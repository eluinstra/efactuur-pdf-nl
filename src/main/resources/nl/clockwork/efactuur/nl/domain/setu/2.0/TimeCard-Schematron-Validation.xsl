<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:schold="http://www.ascc.net/xml/schematron"
                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
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
                              title="Validations for TimeCard Mapping; strict=false"
                              schemaVersion="">
         <xsl:comment>
            <xsl:value-of select="$archiveDirParameter"/>   
		 <xsl:value-of select="$archiveNameParameter"/>  
		 <xsl:value-of select="$fileNameParameter"/>  
		 <xsl:value-of select="$fileDirParameter"/>
         </xsl:comment>
         <svrl:ns-prefix-in-attribute-values uri="http://ns.hr-xml.org/2007-04-15" prefix="hrxml"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">prohibitions</xsl:attribute>
            <xsl:attribute name="name">prohibitions</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M2"/>
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
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">type-restrictions-1</xsl:attribute>
            <xsl:attribute name="name">type-restrictions-1</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M5"/>
      </svrl:schematron-output>
   </xsl:template>

   <!--SCHEMATRON PATTERNS-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Validations for TimeCard Mapping; strict=false</svrl:text>

   <!--PATTERN prohibitions-->


	<!--RULE -->
<xsl:template match="hrxml:TimeCard" priority="1040" mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="hrxml:TimeCard"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@lang)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard may not contain @lang</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:UserArea)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:UserArea)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard may not contain hrxml:UserArea</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData" priority="1039" mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:AdditionalData"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@type)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@type)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData may not contain @type</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"
                 priority="1038"
                 mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Shift)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:Shift)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Shift</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Entity)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:Entity)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Entity</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ContactName)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:ContactName)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ContactName</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AccountCode)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:AccountCode)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:AccountCode</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerJobDescription)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:CustomerJobDescription)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobDescription</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExternalReqNumber)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:ExternalReqNumber)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalReqNumber</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationName)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:LocationName)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationName</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerJobCode)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:CustomerJobCode)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobCode</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExternalOrderNumber)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:ExternalOrderNumber)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalOrderNumber</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ManagerName)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:ManagerName)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ManagerName</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubEntity)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:SubEntity)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SubEntity</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationCode)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:LocationCode)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationCode</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SupervisorName)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:SupervisorName)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SupervisorName</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation"
                 priority="1037"
                 mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:UserArea)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:UserArea)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:UserArea</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:BillToEntityId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:BillToEntityId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:BillToEntityId</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:OrderId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:OrderId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:OrderId</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:MasterOrderId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:MasterOrderId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:MasterOrderId</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:InvoiceId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:InvoiceId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:InvoiceId</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DocumentId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:DocumentId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:DocumentId</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:HumanResourceId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:HumanResourceId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:HumanResourceId</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:IntermediaryId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:IntermediaryId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:IntermediaryId</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PositionId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:PositionId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:PositionId</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:StaffingOrganizationId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:StaffingOrganizationId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:StaffingOrganizationId</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId"
                 priority="1036"
                 mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@validFrom)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId may not contain @validFrom</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@validTo)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId may not contain @validTo</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId/hrxml:IdValue"
                 priority="1035"
                 mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId/hrxml:IdValue"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@name)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId/hrxml:IdValue may not contain @name</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId"
                 priority="1034"
                 mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@validFrom)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may not contain @validFrom</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@validTo)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may not contain @validTo</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/hrxml:IdValue"
                 priority="1033"
                 mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/hrxml:IdValue"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@name)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/hrxml:IdValue may not contain @name</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId"
                 priority="1032"
                 mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@validTo)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may not contain @validTo</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@validFrom)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may not contain @validFrom</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/hrxml:IdValue"
                 priority="1031"
                 mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/hrxml:IdValue"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@name)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/hrxml:IdValue may not contain @name</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId"
                 priority="1030"
                 mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@validFrom)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may not contain @validFrom</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@validTo)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may not contain @validTo</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/hrxml:IdValue"
                 priority="1029"
                 mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/hrxml:IdValue"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@name)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/hrxml:IdValue may not contain @name</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId"
                 priority="1028"
                 mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@validFrom)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may not contain @validFrom</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@validTo)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may not contain @validTo</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/hrxml:IdValue"
                 priority="1027"
                 mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/hrxml:IdValue"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@name)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/hrxml:IdValue may not contain @name</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ApprovalInfo" priority="1026" mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ApprovalInfo"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@approverType)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@approverType)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ApprovalInfo may not contain @approverType</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Comment" priority="1025"
                 mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Comment"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@lang)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Comment may not contain @lang</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id" priority="1024"
                 mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@validFrom)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id may not contain @validFrom</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@validTo)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id may not contain @validTo</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id/hrxml:IdValue"
                 priority="1023"
                 mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id/hrxml:IdValue"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@name)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id/hrxml:IdValue may not contain @name</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName"
                 priority="1022"
                 mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@script)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@script)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName may not contain @script</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AlternateScript)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:AlternateScript)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName may not contain hrxml:AlternateScript</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:Id" priority="1021" mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="hrxml:TimeCard/hrxml:Id"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@validFrom)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:Id may not contain @validFrom</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@validTo)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:Id may not contain @validTo</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:Id/hrxml:IdValue" priority="1020" mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:Id/hrxml:IdValue"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@name)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:Id/hrxml:IdValue may not contain @name</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedResource" priority="1019" mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedResource"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Resource)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:Resource)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedResource may not contain hrxml:Resource</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id"
                 priority="1018"
                 mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@validFrom)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id may not contain @validFrom</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@validTo)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id may not contain @validTo</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id/hrxml:IdValue"
                 priority="1017"
                 mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id/hrxml:IdValue"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@name)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id/hrxml:IdValue may not contain @name</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName"
                 priority="1016"
                 mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AlternateScript)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:AlternateScript)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName may not contain hrxml:AlternateScript</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@script)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@script)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName may not contain @script</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime" priority="1015" mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedTime"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:TimeEvent)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:TimeEvent)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:TimeEvent</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ReportedPersonAssignment)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:ReportedPersonAssignment)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:ReportedPersonAssignment</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Expense)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:Expense)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:Expense</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ApprovalInfo)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:ApprovalInfo)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:ApprovalInfo</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubmitterInfo)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:SubmitterInfo)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:SubmitterInfo</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AdditionalData)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:AdditionalData)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:AdditionalData</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance" priority="1014"
                 mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubmitterInfo)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:SubmitterInfo)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance may not contain hrxml:SubmitterInfo</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ApprovalInfo)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:ApprovalInfo)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance may not contain hrxml:ApprovalInfo</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData"
                 priority="1013"
                 mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@type)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@type)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData may not contain @type</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData"
                 priority="1012"
                 mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ReferenceInformation)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:ReferenceInformation)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData may not contain hrxml:ReferenceInformation</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"
                 priority="1011"
                 mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ManagerName)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:ManagerName)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ManagerName</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ContactName)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:ContactName)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ContactName</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationCode)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:LocationCode)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationCode</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Shift)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:Shift)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Shift</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AccountCode)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:AccountCode)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:AccountCode</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Entity)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:Entity)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Entity</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubEntity)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:SubEntity)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SubEntity</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationName)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:LocationName)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationName</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerJobDescription)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:CustomerJobDescription)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobDescription</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExternalOrderNumber)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:ExternalOrderNumber)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalOrderNumber</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExternalReqNumber)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:ExternalReqNumber)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalReqNumber</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SupervisorName)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:SupervisorName)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SupervisorName</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerJobCode)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:CustomerJobCode)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobCode</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Comment"
                 priority="1010"
                 mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Comment"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@lang)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Comment may not contain @lang</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id"
                 priority="1009"
                 mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@validTo)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id may not contain @validTo</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@validFrom)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id may not contain @validFrom</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval" priority="1008"
                 mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubmitterInfo)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:SubmitterInfo)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval may not contain hrxml:SubmitterInfo</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PieceWork)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:PieceWork)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval may not contain hrxml:PieceWork</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Allowance)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:Allowance)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval may not contain hrxml:Allowance</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ApprovalInfo)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:ApprovalInfo)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval may not contain hrxml:ApprovalInfo</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData"
                 priority="1007"
                 mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@type)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@type)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData may not contain @type</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData"
                 priority="1006"
                 mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ReferenceInformation)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:ReferenceInformation)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData may not contain hrxml:ReferenceInformation</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"
                 priority="1005"
                 mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AccountCode)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:AccountCode)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:AccountCode</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExternalReqNumber)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:ExternalReqNumber)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalReqNumber</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ManagerName)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:ManagerName)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ManagerName</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ContactName)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:ContactName)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ContactName</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Shift)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:Shift)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Shift</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Entity)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:Entity)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Entity</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubEntity)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:SubEntity)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SubEntity</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExternalOrderNumber)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:ExternalOrderNumber)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalOrderNumber</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationName)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:LocationName)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationName</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerJobDescription)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:CustomerJobDescription)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobDescription</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SupervisorName)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:SupervisorName)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SupervisorName</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationCode)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:LocationCode)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationCode</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerJobCode)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:CustomerJobCode)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobCode</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Comment"
                 priority="1004"
                 mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Comment"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@lang)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Comment may not contain @lang</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id"
                 priority="1003"
                 mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@validTo)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id may not contain @validTo</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@validFrom)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id may not contain @validFrom</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id/hrxml:IdValue"
                 priority="1002"
                 mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id/hrxml:IdValue"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@name)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id/hrxml:IdValue may not contain @name</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount"
                 priority="1001"
                 mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@period)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@period)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount may not contain @period</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:SubmitterInfo" priority="1000" mode="M2">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:SubmitterInfo"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Person)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:Person)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:SubmitterInfo may not contain hrxml:Person</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M2"/>
   <xsl:template match="@*|node()" priority="-2" mode="M2">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

   <!--PATTERN cardinality-redefines-->


	<!--RULE -->
