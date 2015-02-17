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
<xsl:template match="hrxml:StaffingOrder" priority="1056" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>hrxml:StaffingOrder may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PositionQuantityOpen)"/>
         <xsl:otherwise>hrxml:StaffingOrder may not contain hrxml:PositionQuantityOpen<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:BillToAttention)"/>
         <xsl:otherwise>hrxml:StaffingOrder may not contain hrxml:BillToAttention<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:CustomerReportingRequirements" priority="1055"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationCode)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:LocationCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ManagerName)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:ManagerName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubEntity)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:SubEntity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PurchaseOrderLineItem)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:PurchaseOrderLineItem<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SupervisorName)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:SupervisorName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExternalReqNumber)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalReqNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExternalOrderNumber)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalOrderNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ContactName)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:ContactName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PurchaseOrderNumber)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:PurchaseOrderNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerJobDescription)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobDescription<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationName)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:LocationName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerJobCode)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Entity)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:Entity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AccountCode)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:AccountCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Shift)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:Shift<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo"
                 priority="1054"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ContactId)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo may not contain hrxml:ContactId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod"
                 priority="1053"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Use)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod may not contain hrxml:Use<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:TTYTDD)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod may not contain hrxml:TTYTDD<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Location)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod may not contain hrxml:Location<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PostalAddress)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod may not contain hrxml:PostalAddress<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:WhenAvailable)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod may not contain hrxml:WhenAvailable<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Pager)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod may not contain hrxml:Pager<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Fax"
                 priority="1052"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubscriberNumber)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:SubscriberNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:InternationalCountryCode)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:InternationalCountryCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Extension)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:Extension<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:NationalNumber)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:NationalNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AreaCityCode)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:AreaCityCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Mobile"
                 priority="1051"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AreaCityCode)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:AreaCityCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@smsEnabled)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain @smsEnabled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Extension)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:Extension<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:InternationalCountryCode)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:InternationalCountryCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:NationalNumber)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:NationalNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubscriberNumber)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:SubscriberNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Telephone"
                 priority="1050"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubscriberNumber)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:SubscriberNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:NationalNumber)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:NationalNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AreaCityCode)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:AreaCityCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Extension)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:Extension<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:InternationalCountryCode)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:InternationalCountryCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:PersonName"
                 priority="1049"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Affix)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:PersonName may not contain hrxml:Affix<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PreferredGivenName)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:PersonName may not contain hrxml:PreferredGivenName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:MiddleName)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:PersonName may not contain hrxml:MiddleName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:FamilyName)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:PersonName may not contain hrxml:FamilyName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AlternateScript)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:PersonName may not contain hrxml:AlternateScript<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:GivenName)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:PersonName may not contain hrxml:GivenName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@script)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:PersonName may not contain @script<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LegalName)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:PersonName may not contain hrxml:LegalName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:OrderId/hrxml:IdValue" priority="1048"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:OrderId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation" priority="1047"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:BillToEntityId)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation may not contain hrxml:BillToEntityId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:HumanResourceId)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation may not contain hrxml:HumanResourceId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:UserArea)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation may not contain hrxml:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AssignmentId)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation may not contain hrxml:AssignmentId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:StaffingOrganizationId)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation may not contain hrxml:StaffingOrganizationId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:TimeCardId)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation may not contain hrxml:TimeCardId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:InvoiceId)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation may not contain hrxml:InvoiceId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PositionId)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation may not contain hrxml:PositionId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:IntermediaryId)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation may not contain hrxml:IntermediaryId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:MasterOrderId"
                 priority="1046"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:MasterOrderId may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:MasterOrderId may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:MasterOrderId/hrxml:IdValue"
                 priority="1045"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:MasterOrderId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId"
                 priority="1044"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/hrxml:IdValue"
                 priority="1043"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId"
                 priority="1042"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/hrxml:IdValue"
                 priority="1041"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId"
                 priority="1040"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/hrxml:IdValue"
                 priority="1039"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId"
                 priority="1038"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/hrxml:IdValue"
                 priority="1037"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition" priority="1036" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:InvoiceInfo)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition may not contain hrxml:InvoiceInfo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:WorkSiteEnvironment)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition may not contain hrxml:WorkSiteEnvironment<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PositionRequirements)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition may not contain hrxml:PositionRequirements<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ReportToPerson)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition may not contain hrxml:ReportToPerson<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DepartmentName)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition may not contain hrxml:DepartmentName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PositionContact)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition may not contain hrxml:PositionContact<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements"
                 priority="1035"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ContactName)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:ContactName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExternalOrderNumber)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalOrderNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ManagerName)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:ManagerName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationCode)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:LocationCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DepartmentName)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:DepartmentName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CostCenterName)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:CostCenterName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationName)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:LocationName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerJobDescription)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobDescription<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubEntity)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:SubEntity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PurchaseOrderLineItem)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:PurchaseOrderLineItem<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExternalReqNumber)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalReqNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AdditionalRequirement)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:AdditionalRequirement<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AccountCode)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:AccountCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ProjectCode)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:ProjectCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerReferenceNumber)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerReferenceNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CostCenterCode)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:CostCenterCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Shift)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:Shift<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Entity)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:Entity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DepartmentCode)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:DepartmentCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SupervisorName)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:SupervisorName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PurchaseOrderNumber)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:PurchaseOrderNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerJobCode)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionDateRange"
                 priority="1034"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PositionDuration)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionDateRange may not contain hrxml:PositionDuration<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:StartAsSoonAsPossible)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionDateRange may not contain hrxml:StartAsSoonAsPossible<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExtensionParameters)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionDateRange may not contain hrxml:ExtensionParameters<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:MaxStartDate)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionDateRange may not contain hrxml:MaxStartDate<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:MaxNeedEndDate)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionDateRange may not contain hrxml:MaxNeedEndDate<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ActualEndDate)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionDateRange may not contain hrxml:ActualEndDate<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader"
                 priority="1033"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PositionSpecificCondition)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:PositionSpecificCondition<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:OvertimeInfo)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:OvertimeInfo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:BusyPeriodInfo)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:BusyPeriodInfo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:HolidayWork)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:HolidayWork<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ReportToPositionId)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:ReportToPositionId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:FormattedPositionDescription)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:FormattedPositionDescription<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PositionMustEndByInfo)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:PositionMustEndByInfo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Quantity)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:Quantity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:TransitionInfo)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:TransitionInfo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:TypeOfHours)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:TypeOfHours<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PositionStatus)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:PositionStatus<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocalStaffingPositionInfo)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:LocalStaffingPositionInfo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SpecialInstructions)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:SpecialInstructions<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:JobCategory)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:JobCategory<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:JobId"
                 priority="1032"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Domain)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:JobId may not contain hrxml:Domain<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:PositionId"
                 priority="1031"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Domain)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:PositionId may not contain hrxml:Domain<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson"
                 priority="1030"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Supplier)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson may not contain hrxml:Supplier<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@currentlyAssigned)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson may not contain @currentlyAssigned<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@mandatory)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson may not contain @mandatory<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonId"
                 priority="1029"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonId may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonId may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonId/hrxml:IdValue"
                 priority="1028"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonName"
                 priority="1027"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AlternateScript)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonName may not contain hrxml:AlternateScript<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@script)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonName may not contain @script<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates" priority="1026"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:BillingMultiplier)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates may not contain hrxml:BillingMultiplier<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:TimeWorkedRounding)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates may not contain hrxml:TimeWorkedRounding<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:StaffingShiftId)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates may not contain hrxml:StaffingShiftId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:CustomerRateClassification"
                 priority="1025"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:CustomerRateClassification may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:CustomerRateClassification may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:CustomerRateClassification may not contain @idOwner<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:ExternalRateSetId"
                 priority="1024"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:ExternalRateSetId may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:ExternalRateSetId may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:ExternalRateSetId may not contain @idOwner<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:ExternalRateSetId/hrxml:IdValue"
                 priority="1023"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:ExternalRateSetId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:Multiplier"
                 priority="1022"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@percentIndicator)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:Multiplier may not contain @percentIndicator<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:RatesId"
                 priority="1021"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:RatesId may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:RatesId may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:RatesId may not contain @idOwner<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:RatesId/hrxml:IdValue"
                 priority="1020"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:RatesId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift"
                 priority="1019"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Name)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift may not contain hrxml:Name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Comment)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift may not contain hrxml:Comment<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExternalStaffingShiftSetId)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift may not contain hrxml:ExternalStaffingShiftSetId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:TypeHours)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift may not contain hrxml:TypeHours<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:StartTime)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift may not contain hrxml:StartTime<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:EndTime)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift may not contain hrxml:EndTime<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift/hrxml:Id"
                 priority="1018"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift/hrxml:Id may not contain @idOwner<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift/hrxml:Id may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift/hrxml:Id may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift/hrxml:Id/hrxml:IdValue"
                 priority="1017"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift/hrxml:Id/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite"
                 priority="1016"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:TravelDirections)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite may not contain hrxml:TravelDirections<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:WorkSiteId)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite may not contain hrxml:WorkSiteId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:StructuredTravelDirections)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite may not contain hrxml:StructuredTravelDirections<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:WorkSiteDetail)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite may not contain hrxml:WorkSiteDetail<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ParkingInstructions)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite may not contain hrxml:ParkingInstructions<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite/hrxml:PostalAddress"
                 priority="1015"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Region)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite/hrxml:PostalAddress may not contain hrxml:Region<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@type)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite/hrxml:PostalAddress may not contain @type<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Recipient)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite/hrxml:PostalAddress may not contain hrxml:Recipient<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite/hrxml:PostalAddress/hrxml:DeliveryAddress"
                 priority="1014"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AddressLine)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite/hrxml:PostalAddress/hrxml:DeliveryAddress may not contain hrxml:AddressLine<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PostOfficeBox)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite/hrxml:PostalAddress/hrxml:DeliveryAddress may not contain hrxml:PostOfficeBox<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:OfferId"
                 priority="1013"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:OfferId may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:OfferId may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:OfferId/hrxml:IdValue"
                 priority="1012"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:OfferId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:PreviousOrderId"
                 priority="1011"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:PreviousOrderId may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:PreviousOrderId may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:PreviousOrderId/hrxml:IdValue"
                 priority="1010"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:PreviousOrderId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:RFQOrderId"
                 priority="1009"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:RFQOrderId may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:RFQOrderId may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:RFQOrderId/hrxml:IdValue"
                 priority="1008"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:RFQOrderId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume"
                 priority="1007"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Objective)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:Objective<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SecurityCredentials)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:SecurityCredentials<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PatentHistory)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:PatentHistory<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SupportingMaterials)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:SupportingMaterials<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:RevisionDate)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:RevisionDate<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ResumeAdditionalItems)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:ResumeAdditionalItems<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ProfessionalAssociations)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:ProfessionalAssociations<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:MilitaryHistory)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:MilitaryHistory<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:References)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:References<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SpeakingEventsHistory)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:SpeakingEventsHistory<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Associations)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:Associations<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Achievements)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:Achievements<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:EmploymentHistory)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:EmploymentHistory<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExecutiveSummary)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:ExecutiveSummary<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Comments)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:Comments<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Languages)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:Languages<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ContactInfo)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:ContactInfo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PublicationHistory)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:PublicationHistory<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution"
                 priority="1006"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Minor)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:Minor<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SchoolName)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:SchoolName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Major)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:Major<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PostalAddress)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:PostalAddress<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Comments)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:Comments<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:School)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:School<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:UserArea)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:OrganizationUnit)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:OrganizationUnit<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Measure)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:Measure<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ISCEDInstitutionClassification)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:ISCEDInstitutionClassification<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationSummary)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:LocationSummary<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DatesOfAttendance)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:DatesOfAttendance<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree"
                 priority="1005"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DegreeDate)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:DegreeDate<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DegreeMinor)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:DegreeMinor<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:UserArea)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DegreeClassification)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:DegreeClassification<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@examPassed)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain @examPassed<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:OtherHonors)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:OtherHonors<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@graduatingDegree)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain @graduatingDegree<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DatesOfAttendance)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:DatesOfAttendance<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Comments)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:Comments<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DegreeMajor)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:DegreeMajor<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DegreeName)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:DegreeName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DegreeMeasure)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:DegreeMeasure<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id"
                 priority="1004"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id/hrxml:IdValue"
                 priority="1003"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification"
                 priority="1002"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:EffectiveDate)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification may not contain hrxml:EffectiveDate<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Description)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification may not contain hrxml:Description<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:IssuingAuthority)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification may not contain hrxml:IssuingAuthority<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications"
                 priority="1001"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:QualificationSummary)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications may not contain hrxml:QualificationSummary<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency"
                 priority="1000"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:UserArea)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency may not contain hrxml:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CompetencyId)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency may not contain hrxml:CompetencyId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:TaxonomyId)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency may not contain hrxml:TaxonomyId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@required)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency may not contain @required<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Competency)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency may not contain hrxml:Competency<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CompetencyWeight)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency may not contain hrxml:CompetencyWeight<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CompetencyEvidence)"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency may not contain hrxml:CompetencyEvidence<xsl:value-of select="string('&#xA;')"/>
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
<xsl:template match="hrxml:StaffingOrder" priority="1028" mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:OrderContact) &gt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder must contain hrxml:OrderContact at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingPosition) &lt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder may contain hrxml:StaffingPosition at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:UserArea) &gt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder must contain hrxml:UserArea at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:CustomerReportingRequirements" priority="1027"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:AdditionalRequirement) &gt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:CustomerReportingRequirements must contain hrxml:AdditionalRequirement at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement"
                 priority="1026"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@requirementTitle) &gt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must contain @requirementTitle at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo"
                 priority="1025"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:ContactMethod) &lt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo may contain hrxml:ContactMethod at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:PersonName"
                 priority="1024"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:FormattedName) &gt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:PersonName must contain hrxml:FormattedName at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:OrderId" priority="1023" mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:OrderId must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:OrderId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation" priority="1022"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingCustomerId) &gt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation must contain hrxml:StaffingCustomerId at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:MasterOrderId"
                 priority="1021"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:MasterOrderId must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:MasterOrderId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId"
                 priority="1020"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId"
                 priority="1019"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId"
                 priority="1018"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId"
                 priority="1017"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition" priority="1016" mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingShift) &lt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition may contain hrxml:StaffingShift at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader"
                 priority="1015"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:RequestedPerson) &lt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may contain hrxml:RequestedPerson at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonId"
                 priority="1014"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonId must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonName"
                 priority="1013"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:FamilyName) &lt;= 2"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonName may contain hrxml:FamilyName at most 2 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:ShiftWork"
                 priority="1012"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:Description) &gt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:ShiftWork must contain hrxml:Description at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates" priority="1011"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:Multiplier) &lt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates may contain hrxml:Multiplier at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:CustomerRateClassification"
                 priority="1010"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:CustomerRateClassification may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:ExternalRateSetId"
                 priority="1009"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:ExternalRateSetId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:RatesId"
                 priority="1008"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:RatesId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift"
                 priority="1007"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:Hours) &gt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift must contain hrxml:Hours at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@shiftPeriod) &gt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift must contain @shiftPeriod at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea" priority="1006" mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(setu:StaffingOrderAdditionalNL) &gt;= 1 and count(setu:StaffingOrderAdditionalNL) &lt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea must contain setu:StaffingOrderAdditionalNL at least 1 and at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:OfferId"
                 priority="1005"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:OfferId must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:OfferId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:PreviousOrderId"
                 priority="1004"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:PreviousOrderId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:PreviousOrderId must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:RFQOrderId"
                 priority="1003"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:RFQOrderId must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:RFQOrderId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution"
                 priority="1002"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:Degree) &lt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may contain hrxml:Degree at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:LocalInstitutionClassification) &lt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may contain hrxml:LocalInstitutionClassification at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id"
                 priority="1001"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency"
                 priority="1000"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@description) &gt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency must contain @description at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@name) &gt;= 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency must contain @name at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
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
<xsl:template match="hrxml:StaffingOrder/hrxml:CustomerReportingRequirements" priority="1028"
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
<xsl:template match="hrxml:StaffingOrder/hrxml:OrderClassification" priority="1027" mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@orderStatus) or (@orderStatus='new') or (@orderStatus='closed')"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:OrderClassification/@orderStatus must have one of the following values: [new, closed]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@orderType) or (@orderType='RFQ') or (@orderType='order')"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:OrderClassification/@orderType must have one of the following values: [RFQ, order]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:OrderContact" priority="1026" mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@contactType) or (@contactType='created by') or (@contactType='authorized by') or (@contactType='first day contact') or (@contactType='placed by') or (@contactType='placed on behalf of') or (@contactType='supervisor') or (@contactType='submitted by')"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:OrderContact/@contactType must have one of the following values: [created by, authorized by, first day contact, placed by, placed on behalf of, supervisor, submitted by]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:OrderId" priority="1025" mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:OrderId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:PositionQuantity" priority="1024" mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="number(text()) &gt; 0"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:PositionQuantity must be at least 1.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation" priority="1023"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingSupplierOrgUnitId/@idOwner) = count(distinct-values(hrxml:StaffingSupplierOrgUnitId/@idOwner))"/>
         <xsl:otherwise>The same idOwner may not be given for StaffingSupplierOrgUnitId<xsl:value-of select="string('&#xA;')"/>
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
         <xsl:when test="if (count(hrxml:StaffingSupplierOrgUnitId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingSupplierOrgUnitId[@idOwner = 'KvK']) = 1) else ('true')"/>
         <xsl:otherwise>If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:MasterOrderId"
                 priority="1022"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:MasterOrderId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId"
                 priority="1021"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, OIN, KvK, BTW, Fi, Vest]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId"
                 priority="1020"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, OIN, KvK, BTW, Fi, Vest]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId"
                 priority="1019"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, OIN, KvK, BTW, Fi, Vest]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId"
                 priority="1018"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='KvK') or (@idOwner='OIN') or (@idOwner='BTW') or (@idOwner='Fi')"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, KvK, OIN, BTW, Fi]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition" priority="1017" mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PositionReason) or (hrxml:PositionReason='Illness') or (hrxml:PositionReason='Peak') or (hrxml:PositionReason='Project') or (hrxml:PositionReason='Reorganisation') or (hrxml:PositionReason='Position') or (hrxml:PositionReason='Vacation') or (hrxml:PositionReason='Maternity') or (hrxml:PositionReason='Season') or (hrxml:PositionReason='Replacement') or (hrxml:PositionReason='Recruitment') or (hrxml:PositionReason='Structural') or (hrxml:PositionReason='Other')"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionReason must have one of the following values: [Illness, Peak, Project, Reorganisation, Position, Vacation, Maternity, Season, Replacement, Recruitment, Structural, Other]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerReportingRequirements) or (hrxml:CustomerReportingRequirements='')"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements must be Empty<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader"
                 priority="1016"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PositionType) or (hrxml:PositionType='recruitment and selection') or (hrxml:PositionType='secondment') or (hrxml:PositionType='temporary staffing')"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:PositionType must have one of the following values: [recruitment and selection, secondment, temporary staffing]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:PositionId"
                 priority="1015"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Id) or (hrxml:Id='')"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:PositionId/hrxml:Id must be Empty<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson"
                 priority="1014"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:PersonName) + count(hrxml:PersonId) &gt; 0"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:PositionHeader/hrxml:RequestedPerson - PersonName OR PersonId is mandatory.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonId"
                 priority="1013"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='BSN')"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonId/@idOwner must have one of the following values: [StaffingCustomer, staffingCustomer, BSN]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonName/hrxml:Affix"
                 priority="1012"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@type) or (@type='aristocraticTitle') or (@type='formOfAddress') or (@type='generation') or (@type='qualification')"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonName/hrxml:Affix/@type must have one of the following values: [aristocraticTitle, formOfAddress, generation, qualification]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:ShiftWork"
                 priority="1011"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@haveShiftWork) or (@haveShiftWork='true')"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:ShiftWork/@haveShiftWork must have one of the following values: [true]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates" priority="1010"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="(empty(hrxml:Class) or (hrxml:Class='TimeInterval') or (hrxml:Class='Allowance') or (hrxml:Class='Expense')) or (empty(hrxml:Class) or (hrxml:Class=''))"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:Class must have one of the following values: [TimeInterval, Allowance, Expense] OR hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:Class must be Empty<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@rateType) or (@rateType='pay') or (@rateType='bill') or (@rateType='minPayRate') or (@rateType='maxPayRate') or (@rateType='minBillRate') or (@rateType='maxBillRate')"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/@rateType must have one of the following values: [pay, bill, minPayRate, maxPayRate, minBillRate, maxBillRate]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(/hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:InclusiveRate) = 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:InclusiveRate is mandatory if Rates are included<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@rateStatus) or (@rateStatus='proposed') or (@rateStatus='agreed')"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/@rateStatus must have one of the following values: [proposed, agreed]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:Amount"
                 priority="1009"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@rateAmountPeriod) or (@rateAmountPeriod='hourly') or (@rateAmountPeriod='x:hourlysplit') or (@rateAmountPeriod='x:hourlyconsolidated') or (@rateAmountPeriod='daily') or (@rateAmountPeriod='weekly') or (@rateAmountPeriod='x:4weekly') or (@rateAmountPeriod='monthly') or (@rateAmountPeriod='yearly') or (@rateAmountPeriod='flatfee')"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:Amount/@rateAmountPeriod must have one of the following values: [hourly, x:hourlysplit, x:hourlyconsolidated, daily, weekly, x:4weekly, monthly, yearly, flatfee]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift"
                 priority="1008"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@shiftPeriod) or (@shiftPeriod='weekly') or (@shiftPeriod='monthly') or (@shiftPeriod='daily')"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift/@shiftPeriod must have one of the following values: [weekly, monthly, daily]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift/hrxml:Id"
                 priority="1007"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:IdValue) or (hrxml:IdValue='')"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift/hrxml:Id/hrxml:IdValue must be Empty<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite/hrxml:PostalAddress"
                 priority="1006"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="matches(hrxml:CountryCode, '^[A-Z][A-Z]$')"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite/hrxml:PostalAddress/hrxml:CountryCode must match regular expression: ^[A-Z][A-Z]$<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL"
                 priority="1005"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(setu:SETUVersionId) or (setu:SETUVersionId='1.2')"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:SETUVersionId must have one of the following values: [1.2]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:OfferId"
                 priority="1004"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCompany')"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:OfferId/@idOwner must have one of the following values: [StaffingCompany]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:PreviousOrderId"
                 priority="1003"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:PreviousOrderId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:RFQOrderId"
                 priority="1002"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:RFQOrderId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree"
                 priority="1001"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@degreeType) or (@degreeType='1') or (@degreeType='2') or (@degreeType='3') or (@degreeType='4') or (@degreeType='5') or (@degreeType='6')"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree/@degreeType must have one of the following values: [1, 2, 3, 4, 5, 6]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id"
                 priority="1000"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:IdValue) or (hrxml:IdValue='SOI-2006')"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id/hrxml:IdValue must have one of the following values: [SOI-2006]<xsl:value-of select="string('&#xA;')"/>
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
<xsl:template match="hrxml:StaffingOrder/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement[@requirementTitle = 'VersionId']"
                 priority="1000"
                 mode="M6">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="text() = '2.0'"/>
         <xsl:otherwise>CustomerReportingRequirements/AdditionalRequirement must have value: 2.0 when requirementTitle is 'VersionId'.<xsl:value-of select="string('&#xA;')"/>
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
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates[hrxml:Class = 'TimeInterval']"
                 priority="1000"
                 mode="M7">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:Multiplier) = 1"/>
         <xsl:otherwise>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:Multiplier is mandatory if hrxml:Class is TimeInterval<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M7"/>
   <xsl:template match="@*|node()" priority="-2" mode="M7">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>
</xsl:stylesheet>