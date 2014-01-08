<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:schold="http://www.ascc.net/xml/schematron"
                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:oagis="http://www.openapplications.org/oagis"
                xmlns:hrxml="http://ns.hr-xml.org/2007-04-15"
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
         <svrl:ns-prefix-in-attribute-values uri="http://www.openapplications.org/oagis" prefix="oagis"/>
         <svrl:ns-prefix-in-attribute-values uri="http://ns.hr-xml.org/2007-04-15" prefix="hrxml"/>
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
      </svrl:schematron-output>
   </xsl:template>

   <!--SCHEMATRON PATTERNS-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Validations for Invoice Mapping; strict=false</svrl:text>

   <!--PATTERN prohibitions-->


	<!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:Salutation"
                 priority="1008"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:Salutation"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@lang)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:Salutation may not contain @lang</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"
                 priority="1007"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PurchaseOrderLineItem)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:PurchaseOrderLineItem)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:PurchaseOrderLineItem</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line" priority="1006" mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Line)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(oagis:Line)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:Line</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Resource"
                 priority="1005"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Resource"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@type)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@type)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Resource may not contain @type</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime"
                 priority="1004"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Expense)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:Expense)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:Expense</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:TimeEvent)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:TimeEvent)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:TimeEvent</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval"
                 priority="1003"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@dayAssignment)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@dayAssignment)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval may not contain @dayAssignment</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Resource"
                 priority="1002"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Resource"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@type)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@type)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Resource may not contain @type</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime"
                 priority="1001"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Expense)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:Expense)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:Expense</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:TimeEvent)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:TimeEvent)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:TimeEvent</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval"
                 priority="1000"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@dayAssignment)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@dayAssignment)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval may not contain @dayAssignment</svrl:text>
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
<xsl:template match="oagis:Invoice" priority="1083" mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="oagis:Invoice"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Header) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:Header) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice must contain oagis:Header at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header" priority="1082" mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="oagis:Invoice/oagis:Header"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:DocumentDateTime) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(oagis:DocumentDateTime) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header must contain oagis:DocumentDateTime at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:DocumentIds) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:DocumentIds) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header must contain oagis:DocumentIds at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Parties) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:Parties) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header must contain oagis:Parties at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Reason) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:Reason) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header may contain oagis:Reason at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:UserArea) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:UserArea) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header must contain oagis:UserArea at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:DocumentIds" priority="1081" mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Header/oagis:DocumentIds"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:DocumentId) &gt;= 1 and count(oagis:DocumentId) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(oagis:DocumentId) &gt;= 1 and count(oagis:DocumentId) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:DocumentIds must contain oagis:DocumentId at least 1 and at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:DocumentIds/oagis:DocumentId"
                 priority="1080"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Header/oagis:DocumentIds/oagis:DocumentId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Id) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:Id) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:DocumentIds/oagis:DocumentId must contain oagis:Id at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties" priority="1079" mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Header/oagis:Parties"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:BillToParty) &gt;= 1 and count(oagis:BillToParty) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(oagis:BillToParty) &gt;= 1 and count(oagis:BillToParty) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties must contain oagis:BillToParty at least 1 and at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:CustomerParty) &gt;= 1 and count(oagis:CustomerParty) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(oagis:CustomerParty) &gt;= 1 and count(oagis:CustomerParty) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties must contain oagis:CustomerParty at least 1 and at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:RemitToParty) &gt;= 1 and count(oagis:RemitToParty) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(oagis:RemitToParty) &gt;= 1 and count(oagis:RemitToParty) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties must contain oagis:RemitToParty at least 1 and at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:SupplierParty) &gt;= 1 and count(oagis:SupplierParty) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(oagis:SupplierParty) &gt;= 1 and count(oagis:SupplierParty) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties must contain oagis:SupplierParty at least 1 and at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty"
                 priority="1078"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Addresses) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:Addresses) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty must contain oagis:Addresses at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Name) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:Name) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty must contain oagis:Name at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:PartyId) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:PartyId) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty must contain oagis:PartyId at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact"
                 priority="1077"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Description) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:Description) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact may contain oagis:Description at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName"
                 priority="1076"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:FamilyName) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:FamilyName) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:FamilyName at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:GivenName) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:GivenName) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:GivenName at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Salutation) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:Salutation) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:Salutation at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:PartyId"
                 priority="1075"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:PartyId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Id) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:Id) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:PartyId must contain oagis:Id at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty"
                 priority="1074"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Addresses) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:Addresses) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty must contain oagis:Addresses at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Name) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:Name) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty must contain oagis:Name at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:PartyId) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:PartyId) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty must contain oagis:PartyId at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses"
                 priority="1073"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:PrimaryAddress) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(oagis:PrimaryAddress) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses must contain oagis:PrimaryAddress at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress"
                 priority="1072"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:AddressLine) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:AddressLine) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:AddressLine at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact"
                 priority="1071"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Description) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:Description) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact may contain oagis:Description at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName"
                 priority="1070"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:FamilyName) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:FamilyName) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:FamilyName at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:GivenName) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:GivenName) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:GivenName at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Salutation) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:Salutation) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:Salutation at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:PartyId"
                 priority="1069"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:PartyId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Id) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:Id) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:PartyId must contain oagis:Id at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty"
                 priority="1068"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Addresses) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:Addresses) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty must contain oagis:Addresses at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Name) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:Name) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty must contain oagis:Name at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:PartyId) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:PartyId) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty must contain oagis:PartyId at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses"
                 priority="1067"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:PrimaryAddress) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(oagis:PrimaryAddress) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses must contain oagis:PrimaryAddress at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress"
                 priority="1066"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:AddressLine) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:AddressLine) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:AddressLine at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact"
                 priority="1065"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Description) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:Description) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact may contain oagis:Description at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Telephone) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:Telephone) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact may contain oagis:Telephone at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName"
                 priority="1064"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:FamilyName) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:FamilyName) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:FamilyName at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:GivenName) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:GivenName) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:GivenName at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Salutation) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:Salutation) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:Salutation at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:PartyId"
                 priority="1063"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:PartyId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Id) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:Id) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:PartyId must contain oagis:Id at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty"
                 priority="1062"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Addresses) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:Addresses) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty must contain oagis:Addresses at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Name) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:Name) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty must contain oagis:Name at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:PartyId) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:PartyId) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty must contain oagis:PartyId at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses"
                 priority="1061"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:PrimaryAddress) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(oagis:PrimaryAddress) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses must contain oagis:PrimaryAddress at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress"
                 priority="1060"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:AddressLine) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:AddressLine) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:AddressLine at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact"
                 priority="1059"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Description) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:Description) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact may contain oagis:Description at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Telephone) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:Telephone) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact may contain oagis:Telephone at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName"
                 priority="1058"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:FamilyName) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:FamilyName) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:FamilyName at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:GivenName) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:GivenName) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:GivenName at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Salutation) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:Salutation) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:Salutation at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:PartyId"
                 priority="1057"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:PartyId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Id) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:Id) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:PartyId must contain oagis:Id at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea" priority="1056" mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Header/oagis:UserArea"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingAdditionalData) &gt;= 1 and count(hrxml:StaffingAdditionalData) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:StaffingAdditionalData) &gt;= 1 and count(hrxml:StaffingAdditionalData) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:UserArea must contain hrxml:StaffingAdditionalData at least 1 and at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingOrganization) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:StaffingOrganization) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:UserArea may contain hrxml:StaffingOrganization at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingOrganizationNL) &gt;= 1 and count(hrxml:StaffingOrganizationNL) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:StaffingOrganizationNL) &gt;= 1 and count(hrxml:StaffingOrganizationNL) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:UserArea must contain hrxml:StaffingOrganizationNL at least 1 and at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"
                 priority="1055"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:AdditionalRequirement) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:AdditionalRequirement) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements must contain hrxml:AdditionalRequirement at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement"
                 priority="1054"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@requirementTitle) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@requirementTitle) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must contain @requirementTitle at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation"
                 priority="1053"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingCustomerOrgUnitId) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:StaffingCustomerOrgUnitId) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may contain hrxml:StaffingCustomerOrgUnitId at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId"
                 priority="1052"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may contain hrxml:IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization"
                 priority="1051"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:Organization) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:Organization) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization may contain hrxml:Organization at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:PaymentInfo) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:PaymentInfo) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization may contain hrxml:PaymentInfo at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganizationNL"
                 priority="1050"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganizationNL"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:ChamberofCommerceReference) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:ChamberofCommerceReference) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganizationNL must contain hrxml:ChamberofCommerceReference at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Charges" priority="1049" mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Charges"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:TotalCharge) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:TotalCharge) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Charges must contain oagis:TotalCharge at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Charges/oagis:Charge" priority="1048"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Charges/oagis:Charge"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Description) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:Description) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Charges/oagis:Charge may contain oagis:Description at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges" priority="1047"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:TotalCharge) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:TotalCharge) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges must contain oagis:TotalCharge at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges/oagis:Charge"
                 priority="1046"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges/oagis:Charge"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Description) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(oagis:Description) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges/oagis:Charge may contain oagis:Description at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea" priority="1045"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingAdditionalData) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:StaffingAdditionalData) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea may contain hrxml:StaffingAdditionalData at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard"
                 priority="1044"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:AdditionalData) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:AdditionalData) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard must contain hrxml:AdditionalData at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:Id) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:Id) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard must contain hrxml:Id at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData"
                 priority="1043"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingAdditionalData) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:StaffingAdditionalData) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData must contain hrxml:StaffingAdditionalData at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData"
                 priority="1042"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:CustomerReportingRequirements) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:CustomerReportingRequirements) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData must contain hrxml:CustomerReportingRequirements at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement"
                 priority="1041"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@requirementTitle) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@requirementTitle) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must contain @requirementTitle at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId"
                 priority="1040"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@idOwner) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId must contain @idOwner at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId"
                 priority="1039"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@idOwner) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId must contain @idOwner at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId"
                 priority="1038"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@idOwner) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId must contain @idOwner at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may contain hrxml:IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName"
                 priority="1037"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:Affix) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:Affix) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName may contain hrxml:Affix at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:FamilyName) &lt;= 2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:FamilyName) &lt;= 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName may contain hrxml:FamilyName at most 2 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:GivenName) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:GivenName) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName may contain hrxml:GivenName at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id"
                 priority="1036"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id"
                 priority="1035"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName"
                 priority="1034"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:FamilyName) &lt;= 2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:FamilyName) &lt;= 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName may contain hrxml:FamilyName at most 2 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:GivenName) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:GivenName) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName may contain hrxml:GivenName at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Resource"
                 priority="1033"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Resource"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:Id) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:Id) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Resource may contain hrxml:Id at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Resource/hrxml:Id"
                 priority="1032"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Resource/hrxml:Id"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Resource/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance"
                 priority="1031"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:Amount) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:Amount) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance must contain hrxml:Amount at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id"
                 priority="1030"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue"
                 priority="1029"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@name) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@name) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue must contain @name at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:ReportedPersonAssignment/hrxml:Id"
                 priority="1028"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:ReportedPersonAssignment/hrxml:Id"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:ReportedPersonAssignment/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance"
                 priority="1027"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:Amount) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:Amount) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance must contain hrxml:Amount at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:Id) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:Id) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance must contain hrxml:Id at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance/hrxml:Id"
                 priority="1026"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance/hrxml:Id"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance/hrxml:Id/hrxml:IdValue"
                 priority="1025"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance/hrxml:Id/hrxml:IdValue"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@name) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@name) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance/hrxml:Id/hrxml:IdValue must contain @name at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id"
                 priority="1024"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:SubmitterInfo/hrxml:Person/hrxml:PersonName"
                 priority="1023"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:SubmitterInfo/hrxml:Person/hrxml:PersonName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:FamilyName) &lt;= 2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:FamilyName) &lt;= 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:SubmitterInfo/hrxml:Person/hrxml:PersonName may contain hrxml:FamilyName at most 2 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:GivenName) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:GivenName) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:SubmitterInfo/hrxml:Person/hrxml:PersonName may contain hrxml:GivenName at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea" priority="1022" mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:UserArea"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingAdditionalData) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:StaffingAdditionalData) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea may contain hrxml:StaffingAdditionalData at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard" priority="1021"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:AdditionalData) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:AdditionalData) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard must contain hrxml:AdditionalData at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:Id) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:Id) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard must contain hrxml:Id at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData"
                 priority="1020"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingAdditionalData) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:StaffingAdditionalData) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData must contain hrxml:StaffingAdditionalData at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData"
                 priority="1019"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:CustomerReportingRequirements) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:CustomerReportingRequirements) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData must contain hrxml:CustomerReportingRequirements at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement"
                 priority="1018"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@requirementTitle) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@requirementTitle) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must contain @requirementTitle at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId"
                 priority="1017"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@idOwner) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId must contain @idOwner at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId"
                 priority="1016"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@idOwner) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId must contain @idOwner at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId"
                 priority="1015"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@idOwner) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId must contain @idOwner at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may contain hrxml:IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName"
                 priority="1014"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:Affix) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:Affix) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName may contain hrxml:Affix at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:FamilyName) &lt;= 2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:FamilyName) &lt;= 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName may contain hrxml:FamilyName at most 2 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:GivenName) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:GivenName) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName may contain hrxml:GivenName at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id"
                 priority="1013"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id"
                 priority="1012"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName"
                 priority="1011"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:FamilyName) &lt;= 2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:FamilyName) &lt;= 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName may contain hrxml:FamilyName at most 2 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:GivenName) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:GivenName) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName may contain hrxml:GivenName at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Resource"
                 priority="1010"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Resource"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:Id) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:Id) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Resource may contain hrxml:Id at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Resource/hrxml:Id"
                 priority="1009"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Resource/hrxml:Id"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Resource/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance"
                 priority="1008"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:Amount) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:Amount) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance must contain hrxml:Amount at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id"
                 priority="1007"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue"
                 priority="1006"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@name) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@name) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue must contain @name at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:ReportedPersonAssignment/hrxml:Id"
                 priority="1005"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:ReportedPersonAssignment/hrxml:Id"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:ReportedPersonAssignment/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance"
                 priority="1004"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:Amount) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:Amount) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance must contain hrxml:Amount at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:Id) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:Id) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance must contain hrxml:Id at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance/hrxml:Id"
                 priority="1003"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance/hrxml:Id"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance/hrxml:Id/hrxml:IdValue"
                 priority="1002"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance/hrxml:Id/hrxml:IdValue"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@name) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@name) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance/hrxml:Id/hrxml:IdValue must contain @name at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id"
                 priority="1001"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:SubmitterInfo/hrxml:Person/hrxml:PersonName"
                 priority="1000"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:SubmitterInfo/hrxml:Person/hrxml:PersonName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:FamilyName) &lt;= 2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:FamilyName) &lt;= 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:SubmitterInfo/hrxml:Person/hrxml:PersonName may contain hrxml:FamilyName at most 2 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:GivenName) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:GivenName) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:SubmitterInfo/hrxml:Person/hrxml:PersonName may contain hrxml:GivenName at most 1 time(s)</svrl:text>
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
<xsl:template match="oagis:Invoice/oagis:Header" priority="1028" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="oagis:Invoice/oagis:Header"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Reason) or (oagis:Reason='Regular') or (oagis:Reason='Pro Forma') or (oagis:Reason='Self-Billed') or (oagis:Reason='regular') or (oagis:Reason='pro forma') or (oagis:Reason='self-billed')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(oagis:Reason) or (oagis:Reason='Regular') or (oagis:Reason='Pro Forma') or (oagis:Reason='Self-Billed') or (oagis:Reason='regular') or (oagis:Reason='pro forma') or (oagis:Reason='self-billed')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Reason must have one of the following values: [Regular, Pro Forma, Self-Billed, regular, pro forma, self-billed]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ReasonCode) or (oagis:ReasonCode='Services') or (oagis:ReasonCode='Hours') or (oagis:ReasonCode='Combination') or (oagis:ReasonCode='services') or (oagis:ReasonCode='hours') or (oagis:ReasonCode='combination')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(oagis:ReasonCode) or (oagis:ReasonCode='Services') or (oagis:ReasonCode='Hours') or (oagis:ReasonCode='Combination') or (oagis:ReasonCode='services') or (oagis:ReasonCode='hours') or (oagis:ReasonCode='combination')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:ReasonCode must have one of the following values: [Services, Hours, Combination, services, hours, combination]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Type) or (oagis:Type='Debit') or (oagis:Type='Credit') or (oagis:Type='Both')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(oagis:Type) or (oagis:Type='Debit') or (oagis:Type='Credit') or (oagis:Type='Both')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:Type must have one of the following values: [Debit, Credit, Both]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"
                 priority="1027"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:AdditionalRequirement[@requirementTitle = 'VersionId']) = 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:AdditionalRequirement[@requirementTitle = 'VersionId']) = 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>There MUST be one CustomerReportingRequirements/AdditionalRequirement with @requirementTitle equal to VersionId</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement[@requirementTitle = 'VersionId']"
                 priority="1026"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement[@requirementTitle = 'VersionId']"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="text() = '1.8'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="text() = '1.8'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>CustomerReportingRequirements/AdditionalRequirement must have value: 1.8 when requirementTitle is 'VersionId'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo/hrxml:BankAccountInfo/hrxml:BankInfoByJurisdiction"
                 priority="1025"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo/hrxml:BankAccountInfo/hrxml:BankInfoByJurisdiction"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@bankJurisdiction) or (@bankJurisdiction='NL')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@bankJurisdiction) or (@bankJurisdiction='NL')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo/hrxml:BankAccountInfo/hrxml:BankInfoByJurisdiction/@bankJurisdiction must have one of the following values: [NL]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:BankAccountKey) or (hrxml:BankAccountKey='')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:BankAccountKey) or (hrxml:BankAccountKey='')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo/hrxml:BankAccountInfo/hrxml:BankInfoByJurisdiction/hrxml:BankAccountKey must be Empty</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:BankWindow) or (hrxml:BankWindow='')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:BankWindow) or (hrxml:BankWindow='')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo/hrxml:BankAccountInfo/hrxml:BankInfoByJurisdiction/hrxml:BankWindow must be Empty</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line" priority="1024" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="oagis:Invoice/oagis:Line"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="((count(oagis:Price) = 0) and (count(oagis:Line/oagis:Price) = count(oagis:Line))) or ((count(oagis:Price) &gt; 0) and (count(oagis:Line/oagis:Price) = 0))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="((count(oagis:Price) = 0) and (count(oagis:Line/oagis:Price) = count(oagis:Line))) or ((count(oagis:Price) &gt; 0) and (count(oagis:Line/oagis:Price) = 0))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Price MOET OF op Line niveau OF voor alle Line/Lines worden opgegeven.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:Tax/oagis:PercentQuantity"
                 priority="1023"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line/oagis:Tax/oagis:PercentQuantity"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(index-of(/oagis:Invoice/oagis:Header/oagis:Tax/oagis:PercentQuantity, text()))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(index-of(/oagis:Invoice/oagis:Header/oagis:Tax/oagis:PercentQuantity, text()))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Line/Line/Tax/PercentQuantity must be available on Header level: <xsl:text/>
                  <xsl:value-of select="text()"/>
                  <xsl:text/>
               </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard"
                 priority="1022"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(count(hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId) + count(hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:PurchaseOrderNumber)) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId) + count(hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:PurchaseOrderNumber)) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>There must be at least one AssignmentId or PurchaseOrderNumber on header level.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation"
                 priority="1021"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="if (count(hrxml:StaffingCustomerOrgUnitId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingCustomerOrgUnitId[@idOwner = 'KvK']) = 1) else ('true')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="if (count(hrxml:StaffingCustomerOrgUnitId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingCustomerOrgUnitId[@idOwner = 'KvK']) = 1) else ('true')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="if (count(hrxml:StaffingCustomerId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingCustomerId[@idOwner = 'KvK']) = 1) else ('true')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="if (count(hrxml:StaffingCustomerId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingCustomerId[@idOwner = 'KvK']) = 1) else ('true')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="if (count(hrxml:StaffingSupplierId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingSupplierId[@idOwner = 'KvK']) = 1) else ('true')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="if (count(hrxml:StaffingSupplierId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingSupplierId[@idOwner = 'KvK']) = 1) else ('true')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingCustomerId/@idOwner) = count(distinct-values(hrxml:StaffingCustomerId/@idOwner))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:StaffingCustomerId/@idOwner) = count(distinct-values(hrxml:StaffingCustomerId/@idOwner))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The same idOwner may not be given for StaffingCustomerId</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingCustomerOrgUnitId/@idOwner) = count(distinct-values(hrxml:StaffingCustomerOrgUnitId/@idOwner))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:StaffingCustomerOrgUnitId/@idOwner) = count(distinct-values(hrxml:StaffingCustomerOrgUnitId/@idOwner))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The same idOwner may not be given for StaffingCustomerOrgUnitId</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingSupplierId/@idOwner) = count(distinct-values(hrxml:StaffingSupplierId/@idOwner))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:StaffingSupplierId/@idOwner) = count(distinct-values(hrxml:StaffingSupplierId/@idOwner))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The same idOwner may not be given for StaffingSupplierId</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId"
                 priority="1020"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/@idOwner must have one of the following values: [StaffingCustomer, staffingCustomer, StaffingCompany, staffingCompany, OIN, KvK, BTW, Fi, Vest]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId"
                 priority="1019"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/@idOwner must have one of the following values: [StaffingCustomer, staffingCustomer, StaffingCompany, staffingCompany, OIN, KvK, BTW, Fi, Vest]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId"
                 priority="1018"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/@idOwner must have one of the following values: [StaffingCustomer, staffingCustomer, StaffingCompany, staffingCompany, OIN, KvK, BTW, Fi, Vest]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id"
                 priority="1017"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(empty(@idOwner) or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer')) or (empty(@idOwner) or (@idOwner=''))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(empty(@idOwner) or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer')) or (empty(@idOwner) or (@idOwner=''))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id/@idOwner must have one of the following values: [StaffingCompany, staffingCompany, StaffingCustomer, staffingCustomer] OR oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id/@idOwner must be Empty</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue"
                 priority="1016"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name) or (@name='allowance') or (@name='expense') or (@name='Expense') or (@name='Allowance')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@name) or (@name='allowance') or (@name='expense') or (@name='Expense') or (@name='Allowance')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue/@name must have one of the following values: [allowance, expense, Expense, Allowance]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement"
                 priority="1015"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@requirementTitle) or (@requirementTitle='InclusiveRate') or (@requirementTitle='inclusiverate')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@requirementTitle) or (@requirementTitle='InclusiveRate') or (@requirementTitle='inclusiverate')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement/@requirementTitle must have one of the following values: [InclusiveRate, inclusiverate]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance/hrxml:Id/hrxml:IdValue"
                 priority="1014"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance/hrxml:Id/hrxml:IdValue"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name) or (@name='expense') or (@name='allowance') or (@name='Expense') or (@name='Allowance')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@name) or (@name='expense') or (@name='allowance') or (@name='Expense') or (@name='Allowance')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance/hrxml:Id/hrxml:IdValue/@name must have one of the following values: [expense, allowance, Expense, Allowance]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id/hrxml:IdValue"
                 priority="1013"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id/hrxml:IdValue"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name) or (@name='split') or (@name='consolidated')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@name) or (@name='split') or (@name='consolidated')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id/hrxml:IdValue/@name must have one of the following values: [split, consolidated]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount"
                 priority="1012"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@type) or (@type='hourly') or (@type='hourlysplit') or (@type='hourlyconsolidated') or (@type='daily') or (@type='dailysplit') or (@type='dailyconsolidated') or (@type='Hourly') or (@type='HourlySplit') or (@type='HourlyConsolidated') or (@type='Daily') or (@type='DailySplit') or (@type='DailyConsolidated')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@type) or (@type='hourly') or (@type='hourlysplit') or (@type='hourlyconsolidated') or (@type='daily') or (@type='dailysplit') or (@type='dailyconsolidated') or (@type='Hourly') or (@type='HourlySplit') or (@type='HourlyConsolidated') or (@type='Daily') or (@type='DailySplit') or (@type='DailyConsolidated')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount/@type must have one of the following values: [hourly, hourlysplit, hourlyconsolidated, daily, dailysplit, dailyconsolidated, Hourly, HourlySplit, HourlyConsolidated, Daily, DailySplit, DailyConsolidated]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Tax/oagis:PercentQuantity"
                 priority="1011"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:Tax/oagis:PercentQuantity"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(index-of(/oagis:Invoice/oagis:Header/oagis:Tax/oagis:PercentQuantity, text()))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(index-of(/oagis:Invoice/oagis:Header/oagis:Tax/oagis:PercentQuantity, text()))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice/Line/Tax/PercentQuantity must be available on Header level: <xsl:text/>
                  <xsl:value-of select="text()"/>
                  <xsl:text/>
               </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard" priority="1010"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(../../oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id) = 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(../../oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id) = 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Invoice Line must not contain TimeCard on Line/Line level when it has a TimeCard itself</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(count(hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId) + count(hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:PurchaseOrderNumber)) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId) + count(hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:PurchaseOrderNumber)) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>There must be at least one AssignmentId or PurchaseOrderNumber on header level.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation"
                 priority="1009"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="if (count(hrxml:StaffingCustomerOrgUnitId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingCustomerOrgUnitId[@idOwner = 'KvK']) = 1) else ('true')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="if (count(hrxml:StaffingCustomerOrgUnitId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingCustomerOrgUnitId[@idOwner = 'KvK']) = 1) else ('true')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="if (count(hrxml:StaffingCustomerId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingCustomerId[@idOwner = 'KvK']) = 1) else ('true')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="if (count(hrxml:StaffingCustomerId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingCustomerId[@idOwner = 'KvK']) = 1) else ('true')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="if (count(hrxml:StaffingSupplierId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingSupplierId[@idOwner = 'KvK']) = 1) else ('true')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="if (count(hrxml:StaffingSupplierId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingSupplierId[@idOwner = 'KvK']) = 1) else ('true')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingCustomerId/@idOwner) = count(distinct-values(hrxml:StaffingCustomerId/@idOwner))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:StaffingCustomerId/@idOwner) = count(distinct-values(hrxml:StaffingCustomerId/@idOwner))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The same idOwner may not be given for StaffingCustomerId</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingCustomerOrgUnitId/@idOwner) = count(distinct-values(hrxml:StaffingCustomerOrgUnitId/@idOwner))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:StaffingCustomerOrgUnitId/@idOwner) = count(distinct-values(hrxml:StaffingCustomerOrgUnitId/@idOwner))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The same idOwner may not be given for StaffingCustomerOrgUnitId</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingSupplierId/@idOwner) = count(distinct-values(hrxml:StaffingSupplierId/@idOwner))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:StaffingSupplierId/@idOwner) = count(distinct-values(hrxml:StaffingSupplierId/@idOwner))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The same idOwner may not be given for StaffingSupplierId</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId"
                 priority="1008"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/@idOwner must have one of the following values: [StaffingCustomer, staffingCustomer, StaffingCompany, staffingCompany, OIN, KvK, BTW, Fi, Vest]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId"
                 priority="1007"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/@idOwner must have one of the following values: [StaffingCustomer, staffingCustomer, StaffingCompany, staffingCompany, OIN, KvK, BTW, Fi, Vest]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId"
                 priority="1006"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/@idOwner must have one of the following values: [StaffingCustomer, staffingCustomer, StaffingCompany, staffingCompany, OIN, KvK, BTW, Fi, Vest]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id"
                 priority="1005"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(empty(@idOwner) or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer')) or (empty(@idOwner) or (@idOwner=''))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(empty(@idOwner) or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer')) or (empty(@idOwner) or (@idOwner=''))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id/@idOwner must have one of the following values: [StaffingCompany, staffingCompany, StaffingCustomer, staffingCustomer] OR oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id/@idOwner must be Empty</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue"
                 priority="1004"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name) or (@name='allowance') or (@name='expense') or (@name='Expense') or (@name='Allowance')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@name) or (@name='allowance') or (@name='expense') or (@name='Expense') or (@name='Allowance')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue/@name must have one of the following values: [allowance, expense, Expense, Allowance]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement"
                 priority="1003"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@requirementTitle) or (@requirementTitle='InclusiveRate') or (@requirementTitle='inclusiverate')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@requirementTitle) or (@requirementTitle='InclusiveRate') or (@requirementTitle='inclusiverate')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement/@requirementTitle must have one of the following values: [InclusiveRate, inclusiverate]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance/hrxml:Id/hrxml:IdValue"
                 priority="1002"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance/hrxml:Id/hrxml:IdValue"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name) or (@name='expense') or (@name='allowance') or (@name='Expense') or (@name='Allowance')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@name) or (@name='expense') or (@name='allowance') or (@name='Expense') or (@name='Allowance')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance/hrxml:Id/hrxml:IdValue/@name must have one of the following values: [expense, allowance, Expense, Allowance]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id/hrxml:IdValue"
                 priority="1001"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id/hrxml:IdValue"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name) or (@name='split') or (@name='consolidated')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@name) or (@name='split') or (@name='consolidated')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id/hrxml:IdValue/@name must have one of the following values: [split, consolidated]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount"
                 priority="1000"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@type) or (@type='hourly') or (@type='hourlysplit') or (@type='hourlyconsolidated') or (@type='daily') or (@type='dailysplit') or (@type='dailyconsolidated') or (@type='Hourly') or (@type='HourlySplit') or (@type='HourlyConsolidated') or (@type='Daily') or (@type='DailySplit') or (@type='DailyConsolidated')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@type) or (@type='hourly') or (@type='hourlysplit') or (@type='hourlyconsolidated') or (@type='daily') or (@type='dailysplit') or (@type='dailyconsolidated') or (@type='Hourly') or (@type='HourlySplit') or (@type='HourlyConsolidated') or (@type='Daily') or (@type='DailySplit') or (@type='DailyConsolidated')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount/@type must have one of the following values: [hourly, hourlysplit, hourlyconsolidated, daily, dailysplit, dailyconsolidated, Hourly, HourlySplit, HourlyConsolidated, Daily, DailySplit, DailyConsolidated]</svrl:text>
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