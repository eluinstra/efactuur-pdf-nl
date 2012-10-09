<?xml version="1.0" encoding="UTF-8"?>
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
			<xsl:apply-templates select="/in:Invoice/cac:SellerSupplierParty" />
			<xsl:apply-templates select="/in:Invoice/cac:BuyerCustomerParty" />
			<xsl:apply-templates select="/in:Invoice/cac:AccountingCustomerParty" />
		</bericht>
	</xsl:template>
	<xsl:template name="factuur">
		<factuur>
			<xsl:for-each select="//@currencyID">
				<xsl:if test="position() = 1">
					<xsl:attribute name="currency">
            <xsl:value-of select="." />
          </xsl:attribute>
				</xsl:if>
			</xsl:for-each>
			<factuurtype>
				<xsl:choose>
					<xsl:when test="/in:Invoice/cbc:InvoiceTypeCode = 'C'">
						Credit
					</xsl:when>
					<xsl:otherwise>
						Debet
					</xsl:otherwise>
				</xsl:choose>
			</factuurtype>
			<inkooporder>
				<xsl:value-of select="/in:Invoice/cac:OrderReference/cbc:ID" />
			</inkooporder>
			<datum>
				<xsl:value-of select="/in:Invoice/cbc:IssueDate" />
			</datum>
			<factuurnummer>
				<xsl:value-of select="in:Invoice/cbc:ID" />
			</factuurnummer>
			<indicatie_kopie>
				<xsl:value-of select="in:Invoice/cbc:CopyIndicator" />
			</indicatie_kopie>
			<omschrijving>
				<xsl:if test="in:Invoice/cac:OrderReference/cbc:CustomerReference!=''">
					<item>
						Referentie:
						<xsl:value-of
							select="in:Invoice/cac:OrderReference/cbc:CustomerReference" />
					</item>
				</xsl:if>
				<xsl:if test="in:Invoice/cbc:AccountingCostCode!=''">
					<item>
						Boeksleutel:
						<xsl:value-of select="in:Invoice/cbc:AccountingCostCode" />
					</item>
				</xsl:if>
				<xsl:if test="in:Invoice/cac:OrderReference/cbc:SalesOrderID!=''">
					<item>
						Verkoopordernummer:
						<xsl:value-of select="in:Invoice/cac:OrderReference/cbc:SalesOrderID" />
					</item>
				</xsl:if>			
			</omschrijving>
			<opmerkingen>
				<xsl:choose>
					<xsl:when test="in:Invoice/cbc:Note!=''">
						<xsl:value-of select="in:Invoice/cbc:Note" />
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
				Ref:
				<xsl:value-of select="cac:OrderLineReference/cac:OrderReference/cbc:ID" />
			</omschrijving>
			<bedrag>
				<prijs>
					<xsl:attribute name="currency">
            			<xsl:value-of select="cac:Price/cbc:PriceAmount/@currencyID" />
          			</xsl:attribute>
					<xsl:value-of select="cac:Price/cbc:PriceAmount" />
				</prijs>
				<totaal_ex_btw>
					<xsl:attribute name="currency">
		            	<xsl:value-of select="cbc:LineExtensionAmount/@currencyID" />
          			</xsl:attribute>
					<xsl:value-of select="cbc:LineExtensionAmount" />
				</totaal_ex_btw>
				<xsl:for-each select="cac:TaxTotal/cac:TaxSubtotal">
					<xsl:apply-templates select="." />
				</xsl:for-each>
				<xsl:for-each select="cac:AllowanceCharge">
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
			<xsl:for-each select="/in:Invoice/cac:TaxTotal/cac:TaxSubtotal">
				<xsl:apply-templates select="." />
			</xsl:for-each>
		</totalen_factuur>
	</xsl:template>
	<xsl:template name="referentie">
		<referentie>
			<contract>
				<nummer>
					<xsl:value-of select="/in:Invoice/cac:ContractDocumentReference/cbc:ID" />
				</nummer>
			</contract>
			<factuur_oorspronkelijk>
				<datum>
					<xsl:choose>
						<xsl:when test="/in:Invoice/cac:BillingReference/cac:InvoiceDocumentReference/cbc:IssueDate != ''" >
							<xsl:value-of select="/in:Invoice/cac:BillingReference/cac:InvoiceDocumentReference/cbc:IssueDate"/>							
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="/in:Invoice/cac:InvoicePeriod/cbc:StartDate"/>
						</xsl:otherwise>
					</xsl:choose>
				</datum>
				<verval_datum>
					<xsl:value-of
						select="/in:Invoice/cac:InvoicePeriod/cbc:EndDate" />					
				</verval_datum>			
				<factuurnummer_leverancier>
					<xsl:value-of
						select="/in:Invoice/cac:BillingReference/cac:InvoiceDocumentReference/cbc:ID" />
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
				<xsl:choose>
					<xsl:when test="cbc:Percent != ''">
						<xsl:value-of select="cbc:Percent" />	
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="cac:TaxCategory/cbc:Percent" />
					</xsl:otherwise>									
				</xsl:choose>				
			</percentage>
		</btw>
	</xsl:template>

	<xsl:template match="cac:PaymentTerms">
		<conditie>
			<kortingspercentage>
				<xsl:value-of select="cbc:SettlementDiscountPercent" />
			</kortingspercentage>
			<omschrijving>
				<xsl:value-of select="cbc:Note" />
			</omschrijving>
			<ubl_looptijd>
				<xsl:attribute name="type">
          			<xsl:value-of select="cac:SettlementPeriod/cbc:DurationMeasure/@unitCode" />
        		</xsl:attribute>
				<xsl:value-of select="cac:SettlementPeriod/cbc:DurationMeasure" />
			</ubl_looptijd>
		</conditie>
	</xsl:template>
	
	<xsl:template match="cac:Contact">
		<contactpersoon>
			<naam><xsl:value-of select="cbc:Name" /></naam>
