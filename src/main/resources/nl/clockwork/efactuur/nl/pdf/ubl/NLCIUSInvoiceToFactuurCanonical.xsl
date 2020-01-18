<?xml version="1.0" encoding="UTF-8"?>
<!--

    Copyright 2011 Clockwork

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.clockwork.nl/ezp/pdf/canonical" xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:in="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"
	xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
	xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
	version="2.0" exclude-result-prefixes="in cbc cac">
	<!--xsl:include href="parties.xsl"/ -->
	<xsl:variable name="date_format" select="'[D01]-[M01]-[Y]'" />
	<xsl:template match="/">
		<bericht>
			<xsl:call-template name="factuur" />
			<xsl:apply-templates select="/in:Invoice/cac:AccountingSupplierParty" />
			<xsl:apply-templates select="/in:Invoice/cac:SellerSupplierParty" /><!-- REMOVE??? -->
			<xsl:apply-templates select="/in:Invoice/cac:BuyerCustomerParty" /><!-- REMOVE??? -->
			<xsl:apply-templates select="/in:Invoice/cac:AccountingCustomerParty" />
		</bericht>
	</xsl:template>
	<xsl:template name="factuur">
		<factuur>
			<xsl:attribute name="currency">
				<xsl:value-of select="/in:Invoice/cbc:DocumentCurrencyCode" />
			</xsl:attribute>
			<factuurtype>
				<xsl:choose>
					<xsl:when test="/in:Invoice/cbc:InvoiceTypeCode">Debet</xsl:when>
					<xsl:otherwise>Credit</xsl:otherwise>
				</xsl:choose>
			</factuurtype>
			<inkooporder>
				<xsl:value-of select="/in:Invoice/cbc:BuyerReference" />
			</inkooporder>
			<datum>
				<xsl:value-of select="/in:Invoice/cbc:IssueDate" />
			</datum>
			<factuurnummer>
				<xsl:value-of select="/in:Invoice/cbc:ID" />
			</factuurnummer>
			<indicatie_kopie>
<!-- 				<xsl:value-of select="/in:Invoice/cbc:CopyIndicator" /> -->
				<xsl:text>/in:Invoice/cbc:CopyIndicator</xsl:text>
			</indicatie_kopie>
			<plaatsingadres>
				<xsl:apply-templates select="/in:Invoice/cac:DeliveryTerms/cac:DeliveryLocation/cac:Address"/><!-- REMOVE??? -->
			</plaatsingadres>
			<omschrijving>
				<xsl:if test="/in:Invoice/cac:OrderReference/cbc:ID!=''">
					<item>
						Referentie: <xsl:value-of select="/in:Invoice/cac:OrderReference/cbc:ID" />
					</item>
				</xsl:if>
			</omschrijving>
			<opmerkingen>
				<xsl:choose>
					<xsl:when test="/in:Invoice/cbc:Note!=''">
						<xsl:value-of select="/in:Invoice/cbc:Note" />
					</xsl:when>
				</xsl:choose>
			</opmerkingen>
			<betalingscondities>
				<xsl:for-each select="/in:Invoice/cac:PaymentTerms">
					<xsl:apply-templates select="." />
				</xsl:for-each>
			</betalingscondities>
			<xsl:call-template name="referentie" />
			<xsl:call-template name="totalen_factuur" />
			<xsl:for-each select="/in:Invoice/cac:InvoiceLine">
				<xsl:apply-templates select="." />
			</xsl:for-each>
		</factuur>
	</xsl:template>
	<xsl:template match="cac:InvoiceLine">
		<factuur_regel>
			<regelnummer>
				<xsl:value-of select="cbc:ID" />
			</regelnummer>
			<aantal>
				<xsl:attribute name="type" />
				<xsl:value-of select="cbc:InvoicedQuantity" />
			</aantal>
			<kostenloos_geleverd>
				<!-- TODO NOT ALLOWED -->
				<xsl:value-of select="cbc:FreeOfChargeIndicator" />
			</kostenloos_geleverd>
			<omschrijving>
				<xsl:choose>
					<xsl:when test="cac:Item/cbc:Description !=''">
						<xsl:value-of select="cac:Item/cbc:Description" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="cac:Item/cbc:Name" />
					</xsl:otherwise>
				</xsl:choose>
			</omschrijving>
			<extra_omschrijving>
				<xsl:if test="cac:Item/cbc:AdditionalInformation != ''">
					<omschrijving_regel>
