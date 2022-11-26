<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:schold="http://www.ascc.net/xml/schematron"
                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
                xmlns:nl-cac="urn:digi-inkoop:ubl:2.0:NL:1.8:UBL-NL-CommonAggregateComponents-2"
                xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
                xmlns:doc="urn:digi-inkoop:ubl:2.0:NL:1.8:UBL-NL-Commitment-2"
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
                              title="Validations for Commitment Mapping; strict=false"
                              schemaVersion="">
         <xsl:comment>
            <xsl:value-of select="$archiveDirParameter"/>   
		 <xsl:value-of select="$archiveNameParameter"/>  
		 <xsl:value-of select="$fileNameParameter"/>  
		 <xsl:value-of select="$fileDirParameter"/>
         </xsl:comment>
         <svrl:ns-prefix-in-attribute-values uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
                                             prefix="cbc"/>
         <svrl:ns-prefix-in-attribute-values uri="urn:digi-inkoop:ubl:2.0:NL:1.8:UBL-NL-CommonAggregateComponents-2"
                                             prefix="nl-cac"/>
         <svrl:ns-prefix-in-attribute-values uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
                                             prefix="cac"/>
         <svrl:ns-prefix-in-attribute-values uri="urn:digi-inkoop:ubl:2.0:NL:1.8:UBL-NL-Commitment-2" prefix="doc"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">cardinality-redefines</xsl:attribute>
            <xsl:attribute name="name">cardinality-redefines</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M5"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">type-restrictions</xsl:attribute>
            <xsl:attribute name="name">type-restrictions</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M6"/>
      </svrl:schematron-output>
   </xsl:template>

   <!--SCHEMATRON PATTERNS-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Validations for Commitment Mapping; strict=false</svrl:text>

   <!--PATTERN cardinality-redefines-->


	<!--RULE -->
