<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:schold="http://www.ascc.net/xml/schematron"
                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:ns1="http://www.openapplications.org/oagis"
                xmlns:ns2="http://ns.hr-xml.org/2007-04-15"
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
                              title="Validations for Invoice Mapping"
                              schemaVersion="">
         <xsl:comment>
            <xsl:value-of select="$archiveDirParameter"/>   
		 <xsl:value-of select="$archiveNameParameter"/>  
		 <xsl:value-of select="$fileNameParameter"/>  
		 <xsl:value-of select="$fileDirParameter"/>
         </xsl:comment>
         <svrl:ns-prefix-in-attribute-values uri="http://www.openapplications.org/oagis" prefix="ns1"/>
         <svrl:ns-prefix-in-attribute-values uri="http://ns.hr-xml.org/2007-04-15" prefix="ns2"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">prohibitions</xsl:attribute>
            <xsl:attribute name="name">prohibitions</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M3"/>
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
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">custom-rules</xsl:attribute>
            <xsl:attribute name="name">custom-rules</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M6"/>
      </svrl:schematron-output>
   </xsl:template>

   <!--SCHEMATRON PATTERNS-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Validations for Invoice Mapping</svrl:text>

   <!--PATTERN prohibitions-->


	<!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Header/ns1:Parties/ns1:CustomerParty/ns1:Contacts/ns1:Contact/ns1:Person/ns1:PersonName/ns1:Salutation"
                 priority="1001"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:CustomerParty/ns1:Contacts/ns1:Contact/ns1:Person/ns1:PersonName/ns1:Salutation"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@lang)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/CustomerParty/Contacts/Contact/Person/PersonName/Salutation may not have attribute lang</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Line/ns1:Line" priority="1000" mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Line/ns1:Line"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(ns1:Line)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(ns1:Line)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Line/Line may not contain element Line</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M3"/>
   <xsl:template match="@*|node()" priority="-2" mode="M3">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

   <!--PATTERN cardinality-redefines-->


	<!--RULE -->
