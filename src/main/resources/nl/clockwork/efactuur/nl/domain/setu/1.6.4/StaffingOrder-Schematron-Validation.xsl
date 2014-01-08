<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:schold="http://www.ascc.net/xml/schematron"
                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:ns1="http://ns.hr-xml.org/2007-04-15"
                xmlns:ns2="http://ns.setu.nl/2008-01"
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
                              title="Validations for StaffingOrder Mapping"
                              schemaVersion="">
         <xsl:comment>
            <xsl:value-of select="$archiveDirParameter"/>   
		 <xsl:value-of select="$archiveNameParameter"/>  
		 <xsl:value-of select="$fileNameParameter"/>  
		 <xsl:value-of select="$fileDirParameter"/>
         </xsl:comment>
         <svrl:ns-prefix-in-attribute-values uri="http://ns.hr-xml.org/2007-04-15" prefix="ns1"/>
         <svrl:ns-prefix-in-attribute-values uri="http://ns.setu.nl/2008-01" prefix="ns2"/>
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
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Validations for StaffingOrder Mapping</svrl:text>

   <!--PATTERN prohibitions-->
<xsl:template match="text()" priority="-1" mode="M3"/>
   <xsl:template match="@*|node()" priority="-2" mode="M3">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

   <!--PATTERN cardinality-redefines-->


	<!--RULE -->
