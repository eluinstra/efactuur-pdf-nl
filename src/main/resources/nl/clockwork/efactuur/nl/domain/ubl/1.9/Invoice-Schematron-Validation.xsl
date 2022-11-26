<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:schold="http://www.ascc.net/xml/schematron"
                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
                xmlns:nl-cbc="urn:digi-inkoop:ubl:2.0:NL:1.7:UBL-NL-CommonBasicComponents-2"
                xmlns:doc="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"
                xmlns:nl-cac="urn:digi-inkoop:ubl:2.0:NL:1.8:UBL-NL-CommonAggregateComponents-2"
                xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
                xmlns:ext="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"
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
<xsl:output xmlns:svrl="http://purl.oclc.org/dsdl/svrl" method="xml"
               omit-xml-declaration="no"
               standalone="yes"
               indent="yes"/>

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
      <svrl:schematron-output xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                              title="Validations for Invoice Mapping; strict=false"
                              schemaVersion="">
         <xsl:comment>
            <xsl:value-of select="$archiveDirParameter"/>   
		 <xsl:value-of select="$archiveNameParameter"/>  
		 <xsl:value-of select="$fileNameParameter"/>  
		 <xsl:value-of select="$fileDirParameter"/>
         </xsl:comment>
         <svrl:ns-prefix-in-attribute-values uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
                                             prefix="cbc"/>
         <svrl:ns-prefix-in-attribute-values uri="urn:digi-inkoop:ubl:2.0:NL:1.7:UBL-NL-CommonBasicComponents-2"
                                             prefix="nl-cbc"/>
         <svrl:ns-prefix-in-attribute-values uri="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2" prefix="doc"/>
         <svrl:ns-prefix-in-attribute-values uri="urn:digi-inkoop:ubl:2.0:NL:1.8:UBL-NL-CommonAggregateComponents-2"
                                             prefix="nl-cac"/>
         <svrl:ns-prefix-in-attribute-values uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
                                             prefix="cac"/>
         <svrl:ns-prefix-in-attribute-values uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"
                                             prefix="ext"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">cardinality-redefines</xsl:attribute>
            <xsl:attribute name="name">cardinality-redefines</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M7"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">type-restrictions</xsl:attribute>
            <xsl:attribute name="name">type-restrictions</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M8"/>
      </svrl:schematron-output>
   </xsl:template>

   <!--SCHEMATRON PATTERNS-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Validations for Invoice Mapping; strict=false</svrl:text>

   <!--PATTERN cardinality-redefines-->


	<!--RULE -->