<xsl:template match="doc:Commitment/cac:AccountingCustomerParty" priority="1016" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Commitment/cac:AccountingCustomerParty"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Party) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:Party) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Commitment/cac:AccountingCustomerParty must contain cac:Party at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Commitment/cac:AccountingCustomerParty/cac:Party" priority="1015"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Commitment/cac:AccountingCustomerParty/cac:Party"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyIdentification) &gt;= 1 and count(cac:PartyIdentification) &lt;= 2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cac:PartyIdentification) &gt;= 1 and count(cac:PartyIdentification) &lt;= 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Commitment/cac:AccountingCustomerParty/cac:Party must contain cac:PartyIdentification at least 1 and at most 2 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyName) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:PartyName) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Commitment/cac:AccountingCustomerParty/cac:Party may contain cac:PartyName at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Commitment/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID"
                 priority="1014"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Commitment/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeAgencyID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@schemeAgencyID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Commitment/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyID at least 1 time(s)</svrl:text>
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
               <svrl:text>doc:Commitment/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Commitment/cac:DocumentReference/cac:Attachment" priority="1013"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Commitment/cac:DocumentReference/cac:Attachment"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:EmbeddedDocumentBinaryObject) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cbc:EmbeddedDocumentBinaryObject) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Commitment/cac:DocumentReference/cac:Attachment must contain cbc:EmbeddedDocumentBinaryObject at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Commitment/cac:SellerSupplierParty" priority="1012" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Commitment/cac:SellerSupplierParty"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Party) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:Party) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Commitment/cac:SellerSupplierParty must contain cac:Party at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Commitment/cac:SellerSupplierParty/cac:Party" priority="1011"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Commitment/cac:SellerSupplierParty/cac:Party"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyIdentification) &lt;= 3"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cac:PartyIdentification) &lt;= 3">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Commitment/cac:SellerSupplierParty/cac:Party may contain cac:PartyIdentification at most 3 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyName) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:PartyName) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Commitment/cac:SellerSupplierParty/cac:Party may contain cac:PartyName at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Commitment/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID"
                 priority="1010"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Commitment/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeAgencyID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@schemeAgencyID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Commitment/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyID at least 1 time(s)</svrl:text>
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
               <svrl:text>doc:Commitment/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Commitment/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme"
                 priority="1009"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Commitment/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:Name) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:Name) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Commitment/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme must contain cbc:Name at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Commitment/cbc:ActionCode" priority="1008" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Commitment/cbc:ActionCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Commitment/cbc:ActionCode must contain @listID at least 1 time(s)</svrl:text>
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
               <svrl:text>doc:Commitment/cbc:ActionCode must contain @listAgencyName at least 1 time(s)</svrl:text>
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
               <svrl:text>doc:Commitment/cbc:ActionCode must contain @listURI at least 1 time(s)</svrl:text>
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
               <svrl:text>doc:Commitment/cbc:ActionCode must contain @listVersionID at least 1 time(s)</svrl:text>
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
               <svrl:text>doc:Commitment/cbc:ActionCode must contain @listSchemeURI at least 1 time(s)</svrl:text>
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
               <svrl:text>doc:Commitment/cbc:ActionCode must contain @listAgencyID at least 1 time(s)</svrl:text>
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
               <svrl:text>doc:Commitment/cbc:ActionCode must contain @listName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Commitment/cbc:DocumentCurrencyCode" priority="1007" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Commitment/cbc:DocumentCurrencyCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@listAgencyID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@listAgencyID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Commitment/cbc:DocumentCurrencyCode must contain @listAgencyID at least 1 time(s)</svrl:text>
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
               <svrl:text>doc:Commitment/cbc:DocumentCurrencyCode must contain @listName at least 1 time(s)</svrl:text>
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
               <svrl:text>doc:Commitment/cbc:DocumentCurrencyCode must contain @listAgencyName at least 1 time(s)</svrl:text>
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
               <svrl:text>doc:Commitment/cbc:DocumentCurrencyCode must contain @listSchemeURI at least 1 time(s)</svrl:text>
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
               <svrl:text>doc:Commitment/cbc:DocumentCurrencyCode must contain @listID at least 1 time(s)</svrl:text>
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
               <svrl:text>doc:Commitment/cbc:DocumentCurrencyCode must contain @listVersionID at least 1 time(s)</svrl:text>
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
               <svrl:text>doc:Commitment/cbc:DocumentCurrencyCode must contain @listURI at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Delivery/cac:RequestedDeliveryPeriod"
                 priority="1006"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Delivery/cac:RequestedDeliveryPeriod"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:StartDate) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:StartDate) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Delivery/cac:RequestedDeliveryPeriod must contain cbc:StartDate at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Item"
                 priority="1005"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Item"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:CatalogueIndicator) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cbc:CatalogueIndicator) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Item must contain cbc:CatalogueIndicator at least 1 time(s)</svrl:text>
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
               <svrl:text>doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Item may contain cbc:Description at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme"
                 priority="1004"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:Name) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:Name) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme must contain cbc:Name at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Commitment/nl-cac:CommitmentLine/cac:SellerSupplierParty"
                 priority="1003"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Commitment/nl-cac:CommitmentLine/cac:SellerSupplierParty"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Party) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:Party) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Commitment/nl-cac:CommitmentLine/cac:SellerSupplierParty must contain cac:Party at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Commitment/nl-cac:CommitmentLine/cac:SellerSupplierParty/cac:Party"
                 priority="1002"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Commitment/nl-cac:CommitmentLine/cac:SellerSupplierParty/cac:Party"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyIdentification) &lt;= 3"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cac:PartyIdentification) &lt;= 3">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Commitment/nl-cac:CommitmentLine/cac:SellerSupplierParty/cac:Party may contain cac:PartyIdentification at most 3 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyName) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:PartyName) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Commitment/nl-cac:CommitmentLine/cac:SellerSupplierParty/cac:Party may contain cac:PartyName at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Commitment/nl-cac:CommitmentLine/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID"
                 priority="1001"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Commitment/nl-cac:CommitmentLine/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeAgencyID) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@schemeAgencyID) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Commitment/nl-cac:CommitmentLine/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyID at least 1 time(s)</svrl:text>
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
               <svrl:text>doc:Commitment/nl-cac:CommitmentLine/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Commitment/nl-cac:CommitmentLine/nl-cac:CommitmentLineReference"
                 priority="1000"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Commitment/nl-cac:CommitmentLine/nl-cac:CommitmentLineReference"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:DocumentReference) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cac:DocumentReference) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Commitment/nl-cac:CommitmentLine/nl-cac:CommitmentLineReference must contain cac:DocumentReference at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M5"/>
   <xsl:template match="@*|node()" priority="-2" mode="M5">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

   <!--PATTERN type-restrictions-->


	<!--RULE -->
