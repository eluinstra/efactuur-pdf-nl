<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:schold="http://www.ascc.net/xml/schematron"
                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
                xmlns:doc="urn:oasis:names:specification:ubl:schema:xsd:OrderResponse-2"
                xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
                version="2.0"><!--Implementers: please note that overriding process-prolog or process-root is 
    the preferred method for meta-stylesheets to use where possible. -->
<xsl:param name="archiveDirParameter"/>
   <xsl:param name="archiveNameParameter"/>
   <xsl:param name="fileNameParameter"/>
   <xsl:param name="fileDirParameter"/>
   <xsl:variable name="document-uri">
      <xsl:value-of select="document-uri(/)"/>
   </xsl:variable>

   <!--PHASES-->


<!--PROLOG-->


<!--XSD TYPES FOR XSLT2-->


<!--KEYS AND FUNCTIONS-->


<!--DEFAULT RULES-->


<!--MODE: SCHEMATRON-SELECT-FULL-PATH-->
<!--This mode can be used to generate an ugly though full XPath for locators-->
<xsl:template match="*" mode="schematron-select-full-path">
      <xsl:apply-templates select="." mode="schematron-get-full-path"/>
   </xsl:template>

   <!--MODE: SCHEMATRON-FULL-PATH-->
<!--This mode can be used to generate an ugly though full XPath for locators-->
<xsl:template match="*" mode="schematron-get-full-path">
      <xsl:apply-templates select="parent::*" mode="schematron-get-full-path"/>
      <xsl:text>/</xsl:text>
      <xsl:choose>
         <xsl:when test="namespace-uri()=''">
            <xsl:value-of select="name()"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>*:</xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text>[namespace-uri()='</xsl:text>
            <xsl:value-of select="namespace-uri()"/>
            <xsl:text>']</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:variable name="preceding"
                    select="count(preceding-sibling::*[local-name()=local-name(current())                                   and namespace-uri() = namespace-uri(current())])"/>
      <xsl:text>[</xsl:text>
      <xsl:value-of select="1+ $preceding"/>
      <xsl:text>]</xsl:text>
   </xsl:template>
   <xsl:template match="@*" mode="schematron-get-full-path">
      <xsl:apply-templates select="parent::*" mode="schematron-get-full-path"/>
      <xsl:text>/</xsl:text>
      <xsl:choose>
         <xsl:when test="namespace-uri()=''">@<xsl:value-of select="name()"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>@*[local-name()='</xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text>' and namespace-uri()='</xsl:text>
            <xsl:value-of select="namespace-uri()"/>
            <xsl:text>']</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <!--MODE: SCHEMATRON-FULL-PATH-2-->
<!--This mode can be used to generate prefixed XPath for humans-->
<xsl:template match="node() | @*" mode="schematron-get-full-path-2">
      <xsl:for-each select="ancestor-or-self::*">
         <xsl:text>/</xsl:text>
         <xsl:value-of select="name(.)"/>
         <xsl:if test="preceding-sibling::*[name(.)=name(current())]">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/>
            <xsl:text>]</xsl:text>
         </xsl:if>
      </xsl:for-each>
      <xsl:if test="not(self::*)">
         <xsl:text/>/@<xsl:value-of select="name(.)"/>
      </xsl:if>
   </xsl:template>
   <!--MODE: SCHEMATRON-FULL-PATH-3-->
<!--This mode can be used to generate prefixed XPath for humans 
	(Top-level element has index)-->
<xsl:template match="node() | @*" mode="schematron-get-full-path-3">
      <xsl:for-each select="ancestor-or-self::*">
         <xsl:text>/</xsl:text>
         <xsl:value-of select="name(.)"/>
         <xsl:if test="parent::*">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/>
            <xsl:text>]</xsl:text>
         </xsl:if>
      </xsl:for-each>
      <xsl:if test="not(self::*)">
         <xsl:text/>/@<xsl:value-of select="name(.)"/>
      </xsl:if>
   </xsl:template>

   <!--MODE: GENERATE-ID-FROM-PATH -->
<xsl:template match="/" mode="generate-id-from-path"/>
   <xsl:template match="text()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.text-', 1+count(preceding-sibling::text()), '-')"/>
   </xsl:template>
   <xsl:template match="comment()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.comment-', 1+count(preceding-sibling::comment()), '-')"/>
   </xsl:template>
   <xsl:template match="processing-instruction()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.processing-instruction-', 1+count(preceding-sibling::processing-instruction()), '-')"/>
   </xsl:template>
   <xsl:template match="@*" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.@', name())"/>
   </xsl:template>
   <xsl:template match="*" mode="generate-id-from-path" priority="-0.5">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:text>.</xsl:text>
      <xsl:value-of select="concat('.',name(),'-',1+count(preceding-sibling::*[name()=name(current())]),'-')"/>
   </xsl:template>

   <!--MODE: GENERATE-ID-2 -->
