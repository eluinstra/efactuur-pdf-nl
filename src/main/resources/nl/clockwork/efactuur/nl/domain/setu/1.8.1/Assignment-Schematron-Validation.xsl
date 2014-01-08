<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:schold="http://www.ascc.net/xml/schematron"
                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:hrxml="http://ns.hr-xml.org/2007-04-15"
                xmlns:setu="http://ns.setu.nl/2008-01"
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
                              title="Validations for Assignment Mapping; strict=false"
                              schemaVersion="">
         <xsl:comment>
            <xsl:value-of select="$archiveDirParameter"/>   
		 <xsl:value-of select="$archiveNameParameter"/>  
		 <xsl:value-of select="$fileNameParameter"/>  
		 <xsl:value-of select="$fileDirParameter"/>
         </xsl:comment>
         <svrl:ns-prefix-in-attribute-values uri="http://ns.hr-xml.org/2007-04-15" prefix="hrxml"/>
         <svrl:ns-prefix-in-attribute-values uri="http://ns.setu.nl/2008-01" prefix="setu"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">cardinality-redefines</xsl:attribute>
            <xsl:attribute name="name">cardinality-redefines</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M3"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">type-restrictions</xsl:attribute>
            <xsl:attribute name="name">type-restrictions</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M4"/>
      </svrl:schematron-output>
   </xsl:template>

   <!--SCHEMATRON PATTERNS-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Validations for Assignment Mapping; strict=false</svrl:text>

   <!--PATTERN cardinality-redefines-->


	<!--RULE -->
<xsl:template match="hrxml:Assignment" priority="1012" mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="hrxml:Assignment"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:AssignmentId) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:AssignmentId) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment may contain hrxml:AssignmentId at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:Assignment/hrxml:AssignmentDateRange" priority="1011" mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:Assignment/hrxml:AssignmentDateRange"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:ProbationaryPeriod) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:ProbationaryPeriod) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment/hrxml:AssignmentDateRange may contain hrxml:ProbationaryPeriod at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:Assignment/hrxml:AssignmentDateRange/hrxml:ProbationaryPeriod"
                 priority="1010"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:Assignment/hrxml:AssignmentDateRange/hrxml:ProbationaryPeriod"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@unitOfMeasure) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@unitOfMeasure) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment/hrxml:AssignmentDateRange/hrxml:ProbationaryPeriod must contain @unitOfMeasure at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:Assignment/hrxml:AssignmentId" priority="1009" mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:Assignment/hrxml:AssignmentId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:IdValue) &lt;= 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment/hrxml:AssignmentId may contain hrxml:IdValue at most 2 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:Assignment/hrxml:ContractInformation/hrxml:ContractId"
                 priority="1008"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:Assignment/hrxml:ContractInformation/hrxml:ContractId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment/hrxml:ContractInformation/hrxml:ContractId may contain hrxml:IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:Assignment/hrxml:CustomerReportingRequirements" priority="1007"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:Assignment/hrxml:CustomerReportingRequirements"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:AdditionalRequirement) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:AdditionalRequirement) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment/hrxml:CustomerReportingRequirements must contain hrxml:AdditionalRequirement at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:Assignment/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement"
                 priority="1006"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:Assignment/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@requirementTitle) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@requirementTitle) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must contain @requirementTitle at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:Assignment/hrxml:Rates" priority="1005" mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:Assignment/hrxml:Rates"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:Multiplier) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:Multiplier) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment/hrxml:Rates may contain hrxml:Multiplier at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:Assignment/hrxml:ReferenceInformation" priority="1004" mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:Assignment/hrxml:ReferenceInformation"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:HumanResourceId) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:HumanResourceId) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment/hrxml:ReferenceInformation may contain hrxml:HumanResourceId at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:MasterOrderId) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:MasterOrderId) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment/hrxml:ReferenceInformation may contain hrxml:MasterOrderId at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:OrderId) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:OrderId) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment/hrxml:ReferenceInformation may contain hrxml:OrderId at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingCustomerId) &lt;= 3"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:StaffingCustomerId) &lt;= 3">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment/hrxml:ReferenceInformation may contain hrxml:StaffingCustomerId at most 3 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingSupplierId) &lt;= 3"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:StaffingSupplierId) &lt;= 3">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment/hrxml:ReferenceInformation may contain hrxml:StaffingSupplierId at most 3 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:Assignment/hrxml:ReferenceInformation/hrxml:MasterOrderId"
                 priority="1003"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:Assignment/hrxml:ReferenceInformation/hrxml:MasterOrderId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment/hrxml:ReferenceInformation/hrxml:MasterOrderId may contain hrxml:IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:Assignment/hrxml:ReferenceInformation/hrxml:OrderId"
                 priority="1002"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:Assignment/hrxml:ReferenceInformation/hrxml:OrderId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:IdValue) &lt;= 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment/hrxml:ReferenceInformation/hrxml:OrderId may contain hrxml:IdValue at most 2 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:Assignment/hrxml:UserArea" priority="1001" mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:Assignment/hrxml:UserArea"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(setu:AssignmentAdditionalNL) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(setu:AssignmentAdditionalNL) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment/hrxml:UserArea may contain setu:AssignmentAdditionalNL at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:Assignment/hrxml:UserArea/setu:AssignmentAdditionalNL/setu:ProcurementOrderId"
                 priority="1000"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:Assignment/hrxml:UserArea/setu:AssignmentAdditionalNL/setu:ProcurementOrderId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:IdValue) &lt;= 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment/hrxml:UserArea/setu:AssignmentAdditionalNL/setu:ProcurementOrderId may contain hrxml:IdValue at most 2 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M3"/>
   <xsl:template match="@*|node()" priority="-2" mode="M3">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

   <!--PATTERN type-restrictions-->


	<!--RULE -->