<!-- 						<xsl:value-of select="cac:Item/cbc:AdditionalInformation"/> -->
						<xsl:text>cac:InvoiceLine/cac:Item/cbc:AdditionalInformation</xsl:text>
					</omschrijving_regel>
				</xsl:if>
				<xsl:for-each select="cac:Item/cac:AdditionalItemProperty">
					<omschrijving_regel>
<!-- 						<xsl:value-of select="cbc:Name"/>: <xsl:value-of select="cbc:Value"/> -->
						<xsl:text>cac:InvoiceLine/cac:Item/cac:AdditionalItemProperty/cbc:Name</xsl:text>
					</omschrijving_regel>				
				</xsl:for-each>	
			</extra_omschrijving>
			<bedrag>
				<prijs>
					<xsl:attribute name="currency">
            			<xsl:value-of select="cac:Price/cbc:PriceAmount/@currencyID" />
          			</xsl:attribute>
					<xsl:value-of select="cac:Price/cbc:PriceAmount" />
				</prijs>
				<btw>
					<percentage>
						<xsl:value-of select="cac:Item/cac:ClassifiedTaxCategory/cbc:Percent"/>
					</percentage>
				</btw>
				<totaal_ex_btw>
					<xsl:attribute name="currency">
		            	<xsl:value-of select="cbc:LineExtensionAmount/@currencyID" />
          			</xsl:attribute>
					<xsl:value-of select="cbc:LineExtensionAmount" />
				</totaal_ex_btw>
				<xsl:for-each select="cac:AllowanceCharge"><!-- REMOVE??? -->
					<xsl:apply-templates select="." />
				</xsl:for-each>
			</bedrag>
		</factuur_regel>
	</xsl:template>
	<xsl:template name="totalen_factuur">
		<totalen_factuur>
			<bedrag_totaal>
				<xsl:attribute name="currency">
          <xsl:value-of
					select="/in:Invoice/cac:LegalMonetaryTotal/cbc:PayableAmount/@currencyID" />
        </xsl:attribute>
				<xsl:value-of select="/in:Invoice/cac:LegalMonetaryTotal/cbc:PayableAmount" />
			</bedrag_totaal>
			<excl_btw_incl_korting>
				<xsl:attribute name="currency">
          <xsl:value-of
					select="/in:Invoice/cac:LegalMonetaryTotal/cbc:TaxExclusiveAmount/@currencyID" />
        </xsl:attribute>
				<xsl:value-of
					select="/in:Invoice/cac:LegalMonetaryTotal/cbc:TaxExclusiveAmount" />
			</excl_btw_incl_korting>
			<!-- TODO NOT ALLOWED -->
			<xsl:for-each select="/in:Invoice/cac:TaxTotal/cac:TaxSubtotal">
				<xsl:apply-templates select="." />
			</xsl:for-each>
		</totalen_factuur>
	</xsl:template>
	<xsl:template name="referentie">
		<referentie>
			<contract>
				<nummer>
<!-- 					<xsl:value-of select="/in:Invoice/cac:ContractDocumentReference/cbc:ID" /> -->
					<xsl:text>/in:Invoice/cac:ContractDocumentReference/cbc:ID</xsl:text>
				</nummer>
			</contract>
			<factuur_oorspronkelijk>
				<datum>
					<xsl:value-of select="/in:Invoice/cac:InvoicePeriod/cbc:StartDate"/>
				</datum>
				<verval_datum>
					<xsl:value-of select="/in:Invoice/cac:InvoicePeriod/cbc:EndDate" />					
				</verval_datum>			
				<factuurnummer_leverancier>