<xsl:template match="doc:Invoice" priority="1102" mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="doc:Invoice"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:ProfileID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:ProfileID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice must contain cbc:ProfileID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:TaxTotal) &gt;= 1 and count(cac:TaxTotal) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cac:TaxTotal) &gt;= 1 and count(cac:TaxTotal) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice must contain cac:TaxTotal at least 1 and at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:UBLVersionID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:UBLVersionID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice must contain cbc:UBLVersionID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Delivery) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:Delivery) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice may contain cac:Delivery at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:CustomizationID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cbc:CustomizationID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice must contain cbc:CustomizationID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:InvoicePeriod) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:InvoicePeriod) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice may contain cac:InvoicePeriod at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:BillingReference) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cac:BillingReference) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice may contain cac:BillingReference at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AccountingCustomerParty" priority="1101" mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AccountingCustomerParty"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Party) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:Party) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty must contain cac:Party at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AccountingCustomerParty/cac:Party" priority="1100"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AccountingCustomerParty/cac:Party"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyIdentification) &gt;= 1 and count(cac:PartyIdentification) &lt;= 3"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cac:PartyIdentification) &gt;= 1 and count(cac:PartyIdentification) &lt;= 3">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party must contain cac:PartyIdentification at least 1 and at most 3 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyLegalEntity) &gt;= 1 and count(cac:PartyLegalEntity) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cac:PartyLegalEntity) &gt;= 1 and count(cac:PartyLegalEntity) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party must contain cac:PartyLegalEntity at least 1 and at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyName) &gt;= 1 and count(cac:PartyName) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cac:PartyName) &gt;= 1 and count(cac:PartyName) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party must contain cac:PartyName at least 1 and at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:Contact"
                 priority="1099"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:Contact"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:Name) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:Name) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:Contact must contain cbc:Name at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID"
                 priority="1098"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeAgencyID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@schemeAgencyID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeAgencyName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@schemeAgencyName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity"
                 priority="1097"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:RegistrationAddress) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cac:RegistrationAddress) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity must contain cac:RegistrationAddress at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress"
                 priority="1096"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Country) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:Country) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress must contain cac:Country at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country"
                 priority="1095"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:IdentificationCode) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cbc:IdentificationCode) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode"
                 priority="1094"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listSchemeURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listSchemeURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode must contain @listSchemeURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listVersionID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listVersionID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode must contain @listVersionID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode must contain @listAgencyName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode must contain @listName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode must contain @listID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode must contain @listURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode must contain @listAgencyID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation"
                 priority="1093"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Address) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:Address) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation must contain cac:Address at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address"
                 priority="1092"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Country) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:Country) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address must contain cac:Country at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country"
                 priority="1091"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:IdentificationCode) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cbc:IdentificationCode) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode"
                 priority="1090"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listAgencyName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listVersionID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listVersionID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listVersionID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listSchemeURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listSchemeURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listSchemeURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listAgencyID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress"
                 priority="1089"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Country) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:Country) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress must contain cac:Country at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country"
                 priority="1088"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:IdentificationCode) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cbc:IdentificationCode) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"
                 priority="1087"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listAgencyName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listVersionID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listVersionID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listVersionID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listSchemeURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listSchemeURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listSchemeURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listAgencyID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AccountingSupplierParty" priority="1086" mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AccountingSupplierParty"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Party) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:Party) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty must contain cac:Party at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AccountingSupplierParty/cac:Party" priority="1085"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AccountingSupplierParty/cac:Party"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyName) &gt;= 1 and count(cac:PartyName) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cac:PartyName) &gt;= 1 and count(cac:PartyName) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party must contain cac:PartyName at least 1 and at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyIdentification) &gt;= 1 and count(cac:PartyIdentification) &lt;= 3"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cac:PartyIdentification) &gt;= 1 and count(cac:PartyIdentification) &lt;= 3">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party must contain cac:PartyIdentification at least 1 and at most 3 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyLegalEntity) &gt;= 1 and count(cac:PartyLegalEntity) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cac:PartyLegalEntity) &gt;= 1 and count(cac:PartyLegalEntity) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party must contain cac:PartyLegalEntity at least 1 and at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:Contact"
                 priority="1084"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:Contact"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:Name) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:Name) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:Contact must contain cbc:Name at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID"
                 priority="1083"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeAgencyName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@schemeAgencyName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeAgencyID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@schemeAgencyID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity"
                 priority="1082"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:RegistrationAddress) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cac:RegistrationAddress) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity must contain cac:RegistrationAddress at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress"
                 priority="1081"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Country) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:Country) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress must contain cac:Country at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country"
                 priority="1080"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:IdentificationCode) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cbc:IdentificationCode) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode"
                 priority="1079"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode must contain @listName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode must contain @listURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listVersionID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listVersionID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode must contain @listVersionID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listSchemeURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listSchemeURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode must contain @listSchemeURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode must contain @listAgencyID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode must contain @listAgencyName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode must contain @listID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation"
                 priority="1078"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Address) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:Address) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation must contain cac:Address at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address"
                 priority="1077"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Country) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:Country) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address must contain cac:Country at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country"
                 priority="1076"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:IdentificationCode) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cbc:IdentificationCode) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode"
                 priority="1075"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listSchemeURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listSchemeURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listSchemeURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listAgencyName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listAgencyID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listVersionID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listVersionID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listVersionID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress"
                 priority="1074"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Country) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:Country) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress must contain cac:Country at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country"
                 priority="1073"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:IdentificationCode) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cbc:IdentificationCode) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"
                 priority="1072"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listAgencyName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listVersionID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listVersionID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listVersionID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listAgencyID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listSchemeURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listSchemeURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listSchemeURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AllowanceCharge/cac:TaxTotal" priority="1071" mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AllowanceCharge/cac:TaxTotal"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:TaxSubtotal) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:TaxSubtotal) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AllowanceCharge/cac:TaxTotal must contain cac:TaxSubtotal at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AllowanceCharge/cac:TaxTotal/cac:TaxSubtotal"
                 priority="1070"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AllowanceCharge/cac:TaxTotal/cac:TaxSubtotal"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:TaxableAmount) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:TaxableAmount) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AllowanceCharge/cac:TaxTotal/cac:TaxSubtotal must contain cbc:TaxableAmount at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AllowanceCharge/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme"
                 priority="1069"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AllowanceCharge/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:Name) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:Name) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AllowanceCharge/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme must contain cbc:Name at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:BuyerCustomerParty" priority="1068" mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:BuyerCustomerParty"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Party) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:Party) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty must contain cac:Party at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:BuyerCustomerParty/cac:Party" priority="1067" mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:BuyerCustomerParty/cac:Party"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyIdentification) &gt;= 1 and count(cac:PartyIdentification) &lt;= 3"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cac:PartyIdentification) &gt;= 1 and count(cac:PartyIdentification) &lt;= 3">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party must contain cac:PartyIdentification at least 1 and at most 3 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyName) &gt;= 1 and count(cac:PartyName) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cac:PartyName) &gt;= 1 and count(cac:PartyName) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party must contain cac:PartyName at least 1 and at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyLegalEntity) &gt;= 1 and count(cac:PartyLegalEntity) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cac:PartyLegalEntity) &gt;= 1 and count(cac:PartyLegalEntity) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party must contain cac:PartyLegalEntity at least 1 and at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:Contact"
                 priority="1066"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:Contact"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:Name) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:Name) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:Contact must contain cbc:Name at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID"
                 priority="1065"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeAgencyID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@schemeAgencyID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeAgencyName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@schemeAgencyName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity"
                 priority="1064"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:RegistrationAddress) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cac:RegistrationAddress) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity must contain cac:RegistrationAddress at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress"
                 priority="1063"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Country) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:Country) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress must contain cac:Country at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country"
                 priority="1062"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:IdentificationCode) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cbc:IdentificationCode) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode"
                 priority="1061"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode must contain @listName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode must contain @listAgencyID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode must contain @listAgencyName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode must contain @listURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listSchemeURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listSchemeURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode must contain @listSchemeURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode must contain @listID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listVersionID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listVersionID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode must contain @listVersionID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation"
                 priority="1060"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Address) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:Address) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation must contain cac:Address at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address"
                 priority="1059"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Country) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:Country) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address must contain cac:Country at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country"
                 priority="1058"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:IdentificationCode) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cbc:IdentificationCode) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode"
                 priority="1057"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listSchemeURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listSchemeURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listSchemeURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listAgencyID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listVersionID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listVersionID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listVersionID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listAgencyName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress"
                 priority="1056"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Country) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:Country) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress must contain cac:Country at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country"
                 priority="1055"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:IdentificationCode) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cbc:IdentificationCode) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"
                 priority="1054"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listAgencyID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listVersionID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listVersionID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listVersionID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listSchemeURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listSchemeURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listSchemeURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listAgencyName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:Delivery/cac:DeliveryAddress" priority="1053" mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:Delivery/cac:DeliveryAddress"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Country) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:Country) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:Delivery/cac:DeliveryAddress must contain cac:Country at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country"
                 priority="1052"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:IdentificationCode) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cbc:IdentificationCode) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode"
                 priority="1051"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must contain @listURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must contain @listAgencyID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listVersionID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listVersionID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must contain @listVersionID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listSchemeURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listSchemeURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must contain @listSchemeURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must contain @listName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must contain @listID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must contain @listAgencyName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:DeliveryTerms" priority="1050" mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:DeliveryTerms"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:ID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:ID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:DeliveryTerms must contain cbc:ID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:DeliveryTerms/cbc:ID" priority="1049" mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:DeliveryTerms/cbc:ID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeVersionID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@schemeVersionID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:DeliveryTerms/cbc:ID must contain @schemeVersionID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeAgencyID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@schemeAgencyID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:DeliveryTerms/cbc:ID must contain @schemeAgencyID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeAgencyName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@schemeAgencyName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:DeliveryTerms/cbc:ID must contain @schemeAgencyName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeDataURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@schemeDataURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:DeliveryTerms/cbc:ID must contain @schemeDataURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@schemeID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:DeliveryTerms/cbc:ID must contain @schemeID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@schemeName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:DeliveryTerms/cbc:ID must contain @schemeName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@schemeURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:DeliveryTerms/cbc:ID must contain @schemeURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:InvoiceLine" priority="1048" mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="doc:Invoice/cac:InvoiceLine"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:FreeOfChargeIndicator) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cbc:FreeOfChargeIndicator) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoiceLine must contain cbc:FreeOfChargeIndicator at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Delivery) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:Delivery) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoiceLine may contain cac:Delivery at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:OrderLineReference) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cac:OrderLineReference) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoiceLine may contain cac:OrderLineReference at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Price) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:Price) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoiceLine must contain cac:Price at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:InvoicedQuantity) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cbc:InvoicedQuantity) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoiceLine must contain cbc:InvoicedQuantity at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:TaxTotal) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:TaxTotal) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoiceLine may contain cac:TaxTotal at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress"
                 priority="1047"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Country) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:Country) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress must contain cac:Country at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cac:Country"
                 priority="1046"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cac:Country"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:IdentificationCode) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cbc:IdentificationCode) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode"
                 priority="1045"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must contain @listID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must contain @listURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listVersionID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listVersionID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must contain @listVersionID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must contain @listName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listSchemeURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listSchemeURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must contain @listSchemeURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must contain @listAgencyID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must contain @listAgencyName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:InvoiceLine/cac:Item" priority="1044" mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:InvoiceLine/cac:Item"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:Name) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:Name) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoiceLine/cac:Item must contain cbc:Name at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:CatalogueIndicator) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cbc:CatalogueIndicator) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoiceLine/cac:Item must contain cbc:CatalogueIndicator at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:Description) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:Description) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoiceLine/cac:Item may contain cbc:Description at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme"
                 priority="1043"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:Name) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:Name) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme must contain cbc:Name at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:InvoiceLine/cac:OrderLineReference" priority="1042"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:InvoiceLine/cac:OrderLineReference"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:OrderReference) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:OrderReference) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoiceLine/cac:OrderLineReference must contain cac:OrderReference at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:InvoiceLine/cac:Price" priority="1041" mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:InvoiceLine/cac:Price"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:BaseQuantity) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:BaseQuantity) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoiceLine/cac:Price must contain cbc:BaseQuantity at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:InvoiceLine/cac:TaxTotal" priority="1040" mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:InvoiceLine/cac:TaxTotal"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:TaxSubtotal) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:TaxSubtotal) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoiceLine/cac:TaxTotal must contain cac:TaxSubtotal at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal"
                 priority="1039"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:TaxableAmount) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:TaxableAmount) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal must contain cbc:TaxableAmount at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme"
                 priority="1038"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:Name) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:Name) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme must contain cbc:Name at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:InvoicePeriod" priority="1037" mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:InvoicePeriod"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:DescriptionCode) &gt;= 1 and count(cbc:DescriptionCode) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cbc:DescriptionCode) &gt;= 1 and count(cbc:DescriptionCode) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoicePeriod must contain cbc:DescriptionCode at least 1 and at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:EndDate) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:EndDate) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoicePeriod must contain cbc:EndDate at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:StartDate) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:StartDate) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoicePeriod must contain cbc:StartDate at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:InvoicePeriod/cbc:DescriptionCode" priority="1036"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:InvoicePeriod/cbc:DescriptionCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoicePeriod/cbc:DescriptionCode must contain @listID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listSchemeURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listSchemeURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoicePeriod/cbc:DescriptionCode must contain @listSchemeURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoicePeriod/cbc:DescriptionCode must contain @listAgencyID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoicePeriod/cbc:DescriptionCode must contain @listAgencyName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoicePeriod/cbc:DescriptionCode must contain @listURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoicePeriod/cbc:DescriptionCode must contain @listName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listVersionID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listVersionID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoicePeriod/cbc:DescriptionCode must contain @listVersionID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:LegalMonetaryTotal" priority="1035" mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:LegalMonetaryTotal"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:LineExtensionAmount) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cbc:LineExtensionAmount) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:LegalMonetaryTotal must contain cbc:LineExtensionAmount at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:TaxInclusiveAmount) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cbc:TaxInclusiveAmount) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:LegalMonetaryTotal must contain cbc:TaxInclusiveAmount at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:TaxExclusiveAmount) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cbc:TaxExclusiveAmount) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:LegalMonetaryTotal must contain cbc:TaxExclusiveAmount at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:PaymentMeans" priority="1034" mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:PaymentMeans"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PayeeFinancialAccount) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cac:PayeeFinancialAccount) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans must contain cac:PayeeFinancialAccount at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount" priority="1033"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:ID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:ID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount must contain cbc:ID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country"
                 priority="1032"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:IdentificationCode) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cbc:IdentificationCode) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode"
                 priority="1031"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listSchemeURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listSchemeURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode must contain @listSchemeURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode must contain @listName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode must contain @listURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode must contain @listAgencyID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode must contain @listAgencyName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listVersionID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listVersionID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode must contain @listVersionID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode must contain @listID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch"
                 priority="1030"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:FinancialInstitution) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cac:FinancialInstitution) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch must contain cac:FinancialInstitution at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address"
                 priority="1029"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Country) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:Country) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address must contain cac:Country at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country"
                 priority="1028"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:IdentificationCode) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cbc:IdentificationCode) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode"
                 priority="1027"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode must contain @listName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode must contain @listID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listVersionID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listVersionID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode must contain @listVersionID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listSchemeURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listSchemeURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode must contain @listSchemeURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode must contain @listURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode must contain @listAgencyID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode must contain @listAgencyName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution"
                 priority="1026"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:ID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:ID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution must contain cbc:ID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:PaymentMeans/cbc:PaymentMeansCode" priority="1025"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:PaymentMeans/cbc:PaymentMeansCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cbc:PaymentMeansCode must contain @listAgencyName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cbc:PaymentMeansCode must contain @listID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listSchemeURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listSchemeURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cbc:PaymentMeansCode must contain @listSchemeURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cbc:PaymentMeansCode must contain @listURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cbc:PaymentMeansCode must contain @listName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listVersionID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listVersionID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cbc:PaymentMeansCode must contain @listVersionID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cbc:PaymentMeansCode must contain @listAgencyID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:PaymentTerms" priority="1024" mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:PaymentTerms"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:Note) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:Note) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentTerms may contain cbc:Note at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:PaymentTerms/cac:PenaltyPeriod" priority="1023"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:PaymentTerms/cac:PenaltyPeriod"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:EndDate) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:EndDate) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentTerms/cac:PenaltyPeriod must contain cbc:EndDate at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:PaymentTerms/cac:SettlementPeriod" priority="1022"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:PaymentTerms/cac:SettlementPeriod"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:Description) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:Description) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentTerms/cac:SettlementPeriod may contain cbc:Description at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:SellerSupplierParty/cac:Party" priority="1021" mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:SellerSupplierParty/cac:Party"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyIdentification) &gt;= 1 and count(cac:PartyIdentification) &lt;= 3"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cac:PartyIdentification) &gt;= 1 and count(cac:PartyIdentification) &lt;= 3">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party must contain cac:PartyIdentification at least 1 and at most 3 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyLegalEntity) &gt;= 1 and count(cac:PartyLegalEntity) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cac:PartyLegalEntity) &gt;= 1 and count(cac:PartyLegalEntity) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party must contain cac:PartyLegalEntity at least 1 and at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyName) &gt;= 1 and count(cac:PartyName) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cac:PartyName) &gt;= 1 and count(cac:PartyName) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party must contain cac:PartyName at least 1 and at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:Contact"
                 priority="1020"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:Contact"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:Name) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:Name) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:Contact must contain cbc:Name at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID"
                 priority="1019"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeAgencyName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@schemeAgencyName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeAgencyID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@schemeAgencyID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity"
                 priority="1018"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:RegistrationAddress) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cac:RegistrationAddress) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity must contain cac:RegistrationAddress at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress"
                 priority="1017"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Country) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:Country) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress must contain cac:Country at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country"
                 priority="1016"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:IdentificationCode) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cbc:IdentificationCode) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode"
                 priority="1015"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode must contain @listAgencyID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode must contain @listURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode must contain @listAgencyName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode must contain @listName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode must contain @listID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listSchemeURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listSchemeURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode must contain @listSchemeURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listVersionID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listVersionID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode must contain @listVersionID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation"
                 priority="1014"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Address) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:Address) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation must contain cac:Address at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address"
                 priority="1013"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Country) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:Country) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address must contain cac:Country at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country"
                 priority="1012"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:IdentificationCode) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cbc:IdentificationCode) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode"
                 priority="1011"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listAgencyName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listAgencyID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listSchemeURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listSchemeURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listSchemeURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listVersionID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listVersionID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listVersionID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress"
                 priority="1010"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:PostalZone) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:PostalZone) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress must contain cbc:PostalZone at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:CityName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:CityName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress must contain cbc:CityName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Country) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:Country) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress must contain cac:Country at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country"
                 priority="1009"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:IdentificationCode) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cbc:IdentificationCode) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"
                 priority="1008"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listSchemeURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listSchemeURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listSchemeURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listAgencyName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listAgencyID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listVersionID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listVersionID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listVersionID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:TaxTotal" priority="1007" mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="doc:Invoice/cac:TaxTotal"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:TaxSubtotal) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:TaxSubtotal) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:TaxTotal must contain cac:TaxSubtotal at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:TaxTotal/cac:TaxSubtotal" priority="1006" mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:TaxTotal/cac:TaxSubtotal"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:TaxableAmount) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:TaxableAmount) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:TaxTotal/cac:TaxSubtotal must contain cbc:TaxableAmount at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme"
                 priority="1005"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:Name) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:Name) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme must contain cbc:Name at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cbc:DocumentCurrencyCode" priority="1004" mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cbc:DocumentCurrencyCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cbc:DocumentCurrencyCode must contain @listID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listVersionID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listVersionID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cbc:DocumentCurrencyCode must contain @listVersionID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cbc:DocumentCurrencyCode must contain @listURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cbc:DocumentCurrencyCode must contain @listAgencyID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listSchemeURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listSchemeURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cbc:DocumentCurrencyCode must contain @listSchemeURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cbc:DocumentCurrencyCode must contain @listName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cbc:DocumentCurrencyCode must contain @listAgencyName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cbc:InvoiceTypeCode" priority="1003" mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cbc:InvoiceTypeCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cbc:InvoiceTypeCode must contain @listID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cbc:InvoiceTypeCode must contain @listAgencyID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cbc:InvoiceTypeCode must contain @listName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listVersionID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listVersionID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cbc:InvoiceTypeCode must contain @listVersionID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cbc:InvoiceTypeCode must contain @listURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cbc:InvoiceTypeCode must contain @listAgencyName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listSchemeURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listSchemeURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cbc:InvoiceTypeCode must contain @listSchemeURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine"
                 priority="1002"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:InvoicePeriod) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:InvoicePeriod) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine may contain cac:InvoicePeriod at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod"
                 priority="1001"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:StartDate) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:StartDate) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod must contain cbc:StartDate at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:DescriptionCode) &gt;= 1 and count(cbc:DescriptionCode) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cbc:DescriptionCode) &gt;= 1 and count(cbc:DescriptionCode) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod must contain cbc:DescriptionCode at least 1 and at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:EndDate) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:EndDate) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod must contain cbc:EndDate at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod/cbc:DescriptionCode"
                 priority="1000"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod/cbc:DescriptionCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod/cbc:DescriptionCode must contain @listAgencyID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod/cbc:DescriptionCode must contain @listID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod/cbc:DescriptionCode must contain @listURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listSchemeURI) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listSchemeURI) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod/cbc:DescriptionCode must contain @listSchemeURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listVersionID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listVersionID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod/cbc:DescriptionCode must contain @listVersionID at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod/cbc:DescriptionCode must contain @listAgencyName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod/cbc:DescriptionCode must contain @listName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M7"/>
   <xsl:template match="@*|node()" priority="-2" mode="M7">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

   <!--PATTERN type-restrictions-->


	<!--RULE -->
