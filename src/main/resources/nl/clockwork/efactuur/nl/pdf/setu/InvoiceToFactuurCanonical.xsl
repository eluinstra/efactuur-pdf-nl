<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.clockwork.nl/ezp/pdf/canonical" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:in="http://www.openapplications.org/oagis" xmlns:nl="http://ns.hr-xml.org/2007-04-15" version="2.0" exclude-result-prefixes="in nl">
  <!--xsl:include href="parties.xsl"/-->
  <xsl:variable name="date_format" select="'[D01]-[M01]-[Y]'"/>
  <xsl:template match="/">
    <bericht>
      <xsl:call-template name="factuur"/>
      <xsl:apply-templates select="/in:Invoice/in:Header/in:Parties/in:BillToParty"/>
      <xsl:apply-templates select="/in:Invoice/in:Header/in:Parties/in:SupplierParty"/>
      <xsl:apply-templates select="/in:Invoice/in:Header/in:Parties/in:CustomerParty"/>
      <xsl:apply-templates select="/in:Invoice/in:Header/in:Parties/in:RemitToParty"/>
      <xsl:call-template name="timecards"/>
    </bericht>
  </xsl:template>
  <xsl:template name="factuur">
    <factuur>
      <xsl:for-each select="//@currency"><!-- FIX ME! eerste attribuut uit een lijst halen zonder for-each loop-->
        <xsl:if test="position() = 1">
          <xsl:attribute name="currency">
            <xsl:value-of select="."/>
          </xsl:attribute>
        </xsl:if>
      </xsl:for-each>
      <inkooporder>
      	<xsl:for-each select="//in:Line/in:UserArea/nl:StaffingAdditionalData/nl:CustomerReportingRequirements/nl:PurchaseOrderNumber">
      		<xsl:if test="position() = 1">
          		<xsl:value-of select="."/>          
        	</xsl:if>
      	</xsl:for-each>      