<!-- 					<xsl:value-of	select="/in:Invoice/cac:BillingReference/cac:InvoiceDocumentReference/cbc:ID" /> -->
					<xsl:text>/in:Invoice/cac:BillingReference/cac:InvoiceDocumentReference/cbc:ID</xsl:text>
				</factuurnummer_leverancier>
			</factuur_oorspronkelijk>
		</referentie>
	</xsl:template>
	<xsl:template match="cac:AllowanceCharge">
		<toeslag>
			<bedrag>
				<xsl:attribute name="currency">
          <xsl:value-of select="cbc:Amount/@currencyID" />
        </xsl:attribute>
				<xsl:if test="cbc:ChargeIndicator = 'false'">
					<xsl:text>-</xsl:text>
				</xsl:if>
				<xsl:value-of select="cbc:Amount" />
			</bedrag>
		</toeslag>
	</xsl:template>
	<xsl:template match="cac:TaxSubtotal">
		<btw>
			<bedrag>
				<xsl:attribute name="currency">
     			<xsl:value-of select="cbc:TaxAmount/@currencyID" />
     		</xsl:attribute>
				<xsl:value-of select="cbc:TaxAmount" />
			</bedrag>
			<percentage>
				<xsl:value-of select="cac:TaxCategory/cbc:Percent" />
			</percentage>
		</btw>
	</xsl:template>

	<xsl:template match="cac:PaymentTerms">
		<conditie>
			<kortingspercentage>
<!-- 				<xsl:value-of select="cbc:SettlementDiscountPercent" /> -->
				<xsl:text>cbc:SettlementDiscountPercent</xsl:text>
			</kortingspercentage>
			<omschrijving>
				<xsl:value-of select="cbc:Note" />
			</omschrijving>
			<ubl_looptijd>
				<xsl:attribute name="type">
<!--           <xsl:value-of select="cac:SettlementPeriod/cbc:DurationMeasure/@unitCode" /> -->
          <xsl:text>cac:SettlementPeriod/cbc:DurationMeasure/@unitCode</xsl:text>
        </xsl:attribute>
<!-- 				<xsl:value-of select="cac:SettlementPeriod/cbc:DurationMeasure" /> -->
					<xsl:text>cac:SettlementPeriod/cbc:DurationMeasure</xsl:text>
			</ubl_looptijd>
		</conditie>
	</xsl:template>
	
	<xsl:template match="cac:Contact">
		<contactpersoon>
			<naam><xsl:value-of select="cbc:Name" /></naam>
			<telefoonnummer>
<!-- 				<xsl:value-of select="cbc:Telephone"/> -->
				<xsl:text>cbc:Telephone</xsl:text>
			</telefoonnummer>
			<email><xsl:value-of select="cbc:ElectronicMail"/></email>				
		</contactpersoon>	
	</xsl:template>	
		
	<xsl:template match="cac:AccountingSupplierParty">
		<crediteur>
			<kvk_nummer>
				<xsl:choose>
					<xsl:when test="cac:Party/cac:PartyIdentification/cbc:ID[@schemeAgencyName='KvK']">
						<xsl:value-of select="cac:Party/cac:PartyIdentification/cbc:ID[@schemeAgencyName='KvK']" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="cac:Party/cac:PartyLegalEntity/cbc:CompanyID[@schemeID='0106' or @schemeID='0190']" />
					</xsl:otherwise>
				</xsl:choose>
			</kvk_nummer>
			<btw_nummer>
				<xsl:choose>
					<xsl:when test="cac:Party/cac:PartyIdentification/cbc:ID[@schemeAgencyName='BTW'] != ''">
						<xsl:value-of select="cac:Party/cac:PartyIdentification/cbc:ID[@schemeAgencyName='BTW']" />														
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="cac:Party/cac:PartyTaxScheme/cbc:CompanyID"/>												
					</xsl:otherwise>
				</xsl:choose>
			</btw_nummer>
			
			<!-- <registratienummer> -->
			<!-- 	<xsl:value-of select="cac:Party/cac:PartyIdentification/cbc:ID" /> -->
			<!-- </registratienummer> -->
			
			<bankrekening>
				<nummer>
					<xsl:value-of select="/in:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:ID" />
				</nummer>
				<bic>
