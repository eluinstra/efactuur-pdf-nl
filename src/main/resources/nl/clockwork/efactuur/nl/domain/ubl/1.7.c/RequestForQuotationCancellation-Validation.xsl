<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:schold="http://www.ascc.net/xml/schematron"
                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
                xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
                xmlns:doc="urn:oasis:names:specification:ubl:schema:xsd:RequestForQuotationCancellation-2"
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
                              title="Validations for RequestForQuotationCancellation Mapping; strict=false"
                              schemaVersion="">
         <xsl:comment>
            <xsl:value-of select="$archiveDirParameter"/>   
		 <xsl:value-of select="$archiveNameParameter"/>  
		 <xsl:value-of select="$fileNameParameter"/>  
		 <xsl:value-of select="$fileDirParameter"/>
         </xsl:comment>
         <svrl:ns-prefix-in-attribute-values uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
                                             prefix="cbc"/>
         <svrl:ns-prefix-in-attribute-values uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
                                             prefix="cac"/>
         <svrl:ns-prefix-in-attribute-values uri="urn:oasis:names:specification:ubl:schema:xsd:RequestForQuotationCancellation-2"
                                             prefix="doc"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">cardinality-redefines</xsl:attribute>
            <xsl:attribute name="name">cardinality-redefines</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M4"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">type-restrictions</xsl:attribute>
            <xsl:attribute name="name">type-restrictions</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M5"/>
      </svrl:schematron-output>
   </xsl:template>

   <!--SCHEMATRON PATTERNS-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Validations for RequestForQuotationCancellation Mapping; strict=false</svrl:text>

   <!--PATTERN cardinality-redefines-->


	<!--RULE -->
<xsl:template match="doc:RequestForQuotationCancellation/cac:DocumentReference"
                 priority="1013"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:RequestForQuotationCancellation/cac:DocumentReference"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:DocumentType) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:DocumentType) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:RequestForQuotationCancellation/cac:DocumentReference must contain cbc:DocumentType at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:RequestForQuotationCancellation/cac:DocumentReference/cac:Attachment"
                 priority="1012"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:RequestForQuotationCancellation/cac:DocumentReference/cac:Attachment"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:EmbeddedDocumentBinaryObject) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cbc:EmbeddedDocumentBinaryObject) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:RequestForQuotationCancellation/cac:DocumentReference/cac:Attachment must contain cbc:EmbeddedDocumentBinaryObject at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty"
                 priority="1011"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Party) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:Party) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty must contain cac:Party at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party"
                 priority="1010"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Contact) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:Contact) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party must contain cac:Contact at least 1 time(s)</svrl:text>
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
               <svrl:text>doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party must contain cac:PartyIdentification at least 1 and at most 3 time(s)</svrl:text>
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
               <svrl:text>doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party must contain cac:PartyName at least 1 and at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:Contact"
                 priority="1009"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:Contact"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:Name) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:Name) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:Contact must contain cbc:Name at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID"
                 priority="1008"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeAgencyName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@schemeAgencyName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address"
                 priority="1007"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Country) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:Country) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address must contain cac:Country at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country"
                 priority="1006"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:IdentificationCode) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cbc:IdentificationCode) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:RequestForQuotationCancellation/cac:SellerSupplierParty"
                 priority="1005"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:RequestForQuotationCancellation/cac:SellerSupplierParty"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Party) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:Party) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:RequestForQuotationCancellation/cac:SellerSupplierParty must contain cac:Party at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party"
                 priority="1004"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyIdentification) &lt;= 3"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cac:PartyIdentification) &lt;= 3">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party may contain cac:PartyIdentification at most 3 time(s)</svrl:text>
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
               <svrl:text>doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party may contain cac:PartyName at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:Contact"
                 priority="1003"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:Contact"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:Name) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:Name) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:Contact must contain cbc:Name at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID"
                 priority="1002"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@schemeAgencyName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@schemeAgencyName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:PostalAddress"
                 priority="1001"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:PostalAddress"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Country) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:Country) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:PostalAddress must contain cac:Country at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country"
                 priority="1000"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:IdentificationCode) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cbc:IdentificationCode) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
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
<xsl:template match="/" priority="1012" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="if(count(//cac:PartyIdentification/cbc:ID[@schemeAgencyName = 'Vest']) = 1) then (count(//cac:PartyIdentification/cbc:ID[@schemeAgencyName = 'KvK']) = 1) else ('true')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="if(count(//cac:PartyIdentification/cbc:ID[@schemeAgencyName = 'Vest']) = 1) then (count(//cac:PartyIdentification/cbc:ID[@schemeAgencyName = 'KvK']) = 1) else ('true')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Als Vestigingsnummer is opgegeven MOET Kamer van Koophandel nummer ook opgegeven worden.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:RequestForQuotationCancellation" priority="1011" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:RequestForQuotationCancellation"/>

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
         <xsl:when test="empty(cbc:CustomizationID) or (cbc:CustomizationID='1.7')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(cbc:CustomizationID) or (cbc:CustomizationID='1.7')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Bericht MOET gebaseerd zijn op versie 1.7 van de Nederlandse specificatie.</svrl:text>
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
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:RequestForQuotationCancellation/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject"
                 priority="1010"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:RequestForQuotationCancellation/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:RequestForQuotationCancellation/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:RequestForQuotationCancellation/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode"
                 priority="1009"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:RequestForQuotationCancellation/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:RequestForQuotationCancellation/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:RequestForQuotationCancellation/cac:DocumentReference/cbc:DocumentType"
                 priority="1008"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:RequestForQuotationCancellation/cac:DocumentReference/cbc:DocumentType"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> Indien de identificatie van een contract meegegeven wordt, moet hier 'Contract' opgegeven worden. Bij bijlagen in de vorm van specificaties moet hier 'Specificaties' opgegeven worden</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:Contact"
                 priority="1007"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:Contact"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="matches(cbc:Telefax, '^[-0-9]*$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="matches(cbc:Telefax, '^[-0-9]*$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="matches(cbc:Telephone, '^[-0-9]*$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="matches(cbc:Telephone, '^[-0-9]*$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:Contact/cbc:Name"
                 priority="1006"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:Contact/cbc:Name"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:Contact/cbc:Name must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID"
                 priority="1005"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID"/>

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
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode"
                 priority="1004"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:Contact"
                 priority="1003"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:Contact"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="matches(cbc:Telefax, '^[-0-9]*$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="matches(cbc:Telefax, '^[-0-9]*$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="matches(cbc:Telephone, '^[-0-9]*$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="matches(cbc:Telephone, '^[-0-9]*$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name"
                 priority="1002"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID"
                 priority="1001"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID must be filled</svrl:text>
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
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"
                 priority="1000"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M5"/>
   <xsl:template match="@*|node()" priority="-2" mode="M5">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>
</xsl:stylesheet>