<!--         <xsl:value-of select="//in:Line/in:UserArea/nl:StaffingAdditionalData/nl:CustomerReportingRequirements/nl:PurchaseOrderNumber"/> -->
      </inkooporder>
      <datum>
        <xsl:value-of select="/in:Invoice/in:Header/in:DocumentDateTime"/>
      </datum>
      <factuurnummer>
        <xsl:value-of select="/in:Invoice/in:Header/in:DocumentIds/in:DocumentId/in:Id"/>
      </factuurnummer>
      <indicatie_kopie/>
      <omschrijving>
        <xsl:for-each select="//nl:ProjectCode"><!-- FIX ME! eerste element uit een lijst halen zonder for-each loop-->
          <xsl:if test="position() = 1">
            <item>
              <xsl:text>Project code: </xsl:text>
              <xsl:value-of select="."/>
            </item>
          </xsl:if>
        </xsl:for-each>
        <xsl:for-each select="//nl:LegalName"> <!-- FIX ME! eerste element uit een lijst halen zonder for-each loop-->
          <xsl:if test="position() = 1">
            <item>
              <xsl:text>Naam: </xsl:text>
              <xsl:value-of select="."/>
            </item>
          </xsl:if>
        </xsl:for-each>
      </omschrijving>
      <betalingscondities>
        <xsl:for-each select="/in:Invoice/in:Header/in:PaymentTerms">
          <xsl:apply-templates select="."/>
        </xsl:for-each>
      </betalingscondities>
      <xsl:call-template name="referentie"/>
      <xsl:call-template name="totalen_factuur"/>
      <xsl:for-each select="in:Invoice/in:Line">
        <xsl:call-template name="factuur_regel"/>
      </xsl:for-each>
    </factuur>
  </xsl:template>
  <xsl:template name="factuur_regel">
    <xsl:for-each select="in:Line">
      <xsl:call-template name="factuur_regel">
			</xsl:call-template>
    </xsl:for-each>
    <xsl:if test="not(in:Line)">
      <xsl:apply-templates select="." mode="normal"/>
    </xsl:if>
  </xsl:template>
  <xsl:template name="factuur_regel_bedrag">
    <bedrag>
      <prijs>
        <xsl:attribute name="currency">
          <xsl:value-of select="in:Price/in:Amount/@currency"/>
        </xsl:attribute>
        <xsl:value-of select="normalize-space(in:Price/in:Amount)"/>
      </prijs>
      <xsl:for-each select="in:Tax">
        <xsl:call-template name="btw"/>
      </xsl:for-each>
      <toeslag>
        <bedrag currency=""/>
      </toeslag>
      <totaal_ex_btw>
        <xsl:attribute name="currency">
          <xsl:value-of select="in:Charges/in:TotalCharge/in:Total/@currency"/>
        </xsl:attribute>
        <xsl:value-of select="normalize-space(in:Charges/in:TotalCharge/in:Total)"/>
      </totaal_ex_btw>
    </bedrag>
  </xsl:template>
  <xsl:template name="referentie">
    <referentie>
      <contract>
        <nummer>
          <xsl:value-of select="/in:Invoice/in:Header/in:DocumentReferences/in:InvoiceDocumentReference/in:DocumentIds/in:DocumentId/in:Id"/>
        </nummer>
      </contract>
      <factuur_oorspronkelijk>
        <datum/>
        <factuurnummer_leverancier/>
      </factuur_oorspronkelijk>
    </referentie>
  </xsl:template>
  <xsl:template name="totalen_factuur">
    <totalen_factuur>
      <bedrag_totaal>
        <xsl:attribute name="currency">
          <xsl:value-of select="/in:Invoice/in:Header/in:TotalAmount/@currency"/>
        </xsl:attribute>
        <xsl:value-of select="normalize-space(/in:Invoice/in:Header/in:TotalAmount)"/>
      </bedrag_totaal>
      <excl_btw_incl_korting>
        <xsl:attribute name="currency">
          <xsl:value-of select="/in:Invoice/in:Header/in:TotalCharges/@currency"/>
        </xsl:attribute>
        <xsl:value-of select="normalize-space(/in:Invoice/in:Header/in:TotalCharges)"/>
      </excl_btw_incl_korting>
      <xsl:for-each select="/in:Invoice/in:Header/in:Tax">
        <xsl:call-template name="btw"/>
      </xsl:for-each>
    </totalen_factuur>
  </xsl:template>
  <xsl:template name="btw">
    <btw>
      <bedrag>
        <xsl:attribute name="currency">
          <xsl:value-of select="in:TaxAmount/@currency"/>
        </xsl:attribute>
        <xsl:value-of select="normalize-space(in:TaxAmount)"/>
      </bedrag>
      <percentage>
        <xsl:value-of select="in:PercentQuantity"/>
      </percentage>
    </btw>
  </xsl:template>
  <xsl:template match="in:Line" mode="timecard">
    <xsl:choose>
      <xsl:when test="in:UserArea/nl:TimeCard">
        <xsl:attribute name="bijlage">
          <xsl:value-of select="in:LineNumber"/>
        </xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
      	<xsl:apply-templates select="parent::node()" mode="timecard"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="in:Line" mode="normal">
    <factuur_regel>
      <xsl:choose>
        <xsl:when test="in:UserArea/nl:TimeCard">
        	<xsl:attribute name="bijlage">
        		<xsl:value-of select="in:LineNumber"/>
        	</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="parent::node()" mode="timecard"/>
        </xsl:otherwise>
      </xsl:choose>
      <regelnummer>
        <xsl:value-of select="in:LineNumber"/>
      </regelnummer>
      <aantal>
        <xsl:attribute name="type">
          <xsl:value-of select="in:ItemQuantity/@uom"/>
        </xsl:attribute>
        <xsl:value-of select="in:ItemQuantity"/>
      </aantal>
      <kostenloos_geleverd/>
      <omschrijving>
        <xsl:if test="in:UserArea/nl:StaffingAdditionalData/nl:CustomerReportingRequirements/nl:AdditionalRequirement[@requirementTitle='werkweeknummer']">
          <xsl:text>Weeknummer: </xsl:text>
          <xsl:value-of select="in:UserArea/nl:StaffingAdditionalData/nl:CustomerReportingRequirements/nl:AdditionalRequirement[@requirementTitle='werkweeknummer']"/>
        </xsl:if>
        <xsl:if test="in:Charges/in:Charge/in:Description">
          <xsl:value-of select="in:Charges/in:Charge/in:Description"/>
        </xsl:if>
      </omschrijving>
      <xsl:call-template name="factuur_regel_bedrag"/>
    </factuur_regel>
  </xsl:template>
  <xsl:template match="in:PaymentTerms">
    <conditie>
      <kortingspercentage>
        <xsl:value-of select="in:DiscountPercent"/>
      </kortingspercentage>
      <omschrijving>
        <xsl:value-of select="in:Description"/>
      </omschrijving>
      <setu_aantal_dagen>
        <xsl:value-of select="in:NumberOfDays"/>
      </setu_aantal_dagen>
      <setu_start_datum>
        <xsl:value-of select="in:PaymentTermsDate"/>
      </setu_start_datum>
      <setu_verval_datum>
        <xsl:value-of select="in:DueDate"/>
      </setu_verval_datum>
    </conditie>
  </xsl:template>
  <xsl:template name="timecards">
    <bijlages>
      <xsl:for-each select="//in:Line">
        <xsl:if test="in:UserArea/nl:TimeCard">
          <bijlage>
            <xsl:attribute name="id">
              <xsl:value-of select="in:LineNumber"/>
            </xsl:attribute>
            <xsl:copy-of select="in:UserArea/nl:TimeCard"/>
          </bijlage>
        </xsl:if>
      </xsl:for-each>
    </bijlages>
  </xsl:template>
  <!-- catch all template to prevent infinite loop in timecard references -->
  <xsl:template match="*" mode="timecard"/>



 <xsl:template match="in:RemitToParty">
    <crediteur>
      <btw_nummer><xsl:value-of select="in:TaxId"/></btw_nummer>
      <kvk_nummer>
        <xsl:value-of select="/in:Invoice/in:Header/in:UserArea/nl:StaffingOrganizationNL/nl:ChamberofCommerceReference"/>
      </kvk_nummer>