<xsl:template match="doc:Commitment" priority="1015" mode="M6">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="doc:Commitment"/>

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
         <xsl:when test="( (count(cac:SellerSupplierParty) = 0) and (count(nl-cac:CommitmentLine/cac:SellerSupplierParty) = count(nl-cac:CommitmentLine))) or ( (count(cac:SellerSupplierParty) &gt; 0) and (count(nl-cac:CommitmentLine/cac:SellerSupplierParty) = 0))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="( (count(cac:SellerSupplierParty) = 0) and (count(nl-cac:CommitmentLine/cac:SellerSupplierParty) = count(nl-cac:CommitmentLine))) or ( (count(cac:SellerSupplierParty) &gt; 0) and (count(nl-cac:CommitmentLine/cac:SellerSupplierParty) = 0))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>SellerSupplierParty MOET OF op algemeen niveau OF voor alle regels worden opgegeven.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(cbc:ActionCode) or (cbc:ActionCode='R') or (cbc:ActionCode='V')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(cbc:ActionCode) or (cbc:ActionCode='R') or (cbc:ActionCode='V')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Commitment/cbc:ActionCode must have one of the following values: [R, V]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Commitment/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID"
                 priority="1014"
                 mode="M6">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Commitment/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID"/>

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
         <xsl:when test="empty(@schemeAgencyName) or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@schemeAgencyName) or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Uitgevende organisatie van de PartijIdentificatie MOET geïdentificeerd worden door een code uit de lijst: BTW, Fi, BSN, OIN, XXX.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Commitment/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject"
                 priority="1013"
                 mode="M6">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Commitment/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Commitment/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Commitment/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode"
                 priority="1012"
                 mode="M6">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Commitment/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Commitment/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Commitment/cac:SellerSupplierParty" priority="1011" mode="M6">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Commitment/cac:SellerSupplierParty"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(//doc:Commitment/cbc:ActionCode != 'V') or (cac:Party/cac:PartyName/cbc:Name != '')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(//doc:Commitment/cbc:ActionCode != 'V') or (cac:Party/cac:PartyName/cbc:Name != '')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Naam van leverancier MOET worden opgegeven indien berichttype 'V' is.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Commitment/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID"
                 priority="1010"
                 mode="M6">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Commitment/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID"/>

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
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Commitment/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme"
                 priority="1009"
                 mode="M6">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Commitment/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(cbc:Name) or (cbc:Name='BTW') or (cbc:Name='Accijns') or (cbc:Name='Toeslag') or (cbc:Name='Overige')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(cbc:Name) or (cbc:Name='BTW') or (cbc:Name='Accijns') or (cbc:Name='Toeslag') or (cbc:Name='Overige')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Commitment/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:Name must have one of the following values: [BTW, Accijns, Toeslag, Overige]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Commitment/cbc:ActionCode" priority="1008" mode="M6">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Commitment/cbc:ActionCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listID) or (@listID='NL-1006')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listID) or (@listID='NL-1006')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Commitment/cbc:ActionCode/@listID must have one of the following values: [NL-1006]</svrl:text>
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
               <svrl:text>doc:Commitment/cbc:ActionCode/@listAgencyName must have one of the following values: [Logius Gegevensbeheer NL-Overheid]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listURI) or (@listURI='http://www.nltaxonomie.nl/ubl/2.0/NL/1.9/cl/gc/NL-ActionCode-1.9.gc')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listURI) or (@listURI='http://www.nltaxonomie.nl/ubl/2.0/NL/1.9/cl/gc/NL-ActionCode-1.9.gc')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Commitment/cbc:ActionCode/@listURI must have one of the following values: [http://www.nltaxonomie.nl/ubl/2.0/NL/1.9/cl/gc/NL-ActionCode-1.9.gc]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listVersionID) or (@listVersionID='1.9')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listVersionID) or (@listVersionID='1.9')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Commitment/cbc:ActionCode/@listVersionID must have one of the following values: [1.9]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listSchemeURI) or (@listSchemeURI='urn:digi-inkoop:ubl:2.0:NL:1.9:gc:ActionCode')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listSchemeURI) or (@listSchemeURI='urn:digi-inkoop:ubl:2.0:NL:1.9:gc:ActionCode')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Commitment/cbc:ActionCode/@listSchemeURI must have one of the following values: [urn:digi-inkoop:ubl:2.0:NL:1.9:gc:ActionCode]</svrl:text>
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
               <svrl:text>doc:Commitment/cbc:ActionCode/@listAgencyID must have one of the following values: [88]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listName) or (@listName='ActieCode')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listName) or (@listName='ActieCode')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Commitment/cbc:ActionCode/@listName must have one of the following values: [ActieCode]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Commitment/cbc:DocumentCurrencyCode" priority="1007" mode="M6">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Commitment/cbc:DocumentCurrencyCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listAgencyID) or (@listAgencyID='6')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listAgencyID) or (@listAgencyID='6')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Commitment/cbc:DocumentCurrencyCode/@listAgencyID must have one of the following values: [6]</svrl:text>
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
               <svrl:text>doc:Commitment/cbc:DocumentCurrencyCode/@listName must have one of the following values: [Currency]</svrl:text>
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
               <svrl:text>doc:Commitment/cbc:DocumentCurrencyCode/@listAgencyName must have one of the following values: [United Nations Economic Commission for Europe]</svrl:text>
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
               <svrl:text>doc:Commitment/cbc:DocumentCurrencyCode/@listSchemeURI must have one of the following values: [urn:un:unece:uncefact:codelist:specification:54217]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@listID) or (@listID='ISO 4217 Alpha')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@listID) or (@listID='ISO 4217 Alpha')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Commitment/cbc:DocumentCurrencyCode/@listID must have one of the following values: [ISO 4217 Alpha]</svrl:text>
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
               <svrl:text>doc:Commitment/cbc:DocumentCurrencyCode/@listVersionID must have one of the following values: [2001]</svrl:text>
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
               <svrl:text>doc:Commitment/cbc:DocumentCurrencyCode/@listURI must have one of the following values: [http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/cefact/CurrencyCode-2.0.gc]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Commitment/nl-cac:CommitmentLine/cac:LineItem" priority="1006"
                 mode="M6">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Commitment/nl-cac:CommitmentLine/cac:LineItem"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="matches(cbc:AccountingCost, '^[^@]*[@][^@]*$|^$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="matches(cbc:AccountingCost, '^[^@]*[@][^@]*$|^$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cbc:AccountingCost element MOET exact 1 @-teken bevatten als het niet leeg is!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Item"
                 priority="1005"
                 mode="M6">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Item"/>

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
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme"
                 priority="1004"
                 mode="M6">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(cbc:Name) or (cbc:Name='BTW') or (cbc:Name='Accijns') or (cbc:Name='Toeslag') or (cbc:Name='Overige')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(cbc:Name) or (cbc:Name='BTW') or (cbc:Name='Accijns') or (cbc:Name='Toeslag') or (cbc:Name='Overige')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme/cbc:Name must have one of the following values: [BTW, Accijns, Toeslag, Overige]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Item/cbc:Description"
                 priority="1003"
                 mode="M6">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Item/cbc:Description"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Item/cbc:Description must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cbc:Quantity/@unitCode"
                 priority="1002"
                 mode="M6">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cbc:Quantity/@unitCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cbc:Quantity/@unitCode must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Commitment/nl-cac:CommitmentLine/cac:SellerSupplierParty"
                 priority="1001"
                 mode="M6">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Commitment/nl-cac:CommitmentLine/cac:SellerSupplierParty"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(//doc:Commitment/cbc:ActionCode != 'V') or (cac:Party/cac:PartyName/cbc:Name != '')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(//doc:Commitment/cbc:ActionCode != 'V') or (cac:Party/cac:PartyName/cbc:Name != '')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Naam van leverancier MOET worden opgegeven indien berichttype 'V' is.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:Commitment/nl-cac:CommitmentLine/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID"
                 priority="1000"
                 mode="M6">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:Commitment/nl-cac:CommitmentLine/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID"/>

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
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M6"/>
   <xsl:template match="@*|node()" priority="-2" mode="M6">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>
</xsl:stylesheet>