<xsl:template match="/" mode="generate-id-2">U</xsl:template>
   <xsl:template match="*" mode="generate-id-2" priority="2">
      <xsl:text>U</xsl:text>
      <xsl:number level="multiple" count="*"/>
   </xsl:template>
   <xsl:template match="node()" mode="generate-id-2">
      <xsl:text>U.</xsl:text>
      <xsl:number level="multiple" count="*"/>
      <xsl:text>n</xsl:text>
      <xsl:number count="node()"/>
   </xsl:template>
   <xsl:template match="@*" mode="generate-id-2">
      <xsl:text>U.</xsl:text>
      <xsl:number level="multiple" count="*"/>
      <xsl:text>_</xsl:text>
      <xsl:value-of select="string-length(local-name(.))"/>
      <xsl:text>_</xsl:text>
      <xsl:value-of select="translate(name(),':','.')"/>
   </xsl:template>
   <!--Strip characters--><xsl:template match="text()" priority="-1"/>

   <!--SCHEMA SETUP-->
<xsl:template match="/">
      <xsl:apply-templates select="/" mode="M4"/>
      <xsl:apply-templates select="/" mode="M5"/>
   </xsl:template>

   <!--SCHEMATRON PATTERNS-->


<!--PATTERN cardinality-redefines-->


	<!--RULE -->