<!-- 			<functie><xsl:value-of select="cbc:ID" /></functie> -->
			<telefoonnummer><xsl:value-of select="cbc:Telephone"/></telefoonnummer>
<!-- 			<telefax><xsl:value-of select="cbc:Telefax"/></telefax> -->
			<email><xsl:value-of select="cbc:ElectronicMail"/></email>				
		</contactpersoon>	
	</xsl:template>	
		
	<xsl:template match="cac:AccountingSupplierParty">
		<crediteur>
			<kvk_nummer>
				<xsl:value-of
					select="cac:Party/cac:PartyIdentification/cbc:ID[@schemeAgencyName='KvK']" />
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
					<xsl:value-of
						select="/in:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:ID" />
				</nummer>
				<bic>
					<xsl:value-of
						select="/in:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID" />
				</bic>
			</bankrekening>
			<adres>
				<xsl:apply-templates select="cac:Party/cac:PostalAddress" />
				<xsl:apply-templates select="cac:Party/cac:PhysicalLocation/cac:Address" />
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
			<xsl:apply-templates select="cac:Party/cac:Person" />
		</crediteur>
	</xsl:template>

	<xsl:template match="cac:SellerSupplierParty">
		<leverancier>
			<btw_nummer>
				<xsl:value-of select="cac:Party/cac:PartyTaxScheme/cbc:CompanyID" />
			</btw_nummer>
			<registratienummer>
				<xsl:value-of select="cac:Party/cac:PartyIdentification/cbc:ID" />
			</registratienummer>
			<bankrekening>
				<nummer>
					<xsl:value-of
						select="/in:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:ID" />
				</nummer>
				<bic>
					<xsl:value-of
						select="/in:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID" />
				</bic>
			</bankrekening>
			<adres>
				<xsl:apply-templates select="cac:Party/cac:PostalAddress" />
				<xsl:apply-templates select="cac:Party/cac:PhysicalLocation/cac:Address" />
			</adres>
			<niet_natuurlijk_persoon>
				<naam>
					<xsl:value-of select="cac:Party/cac:PartyName/cbc:Name" />
				</naam>
				<xsl:apply-templates select="cac:Party/cac:Contact" />				
			</niet_natuurlijk_persoon>
			<xsl:apply-templates select="cac:Party/cac:Person" />
		</leverancier>
	</xsl:template>
	<xsl:template match="cac:BuyerCustomerParty">
		<afnemer>
			<btw_nummer>
				<xsl:value-of select="cac:Party/cac:PartyTaxScheme/cbc:CompanyID" />
			</btw_nummer>
			<registratienummer>
				<xsl:value-of select="cac:Party/cac:PartyIdentification/cbc:ID" />
			</registratienummer>
			<adres>
				<xsl:apply-templates select="cac:Party/cac:PostalAddress" />
				<xsl:apply-templates select="cac:Party/cac:PhysicalLocation/cac:Address" />
			</adres>
			<niet_natuurlijk_persoon>
				<naam>
					<xsl:value-of select="cac:Party/cac:PartyName/cbc:Name" />
				</naam>
				<departement>
					<xsl:value-of select="cac:Party/cac:PostalAddress/cbc:Department" />
				</departement>
				<xsl:apply-templates select="cac:Party/cac:Contact" />				
			</niet_natuurlijk_persoon>
			<xsl:apply-templates select="cac:Party/cac:Person" />
		</afnemer>
	</xsl:template>
	<xsl:template match="cac:AccountingCustomerParty">
		<debiteur>
			<btw_nummer>
				<xsl:value-of select="cac:Party/cac:PartyTaxScheme/cbc:CompanyID" />
			</btw_nummer>
			<registratienummer>
				<xsl:choose>
					<xsl:when
						test="/in:Invoice/cac:AccountingCustomerParty/cbc:SupplierAssignedAccountID!=''">
						<xsl:value-of
							select="/in:Invoice/cac:AccountingCustomerParty/cbc:SupplierAssignedAccountID" />
					</xsl:when>
					<xsl:when
						test="/in:Invoice/cac:BuyerCustomerParty/cbc:SupplierAssignedAccountID!=''">
						<xsl:value-of
							select="/in:Invoice/cac:BuyerCustomerParty/cbc:SupplierAssignedAccountID" />
					</xsl:when>
					<xsl:when
						test="/in:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID!=''">
						<xsl:if
							test="/in:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID/@schemeAgencyID = 'XXX'">
							<xsl:value-of
								select="/in:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID"></xsl:value-of>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise></xsl:otherwise>
				</xsl:choose>
			</registratienummer>
			<adres>
				<xsl:apply-templates select="cac:Party/cac:PostalAddress" />
				<xsl:apply-templates select="cac:Party/cac:PhysicalLocation/cac:Address" />
			</adres>
			<niet_natuurlijk_persoon>
				<naam>
					<xsl:value-of select="cac:Party/cac:PartyName/cbc:Name" />
				</naam>
				<departement>
					<xsl:value-of select="cac:Party/cac:PostalAddress/cbc:Department" />
				</departement>
				<xsl:apply-templates select="cac:Party/cac:Contact" />
			</niet_natuurlijk_persoon>
			<xsl:apply-templates select="cac:Party/cac:Person" />
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
	<xsl:template match="cac:Address">
		<adres>
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
		</adres>
	</xsl:template>
	<xsl:template match="cac:Person">
		<natuurlijk_persoon>
			<voorletters>
				<xsl:value-of select="cbc:NameSuffix" />
			</voorletters>
			<voornamen>
				<xsl:value-of select="cbc:FirstName" />
			</voornamen>
			<voorvoegsel>
				<xsl:value-of select="cbc:MiddleName" />
			</voorvoegsel>
			<achternaam>
				<xsl:value-of select="cbc:FamilyName" />
			</achternaam>
		</natuurlijk_persoon>
	</xsl:template>
</xsl:stylesheet>