<xsl:template match="ns1:StaffingOrder" priority="1022" mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="ns1:StaffingOrder"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:OrderContact) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:OrderContact) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder may contain OrderContact at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:OrderComments) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:OrderComments) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder may contain OrderComments at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:StaffingOrder/ns1:OrderId" priority="1021" mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:OrderId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:IdValue) &lt;= 2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:IdValue) &lt;= 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/OrderId may contain IdValue at most 2 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:StaffingOrder/ns1:ReferenceInformation" priority="1020" mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:ReferenceInformation"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:MasterOrderId) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:MasterOrderId) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/ReferenceInformation may contain MasterOrderId at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:StaffingCustomerId) &lt;= 2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(ns1:StaffingCustomerId) &lt;= 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/ReferenceInformation may contain StaffingCustomerId at most 2 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:StaffingCustomerOrgUnitId) &lt;= 2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(ns1:StaffingCustomerOrgUnitId) &lt;= 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/ReferenceInformation may contain StaffingCustomerOrgUnitId at most 2 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:IntermediaryId) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:IntermediaryId) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/ReferenceInformation may contain IntermediaryId at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:StaffingSupplierId) &lt;= 2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(ns1:StaffingSupplierId) &lt;= 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/ReferenceInformation may contain StaffingSupplierId at most 2 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:StaffingOrder/ns1:ReferenceInformation/ns1:MasterOrderId"
                 priority="1019"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:ReferenceInformation/ns1:MasterOrderId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/ReferenceInformation/MasterOrderId may contain IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:StaffingOrder/ns1:ReferenceInformation/ns1:StaffingCustomerId"
                 priority="1018"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:ReferenceInformation/ns1:StaffingCustomerId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/ReferenceInformation/StaffingCustomerId may contain IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:StaffingOrder/ns1:ReferenceInformation/ns1:StaffingCustomerOrgUnitId"
                 priority="1017"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:ReferenceInformation/ns1:StaffingCustomerOrgUnitId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/ReferenceInformation/StaffingCustomerOrgUnitId may contain IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:StaffingOrder/ns1:ReferenceInformation/ns1:StaffingSupplierId"
                 priority="1016"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:ReferenceInformation/ns1:StaffingSupplierId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/ReferenceInformation/StaffingSupplierId may contain IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:StaffingOrder/ns1:CustomerReportingRequirements" priority="1015"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:CustomerReportingRequirements"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:AdditionalRequirement) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(ns1:AdditionalRequirement) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/CustomerReportingRequirements must contain AdditionalRequirement at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:StaffingOrder/ns1:CustomerReportingRequirements/ns1:AdditionalRequirement"
                 priority="1014"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:CustomerReportingRequirements/ns1:AdditionalRequirement"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@requirementTitle) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@requirementTitle) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/CustomerReportingRequirements/AdditionalRequirement must contain requirementTitle at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:StaffingOrder/ns1:StaffingPosition" priority="1013" mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:StaffingPosition"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:Rates) &lt;= 2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:Rates) &lt;= 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/StaffingPosition may contain Rates at most 2 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:StaffingShift) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:StaffingShift) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/StaffingPosition may contain StaffingShift at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:StaffingOrder/ns1:StaffingPosition/ns1:PositionHeader"
                 priority="1012"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:StaffingPosition/ns1:PositionHeader"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:RequestedPerson) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(ns1:RequestedPerson) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/StaffingPosition/PositionHeader may contain RequestedPerson at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:StaffingOrder/ns1:StaffingPosition/ns1:PositionHeader/ns1:RequestedPerson/ns1:PersonName"
                 priority="1011"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:StaffingPosition/ns1:PositionHeader/ns1:RequestedPerson/ns1:PersonName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:GivenName) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:GivenName) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/StaffingPosition/PositionHeader/RequestedPerson/PersonName may contain GivenName at most 1 time(s)</svrl:text>
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
               <svrl:text>StaffingOrder/StaffingPosition/PositionHeader/RequestedPerson/PersonName may contain FamilyName at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:StaffingOrder/ns1:StaffingPosition/ns1:PositionHeader/ns1:RequestedPerson/ns1:PersonId"
                 priority="1010"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:StaffingPosition/ns1:PositionHeader/ns1:RequestedPerson/ns1:PersonId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/StaffingPosition/PositionHeader/RequestedPerson/PersonId may contain IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:StaffingOrder/ns1:StaffingPosition/ns1:PositionHeader/ns1:ShiftWork"
                 priority="1009"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:StaffingPosition/ns1:PositionHeader/ns1:ShiftWork"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:Description) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:Description) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/StaffingPosition/PositionHeader/ShiftWork must contain Description at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:StaffingOrder/ns1:StaffingPosition/ns1:CustomerReportingRequirements"
                 priority="1008"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:StaffingPosition/ns1:CustomerReportingRequirements"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:CostCenterCode) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:CostCenterCode) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/StaffingPosition/CustomerReportingRequirements must contain CostCenterCode at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:StaffingOrder/ns1:UserArea" priority="1007" mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:UserArea"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns2:StaffingOrderAdditionalNL) &gt;= 1 and count(ns2:StaffingOrderAdditionalNL) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(ns2:StaffingOrderAdditionalNL) &gt;= 1 and count(ns2:StaffingOrderAdditionalNL) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/UserArea must contain StaffingOrderAdditionalNL at least 1 and at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:StaffingOrder/ns1:UserArea/ns2:StaffingOrderAdditionalNL/ns2:OfferId"
                 priority="1006"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:UserArea/ns2:StaffingOrderAdditionalNL/ns2:OfferId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:IdValue) &lt;= 2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:IdValue) &lt;= 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/UserArea/StaffingOrderAdditionalNL/OfferId may contain IdValue at most 2 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:StaffingOrder/ns1:UserArea/ns2:StaffingOrderAdditionalNL/ns2:PreviousOrderId"
                 priority="1005"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:UserArea/ns2:StaffingOrderAdditionalNL/ns2:PreviousOrderId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/UserArea/StaffingOrderAdditionalNL/PreviousOrderId may contain IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:StaffingOrder/ns1:UserArea/ns2:StaffingOrderAdditionalNL/ns2:RFQOrderId"
                 priority="1004"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:UserArea/ns2:StaffingOrderAdditionalNL/ns2:RFQOrderId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/UserArea/StaffingOrderAdditionalNL/RFQOrderId may contain IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:StaffingOrder/ns1:UserArea/ns2:StaffingOrderAdditionalNL/ns2:StructuredXMLResume/ns1:EducationHistory"
                 priority="1003"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:UserArea/ns2:StaffingOrderAdditionalNL/ns2:StructuredXMLResume/ns1:EducationHistory"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:SchoolOrInstitution) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(ns1:SchoolOrInstitution) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/UserArea/StaffingOrderAdditionalNL/StructuredXMLResume/EducationHistory may contain SchoolOrInstitution at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:StaffingOrder/ns1:UserArea/ns2:StaffingOrderAdditionalNL/ns2:StructuredXMLResume/ns1:EducationHistory/ns1:SchoolOrInstitution"
                 priority="1002"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:UserArea/ns2:StaffingOrderAdditionalNL/ns2:StructuredXMLResume/ns1:EducationHistory/ns1:SchoolOrInstitution"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:LocalInstitutionClassification) &gt;= 1 and count(ns1:LocalInstitutionClassification) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(ns1:LocalInstitutionClassification) &gt;= 1 and count(ns1:LocalInstitutionClassification) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/UserArea/StaffingOrderAdditionalNL/StructuredXMLResume/EducationHistory/SchoolOrInstitution must contain LocalInstitutionClassification at least 1 and at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:StaffingOrder/ns1:UserArea/ns2:StaffingOrderAdditionalNL/ns2:StructuredXMLResume/ns1:EducationHistory/ns1:SchoolOrInstitution/ns1:LocalInstitutionClassification/ns1:Id"
                 priority="1001"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:UserArea/ns2:StaffingOrderAdditionalNL/ns2:StructuredXMLResume/ns1:EducationHistory/ns1:SchoolOrInstitution/ns1:LocalInstitutionClassification/ns1:Id"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/UserArea/StaffingOrderAdditionalNL/StructuredXMLResume/EducationHistory/SchoolOrInstitution/LocalInstitutionClassification/Id may contain IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:StaffingOrder/ns1:UserArea/ns2:StaffingOrderAdditionalNL/ns2:StructuredXMLResume/ns1:Qualifications"
                 priority="1000"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:UserArea/ns2:StaffingOrderAdditionalNL/ns2:StructuredXMLResume/ns1:Qualifications"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:Competency) &lt;= 2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ns1:Competency) &lt;= 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/UserArea/StaffingOrderAdditionalNL/StructuredXMLResume/Qualifications may contain Competency at most 2 time(s)</svrl:text>
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
<xsl:template match="ns1:StaffingOrder/ns1:OrderId" priority="1018" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:OrderId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/OrderId/@idOwner may only have (one of) the following value(s): StaffingCustomer, staffingCustomer, [Empty]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:StaffingOrder/ns1:OrderId/ns1:IdValue[2]" priority="1017" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:OrderId/ns1:IdValue[2]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name) or (@name='Version') or (@name='version')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@name) or (@name='Version') or (@name='version')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/OrderId/IdValue/@name[2] may only have (one of) the following value(s): Version, version</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:StaffingOrder/ns1:ReferenceInformation/ns1:StaffingCustomerId"
                 priority="1016"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:ReferenceInformation/ns1:StaffingCustomerId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/ReferenceInformation/StaffingCustomerId/@idOwner may only have (one of) the following value(s): StaffingCustomer, staffingCustomer, StaffingCompany, staffingCompany, OIN, KvK, BTW, Fi</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:StaffingOrder/ns1:ReferenceInformation/ns1:StaffingCustomerOrgUnitId"
                 priority="1015"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:ReferenceInformation/ns1:StaffingCustomerOrgUnitId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/ReferenceInformation/StaffingCustomerOrgUnitId/@idOwner may only have (one of) the following value(s): StaffingCustomer, staffingCustomer, StaffingCompany, staffingCompany, OIN, KvK, BTW, Fi</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:StaffingOrder/ns1:ReferenceInformation/ns1:StaffingSupplierId"
                 priority="1014"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:ReferenceInformation/ns1:StaffingSupplierId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/ReferenceInformation/StaffingSupplierId/@idOwner may only have (one of) the following value(s): StaffingCustomer, staffingCustomer, StaffingCompany, staffingCompany, OIN, KvK, BTW, Fi</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:StaffingOrder/ns1:CustomerReportingRequirements/ns1:AdditionalRequirement"
                 priority="1013"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:CustomerReportingRequirements/ns1:AdditionalRequirement"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@requirementTitle) or (@requirementTitle='MinimalRequiredEndDateValidityOffer') or (@requirementTitle='StartDateSubmittancePeriodOffer') or (@requirementTitle='EndDateSubmittancePeriodOffer') or (@requirementTitle='AwardDate') or (@requirementTitle='minimalRequiredEndDateValidityOffer') or (@requirementTitle='startDateSubmittancePeriodOffer') or (@requirementTitle='endDateSubmittancePeriodOffer') or (@requirementTitle='awardDate') or (@requirementTitle='VersionId')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@requirementTitle) or (@requirementTitle='MinimalRequiredEndDateValidityOffer') or (@requirementTitle='StartDateSubmittancePeriodOffer') or (@requirementTitle='EndDateSubmittancePeriodOffer') or (@requirementTitle='AwardDate') or (@requirementTitle='minimalRequiredEndDateValidityOffer') or (@requirementTitle='startDateSubmittancePeriodOffer') or (@requirementTitle='endDateSubmittancePeriodOffer') or (@requirementTitle='awardDate') or (@requirementTitle='VersionId')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/CustomerReportingRequirements/AdditionalRequirement/@requirementTitle may only have (one of) the following value(s): MinimalRequiredEndDateValidityOffer, StartDateSubmittancePeriodOffer, EndDateSubmittancePeriodOffer, AwardDate, minimalRequiredEndDateValidityOffer, startDateSubmittancePeriodOffer, endDateSubmittancePeriodOffer, awardDate, VersionId</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:StaffingOrder/ns1:CustomerReportingRequirements" priority="1012"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:CustomerReportingRequirements"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(ns1:AdditionalRequirement[@requirementTitle = 'VersionId']) = 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(ns1:AdditionalRequirement[@requirementTitle = 'VersionId']) = 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/CustomerReportingRequirements/AdditionalRequirement/@requirementTitle must have at least the value: VersionId</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(ns1:AdditionalRequirement = '1.6') and (ns1:AdditionalRequirement/@requirementTitle = 'VersionId')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(ns1:AdditionalRequirement = '1.6') and (ns1:AdditionalRequirement/@requirementTitle = 'VersionId')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/CustomerReportingRequirements/AdditionalRequirement must have value: 1.6 when StaffingOrder/CustomerReportingRequirements/AdditionalRequirement is 'VersionId'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:StaffingOrder/ns1:OrderClassification" priority="1011" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:OrderClassification"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@orderStatus) or (@orderStatus='new') or (@orderStatus='revised') or (@orderStatus='closed') or (@orderStatus='reopened') or (@orderStatus='cancelled') or (@orderStatus='x:Rejected') or (@orderStatus='x:rejected')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@orderStatus) or (@orderStatus='new') or (@orderStatus='revised') or (@orderStatus='closed') or (@orderStatus='reopened') or (@orderStatus='cancelled') or (@orderStatus='x:Rejected') or (@orderStatus='x:rejected')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/OrderClassification/@orderStatus may only have (one of) the following value(s): new, revised, closed, reopened, cancelled, x:Rejected, x:rejected</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@orderType) or (@orderType='RFQ') or (@orderType='order')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@orderType) or (@orderType='RFQ') or (@orderType='order')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/OrderClassification/@orderType may only have (one of) the following value(s): RFQ, order</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:StaffingOrder/ns1:StaffingPosition" priority="1010" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:StaffingPosition"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(ns1:PositionReason) or (ns1:PositionReason='Illness') or (ns1:PositionReason='Peak') or (ns1:PositionReason='Project') or (ns1:PositionReason='Reorganisation') or (ns1:PositionReason='Position') or (ns1:PositionReason='Vacation') or (ns1:PositionReason='Maternity') or (ns1:PositionReason='Season') or (ns1:PositionReason='Replacement') or (ns1:PositionReason='Recruitment') or (ns1:PositionReason='Structural') or (ns1:PositionReason='Other') or (ns1:PositionReason='illness') or (ns1:PositionReason='peak') or (ns1:PositionReason='project') or (ns1:PositionReason='reorganisation') or (ns1:PositionReason='position') or (ns1:PositionReason='vacation') or (ns1:PositionReason='maternity') or (ns1:PositionReason='season') or (ns1:PositionReason='replacement') or (ns1:PositionReason='recruitment') or (ns1:PositionReason='structural') or (ns1:PositionReason='other')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(ns1:PositionReason) or (ns1:PositionReason='Illness') or (ns1:PositionReason='Peak') or (ns1:PositionReason='Project') or (ns1:PositionReason='Reorganisation') or (ns1:PositionReason='Position') or (ns1:PositionReason='Vacation') or (ns1:PositionReason='Maternity') or (ns1:PositionReason='Season') or (ns1:PositionReason='Replacement') or (ns1:PositionReason='Recruitment') or (ns1:PositionReason='Structural') or (ns1:PositionReason='Other') or (ns1:PositionReason='illness') or (ns1:PositionReason='peak') or (ns1:PositionReason='project') or (ns1:PositionReason='reorganisation') or (ns1:PositionReason='position') or (ns1:PositionReason='vacation') or (ns1:PositionReason='maternity') or (ns1:PositionReason='season') or (ns1:PositionReason='replacement') or (ns1:PositionReason='recruitment') or (ns1:PositionReason='structural') or (ns1:PositionReason='other')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/StaffingPosition/PositionReason may only have (one of) the following value(s): Illness, Peak, Project, Reorganisation, Position, Vacation, Maternity, Season, Replacement, Recruitment, Structural, Other, illness, peak, project, reorganisation, position, vacation, maternity, season, replacement, recruitment, structural, other</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:StaffingOrder/ns1:StaffingPosition/ns1:PositionHeader"
                 priority="1009"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:StaffingPosition/ns1:PositionHeader"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(ns1:PositionType) or (ns1:PositionType='Recruitment &amp; Selection') or (ns1:PositionType='recruitment &amp; selection') or (ns1:PositionType='Secondment') or (ns1:PositionType='secondment') or (ns1:PositionType='Temporary Staffing') or (ns1:PositionType='temporary staffing')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(ns1:PositionType) or (ns1:PositionType='Recruitment &amp; Selection') or (ns1:PositionType='recruitment &amp; selection') or (ns1:PositionType='Secondment') or (ns1:PositionType='secondment') or (ns1:PositionType='Temporary Staffing') or (ns1:PositionType='temporary staffing')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/StaffingPosition/PositionHeader/PositionType may only have (one of) the following value(s): Recruitment &amp; Selection, recruitment &amp; selection, Secondment, secondment, Temporary Staffing, temporary staffing</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:StaffingOrder/ns1:StaffingPosition/ns1:PositionHeader/ns1:PositionId"
                 priority="1008"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:StaffingPosition/ns1:PositionHeader/ns1:PositionId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(ns1:Id) or (ns1:Id='')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(ns1:Id) or (ns1:Id='')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/StaffingPosition/PositionHeader/PositionId/Id may only have (one of) the following value(s): [Empty]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:StaffingOrder/ns1:StaffingPosition/ns1:PositionHeader/ns1:RequestedPerson/ns1:PersonId"
                 priority="1007"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:StaffingPosition/ns1:PositionHeader/ns1:RequestedPerson/ns1:PersonId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='BSN')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='BSN')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/StaffingPosition/PositionHeader/RequestedPerson/PersonId/@idOwner may only have (one of) the following value(s): StaffingCustomer, staffingCustomer, BSN</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:StaffingOrder/ns1:StaffingPosition/ns1:PositionHeader/ns1:ShiftWork"
                 priority="1006"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:StaffingPosition/ns1:PositionHeader/ns1:ShiftWork"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@haveShiftWork) or (@haveShiftWork='true') or (@haveShiftWork='1')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@haveShiftWork) or (@haveShiftWork='true') or (@haveShiftWork='1')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/StaffingPosition/PositionHeader/ShiftWork/@haveShiftWork may only have (one of) the following value(s): true, 1</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(ns1:Description) or (ns1:Description='3-shift') or (ns1:Description='4-shift') or (ns1:Description='5-shift') or (ns1:Description='')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(ns1:Description) or (ns1:Description='3-shift') or (ns1:Description='4-shift') or (ns1:Description='5-shift') or (ns1:Description='')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/StaffingPosition/PositionHeader/ShiftWork/Description may only have (one of) the following value(s): 3-shift, 4-shift, 5-shift, [Empty]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:StaffingOrder/ns1:StaffingPosition/ns1:Rates" priority="1005"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:StaffingPosition/ns1:Rates"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@rateType) or (@rateType='bill') or (@rateType='pay') or (@rateType='minPayRate') or (@rateType='maxPayRate') or (@rateType='minBillRate') or (@rateType='maxBillRate')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@rateType) or (@rateType='bill') or (@rateType='pay') or (@rateType='minPayRate') or (@rateType='maxPayRate') or (@rateType='minBillRate') or (@rateType='maxBillRate')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/StaffingPosition/Rates/@rateType may only have (one of) the following value(s): bill, pay, minPayRate, maxPayRate, minBillRate, maxBillRate</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@rateStatus) or (@rateStatus='proposed') or (@rateStatus='')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@rateStatus) or (@rateStatus='proposed') or (@rateStatus='')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/StaffingPosition/Rates/@rateStatus may only have (one of) the following value(s): proposed, [Empty]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(ns1:Class) or (ns1:Class='TimeInterval') or (ns1:Class='Allowance') or (ns1:Class='Expense') or (ns1:Class='timeInterval') or (ns1:Class='allowance') or (ns1:Class='expense') or (ns1:Class='')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(ns1:Class) or (ns1:Class='TimeInterval') or (ns1:Class='Allowance') or (ns1:Class='Expense') or (ns1:Class='timeInterval') or (ns1:Class='allowance') or (ns1:Class='expense') or (ns1:Class='')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/StaffingPosition/Rates/Class may only have (one of) the following value(s): TimeInterval, Allowance, Expense, timeInterval, allowance, expense, [Empty]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:StaffingOrder/ns1:StaffingPosition/ns1:Rates/ns1:Amount"
                 priority="1004"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:StaffingPosition/ns1:Rates/ns1:Amount"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@rateAmountPeriod) or (@rateAmountPeriod='x:HourlySplit') or (@rateAmountPeriod='x:HourlyConsolidated') or (@rateAmountPeriod='x:4Weekly') or (@rateAmountPeriod='hourly') or (@rateAmountPeriod='x:hourlysplit') or (@rateAmountPeriod='x:hourlyconsolidated') or (@rateAmountPeriod='daily') or (@rateAmountPeriod='weekly') or (@rateAmountPeriod='x:4weekly') or (@rateAmountPeriod='monthly') or (@rateAmountPeriod='yearly')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@rateAmountPeriod) or (@rateAmountPeriod='x:HourlySplit') or (@rateAmountPeriod='x:HourlyConsolidated') or (@rateAmountPeriod='x:4Weekly') or (@rateAmountPeriod='hourly') or (@rateAmountPeriod='x:hourlysplit') or (@rateAmountPeriod='x:hourlyconsolidated') or (@rateAmountPeriod='daily') or (@rateAmountPeriod='weekly') or (@rateAmountPeriod='x:4weekly') or (@rateAmountPeriod='monthly') or (@rateAmountPeriod='yearly')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/StaffingPosition/Rates/Amount/@rateAmountPeriod may only have (one of) the following value(s): x:HourlySplit, x:HourlyConsolidated, x:4Weekly, hourly, x:hourlysplit, x:hourlyconsolidated, daily, weekly, x:4weekly, monthly, yearly</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:StaffingOrder/ns1:StaffingPosition/ns1:WorkSite/ns1:PostalAddress"
                 priority="1003"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:StaffingPosition/ns1:WorkSite/ns1:PostalAddress"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="matches(ns1:CountryCode, '^[A-Z][A-Z]$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="matches(ns1:CountryCode, '^[A-Z][A-Z]$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/StaffingPosition/WorkSite/PostalAddress/CountryCode must conform to the regular expression: ^[A-Z][A-Z]$</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:StaffingOrder/ns1:StaffingPosition/ns1:StaffingShift"
                 priority="1002"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:StaffingPosition/ns1:StaffingShift"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@shiftPeriod) or (@shiftPeriod='weekly')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@shiftPeriod) or (@shiftPeriod='weekly')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/StaffingPosition/StaffingShift/@shiftPeriod may only have (one of) the following value(s): weekly</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:StaffingOrder/ns1:StaffingPosition/ns1:StaffingShift/ns1:Id"
                 priority="1001"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:StaffingPosition/ns1:StaffingShift/ns1:Id"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(ns1:IdValue) or (ns1:IdValue='')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(ns1:IdValue) or (ns1:IdValue='')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/StaffingPosition/StaffingShift/Id/IdValue may only have (one of) the following value(s): [Empty]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="ns1:StaffingOrder/ns1:UserArea/ns2:StaffingOrderAdditionalNL/ns2:OfferId/ns1:IdValue[2]"
                 priority="1000"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="ns1:StaffingOrder/ns1:UserArea/ns2:StaffingOrderAdditionalNL/ns2:OfferId/ns1:IdValue[2]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name) or (@name='ReactToVersion') or (@name='reacttoversion')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@name) or (@name='ReactToVersion') or (@name='reacttoversion')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>StaffingOrder/UserArea/StaffingOrderAdditionalNL/OfferId/IdValue/@name[2] may only have (one of) the following value(s): ReactToVersion, reacttoversion</svrl:text>
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