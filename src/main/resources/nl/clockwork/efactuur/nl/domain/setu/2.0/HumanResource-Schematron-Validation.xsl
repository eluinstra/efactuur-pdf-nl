<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:schold="http://www.ascc.net/xml/schematron"
                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:hrxml="http://ns.hr-xml.org/2007-04-15"
                xmlns:setu="http://ns.setu.nl/2012-01"
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
      <xsl:apply-templates select="/" mode="M3"/>
      <xsl:apply-templates select="/" mode="M4"/>
      <xsl:apply-templates select="/" mode="M5"/>
      <xsl:apply-templates select="/" mode="M6"/>
      <xsl:apply-templates select="/" mode="M7"/>
   </xsl:template>

   <!--SCHEMATRON PATTERNS-->


<!--PATTERN prohibitions-->


	<!--RULE -->
<xsl:template match="hrxml:HumanResource" priority="1072" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ResourceScreening)"/>
         <xsl:otherwise>hrxml:HumanResource may not contain hrxml:ResourceScreening<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SocialInsurance)"/>
         <xsl:otherwise>hrxml:HumanResource may not contain hrxml:SocialInsurance<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>hrxml:HumanResource may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:HumanResourceId" priority="1071" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:HumanResourceId may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:HumanResourceId may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:HumanResourceId/hrxml:IdValue" priority="1070"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:HumanResourceId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:HumanResourceStatus" priority="1069" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@statusChangeReason)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:HumanResourceStatus may not contain @statusChangeReason<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Preferences" priority="1068" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DistributionRestrictions)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Preferences may not contain hrxml:DistributionRestrictions<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Commute)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Preferences may not contain hrxml:Commute<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Relocation)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Preferences may not contain hrxml:Relocation<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Travel)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Preferences may not contain hrxml:Travel<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DesiredShift)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Preferences may not contain hrxml:DesiredShift<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DesiredCompensation)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Preferences may not contain hrxml:DesiredCompensation<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile" priority="1067" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PositionHeader)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile may not contain hrxml:PositionHeader<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Competency)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile may not contain hrxml:Competency<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume" priority="1066"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:NonXMLResume)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume may not contain hrxml:NonXMLResume<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ResumeId)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume may not contain hrxml:ResumeId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:UserArea)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume may not contain hrxml:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DistributionGuidelines)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume may not contain hrxml:DistributionGuidelines<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume"
                 priority="1065"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExecutiveSummary)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume may not contain hrxml:ExecutiveSummary<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:MilitaryHistory)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume may not contain hrxml:MilitaryHistory<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:RevisionDate)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume may not contain hrxml:RevisionDate<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PublicationHistory)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume may not contain hrxml:PublicationHistory<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Comments)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume may not contain hrxml:Comments<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SpeakingEventsHistory)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume may not contain hrxml:SpeakingEventsHistory<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ResumeAdditionalItems)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume may not contain hrxml:ResumeAdditionalItems<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Languages)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume may not contain hrxml:Languages<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PatentHistory)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume may not contain hrxml:PatentHistory<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:References)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume may not contain hrxml:References<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Objective)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume may not contain hrxml:Objective<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Achievements)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume may not contain hrxml:Achievements<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Associations)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume may not contain hrxml:Associations<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SecurityCredentials)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume may not contain hrxml:SecurityCredentials<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ContactInfo)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume may not contain hrxml:ContactInfo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ProfessionalAssociations)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume may not contain hrxml:ProfessionalAssociations<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution"
                 priority="1064"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationSummary)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:LocationSummary<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PostalAddress)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:PostalAddress<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ISCEDInstitutionClassification)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:ISCEDInstitutionClassification<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:OrganizationUnit)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:OrganizationUnit<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SchoolName)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:SchoolName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Measure)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:Measure<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:School)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:School<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Minor)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:Minor<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Comments)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:Comments<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:UserArea)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Major)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:Major<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance"
                 priority="1063"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@enrollmentStatus)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance may not contain @enrollmentStatus<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@currentlyEnrolled)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance may not contain @currentlyEnrolled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@studentInGoodStanding)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance may not contain @studentInGoodStanding<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance/hrxml:EndDate"
                 priority="1062"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:MonthDay)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance/hrxml:EndDate may not contain hrxml:MonthDay<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:StringDate)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance/hrxml:EndDate may not contain hrxml:StringDate<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Year)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance/hrxml:EndDate may not contain hrxml:Year<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:YearMonth)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance/hrxml:EndDate may not contain hrxml:YearMonth<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@dateDescription)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance/hrxml:EndDate may not contain @dateDescription<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance/hrxml:StartDate"
                 priority="1061"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:YearMonth)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance/hrxml:StartDate may not contain hrxml:YearMonth<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:MonthDay)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance/hrxml:StartDate may not contain hrxml:MonthDay<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@dateDescription)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance/hrxml:StartDate may not contain @dateDescription<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:StringDate)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance/hrxml:StartDate may not contain hrxml:StringDate<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Year)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance/hrxml:StartDate may not contain hrxml:Year<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree"
                 priority="1060"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Comments)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:Comments<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:OtherHonors)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:OtherHonors<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DegreeMajor)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:DegreeMajor<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DatesOfAttendance)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:DatesOfAttendance<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DegreeMinor)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:DegreeMinor<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DegreeMeasure)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:DegreeMeasure<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DegreeClassification)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:DegreeClassification<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:UserArea)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@examPassed)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain @examPassed<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@graduatingDegree)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain @graduatingDegree<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DegreeDate)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:DegreeDate<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree/hrxml:DegreeName"
                 priority="1059"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@honorsProgram)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree/hrxml:DegreeName may not contain @honorsProgram<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@academicHonors)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree/hrxml:DegreeName may not contain @academicHonors<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id"
                 priority="1058"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id/hrxml:IdValue"
                 priority="1057"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg"
                 priority="1056"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:UserArea)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg may not contain hrxml:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@employerOrgType)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg may not contain @employerOrgType<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo"
                 priority="1055"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationSummary)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo may not contain hrxml:LocationSummary<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:InternetDomainName)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo may not contain hrxml:InternetDomainName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@contactType)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo may not contain @contactType<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod"
                 priority="1054"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:TTYTDD)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod may not contain hrxml:TTYTDD<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:WhenAvailable)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod may not contain hrxml:WhenAvailable<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Location)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod may not contain hrxml:Location<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PostalAddress)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod may not contain hrxml:PostalAddress<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Use)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod may not contain hrxml:Use<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Pager)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod may not contain hrxml:Pager<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod/hrxml:Fax"
                 priority="1053"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:InternationalCountryCode)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:InternationalCountryCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:NationalNumber)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:NationalNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubscriberNumber)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:SubscriberNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Extension)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:Extension<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AreaCityCode)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:AreaCityCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod/hrxml:Mobile"
                 priority="1052"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Extension)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:Extension<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:InternationalCountryCode)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:InternationalCountryCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AreaCityCode)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:AreaCityCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@smsEnabled)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain @smsEnabled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:NationalNumber)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:NationalNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubscriberNumber)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:SubscriberNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod/hrxml:Telephone"
                 priority="1051"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubscriberNumber)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:SubscriberNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Extension)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:Extension<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:InternationalCountryCode)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:InternationalCountryCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:NationalNumber)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:NationalNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AreaCityCode)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:AreaCityCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:PersonName"
                 priority="1050"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@script)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:PersonName may not contain @script<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:MiddleName)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:PersonName may not contain hrxml:MiddleName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LegalName)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:PersonName may not contain hrxml:LegalName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:FamilyName)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:PersonName may not contain hrxml:FamilyName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:GivenName)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:PersonName may not contain hrxml:GivenName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AlternateScript)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:PersonName may not contain hrxml:AlternateScript<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Affix)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:PersonName may not contain hrxml:Affix<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PreferredGivenName)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:PersonName may not contain hrxml:PreferredGivenName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory"
                 priority="1049"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:JobLevelInfo)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory may not contain hrxml:JobLevelInfo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:OrgInfo)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory may not contain hrxml:OrgInfo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:JobCategory)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory may not contain hrxml:JobCategory<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Comments)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory may not contain hrxml:Comments<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:UserArea)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory may not contain hrxml:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@positionType)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory may not contain @positionType<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Title)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory may not contain hrxml:Title<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:OrgSize)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory may not contain hrxml:OrgSize<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Verification)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory may not contain hrxml:Verification<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Compensation)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory may not contain hrxml:Compensation<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:OrgIndustry)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory may not contain hrxml:OrgIndustry<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@currentEmployer)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory may not contain @currentEmployer<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Competency)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory may not contain hrxml:Competency<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory/hrxml:EndDate"
                 priority="1048"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Year)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory/hrxml:EndDate may not contain hrxml:Year<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:StringDate)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory/hrxml:EndDate may not contain hrxml:StringDate<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:MonthDay)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory/hrxml:EndDate may not contain hrxml:MonthDay<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:YearMonth)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory/hrxml:EndDate may not contain hrxml:YearMonth<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@dateDescription)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory/hrxml:EndDate may not contain @dateDescription<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory/hrxml:OrgName"
                 priority="1047"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:OrgName)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory/hrxml:OrgName may not contain hrxml:OrgName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@organizationType)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory/hrxml:OrgName may not contain @organizationType<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory/hrxml:StartDate"
                 priority="1046"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@dateDescription)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory/hrxml:StartDate may not contain @dateDescription<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:StringDate)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory/hrxml:StartDate may not contain hrxml:StringDate<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:MonthDay)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory/hrxml:StartDate may not contain hrxml:MonthDay<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:YearMonth)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory/hrxml:StartDate may not contain hrxml:YearMonth<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Year)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory/hrxml:StartDate may not contain hrxml:Year<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:EffectiveDate/hrxml:FirstIssuedDate"
                 priority="1045"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:MonthDay)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:EffectiveDate/hrxml:FirstIssuedDate may not contain hrxml:MonthDay<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Year)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:EffectiveDate/hrxml:FirstIssuedDate may not contain hrxml:Year<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@dateDescription)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:EffectiveDate/hrxml:FirstIssuedDate may not contain @dateDescription<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:YearMonth)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:EffectiveDate/hrxml:FirstIssuedDate may not contain hrxml:YearMonth<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:StringDate)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:EffectiveDate/hrxml:FirstIssuedDate may not contain hrxml:StringDate<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:EffectiveDate/hrxml:ValidFrom"
                 priority="1044"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@dateDescription)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:EffectiveDate/hrxml:ValidFrom may not contain @dateDescription<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:YearMonth)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:EffectiveDate/hrxml:ValidFrom may not contain hrxml:YearMonth<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Year)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:EffectiveDate/hrxml:ValidFrom may not contain hrxml:Year<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:MonthDay)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:EffectiveDate/hrxml:ValidFrom may not contain hrxml:MonthDay<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:StringDate)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:EffectiveDate/hrxml:ValidFrom may not contain hrxml:StringDate<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:EffectiveDate/hrxml:ValidTo"
                 priority="1043"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:YearMonth)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:EffectiveDate/hrxml:ValidTo may not contain hrxml:YearMonth<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Year)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:EffectiveDate/hrxml:ValidTo may not contain hrxml:Year<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:StringDate)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:EffectiveDate/hrxml:ValidTo may not contain hrxml:StringDate<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:MonthDay)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:EffectiveDate/hrxml:ValidTo may not contain hrxml:MonthDay<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@dateDescription)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:EffectiveDate/hrxml:ValidTo may not contain @dateDescription<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:IssuingAuthority"
                 priority="1042"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@countryCode)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:IssuingAuthority may not contain @countryCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:Qualifications"
                 priority="1041"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:QualificationSummary)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:Qualifications may not contain hrxml:QualificationSummary<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency"
                 priority="1040"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CompetencyId)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency may not contain hrxml:CompetencyId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@required)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency may not contain @required<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:UserArea)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency may not contain hrxml:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CompetencyWeight)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency may not contain hrxml:CompetencyWeight<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Competency)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency may not contain hrxml:Competency<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CompetencyEvidence)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency may not contain hrxml:CompetencyEvidence<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:TaxonomyId)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency may not contain hrxml:TaxonomyId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:SupportingMaterials"
                 priority="1039"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Link)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:SupportingMaterials may not contain hrxml:Link<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:SupportingMaterials/hrxml:AttachmentReference"
                 priority="1038"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@context)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:SupportingMaterials/hrxml:AttachmentReference may not contain @context<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Rates" priority="1037" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:BillingMultiplier)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Rates may not contain hrxml:BillingMultiplier<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Rates may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:TimeWorkedRounding)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Rates may not contain hrxml:TimeWorkedRounding<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:StaffingShiftId)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Rates may not contain hrxml:StaffingShiftId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Rates/hrxml:CustomerRateClassification"
                 priority="1036"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Rates/hrxml:CustomerRateClassification may not contain @idOwner<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Rates/hrxml:CustomerRateClassification may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Rates/hrxml:CustomerRateClassification may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Rates/hrxml:ExternalRateSetId" priority="1035"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Rates/hrxml:ExternalRateSetId may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Rates/hrxml:ExternalRateSetId may not contain @idOwner<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Rates/hrxml:ExternalRateSetId may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Rates/hrxml:ExternalRateSetId/hrxml:IdValue"
                 priority="1034"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Rates/hrxml:ExternalRateSetId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Rates/hrxml:Multiplier" priority="1033"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@percentIndicator)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Rates/hrxml:Multiplier may not contain @percentIndicator<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Rates/hrxml:RatesId" priority="1032" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Rates/hrxml:RatesId may not contain @idOwner<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Rates/hrxml:RatesId may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Rates/hrxml:RatesId may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Rates/hrxml:RatesId/hrxml:IdValue"
                 priority="1031"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Rates/hrxml:RatesId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:ReferenceInformation" priority="1030"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:StaffingOrganizationId)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation may not contain hrxml:StaffingOrganizationId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:UserArea)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation may not contain hrxml:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AssignmentId)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation may not contain hrxml:AssignmentId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PositionId)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation may not contain hrxml:PositionId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:TimeCardId)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation may not contain hrxml:TimeCardId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:IntermediaryId)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation may not contain hrxml:IntermediaryId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:InvoiceId)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation may not contain hrxml:InvoiceId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:MasterOrderId)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation may not contain hrxml:MasterOrderId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:BillToEntityId)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation may not contain hrxml:BillToEntityId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:OrderId"
                 priority="1029"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:OrderId may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:OrderId may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:OrderId/hrxml:IdValue"
                 priority="1028"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:OrderId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerId"
                 priority="1027"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/hrxml:IdValue"
                 priority="1026"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId"
                 priority="1025"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/hrxml:IdValue"
                 priority="1024"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierId"
                 priority="1023"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/hrxml:IdValue"
                 priority="1022"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId"
                 priority="1021"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/hrxml:IdValue"
                 priority="1020"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:ResourceInformation" priority="1019" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ResourceType)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ResourceInformation may not contain hrxml:ResourceType<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo"
                 priority="1018"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PersonName)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo may not contain hrxml:PersonName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod"
                 priority="1017"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Pager)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod may not contain hrxml:Pager<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Location)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod may not contain hrxml:Location<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:WhenAvailable)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod may not contain hrxml:WhenAvailable<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:TTYTDD)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod may not contain hrxml:TTYTDD<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PostalAddress)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod may not contain hrxml:PostalAddress<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Use)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod may not contain hrxml:Use<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:Fax"
                 priority="1016"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubscriberNumber)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:SubscriberNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:NationalNumber)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:NationalNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AreaCityCode)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:AreaCityCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:InternationalCountryCode)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:InternationalCountryCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Extension)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:Extension<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:Mobile"
                 priority="1015"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@smsEnabled)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain @smsEnabled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Extension)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:Extension<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AreaCityCode)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:AreaCityCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubscriberNumber)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:SubscriberNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:NationalNumber)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:NationalNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:InternationalCountryCode)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:InternationalCountryCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:Telephone"
                 priority="1014"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:NationalNumber)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:NationalNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubscriberNumber)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:SubscriberNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Extension)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:Extension<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:InternationalCountryCode)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:InternationalCountryCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AreaCityCode)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:AreaCityCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:ResourceInformation/hrxml:PersonName"
                 priority="1013"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@script)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ResourceInformation/hrxml:PersonName may not contain @script<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AlternateScript)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ResourceInformation/hrxml:PersonName may not contain hrxml:AlternateScript<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:ResourceInformation/hrxml:PostalAddress"
                 priority="1012"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Region)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ResourceInformation/hrxml:PostalAddress may not contain hrxml:Region<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@type)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ResourceInformation/hrxml:PostalAddress may not contain @type<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Recipient)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ResourceInformation/hrxml:PostalAddress may not contain hrxml:Recipient<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:ResourceInformation/hrxml:PostalAddress/hrxml:DeliveryAddress"
                 priority="1011"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AddressLine)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ResourceInformation/hrxml:PostalAddress/hrxml:DeliveryAddress may not contain hrxml:AddressLine<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PostOfficeBox)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ResourceInformation/hrxml:PostalAddress/hrxml:DeliveryAddress may not contain hrxml:PostOfficeBox<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements"
                 priority="1010"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExternalOrderNumber)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements may not contain hrxml:ExternalOrderNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CostCenterName)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements may not contain hrxml:CostCenterName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationName)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements may not contain hrxml:LocationName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CostCenterCode)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements may not contain hrxml:CostCenterCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ProjectCode)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements may not contain hrxml:ProjectCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AccountCode)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements may not contain hrxml:AccountCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Entity)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements may not contain hrxml:Entity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationCode)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements may not contain hrxml:LocationCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DepartmentCode)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements may not contain hrxml:DepartmentCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExternalReqNumber)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements may not contain hrxml:ExternalReqNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PurchaseOrderLineItem)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements may not contain hrxml:PurchaseOrderLineItem<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerJobCode)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements may not contain hrxml:CustomerJobCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SupervisorName)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements may not contain hrxml:SupervisorName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubEntity)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements may not contain hrxml:SubEntity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DepartmentName)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements may not contain hrxml:DepartmentName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ContactName)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements may not contain hrxml:ContactName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ManagerName)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements may not contain hrxml:ManagerName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerReferenceNumber)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements may not contain hrxml:CustomerReferenceNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Shift)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements may not contain hrxml:Shift<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerJobDescription)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements may not contain hrxml:CustomerJobDescription<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:OfferId"
                 priority="1009"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:OfferId may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:OfferId may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:OfferId/hrxml:IdValue"
                 priority="1008"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:OfferId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift"
                 priority="1007"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:TypeHours)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift may not contain hrxml:TypeHours<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:StartTime)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift may not contain hrxml:StartTime<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExternalStaffingShiftSetId)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift may not contain hrxml:ExternalStaffingShiftSetId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Name)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift may not contain hrxml:Name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:EndTime)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift may not contain hrxml:EndTime<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Comment)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift may not contain hrxml:Comment<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift/hrxml:Id"
                 priority="1006"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift/hrxml:Id may not contain @idOwner<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift/hrxml:Id may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift/hrxml:Id may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift/hrxml:Id/hrxml:IdValue"
                 priority="1005"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift/hrxml:Id/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo"
                 priority="1004"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PersonName)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo may not contain hrxml:PersonName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod"
                 priority="1003"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Location)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod may not contain hrxml:Location<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:WhenAvailable)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod may not contain hrxml:WhenAvailable<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Use)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod may not contain hrxml:Use<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PostalAddress)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod may not contain hrxml:PostalAddress<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:TTYTDD)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod may not contain hrxml:TTYTDD<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Pager)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod may not contain hrxml:Pager<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:Fax"
                 priority="1002"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubscriberNumber)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:SubscriberNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:InternationalCountryCode)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:InternationalCountryCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Extension)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:Extension<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:NationalNumber)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:NationalNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AreaCityCode)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:AreaCityCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:Mobile"
                 priority="1001"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@smsEnabled)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain @smsEnabled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Extension)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:Extension<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubscriberNumber)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:SubscriberNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AreaCityCode)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:AreaCityCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:InternationalCountryCode)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:InternationalCountryCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:NationalNumber)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:NationalNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:Telephone"
                 priority="1000"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Extension)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:Extension<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:InternationalCountryCode)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:InternationalCountryCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AreaCityCode)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:AreaCityCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:NationalNumber)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:NationalNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubscriberNumber)"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:SubscriberNumber<xsl:value-of select="string('&#xA;')"/>
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
<xsl:template match="hrxml:HumanResource" priority="1029" mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:UserArea) &gt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource must contain hrxml:UserArea at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:HumanResourceId) &lt;= 2"/>
         <xsl:otherwise>hrxml:HumanResource may contain hrxml:HumanResourceId at most 2 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:HumanResourceId" priority="1028" mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:HumanResourceId must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:HumanResourceId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution"
                 priority="1027"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:LocalInstitutionClassification) &lt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may contain hrxml:LocalInstitutionClassification at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:Degree) &lt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may contain hrxml:Degree at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance"
                 priority="1026"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StartDate) &lt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance may contain hrxml:StartDate at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:EndDate) &lt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance may contain hrxml:EndDate at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance/hrxml:StartDate"
                 priority="1025"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:AnyDate) &gt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance/hrxml:StartDate must contain hrxml:AnyDate at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id"
                 priority="1024"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo"
                 priority="1023"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:ContactMethod) &lt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo may contain hrxml:ContactMethod at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory/hrxml:StartDate"
                 priority="1022"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:AnyDate) &gt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory/hrxml:StartDate must contain hrxml:AnyDate at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency"
                 priority="1021"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@name) &gt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency must contain @name at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@description) &gt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency must contain @description at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:SupportingMaterials"
                 priority="1020"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:AttachmentReference) &gt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:SupportingMaterials must contain hrxml:AttachmentReference at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:Description) &gt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:SupportingMaterials must contain hrxml:Description at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:SupportingMaterials/hrxml:AttachmentReference"
                 priority="1019"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@mimeType) &gt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:SupportingMaterials/hrxml:AttachmentReference must contain @mimeType at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Rates" priority="1018" mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:Multiplier) &lt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Rates may contain hrxml:Multiplier at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Rates/hrxml:CustomerRateClassification"
                 priority="1017"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Rates/hrxml:CustomerRateClassification may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Rates/hrxml:ExternalRateSetId" priority="1016"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Rates/hrxml:ExternalRateSetId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Rates/hrxml:RatesId" priority="1015" mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Rates/hrxml:RatesId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:ReferenceInformation" priority="1014"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:OrderId) &lt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation may contain hrxml:OrderId at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:OrderId"
                 priority="1013"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:OrderId must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:OrderId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerId"
                 priority="1012"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerId must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId"
                 priority="1011"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierId"
                 priority="1010"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierId must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId"
                 priority="1009"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo"
                 priority="1008"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:ContactMethod) &lt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo may contain hrxml:ContactMethod at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:ResourceInformation/hrxml:PersonName"
                 priority="1007"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:FamilyName) &lt;= 2"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ResourceInformation/hrxml:PersonName may contain hrxml:FamilyName at most 2 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:UserArea" priority="1006" mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(setu:HumanResourceAdditionalNL) &gt;= 1 and count(setu:HumanResourceAdditionalNL) &lt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea must contain setu:HumanResourceAdditionalNL at least 1 and at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL"
                 priority="1005"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(setu:CustomerReportingRequirements) &gt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL must contain setu:CustomerReportingRequirements at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements"
                 priority="1004"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:AdditionalRequirement) &gt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements must contain hrxml:AdditionalRequirement at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements/hrxml:AdditionalRequirement"
                 priority="1003"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@requirementTitle) &gt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements/hrxml:AdditionalRequirement must contain @requirementTitle at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:OfferId"
                 priority="1002"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:OfferId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:OfferId must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift"
                 priority="1001"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@shiftPeriod) &gt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift must contain @shiftPeriod at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo"
                 priority="1000"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:ContactMethod) &lt;= 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo may contain hrxml:ContactMethod at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
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
<xsl:template match="hrxml:HumanResource" priority="1023" mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Preferences) or (hrxml:Preferences='')"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Preferences must be Empty<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:HumanResourceId" priority="1022" mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:HumanResourceId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:HumanResourceStatus" priority="1021" mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@status) or (@status='new') or (@status='accepted') or (@status='x:assigned') or (@status='revised') or (@status='withdrawn') or (@status='rejected')"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:HumanResourceStatus/@status must have one of the following values: [new, accepted, x:assigned, revised, withdrawn, rejected]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree"
                 priority="1020"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@degreeType) or (@degreeType='1') or (@degreeType='2') or (@degreeType='3') or (@degreeType='4') or (@degreeType='5') or (@degreeType='6')"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree/@degreeType must have one of the following values: [1, 2, 3, 4, 5, 6]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory/hrxml:OrgName"
                 priority="1019"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:OrganizationName) or (hrxml:OrganizationName='')"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory/hrxml:OrgName/hrxml:OrganizationName must be Empty<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:SupportingMaterials"
                 priority="1018"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="(count(hrxml:AttachmentReference) = 0 and count(hrxml:Description) = 0) or (count(hrxml:AttachmentReference) = 1 and count(hrxml:AttachmentReference/@mimeType) = 1 and count(hrxml:Description) = 1 and string-length(hrxml:AttachmentReference) &gt; 0 and string-length(hrxml:AttachmentReference/@mimeType) &gt; 0 and string-length(hrxml:Description) &gt; 0)"/>
         <xsl:otherwise>AttachmentReference, mimeType and Description MUST all be present or none at all<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Rates" priority="1017" mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(/hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:InclusiveRate) = 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:InclusiveRate is mandatory if Rates are included<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@rateType) or (@rateType='pay') or (@rateType='bill')"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Rates/@rateType must have one of the following values: [pay, bill]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(empty(hrxml:Class) or (hrxml:Class='TimeInterval') or (hrxml:Class='Allowance') or (hrxml:Class='Expense')) or (empty(hrxml:Class) or (hrxml:Class=''))"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Rates/hrxml:Class must have one of the following values: [TimeInterval, Allowance, Expense] OR hrxml:HumanResource/hrxml:Rates/hrxml:Class must be Empty<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@rateStatus) or (@rateStatus='proposed') or (@rateStatus='agreed')"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Rates/@rateStatus must have one of the following values: [proposed, agreed]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Rates/hrxml:Amount" priority="1016" mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@rateAmountPeriod) or (@rateAmountPeriod='hourly') or (@rateAmountPeriod='x:hourlysplit') or (@rateAmountPeriod='x:hourlyconsolidated') or (@rateAmountPeriod='daily') or (@rateAmountPeriod='weekly') or (@rateAmountPeriod='x:4weekly') or (@rateAmountPeriod='monthly') or (@rateAmountPeriod='yearly') or (@rateAmountPeriod='flatfee')"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Rates/hrxml:Amount/@rateAmountPeriod must have one of the following values: [hourly, x:hourlysplit, x:hourlyconsolidated, daily, weekly, x:4weekly, monthly, yearly, flatfee]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:ReferenceInformation" priority="1015"
                 mode="M5">

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

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingCustomerOrgUnitId/@idOwner) = count(distinct-values(hrxml:StaffingCustomerOrgUnitId/@idOwner))"/>
         <xsl:otherwise>The same idOwner may not be given for StaffingCustomerOrgUnitId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingCustomerId/@idOwner) = count(distinct-values(hrxml:StaffingCustomerId/@idOwner))"/>
         <xsl:otherwise>The same idOwner may not be given for StaffingCustomerId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:OrderId"
                 priority="1014"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:OrderId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerId"
                 priority="1013"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerId must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, OIN, KvK, BTW, Fi, Vest]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId"
                 priority="1012"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, OIN, KvK, BTW, Fi, Vest]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierId"
                 priority="1011"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierId must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, OIN, KvK, BTW, Fi, Vest]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId"
                 priority="1010"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='KvK') or (@idOwner='OIN') or (@idOwner='BTW') or (@idOwner='Fi')"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, KvK, OIN, BTW, Fi]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:PostalAddress"
                 priority="1009"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="matches(hrxml:CountryCode, '^[A-Z][A-Z]$')"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:PostalAddress/hrxml:CountryCode must match regular expression: ^[A-Z][A-Z]$<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:ResourceInformation/hrxml:PersonName/hrxml:Affix"
                 priority="1008"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@type) or (@type='aristocraticTitle') or (@type='formOfAddress') or (@type='generation') or (@type='qualification')"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ResourceInformation/hrxml:PersonName/hrxml:Affix/@type must have one of the following values: [aristocraticTitle, formOfAddress, generation, qualification]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:ResourceInformation/hrxml:PersonName/hrxml:FamilyName"
                 priority="1007"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@primary) or (@primary='true') or (@primary='false')"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ResourceInformation/hrxml:PersonName/hrxml:FamilyName/@primary must have one of the following values: [true, false]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:ResourceInformation/hrxml:PostalAddress"
                 priority="1006"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="matches(hrxml:CountryCode, '^[A-Z][A-Z]$')"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:ResourceInformation/hrxml:PostalAddress/hrxml:CountryCode must match regular expression: ^[A-Z][A-Z]$<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL"
                 priority="1005"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(setu:Sex) or (setu:Sex='male') or (setu:Sex='female') or (setu:Sex='unknown')"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:Sex must have one of the following values: [male, female, unknown]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(count(setu:OfferId) = 1) or (../../hrxml:HumanResourceStatus/@status = 'x:Confirmed' or ../../hrxml:HumanResourceStatus/@status = 'x:confirmed' or ../../hrxml:HumanResourceStatus/@status = 'x:Assigned' or ../../hrxml:HumanResourceStatus/@status = 'x:assigned')"/>
         <xsl:otherwise>OfferId is required when status is not x:Confirmed, x:confirmed, xAssigned or x:assigned<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(setu:SETUVersionId) or (setu:SETUVersionId='1.2')"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SETUVersionId must have one of the following values: [1.2]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements"
                 priority="1004"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:AdditionalRequirement[@requirementTitle = 'VersionId']) = 1"/>
         <xsl:otherwise>There MUST be one CustomerReportingRequirements/AdditionalRequirement with @requirementTitle equal to VersionId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:OfferId"
                 priority="1003"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCompany')"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:OfferId/@idOwner must have one of the following values: [StaffingCompany]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift"
                 priority="1002"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@shiftPeriod) or (@shiftPeriod='weekly')"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift/@shiftPeriod must have one of the following values: [weekly]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift/hrxml:Id"
                 priority="1001"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:IdValue) or (hrxml:IdValue='')"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift/hrxml:Id/hrxml:IdValue must be Empty<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:PostalAddress"
                 priority="1000"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="matches(hrxml:CountryCode, '^[A-Z][A-Z]$')"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:PostalAddress/hrxml:CountryCode must match regular expression: ^[A-Z][A-Z]$<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M5"/>
   <xsl:template match="@*|node()" priority="-2" mode="M5">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

   <!--PATTERN type-restrictions-1-->


	<!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:Rates[hrxml:Class = 'TimeInterval']"
                 priority="1000"
                 mode="M6">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:Multiplier) = 1"/>
         <xsl:otherwise>hrxml:HumanResource/hrxml:Rates/hrxml:Multiplier is mandatory if hrxml:Class is TimeInterval<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M6"/>
   <xsl:template match="@*|node()" priority="-2" mode="M6">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>

   <!--PATTERN type-restrictions-2-->


	<!--RULE -->
<xsl:template match="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements/hrxml:AdditionalRequirement[@requirementTitle = 'VersionId']"
                 priority="1000"
                 mode="M7">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="text() = '2.0'"/>
         <xsl:otherwise>CustomerReportingRequirements/AdditionalRequirement must have value: 2.0 when requirementTitle is 'VersionId'.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M7"/>
   <xsl:template match="@*|node()" priority="-2" mode="M7">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>
</xsl:stylesheet>