<xsl:template match="doc:OrderResponse" priority="1068" mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Contract) &lt;= 1"/>
         <xsl:otherwise>doc:OrderResponse may contain cac:Contract at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Delivery) &lt;= 1"/>
         <xsl:otherwise>doc:OrderResponse may contain cac:Delivery at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:OrderReference) &lt;= 1"/>
         <xsl:otherwise>doc:OrderResponse may contain cac:OrderReference at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:TaxTotal) &lt;= 1"/>
         <xsl:otherwise>doc:OrderResponse may contain cac:TaxTotal at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:CustomizationID) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse must contain cbc:CustomizationID at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:Note) &lt;= 1"/>
         <xsl:otherwise>doc:OrderResponse may contain cbc:Note at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:ProfileID) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse must contain cbc:ProfileID at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:UBLVersionID) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse must contain cbc:UBLVersionID at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:AccountingCustomerParty" priority="1067" mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Party) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:AccountingCustomerParty must contain cac:Party at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:AccountingCustomerParty/cac:Party" priority="1066"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyIdentification) &gt;= 1 and count(cac:PartyIdentification) &lt;= 3"/>
         <xsl:otherwise>doc:OrderResponse/cac:AccountingCustomerParty/cac:Party must contain cac:PartyIdentification at least 1 and at most 3 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyName) &gt;= 1 and count(cac:PartyName) &lt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:AccountingCustomerParty/cac:Party must contain cac:PartyName at least 1 and at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification/cbc:ID"
                 priority="1065"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeAgencyName) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID"
                 priority="1064"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeAgencyName) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress"
                 priority="1063"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Country) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress must contain cac:Country at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country"
                 priority="1062"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:IdentificationCode) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:BuyerCustomerParty" priority="1061" mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Party) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:BuyerCustomerParty must contain cac:Party at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:BuyerCustomerParty/cac:Party" priority="1060"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Contact) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:BuyerCustomerParty/cac:Party must contain cac:Contact at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyIdentification) &gt;= 1 and count(cac:PartyIdentification) &lt;= 3"/>
         <xsl:otherwise>doc:OrderResponse/cac:BuyerCustomerParty/cac:Party must contain cac:PartyIdentification at least 1 and at most 3 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyName) &gt;= 1 and count(cac:PartyName) &lt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:BuyerCustomerParty/cac:Party must contain cac:PartyName at least 1 and at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty"
                 priority="1059"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyIdentification) &gt;= 1 and count(cac:PartyIdentification) &lt;= 3"/>
         <xsl:otherwise>doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty must contain cac:PartyIdentification at least 1 and at most 3 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyName) &lt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty may contain cac:PartyName at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:Contact"
                 priority="1058"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:Name) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:Contact must contain cbc:Name at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification/cbc:ID"
                 priority="1057"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeAgencyName) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress"
                 priority="1056"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Country) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress must contain cac:Country at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country"
                 priority="1055"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:IdentificationCode) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:Contact"
                 priority="1054"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:Name) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:Contact must contain cbc:Name at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID"
                 priority="1053"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeAgencyName) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation"
                 priority="1052"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Address) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation must contain cac:Address at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address"
                 priority="1051"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Country) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address must contain cac:Country at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country"
                 priority="1050"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:IdentificationCode) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country must contain cbc:IdentificationCode at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:Contract" priority="1049" mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:ID) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:Contract must contain cbc:ID at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:Delivery/cac:DeliveryAddress" priority="1048"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Country) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:Delivery/cac:DeliveryAddress must contain cac:Country at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:Delivery/cac:DeliveryAddress/cac:Country"
                 priority="1047"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:IdentificationCode) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:Delivery/cac:DeliveryAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:Delivery/cac:Despatch" priority="1046" mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:DespatchAddress) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:Delivery/cac:Despatch must contain cac:DespatchAddress at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:Delivery/cac:Despatch/cac:DespatchAddress"
                 priority="1045"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Country) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:Delivery/cac:Despatch/cac:DespatchAddress must contain cac:Country at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country"
                 priority="1044"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:IdentificationCode) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:Delivery/cac:PromisedDeliveryPeriod"
                 priority="1043"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:EndDate) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:Delivery/cac:PromisedDeliveryPeriod must contain cbc:EndDate at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:DeliveryTerms" priority="1042" mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:ID) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:DeliveryTerms must contain cbc:ID at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:DeliveryTerms/cbc:ID" priority="1041" mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeAgencyID) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:DeliveryTerms/cbc:ID must contain @schemeAgencyID at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeAgencyName) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:DeliveryTerms/cbc:ID must contain @schemeAgencyName at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeDataURI) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:DeliveryTerms/cbc:ID must contain @schemeDataURI at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeID) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:DeliveryTerms/cbc:ID must contain @schemeID at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeName) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:DeliveryTerms/cbc:ID must contain @schemeName at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeURI) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:DeliveryTerms/cbc:ID must contain @schemeURI at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeVersionID) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:DeliveryTerms/cbc:ID must contain @schemeVersionID at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:FreightForwarderParty" priority="1040" mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyIdentification) &gt;= 1 and count(cac:PartyIdentification) &lt;= 3"/>
         <xsl:otherwise>doc:OrderResponse/cac:FreightForwarderParty must contain cac:PartyIdentification at least 1 and at most 3 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyName) &lt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:FreightForwarderParty may contain cac:PartyName at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:FreightForwarderParty/cac:PartyIdentification/cbc:ID"
                 priority="1039"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeAgencyName) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:FreightForwarderParty/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:LegalMonetaryTotal" priority="1038" mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:LineExtensionAmount) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:LegalMonetaryTotal must contain cbc:LineExtensionAmount at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:TaxExclusiveAmount) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:LegalMonetaryTotal must contain cbc:TaxExclusiveAmount at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:TaxInclusiveAmount) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:LegalMonetaryTotal must contain cbc:TaxInclusiveAmount at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:DocumentReference" priority="1037"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:DocumentType) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:DocumentReference must contain cbc:DocumentType at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:DocumentReference/cac:Attachment"
                 priority="1036"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:EmbeddedDocumentBinaryObject) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:DocumentReference/cac:Attachment must contain cbc:EmbeddedDocumentBinaryObject at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:LineItem" priority="1035" mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Price) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:LineItem must contain cac:Price at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:Quantity) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:LineItem must contain cbc:Quantity at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress"
                 priority="1034"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Country) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress must contain cac:Country at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country"
                 priority="1033"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:IdentificationCode) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty"
                 priority="1032"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyName) &gt;= 1 and count(cac:PartyName) &lt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty must contain cac:PartyName at least 1 and at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact"
                 priority="1031"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:Name) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact must contain cbc:Name at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:PromisedDeliveryPeriod"
                 priority="1030"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:EndDate) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:PromisedDeliveryPeriod must contain cbc:EndDate at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms"
                 priority="1029"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:ID) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms must contain cbc:ID at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID"
                 priority="1028"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeAgencyID) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID must contain @schemeAgencyID at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeAgencyName) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID must contain @schemeAgencyName at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeDataURI) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID must contain @schemeDataURI at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeID) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID must contain @schemeID at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeName) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID must contain @schemeName at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeURI) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID must contain @schemeURI at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeVersionID) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID must contain @schemeVersionID at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item" priority="1027"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:CatalogueIndicator) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item must contain cbc:CatalogueIndicator at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:Description) &lt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item may contain cbc:Description at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme"
                 priority="1026"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:Name) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme must contain cbc:Name at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment"
                 priority="1025"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:EmbeddedDocumentBinaryObject) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment must contain cbc:EmbeddedDocumentBinaryObject at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:LineItem/cbc:Quantity"
                 priority="1024"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@unitCode) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:LineItem/cbc:Quantity must contain @unitCode at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryAddress"
                 priority="1023"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Country) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryAddress must contain cac:Country at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryAddress/cac:Country"
                 priority="1022"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:IdentificationCode) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryParty"
                 priority="1021"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyName) &gt;= 1 and count(cac:PartyName) &lt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryParty must contain cac:PartyName at least 1 and at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryParty/cac:Contact"
                 priority="1020"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:Name) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryParty/cac:Contact must contain cbc:Name at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:PromisedDeliveryPeriod"
                 priority="1019"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:EndDate) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:PromisedDeliveryPeriod must contain cbc:EndDate at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms"
                 priority="1018"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:ID) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms must contain cbc:ID at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID"
                 priority="1017"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeAgencyID) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID must contain @schemeAgencyID at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeAgencyName) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID must contain @schemeAgencyName at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeDataURI) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID must contain @schemeDataURI at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeID) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID must contain @schemeID at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeName) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID must contain @schemeName at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeURI) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID must contain @schemeURI at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeVersionID) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID must contain @schemeVersionID at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item"
                 priority="1016"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:CatalogueIndicator) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item must contain cbc:CatalogueIndicator at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:Description) &lt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item may contain cbc:Description at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme"
                 priority="1015"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:Name) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme must contain cbc:Name at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment"
                 priority="1014"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:EmbeddedDocumentBinaryObject) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment must contain cbc:EmbeddedDocumentBinaryObject at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount"
                 priority="1013"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:ID) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount must contain cbc:ID at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country"
                 priority="1012"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:IdentificationCode) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country must contain cbc:IdentificationCode at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch"
                 priority="1011"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:FinancialInstitution) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch must contain cac:FinancialInstitution at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address"
                 priority="1010"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Country) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address must contain cac:Country at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country"
                 priority="1009"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:IdentificationCode) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country must contain cbc:IdentificationCode at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution"
                 priority="1008"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:ID) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution must contain cbc:ID at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:SellerSupplierParty" priority="1007" mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Party) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:SellerSupplierParty must contain cac:Party at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:CustomerAssignedAccountID) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:SellerSupplierParty must contain cbc:CustomerAssignedAccountID at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:SellerSupplierParty/cac:Party" priority="1006"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyIdentification) &gt;= 1 and count(cac:PartyIdentification) &lt;= 3"/>
         <xsl:otherwise>doc:OrderResponse/cac:SellerSupplierParty/cac:Party must contain cac:PartyIdentification at least 1 and at most 3 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyName) &gt;= 1 and count(cac:PartyName) &lt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:SellerSupplierParty/cac:Party must contain cac:PartyName at least 1 and at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:Contact"
                 priority="1005"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:Name) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:Contact must contain cbc:Name at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID"
                 priority="1004"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeAgencyName) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PostalAddress"
                 priority="1003"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Country) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PostalAddress must contain cac:Country at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country"
                 priority="1002"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:IdentificationCode) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:TaxTotal" priority="1001" mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:TaxSubtotal) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:TaxTotal must contain cac:TaxSubtotal at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme"
                 priority="1000"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:Name) &gt;= 1"/>
         <xsl:otherwise>doc:OrderResponse/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme must contain cbc:Name at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M4"/>
   <xsl:template match="@*|node()" priority="-2" mode="M4">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

   <!--PATTERN type-restrictions-->


	<!--RULE -->