<!-- 					<xsl:value-of select="/in:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID" /> -->
					<xsl:text>/in:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID</xsl:text>
				</bic>
			</bankrekening>
			<adres>
				<xsl:apply-templates select="cac:Party/cac:PostalAddress" />
				<xsl:apply-templates select="cac:Party/cac:PhysicalLocation/cac:Address" /><!-- REMOVE??? -->
			</adres>
			<niet_natuurlijk_persoon>
				<naam>
					<xsl:choose>
						<xsl:when test="cac:Party/cac:PartyName/cbc:Name !=''">
							<xsl:value-of select="cac:Party/cac:PartyName/cbc:Name" />
						</xsl:when>
					</xsl:choose> 									
				</naam>
				<xsl:apply-templates select="cac:Party/cac:Contact" />
			</niet_natuurlijk_persoon>
			<xsl:apply-templates select="cac:Party/cac:Person" /><!-- REMOVE??? -->
		</crediteur>
	</xsl:template>

	<xsl:template match="cac:SellerSupplierParty"><!-- REMOVE??? -->
		<leverancier>
			<btw_nummer>
<!-- 				<xsl:value-of select="cac:Party/cac:PartyTaxScheme/cbc:CompanyID" /> -->
				<xsl:text>cac:Party/cac:PartyTaxScheme/cbc:CompanyID</xsl:text>
			</btw_nummer>
			<registratienummer>
<!-- 				<xsl:value-of select="cac:Party/cac:PartyIdentification/cbc:ID" /> -->
				<xsl:text>cac:Party/cac:PartyIdentification/cbc:ID</xsl:text>
			</registratienummer>
			<bankrekening>
				<nummer>
					<xsl:value-of select="/in:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:ID" /><!-- 2nd time -->
				</nummer>
				<bic>
<!-- 					<xsl:value-of select="/in:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID" /> 2nd time -->
					<xsl:text>/in:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID 2nd time</xsl:text>
				</bic>
			</bankrekening>
			<adres>
				<xsl:apply-templates select="cac:Party/cac:PostalAddress" /><!-- REMOVE??? -->
				<xsl:apply-templates select="cac:Party/cac:PhysicalLocation/cac:Address" /><!-- REMOVE??? -->
			</adres>
			<niet_natuurlijk_persoon>
				<naam>
<!-- 					<xsl:value-of select="cac:Party/cac:PartyName/cbc:Name" /> -->
					<xsl:text>cac:Party/cac:PartyName/cbc:Name</xsl:text>
				</naam>
				<xsl:apply-templates select="cac:Party/cac:Contact" /><!-- REMOVE??? -->
			</niet_natuurlijk_persoon>
			<xsl:apply-templates select="cac:Party/cac:Person" /><!-- REMOVE??? -->
		</leverancier>
	</xsl:template>
	<xsl:template match="cac:BuyerCustomerParty"><!-- REMOVE??? -->
		<afnemer>
			<btw_nummer>
<!-- 				<xsl:value-of select="cac:Party/cac:PartyTaxScheme/cbc:CompanyID" /> -->
				<xsl:text>cac:Party/cac:PartyTaxScheme/cbc:CompanyID</xsl:text>
			</btw_nummer>
			<registratienummer>
<!-- 				<xsl:value-of select="cac:Party/cac:PartyIdentification/cbc:ID" /> -->
				<xsl:text>cac:Party/cac:PartyIdentification/cbc:ID</xsl:text>
			</registratienummer>
			<adres>
				<xsl:apply-templates select="cac:Party/cac:PostalAddress" /><!-- REMOVE??? -->
				<xsl:apply-templates select="cac:Party/cac:PhysicalLocation/cac:Address" /><!-- REMOVE??? -->
			</adres>
			<niet_natuurlijk_persoon>
				<naam>
<!-- 					<xsl:value-of select="cac:Party/cac:PartyName/cbc:Name" /> -->
					<xsl:text>cac:Party/cac:PartyName/cbc:Name</xsl:text>
				</naam>
				<departement>
<!-- 					<xsl:value-of select="cac:Party/cac:PostalAddress/cbc:Department" /> -->
					<xsl:text>cac:Party/cac:PostalAddress/cbc:Department</xsl:text>
				</departement>
				<xsl:apply-templates select="cac:Party/cac:Contact" /><!-- REMOVE??? -->		
			</niet_natuurlijk_persoon>
			<xsl:apply-templates select="cac:Party/cac:Person" /><!-- REMOVE??? -->
		</afnemer>
	</xsl:template>
	<xsl:template match="cac:AccountingCustomerParty">
		<debiteur>
			<btw_nummer>