<xsl:template match="doc:Invoice" priority="1052" mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="doc:Invoice"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(cbc:ProfileID) or (cbc:ProfileID='NL')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(cbc:ProfileID) or (cbc:ProfileID='NL')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Bericht MOET op de Nederlandse (NL) specificatie gebaseerd zijn.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="every $bn in //cbc:BuildingNumber satisfies (matches($bn,'^\d+(-[ \w]+)?$'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="every $bn in //cbc:BuildingNumber satisfies (matches($bn,'^\d+(-[ \w]+)?$'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Huisnummer en Huisnummertoevoeging moeten achter elkaar geplaatst worden, gescheiden met een koppelteken.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="every $id in //cac:PartyIdentification/cbc:ID satisfies (exists($id/@schemeAgencyID) and not(empty($id/@schemeAgencyID)) and exists($id/@schemeAgencyName) and not(empty($id/@schemeAgencyName)))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="every $id in //cac:PartyIdentification/cbc:ID satisfies (exists($id/@schemeAgencyID) and not(empty($id/@schemeAgencyID)) and exists($id/@schemeAgencyName) and not(empty($id/@schemeAgencyName)))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>PartyIdentification/ID MOET @schemeAgencyID en @schemeAgencyName attributen bevatten.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="every $pa in //cac:PostalAddress satisfies ((not(empty($pa/cbc:Postbox)) and empty($pa/cbc:StreetName) and empty($pa/cbc:BuildingNumber) and empty(cbc:Room) and empty(cbc:Floor) and empty(cbc:Department) and empty(cbc:InhouseMail) and empty(cbc:PlotIdentification)) or (empty($pa/cbc:Postbox) and (not(empty($pa/cbc:StreetName)) or not(empty($pa/cbc:BuildingNumber)) or not(empty(cbc:Room)) or not(empty(cbc:Floor)) or not(empty(cbc:Department)) or not(empty(cbc:InhouseMail)) or not(empty(cbc:PlotIdentification)))))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="every $pa in //cac:PostalAddress satisfies ((not(empty($pa/cbc:Postbox)) and empty($pa/cbc:StreetName) and empty($pa/cbc:BuildingNumber) and empty(cbc:Room) and empty(cbc:Floor) and empty(cbc:Department) and empty(cbc:InhouseMail) and empty(cbc:PlotIdentification)) or (empty($pa/cbc:Postbox) and (not(empty($pa/cbc:StreetName)) or not(empty($pa/cbc:BuildingNumber)) or not(empty(cbc:Room)) or not(empty(cbc:Floor)) or not(empty(cbc:Department)) or not(empty(cbc:InhouseMail)) or not(empty(cbc:PlotIdentification)))))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>PostalAddress MOET OF een Postbox bevatten OF minimaal 1 van de elementen StreetName, BuildingNumber, Room, Floor, Department, InhouseMail of PlotIdentification. Beide MAG NIET.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="( (count(cac:Delivery/cbc:ActualDeliveryDate) = 0) and (   (count(cac:InvoiceLine/cac:Delivery/cbc:ActualDeliveryDate) ) &gt; 0 ))or( (count(cac:Delivery/cbc:ActualDeliveryDate) &gt; 0) and (   (count(cac:InvoiceLine/cac:Delivery/cbc:ActualDeliveryDate) ) = 0 ))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="( (count(cac:Delivery/cbc:ActualDeliveryDate) = 0) and ( (count(cac:InvoiceLine/cac:Delivery/cbc:ActualDeliveryDate) ) &gt; 0 ))or( (count(cac:Delivery/cbc:ActualDeliveryDate) &gt; 0) and ( (count(cac:InvoiceLine/cac:Delivery/cbc:ActualDeliveryDate) ) = 0 ))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> Bericht MOET OF een ActualDeliveryDate op documentniveau OF op regelniveau bevatten.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(count(cac:OrderReference/cbc:ID) + count(cbc:AccountingCostCode) + count(cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:Name)) &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(cac:OrderReference/cbc:ID) + count(cbc:AccountingCostCode) + count(cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:Name)) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> Er moet in ieder geval een OrderReference ID, AccountingCostCode of Contact Name worden opgegeven.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(count(cbc:InvoiceTypeCode[text() = 'C']) + count(cbc:InvoiceTypeCode[text() = 'VC'])) = 0 or count(cac:BillingReference/cac:DebitNoteDocumentReference/cbc:ID) &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(cbc:InvoiceTypeCode[text() = 'C']) + count(cbc:InvoiceTypeCode[text() = 'VC'])) = 0 or count(cac:BillingReference/cac:DebitNoteDocumentReference/cbc:ID) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Referentie naar debitnota is verplicht bij (voorstel) creditnota.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="every $pi in //cac:PartyIdentification satisfies (if(count($pi/cbc:ID[@schemeAgencyName = 'Vest']) = 1) then (count($pi/../cac:PartyIdentification/cbc:ID[@schemeAgencyName = 'KvK']) = 1) else ('true'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="every $pi in //cac:PartyIdentification satisfies (if(count($pi/cbc:ID[@schemeAgencyName = 'Vest']) = 1) then (count($pi/../cac:PartyIdentification/cbc:ID[@schemeAgencyName = 'KvK']) = 1) else ('true'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Als Vestigingsnummer is opgegeven MOET Kamer van Koophandel nummer ook opgegeven worden.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(cbc:UBLVersionID) or (cbc:UBLVersionID='2.0')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(cbc:UBLVersionID) or (cbc:UBLVersionID='2.0')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Bericht MOET gebaseerd zijn op UBL Versie 2.0</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(cbc:CustomizationID) or (cbc:CustomizationID='1.9')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(cbc:CustomizationID) or (cbc:CustomizationID='1.9')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Bericht MOET gebaseerd zijn op versie 1.9 van de Nederlandse specificatie.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:Name"
                 priority="1051"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:Name"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:Name must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID"
                 priority="1050"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="matches(@schemeAgencyID, '^[A-Z]{2}$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="matches(@schemeAgencyID, '^[A-Z]{2}$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@schemeAgencyName) or (@schemeAgencyName='KvK') or (@schemeAgencyName='Vest') or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@schemeAgencyName) or (@schemeAgencyName='KvK') or (@schemeAgencyName='Vest') or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Uitgevende organisatie van de PartijIdentificatie MOET geïdentificeerd worden door een code uit de lijst: KvK, Vest, BTW, Fi, BSN, OIN, XXX.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode"
                 priority="1049"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode/@listSchemeURI must have one of the following values: [urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listVersionID) or (@listVersionID='0.3')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listVersionID) or (@listVersionID='0.3')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode/@listVersionID must have one of the following values: [0.3]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode/@listAgencyName must have one of the following values: [United Nations Economic Commission for Europe]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listName) or (@listName='Country')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listName) or (@listName='Country')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode/@listName must have one of the following values: [Country]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listID) or (@listID='ISO3166-1')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listID) or (@listID='ISO3166-1')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode/@listID must have one of the following values: [ISO3166-1]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode/@listURI must have one of the following values: [http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyID) or (@listAgencyID='6')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyID) or (@listAgencyID='6')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode/@listAgencyID must have one of the following values: [6]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode"
                 priority="1048"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listAgencyName must have one of the following values: [United Nations Economic Commission for Europe]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listID) or (@listID='ISO3166-1')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listID) or (@listID='ISO3166-1')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listID must have one of the following values: [ISO3166-1]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listVersionID) or (@listVersionID='0.3')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listVersionID) or (@listVersionID='0.3')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listVersionID must have one of the following values: [0.3]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listSchemeURI must have one of the following values: [urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyID) or (@listAgencyID='6')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyID) or (@listAgencyID='6')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listAgencyID must have one of the following values: [6]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listName) or (@listName='Country')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listName) or (@listName='Country')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listName must have one of the following values: [Country]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listURI must have one of the following values: [http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"
                 priority="1047"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listName) or (@listName='Country')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listName) or (@listName='Country')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listName must have one of the following values: [Country]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listAgencyName must have one of the following values: [United Nations Economic Commission for Europe]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listURI must have one of the following values: [http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listID) or (@listID='ISO3166-1')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listID) or (@listID='ISO3166-1')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listID must have one of the following values: [ISO3166-1]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listVersionID) or (@listVersionID='0.3')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listVersionID) or (@listVersionID='0.3')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listVersionID must have one of the following values: [0.3]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listSchemeURI must have one of the following values: [urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyID) or (@listAgencyID='6')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyID) or (@listAgencyID='6')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listAgencyID must have one of the following values: [6]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:Name"
                 priority="1046"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:Name"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:Name must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID"
                 priority="1045"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@schemeAgencyName) or (@schemeAgencyName='KvK') or (@schemeAgencyName='Vest') or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@schemeAgencyName) or (@schemeAgencyName='KvK') or (@schemeAgencyName='Vest') or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Uitgevende organisatie van de PartijIdentificatie MOET geïdentificeerd worden door een code uit de lijst: KvK, Vest, BTW, Fi, BSN, OIN, XXX.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="matches(@schemeAgencyID, '^[A-Z]{2}$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="matches(@schemeAgencyID, '^[A-Z]{2}$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode"
                 priority="1044"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listName) or (@listName='Country')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listName) or (@listName='Country')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode/@listName must have one of the following values: [Country]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode/@listURI must have one of the following values: [http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listVersionID) or (@listVersionID='0.3')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listVersionID) or (@listVersionID='0.3')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode/@listVersionID must have one of the following values: [0.3]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode/@listSchemeURI must have one of the following values: [urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyID) or (@listAgencyID='6')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyID) or (@listAgencyID='6')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode/@listAgencyID must have one of the following values: [6]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode/@listAgencyName must have one of the following values: [United Nations Economic Commission for Europe]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listID) or (@listID='ISO3166-1')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listID) or (@listID='ISO3166-1')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode/@listID must have one of the following values: [ISO3166-1]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode"
                 priority="1043"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listName) or (@listName='Country')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listName) or (@listName='Country')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listName must have one of the following values: [Country]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listURI must have one of the following values: [http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listSchemeURI must have one of the following values: [urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listID) or (@listID='ISO3166-1')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listID) or (@listID='ISO3166-1')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listID must have one of the following values: [ISO3166-1]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listAgencyName must have one of the following values: [United Nations Economic Commission for Europe]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyID) or (@listAgencyID='6')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyID) or (@listAgencyID='6')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listAgencyID must have one of the following values: [6]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listVersionID) or (@listVersionID='0.3')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listVersionID) or (@listVersionID='0.3')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listVersionID must have one of the following values: [0.3]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"
                 priority="1042"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listAgencyName must have one of the following values: [United Nations Economic Commission for Europe]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listURI must have one of the following values: [http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listVersionID) or (@listVersionID='0.3')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listVersionID) or (@listVersionID='0.3')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listVersionID must have one of the following values: [0.3]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listName) or (@listName='Country')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listName) or (@listName='Country')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listName must have one of the following values: [Country]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyID) or (@listAgencyID='6')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyID) or (@listAgencyID='6')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listAgencyID must have one of the following values: [6]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listID) or (@listID='ISO3166-1')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listID) or (@listID='ISO3166-1')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listID must have one of the following values: [ISO3166-1]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listSchemeURI must have one of the following values: [urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:AllowanceCharge/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme"
                 priority="1041"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:AllowanceCharge/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(cbc:Name) or (cbc:Name='BTW') or (cbc:Name='Accijns') or (cbc:Name='Toeslag') or (cbc:Name='Overige')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(cbc:Name) or (cbc:Name='BTW') or (cbc:Name='Accijns') or (cbc:Name='Toeslag') or (cbc:Name='Overige')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>De soort belasting/heffing MOET geïdentificeerd worden met een code uit de lijst: BTW, Accijns, Toeslag, Overige.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:BillingReference" priority="1040" mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:BillingReference"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(count(cac:InvoiceDocumentReference) + count(cac:DebitNoteDocumentReference)) &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(cac:InvoiceDocumentReference) + count(cac:DebitNoteDocumentReference)) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>De BillingReference moet een InvoiceDocumentReference of een DebitNoteDocumentReference (of beiden) bevatten.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:BillingReference/cac:InvoiceDocumentReference/cbc:ID"
                 priority="1039"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:BillingReference/cac:InvoiceDocumentReference/cbc:ID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BillingReference/cac:InvoiceDocumentReference/cbc:ID must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:Contact/cbc:Name"
                 priority="1038"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:Contact/cbc:Name"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:Contact/cbc:Name must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID"
                 priority="1037"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="matches(@schemeAgencyID, '^[A-Z]{2}$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="matches(@schemeAgencyID, '^[A-Z]{2}$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@schemeAgencyName) or (@schemeAgencyName='KvK') or (@schemeAgencyName='Vest') or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@schemeAgencyName) or (@schemeAgencyName='KvK') or (@schemeAgencyName='Vest') or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Uitgevende organisatie van de PartijIdentificatie MOET geïdentificeerd worden door een code uit de lijst: KvK, Vest, BTW, Fi, BSN, OIN, XXX.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode"
                 priority="1036"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listName) or (@listName='Country')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listName) or (@listName='Country')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode/@listName must have one of the following values: [Country]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyID) or (@listAgencyID='6')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyID) or (@listAgencyID='6')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode/@listAgencyID must have one of the following values: [6]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode/@listAgencyName must have one of the following values: [United Nations Economic Commission for Europe]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode/@listURI must have one of the following values: [http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode/@listSchemeURI must have one of the following values: [urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listID) or (@listID='ISO3166-1')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listID) or (@listID='ISO3166-1')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode/@listID must have one of the following values: [ISO3166-1]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listVersionID) or (@listVersionID='0.3')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listVersionID) or (@listVersionID='0.3')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode/@listVersionID must have one of the following values: [0.3]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode"
                 priority="1035"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listName) or (@listName='Country')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listName) or (@listName='Country')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listName must have one of the following values: [Country]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listSchemeURI must have one of the following values: [urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listURI must have one of the following values: [http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyID) or (@listAgencyID='6')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyID) or (@listAgencyID='6')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listAgencyID must have one of the following values: [6]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listID) or (@listID='ISO3166-1')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listID) or (@listID='ISO3166-1')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listID must have one of the following values: [ISO3166-1]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listVersionID) or (@listVersionID='0.3')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listVersionID) or (@listVersionID='0.3')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listVersionID must have one of the following values: [0.3]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listAgencyName must have one of the following values: [United Nations Economic Commission for Europe]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"
                 priority="1034"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listID) or (@listID='ISO3166-1')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listID) or (@listID='ISO3166-1')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listID must have one of the following values: [ISO3166-1]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyID) or (@listAgencyID='6')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyID) or (@listAgencyID='6')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listAgencyID must have one of the following values: [6]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listVersionID) or (@listVersionID='0.3')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listVersionID) or (@listVersionID='0.3')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listVersionID must have one of the following values: [0.3]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listSchemeURI must have one of the following values: [urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listURI must have one of the following values: [http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listName) or (@listName='Country')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listName) or (@listName='Country')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listName must have one of the following values: [Country]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listAgencyName must have one of the following values: [United Nations Economic Commission for Europe]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode"
                 priority="1033"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode/@listURI must have one of the following values: [http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyID) or (@listAgencyID='6')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyID) or (@listAgencyID='6')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode/@listAgencyID must have one of the following values: [6]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listVersionID) or (@listVersionID='0.3')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listVersionID) or (@listVersionID='0.3')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode/@listVersionID must have one of the following values: [0.3]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode/@listSchemeURI must have one of the following values: [urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listName) or (@listName='Country')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listName) or (@listName='Country')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode/@listName must have one of the following values: [Country]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listID) or (@listID='ISO3166-1')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listID) or (@listID='ISO3166-1')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode/@listID must have one of the following values: [ISO3166-1]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode/@listAgencyName must have one of the following values: [United Nations Economic Commission for Europe]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:DeliveryTerms/cbc:ID" priority="1032" mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:DeliveryTerms/cbc:ID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@schemeVersionID) or (@schemeVersionID='1.8')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@schemeVersionID) or (@schemeVersionID='1.8')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:DeliveryTerms/cbc:ID/@schemeVersionID must have one of the following values: [1.8]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:DeliveryTerms/cbc:ID must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@schemeAgencyID) or (@schemeAgencyID='88')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@schemeAgencyID) or (@schemeAgencyID='88')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:DeliveryTerms/cbc:ID/@schemeAgencyID must have one of the following values: [88]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@schemeAgencyName) or (@schemeAgencyName='Logius Gegevensbeheer NL-Overheid')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@schemeAgencyName) or (@schemeAgencyName='Logius Gegevensbeheer NL-Overheid')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:DeliveryTerms/cbc:ID/@schemeAgencyName must have one of the following values: [Logius Gegevensbeheer NL-Overheid]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@schemeDataURI) or (@schemeDataURI='urn:digi-inkoop:ubl:2.0:NL:1.8:gc:DeliveryTermsCode')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@schemeDataURI) or (@schemeDataURI='urn:digi-inkoop:ubl:2.0:NL:1.8:gc:DeliveryTermsCode')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:DeliveryTerms/cbc:ID/@schemeDataURI must have one of the following values: [urn:digi-inkoop:ubl:2.0:NL:1.8:gc:DeliveryTermsCode]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@schemeID) or (@schemeID='NL-1002')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@schemeID) or (@schemeID='NL-1002')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:DeliveryTerms/cbc:ID/@schemeID must have one of the following values: [NL-1002]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@schemeName) or (@schemeName='DeliveryTermsCode')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@schemeName) or (@schemeName='DeliveryTermsCode')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:DeliveryTerms/cbc:ID/@schemeName must have one of the following values: [DeliveryTermsCode]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@schemeURI) or (@schemeURI='http://www.nltaxonomie.nl/ubl/2.0/NL/1.8/cl/gc/DeliveryTermsCode.gc')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@schemeURI) or (@schemeURI='http://www.nltaxonomie.nl/ubl/2.0/NL/1.8/cl/gc/DeliveryTermsCode.gc')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:DeliveryTerms/cbc:ID/@schemeURI must have one of the following values: [http://www.nltaxonomie.nl/ubl/2.0/NL/1.8/cl/gc/DeliveryTermsCode.gc]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode"
                 priority="1031"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listID) or (@listID='ISO3166-1')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listID) or (@listID='ISO3166-1')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode/@listID must have one of the following values: [ISO3166-1]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode/@listURI must have one of the following values: [http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listVersionID) or (@listVersionID='0.3')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listVersionID) or (@listVersionID='0.3')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode/@listVersionID must have one of the following values: [0.3]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listName) or (@listName='Country')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listName) or (@listName='Country')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode/@listName must have one of the following values: [Country]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode/@listSchemeURI must have one of the following values: [urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyID) or (@listAgencyID='6')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyID) or (@listAgencyID='6')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode/@listAgencyID must have one of the following values: [6]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode/@listAgencyName must have one of the following values: [United Nations Economic Commission for Europe]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:InvoiceLine/cac:Item" priority="1030" mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:InvoiceLine/cac:Item"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(count(cbc:Description) + count(cac:BuyersItemIdentification/cbc:ID) + count(cac:SellersItemIdentification/cbc:ID) + count(cac:ManufacturersItemIdentification/cbc:ID) + count(cac:StandardItemIdentification/cbc:ID) + count(cac:CatalogueItemIdentification/cbc:ID)) &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(cbc:Description) + count(cac:BuyersItemIdentification/cbc:ID) + count(cac:SellersItemIdentification/cbc:ID) + count(cac:ManufacturersItemIdentification/cbc:ID) + count(cac:StandardItemIdentification/cbc:ID) + count(cac:CatalogueItemIdentification/cbc:ID)) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Item MOET een Description OF een (party)Identification/ID bevatten.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme"
                 priority="1029"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(cbc:Name) or (cbc:Name='BTW') or (cbc:Name='Accijns') or (cbc:Name='Toeslag') or (cbc:Name='Overige')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(cbc:Name) or (cbc:Name='BTW') or (cbc:Name='Accijns') or (cbc:Name='Toeslag') or (cbc:Name='Overige')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> De soort belasting/heffing MOET geïdentificeerd worden met een code uit de lijst: BTW, Accijns, Toeslag, Overige.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:InvoiceLine/cac:Item/cbc:Name" priority="1028" mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:InvoiceLine/cac:Item/cbc:Name"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoiceLine/cac:Item/cbc:Name must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:InvoiceLine/cac:OrderLineReference/cbc:LineID"
                 priority="1027"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:InvoiceLine/cac:OrderLineReference/cbc:LineID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoiceLine/cac:OrderLineReference/cbc:LineID must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:InvoiceLine/cac:Price/cbc:BaseQuantity/@unitCode"
                 priority="1026"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:InvoiceLine/cac:Price/cbc:BaseQuantity/@unitCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoiceLine/cac:Price/cbc:BaseQuantity/@unitCode must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:InvoiceLine/cac:Price/cbc:PriceAmount" priority="1025"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:InvoiceLine/cac:Price/cbc:PriceAmount"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(count(../../../cbc:PricingCurrencyCode) = 0)or( (count(../../../cbc:PricingCurrencyCode) &gt; 0) and (@currencyID = ../../../cbc:PricingCurrencyCode/text()))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(../../../cbc:PricingCurrencyCode) = 0)or( (count(../../../cbc:PricingCurrencyCode) &gt; 0) and (@currencyID = ../../../cbc:PricingCurrencyCode/text()))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> Valutacode op regelniveau MOET gelijk zijn aan algemeen niveau als opgegeven.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme"
                 priority="1024"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(cbc:Name) or (cbc:Name='BTW') or (cbc:Name='Accijns') or (cbc:Name='Toeslag') or (cbc:Name='Overige')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(cbc:Name) or (cbc:Name='BTW') or (cbc:Name='Accijns') or (cbc:Name='Toeslag') or (cbc:Name='Overige')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> De soort belasting/heffing MOET geïdentificeerd worden met een code uit de lijst: BTW, Accijns, Toeslag, Overige.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:InvoiceLine/cbc:InvoicedQuantity/@unitCode"
                 priority="1023"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:InvoiceLine/cbc:InvoicedQuantity/@unitCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoiceLine/cbc:InvoicedQuantity/@unitCode must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:InvoicePeriod" priority="1022" mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:InvoicePeriod"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(cbc:DescriptionCode) or (cbc:DescriptionCode='I') or (cbc:DescriptionCode='D')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(cbc:DescriptionCode) or (cbc:DescriptionCode='I') or (cbc:DescriptionCode='D')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoicePeriod/cbc:DescriptionCode must have one of the following values: [I, D]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:InvoicePeriod/cbc:DescriptionCode" priority="1021"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:InvoicePeriod/cbc:DescriptionCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listID) or (@listID='NL-1004')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listID) or (@listID='NL-1004')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoicePeriod/cbc:DescriptionCode/@listID must have one of the following values: [NL-1004]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listSchemeURI) or (@listSchemeURI='urn:digi-inkoop:ubl:2.0:NL:1.7:gc:InvoicePeriodDescriptionCode')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listSchemeURI) or (@listSchemeURI='urn:digi-inkoop:ubl:2.0:NL:1.7:gc:InvoicePeriodDescriptionCode')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoicePeriod/cbc:DescriptionCode/@listSchemeURI must have one of the following values: [urn:digi-inkoop:ubl:2.0:NL:1.7:gc:InvoicePeriodDescriptionCode]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyID) or (@listAgencyID='88')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyID) or (@listAgencyID='88')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoicePeriod/cbc:DescriptionCode/@listAgencyID must have one of the following values: [88]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyName) or (@listAgencyName='Logius Gegevensbeheer NL-Overheid')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyName) or (@listAgencyName='Logius Gegevensbeheer NL-Overheid')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoicePeriod/cbc:DescriptionCode/@listAgencyName must have one of the following values: [Logius Gegevensbeheer NL-Overheid]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listURI) or (@listURI='http://www.nltaxonomie.nl/ubl/2.0/NL/1.7/cl/gc/InvoicePeriodDescriptionCode.gc')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listURI) or (@listURI='http://www.nltaxonomie.nl/ubl/2.0/NL/1.7/cl/gc/InvoicePeriodDescriptionCode.gc')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoicePeriod/cbc:DescriptionCode/@listURI must have one of the following values: [http://www.nltaxonomie.nl/ubl/2.0/NL/1.7/cl/gc/InvoicePeriodDescriptionCode.gc]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listName) or (@listName='FactuurPeriodDescriptionCode')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listName) or (@listName='FactuurPeriodDescriptionCode')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoicePeriod/cbc:DescriptionCode/@listName must have one of the following values: [FactuurPeriodDescriptionCode]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listVersionID) or (@listVersionID='1.7')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listVersionID) or (@listVersionID='1.7')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:InvoicePeriod/cbc:DescriptionCode/@listVersionID must have one of the following values: [1.7]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:OrderReference/cbc:ID" priority="1020" mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:OrderReference/cbc:ID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:OrderReference/cbc:ID must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode"
                 priority="1019"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode/@listSchemeURI must have one of the following values: [urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listName) or (@listName='Country')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listName) or (@listName='Country')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode/@listName must have one of the following values: [Country]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode/@listURI must have one of the following values: [http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyID) or (@listAgencyID='6')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyID) or (@listAgencyID='6')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode/@listAgencyID must have one of the following values: [6]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode/@listAgencyName must have one of the following values: [United Nations Economic Commission for Europe]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listVersionID) or (@listVersionID='0.3')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listVersionID) or (@listVersionID='0.3')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode/@listVersionID must have one of the following values: [0.3]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listID) or (@listID='ISO3166-1')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listID) or (@listID='ISO3166-1')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode/@listID must have one of the following values: [ISO3166-1]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode"
                 priority="1018"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listName) or (@listName='Country')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listName) or (@listName='Country')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode/@listName must have one of the following values: [Country]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listID) or (@listID='ISO3166-1')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listID) or (@listID='ISO3166-1')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode/@listID must have one of the following values: [ISO3166-1]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listVersionID) or (@listVersionID='0.3')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listVersionID) or (@listVersionID='0.3')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode/@listVersionID must have one of the following values: [0.3]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode/@listSchemeURI must have one of the following values: [urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode/@listURI must have one of the following values: [http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyID) or (@listAgencyID='6')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyID) or (@listAgencyID='6')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode/@listAgencyID must have one of the following values: [6]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode/@listAgencyName must have one of the following values: [United Nations Economic Commission for Europe]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID"
                 priority="1017"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:ID"
                 priority="1016"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:ID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:ID must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:PaymentMeans/cbc:PaymentMeansCode" priority="1015"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:PaymentMeans/cbc:PaymentMeansCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cbc:PaymentMeansCode/@listAgencyName must have one of the following values: [United Nations Economic Commission for Europe]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listID) or (@listID='UN/ECE 4461')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listID) or (@listID='UN/ECE 4461')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cbc:PaymentMeansCode/@listID must have one of the following values: [UN/ECE 4461]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:PaymentMeansCode')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:PaymentMeansCode')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cbc:PaymentMeansCode/@listSchemeURI must have one of the following values: [urn:oasis:names:specification:ubl:codelist:gc:PaymentMeansCode]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/PaymentMeansCode-2.0.gc')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/PaymentMeansCode-2.0.gc')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cbc:PaymentMeansCode/@listURI must have one of the following values: [http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/PaymentMeansCode-2.0.gc]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listName) or (@listName='Payment Means')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listName) or (@listName='Payment Means')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cbc:PaymentMeansCode/@listName must have one of the following values: [Payment Means]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listVersionID) or (@listVersionID='D03A')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listVersionID) or (@listVersionID='D03A')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cbc:PaymentMeansCode/@listVersionID must have one of the following values: [D03A]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyID) or (@listAgencyID='6')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyID) or (@listAgencyID='6')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cbc:PaymentMeansCode/@listAgencyID must have one of the following values: [6]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentMeans/cbc:PaymentMeansCode must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:PaymentTerms/cac:SettlementPeriod/cbc:DurationMeasure/@unitCode"
                 priority="1014"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:PaymentTerms/cac:SettlementPeriod/cbc:DurationMeasure/@unitCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:PaymentTerms/cac:SettlementPeriod/cbc:DurationMeasure/@unitCode must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name"
                 priority="1013"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID"
                 priority="1012"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@schemeAgencyName) or (@schemeAgencyName='KvK') or (@schemeAgencyName='Vest') or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@schemeAgencyName) or (@schemeAgencyName='KvK') or (@schemeAgencyName='Vest') or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Uitgevende organisatie van de PartijIdentificatie MOET geïdentificeerd worden door een code uit de lijst: KvK, Vest, BTW, Fi, BSN, OIN, XXX.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="matches(@schemeAgencyID, '^[A-Z]{2}$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="matches(@schemeAgencyID, '^[A-Z]{2}$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode"
                 priority="1011"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyID) or (@listAgencyID='6')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyID) or (@listAgencyID='6')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode/@listAgencyID must have one of the following values: [6]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode/@listURI must have one of the following values: [http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode/@listAgencyName must have one of the following values: [United Nations Economic Commission for Europe]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listName) or (@listName='Country')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listName) or (@listName='Country')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode/@listName must have one of the following values: [Country]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listID) or (@listID='ISO3166-1')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listID) or (@listID='ISO3166-1')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode/@listID must have one of the following values: [ISO3166-1]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode/@listSchemeURI must have one of the following values: [urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listVersionID) or (@listVersionID='0.3')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listVersionID) or (@listVersionID='0.3')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode/@listVersionID must have one of the following values: [0.3]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode"
                 priority="1010"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listAgencyName must have one of the following values: [United Nations Economic Commission for Europe]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyID) or (@listAgencyID='6')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyID) or (@listAgencyID='6')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listAgencyID must have one of the following values: [6]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listSchemeURI must have one of the following values: [urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listURI must have one of the following values: [http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listVersionID) or (@listVersionID='0.3')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listVersionID) or (@listVersionID='0.3')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listVersionID must have one of the following values: [0.3]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listID) or (@listID='ISO3166-1')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listID) or (@listID='ISO3166-1')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listID must have one of the following values: [ISO3166-1]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listName) or (@listName='Country')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listName) or (@listName='Country')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listName must have one of the following values: [Country]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"
                 priority="1009"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listSchemeURI must have one of the following values: [urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listAgencyName must have one of the following values: [United Nations Economic Commission for Europe]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listID) or (@listID='ISO3166-1')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listID) or (@listID='ISO3166-1')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listID must have one of the following values: [ISO3166-1]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listName) or (@listName='Country')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listName) or (@listName='Country')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listName must have one of the following values: [Country]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyID) or (@listAgencyID='6')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyID) or (@listAgencyID='6')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listAgencyID must have one of the following values: [6]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listURI must have one of the following values: [http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listVersionID) or (@listVersionID='0.3')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listVersionID) or (@listVersionID='0.3')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listVersionID must have one of the following values: [0.3]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:CityName"
                 priority="1008"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:CityName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:CityName must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:PostalZone"
                 priority="1007"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:PostalZone"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:PostalZone must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme"
                 priority="1006"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(cbc:Name) or (cbc:Name='BTW') or (cbc:Name='Accijns') or (cbc:Name='Toeslag') or (cbc:Name='Overige')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(cbc:Name) or (cbc:Name='BTW') or (cbc:Name='Accijns') or (cbc:Name='Toeslag') or (cbc:Name='Overige')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> De soort belasting/heffing MOET geïdentificeerd worden met een code uit de lijst: BTW, Accijns, Toeslag, Overige.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cbc:DocumentCurrencyCode" priority="1005" mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cbc:DocumentCurrencyCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listID) or (@listID='ISO 4217 Alpha')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listID) or (@listID='ISO 4217 Alpha')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cbc:DocumentCurrencyCode/@listID must have one of the following values: [ISO 4217 Alpha]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listVersionID) or (@listVersionID='2001')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listVersionID) or (@listVersionID='2001')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cbc:DocumentCurrencyCode/@listVersionID must have one of the following values: [2001]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/cefact/CurrencyCode-2.0.gc')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/cefact/CurrencyCode-2.0.gc')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cbc:DocumentCurrencyCode/@listURI must have one of the following values: [http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/cefact/CurrencyCode-2.0.gc]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyID) or (@listAgencyID='6')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyID) or (@listAgencyID='6')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cbc:DocumentCurrencyCode/@listAgencyID must have one of the following values: [6]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listSchemeURI) or (@listSchemeURI='urn:un:unece:uncefact:codelist:specification:54217')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listSchemeURI) or (@listSchemeURI='urn:un:unece:uncefact:codelist:specification:54217')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cbc:DocumentCurrencyCode/@listSchemeURI must have one of the following values: [urn:un:unece:uncefact:codelist:specification:54217]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listName) or (@listName='Currency')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listName) or (@listName='Currency')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cbc:DocumentCurrencyCode/@listName must have one of the following values: [Currency]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cbc:DocumentCurrencyCode/@listAgencyName must have one of the following values: [United Nations Economic Commission for Europe]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cbc:ID" priority="1004" mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="doc:Invoice/cbc:ID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cbc:ID must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) lt 25"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) lt 25">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Element lengte MOET minder dan 25 posities zijn.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/cbc:InvoiceTypeCode" priority="1003" mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/cbc:InvoiceTypeCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listID) or (@listID='NL-1001')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listID) or (@listID='NL-1001')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cbc:InvoiceTypeCode/@listID must have one of the following values: [NL-1001]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyID) or (@listAgencyID='88')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyID) or (@listAgencyID='88')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cbc:InvoiceTypeCode/@listAgencyID must have one of the following values: [88]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listName) or (@listName='FactuurSoort')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listName) or (@listName='FactuurSoort')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cbc:InvoiceTypeCode/@listName must have one of the following values: [FactuurSoort]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listVersionID) or (@listVersionID='1.7')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listVersionID) or (@listVersionID='1.7')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cbc:InvoiceTypeCode/@listVersionID must have one of the following values: [1.7]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listURI) or (@listURI='http://www.nltaxonomie.nl/ubl/2.0/NL/1.7/cl/gc/InvoiceTypeCode.gc')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listURI) or (@listURI='http://www.nltaxonomie.nl/ubl/2.0/NL/1.7/cl/gc/InvoiceTypeCode.gc')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cbc:InvoiceTypeCode/@listURI must have one of the following values: [http://www.nltaxonomie.nl/ubl/2.0/NL/1.7/cl/gc/InvoiceTypeCode.gc]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyName) or (@listAgencyName='Logius Gegevensbeheer NL-Overheid')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyName) or (@listAgencyName='Logius Gegevensbeheer NL-Overheid')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cbc:InvoiceTypeCode/@listAgencyName must have one of the following values: [Logius Gegevensbeheer NL-Overheid]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listSchemeURI) or (@listSchemeURI='urn:digi-inkoop:ubl:2.0:NL:1.7:gc:InvoiceTypeCode')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listSchemeURI) or (@listSchemeURI='urn:digi-inkoop:ubl:2.0:NL:1.7:gc:InvoiceTypeCode')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cbc:InvoiceTypeCode/@listSchemeURI must have one of the following values: [urn:digi-inkoop:ubl:2.0:NL:1.7:gc:InvoiceTypeCode]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/cbc:InvoiceTypeCode must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine"
                 priority="1002"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="index-of(//cac:InvoiceLine/cbc:ID, cbc:ID) &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="index-of(//cac:InvoiceLine/cbc:ID, cbc:ID) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>nl-cac:InvoiceLine/cbc:ID MOET verwijzen naar een bestaande cac:InvoiceLine/cbc:ID.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod"
                 priority="1001"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(cbc:DescriptionCode) or (cbc:DescriptionCode='I') or (cbc:DescriptionCode='D')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(cbc:DescriptionCode) or (cbc:DescriptionCode='I') or (cbc:DescriptionCode='D')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod/cbc:DescriptionCode must have one of the following values: [I, D]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod/cbc:DescriptionCode"
                 priority="1000"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod/cbc:DescriptionCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyID) or (@listAgencyID='88')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyID) or (@listAgencyID='88')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod/cbc:DescriptionCode/@listAgencyID must have one of the following values: [88]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listID) or (@listID='NL-1004')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listID) or (@listID='NL-1004')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod/cbc:DescriptionCode/@listID must have one of the following values: [NL-1004]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listURI) or (@listURI='http://www.nltaxonomie.nl/ubl/2.0/NL/1.7/cl/gc/InvoicePeriodDescriptionCode.gc')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listURI) or (@listURI='http://www.nltaxonomie.nl/ubl/2.0/NL/1.7/cl/gc/InvoicePeriodDescriptionCode.gc')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod/cbc:DescriptionCode/@listURI must have one of the following values: [http://www.nltaxonomie.nl/ubl/2.0/NL/1.7/cl/gc/InvoicePeriodDescriptionCode.gc]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listSchemeURI) or (@listSchemeURI='urn:digi-inkoop:ubl:2.0:NL:1.7:gc:InvoicePeriodDescriptionCode')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listSchemeURI) or (@listSchemeURI='urn:digi-inkoop:ubl:2.0:NL:1.7:gc:InvoicePeriodDescriptionCode')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod/cbc:DescriptionCode/@listSchemeURI must have one of the following values: [urn:digi-inkoop:ubl:2.0:NL:1.7:gc:InvoicePeriodDescriptionCode]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listVersionID) or (@listVersionID='1.7')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listVersionID) or (@listVersionID='1.7')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod/cbc:DescriptionCode/@listVersionID must have one of the following values: [1.7]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyName) or (@listAgencyName='Logius Gegevensbeheer NL-Overheid')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyName) or (@listAgencyName='Logius Gegevensbeheer NL-Overheid')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod/cbc:DescriptionCode/@listAgencyName must have one of the following values: [Logius Gegevensbeheer NL-Overheid]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listName) or (@listName='FactuurPeriodDescriptionCode')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listName) or (@listName='FactuurPeriodDescriptionCode')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod/cbc:DescriptionCode/@listName must have one of the following values: [FactuurPeriodDescriptionCode]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M8"/>
   <xsl:template match="@*|node()" priority="-2" mode="M8">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>
</xsl:stylesheet>