<xsl:template match="doc:OrderResponse" priority="1048" mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="every $bn in //cbc:BuildingNumber satisfies (matches($bn,'^\d+(-[ \w]+)?$'))"/>
         <xsl:otherwise>Huisnummer en Huisnummertoevoeging moeten achter elkaar geplaatst worden, gescheiden met een koppelteken.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="every $id in //cac:PartyIdentification/cbc:ID satisfies (exists($id/@schemeAgencyID) and not(empty($id/@schemeAgencyID)) and exists($id/@schemeAgencyName) and not(empty($id/@schemeAgencyName)))"/>
         <xsl:otherwise>PartyIdentification/ID MOET @schemeAgencyID en @schemeAgencyName attributen bevatten.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="every $pa in //cac:PostalAddress satisfies ((not(empty($pa/cbc:Postbox)) and empty($pa/cbc:StreetName) and empty($pa/cbc:BuildingNumber) and empty(cbc:Room) and empty(cbc:Floor) and empty(cbc:Department) and empty(cbc:InhouseMail) and empty(cbc:PlotIdentification)) or (empty($pa/cbc:Postbox) and (not(empty($pa/cbc:StreetName)) or not(empty($pa/cbc:BuildingNumber)) or not(empty(cbc:Room)) or not(empty(cbc:Floor)) or not(empty(cbc:Department)) or not(empty(cbc:InhouseMail)) or not(empty(cbc:PlotIdentification)))))"/>
         <xsl:otherwise>PostalAddress MOET OF een Postbox bevatten OF minimaal 1 van de elementen StreetName, BuildingNumber, Room, Floor, Department, InhouseMail of PlotIdentification. Beide MAG NIET.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="( (count(cac:Delivery/cac:DeliveryAddress) = 0) and (count(cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress) = count(cac:OrderLine/cac:LineItem)))or( (count(cac:Delivery/cac:DeliveryAddress) &gt; 0) and (count(cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress) = 0))"/>
         <xsl:otherwise> Afleveradres MOET OF op algemeen niveau OF voor alle regels worden opgegeven.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="( (count(cbc:AccountingCostCode) = 0) and (count(cac:OrderLine/cac:LineItem/cbc:AccountingCostCode) = count(cac:OrderLine/cac:LineItem)))or( (count(cbc:AccountingCostCode) &gt; 0) and (count(cac:OrderLine/cac:LineItem/cbc:AccountingCostCode) = 0))"/>
         <xsl:otherwise> Kostenplaats MOET OF op algemeen niveau OF voor alle regels worden opgegeven.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(count(cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact) = count(cac:OrderLine/cac:LineItem))or(count(cac:SellerSupplierParty/cac:Party/cac:Contact) &gt; 0)"/>
         <xsl:otherwise> Leverancier contactpersoon MOET voor alle regels worden opgegeven ALS NIET op algemeen niveau opgegeven.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="( (count(cac:Delivery/cac:PromisedDeliveryPeriod) = 0) and (count(cac:OrderLine/cac:LineItem/cac:Delivery/cac:PromisedDeliveryPeriod) = count(cac:OrderLine/cac:LineItem)))or( (count(cac:Delivery/cac:PromisedDeliveryPeriod) &gt; 0) and (count(cac:OrderLine/cac:LineItem/cac:Delivery/cac:PromisedDeliveryPeriod) = 0))"/>
         <xsl:otherwise>Levertijd MOET OF op algemeen niveau OF voor alle regels worden opgegeven.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="every $pi in //cac:PartyIdentification satisfies (if(count($pi/cbc:ID[@schemeAgencyName = 'Vest']) = 1) then (count($pi/../cac:PartyIdentification/cbc:ID[@schemeAgencyName = 'KvK']) = 1) else ('true'))"/>
         <xsl:otherwise>Als Vestigingsnummer is opgegeven MOET Kamer van Koophandel nummer ook opgegeven worden.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(cbc:CustomizationID) or (cbc:CustomizationID='1.8')"/>
         <xsl:otherwise>Bericht MOET gebaseerd zijn op versie 1.8 van de Nederlandse specificatie.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(cbc:ProfileID) or (cbc:ProfileID='NL')"/>
         <xsl:otherwise>Bericht MOET op de Nederlandse (NL) specificatie gebaseerd zijn.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(cbc:UBLVersionID) or (cbc:UBLVersionID='2.0')"/>
         <xsl:otherwise>Bericht MOET gebaseerd zijn op UBL Versie 2.0<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification/cbc:ID"
                 priority="1047"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="matches(@schemeAgencyID, '^[A-Z]{2}$')"/>
         <xsl:otherwise>Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@schemeAgencyName) or (@schemeAgencyName='KvK') or (@schemeAgencyName='Vest') or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')"/>
         <xsl:otherwise>Uitgevende organisatie van de PartijIdentificatie MOET geïdentificeerd worden door een code uit de lijst: KvK, Vest, BTW, Fi, BSN, OIN, XXX.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID"
                 priority="1046"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="matches(@schemeAgencyID, '^[A-Z]{2}$')"/>
         <xsl:otherwise>Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@schemeAgencyName) or (@schemeAgencyName='KvK') or (@schemeAgencyName='Vest') or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')"/>
         <xsl:otherwise>Uitgevende organisatie van de PartijIdentificatie MOET geïdentificeerd worden door een code uit de lijst: KvK, Vest, BTW, Fi, BSN, OIN, XXX.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"
                 priority="1045"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:Contact/cbc:Name"
                 priority="1044"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:Contact/cbc:Name must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification/cbc:ID"
                 priority="1043"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="matches(@schemeAgencyID, '^[A-Z]{2}$')"/>
         <xsl:otherwise>Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@schemeAgencyName) or (@schemeAgencyName='KvK') or (@schemeAgencyName='Vest') or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')"/>
         <xsl:otherwise>Uitgevende organisatie van de PartijIdentificatie MOET geïdentificeerd worden door een code uit de lijst: KvK, Vest, BTW, Fi, BSN, OIN, XXX.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode"
                 priority="1042"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:Contact/cbc:Name"
                 priority="1041"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:Contact/cbc:Name must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID"
                 priority="1040"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="matches(@schemeAgencyID, '^[A-Z]{2}$')"/>
         <xsl:otherwise>Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@schemeAgencyName) or (@schemeAgencyName='KvK') or (@schemeAgencyName='Vest') or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')"/>
         <xsl:otherwise>Uitgevende organisatie van de PartijIdentificatie MOET geïdentificeerd worden door een code uit de lijst: KvK, Vest, BTW, Fi, BSN, OIN, XXX.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode"
                 priority="1039"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:Contract/cbc:ID" priority="1038" mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>doc:OrderResponse/cac:Contract/cbc:ID must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode"
                 priority="1037"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>doc:OrderResponse/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country/cbc:IdentificationCode"
                 priority="1036"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>doc:OrderResponse/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country/cbc:IdentificationCode must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:DeliveryTerms/cbc:ID" priority="1035" mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>doc:OrderResponse/cac:DeliveryTerms/cbc:ID must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@schemeAgencyID) or (@schemeAgencyID='88')"/>
         <xsl:otherwise>doc:OrderResponse/cac:DeliveryTerms/cbc:ID/@schemeAgencyID must have one of the following values: [88]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@schemeAgencyName) or (@schemeAgencyName='Logius Gegevensbeheer NL-Overheid')"/>
         <xsl:otherwise>doc:OrderResponse/cac:DeliveryTerms/cbc:ID/@schemeAgencyName must have one of the following values: [Logius Gegevensbeheer NL-Overheid]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@schemeDataURI) or (@schemeDataURI='urn:digi-inkoop:ubl:2.0:NL:1.8:gc:DeliveryTermsCode')"/>
         <xsl:otherwise>doc:OrderResponse/cac:DeliveryTerms/cbc:ID/@schemeDataURI must have one of the following values: [urn:digi-inkoop:ubl:2.0:NL:1.8:gc:DeliveryTermsCode]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@schemeID) or (@schemeID='NL-1002')"/>
         <xsl:otherwise>doc:OrderResponse/cac:DeliveryTerms/cbc:ID/@schemeID must have one of the following values: [NL-1002]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@schemeName) or (@schemeName='DeliveryTermsCode')"/>
         <xsl:otherwise>doc:OrderResponse/cac:DeliveryTerms/cbc:ID/@schemeName must have one of the following values: [DeliveryTermsCode]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@schemeURI) or (@schemeURI='http://www.nltaxonomie.nl/ubl/2.0/NL/1.8/cl/gc/DeliveryTermsCode.gc')"/>
         <xsl:otherwise>doc:OrderResponse/cac:DeliveryTerms/cbc:ID/@schemeURI must have one of the following values: [http://www.nltaxonomie.nl/ubl/2.0/NL/1.8/cl/gc/DeliveryTermsCode.gc]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@schemeVersionID) or (@schemeVersionID='1.8')"/>
         <xsl:otherwise>doc:OrderResponse/cac:DeliveryTerms/cbc:ID/@schemeVersionID must have one of the following values: [1.8]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:FreightForwarderParty/cac:PartyIdentification/cbc:ID"
                 priority="1034"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="matches(@schemeAgencyID, '^[A-Z]{2}$')"/>
         <xsl:otherwise>Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@schemeAgencyName) or (@schemeAgencyName='KvK') or (@schemeAgencyName='Vest') or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')"/>
         <xsl:otherwise>Uitgevende organisatie van de PartijIdentificatie MOET geïdentificeerd worden door een code uit de lijst: KvK, Vest, BTW, Fi, BSN, OIN, XXX.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject"
                 priority="1033"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:DocumentReference/cbc:DocumentType"
                 priority="1032"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise> DocumentType MOET gevuld worden met de soort identificatie van het document: 'Bestelling' of 'Contract' of 'Specificatie' in geval er een bijlage meegezonden wordt.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode"
                 priority="1031"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact/cbc:Name"
                 priority="1030"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact/cbc:Name must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cbc:Quantity/@unitCode"
                 priority="1029"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cbc:Quantity/@unitCode must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID"
                 priority="1028"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@schemeAgencyID) or (@schemeAgencyID='88')"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID/@schemeAgencyID must have one of the following values: [88]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@schemeAgencyName) or (@schemeAgencyName='Logius Gegevensbeheer NL-Overheid')"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID/@schemeAgencyName must have one of the following values: [Logius Gegevensbeheer NL-Overheid]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@schemeDataURI) or (@schemeDataURI='urn:digi-inkoop:ubl:2.0:NL:1.8:gc:DeliveryTermsCode')"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID/@schemeDataURI must have one of the following values: [urn:digi-inkoop:ubl:2.0:NL:1.8:gc:DeliveryTermsCode]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@schemeID) or (@schemeID='NL-1002')"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID/@schemeID must have one of the following values: [NL-1002]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@schemeName) or (@schemeName='DeliveryTermsCode')"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID/@schemeName must have one of the following values: [DeliveryTermsCode]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@schemeURI) or (@schemeURI='http://www.nltaxonomie.nl/ubl/2.0/NL/1.8/cl/gc/DeliveryTermsCode.gc')"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID/@schemeURI must have one of the following values: [http://www.nltaxonomie.nl/ubl/2.0/NL/1.8/cl/gc/DeliveryTermsCode.gc]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@schemeVersionID) or (@schemeVersionID='1.8')"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID/@schemeVersionID must have one of the following values: [1.8]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item" priority="1027"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="(count(cbc:Description) + count(cac:BuyersItemIdentification/cbc:ID) + count(cac:SellersItemIdentification/cbc:ID) + count(cac:ManufacturersItemIdentification/cbc:ID) + count(cac:StandardItemIdentification/cbc:ID) + count(cac:CatalogueItemIdentification/cbc:ID)) &gt; 0"/>
         <xsl:otherwise>Item MOET een Description OF een (party)Identification/ID bevatten.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme"
                 priority="1026"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(cbc:Name) or (cbc:Name='BTW') or (cbc:Name='Accijns') or (cbc:Name='Toeslag') or (cbc:Name='Overige')"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme/cbc:Name must have one of the following values: [BTW, Accijns, Toeslag, Overige]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject"
                 priority="1025"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cbc:Description"
                 priority="1024"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cbc:Description must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Price/cbc:BaseQuantity/@unitCode"
                 priority="1023"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Price/cbc:BaseQuantity/@unitCode must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Price/cbc:PriceAmount"
                 priority="1022"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="(count(../../../../cbc:PricingCurrencyCode) = 0)or( (count(../../../../cbc:PricingCurrencyCode) &gt; 0) and (@currencyID = ../../../../cbc:PricingCurrencyCode/text()))"/>
         <xsl:otherwise>Valutacode op regelniveau MOET gelijk zijn aan algemeen niveau als opgegeven.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:LineItem/cbc:Quantity/@unitCode"
                 priority="1021"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:LineItem/cbc:Quantity/@unitCode must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode"
                 priority="1020"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryParty/cac:Contact/cbc:Name"
                 priority="1019"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryParty/cac:Contact/cbc:Name must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cbc:Quantity/@unitCode"
                 priority="1018"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cbc:Quantity/@unitCode must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID"
                 priority="1017"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@schemeAgencyID) or (@schemeAgencyID='88')"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID/@schemeAgencyID must have one of the following values: [88]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@schemeAgencyName) or (@schemeAgencyName='Logius Gegevensbeheer NL-Overheid')"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID/@schemeAgencyName must have one of the following values: [Logius Gegevensbeheer NL-Overheid]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@schemeDataURI) or (@schemeDataURI='urn:digi-inkoop:ubl:2.0:NL:1.8:gc:DeliveryTermsCode')"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID/@schemeDataURI must have one of the following values: [urn:digi-inkoop:ubl:2.0:NL:1.8:gc:DeliveryTermsCode]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@schemeID) or (@schemeID='NL-1002')"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID/@schemeID must have one of the following values: [NL-1002]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@schemeName) or (@schemeName='DeliveryTermsCode')"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID/@schemeName must have one of the following values: [DeliveryTermsCode]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@schemeURI) or (@schemeURI='http://www.nltaxonomie.nl/ubl/2.0/NL/1.8/cl/gc/DeliveryTermsCode.gc')"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID/@schemeURI must have one of the following values: [http://www.nltaxonomie.nl/ubl/2.0/NL/1.8/cl/gc/DeliveryTermsCode.gc]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@schemeVersionID) or (@schemeVersionID='1.8')"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID/@schemeVersionID must have one of the following values: [1.8]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item"
                 priority="1016"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="(count(cbc:Description) + count(cac:BuyersItemIdentification/cbc:ID) + count(cac:SellersItemIdentification/cbc:ID) + count(cac:ManufacturersItemIdentification/cbc:ID) + count(cac:StandardItemIdentification/cbc:ID) + count(cac:CatalogueItemIdentification/cbc:ID)) &gt; 0"/>
         <xsl:otherwise>Item MOET een Description OF een (party)Identification/ID bevatten.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme"
                 priority="1015"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(cbc:Name) or (cbc:Name='BTW') or (cbc:Name='Accijns') or (cbc:Name='Toeslag') or (cbc:Name='Overige')"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme/cbc:Name must have one of the following values: [BTW, Accijns, Toeslag, Overige]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject"
                 priority="1014"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cbc:Description"
                 priority="1013"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cbc:Description must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Price/cbc:BaseQuantity/@unitCode"
                 priority="1012"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Price/cbc:BaseQuantity/@unitCode must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cbc:Quantity/@unitCode"
                 priority="1011"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cbc:Quantity/@unitCode must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode"
                 priority="1010"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode"
                 priority="1009"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID"
                 priority="1008"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:ID"
                 priority="1007"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:ID must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:PaymentMeans/cbc:PaymentMeansCode" priority="1006"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>doc:OrderResponse/cac:PaymentMeans/cbc:PaymentMeansCode must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name"
                 priority="1005"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID"
                 priority="1004"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="matches(@schemeAgencyID, '^[A-Z]{2}$')"/>
         <xsl:otherwise>Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@schemeAgencyName) or (@schemeAgencyName='KvK') or (@schemeAgencyName='Vest') or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')"/>
         <xsl:otherwise>Uitgevende organisatie van de PartijIdentificatie MOET geïdentificeerd worden door een code uit de lijst: KvK, Vest, BTW, Fi, BSN, OIN, XXX.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"
                 priority="1003"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:SellerSupplierParty/cbc:CustomerAssignedAccountID"
                 priority="1002"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>doc:OrderResponse/cac:SellerSupplierParty/cbc:CustomerAssignedAccountID must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme"
                 priority="1001"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(cbc:Name) or (cbc:Name='BTW') or (cbc:Name='Accijns') or (cbc:Name='Toeslag') or (cbc:Name='Overige')"/>
         <xsl:otherwise>doc:OrderResponse/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:Name must have one of the following values: [BTW, Accijns, Toeslag, Overige]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:OrderResponse/cbc:DocumentCurrencyCode" priority="1000" mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyID) or (@listAgencyID='6')"/>
         <xsl:otherwise>doc:OrderResponse/cbc:DocumentCurrencyCode/@listAgencyID must have one of the following values: [6]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')"/>
         <xsl:otherwise>doc:OrderResponse/cbc:DocumentCurrencyCode/@listAgencyName must have one of the following values: [United Nations Economic Commission for Europe]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listID) or (@listID='ISO 4217 Alpha')"/>
         <xsl:otherwise>doc:OrderResponse/cbc:DocumentCurrencyCode/@listID must have one of the following values: [ISO 4217 Alpha]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listName) or (@listName='Currency')"/>
         <xsl:otherwise>doc:OrderResponse/cbc:DocumentCurrencyCode/@listName must have one of the following values: [Currency]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listSchemeURI) or (@listSchemeURI='urn:un:unece:uncefact:codelist:specification:54217')"/>
         <xsl:otherwise>doc:OrderResponse/cbc:DocumentCurrencyCode/@listSchemeURI must have one of the following values: [urn:un:unece:uncefact:codelist:specification:54217]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/cefact/CurrencyCode-2.0.gc')"/>
         <xsl:otherwise>doc:OrderResponse/cbc:DocumentCurrencyCode/@listURI must have one of the following values: [http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/cefact/CurrencyCode-2.0.gc]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listVersionID) or (@listVersionID='2001')"/>
         <xsl:otherwise>doc:OrderResponse/cbc:DocumentCurrencyCode/@listVersionID must have one of the following values: [2001]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M5"/>
   <xsl:template match="@*|node()" priority="-2" mode="M5">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>
</xsl:stylesheet>