<!-- 				<xsl:value-of select="cac:Party/cac:PartyTaxScheme/cbc:CompanyID" /> -->
				<xsl:text>cac:Party/cac:PartyTaxScheme/cbc:CompanyID</xsl:text>
			</btw_nummer>
			<registratienummer>
				<xsl:value-of select="/in:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID"></xsl:value-of>
			</registratienummer>
			<adres>
				<xsl:apply-templates select="cac:Party/cac:PostalAddress" />
				<xsl:apply-templates select="cac:Party/cac:PhysicalLocation/cac:Address" /><!-- REMOVE??? -->
			</adres>
			<niet_natuurlijk_persoon>
				<naam>
					<xsl:value-of select="cac:Party/cac:PartyName/cbc:Name" />
				</naam>
				<departement>
<!-- 					<xsl:value-of select="cac:Party/cac:PostalAddress/cbc:Department" /> -->
					<xsl:text>cac:Party/cac:PostalAddress/cbc:Department</xsl:text>
				</departement>
				<xsl:apply-templates select="cac:Party/cac:Contact" /><!-- REMOVE??? -->
			</niet_natuurlijk_persoon>
			<xsl:apply-templates select="cac:Party/cac:Person" /><!-- REMOVE??? -->
		</debiteur>
	</xsl:template>
	<xsl:template match="cac:PostalAddress">
		<postadres>
			<postbusnummer>
				<xsl:value-of select="cbc:Postbox" />
			</postbusnummer>
			<straat>
				<xsl:value-of select="cbc:StreetName" />
			</straat>
			<huisnummer>
				<xsl:value-of select="cbc:BuildingNumber" />
			</huisnummer>
			<postcode>
				<xsl:value-of select="cbc:PostalZone" />
			</postcode>
			<woonplaats>
				<xsl:value-of select="cbc:CityName" />
			</woonplaats>
			<regio>
				<xsl:value-of select="cbc:Region" />
			</regio>
			<landcode>
				<xsl:value-of select="cac:Country/cbc:IdentificationCode" />
			</landcode>
		</postadres>
	</xsl:template>
	<xsl:template match="cac:Address"><!-- REMOVE??? -->
		<adres>
			<postbusnummer>
<!-- 				<xsl:value-of select="cbc:Postbox" /> -->
				<xsl:text>cbc:Postbox</xsl:text>
			</postbusnummer>
			<straat>
<!-- 				<xsl:value-of select="cbc:StreetName" /> -->
				<xsl:text>cbc:StreetName</xsl:text>
			</straat>
			<huisnummer>
<!-- 				<xsl:value-of select="cbc:BuildingNumber" /> -->
				<xsl:text>cbc:BuildingNumber</xsl:text>
			</huisnummer>
			<postcode>
<!-- 				<xsl:value-of select="cbc:PostalZone" /> -->
				<xsl:text>cbc:PostalZone</xsl:text>
			</postcode>
			<woonplaats>
<!-- 				<xsl:value-of select="cbc:CityName" /> -->
				<xsl:text>cbc:CityName</xsl:text>
			</woonplaats>
			<regio>
<!-- 				<xsl:value-of select="cbc:Region" /> -->
				<xsl:text>cbc:Region</xsl:text>
			</regio>
			<landcode>
<!-- 				<xsl:value-of select="cac:Country/cbc:IdentificationCode" /> -->
				<xsl:text>cac:Country/cbc:IdentificationCode</xsl:text>
			</landcode>
		</adres>
	</xsl:template>
	<xsl:template match="cac:Person"><!-- REMOVE??? -->
		<natuurlijk_persoon>
			<voorletters>
<!-- 				<xsl:value-of select="cbc:NameSuffix" /> -->
				<xsl:text>cbc:NameSuffix</xsl:text>
			</voorletters>
			<voornamen>
<!-- 				<xsl:value-of select="cbc:FirstName" /> -->
				<xsl:text>cbc:FirstName</xsl:text>
			</voornamen>
			<voorvoegsel>
<!-- 				<xsl:value-of select="cbc:MiddleName" /> -->
				<xsl:text>cbc:MiddleName</xsl:text>
			</voorvoegsel>
			<achternaam>
<!-- 				<xsl:value-of select="cbc:FamilyName" /> -->
				<xsl:text>cbc:FamilyName</xsl:text>
			</achternaam>
		</natuurlijk_persoon>
	</xsl:template>
</xsl:stylesheet>