<xsl:template match="hrxml:TimeCard" priority="1023" mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="hrxml:TimeCard"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:ReportedTime) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:ReportedTime) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard may contain hrxml:ReportedTime at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:AdditionalData) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:AdditionalData) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard must contain hrxml:AdditionalData at least 1 time(s)</svrl:text>
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
               <svrl:text>hrxml:TimeCard must contain hrxml:Id at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData" priority="1022" mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:AdditionalData"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingAdditionalData) &gt;= 1 and count(hrxml:StaffingAdditionalData) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:StaffingAdditionalData) &gt;= 1 and count(hrxml:StaffingAdditionalData) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData must contain hrxml:StaffingAdditionalData at least 1 and at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"
                 priority="1021"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:AdditionalRequirement) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:AdditionalRequirement) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements must contain hrxml:AdditionalRequirement at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement"
                 priority="1020"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@requirementTitle) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@requirementTitle) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must contain @requirementTitle at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId"
                 priority="1019"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@idOwner) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId must contain @idOwner at least 1 time(s)</svrl:text>
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
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId may contain hrxml:IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId"
                 priority="1018"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may contain hrxml:IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@idOwner) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId must contain @idOwner at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId"
                 priority="1017"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@idOwner) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId must contain @idOwner at least 1 time(s)</svrl:text>
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
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may contain hrxml:IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId"
                 priority="1016"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@idOwner) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId must contain @idOwner at least 1 time(s)</svrl:text>
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
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may contain hrxml:IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId"
                 priority="1015"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@idOwner) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId must contain @idOwner at least 1 time(s)</svrl:text>
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
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may contain hrxml:IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id" priority="1014"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@idOwner) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id must contain @idOwner at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName"
                 priority="1013"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:FamilyName) &lt;= 2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:FamilyName) &lt;= 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName may contain hrxml:FamilyName at most 2 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:Id" priority="1012" mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="hrxml:TimeCard/hrxml:Id"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@idOwner) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:Id must contain @idOwner at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedResource" priority="1011" mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedResource"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:Person) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:Person) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedResource must contain hrxml:Person at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id"
                 priority="1010"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@idOwner) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id must contain @idOwner at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName"
                 priority="1009"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:FamilyName) &lt;= 2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:FamilyName) &lt;= 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName may contain hrxml:FamilyName at most 2 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance" priority="1008"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:Amount) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:Amount) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance must contain hrxml:Amount at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData"
                 priority="1007"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingAdditionalData) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:StaffingAdditionalData) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData may contain hrxml:StaffingAdditionalData at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement"
                 priority="1006"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@requirementTitle) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@requirementTitle) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must contain @requirementTitle at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id"
                 priority="1005"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@idOwner) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id must contain @idOwner at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue"
                 priority="1004"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@name) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@name) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue must contain @name at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"
                 priority="1003"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:AdditionalRequirement) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:AdditionalRequirement) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may contain hrxml:AdditionalRequirement at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement"
                 priority="1002"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@requirementTitle) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@requirementTitle) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must contain @requirementTitle at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id"
                 priority="1001"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@idOwner) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id must contain @idOwner at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount"
                 priority="1000"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@multiplier) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@multiplier) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount must contain @multiplier at least 1 time(s)</svrl:text>
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
<xsl:template match="hrxml:TimeCard" priority="1023" mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="hrxml:TimeCard"/>

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
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData"
                 priority="1022"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:CustomerReportingRequirements) + count(hrxml:ReferenceInformation) &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:CustomerReportingRequirements) + count(hrxml:ReferenceInformation) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData must contain CustomerReportingRequirements or ReferenceInformation</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"
                 priority="1021"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"/>

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
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation"
                 priority="1020"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation"/>

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
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId"
                 priority="1019"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCompany')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@idOwner) or (@idOwner='StaffingCompany')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId/@idOwner must have one of the following values: [StaffingCompany]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId"
                 priority="1018"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, OIN, KvK, BTW, Fi, Vest]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId"
                 priority="1017"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, OIN, KvK, BTW, Fi, Vest]</svrl:text>
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
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId"
                 priority="1016"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, OIN, KvK, BTW, Fi, Vest]</svrl:text>
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
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId"
                 priority="1015"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='KvK') or (@idOwner='OIN') or (@idOwner='BTW') or (@idOwner='Fi')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='KvK') or (@idOwner='OIN') or (@idOwner='BTW') or (@idOwner='Fi')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, KvK, OIN, BTW, Fi]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName/hrxml:Affix"
                 priority="1014"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName/hrxml:Affix"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@type) or (@type='aristocraticTitle') or (@type='formOfAddress') or (@type='generation') or (@type='qualification')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@type) or (@type='aristocraticTitle') or (@type='formOfAddress') or (@type='generation') or (@type='qualification')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName/hrxml:Affix/@type must have one of the following values: [aristocraticTitle, formOfAddress, generation, qualification]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName/hrxml:FamilyName"
                 priority="1013"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName/hrxml:FamilyName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@primary) or (@primary='true') or (@primary='false')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@primary) or (@primary='true') or (@primary='false')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName/hrxml:FamilyName/@primary must have one of the following values: [true, false]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:Id" priority="1012" mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="hrxml:TimeCard/hrxml:Id"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:Id/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id"
                 priority="1011"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName/hrxml:Affix"
                 priority="1010"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName/hrxml:Affix"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@type) or (@type='aristocraticTitle') or (@type='formOfAddress') or (@type='generation') or (@type='qualification')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@type) or (@type='aristocraticTitle') or (@type='formOfAddress') or (@type='generation') or (@type='qualification')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName/hrxml:Affix/@type must have one of the following values: [aristocraticTitle, formOfAddress, generation, qualification]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName/hrxml:FamilyName"
                 priority="1009"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName/hrxml:FamilyName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@primary) or (@primary='true') or (@primary='false')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@primary) or (@primary='true') or (@primary='false')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName/hrxml:FamilyName/@primary must have one of the following values: [true, false]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime" priority="1008" mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedTime"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(empty(@status) or (@status='rejected') or (@status='corrected')) or (empty(@status) or (@status=''))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(empty(@status) or (@status='rejected') or (@status='corrected')) or (empty(@status) or (@status=''))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/@status must have one of the following values: [rejected, corrected] OR hrxml:TimeCard/hrxml:ReportedTime/@status must be Empty</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:TimeInterval) + count(hrxml:Allowance) &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:TimeInterval) + count(hrxml:Allowance) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime must contain at least one TimeInterval or Allowance</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance" priority="1007"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@actionCode) or (@actionCode='Add') or (@actionCode='Change') or (@actionCode='Void') or (@actionCode='Unchanged')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@actionCode) or (@actionCode='Add') or (@actionCode='Change') or (@actionCode='Void') or (@actionCode='Unchanged')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/@actionCode must have one of the following values: [Add, Change, Void, Unchanged]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id"
                 priority="1006"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue"
                 priority="1005"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name) or (@name='allowance') or (@name='expense')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@name) or (@name='allowance') or (@name='expense')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue/@name must have one of the following values: [allowance, expense]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval" priority="1004"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@actionCode) or (@actionCode='Add') or (@actionCode='Change') or (@actionCode='Void') or (@actionCode='Unchanged')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@actionCode) or (@actionCode='Add') or (@actionCode='Change') or (@actionCode='Void') or (@actionCode='Unchanged')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/@actionCode must have one of the following values: [Add, Change, Void, Unchanged]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:EndDateTime) + count(hrxml:Duration) &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:EndDateTime) + count(hrxml:Duration) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval must have EndDateTime or Duration</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"
                 priority="1003"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AdditionalRequirement) or (hrxml:AdditionalRequirement='true') or (hrxml:AdditionalRequirement='false')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:AdditionalRequirement) or (hrxml:AdditionalRequirement='true') or (hrxml:AdditionalRequirement='false')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must have one of the following values: [true, false]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement"
                 priority="1002"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@requirementTitle) or (@requirementTitle='InclusiveRate')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@requirementTitle) or (@requirementTitle='InclusiveRate')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement/@requirementTitle must have one of the following values: [InclusiveRate]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id"
                 priority="1001"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount"
                 priority="1000"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@type) or (@type='hourly') or (@type='hourlyconsolidated') or (@type='hourlysplit') or (@type='4weekly') or (@type='monthly')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@type) or (@type='hourly') or (@type='hourlyconsolidated') or (@type='hourlysplit') or (@type='4weekly') or (@type='monthly')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount/@type must have one of the following values: [hourly, hourlyconsolidated, hourlysplit, 4weekly, monthly]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M4"/>
   <xsl:template match="@*|node()" priority="-2" mode="M4">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

   <!--PATTERN type-restrictions-1-->


	<!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement[@requirementTitle = 'VersionId']"
                 priority="1000"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement[@requirementTitle = 'VersionId']"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="text() = '2.0'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="text() = '2.0'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>CustomerReportingRequirements/AdditionalRequirement must have value: 2.0 when requirementTitle is 'VersionId'.</svrl:text>
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