<!--       <registratienummer> -->
<!--         <xsl:value-of select="in:PartyId/in:Id"/> -->
<!--       </registratienummer> -->
      <bankrekening>
        <nummer>
          <xsl:value-of select="/in:Invoice/in:Header/in:UserArea/nl:StaffingOrganization/nl:PaymentInfo/nl:BankAccountInfo/nl:BankInfoByJurisdiction/nl:BankAccountNumber"/>
        </nummer>
        <bic>
          <xsl:value-of select="/in:Invoice/in:Header/in:UserArea/nl:StaffingOrganization/nl:PaymentInfo/nl:BankAccountInfo/nl:BankInfoByJurisdiction/nl:BankCode"/>
        </bic>
      </bankrekening>
      <adres>
        <xsl:choose>
          <xsl:when test="in:Addresses/in:PrimaryAddress">
            <xsl:apply-templates select="in:Addresses/in:PrimaryAddress"/>
          </xsl:when>
          <xsl:otherwise>
             <xsl:apply-templates select="in:Contacts/in:Contact/in:Addresses/in:PrimaryAddress"/>
          </xsl:otherwise>
        </xsl:choose>
      </adres>
      <niet_natuurlijk_persoon>
        <naam>
          <xsl:value-of select="in:Name"/>
        </naam>
      </niet_natuurlijk_persoon>
      <xsl:apply-templates select="in:Contacts/in:Contact"/>
    </crediteur>
  </xsl:template>
  <xsl:template match="in:SupplierParty">
    <leverancier>
     <btw_nummer><xsl:value-of select="in:TaxId"/></btw_nummer>
      <registratienummer>
        <xsl:value-of select="in:PartyId/in:Id"/>
      </registratienummer>
      <adres>
        <xsl:choose>
          <xsl:when test="in:Addresses/in:PrimaryAddress">
            <xsl:apply-templates select="in:Addresses/in:PrimaryAddress"/>
          </xsl:when>
          <xsl:otherwise>
          <blerk/>
             <xsl:apply-templates select="in:Contacts/in:Contact/in:Addresses/in:PrimaryAddress"/>
          </xsl:otherwise>
        </xsl:choose>
      </adres>
      <niet_natuurlijk_persoon>
        <naam>
          <xsl:value-of select="in:Name"/>
        </naam>
      </niet_natuurlijk_persoon>
      <xsl:apply-templates select="in:Contacts/in:Contact"/>
    </leverancier>
  </xsl:template>
  <xsl:template match="in:BillToParty">
    <debiteur>
      <btw_nummer><xsl:value-of select="in:TaxId"/></btw_nummer>
      <registratienummer>
        <xsl:value-of select="in:PartyId/in:Id"/>
      </registratienummer>
    <adres>
        <xsl:choose>
          <xsl:when test="in:Addresses/in:PrimaryAddress">
            <xsl:apply-templates select="in:Addresses/in:PrimaryAddress"/>
          </xsl:when>
          <xsl:otherwise>
             <xsl:apply-templates select="in:Contacts/in:Contact/in:Addresses/in:PrimaryAddress"/>
          </xsl:otherwise>
        </xsl:choose>
      </adres>
      <niet_natuurlijk_persoon>
        <naam>
          <xsl:value-of select="in:Name"/>
        </naam>
      </niet_natuurlijk_persoon>
      <xsl:apply-templates select="in:Contacts/in:Contact"/>
    </debiteur>
  </xsl:template>
   <xsl:template match="in:CustomerParty">
    <afnemer>
      <btw_nummer><xsl:value-of select="in:TaxId"/></btw_nummer>
      <registratienummer>
        <xsl:value-of select="in:PartyId/in:Id"/>
      </registratienummer>      
      <adres>
        <xsl:choose>
          <xsl:when test="in:Addresses/in:PrimaryAddress">
            <xsl:apply-templates select="in:Addresses/in:PrimaryAddress"/>
          </xsl:when>
          <xsl:otherwise>
             <xsl:apply-templates select="in:Contacts/in:Contact/in:Addresses/in:PrimaryAddress"/>
          </xsl:otherwise>
        </xsl:choose>
      </adres>
      <niet_natuurlijk_persoon>
        <naam>
          <xsl:value-of select="in:Name"/>
        </naam>
      </niet_natuurlijk_persoon>
      <xsl:apply-templates select="in:Contacts/in:Contact"/>
    </afnemer>
  </xsl:template>
  <xsl:template match="in:PrimaryAddress">
    <adres>
      <xsl:for-each select="in:AddressLine">
        <adresregel>
          <xsl:value-of select="."/>
        </adresregel>
      </xsl:for-each>
      <postcode>
        <xsl:value-of select="in:PostalCode"/>
      </postcode>
      <woonplaats>
        <xsl:value-of select="in:City"/>
      </woonplaats>
    </adres>
  </xsl:template>
  <xsl:template match="in:Contact">
    <natuurlijk_persoon>
      <voornaam>
        <xsl:value-of select="in:PersonName/in:GivenName"/>
      </voornaam>
      <achternaam>
        <xsl:value-of select="in:PersonName/in:FamilyName"/>
      </achternaam>
    </natuurlijk_persoon>
  </xsl:template>  
</xsl:stylesheet>