<xsl:template match="ns1:Invoice" priority="1039" mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="ns1:Invoice"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:Header) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:Header) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice must contain Header at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Header" priority="1038" mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="ns1:Invoice/ns1:Header"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:DocumentIds) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:DocumentIds) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header must contain DocumentIds at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:DocumentDateTime) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(ns1:DocumentDateTime) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header must contain DocumentDateTime at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:Reason) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:Reason) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header may contain Reason at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:UserArea) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:UserArea) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header must contain UserArea at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Header/ns1:DocumentIds" priority="1037" mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Header/ns1:DocumentIds"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:DocumentId) &gt;= 1 and count(ns1:DocumentId) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(ns1:DocumentId) &gt;= 1 and count(ns1:DocumentId) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/DocumentIds must contain DocumentId at least 1 and at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Header/ns1:DocumentIds/ns1:DocumentId" priority="1036"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Header/ns1:DocumentIds/ns1:DocumentId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:Id) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:Id) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/DocumentIds/DocumentId must contain Id at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Header/ns1:Parties" priority="1035" mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Header/ns1:Parties"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:RemitToParty) &gt;= 1 and count(ns1:RemitToParty) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(ns1:RemitToParty) &gt;= 1 and count(ns1:RemitToParty) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties must contain RemitToParty at least 1 and at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:CustomerParty) &gt;= 1 and count(ns1:CustomerParty) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(ns1:CustomerParty) &gt;= 1 and count(ns1:CustomerParty) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties must contain CustomerParty at least 1 and at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:BillToParty) &gt;= 1 and count(ns1:BillToParty) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(ns1:BillToParty) &gt;= 1 and count(ns1:BillToParty) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties must contain BillToParty at least 1 and at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:SupplierParty) &gt;= 1 and count(ns1:SupplierParty) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(ns1:SupplierParty) &gt;= 1 and count(ns1:SupplierParty) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties must contain SupplierParty at least 1 and at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Header/ns1:Parties/ns1:RemitToParty" priority="1034"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:RemitToParty"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:PartyId) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:PartyId) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/RemitToParty must contain PartyId at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:Name) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:Name) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/RemitToParty must contain Name at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:Addresses) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:Addresses) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/RemitToParty must contain Addresses at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Header/ns1:Parties/ns1:RemitToParty/ns1:PartyId"
                 priority="1033"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:RemitToParty/ns1:PartyId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:Id) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:Id) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/RemitToParty/PartyId must contain Id at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Header/ns1:Parties/ns1:RemitToParty/ns1:Addresses"
                 priority="1032"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:RemitToParty/ns1:Addresses"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:PrimaryAddress) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:PrimaryAddress) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/RemitToParty/Addresses must contain PrimaryAddress at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Header/ns1:Parties/ns1:RemitToParty/ns1:Addresses/ns1:PrimaryAddress"
                 priority="1031"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:RemitToParty/ns1:Addresses/ns1:PrimaryAddress"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:AddressLine) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:AddressLine) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/RemitToParty/Addresses/PrimaryAddress may contain AddressLine at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Header/ns1:Parties/ns1:RemitToParty/ns1:Contacts/ns1:Contact"
                 priority="1030"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:RemitToParty/ns1:Contacts/ns1:Contact"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:Telephone) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:Telephone) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/RemitToParty/Contacts/Contact may contain Telephone at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:Description) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:Description) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/RemitToParty/Contacts/Contact may contain Description at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Header/ns1:Parties/ns1:RemitToParty/ns1:Contacts/ns1:Contact/ns1:Person/ns1:PersonName"
                 priority="1029"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:RemitToParty/ns1:Contacts/ns1:Contact/ns1:Person/ns1:PersonName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:Salutation) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:Salutation) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/RemitToParty/Contacts/Contact/Person/PersonName may contain Salutation at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:GivenName) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:GivenName) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/RemitToParty/Contacts/Contact/Person/PersonName may contain GivenName at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:FamilyName) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:FamilyName) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/RemitToParty/Contacts/Contact/Person/PersonName may contain FamilyName at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Header/ns1:Parties/ns1:CustomerParty" priority="1028"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:CustomerParty"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:PartyId) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:PartyId) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/CustomerParty must contain PartyId at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:Name) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:Name) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/CustomerParty must contain Name at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:Addresses) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:Addresses) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/CustomerParty must contain Addresses at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Header/ns1:Parties/ns1:CustomerParty/ns1:PartyId"
                 priority="1027"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:CustomerParty/ns1:PartyId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:Id) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:Id) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/CustomerParty/PartyId must contain Id at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Header/ns1:Parties/ns1:CustomerParty/ns1:Addresses"
                 priority="1026"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:CustomerParty/ns1:Addresses"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:PrimaryAddress) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:PrimaryAddress) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/CustomerParty/Addresses must contain PrimaryAddress at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Header/ns1:Parties/ns1:CustomerParty/ns1:Addresses/ns1:PrimaryAddress"
                 priority="1025"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:CustomerParty/ns1:Addresses/ns1:PrimaryAddress"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:AddressLine) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:AddressLine) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/CustomerParty/Addresses/PrimaryAddress may contain AddressLine at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Header/ns1:Parties/ns1:CustomerParty/ns1:Contacts/ns1:Contact"
                 priority="1024"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:CustomerParty/ns1:Contacts/ns1:Contact"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:Description) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:Description) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/CustomerParty/Contacts/Contact may contain Description at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Header/ns1:Parties/ns1:CustomerParty/ns1:Contacts/ns1:Contact/ns1:Person/ns1:PersonName"
                 priority="1023"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:CustomerParty/ns1:Contacts/ns1:Contact/ns1:Person/ns1:PersonName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:Salutation) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:Salutation) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/CustomerParty/Contacts/Contact/Person/PersonName may contain Salutation at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:GivenName) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:GivenName) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/CustomerParty/Contacts/Contact/Person/PersonName may contain GivenName at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:FamilyName) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:FamilyName) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/CustomerParty/Contacts/Contact/Person/PersonName may contain FamilyName at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Header/ns1:Parties/ns1:BillToParty" priority="1022"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:BillToParty"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:PartyId) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:PartyId) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/BillToParty must contain PartyId at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:Name) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:Name) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/BillToParty must contain Name at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:Addresses) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:Addresses) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/BillToParty must contain Addresses at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Header/ns1:Parties/ns1:BillToParty/ns1:PartyId"
                 priority="1021"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:BillToParty/ns1:PartyId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:Id) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:Id) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/BillToParty/PartyId must contain Id at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Header/ns1:Parties/ns1:BillToParty/ns1:Contacts/ns1:Contact"
                 priority="1020"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:BillToParty/ns1:Contacts/ns1:Contact"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:Description) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:Description) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/BillToParty/Contacts/Contact may contain Description at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Header/ns1:Parties/ns1:BillToParty/ns1:Contacts/ns1:Contact/ns1:Person/ns1:PersonName"
                 priority="1019"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:BillToParty/ns1:Contacts/ns1:Contact/ns1:Person/ns1:PersonName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:Salutation) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:Salutation) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/BillToParty/Contacts/Contact/Person/PersonName may contain Salutation at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:GivenName) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:GivenName) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/BillToParty/Contacts/Contact/Person/PersonName may contain GivenName at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:FamilyName) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:FamilyName) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/BillToParty/Contacts/Contact/Person/PersonName may contain FamilyName at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Header/ns1:Parties/ns1:SupplierParty" priority="1018"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:SupplierParty"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:PartyId) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:PartyId) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/SupplierParty must contain PartyId at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:Name) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:Name) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/SupplierParty must contain Name at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:Addresses) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:Addresses) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/SupplierParty must contain Addresses at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Header/ns1:Parties/ns1:SupplierParty/ns1:PartyId"
                 priority="1017"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:SupplierParty/ns1:PartyId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:Id) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:Id) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/SupplierParty/PartyId must contain Id at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Header/ns1:Parties/ns1:SupplierParty/ns1:Addresses"
                 priority="1016"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:SupplierParty/ns1:Addresses"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:PrimaryAddress) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:PrimaryAddress) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/SupplierParty/Addresses must contain PrimaryAddress at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Header/ns1:Parties/ns1:SupplierParty/ns1:Addresses/ns1:PrimaryAddress"
                 priority="1015"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:SupplierParty/ns1:Addresses/ns1:PrimaryAddress"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:AddressLine) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:AddressLine) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/SupplierParty/Addresses/PrimaryAddress may contain AddressLine at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Header/ns1:Parties/ns1:SupplierParty/ns1:Contacts/ns1:Contact"
                 priority="1014"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:SupplierParty/ns1:Contacts/ns1:Contact"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:Telephone) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:Telephone) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/SupplierParty/Contacts/Contact may contain Telephone at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:Description) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:Description) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/SupplierParty/Contacts/Contact may contain Description at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Header/ns1:Parties/ns1:SupplierParty/ns1:Contacts/ns1:Contact/ns1:Person/ns1:PersonName"
                 priority="1013"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:SupplierParty/ns1:Contacts/ns1:Contact/ns1:Person/ns1:PersonName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:Salutation) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:Salutation) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/SupplierParty/Contacts/Contact/Person/PersonName may contain Salutation at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:GivenName) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:GivenName) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/SupplierParty/Contacts/Contact/Person/PersonName may contain GivenName at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:FamilyName) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:FamilyName) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Parties/SupplierParty/Contacts/Contact/Person/PersonName may contain FamilyName at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Header/ns1:UserArea" priority="1012" mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Header/ns1:UserArea"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns2:StaffingAdditionalData) &gt;= 1 and count(ns2:StaffingAdditionalData) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(ns2:StaffingAdditionalData) &gt;= 1 and count(ns2:StaffingAdditionalData) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/UserArea must contain StaffingAdditionalData at least 1 and at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns2:StaffingOrganization) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(ns2:StaffingOrganization) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/UserArea may contain StaffingOrganization at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns2:StaffingOrganizationNL) &gt;= 1 and count(ns2:StaffingOrganizationNL) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(ns2:StaffingOrganizationNL) &gt;= 1 and count(ns2:StaffingOrganizationNL) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/UserArea must contain StaffingOrganizationNL at least 1 and at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Header/ns1:UserArea/ns2:StaffingAdditionalData/ns2:CustomerReportingRequirements"
                 priority="1011"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Header/ns1:UserArea/ns2:StaffingAdditionalData/ns2:CustomerReportingRequirements"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns2:AdditionalRequirement) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(ns2:AdditionalRequirement) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/UserArea/StaffingAdditionalData/CustomerReportingRequirements must contain AdditionalRequirement at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Header/ns1:UserArea/ns2:StaffingAdditionalData/ns2:CustomerReportingRequirements/ns2:AdditionalRequirement"
                 priority="1010"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Header/ns1:UserArea/ns2:StaffingAdditionalData/ns2:CustomerReportingRequirements/ns2:AdditionalRequirement"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@requirementTitle) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@requirementTitle) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/UserArea/StaffingAdditionalData/CustomerReportingRequirements/AdditionalRequirement must contain requirementTitle at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Header/ns1:UserArea/ns2:StaffingAdditionalData/ns2:ReferenceInformation"
                 priority="1009"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Header/ns1:UserArea/ns2:StaffingAdditionalData/ns2:ReferenceInformation"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns2:StaffingCustomerOrgUnitId) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(ns2:StaffingCustomerOrgUnitId) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/UserArea/StaffingAdditionalData/ReferenceInformation may contain StaffingCustomerOrgUnitId at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Header/ns1:UserArea/ns2:StaffingAdditionalData/ns2:ReferenceInformation/ns2:StaffingCustomerOrgUnitId"
                 priority="1008"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Header/ns1:UserArea/ns2:StaffingAdditionalData/ns2:ReferenceInformation/ns2:StaffingCustomerOrgUnitId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns2:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns2:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/UserArea/StaffingAdditionalData/ReferenceInformation/StaffingCustomerOrgUnitId may contain IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Header/ns1:UserArea/ns2:StaffingOrganization"
                 priority="1007"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Header/ns1:UserArea/ns2:StaffingOrganization"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns2:Organization) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns2:Organization) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/UserArea/StaffingOrganization may contain Organization at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns2:PaymentInfo) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns2:PaymentInfo) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/UserArea/StaffingOrganization may contain PaymentInfo at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Header/ns1:UserArea/ns2:StaffingOrganizationNL"
                 priority="1006"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Header/ns1:UserArea/ns2:StaffingOrganizationNL"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns2:ChamberofCommerceReference) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(ns2:ChamberofCommerceReference) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/UserArea/StaffingOrganizationNL must contain ChamberofCommerceReference at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Line" priority="1005" mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="ns1:Invoice/ns1:Line"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(count(ns1:Line/ns1:Price) &gt;= 1 and count(ns1:Price) = 0) or (count(ns1:Price) &gt;= 1 and count(ns1:Line/ns1:Price) = 0) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(ns1:Line/ns1:Price) &gt;= 1 and count(ns1:Price) = 0) or (count(ns1:Price) &gt;= 1 and count(ns1:Line/ns1:Price) = 0)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice must contain Price either on Invoice/Line level or on all Invoice/Line/Line levels.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Line/ns1:Charges" priority="1004" mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Line/ns1:Charges"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(count(../ns1:Line/ns1:Charges/ns1:TotalCharge) &gt;= 1 and count(ns1:TotalCharge) = 0) or (count(ns1:TotalCharge) &gt;= 1 and count(../ns1:Line/ns1:Charges/ns1:TotalCharge) = 0) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(../ns1:Line/ns1:Charges/ns1:TotalCharge) &gt;= 1 and count(ns1:TotalCharge) = 0) or (count(ns1:TotalCharge) &gt;= 1 and count(../ns1:Line/ns1:Charges/ns1:TotalCharge) = 0)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice must contain TotalCharge either on Invoice/Line/Charges level or on all Invoice/Line/Line/Charges levels.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Line/ns1:Charges/ns1:Charge" priority="1003" mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Line/ns1:Charges/ns1:Charge"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:Description) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:Description) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Line/Charges/Charge may contain Description at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Line/ns1:Line/ns1:Charges/ns1:Charge" priority="1002"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Line/ns1:Line/ns1:Charges/ns1:Charge"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:Description) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:Description) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Line/Line/Charges/Charge may contain Description at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Line/ns1:UserArea" priority="1001" mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Line/ns1:UserArea"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns2:StaffingAdditionalData) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(ns2:StaffingAdditionalData) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Line/UserArea may contain StaffingAdditionalData at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Line/ns1:Line/ns1:UserArea" priority="1000" mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Line/ns1:Line/ns1:UserArea"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns2:StaffingAdditionalData) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(ns2:StaffingAdditionalData) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Line/Line/UserArea may contain StaffingAdditionalData at most 1 time(s)</svrl:text>
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
<xsl:template match="ns1:Invoice/ns1:Header" priority="1003" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="ns1:Invoice/ns1:Header"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(ns1:ReasonCode) or (ns1:ReasonCode='Services') or (ns1:ReasonCode='Hours') or (ns1:ReasonCode='Combination') or (ns1:ReasonCode='services') or (ns1:ReasonCode='hours') or (ns1:ReasonCode='combination')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(ns1:ReasonCode) or (ns1:ReasonCode='Services') or (ns1:ReasonCode='Hours') or (ns1:ReasonCode='Combination') or (ns1:ReasonCode='services') or (ns1:ReasonCode='hours') or (ns1:ReasonCode='combination')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/ReasonCode may only have (one of) the following value(s): Services, Hours, Combination, services, hours, combination</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(ns1:Type) or (ns1:Type='Debit') or (ns1:Type='Credit') or (ns1:Type='Both')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(ns1:Type) or (ns1:Type='Debit') or (ns1:Type='Credit') or (ns1:Type='Both')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Type may only have (one of) the following value(s): Debit, Credit, Both</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(ns1:Reason) or (ns1:Reason='Regular') or (ns1:Reason='Pro Forma') or (ns1:Reason='Self-Billed') or (ns1:Reason='regular') or (ns1:Reason='pro forma') or (ns1:Reason='self-billed')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(ns1:Reason) or (ns1:Reason='Regular') or (ns1:Reason='Pro Forma') or (ns1:Reason='Self-Billed') or (ns1:Reason='regular') or (ns1:Reason='pro forma') or (ns1:Reason='self-billed')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/Reason may only have (one of) the following value(s): Regular, Pro Forma, Self-Billed, regular, pro forma, self-billed</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Header/ns1:UserArea/ns2:StaffingAdditionalData/ns2:CustomerReportingRequirements"
                 priority="1002"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Header/ns1:UserArea/ns2:StaffingAdditionalData/ns2:CustomerReportingRequirements"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(ns2:AdditionalRequirement) or (ns2:AdditionalRequirement='1.6')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(ns2:AdditionalRequirement) or (ns2:AdditionalRequirement='1.6')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/UserArea/StaffingAdditionalData/CustomerReportingRequirements/AdditionalRequirement may only have (one of) the following value(s): 1.6</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Header/ns1:UserArea/ns2:StaffingAdditionalData/ns2:CustomerReportingRequirements/ns2:AdditionalRequirement"
                 priority="1001"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Header/ns1:UserArea/ns2:StaffingAdditionalData/ns2:CustomerReportingRequirements/ns2:AdditionalRequirement"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@requirementTitle) or (@requirementTitle='VersionId')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@requirementTitle) or (@requirementTitle='VersionId')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/UserArea/StaffingAdditionalData/CustomerReportingRequirements/AdditionalRequirement/@requirementTitle may only have (one of) the following value(s): VersionId</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Header/ns1:UserArea/ns2:StaffingOrganization/ns2:PaymentInfo/ns2:BankAccountInfo/ns2:BankInfoByJurisdiction"
                 priority="1000"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Header/ns1:UserArea/ns2:StaffingOrganization/ns2:PaymentInfo/ns2:BankAccountInfo/ns2:BankInfoByJurisdiction"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@bankJurisdiction) or (@bankJurisdiction='NL')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@bankJurisdiction) or (@bankJurisdiction='NL')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/UserArea/StaffingOrganization/PaymentInfo/BankAccountInfo/BankInfoByJurisdiction/@bankJurisdiction may only have (one of) the following value(s): NL</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(ns2:BankWindow) or (ns2:BankWindow='')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(ns2:BankWindow) or (ns2:BankWindow='')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/UserArea/StaffingOrganization/PaymentInfo/BankAccountInfo/BankInfoByJurisdiction/BankWindow may only have (one of) the following value(s): [Empty]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(ns2:BankAccountKey) or (ns2:BankAccountKey='')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(ns2:BankAccountKey) or (ns2:BankAccountKey='')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Header/UserArea/StaffingOrganization/PaymentInfo/BankAccountInfo/BankInfoByJurisdiction/BankAccountKey may only have (one of) the following value(s): [Empty]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M5"/>
   <xsl:template match="@*|node()" priority="-2" mode="M5">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

   <!--PATTERN custom-rules-->


	<!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Line" priority="1002" mode="M6">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="ns1:Invoice/ns1:Line"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(                (count(ns1:Price) = 0) and                (count(ns1:Line/ns1:Price) = count(ns1:Line))               )               or               (                (count(ns1:Price) &gt; 0) and                (count(ns1:Line/ns1:Price) = 0)               )"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="( (count(ns1:Price) = 0) and (count(ns1:Line/ns1:Price) = count(ns1:Line)) ) or ( (count(ns1:Price) &gt; 0) and (count(ns1:Line/ns1:Price) = 0) )">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Price MUST be given EITHER for Line OR for ALL Line/Line elements.
	  </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Line/ns1:Tax/ns1:PercentQuantity" priority="1001"
                 mode="M6">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Line/ns1:Tax/ns1:PercentQuantity"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(index-of(../../../ns1:Header/ns1:Tax/ns1:PercentQuantity, text()))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(index-of(../../../ns1:Header/ns1:Tax/ns1:PercentQuantity, text()))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Line/Tax/PercentQuantity must be available on Header level: <xsl:text/>
                  <xsl:value-of select="text()"/>
                  <xsl:text/>.
	  </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:Invoice/ns1:Line/ns1:Line/ns1:Tax/ns1:PercentQuantity"
                 priority="1000"
                 mode="M6">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:Invoice/ns1:Line/ns1:Line/ns1:Tax/ns1:PercentQuantity"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(index-of(../../../ns1:Tax/ns1:PercentQuantity, text()))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(index-of(../../../ns1:Tax/ns1:PercentQuantity, text()))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Line/Line/Tax/PercentQuantity must be available on Line level above: <xsl:text/>
                  <xsl:value-of select="text()"/>
                  <xsl:text/>.
	  </svrl:text>
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