<xsl:template match="hrxml:Assignment/hrxml:AssignmentId" priority="1018" mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:Assignment/hrxml:AssignmentId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@idOwner) or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment/hrxml:AssignmentId/@idOwner must have one of the following values: [StaffingCompany, staffingCompany]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:Assignment/hrxml:AssignmentId/hrxml:IdValue[2]" priority="1017"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:Assignment/hrxml:AssignmentId/hrxml:IdValue[2]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name) or (@name='Version') or (@name='version')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@name) or (@name='Version') or (@name='version')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment/hrxml:AssignmentId/hrxml:IdValue/@name must have one of the following values: [Version, version]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:Assignment/hrxml:ContractInformation" priority="1016" mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:Assignment/hrxml:ContractInformation"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ContractId) or (hrxml:ContractId='')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:ContractId) or (hrxml:ContractId='')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment/hrxml:ContractInformation/hrxml:ContractId must be Empty</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ContractVersion) or (hrxml:ContractVersion='')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:ContractVersion) or (hrxml:ContractVersion='')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment/hrxml:ContractInformation/hrxml:ContractVersion must be Empty</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ContractVersionDate) or (hrxml:ContractVersionDate='')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:ContractVersionDate) or (hrxml:ContractVersionDate='')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment/hrxml:ContractInformation/hrxml:ContractVersionDate must be Empty</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LegalInformation) or (hrxml:LegalInformation='')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:LegalInformation) or (hrxml:LegalInformation='')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment/hrxml:ContractInformation/hrxml:LegalInformation must be Empty</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:StaffType) or (hrxml:StaffType='')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:StaffType) or (hrxml:StaffType='')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment/hrxml:ContractInformation/hrxml:StaffType must be Empty</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:Assignment/hrxml:ContractInformation/hrxml:ContractId"
                 priority="1015"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:Assignment/hrxml:ContractInformation/hrxml:ContractId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:IdValue) or (hrxml:IdValue='')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:IdValue) or (hrxml:IdValue='')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment/hrxml:ContractInformation/hrxml:ContractId/hrxml:IdValue must be Empty</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:Assignment/hrxml:CustomerReportingRequirements" priority="1014"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:Assignment/hrxml:CustomerReportingRequirements"/>

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
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:Assignment/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement[@requirementTitle = 'VersionId']"
                 priority="1013"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:Assignment/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement[@requirementTitle = 'VersionId']"/>

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
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:Assignment/hrxml:Rates" priority="1012" mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:Assignment/hrxml:Rates"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@rateStatus) or (@rateStatus='Agreed') or (@rateStatus='agreed')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@rateStatus) or (@rateStatus='Agreed') or (@rateStatus='agreed')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment/hrxml:Rates/@rateStatus must have one of the following values: [Agreed, agreed]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Class) or (hrxml:Class='TimeInterval') or (hrxml:Class='Allowance') or (hrxml:Class='Expense') or (hrxml:Class='timeInterval') or (hrxml:Class='allowance') or (hrxml:Class='expense')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:Class) or (hrxml:Class='TimeInterval') or (hrxml:Class='Allowance') or (hrxml:Class='Expense') or (hrxml:Class='timeInterval') or (hrxml:Class='allowance') or (hrxml:Class='expense')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment/hrxml:Rates/hrxml:Class must have one of the following values: [TimeInterval, Allowance, Expense, timeInterval, allowance, expense]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Description) or (hrxml:Description='Kostenvergoeding') or (hrxml:Description='Vervoerskosten') or (hrxml:Description='Reiskosten') or (hrxml:Description='Kilometervergoeding') or (hrxml:Description='Benzinekosten') or (hrxml:Description='Korting') or (hrxml:Description='Reisuren') or (hrxml:Description='Verblijfskosten') or (hrxml:Description='Maaltijd') or (hrxml:Description='Koffiegeld') or (hrxml:Description='Toeslag') or (hrxml:Description='Toeslag werkomstandigheden') or (hrxml:Description='Toeslag loon') or (hrxml:Description='Toeslag competentie') or (hrxml:Description='Ploegentoeslag') or (hrxml:Description='Opleidingskosten') or (hrxml:Description='Gereedschap') or (hrxml:Description='Kleding') or (hrxml:Description='Communicatiekosten') or (hrxml:Description='Vergoeding') or (hrxml:Description='Uurvergoeding') or (hrxml:Description='Dagvergoeding') or (hrxml:Description='Bijdrage ziektekosten') or (hrxml:Description='Verzekering') or (hrxml:Description='Premie') or (hrxml:Description='Bonus') or (hrxml:Description='Provisie') or (hrxml:Description='Stukloon') or (hrxml:Description='Overige') or (hrxml:Description='Budget') or (hrxml:Description='Incidentele uitkering/ vergoeding') or (hrxml:Description='Inhouding') or (hrxml:Description='Loopbaan') or (hrxml:Description='Loon') or (hrxml:Description='Reservering') or (hrxml:Description='Spaarloon') or (hrxml:Description='Werving en selectie') or (hrxml:Description='Declaratie') or (hrxml:Description='Compensatie/correctie') or (hrxml:Description='Advies/Bemiddeling') or (hrxml:Description='Afschrijving') or (hrxml:Description='Normale/standaard uren') or (hrxml:Description='Overuren') or (hrxml:Description='Ploegentoeslag') or (hrxml:Description='Reisuren') or (hrxml:Description='Onregelmatigheidstoeslag') or (hrxml:Description='Buitengewoon verlof') or (hrxml:Description='Kort verzuim') or (hrxml:Description='Feestdag') or (hrxml:Description='Onbetaald verlof') or (hrxml:Description='Training / scholing') or (hrxml:Description='Verlof') or (hrxml:Description='ADV') or (hrxml:Description='Zieke / ongeval') or (hrxml:Description='Leegloop') or (hrxml:Description='Zorgverlof') or (hrxml:Description='kostenvergoeding') or (hrxml:Description='vervoerskosten') or (hrxml:Description='reiskosten') or (hrxml:Description='kilometervergoeding') or (hrxml:Description='benzinekosten') or (hrxml:Description='korting') or (hrxml:Description='reisuren') or (hrxml:Description='verblijfskosten') or (hrxml:Description='maaltijd') or (hrxml:Description='koffiegeld') or (hrxml:Description='toeslag') or (hrxml:Description='toeslag werkomstandigheden') or (hrxml:Description='toeslag loon') or (hrxml:Description='toeslag competentie') or (hrxml:Description='ploegentoeslag') or (hrxml:Description='opleidingskosten') or (hrxml:Description='gereedschap') or (hrxml:Description='kleding') or (hrxml:Description='communicatiekosten') or (hrxml:Description='vergoeding') or (hrxml:Description='uurvergoeding') or (hrxml:Description='dagvergoeding') or (hrxml:Description='bijdrage ziektekosten') or (hrxml:Description='verzekering') or (hrxml:Description='premie') or (hrxml:Description='bonus') or (hrxml:Description='provisie') or (hrxml:Description='stukloon') or (hrxml:Description='overige') or (hrxml:Description='budget') or (hrxml:Description='incidentele uitkering/ vergoeding') or (hrxml:Description='inhouding') or (hrxml:Description='loopbaan') or (hrxml:Description='loon') or (hrxml:Description='reservering') or (hrxml:Description='spaarloon') or (hrxml:Description='werving en selectie') or (hrxml:Description='declaratie') or (hrxml:Description='compensatie/correctie') or (hrxml:Description='advies/bemiddeling') or (hrxml:Description='afschrijving') or (hrxml:Description='normale/standaard uren') or (hrxml:Description='overuren') or (hrxml:Description='ploegentoeslag') or (hrxml:Description='reisuren') or (hrxml:Description='onregelmatigheidstoeslag') or (hrxml:Description='buitengewoon verlof') or (hrxml:Description='kort verzuim') or (hrxml:Description='feestdag') or (hrxml:Description='onbetaald verlof') or (hrxml:Description='training / scholing') or (hrxml:Description='verlof') or (hrxml:Description='adv') or (hrxml:Description='zieke / ongeval') or (hrxml:Description='leegloop') or (hrxml:Description='zorgverlof')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:Description) or (hrxml:Description='Kostenvergoeding') or (hrxml:Description='Vervoerskosten') or (hrxml:Description='Reiskosten') or (hrxml:Description='Kilometervergoeding') or (hrxml:Description='Benzinekosten') or (hrxml:Description='Korting') or (hrxml:Description='Reisuren') or (hrxml:Description='Verblijfskosten') or (hrxml:Description='Maaltijd') or (hrxml:Description='Koffiegeld') or (hrxml:Description='Toeslag') or (hrxml:Description='Toeslag werkomstandigheden') or (hrxml:Description='Toeslag loon') or (hrxml:Description='Toeslag competentie') or (hrxml:Description='Ploegentoeslag') or (hrxml:Description='Opleidingskosten') or (hrxml:Description='Gereedschap') or (hrxml:Description='Kleding') or (hrxml:Description='Communicatiekosten') or (hrxml:Description='Vergoeding') or (hrxml:Description='Uurvergoeding') or (hrxml:Description='Dagvergoeding') or (hrxml:Description='Bijdrage ziektekosten') or (hrxml:Description='Verzekering') or (hrxml:Description='Premie') or (hrxml:Description='Bonus') or (hrxml:Description='Provisie') or (hrxml:Description='Stukloon') or (hrxml:Description='Overige') or (hrxml:Description='Budget') or (hrxml:Description='Incidentele uitkering/ vergoeding') or (hrxml:Description='Inhouding') or (hrxml:Description='Loopbaan') or (hrxml:Description='Loon') or (hrxml:Description='Reservering') or (hrxml:Description='Spaarloon') or (hrxml:Description='Werving en selectie') or (hrxml:Description='Declaratie') or (hrxml:Description='Compensatie/correctie') or (hrxml:Description='Advies/Bemiddeling') or (hrxml:Description='Afschrijving') or (hrxml:Description='Normale/standaard uren') or (hrxml:Description='Overuren') or (hrxml:Description='Ploegentoeslag') or (hrxml:Description='Reisuren') or (hrxml:Description='Onregelmatigheidstoeslag') or (hrxml:Description='Buitengewoon verlof') or (hrxml:Description='Kort verzuim') or (hrxml:Description='Feestdag') or (hrxml:Description='Onbetaald verlof') or (hrxml:Description='Training / scholing') or (hrxml:Description='Verlof') or (hrxml:Description='ADV') or (hrxml:Description='Zieke / ongeval') or (hrxml:Description='Leegloop') or (hrxml:Description='Zorgverlof') or (hrxml:Description='kostenvergoeding') or (hrxml:Description='vervoerskosten') or (hrxml:Description='reiskosten') or (hrxml:Description='kilometervergoeding') or (hrxml:Description='benzinekosten') or (hrxml:Description='korting') or (hrxml:Description='reisuren') or (hrxml:Description='verblijfskosten') or (hrxml:Description='maaltijd') or (hrxml:Description='koffiegeld') or (hrxml:Description='toeslag') or (hrxml:Description='toeslag werkomstandigheden') or (hrxml:Description='toeslag loon') or (hrxml:Description='toeslag competentie') or (hrxml:Description='ploegentoeslag') or (hrxml:Description='opleidingskosten') or (hrxml:Description='gereedschap') or (hrxml:Description='kleding') or (hrxml:Description='communicatiekosten') or (hrxml:Description='vergoeding') or (hrxml:Description='uurvergoeding') or (hrxml:Description='dagvergoeding') or (hrxml:Description='bijdrage ziektekosten') or (hrxml:Description='verzekering') or (hrxml:Description='premie') or (hrxml:Description='bonus') or (hrxml:Description='provisie') or (hrxml:Description='stukloon') or (hrxml:Description='overige') or (hrxml:Description='budget') or (hrxml:Description='incidentele uitkering/ vergoeding') or (hrxml:Description='inhouding') or (hrxml:Description='loopbaan') or (hrxml:Description='loon') or (hrxml:Description='reservering') or (hrxml:Description='spaarloon') or (hrxml:Description='werving en selectie') or (hrxml:Description='declaratie') or (hrxml:Description='compensatie/correctie') or (hrxml:Description='advies/bemiddeling') or (hrxml:Description='afschrijving') or (hrxml:Description='normale/standaard uren') or (hrxml:Description='overuren') or (hrxml:Description='ploegentoeslag') or (hrxml:Description='reisuren') or (hrxml:Description='onregelmatigheidstoeslag') or (hrxml:Description='buitengewoon verlof') or (hrxml:Description='kort verzuim') or (hrxml:Description='feestdag') or (hrxml:Description='onbetaald verlof') or (hrxml:Description='training / scholing') or (hrxml:Description='verlof') or (hrxml:Description='adv') or (hrxml:Description='zieke / ongeval') or (hrxml:Description='leegloop') or (hrxml:Description='zorgverlof')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment/hrxml:Rates/hrxml:Description must have one of the following values: [Kostenvergoeding, Vervoerskosten, Reiskosten, Kilometervergoeding, Benzinekosten, Korting, Reisuren, Verblijfskosten, Maaltijd, Koffiegeld, Toeslag, Toeslag werkomstandigheden, Toeslag loon, Toeslag competentie, Ploegentoeslag, Opleidingskosten, Gereedschap, Kleding, Communicatiekosten, Vergoeding, Uurvergoeding, Dagvergoeding, Bijdrage ziektekosten, Verzekering, Premie, Bonus, Provisie, Stukloon, Overige, Budget, Incidentele uitkering/ vergoeding, Inhouding, Loopbaan, Loon, Reservering, Spaarloon, Werving en selectie, Declaratie, Compensatie/correctie, Advies/Bemiddeling, Afschrijving, Normale/standaard uren, Overuren, Ploegentoeslag, Reisuren, Onregelmatigheidstoeslag, Buitengewoon verlof, Kort verzuim, Feestdag, Onbetaald verlof, Training / scholing, Verlof, ADV, Zieke / ongeval, Leegloop, Zorgverlof, kostenvergoeding, vervoerskosten, reiskosten, kilometervergoeding, benzinekosten, korting, reisuren, verblijfskosten, maaltijd, koffiegeld, toeslag, toeslag werkomstandigheden, toeslag loon, toeslag competentie, ploegentoeslag, opleidingskosten, gereedschap, kleding, communicatiekosten, vergoeding, uurvergoeding, dagvergoeding, bijdrage ziektekosten, verzekering, premie, bonus, provisie, stukloon, overige, budget, incidentele uitkering/ vergoeding, inhouding, loopbaan, loon, reservering, spaarloon, werving en selectie, declaratie, compensatie/correctie, advies/bemiddeling, afschrijving, normale/standaard uren, overuren, ploegentoeslag, reisuren, onregelmatigheidstoeslag, buitengewoon verlof, kort verzuim, feestdag, onbetaald verlof, training / scholing, verlof, adv, zieke / ongeval, leegloop, zorgverlof]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:Assignment/hrxml:Rates/hrxml:CustomerRateClassification"
                 priority="1011"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:Assignment/hrxml:Rates/hrxml:CustomerRateClassification"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:IdValue) or (hrxml:IdValue='100B') or (hrxml:IdValue='100O') or (hrxml:IdValue='101B') or (hrxml:IdValue='101O') or (hrxml:IdValue='102B') or (hrxml:IdValue='102O') or (hrxml:IdValue='103B') or (hrxml:IdValue='103O') or (hrxml:IdValue='104O') or (hrxml:IdValue='105O') or (hrxml:IdValue='106B') or (hrxml:IdValue='201B') or (hrxml:IdValue='201O') or (hrxml:IdValue='202B') or (hrxml:IdValue='202O') or (hrxml:IdValue='203B') or (hrxml:IdValue='203O') or (hrxml:IdValue='300B') or (hrxml:IdValue='301B') or (hrxml:IdValue='302B') or (hrxml:IdValue='303B') or (hrxml:IdValue='304B') or (hrxml:IdValue='400O') or (hrxml:IdValue='501B') or (hrxml:IdValue='501O') or (hrxml:IdValue='502B') or (hrxml:IdValue='502O') or (hrxml:IdValue='503B') or (hrxml:IdValue='503O') or (hrxml:IdValue='600B') or (hrxml:IdValue='600O') or (hrxml:IdValue='601B') or (hrxml:IdValue='602B') or (hrxml:IdValue='602O') or (hrxml:IdValue='701B') or (hrxml:IdValue='702B') or (hrxml:IdValue='703B') or (hrxml:IdValue='801B') or (hrxml:IdValue='802B') or (hrxml:IdValue='803B') or (hrxml:IdValue='900B') or (hrxml:IdValue='900O') or (hrxml:IdValue='901O') or (hrxml:IdValue='903B') or (hrxml:IdValue='904B') or (hrxml:IdValue='904O') or (hrxml:IdValue='905B') or (hrxml:IdValue='905O') or (hrxml:IdValue='906B') or (hrxml:IdValue='907B') or (hrxml:IdValue='908B') or (hrxml:IdValue='909O') or (hrxml:IdValue='911B') or (hrxml:IdValue='911O') or (hrxml:IdValue='912B') or (hrxml:IdValue='913O') or (hrxml:IdValue='914O') or (hrxml:IdValue='Regular') or (hrxml:IdValue='Overtime') or (hrxml:IdValue='Shift') or (hrxml:IdValue='Travel') or (hrxml:IdValue='Additional') or (hrxml:IdValue='Special Leave') or (hrxml:IdValue='Short leave') or (hrxml:IdValue='Holiday') or (hrxml:IdValue='Unpaid leave') or (hrxml:IdValue='Training') or (hrxml:IdValue='Vacation') or (hrxml:IdValue='Reduction of working hours') or (hrxml:IdValue='Sick time') or (hrxml:IdValue='Work underload') or (hrxml:IdValue='Care Leave') or (hrxml:IdValue='regular') or (hrxml:IdValue='overtime') or (hrxml:IdValue='shift') or (hrxml:IdValue='travel') or (hrxml:IdValue='additional') or (hrxml:IdValue='special leave') or (hrxml:IdValue='short leave') or (hrxml:IdValue='holiday') or (hrxml:IdValue='unpaid leave') or (hrxml:IdValue='training') or (hrxml:IdValue='vacation') or (hrxml:IdValue='reduction of working hours') or (hrxml:IdValue='sick time') or (hrxml:IdValue='work underload') or (hrxml:IdValue='care leave')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:IdValue) or (hrxml:IdValue='100B') or (hrxml:IdValue='100O') or (hrxml:IdValue='101B') or (hrxml:IdValue='101O') or (hrxml:IdValue='102B') or (hrxml:IdValue='102O') or (hrxml:IdValue='103B') or (hrxml:IdValue='103O') or (hrxml:IdValue='104O') or (hrxml:IdValue='105O') or (hrxml:IdValue='106B') or (hrxml:IdValue='201B') or (hrxml:IdValue='201O') or (hrxml:IdValue='202B') or (hrxml:IdValue='202O') or (hrxml:IdValue='203B') or (hrxml:IdValue='203O') or (hrxml:IdValue='300B') or (hrxml:IdValue='301B') or (hrxml:IdValue='302B') or (hrxml:IdValue='303B') or (hrxml:IdValue='304B') or (hrxml:IdValue='400O') or (hrxml:IdValue='501B') or (hrxml:IdValue='501O') or (hrxml:IdValue='502B') or (hrxml:IdValue='502O') or (hrxml:IdValue='503B') or (hrxml:IdValue='503O') or (hrxml:IdValue='600B') or (hrxml:IdValue='600O') or (hrxml:IdValue='601B') or (hrxml:IdValue='602B') or (hrxml:IdValue='602O') or (hrxml:IdValue='701B') or (hrxml:IdValue='702B') or (hrxml:IdValue='703B') or (hrxml:IdValue='801B') or (hrxml:IdValue='802B') or (hrxml:IdValue='803B') or (hrxml:IdValue='900B') or (hrxml:IdValue='900O') or (hrxml:IdValue='901O') or (hrxml:IdValue='903B') or (hrxml:IdValue='904B') or (hrxml:IdValue='904O') or (hrxml:IdValue='905B') or (hrxml:IdValue='905O') or (hrxml:IdValue='906B') or (hrxml:IdValue='907B') or (hrxml:IdValue='908B') or (hrxml:IdValue='909O') or (hrxml:IdValue='911B') or (hrxml:IdValue='911O') or (hrxml:IdValue='912B') or (hrxml:IdValue='913O') or (hrxml:IdValue='914O') or (hrxml:IdValue='Regular') or (hrxml:IdValue='Overtime') or (hrxml:IdValue='Shift') or (hrxml:IdValue='Travel') or (hrxml:IdValue='Additional') or (hrxml:IdValue='Special Leave') or (hrxml:IdValue='Short leave') or (hrxml:IdValue='Holiday') or (hrxml:IdValue='Unpaid leave') or (hrxml:IdValue='Training') or (hrxml:IdValue='Vacation') or (hrxml:IdValue='Reduction of working hours') or (hrxml:IdValue='Sick time') or (hrxml:IdValue='Work underload') or (hrxml:IdValue='Care Leave') or (hrxml:IdValue='regular') or (hrxml:IdValue='overtime') or (hrxml:IdValue='shift') or (hrxml:IdValue='travel') or (hrxml:IdValue='additional') or (hrxml:IdValue='special leave') or (hrxml:IdValue='short leave') or (hrxml:IdValue='holiday') or (hrxml:IdValue='unpaid leave') or (hrxml:IdValue='training') or (hrxml:IdValue='vacation') or (hrxml:IdValue='reduction of working hours') or (hrxml:IdValue='sick time') or (hrxml:IdValue='work underload') or (hrxml:IdValue='care leave')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment/hrxml:Rates/hrxml:CustomerRateClassification/hrxml:IdValue must have one of the following values: [100B, 100O, 101B, 101O, 102B, 102O, 103B, 103O, 104O, 105O, 106B, 201B, 201O, 202B, 202O, 203B, 203O, 300B, 301B, 302B, 303B, 304B, 400O, 501B, 501O, 502B, 502O, 503B, 503O, 600B, 600O, 601B, 602B, 602O, 701B, 702B, 703B, 801B, 802B, 803B, 900B, 900O, 901O, 903B, 904B, 904O, 905B, 905O, 906B, 907B, 908B, 909O, 911B, 911O, 912B, 913O, 914O, Regular, Overtime, Shift, Travel, Additional, Special Leave, Short leave, Holiday, Unpaid leave, Training, Vacation, Reduction of working hours, Sick time, Work underload, Care Leave, regular, overtime, shift, travel, additional, special leave, short leave, holiday, unpaid leave, training, vacation, reduction of working hours, sick time, work underload, care leave]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:Assignment/hrxml:ReferenceInformation" priority="1010" mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:Assignment/hrxml:ReferenceInformation"/>

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
         <xsl:when test="empty(hrxml:PositionId) or (hrxml:PositionId='')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:PositionId) or (hrxml:PositionId='')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment/hrxml:ReferenceInformation/hrxml:PositionId must be Empty</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:Assignment/hrxml:ReferenceInformation/hrxml:HumanResourceId"
                 priority="1009"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:Assignment/hrxml:ReferenceInformation/hrxml:HumanResourceId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='BSN')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@idOwner) or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='BSN')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment/hrxml:ReferenceInformation/hrxml:HumanResourceId/@idOwner must have one of the following values: [StaffingCompany, staffingCompany, BSN]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:Assignment/hrxml:ReferenceInformation/hrxml:OrderId/hrxml:IdValue[2]"
                 priority="1008"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:Assignment/hrxml:ReferenceInformation/hrxml:OrderId/hrxml:IdValue[2]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name) or (@name='ReactToVersion') or (@name='reacttoversion')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@name) or (@name='ReactToVersion') or (@name='reacttoversion')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment/hrxml:ReferenceInformation/hrxml:OrderId/hrxml:IdValue/@name must have one of the following values: [ReactToVersion, reacttoversion]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:Assignment/hrxml:ReferenceInformation/hrxml:PositionId"
                 priority="1007"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:Assignment/hrxml:ReferenceInformation/hrxml:PositionId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:IdValue) or (hrxml:IdValue='')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:IdValue) or (hrxml:IdValue='')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment/hrxml:ReferenceInformation/hrxml:PositionId/hrxml:IdValue must be Empty</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:Assignment/hrxml:ReferenceInformation/hrxml:StaffingCustomerId"
                 priority="1006"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:Assignment/hrxml:ReferenceInformation/hrxml:StaffingCustomerId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingSupplier') or (@idOwner='staffingSupplier') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingSupplier') or (@idOwner='staffingSupplier') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/@idOwner must have one of the following values: [StaffingCustomer, staffingCustomer, StaffingSupplier, staffingSupplier, OIN, KvK, BTW, Fi, Vest]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:Assignment/hrxml:ReferenceInformation/hrxml:StaffingSupplierId"
                 priority="1005"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:Assignment/hrxml:ReferenceInformation/hrxml:StaffingSupplierId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingSupplier') or (@idOwner='staffingSupplier') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingSupplier') or (@idOwner='staffingSupplier') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/@idOwner must have one of the following values: [StaffingCustomer, staffingCustomer, StaffingSupplier, staffingSupplier, OIN, KvK, BTW, Fi, Vest]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:Assignment/hrxml:StaffingShift" priority="1004" mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:Assignment/hrxml:StaffingShift"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@shiftPeriod) or (@shiftPeriod='weekly') or (@shiftPeriod='monthly') or (@shiftPeriod='daily') or (@shiftPeriod='x:4weekly') or (@shiftPeriod='Weekly') or (@shiftPeriod='Monthly') or (@shiftPeriod='Daily') or (@shiftPeriod='x:4Weekly')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@shiftPeriod) or (@shiftPeriod='weekly') or (@shiftPeriod='monthly') or (@shiftPeriod='daily') or (@shiftPeriod='x:4weekly') or (@shiftPeriod='Weekly') or (@shiftPeriod='Monthly') or (@shiftPeriod='Daily') or (@shiftPeriod='x:4Weekly')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment/hrxml:StaffingShift/@shiftPeriod must have one of the following values: [weekly, monthly, daily, x:4weekly, Weekly, Monthly, Daily, x:4Weekly]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Id) or (hrxml:Id='')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:Id) or (hrxml:Id='')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment/hrxml:StaffingShift/hrxml:Id must be Empty</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:Assignment/hrxml:StaffingShift/hrxml:Id" priority="1003" mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:Assignment/hrxml:StaffingShift/hrxml:Id"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:IdValue) or (hrxml:IdValue='')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:IdValue) or (hrxml:IdValue='')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment/hrxml:StaffingShift/hrxml:Id/hrxml:IdValue must be Empty</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:Assignment/hrxml:UserArea/setu:AssignmentAdditionalNL/setu:ProcurementOrderId/hrxml:IdValue[1]"
                 priority="1002"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:Assignment/hrxml:UserArea/setu:AssignmentAdditionalNL/setu:ProcurementOrderId/hrxml:IdValue[1]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name) or (@name='')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@name) or (@name='')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment/hrxml:UserArea/setu:AssignmentAdditionalNL/setu:ProcurementOrderId/hrxml:IdValue/@name must be Empty</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:Assignment/hrxml:UserArea/setu:AssignmentAdditionalNL/setu:ProcurementOrderId/hrxml:IdValue[2]"
                 priority="1001"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:Assignment/hrxml:UserArea/setu:AssignmentAdditionalNL/setu:ProcurementOrderId/hrxml:IdValue[2]"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name) or (@name='ReactToVersion') or (@name='reacttoversion')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@name) or (@name='ReactToVersion') or (@name='reacttoversion')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment/hrxml:UserArea/setu:AssignmentAdditionalNL/setu:ProcurementOrderId/hrxml:IdValue/@name must have one of the following values: [ReactToVersion, reacttoversion]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:Assignment/hrxml:UserArea/setu:AssignmentAdditionalNL/setu:StaffingWorkSite/hrxml:PostalAddress"
                 priority="1000"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:Assignment/hrxml:UserArea/setu:AssignmentAdditionalNL/setu:StaffingWorkSite/hrxml:PostalAddress"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="matches(hrxml:CountryCode, '^[A-Z][A-Z]$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="matches(hrxml:CountryCode, '^[A-Z][A-Z]$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:Assignment/hrxml:UserArea/setu:AssignmentAdditionalNL/setu:StaffingWorkSite/hrxml:PostalAddress/hrxml:CountryCode must match regular expression: ^[A-Z][A-Z]$</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M4"/>
   <xsl:template match="@*|node()" priority="-2" mode="M4">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>
</xsl:stylesheet>