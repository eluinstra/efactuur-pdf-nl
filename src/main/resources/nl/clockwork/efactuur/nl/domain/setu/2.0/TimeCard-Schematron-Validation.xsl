<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:schold="http://www.ascc.net/xml/schematron"
                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
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
      <xsl:apply-templates select="/" mode="M2"/>
      <xsl:apply-templates select="/" mode="M3"/>
      <xsl:apply-templates select="/" mode="M4"/>
      <xsl:apply-templates select="/" mode="M5"/>
   </xsl:template>

   <!--SCHEMATRON PATTERNS-->


<!--PATTERN prohibitions-->


	<!--RULE -->
<xsl:template match="hrxml:TimeCard" priority="1040" mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>hrxml:TimeCard may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:UserArea)"/>
         <xsl:otherwise>hrxml:TimeCard may not contain hrxml:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData" priority="1039" mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@type)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData may not contain @type<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"
                 priority="1038"
                 mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Shift)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Shift<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Entity)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Entity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ContactName)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ContactName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AccountCode)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:AccountCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerJobDescription)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobDescription<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExternalReqNumber)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalReqNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationName)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerJobCode)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExternalOrderNumber)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalOrderNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ManagerName)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ManagerName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubEntity)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SubEntity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationCode)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SupervisorName)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SupervisorName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation"
                 priority="1037"
                 mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:UserArea)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:BillToEntityId)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:BillToEntityId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:OrderId)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:OrderId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:MasterOrderId)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:MasterOrderId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:InvoiceId)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:InvoiceId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DocumentId)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:DocumentId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:HumanResourceId)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:HumanResourceId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:IntermediaryId)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:IntermediaryId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PositionId)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:PositionId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:StaffingOrganizationId)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:StaffingOrganizationId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId"
                 priority="1036"
                 mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId/hrxml:IdValue"
                 priority="1035"
                 mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId"
                 priority="1034"
                 mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/hrxml:IdValue"
                 priority="1033"
                 mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId"
                 priority="1032"
                 mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/hrxml:IdValue"
                 priority="1031"
                 mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId"
                 priority="1030"
                 mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/hrxml:IdValue"
                 priority="1029"
                 mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId"
                 priority="1028"
                 mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/hrxml:IdValue"
                 priority="1027"
                 mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ApprovalInfo" priority="1026" mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@approverType)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ApprovalInfo may not contain @approverType<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Comment" priority="1025"
                 mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Comment may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id" priority="1024"
                 mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id/hrxml:IdValue"
                 priority="1023"
                 mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName"
                 priority="1022"
                 mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@script)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName may not contain @script<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AlternateScript)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName may not contain hrxml:AlternateScript<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:Id" priority="1021" mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:Id may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:Id may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:Id/hrxml:IdValue" priority="1020" mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:Id/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedResource" priority="1019" mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Resource)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedResource may not contain hrxml:Resource<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id"
                 priority="1018"
                 mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id/hrxml:IdValue"
                 priority="1017"
                 mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName"
                 priority="1016"
                 mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AlternateScript)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName may not contain hrxml:AlternateScript<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@script)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName may not contain @script<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime" priority="1015" mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:TimeEvent)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:TimeEvent<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ReportedPersonAssignment)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:ReportedPersonAssignment<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Expense)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:Expense<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ApprovalInfo)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:ApprovalInfo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubmitterInfo)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:SubmitterInfo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AdditionalData)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:AdditionalData<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance" priority="1014"
                 mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubmitterInfo)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance may not contain hrxml:SubmitterInfo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ApprovalInfo)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance may not contain hrxml:ApprovalInfo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData"
                 priority="1013"
                 mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@type)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData may not contain @type<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData"
                 priority="1012"
                 mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ReferenceInformation)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData may not contain hrxml:ReferenceInformation<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"
                 priority="1011"
                 mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ManagerName)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ManagerName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ContactName)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ContactName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationCode)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Shift)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Shift<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AccountCode)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:AccountCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Entity)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Entity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubEntity)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SubEntity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationName)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerJobDescription)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobDescription<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExternalOrderNumber)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalOrderNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExternalReqNumber)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalReqNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SupervisorName)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SupervisorName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerJobCode)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Comment"
                 priority="1010"
                 mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Comment may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id"
                 priority="1009"
                 mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval" priority="1008"
                 mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubmitterInfo)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval may not contain hrxml:SubmitterInfo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PieceWork)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval may not contain hrxml:PieceWork<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Allowance)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval may not contain hrxml:Allowance<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ApprovalInfo)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval may not contain hrxml:ApprovalInfo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData"
                 priority="1007"
                 mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@type)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData may not contain @type<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData"
                 priority="1006"
                 mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ReferenceInformation)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData may not contain hrxml:ReferenceInformation<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"
                 priority="1005"
                 mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AccountCode)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:AccountCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExternalReqNumber)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalReqNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ManagerName)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ManagerName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ContactName)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ContactName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Shift)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Shift<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Entity)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Entity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubEntity)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SubEntity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExternalOrderNumber)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalOrderNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationName)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerJobDescription)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobDescription<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SupervisorName)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SupervisorName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationCode)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerJobCode)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Comment"
                 priority="1004"
                 mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Comment may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id"
                 priority="1003"
                 mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id/hrxml:IdValue"
                 priority="1002"
                 mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount"
                 priority="1001"
                 mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@period)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount may not contain @period<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:SubmitterInfo" priority="1000" mode="M2">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Person)"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:SubmitterInfo may not contain hrxml:Person<xsl:value-of select="string('&#xA;')"/>
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

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:ReportedTime) &lt;= 1"/>
         <xsl:otherwise>hrxml:TimeCard may contain hrxml:ReportedTime at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:AdditionalData) &gt;= 1"/>
         <xsl:otherwise>hrxml:TimeCard must contain hrxml:AdditionalData at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:Id) &gt;= 1"/>
         <xsl:otherwise>hrxml:TimeCard must contain hrxml:Id at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData" priority="1022" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingAdditionalData) &gt;= 1 and count(hrxml:StaffingAdditionalData) &lt;= 1"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData must contain hrxml:StaffingAdditionalData at least 1 and at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"
                 priority="1021"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:AdditionalRequirement) &gt;= 1"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements must contain hrxml:AdditionalRequirement at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement"
                 priority="1020"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@requirementTitle) &gt;= 1"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must contain @requirementTitle at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId"
                 priority="1019"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId"
                 priority="1018"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId"
                 priority="1017"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId"
                 priority="1016"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId"
                 priority="1015"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id" priority="1014"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName"
                 priority="1013"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:FamilyName) &lt;= 2"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName may contain hrxml:FamilyName at most 2 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:Id" priority="1012" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:Id may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:Id must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedResource" priority="1011" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:Person) &gt;= 1"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedResource must contain hrxml:Person at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id"
                 priority="1010"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName"
                 priority="1009"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:FamilyName) &lt;= 2"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName may contain hrxml:FamilyName at most 2 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance" priority="1008"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:Amount) &gt;= 1"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance must contain hrxml:Amount at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData"
                 priority="1007"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingAdditionalData) &lt;= 1"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData may contain hrxml:StaffingAdditionalData at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement"
                 priority="1006"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@requirementTitle) &gt;= 1"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must contain @requirementTitle at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id"
                 priority="1005"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue"
                 priority="1004"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@name) &gt;= 1"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue must contain @name at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"
                 priority="1003"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:AdditionalRequirement) &lt;= 1"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may contain hrxml:AdditionalRequirement at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement"
                 priority="1002"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@requirementTitle) &gt;= 1"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must contain @requirementTitle at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id"
                 priority="1001"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount"
                 priority="1000"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@multiplier) &gt;= 1"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount must contain @multiplier at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
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

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="(count(hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId) + count(hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:PurchaseOrderNumber)) &gt;= 1"/>
         <xsl:otherwise>There must be at least one AssignmentId or PurchaseOrderNumber on header level.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData"
                 priority="1022"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:CustomerReportingRequirements) + count(hrxml:ReferenceInformation) &gt; 0"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData must contain CustomerReportingRequirements or ReferenceInformation<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"
                 priority="1021"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:AdditionalRequirement[@requirementTitle = 'VersionId']) = 1"/>
         <xsl:otherwise>There MUST be one CustomerReportingRequirements/AdditionalRequirement with @requirementTitle equal to VersionId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation"
                 priority="1020"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingCustomerId/@idOwner) = count(distinct-values(hrxml:StaffingCustomerId/@idOwner))"/>
         <xsl:otherwise>The same idOwner may not be given for StaffingCustomerId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingCustomerOrgUnitId/@idOwner) = count(distinct-values(hrxml:StaffingCustomerOrgUnitId/@idOwner))"/>
         <xsl:otherwise>The same idOwner may not be given for StaffingCustomerOrgUnitId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingSupplierId/@idOwner) = count(distinct-values(hrxml:StaffingSupplierId/@idOwner))"/>
         <xsl:otherwise>The same idOwner may not be given for StaffingSupplierId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="if (count(hrxml:StaffingCustomerOrgUnitId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingCustomerOrgUnitId[@idOwner = 'KvK']) = 1) else ('true')"/>
         <xsl:otherwise>If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="if (count(hrxml:StaffingCustomerId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingCustomerId[@idOwner = 'KvK']) = 1) else ('true')"/>
         <xsl:otherwise>If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="if (count(hrxml:StaffingSupplierId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingSupplierId[@idOwner = 'KvK']) = 1) else ('true')"/>
         <xsl:otherwise>If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId"
                 priority="1019"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCompany')"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId/@idOwner must have one of the following values: [StaffingCompany]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId"
                 priority="1018"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, OIN, KvK, BTW, Fi, Vest]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId"
                 priority="1017"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, OIN, KvK, BTW, Fi, Vest]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId"
                 priority="1016"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, OIN, KvK, BTW, Fi, Vest]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId"
                 priority="1015"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='KvK') or (@idOwner='OIN') or (@idOwner='BTW') or (@idOwner='Fi')"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, KvK, OIN, BTW, Fi]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName/hrxml:Affix"
                 priority="1014"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@type) or (@type='aristocraticTitle') or (@type='formOfAddress') or (@type='generation') or (@type='qualification')"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName/hrxml:Affix/@type must have one of the following values: [aristocraticTitle, formOfAddress, generation, qualification]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName/hrxml:FamilyName"
                 priority="1013"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@primary) or (@primary='true') or (@primary='false')"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName/hrxml:FamilyName/@primary must have one of the following values: [true, false]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:Id" priority="1012" mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:Id/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id"
                 priority="1011"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName/hrxml:Affix"
                 priority="1010"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@type) or (@type='aristocraticTitle') or (@type='formOfAddress') or (@type='generation') or (@type='qualification')"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName/hrxml:Affix/@type must have one of the following values: [aristocraticTitle, formOfAddress, generation, qualification]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName/hrxml:FamilyName"
                 priority="1009"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@primary) or (@primary='true') or (@primary='false')"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName/hrxml:FamilyName/@primary must have one of the following values: [true, false]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime" priority="1008" mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="(empty(@status) or (@status='rejected') or (@status='corrected')) or (empty(@status) or (@status=''))"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/@status must have one of the following values: [rejected, corrected] OR hrxml:TimeCard/hrxml:ReportedTime/@status must be Empty<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:TimeInterval) + count(hrxml:Allowance) &gt; 0"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime must contain at least one TimeInterval or Allowance<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance" priority="1007"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@actionCode) or (@actionCode='Add') or (@actionCode='Change') or (@actionCode='Void') or (@actionCode='Unchanged')"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/@actionCode must have one of the following values: [Add, Change, Void, Unchanged]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id"
                 priority="1006"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue"
                 priority="1005"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name) or (@name='allowance') or (@name='expense')"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue/@name must have one of the following values: [allowance, expense]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval" priority="1004"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@actionCode) or (@actionCode='Add') or (@actionCode='Change') or (@actionCode='Void') or (@actionCode='Unchanged')"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/@actionCode must have one of the following values: [Add, Change, Void, Unchanged]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:EndDateTime) + count(hrxml:Duration) &gt; 0"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval must have EndDateTime or Duration<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"
                 priority="1003"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AdditionalRequirement) or (hrxml:AdditionalRequirement='true') or (hrxml:AdditionalRequirement='false')"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must have one of the following values: [true, false]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement"
                 priority="1002"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@requirementTitle) or (@requirementTitle='InclusiveRate')"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement/@requirementTitle must have one of the following values: [InclusiveRate]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id"
                 priority="1001"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount"
                 priority="1000"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@type) or (@type='hourly') or (@type='hourlyconsolidated') or (@type='hourlysplit') or (@type='4weekly') or (@type='monthly')"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount/@type must have one of the following values: [hourly, hourlyconsolidated, hourlysplit, 4weekly, monthly]<xsl:value-of select="string('&#xA;')"/>
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

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="text() = '2.0'"/>
         <xsl:otherwise>CustomerReportingRequirements/AdditionalRequirement must have value: 2.0 when requirementTitle is 'VersionId'.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M5"/>
   <xsl:template match="@*|node()" priority="-2" mode="M5">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>
</xsl:stylesheet>