<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:schold="http://www.ascc.net/xml/schematron"
                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
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
      <xsl:apply-templates select="/" mode="M8"/>
   </xsl:template>

   <!--SCHEMATRON PATTERNS-->


<!--PATTERN prohibitions-->


	<!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header" priority="1235" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TaxWithholdingExempt)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header may not contain oagis:TaxWithholdingExempt<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SpecialPriceAuthorization)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header may not contain oagis:SpecialPriceAuthorization<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:PromisedDeliveryDate)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header may not contain oagis:PromisedDeliveryDate<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Distribution)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header may not contain oagis:Distribution<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ExtendedPrice)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header may not contain oagis:ExtendedPrice<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Reason)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header may not contain oagis:Reason<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Allowance)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header may not contain oagis:Allowance<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:OrderStatus)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header may not contain oagis:OrderStatus<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:NeedDeliveryDate)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header may not contain oagis:NeedDeliveryDate<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Priority)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header may not contain oagis:Priority<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:License)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header may not contain oagis:License<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:FreightClass)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header may not contain oagis:FreightClass<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TotalAllowance)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header may not contain oagis:TotalAllowance<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:LastModificationDateTime)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header may not contain oagis:LastModificationDateTime<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:DropShipInd)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header may not contain oagis:DropShipInd<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ShipPriorToDueDateInd)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header may not contain oagis:ShipPriorToDueDateInd<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:EarliestShipDate)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header may not contain oagis:EarliestShipDate<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:PromisedShipDate)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header may not contain oagis:PromisedShipDate<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ShipNote)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header may not contain oagis:ShipNote<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:BackOrderedInd)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header may not contain oagis:BackOrderedInd<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TransportationTerm)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header may not contain oagis:TransportationTerm<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Attachments" priority="1234" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:DrawingAttachment)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Attachments may not contain oagis:DrawingAttachment<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:InstructionsAttachment)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Attachments may not contain oagis:InstructionsAttachment<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:PictureAttachment)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Attachments may not contain oagis:PictureAttachment<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:DataSheetAttachment)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Attachments may not contain oagis:DataSheetAttachment<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:FileAttachment)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Attachments may not contain oagis:FileAttachment<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Attachments/oagis:Attachment"
                 priority="1233"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Attachments/oagis:Attachment may not contain oagis:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:FileSize)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Attachments/oagis:Attachment may not contain oagis:FileSize<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:DocumentDate)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Attachments/oagis:Attachment may not contain oagis:DocumentDate<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:URI)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Attachments/oagis:Attachment may not contain oagis:URI<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Title)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Attachments/oagis:Attachment may not contain oagis:Title<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:FileName)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Attachments/oagis:Attachment may not contain oagis:FileName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ISBN)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Attachments/oagis:Attachment may not contain oagis:ISBN<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@inline)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Attachments/oagis:Attachment may not contain @inline<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Note)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Attachments/oagis:Attachment may not contain oagis:Note<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Description)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Attachments/oagis:Attachment may not contain oagis:Description<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Charges" priority="1232" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:AdditionalCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Charges may not contain oagis:AdditionalCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SpecificAmountCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Charges may not contain oagis:SpecificAmountCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:BasicFreightCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Charges may not contain oagis:BasicFreightCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:OriginPortCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Charges may not contain oagis:OriginPortCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:DestinationPortCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Charges may not contain oagis:DestinationPortCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:DestinationHaulageCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Charges may not contain oagis:DestinationHaulageCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TransportToLocationCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Charges may not contain oagis:TransportToLocationCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:AllCostsToLocationCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Charges may not contain oagis:AllCostsToLocationCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SupplementaryCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Charges may not contain oagis:SupplementaryCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TransportationCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Charges may not contain oagis:TransportationCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:WeightValuationCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Charges may not contain oagis:WeightValuationCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TransportPlusAdditionalCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Charges may not contain oagis:TransportPlusAdditionalCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TotalCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Charges may not contain oagis:TotalCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:AllCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Charges may not contain oagis:AllCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:MiscellaneousCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Charges may not contain oagis:MiscellaneousCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:DistribursmentCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Charges may not contain oagis:DistribursmentCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Charges/oagis:Charge" priority="1231"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Charges/oagis:Charge may not contain oagis:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Id)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Charges/oagis:Charge may not contain oagis:Id<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Distribution)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Charges/oagis:Charge may not contain oagis:Distribution<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Cost)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Charges/oagis:Charge may not contain oagis:Cost<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Charges/oagis:Charge/oagis:Description"
                 priority="1230"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@owner)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Charges/oagis:Charge/oagis:Description may not contain @owner<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Charges/oagis:Charge/oagis:Description may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Description" priority="1229" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Description may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@owner)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Description may not contain @owner<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:DocumentIds" priority="1228" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SupplierDocumentId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentIds may not contain oagis:SupplierDocumentId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:CustomerDocumentId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentIds may not contain oagis:CustomerDocumentId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:BrokerDocumentId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentIds may not contain oagis:BrokerDocumentId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:LogisticsProviderDocumentId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentIds may not contain oagis:LogisticsProviderDocumentId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ShippersDocumentId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentIds may not contain oagis:ShippersDocumentId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:CarrierDocumentId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentIds may not contain oagis:CarrierDocumentId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:DocumentIds/oagis:DocumentId"
                 priority="1227"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Revision)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentIds/oagis:DocumentId may not contain oagis:Revision<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:DocumentReferences" priority="1226"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ProjectReference)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentReferences may not contain oagis:ProjectReference<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:LedgerDocumentReference)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentReferences may not contain oagis:LedgerDocumentReference<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:QuoteDocumentReference)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentReferences may not contain oagis:QuoteDocumentReference<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:RFQDocumentReference)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentReferences may not contain oagis:RFQDocumentReference<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:UOMGroupReference)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentReferences may not contain oagis:UOMGroupReference<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ContractDocumentReference)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentReferences may not contain oagis:ContractDocumentReference<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ReceiptDocumentReference)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentReferences may not contain oagis:ReceiptDocumentReference<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:CatalogDocumentReference)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentReferences may not contain oagis:CatalogDocumentReference<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:VoucherDocumentReference)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentReferences may not contain oagis:VoucherDocumentReference<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:MaintenanceOrderReference)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentReferences may not contain oagis:MaintenanceOrderReference<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SalesOrderDocumentReference)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentReferences may not contain oagis:SalesOrderDocumentReference<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:RequisitionDocumentReference)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentReferences may not contain oagis:RequisitionDocumentReference<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:PurchaseOrderDocumentReference)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentReferences may not contain oagis:PurchaseOrderDocumentReference<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference"
                 priority="1225"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Name)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:Name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Status)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:Status<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Description)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:Description<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Usage)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:Usage<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Note)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:Note<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:DocumentDate)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:DocumentDate<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:LineNumber)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:LineNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ScheduleLineNumber)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:ScheduleLineNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SubLineNumber)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:SubLineNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds"
                 priority="1224"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:BrokerDocumentId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds may not contain oagis:BrokerDocumentId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ShippersDocumentId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds may not contain oagis:ShippersDocumentId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SupplierDocumentId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds may not contain oagis:SupplierDocumentId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:CarrierDocumentId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds may not contain oagis:CarrierDocumentId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:LogisticsProviderDocumentId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds may not contain oagis:LogisticsProviderDocumentId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:CustomerDocumentId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds may not contain oagis:CustomerDocumentId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds/oagis:DocumentId"
                 priority="1223"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Revision)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds/oagis:DocumentId may not contain oagis:Revision<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Note" priority="1222" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@entryDateTime)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Note may not contain @entryDateTime<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Note may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@author)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Note may not contain @author<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties" priority="1221" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ManufacturerParty)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties may not contain oagis:ManufacturerParty<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:CarrierParty)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties may not contain oagis:CarrierParty<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:BrokerParty)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties may not contain oagis:BrokerParty<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:EmployeeParty)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties may not contain oagis:EmployeeParty<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:FreightBillToParty)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties may not contain oagis:FreightBillToParty<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ShipFromParty)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties may not contain oagis:ShipFromParty<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ShipToParty)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties may not contain oagis:ShipToParty<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:HoldAtParty)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties may not contain oagis:HoldAtParty<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ImporterParty)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties may not contain oagis:ImporterParty<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:PayFromParty)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties may not contain oagis:PayFromParty<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ReturnToParty)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties may not contain oagis:ReturnToParty<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ExporterParty)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties may not contain oagis:ExporterParty<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:PublisherParty)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties may not contain oagis:PublisherParty<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:JointVentureParty)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties may not contain oagis:JointVentureParty<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SoldToParty)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties may not contain oagis:SoldToParty<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty"
                 priority="1220"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Currency)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty may not contain oagis:Currency<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Business)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty may not contain oagis:Business<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Attachments)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty may not contain oagis:Attachments<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:AlternatePartyIds)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty may not contain oagis:AlternatePartyIds<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Rating)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty may not contain oagis:Rating<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@oneTime)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty may not contain @oneTime<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TermId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty may not contain oagis:TermId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Qualification)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty may not contain oagis:Qualification<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty may not contain oagis:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:GLEntity)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty may not contain oagis:GLEntity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:PaymentMethod)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty may not contain oagis:PaymentMethod<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:CorrespondenceLanguage)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty may not contain oagis:CorrespondenceLanguage<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@active)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty may not contain @active<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TaxExemptInd)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty may not contain oagis:TaxExemptInd<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses"
                 priority="1219"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Address)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses may not contain oagis:Address<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SecondaryAddress)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses may not contain oagis:SecondaryAddress<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ShippingAddress)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses may not contain oagis:ShippingAddress<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:DropShipAddress)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses may not contain oagis:DropShipAddress<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses/oagis:PrimaryAddress"
                 priority="1218"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TaxJurisdiction)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses/oagis:PrimaryAddress may not contain oagis:TaxJurisdiction<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses/oagis:PrimaryAddress may not contain oagis:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses/oagis:PrimaryAddress/oagis:AddressId"
                 priority="1217"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@qualifyingAgency)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses/oagis:PrimaryAddress/oagis:AddressId may not contain @qualifyingAgency<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses/oagis:PrimaryAddress/oagis:Description"
                 priority="1216"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses/oagis:PrimaryAddress/oagis:Description may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@owner)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses/oagis:PrimaryAddress/oagis:Description may not contain @owner<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts"
                 priority="1215"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SecondaryContact)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts may not contain oagis:SecondaryContact<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Buyer)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts may not contain oagis:Buyer<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SalesPerson)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts may not contain oagis:SalesPerson<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ContactAbs)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts may not contain oagis:ContactAbs<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:DeliverToContact)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts may not contain oagis:DeliverToContact<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Requester)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts may not contain oagis:Requester<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:MarketingContact)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts may not contain oagis:MarketingContact<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:PrimaryContact)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts may not contain oagis:PrimaryContact<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SalesContact)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts may not contain oagis:SalesContact<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Planner)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts may not contain oagis:Planner<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:AccountingContact)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts may not contain oagis:AccountingContact<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact"
                 priority="1214"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact may not contain oagis:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses"
                 priority="1213"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:DropShipAddress)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses may not contain oagis:DropShipAddress<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SecondaryAddress)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses may not contain oagis:SecondaryAddress<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ShippingAddress)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses may not contain oagis:ShippingAddress<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Address)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses may not contain oagis:Address<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress"
                 priority="1212"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may not contain oagis:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TaxJurisdiction)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may not contain oagis:TaxJurisdiction<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:AddressId"
                 priority="1211"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@qualifyingAgency)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:AddressId may not contain @qualifyingAgency<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:Description"
                 priority="1210"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@owner)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:Description may not contain @owner<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:Description may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Description"
                 priority="1209"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Description may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@owner)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Description may not contain @owner<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person"
                 priority="1208"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person may not contain oagis:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:PersonCode)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person may not contain oagis:PersonCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName"
                 priority="1207"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may not contain oagis:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:FamilyName"
                 priority="1206"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:FamilyName may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:FormattedName"
                 priority="1205"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:FormattedName may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:GivenName"
                 priority="1204"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:GivenName may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:MiddleName"
                 priority="1203"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:MiddleName may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:PreferredGivenName"
                 priority="1202"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:PreferredGivenName may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:Salutation"
                 priority="1201"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:Salutation may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:Suffix"
                 priority="1200"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:Suffix may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Description"
                 priority="1199"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Description may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@owner)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Description may not contain @owner<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Name"
                 priority="1198"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Name may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:PartyId"
                 priority="1197"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:DUNS)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:PartyId may not contain oagis:DUNS<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SCAC)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:PartyId may not contain oagis:SCAC<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty"
                 priority="1196"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Rating)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty may not contain oagis:Rating<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Currency)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty may not contain oagis:Currency<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:CorrespondenceLanguage)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty may not contain oagis:CorrespondenceLanguage<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TaxExemptInd)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty may not contain oagis:TaxExemptInd<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TermId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty may not contain oagis:TermId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Qualification)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty may not contain oagis:Qualification<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Business)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty may not contain oagis:Business<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@active)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty may not contain @active<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@oneTime)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty may not contain @oneTime<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty may not contain oagis:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:GLEntity)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty may not contain oagis:GLEntity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Attachments)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty may not contain oagis:Attachments<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:PaymentMethod)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty may not contain oagis:PaymentMethod<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:AlternatePartyIds)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty may not contain oagis:AlternatePartyIds<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses"
                 priority="1195"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Address)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses may not contain oagis:Address<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ShippingAddress)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses may not contain oagis:ShippingAddress<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:DropShipAddress)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses may not contain oagis:DropShipAddress<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SecondaryAddress)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses may not contain oagis:SecondaryAddress<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress"
                 priority="1194"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress may not contain oagis:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TaxJurisdiction)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress may not contain oagis:TaxJurisdiction<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress/oagis:AddressId"
                 priority="1193"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@qualifyingAgency)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress/oagis:AddressId may not contain @qualifyingAgency<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress/oagis:Description"
                 priority="1192"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress/oagis:Description may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@owner)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress/oagis:Description may not contain @owner<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts"
                 priority="1191"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Buyer)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts may not contain oagis:Buyer<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Planner)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts may not contain oagis:Planner<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SalesPerson)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts may not contain oagis:SalesPerson<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SalesContact)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts may not contain oagis:SalesContact<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SecondaryContact)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts may not contain oagis:SecondaryContact<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Requester)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts may not contain oagis:Requester<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:DeliverToContact)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts may not contain oagis:DeliverToContact<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ContactAbs)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts may not contain oagis:ContactAbs<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:AccountingContact)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts may not contain oagis:AccountingContact<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:MarketingContact)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts may not contain oagis:MarketingContact<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:PrimaryContact)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts may not contain oagis:PrimaryContact<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact"
                 priority="1190"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact may not contain oagis:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses"
                 priority="1189"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:DropShipAddress)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses may not contain oagis:DropShipAddress<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Address)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses may not contain oagis:Address<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SecondaryAddress)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses may not contain oagis:SecondaryAddress<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ShippingAddress)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses may not contain oagis:ShippingAddress<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress"
                 priority="1188"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TaxJurisdiction)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may not contain oagis:TaxJurisdiction<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may not contain oagis:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:AddressId"
                 priority="1187"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@qualifyingAgency)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:AddressId may not contain @qualifyingAgency<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:Description"
                 priority="1186"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@owner)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:Description may not contain @owner<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:Description may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Description"
                 priority="1185"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Description may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@owner)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Description may not contain @owner<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person"
                 priority="1184"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:PersonCode)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person may not contain oagis:PersonCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person may not contain oagis:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName"
                 priority="1183"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may not contain oagis:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:FamilyName"
                 priority="1182"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:FamilyName may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:FormattedName"
                 priority="1181"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:FormattedName may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:GivenName"
                 priority="1180"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:GivenName may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:MiddleName"
                 priority="1179"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:MiddleName may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:PreferredGivenName"
                 priority="1178"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:PreferredGivenName may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:Salutation"
                 priority="1177"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:Salutation may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:Suffix"
                 priority="1176"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:Suffix may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Description"
                 priority="1175"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@owner)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Description may not contain @owner<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Description may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Name"
                 priority="1174"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Name may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:PartyId"
                 priority="1173"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:DUNS)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:PartyId may not contain oagis:DUNS<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SCAC)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:PartyId may not contain oagis:SCAC<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty"
                 priority="1172"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty may not contain oagis:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Business)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty may not contain oagis:Business<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@oneTime)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty may not contain @oneTime<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TermId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty may not contain oagis:TermId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:GLEntity)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty may not contain oagis:GLEntity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:CorrespondenceLanguage)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty may not contain oagis:CorrespondenceLanguage<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Attachments)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty may not contain oagis:Attachments<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Qualification)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty may not contain oagis:Qualification<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Rating)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty may not contain oagis:Rating<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Currency)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty may not contain oagis:Currency<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@active)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty may not contain @active<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TaxExemptInd)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty may not contain oagis:TaxExemptInd<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:AlternatePartyIds)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty may not contain oagis:AlternatePartyIds<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:PaymentMethod)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty may not contain oagis:PaymentMethod<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses"
                 priority="1171"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Address)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses may not contain oagis:Address<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ShippingAddress)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses may not contain oagis:ShippingAddress<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SecondaryAddress)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses may not contain oagis:SecondaryAddress<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:DropShipAddress)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses may not contain oagis:DropShipAddress<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress"
                 priority="1170"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TaxJurisdiction)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress may not contain oagis:TaxJurisdiction<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress may not contain oagis:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress/oagis:AddressId"
                 priority="1169"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@qualifyingAgency)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress/oagis:AddressId may not contain @qualifyingAgency<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress/oagis:Description"
                 priority="1168"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@owner)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress/oagis:Description may not contain @owner<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress/oagis:Description may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts"
                 priority="1167"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:AccountingContact)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts may not contain oagis:AccountingContact<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SalesContact)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts may not contain oagis:SalesContact<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:DeliverToContact)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts may not contain oagis:DeliverToContact<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:MarketingContact)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts may not contain oagis:MarketingContact<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SecondaryContact)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts may not contain oagis:SecondaryContact<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Planner)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts may not contain oagis:Planner<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Requester)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts may not contain oagis:Requester<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:PrimaryContact)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts may not contain oagis:PrimaryContact<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SalesPerson)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts may not contain oagis:SalesPerson<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ContactAbs)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts may not contain oagis:ContactAbs<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Buyer)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts may not contain oagis:Buyer<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact"
                 priority="1166"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact may not contain oagis:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses"
                 priority="1165"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ShippingAddress)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses may not contain oagis:ShippingAddress<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SecondaryAddress)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses may not contain oagis:SecondaryAddress<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:DropShipAddress)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses may not contain oagis:DropShipAddress<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Address)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses may not contain oagis:Address<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress"
                 priority="1164"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TaxJurisdiction)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may not contain oagis:TaxJurisdiction<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may not contain oagis:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:AddressId"
                 priority="1163"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@qualifyingAgency)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:AddressId may not contain @qualifyingAgency<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:Description"
                 priority="1162"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@owner)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:Description may not contain @owner<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:Description may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Description"
                 priority="1161"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Description may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@owner)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Description may not contain @owner<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person"
                 priority="1160"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:PersonCode)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person may not contain oagis:PersonCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person may not contain oagis:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName"
                 priority="1159"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may not contain oagis:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:FamilyName"
                 priority="1158"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:FamilyName may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:FormattedName"
                 priority="1157"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:FormattedName may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:GivenName"
                 priority="1156"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:GivenName may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:MiddleName"
                 priority="1155"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:MiddleName may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:PreferredGivenName"
                 priority="1154"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:PreferredGivenName may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:Salutation"
                 priority="1153"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:Salutation may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:Suffix"
                 priority="1152"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:Suffix may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Description"
                 priority="1151"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@owner)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Description may not contain @owner<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Description may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Name"
                 priority="1150"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Name may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:PartyId"
                 priority="1149"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SCAC)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:PartyId may not contain oagis:SCAC<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:DUNS)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:PartyId may not contain oagis:DUNS<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty"
                 priority="1148"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TaxExemptInd)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty may not contain oagis:TaxExemptInd<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:CorrespondenceLanguage)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty may not contain oagis:CorrespondenceLanguage<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:AlternatePartyIds)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty may not contain oagis:AlternatePartyIds<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@oneTime)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty may not contain @oneTime<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:GLEntity)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty may not contain oagis:GLEntity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TermId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty may not contain oagis:TermId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty may not contain oagis:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Qualification)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty may not contain oagis:Qualification<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Rating)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty may not contain oagis:Rating<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@active)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty may not contain @active<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:PaymentMethod)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty may not contain oagis:PaymentMethod<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Attachments)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty may not contain oagis:Attachments<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Currency)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty may not contain oagis:Currency<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Business)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty may not contain oagis:Business<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses"
                 priority="1147"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:DropShipAddress)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses may not contain oagis:DropShipAddress<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SecondaryAddress)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses may not contain oagis:SecondaryAddress<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ShippingAddress)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses may not contain oagis:ShippingAddress<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Address)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses may not contain oagis:Address<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress"
                 priority="1146"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress may not contain oagis:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TaxJurisdiction)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress may not contain oagis:TaxJurisdiction<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress/oagis:AddressId"
                 priority="1145"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@qualifyingAgency)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress/oagis:AddressId may not contain @qualifyingAgency<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress/oagis:Description"
                 priority="1144"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@owner)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress/oagis:Description may not contain @owner<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress/oagis:Description may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts"
                 priority="1143"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SalesPerson)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts may not contain oagis:SalesPerson<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Requester)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts may not contain oagis:Requester<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:AccountingContact)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts may not contain oagis:AccountingContact<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SalesContact)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts may not contain oagis:SalesContact<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SecondaryContact)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts may not contain oagis:SecondaryContact<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:DeliverToContact)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts may not contain oagis:DeliverToContact<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ContactAbs)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts may not contain oagis:ContactAbs<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Buyer)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts may not contain oagis:Buyer<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:MarketingContact)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts may not contain oagis:MarketingContact<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Planner)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts may not contain oagis:Planner<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:PrimaryContact)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts may not contain oagis:PrimaryContact<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact"
                 priority="1142"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact may not contain oagis:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses"
                 priority="1141"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Address)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses may not contain oagis:Address<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:DropShipAddress)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses may not contain oagis:DropShipAddress<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ShippingAddress)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses may not contain oagis:ShippingAddress<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SecondaryAddress)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses may not contain oagis:SecondaryAddress<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress"
                 priority="1140"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TaxJurisdiction)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may not contain oagis:TaxJurisdiction<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may not contain oagis:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:AddressId"
                 priority="1139"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@qualifyingAgency)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:AddressId may not contain @qualifyingAgency<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:Description"
                 priority="1138"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:Description may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@owner)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:Description may not contain @owner<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Description"
                 priority="1137"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@owner)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Description may not contain @owner<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Description may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person"
                 priority="1136"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:PersonCode)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person may not contain oagis:PersonCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person may not contain oagis:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName"
                 priority="1135"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may not contain oagis:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:FamilyName"
                 priority="1134"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:FamilyName may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:FormattedName"
                 priority="1133"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:FormattedName may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:GivenName"
                 priority="1132"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:GivenName may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:MiddleName"
                 priority="1131"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:MiddleName may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:PreferredGivenName"
                 priority="1130"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:PreferredGivenName may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:Salutation"
                 priority="1129"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:Salutation may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:Suffix"
                 priority="1128"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:Suffix may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Description"
                 priority="1127"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Description may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@owner)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Description may not contain @owner<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Name"
                 priority="1126"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Name may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:PartyId"
                 priority="1125"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SCAC)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:PartyId may not contain oagis:SCAC<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:DUNS)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:PartyId may not contain oagis:DUNS<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:PaymentTerms" priority="1124" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:LineNumber)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:PaymentTerms may not contain oagis:LineNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TermId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:PaymentTerms may not contain oagis:TermId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ProximoNumberMonth)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:PaymentTerms may not contain oagis:ProximoNumberMonth<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:PaymentTerms may not contain oagis:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:PaymentTerms/oagis:Description"
                 priority="1123"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@owner)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:PaymentTerms/oagis:Description may not contain @owner<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:PaymentTerms/oagis:Description may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Tax" priority="1122" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TaxJurisdiction)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Tax may not contain oagis:TaxJurisdiction<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Tax)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Tax may not contain oagis:Tax<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Charges)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Tax may not contain oagis:Charges<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Description)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Tax may not contain oagis:Description<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Tax may not contain oagis:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TaxCode)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Tax may not contain oagis:TaxCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:LineNumber)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Tax may not contain oagis:LineNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"
                 priority="1121"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerJobDescription)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobDescription<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationName)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerJobCode)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExternalOrderNumber)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalOrderNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Entity)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Entity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Shift)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Shift<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExternalReqNumber)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalReqNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubEntity)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SubEntity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ContactName)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ContactName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationCode)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ManagerName)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ManagerName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SupervisorName)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SupervisorName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AccountCode)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:AccountCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation"
                 priority="1120"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:IntermediaryId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:IntermediaryId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:MasterOrderId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:MasterOrderId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:HumanResourceId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:HumanResourceId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DocumentId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:DocumentId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:BillToEntityId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:BillToEntityId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:InvoiceId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:InvoiceId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:OrderId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:OrderId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:StaffingOrganizationId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:StaffingOrganizationId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PositionId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:PositionId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId"
                 priority="1119"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId/hrxml:IdValue"
                 priority="1118"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId"
                 priority="1117"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/hrxml:IdValue"
                 priority="1116"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId"
                 priority="1115"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/hrxml:IdValue"
                 priority="1114"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId"
                 priority="1113"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/hrxml:IdValue"
                 priority="1112"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId"
                 priority="1111"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/hrxml:IdValue"
                 priority="1110"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization"
                 priority="1109"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ReferenceIdInfo)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization may not contain hrxml:ReferenceIdInfo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization may not contain hrxml:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization"
                 priority="1108"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization may not contain hrxml:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:MissionStatement)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization may not contain hrxml:MissionStatement<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:IsPublicCompany)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization may not contain hrxml:IsPublicCompany<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:IndustryCode)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization may not contain hrxml:IndustryCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Description)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization may not contain hrxml:Description<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ValueStatement)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization may not contain hrxml:ValueStatement<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:OrganizationalUnit)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization may not contain hrxml:OrganizationalUnit<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DunsNumber)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization may not contain hrxml:DunsNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ContactInfo)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization may not contain hrxml:ContactInfo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:TaxId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization may not contain hrxml:TaxId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LegalClassification)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization may not contain hrxml:LegalClassification<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:OrganizationId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization may not contain hrxml:OrganizationId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LegalId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization may not contain hrxml:LegalId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Stock)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization may not contain hrxml:Stock<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:RelatedOrganization)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization may not contain hrxml:RelatedOrganization<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:WorkSite)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization may not contain hrxml:WorkSite<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Headcount)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization may not contain hrxml:Headcount<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DoingBusinessAs)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization may not contain hrxml:DoingBusinessAs<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:InternetDomainName)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization may not contain hrxml:InternetDomainName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo"
                 priority="1107"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CollectiveAgreement)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo may not contain hrxml:CollectiveAgreement<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PaymentCondition)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo may not contain hrxml:PaymentCondition<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:TaxEvaluation)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo may not contain hrxml:TaxEvaluation<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Capital)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo may not contain hrxml:Capital<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:OrganizationalUnitId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo may not contain hrxml:OrganizationalUnitId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:OrganizationId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo may not contain hrxml:OrganizationId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo may not contain hrxml:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:VATRate)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo may not contain hrxml:VATRate<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo/hrxml:BankAccountInfo"
                 priority="1106"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:BankAccountForeign)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo/hrxml:BankAccountInfo may not contain hrxml:BankAccountForeign<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line" priority="1105" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Note)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line may not contain oagis:Note<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:OrderItem)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line may not contain oagis:OrderItem<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:PackingMaterial)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line may not contain oagis:PackingMaterial<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ExtendedPrice)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line may not contain oagis:ExtendedPrice<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Attachments)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line may not contain oagis:Attachments<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TransportationTerm)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line may not contain oagis:TransportationTerm<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SubstitutionAllowedInd)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line may not contain oagis:SubstitutionAllowedInd<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ShipNote)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line may not contain oagis:ShipNote<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ActualTemperature)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line may not contain oagis:ActualTemperature<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ShipPriorToDueDateInd)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line may not contain oagis:ShipPriorToDueDateInd<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Parties)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line may not contain oagis:Parties<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:UnitPrice)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line may not contain oagis:UnitPrice<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:License)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line may not contain oagis:License<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:MinimumTemperature)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line may not contain oagis:MinimumTemperature<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Allowance)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line may not contain oagis:Allowance<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ProjectResource)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line may not contain oagis:ProjectResource<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:FreightClass)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line may not contain oagis:FreightClass<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:OrderStatus)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line may not contain oagis:OrderStatus<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Distribution)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line may not contain oagis:Distribution<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:PromisedShipDate)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line may not contain oagis:PromisedShipDate<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:PromisedDeliveryDate)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line may not contain oagis:PromisedDeliveryDate<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TotalAmount)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line may not contain oagis:TotalAmount<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:DropShipInd)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line may not contain oagis:DropShipInd<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:PaymentTerms)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line may not contain oagis:PaymentTerms<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ShippingNote)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line may not contain oagis:ShippingNote<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SpecialHandlingNote)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line may not contain oagis:SpecialHandlingNote<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:LoadingTemperature)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line may not contain oagis:LoadingTemperature<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:DeliveryTemperature)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line may not contain oagis:DeliveryTemperature<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:MaximumTemperature)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line may not contain oagis:MaximumTemperature<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TaxWithholdingExempt)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line may not contain oagis:TaxWithholdingExempt<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ProjectActivity)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line may not contain oagis:ProjectActivity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:BackOrderedQuantity)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line may not contain oagis:BackOrderedQuantity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:NeedDeliveryDate)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line may not contain oagis:NeedDeliveryDate<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:OrderQuantity)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line may not contain oagis:OrderQuantity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:EarliestShipDate)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line may not contain oagis:EarliestShipDate<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Priority)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line may not contain oagis:Priority<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:BackOrderedInd)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line may not contain oagis:BackOrderedInd<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Charges" priority="1104" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TransportToLocationCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Charges may not contain oagis:TransportToLocationCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:BasicFreightCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Charges may not contain oagis:BasicFreightCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:AllCostsToLocationCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Charges may not contain oagis:AllCostsToLocationCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:WeightValuationCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Charges may not contain oagis:WeightValuationCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SpecificAmountCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Charges may not contain oagis:SpecificAmountCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Charge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Charges may not contain oagis:Charge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SupplementaryCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Charges may not contain oagis:SupplementaryCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:DestinationHaulageCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Charges may not contain oagis:DestinationHaulageCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:DestinationPortCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Charges may not contain oagis:DestinationPortCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:AdditionalCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Charges may not contain oagis:AdditionalCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TransportPlusAdditionalCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Charges may not contain oagis:TransportPlusAdditionalCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:MiscellaneousCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Charges may not contain oagis:MiscellaneousCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:OriginPortCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Charges may not contain oagis:OriginPortCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:DistribursmentCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Charges may not contain oagis:DistribursmentCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TransportationCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Charges may not contain oagis:TransportationCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:AllCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Charges may not contain oagis:AllCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Charges/oagis:TotalCharge"
                 priority="1103"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Id)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Charges/oagis:TotalCharge may not contain oagis:Id<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Charges/oagis:TotalCharge may not contain oagis:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Cost)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Charges/oagis:TotalCharge may not contain oagis:Cost<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Distribution)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Charges/oagis:TotalCharge may not contain oagis:Distribution<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Description)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Charges/oagis:TotalCharge may not contain oagis:Description<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Description" priority="1102" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@owner)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Description may not contain @owner<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Description may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:DocumentReferences" priority="1101"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:RequisitionDocumentReference)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:DocumentReferences may not contain oagis:RequisitionDocumentReference<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:CatalogDocumentReference)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:DocumentReferences may not contain oagis:CatalogDocumentReference<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:PurchaseOrderDocumentReference)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:DocumentReferences may not contain oagis:PurchaseOrderDocumentReference<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:VoucherDocumentReference)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:DocumentReferences may not contain oagis:VoucherDocumentReference<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SalesOrderDocumentReference)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:DocumentReferences may not contain oagis:SalesOrderDocumentReference<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:RFQDocumentReference)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:DocumentReferences may not contain oagis:RFQDocumentReference<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:LedgerDocumentReference)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:DocumentReferences may not contain oagis:LedgerDocumentReference<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ProjectReference)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:DocumentReferences may not contain oagis:ProjectReference<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:UOMGroupReference)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:DocumentReferences may not contain oagis:UOMGroupReference<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ContractDocumentReference)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:DocumentReferences may not contain oagis:ContractDocumentReference<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:MaintenanceOrderReference)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:DocumentReferences may not contain oagis:MaintenanceOrderReference<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ReceiptDocumentReference)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:DocumentReferences may not contain oagis:ReceiptDocumentReference<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:QuoteDocumentReference)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:DocumentReferences may not contain oagis:QuoteDocumentReference<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference"
                 priority="1100"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Status)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:Status<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Note)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:Note<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Name)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:Name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Description)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:Description<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:DocumentDate)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:DocumentDate<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ScheduleLineNumber)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:ScheduleLineNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Usage)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:Usage<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SubLineNumber)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:SubLineNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds"
                 priority="1099"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:CustomerDocumentId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds may not contain oagis:CustomerDocumentId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ShippersDocumentId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds may not contain oagis:ShippersDocumentId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:LogisticsProviderDocumentId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds may not contain oagis:LogisticsProviderDocumentId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:CarrierDocumentId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds may not contain oagis:CarrierDocumentId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SupplierDocumentId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds may not contain oagis:SupplierDocumentId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:BrokerDocumentId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds may not contain oagis:BrokerDocumentId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds/oagis:DocumentId"
                 priority="1098"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Revision)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds/oagis:DocumentId may not contain oagis:Revision<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line" priority="1097" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:EarliestShipDate)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:EarliestShipDate<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ActualTemperature)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:ActualTemperature<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:License)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:License<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TaxWithholdingExempt)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:TaxWithholdingExempt<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:FreightClass)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:FreightClass<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Priority)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:Priority<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:UnitPrice)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:UnitPrice<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:OrderItem)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:OrderItem<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ProjectActivity)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:ProjectActivity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:LoadingTemperature)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:LoadingTemperature<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TransportationTerm)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:TransportationTerm<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TotalAmount)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:TotalAmount<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ProjectResource)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:ProjectResource<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:MaximumTemperature)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:MaximumTemperature<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SpecialHandlingNote)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:SpecialHandlingNote<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:MinimumTemperature)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:MinimumTemperature<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ShippingNote)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:ShippingNote<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:NeedDeliveryDate)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:NeedDeliveryDate<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:BackOrderedInd)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:BackOrderedInd<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Distribution)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:Distribution<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:DeliveryTemperature)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:DeliveryTemperature<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Line)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:Line<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:DropShipInd)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:DropShipInd<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:BackOrderedQuantity)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:BackOrderedQuantity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Parties)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:Parties<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ShipNote)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:ShipNote<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ExtendedPrice)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:ExtendedPrice<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Note)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:Note<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:PackingMaterial)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:PackingMaterial<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Allowance)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:Allowance<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SubstitutionAllowedInd)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:SubstitutionAllowedInd<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ShipPriorToDueDateInd)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:ShipPriorToDueDateInd<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:PaymentTerms)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:PaymentTerms<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Attachments)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:Attachments<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:PromisedShipDate)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:PromisedShipDate<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:OrderQuantity)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:OrderQuantity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:OrderStatus)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:OrderStatus<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:PromisedDeliveryDate)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:PromisedDeliveryDate<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges" priority="1096"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TransportToLocationCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges may not contain oagis:TransportToLocationCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:MiscellaneousCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges may not contain oagis:MiscellaneousCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:DestinationHaulageCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges may not contain oagis:DestinationHaulageCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:DestinationPortCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges may not contain oagis:DestinationPortCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:BasicFreightCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges may not contain oagis:BasicFreightCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:WeightValuationCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges may not contain oagis:WeightValuationCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:AllCostsToLocationCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges may not contain oagis:AllCostsToLocationCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:DistribursmentCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges may not contain oagis:DistribursmentCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Charge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges may not contain oagis:Charge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:OriginPortCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges may not contain oagis:OriginPortCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TransportationCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges may not contain oagis:TransportationCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SupplementaryCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges may not contain oagis:SupplementaryCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SpecificAmountCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges may not contain oagis:SpecificAmountCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:AdditionalCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges may not contain oagis:AdditionalCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TransportPlusAdditionalCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges may not contain oagis:TransportPlusAdditionalCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:AllCharge)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges may not contain oagis:AllCharge<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges/oagis:TotalCharge"
                 priority="1095"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Description)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges/oagis:TotalCharge may not contain oagis:Description<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Id)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges/oagis:TotalCharge may not contain oagis:Id<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Cost)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges/oagis:TotalCharge may not contain oagis:Cost<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Distribution)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges/oagis:TotalCharge may not contain oagis:Distribution<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges/oagis:TotalCharge may not contain oagis:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:Description" priority="1094"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:Description may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@owner)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:Description may not contain @owner<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences"
                 priority="1093"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:PurchaseOrderDocumentReference)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences may not contain oagis:PurchaseOrderDocumentReference<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:UOMGroupReference)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences may not contain oagis:UOMGroupReference<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:LedgerDocumentReference)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences may not contain oagis:LedgerDocumentReference<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:MaintenanceOrderReference)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences may not contain oagis:MaintenanceOrderReference<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SalesOrderDocumentReference)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences may not contain oagis:SalesOrderDocumentReference<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ContractDocumentReference)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences may not contain oagis:ContractDocumentReference<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:RFQDocumentReference)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences may not contain oagis:RFQDocumentReference<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ReceiptDocumentReference)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences may not contain oagis:ReceiptDocumentReference<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:CatalogDocumentReference)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences may not contain oagis:CatalogDocumentReference<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:RequisitionDocumentReference)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences may not contain oagis:RequisitionDocumentReference<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:QuoteDocumentReference)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences may not contain oagis:QuoteDocumentReference<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ProjectReference)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences may not contain oagis:ProjectReference<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:VoucherDocumentReference)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences may not contain oagis:VoucherDocumentReference<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference"
                 priority="1092"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Name)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:Name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Description)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:Description<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ScheduleLineNumber)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:ScheduleLineNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SubLineNumber)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:SubLineNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:DocumentDate)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:DocumentDate<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Status)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:Status<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Usage)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:Usage<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Note)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference may not contain oagis:Note<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds"
                 priority="1091"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:CarrierDocumentId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds may not contain oagis:CarrierDocumentId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:LogisticsProviderDocumentId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds may not contain oagis:LogisticsProviderDocumentId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:SupplierDocumentId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds may not contain oagis:SupplierDocumentId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ShippersDocumentId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds may not contain oagis:ShippersDocumentId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:BrokerDocumentId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds may not contain oagis:BrokerDocumentId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:CustomerDocumentId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds may not contain oagis:CustomerDocumentId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds/oagis:DocumentId"
                 priority="1090"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Revision)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds/oagis:DocumentId may not contain oagis:Revision<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:Price" priority="1089"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:FunctionalAmout)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:Price may not contain oagis:FunctionalAmout<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:Tax" priority="1088" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TaxJurisdiction)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:Tax may not contain oagis:TaxJurisdiction<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Description)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:Tax may not contain oagis:Description<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TaxCode)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:Tax may not contain oagis:TaxCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:LineNumber)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:Tax may not contain oagis:LineNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Charges)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:Tax may not contain oagis:Charges<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Tax)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:Tax may not contain oagis:Tax<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:Tax may not contain oagis:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData"
                 priority="1087"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ReferenceInformation)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData may not contain hrxml:ReferenceInformation<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"
                 priority="1086"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Entity)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Entity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SupervisorName)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SupervisorName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ContactName)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ContactName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Shift)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Shift<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ManagerName)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ManagerName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationName)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExternalReqNumber)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalReqNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationCode)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerJobCode)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AccountCode)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:AccountCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerJobDescription)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobDescription<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExternalOrderNumber)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalOrderNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubEntity)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SubEntity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard"
                 priority="1085"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard may not contain hrxml:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData"
                 priority="1084"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@type)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData may not contain @type<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"
                 priority="1083"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Shift)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Shift<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SupervisorName)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SupervisorName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerJobDescription)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobDescription<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubEntity)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SubEntity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationCode)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationName)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ContactName)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ContactName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AccountCode)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:AccountCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExternalOrderNumber)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalOrderNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ManagerName)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ManagerName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerJobCode)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExternalReqNumber)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalReqNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Entity)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Entity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation"
                 priority="1082"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:OrderId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:OrderId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:HumanResourceId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:HumanResourceId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:BillToEntityId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:BillToEntityId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:InvoiceId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:InvoiceId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DocumentId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:DocumentId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:IntermediaryId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:IntermediaryId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PositionId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:PositionId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:StaffingOrganizationId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:StaffingOrganizationId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:MasterOrderId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:MasterOrderId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId"
                 priority="1081"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId/hrxml:IdValue"
                 priority="1080"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId"
                 priority="1079"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/hrxml:IdValue"
                 priority="1078"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId"
                 priority="1077"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/hrxml:IdValue"
                 priority="1076"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId"
                 priority="1075"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/hrxml:IdValue"
                 priority="1074"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId"
                 priority="1073"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/hrxml:IdValue"
                 priority="1072"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo"
                 priority="1071"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@approverType)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo may not contain @approverType<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Comment"
                 priority="1070"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Comment may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id"
                 priority="1069"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id/hrxml:IdValue"
                 priority="1068"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName"
                 priority="1067"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@script)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName may not contain @script<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AlternateScript)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName may not contain hrxml:AlternateScript<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id"
                 priority="1066"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id/hrxml:IdValue"
                 priority="1065"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource"
                 priority="1064"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Resource)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource may not contain hrxml:Resource<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id"
                 priority="1063"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id/hrxml:IdValue"
                 priority="1062"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName"
                 priority="1061"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AlternateScript)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName may not contain hrxml:AlternateScript<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@script)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName may not contain @script<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime"
                 priority="1060"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ReportedPersonAssignment)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:ReportedPersonAssignment<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubmitterInfo)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:SubmitterInfo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Expense)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:Expense<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AdditionalData)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:AdditionalData<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:TimeEvent)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:TimeEvent<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ApprovalInfo)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:ApprovalInfo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance"
                 priority="1059"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ApprovalInfo)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance may not contain hrxml:ApprovalInfo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubmitterInfo)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance may not contain hrxml:SubmitterInfo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData"
                 priority="1058"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@type)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData may not contain @type<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData"
                 priority="1057"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ReferenceInformation)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData may not contain hrxml:ReferenceInformation<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"
                 priority="1056"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ManagerName)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ManagerName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SupervisorName)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SupervisorName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Entity)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Entity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ContactName)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ContactName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubEntity)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SubEntity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AccountCode)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:AccountCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerJobCode)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationName)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Shift)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Shift<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationCode)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerJobDescription)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobDescription<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExternalOrderNumber)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalOrderNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExternalReqNumber)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalReqNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Comment"
                 priority="1055"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Comment may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id"
                 priority="1054"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval"
                 priority="1053"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Allowance)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval may not contain hrxml:Allowance<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubmitterInfo)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval may not contain hrxml:SubmitterInfo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ApprovalInfo)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval may not contain hrxml:ApprovalInfo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PieceWork)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval may not contain hrxml:PieceWork<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData"
                 priority="1052"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@type)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData may not contain @type<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData"
                 priority="1051"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ReferenceInformation)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData may not contain hrxml:ReferenceInformation<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"
                 priority="1050"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExternalReqNumber)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalReqNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ManagerName)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ManagerName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AccountCode)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:AccountCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerJobDescription)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobDescription<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Entity)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Entity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerJobCode)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExternalOrderNumber)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalOrderNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationCode)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ContactName)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ContactName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubEntity)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SubEntity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationName)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Shift)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Shift<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SupervisorName)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SupervisorName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Comment"
                 priority="1049"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Comment may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id"
                 priority="1048"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id/hrxml:IdValue"
                 priority="1047"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount"
                 priority="1046"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@period)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount may not contain @period<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:SubmitterInfo"
                 priority="1045"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Person)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:SubmitterInfo may not contain hrxml:Person<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Price" priority="1044" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:FunctionalAmout)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Price may not contain oagis:FunctionalAmout<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Tax" priority="1043" mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:LineNumber)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Tax may not contain oagis:LineNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Tax)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Tax may not contain oagis:Tax<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TaxJurisdiction)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Tax may not contain oagis:TaxJurisdiction<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:TaxCode)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Tax may not contain oagis:TaxCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Charges)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Tax may not contain oagis:Charges<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Description)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Tax may not contain oagis:Description<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Tax may not contain oagis:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData"
                 priority="1042"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ReferenceInformation)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData may not contain hrxml:ReferenceInformation<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"
                 priority="1041"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExternalReqNumber)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalReqNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Entity)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Entity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerJobDescription)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobDescription<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AccountCode)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:AccountCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SupervisorName)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SupervisorName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubEntity)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SubEntity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExternalOrderNumber)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalOrderNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationName)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ContactName)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ContactName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ManagerName)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ManagerName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationCode)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Shift)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Shift<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerJobCode)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard" priority="1040"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard may not contain hrxml:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData"
                 priority="1039"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@type)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData may not contain @type<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"
                 priority="1038"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExternalReqNumber)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalReqNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Shift)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Shift<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationName)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationCode)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Entity)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Entity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExternalOrderNumber)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalOrderNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubEntity)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SubEntity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AccountCode)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:AccountCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ContactName)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ContactName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ManagerName)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ManagerName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerJobDescription)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobDescription<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerJobCode)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SupervisorName)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SupervisorName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation"
                 priority="1037"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:OrderId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:OrderId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:UserArea)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:UserArea<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PositionId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:PositionId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:BillToEntityId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:BillToEntityId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:HumanResourceId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:HumanResourceId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:StaffingOrganizationId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:StaffingOrganizationId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:InvoiceId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:InvoiceId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:MasterOrderId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:MasterOrderId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:IntermediaryId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:IntermediaryId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DocumentId)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:DocumentId<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId"
                 priority="1036"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId/hrxml:IdValue"
                 priority="1035"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId"
                 priority="1034"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/hrxml:IdValue"
                 priority="1033"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId"
                 priority="1032"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/hrxml:IdValue"
                 priority="1031"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId"
                 priority="1030"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/hrxml:IdValue"
                 priority="1029"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId"
                 priority="1028"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/hrxml:IdValue"
                 priority="1027"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo"
                 priority="1026"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@approverType)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo may not contain @approverType<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Comment"
                 priority="1025"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Comment may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id"
                 priority="1024"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id/hrxml:IdValue"
                 priority="1023"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName"
                 priority="1022"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@script)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName may not contain @script<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AlternateScript)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName may not contain hrxml:AlternateScript<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id"
                 priority="1021"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id/hrxml:IdValue"
                 priority="1020"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource"
                 priority="1019"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Resource)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource may not contain hrxml:Resource<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id"
                 priority="1018"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id/hrxml:IdValue"
                 priority="1017"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName"
                 priority="1016"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@script)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName may not contain @script<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AlternateScript)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName may not contain hrxml:AlternateScript<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime"
                 priority="1015"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ReportedPersonAssignment)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:ReportedPersonAssignment<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Expense)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:Expense<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ApprovalInfo)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:ApprovalInfo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AdditionalData)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:AdditionalData<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:TimeEvent)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:TimeEvent<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubmitterInfo)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:SubmitterInfo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance"
                 priority="1014"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ApprovalInfo)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance may not contain hrxml:ApprovalInfo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubmitterInfo)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance may not contain hrxml:SubmitterInfo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData"
                 priority="1013"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@type)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData may not contain @type<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData"
                 priority="1012"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ReferenceInformation)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData may not contain hrxml:ReferenceInformation<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"
                 priority="1011"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerJobDescription)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobDescription<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExternalOrderNumber)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalOrderNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExternalReqNumber)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalReqNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SupervisorName)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SupervisorName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubEntity)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SubEntity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationCode)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerJobCode)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Shift)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Shift<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Entity)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Entity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ManagerName)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ManagerName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AccountCode)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:AccountCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationName)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ContactName)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ContactName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Comment"
                 priority="1010"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Comment may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id"
                 priority="1009"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval"
                 priority="1008"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PieceWork)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval may not contain hrxml:PieceWork<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Allowance)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval may not contain hrxml:Allowance<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubmitterInfo)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval may not contain hrxml:SubmitterInfo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ApprovalInfo)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval may not contain hrxml:ApprovalInfo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData"
                 priority="1007"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@type)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData may not contain @type<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData"
                 priority="1006"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ReferenceInformation)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData may not contain hrxml:ReferenceInformation<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"
                 priority="1005"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationCode)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerJobCode)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Entity)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Entity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationName)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AccountCode)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:AccountCode<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExternalOrderNumber)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalOrderNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExternalReqNumber)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalReqNumber<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Shift)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Shift<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SupervisorName)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SupervisorName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubEntity)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SubEntity<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ContactName)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ContactName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ManagerName)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ManagerName<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerJobDescription)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobDescription<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Comment"
                 priority="1004"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Comment may not contain @lang<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id"
                 priority="1003"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id may not contain @validFrom<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id may not contain @validTo<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id/hrxml:IdValue"
                 priority="1002"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id/hrxml:IdValue may not contain @name<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount"
                 priority="1001"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@period)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount may not contain @period<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:SubmitterInfo"
                 priority="1000"
                 mode="M3">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Person)"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:SubmitterInfo may not contain hrxml:Person<xsl:value-of select="string('&#xA;')"/>
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
<xsl:template match="oagis:Invoice" priority="1127" mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Header) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice must contain oagis:Header at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header" priority="1126" mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:TotalTax) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header must contain oagis:TotalTax at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:TotalAmount) &gt;= 1 and count(oagis:TotalAmount) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header must contain oagis:TotalAmount at least 1 and at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:DocumentIds) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header must contain oagis:DocumentIds at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:TotalCharges) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header must contain oagis:TotalCharges at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:DocumentDateTime) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header must contain oagis:DocumentDateTime at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:UserArea) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header must contain oagis:UserArea at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:ReasonCode) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header must contain oagis:ReasonCode at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Parties) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header must contain oagis:Parties at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Type) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header must contain oagis:Type at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Attachments/oagis:Attachment"
                 priority="1125"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:FileType) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Attachments/oagis:Attachment must contain oagis:FileType at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Charges" priority="1124" mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Charge) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Charges may contain oagis:Charge at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Charges/oagis:Charge" priority="1123"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Total) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Charges/oagis:Charge must contain oagis:Total at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Description) &gt;= 1 and count(oagis:Description) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Charges/oagis:Charge must contain oagis:Description at least 1 and at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:DocumentIds" priority="1122" mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:DocumentId) &gt;= 1 and count(oagis:DocumentId) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentIds must contain oagis:DocumentId at least 1 and at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:DocumentIds/oagis:DocumentId"
                 priority="1121"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Id) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentIds/oagis:DocumentId must contain oagis:Id at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:DocumentReferences" priority="1120"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:InvoiceDocumentReference) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentReferences may contain oagis:InvoiceDocumentReference at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference"
                 priority="1119"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:DocumentIds) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference must contain oagis:DocumentIds at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds"
                 priority="1118"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:DocumentId) &gt;= 1 and count(oagis:DocumentId) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds must contain oagis:DocumentId at least 1 and at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds/oagis:DocumentId"
                 priority="1117"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Id) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds/oagis:DocumentId must contain oagis:Id at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties" priority="1116" mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:RemitToParty) &gt;= 1 and count(oagis:RemitToParty) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties must contain oagis:RemitToParty at least 1 and at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:BillToParty) &gt;= 1 and count(oagis:BillToParty) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties must contain oagis:BillToParty at least 1 and at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:CustomerParty) &gt;= 1 and count(oagis:CustomerParty) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties must contain oagis:CustomerParty at least 1 and at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:SupplierParty) &gt;= 1 and count(oagis:SupplierParty) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties must contain oagis:SupplierParty at least 1 and at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty"
                 priority="1115"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:PartyId) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty must contain oagis:PartyId at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Addresses) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty must contain oagis:Addresses at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Name) &gt;= 1 and count(oagis:Name) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty must contain oagis:Name at least 1 and at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses"
                 priority="1114"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:PrimaryAddress) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses must contain oagis:PrimaryAddress at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses/oagis:PrimaryAddress"
                 priority="1113"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:URI) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:URI at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:AddressLine) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:AddressLine at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:EMailAddress) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:EMailAddress at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:AddressId) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:AddressId at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:FaxNumber) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:FaxNumber at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Description) &gt;= 1 and count(oagis:Description) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses/oagis:PrimaryAddress must contain oagis:Description at least 1 and at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Telephone) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:Telephone at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact"
                 priority="1112"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Description) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact may contain oagis:Description at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Telephone) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact may contain oagis:Telephone at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:EMailAddress) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact may contain oagis:EMailAddress at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Fax) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact may contain oagis:Fax at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:URI) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact may contain oagis:URI at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Person) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact may contain oagis:Person at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses"
                 priority="1111"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:PrimaryAddress) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses must contain oagis:PrimaryAddress at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress"
                 priority="1110"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:EMailAddress) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:EMailAddress at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Description) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:Description at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Telephone) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:Telephone at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:URI) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:URI at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:AddressLine) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:AddressLine at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:FaxNumber) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:FaxNumber at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:AddressId) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:AddressId at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person"
                 priority="1109"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:PersonName) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person must contain oagis:PersonName at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName"
                 priority="1108"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:MiddleName) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:MiddleName at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Salutation) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:Salutation at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Suffix) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:Suffix at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:FormattedName) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:FormattedName at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:PreferredGivenName) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:PreferredGivenName at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:PartyId"
                 priority="1107"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Id) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:PartyId must contain oagis:Id at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty"
                 priority="1106"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Addresses) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty must contain oagis:Addresses at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:PartyId) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty must contain oagis:PartyId at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Name) &gt;= 1 and count(oagis:Name) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty must contain oagis:Name at least 1 and at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses"
                 priority="1105"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:PrimaryAddress) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses must contain oagis:PrimaryAddress at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress"
                 priority="1104"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Telephone) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:Telephone at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:AddressLine) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:AddressLine at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:URI) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:URI at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Description) &gt;= 1 and count(oagis:Description) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress must contain oagis:Description at least 1 and at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:FaxNumber) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:FaxNumber at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:EMailAddress) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:EMailAddress at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:AddressId) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:AddressId at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact"
                 priority="1103"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Fax) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact may contain oagis:Fax at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Telephone) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact may contain oagis:Telephone at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:EMailAddress) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact may contain oagis:EMailAddress at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Description) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact may contain oagis:Description at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:URI) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact may contain oagis:URI at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Person) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact may contain oagis:Person at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses"
                 priority="1102"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:PrimaryAddress) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses must contain oagis:PrimaryAddress at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress"
                 priority="1101"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:URI) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:URI at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:EMailAddress) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:EMailAddress at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:FaxNumber) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:FaxNumber at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Description) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:Description at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:AddressId) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:AddressId at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:AddressLine) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:AddressLine at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Telephone) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:Telephone at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person"
                 priority="1100"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:PersonName) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person must contain oagis:PersonName at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName"
                 priority="1099"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Suffix) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:Suffix at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:PreferredGivenName) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:PreferredGivenName at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Salutation) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:Salutation at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:FormattedName) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:FormattedName at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:MiddleName) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:MiddleName at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:PartyId"
                 priority="1098"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Id) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:PartyId must contain oagis:Id at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty"
                 priority="1097"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Name) &gt;= 1 and count(oagis:Name) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty must contain oagis:Name at least 1 and at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Addresses) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty must contain oagis:Addresses at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:PartyId) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty must contain oagis:PartyId at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses"
                 priority="1096"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:PrimaryAddress) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses must contain oagis:PrimaryAddress at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress"
                 priority="1095"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Telephone) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:Telephone at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Description) &gt;= 1 and count(oagis:Description) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress must contain oagis:Description at least 1 and at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:URI) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:URI at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:EMailAddress) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:EMailAddress at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:AddressId) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:AddressId at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:AddressLine) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:AddressLine at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:FaxNumber) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:FaxNumber at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact"
                 priority="1094"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:URI) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact may contain oagis:URI at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Person) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact may contain oagis:Person at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Description) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact may contain oagis:Description at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Telephone) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact may contain oagis:Telephone at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:EMailAddress) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact may contain oagis:EMailAddress at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Fax) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact may contain oagis:Fax at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses"
                 priority="1093"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:PrimaryAddress) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses must contain oagis:PrimaryAddress at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress"
                 priority="1092"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Telephone) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:Telephone at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:URI) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:URI at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:EMailAddress) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:EMailAddress at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:AddressLine) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:AddressLine at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:AddressId) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:AddressId at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Description) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:Description at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:FaxNumber) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:FaxNumber at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person"
                 priority="1091"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:PersonName) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person must contain oagis:PersonName at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName"
                 priority="1090"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:PreferredGivenName) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:PreferredGivenName at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Suffix) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:Suffix at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:MiddleName) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:MiddleName at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Salutation) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:Salutation at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:FormattedName) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:FormattedName at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:PartyId"
                 priority="1089"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Id) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:PartyId must contain oagis:Id at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty"
                 priority="1088"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Addresses) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty must contain oagis:Addresses at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:PartyId) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty must contain oagis:PartyId at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Name) &gt;= 1 and count(oagis:Name) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty must contain oagis:Name at least 1 and at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:TaxId) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty must contain oagis:TaxId at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses"
                 priority="1087"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:PrimaryAddress) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses must contain oagis:PrimaryAddress at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress"
                 priority="1086"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Description) &gt;= 1 and count(oagis:Description) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress must contain oagis:Description at least 1 and at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:EMailAddress) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:EMailAddress at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:FaxNumber) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:FaxNumber at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Telephone) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:Telephone at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:AddressId) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:AddressId at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:AddressLine) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:AddressLine at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:URI) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:URI at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact"
                 priority="1085"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Fax) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact may contain oagis:Fax at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Person) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact may contain oagis:Person at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:EMailAddress) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact may contain oagis:EMailAddress at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Description) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact may contain oagis:Description at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Telephone) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact may contain oagis:Telephone at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:URI) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact may contain oagis:URI at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses"
                 priority="1084"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:PrimaryAddress) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses must contain oagis:PrimaryAddress at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress"
                 priority="1083"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:AddressLine) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:AddressLine at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:AddressId) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:AddressId at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Description) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:Description at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:EMailAddress) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:EMailAddress at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:FaxNumber) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:FaxNumber at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:URI) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:URI at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Telephone) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress may contain oagis:Telephone at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person"
                 priority="1082"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:PersonName) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person must contain oagis:PersonName at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName"
                 priority="1081"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Suffix) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:Suffix at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:FormattedName) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:FormattedName at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:MiddleName) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:MiddleName at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:PreferredGivenName) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:PreferredGivenName at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Salutation) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:Salutation at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:PartyId"
                 priority="1080"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Id) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:PartyId must contain oagis:Id at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Tax" priority="1079" mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:TaxAmount) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Tax must contain oagis:TaxAmount at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:TaxBaseAmount) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Tax must contain oagis:TaxBaseAmount at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea" priority="1078" mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingAdditionalData) &gt;= 1 and count(hrxml:StaffingAdditionalData) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea must contain hrxml:StaffingAdditionalData at least 1 and at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingOrganizationNL) &gt;= 1 and count(hrxml:StaffingOrganizationNL) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea must contain hrxml:StaffingOrganizationNL at least 1 and at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingOrganization) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea may contain hrxml:StaffingOrganization at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData"
                 priority="1077"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:CustomerReportingRequirements) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData must contain hrxml:CustomerReportingRequirements at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"
                 priority="1076"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:AdditionalRequirement) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements must contain hrxml:AdditionalRequirement at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement"
                 priority="1075"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@requirementTitle) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must contain @requirementTitle at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation"
                 priority="1074"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingSupplierId) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may contain hrxml:StaffingSupplierId at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingCustomerId) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may contain hrxml:StaffingCustomerId at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId"
                 priority="1073"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId"
                 priority="1072"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId"
                 priority="1071"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId"
                 priority="1070"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId"
                 priority="1069"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization"
                 priority="1068"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:PaymentInfo) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization must contain hrxml:PaymentInfo at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:Organization) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization may contain hrxml:Organization at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization"
                 priority="1067"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:OrganizationName) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:Organization must contain hrxml:OrganizationName at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo"
                 priority="1066"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:BankAccountInfo) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo must contain hrxml:BankAccountInfo at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo/hrxml:BankAccountInfo"
                 priority="1065"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:BankInfoByJurisdiction) &gt;= 1 and count(hrxml:BankInfoByJurisdiction) &lt;= 2"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo/hrxml:BankAccountInfo must contain hrxml:BankInfoByJurisdiction at least 1 and at most 2 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganizationNL"
                 priority="1064"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:ChamberofCommerceReference) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganizationNL must contain hrxml:ChamberofCommerceReference at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line" priority="1063" mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Charges) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line must contain oagis:Charges at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:LineNumber) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line must contain oagis:LineNumber at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Charges" priority="1062" mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:TotalCharge) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Charges must contain oagis:TotalCharge at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Charges/oagis:TotalCharge"
                 priority="1061"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Total) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Charges/oagis:TotalCharge must contain oagis:Total at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:DocumentReferences" priority="1060"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:InvoiceDocumentReference) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:DocumentReferences may contain oagis:InvoiceDocumentReference at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference"
                 priority="1059"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:DocumentIds) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference must contain oagis:DocumentIds at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds"
                 priority="1058"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:DocumentId) &gt;= 1 and count(oagis:DocumentId) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds must contain oagis:DocumentId at least 1 and at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds/oagis:DocumentId"
                 priority="1057"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Id) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds/oagis:DocumentId must contain oagis:Id at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line" priority="1056" mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:LineNumber) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line must contain oagis:LineNumber at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Charges) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line must contain oagis:Charges at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges" priority="1055"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:TotalCharge) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges must contain oagis:TotalCharge at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges/oagis:TotalCharge"
                 priority="1054"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Total) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges/oagis:TotalCharge must contain oagis:Total at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences"
                 priority="1053"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:InvoiceDocumentReference) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences may contain oagis:InvoiceDocumentReference at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference"
                 priority="1052"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:DocumentIds) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference must contain oagis:DocumentIds at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds"
                 priority="1051"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:DocumentId) &gt;= 1 and count(oagis:DocumentId) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds must contain oagis:DocumentId at least 1 and at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds/oagis:DocumentId"
                 priority="1050"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Id) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:DocumentReferences/oagis:InvoiceDocumentReference/oagis:DocumentIds/oagis:DocumentId must contain oagis:Id at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:Tax" priority="1049" mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:TaxBaseAmount) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:Tax must contain oagis:TaxBaseAmount at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:TaxAmount) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:Tax must contain oagis:TaxAmount at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea" priority="1048"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingAdditionalData) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea may contain hrxml:StaffingAdditionalData at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement"
                 priority="1047"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@requirementTitle) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must contain @requirementTitle at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard"
                 priority="1046"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:AdditionalData) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard must contain hrxml:AdditionalData at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:Id) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard must contain hrxml:Id at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:ReportedTime) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard may contain hrxml:ReportedTime at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData"
                 priority="1045"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingAdditionalData) &gt;= 1 and count(hrxml:StaffingAdditionalData) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData must contain hrxml:StaffingAdditionalData at least 1 and at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId"
                 priority="1044"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId"
                 priority="1043"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId"
                 priority="1042"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId"
                 priority="1041"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId"
                 priority="1040"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id"
                 priority="1039"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName"
                 priority="1038"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:FamilyName) &lt;= 2"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName may contain hrxml:FamilyName at most 2 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id"
                 priority="1037"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource"
                 priority="1036"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:Person) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource must contain hrxml:Person at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id"
                 priority="1035"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName"
                 priority="1034"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:FamilyName) &lt;= 2"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName may contain hrxml:FamilyName at most 2 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance"
                 priority="1033"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:Amount) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance must contain hrxml:Amount at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData"
                 priority="1032"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingAdditionalData) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData may contain hrxml:StaffingAdditionalData at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement"
                 priority="1031"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@requirementTitle) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must contain @requirementTitle at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id"
                 priority="1030"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue"
                 priority="1029"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@name) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue must contain @name at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"
                 priority="1028"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:AdditionalRequirement) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may contain hrxml:AdditionalRequirement at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement"
                 priority="1027"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@requirementTitle) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must contain @requirementTitle at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id"
                 priority="1026"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount"
                 priority="1025"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@multiplier) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount must contain @multiplier at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Tax" priority="1024" mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:TaxAmount) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Tax must contain oagis:TaxAmount at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:TaxBaseAmount) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Tax must contain oagis:TaxBaseAmount at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea" priority="1023" mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingAdditionalData) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea may contain hrxml:StaffingAdditionalData at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement"
                 priority="1022"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@requirementTitle) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must contain @requirementTitle at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard" priority="1021"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:ReportedTime) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard may contain hrxml:ReportedTime at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:AdditionalData) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard must contain hrxml:AdditionalData at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:Id) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard must contain hrxml:Id at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData"
                 priority="1020"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingAdditionalData) &gt;= 1 and count(hrxml:StaffingAdditionalData) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData must contain hrxml:StaffingAdditionalData at least 1 and at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId"
                 priority="1019"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId"
                 priority="1018"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId"
                 priority="1017"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId"
                 priority="1016"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId"
                 priority="1015"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id"
                 priority="1014"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName"
                 priority="1013"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:FamilyName) &lt;= 2"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName may contain hrxml:FamilyName at most 2 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id"
                 priority="1012"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource"
                 priority="1011"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:Person) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource must contain hrxml:Person at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id"
                 priority="1010"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName"
                 priority="1009"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:FamilyName) &lt;= 2"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName may contain hrxml:FamilyName at most 2 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance"
                 priority="1008"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:Amount) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance must contain hrxml:Amount at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData"
                 priority="1007"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingAdditionalData) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData may contain hrxml:StaffingAdditionalData at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement"
                 priority="1006"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@requirementTitle) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must contain @requirementTitle at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id"
                 priority="1005"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue"
                 priority="1004"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@name) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue must contain @name at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"
                 priority="1003"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:AdditionalRequirement) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may contain hrxml:AdditionalRequirement at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement"
                 priority="1002"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@requirementTitle) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must contain @requirementTitle at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id"
                 priority="1001"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id must contain @idOwner at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id may contain hrxml:IdValue at most 1 time(s)<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount"
                 priority="1000"
                 mode="M4">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@multiplier) &gt;= 1"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount must contain @multiplier at least 1 time(s)<xsl:value-of select="string('&#xA;')"/>
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
<xsl:template match="oagis:Invoice" priority="1078" mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Line/oagis:LineNumber) = count(distinct-values(oagis:Line/oagis:LineNumber))"/>
         <xsl:otherwise>LineNumbers must be unique<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header" priority="1077" mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:ReasonCode) or (oagis:ReasonCode='services') or (oagis:ReasonCode='hours') or (oagis:ReasonCode='combination')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:ReasonCode must have one of the following values: [services, hours, combination]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Type) or (oagis:Type='Debit') or (oagis:Type='Credit') or (oagis:Type='Both')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Type must have one of the following values: [Debit, Credit, Both]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Attachments/oagis:Attachment"
                 priority="1076"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:FileType) or (oagis:FileType='application/pdf')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Attachments/oagis:Attachment/oagis:FileType must have one of the following values: [application/pdf]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Attachments/oagis:Attachment/oagis:EmbeddedData"
                 priority="1075"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@encoding) or (@encoding='base64')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Attachments/oagis:Attachment/oagis:EmbeddedData/@encoding must have one of the following values: [base64]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Charges/oagis:Charge" priority="1074"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Description) or (oagis:Description='TotalOnChargedVAT')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Charges/oagis:Charge/oagis:Description must have one of the following values: [TotalOnChargedVAT]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses/oagis:PrimaryAddress"
                 priority="1073"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Description) or (oagis:Description='PhysicalAddress') or (oagis:Description='PostalAddress')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Addresses/oagis:PrimaryAddress/oagis:Description must have one of the following values: [PhysicalAddress, PostalAddress]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress"
                 priority="1072"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Description) or (oagis:Description='PhysicalAddress') or (oagis:Description='PostalAddress')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:Description must have one of the following values: [PhysicalAddress, PostalAddress]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress"
                 priority="1071"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Description) or (oagis:Description='PhysicalAddress') or (oagis:Description='PostalAddress')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress/oagis:Description must have one of the following values: [PhysicalAddress, PostalAddress]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress"
                 priority="1070"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Description) or (oagis:Description='PhysicalAddress') or (oagis:Description='PostalAddress')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:Description must have one of the following values: [PhysicalAddress, PostalAddress]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress"
                 priority="1069"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Description) or (oagis:Description='PhysicalAddress') or (oagis:Description='PostalAddress')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress/oagis:Description must have one of the following values: [PhysicalAddress, PostalAddress]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress"
                 priority="1068"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Description) or (oagis:Description='PhysicalAddress') or (oagis:Description='PostalAddress')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:Description must have one of the following values: [PhysicalAddress, PostalAddress]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress"
                 priority="1067"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Description) or (oagis:Description='PhysicalAddress') or (oagis:Description='PostalAddress')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress/oagis:Description must have one of the following values: [PhysicalAddress, PostalAddress]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress"
                 priority="1066"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(oagis:Description) or (oagis:Description='PhysicalAddress') or (oagis:Description='PostalAddress')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Addresses/oagis:PrimaryAddress/oagis:Description must have one of the following values: [PhysicalAddress, PostalAddress]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:PaymentTerms/oagis:DayOfMonth"
                 priority="1065"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="number(text()) &gt; 0"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:PaymentTerms/oagis:DayOfMonth must be at least 1.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:PaymentTerms/oagis:DiscountPercent"
                 priority="1064"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@uom) or (@uom='percentage')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:PaymentTerms/oagis:DiscountPercent/@uom must have one of the following values: [percentage]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:PaymentTerms/oagis:NumberOfDays"
                 priority="1063"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="number(text()) &gt; 0"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:PaymentTerms/oagis:NumberOfDays must be at least 1.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:Tax/oagis:PercentQuantity"
                 priority="1062"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@uom) or (@uom='BTW')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:Tax/oagis:PercentQuantity/@uom must have one of the following values: [BTW]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData"
                 priority="1061"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:CustomerReportingRequirements) + count(hrxml:ReferenceInformation) &gt; 0"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData must contain CustomerReportingRequirements or ReferenceInformation<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"
                 priority="1060"
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
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId"
                 priority="1059"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCompany')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId/@idOwner must have one of the following values: [StaffingCompany]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId"
                 priority="1058"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='KvK') or (@idOwner='OIN') or (@idOwner='BTW') or (@idOwner='Fi')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, KvK, OIN, BTW, Fi]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId"
                 priority="1057"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='KvK') or (@idOwner='OIN') or (@idOwner='BTW') or (@idOwner='Fi')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, KvK, OIN, BTW, Fi]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId"
                 priority="1056"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='KvK') or (@idOwner='OIN') or (@idOwner='BTW') or (@idOwner='Fi')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, KvK, OIN, BTW, Fi]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId"
                 priority="1055"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='KvK') or (@idOwner='OIN') or (@idOwner='BTW') or (@idOwner='Fi')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, KvK, OIN, BTW, Fi]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization"
                 priority="1054"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@typeOfOrganization) or (@typeOfOrganization='Supplier')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/@typeOfOrganization must have one of the following values: [Supplier]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo/hrxml:BankAccountInfo/hrxml:BankInfoByJurisdiction"
                 priority="1053"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="matches(hrxml:BankAccountNumber, '^[A-Z0-9]+$')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo/hrxml:BankAccountInfo/hrxml:BankInfoByJurisdiction/hrxml:BankAccountNumber must match regular expression: ^[A-Z0-9]+$<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@bankJurisdiction) or (@bankJurisdiction='NL')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo/hrxml:BankAccountInfo/hrxml:BankInfoByJurisdiction/@bankJurisdiction must have one of the following values: [NL]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(empty(hrxml:BankAccountType) or (hrxml:BankAccountType='IBAN')) or (empty(hrxml:BankAccountType) or (hrxml:BankAccountType=''))"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo/hrxml:BankAccountInfo/hrxml:BankInfoByJurisdiction/hrxml:BankAccountType must have one of the following values: [IBAN] OR oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo/hrxml:BankAccountInfo/hrxml:BankInfoByJurisdiction/hrxml:BankAccountType must be Empty<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:BankAccountKey) or (hrxml:BankAccountKey='')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo/hrxml:BankAccountInfo/hrxml:BankInfoByJurisdiction/hrxml:BankAccountKey must be Empty<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:BankWindow) or (hrxml:BankWindow='')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo/hrxml:BankAccountInfo/hrxml:BankInfoByJurisdiction/hrxml:BankWindow must be Empty<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo/hrxml:FinancialGuarantee"
                 priority="1052"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Name) or (hrxml:Name='G-account') or (hrxml:Name='Depot-account') or (hrxml:Name='Pawning-account')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo/hrxml:FinancialGuarantee/hrxml:Name must have one of the following values: [G-account, Depot-account, Pawning-account]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line" priority="1051" mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Line/oagis:LineNumber) = count(distinct-values(oagis:Line/oagis:LineNumber))"/>
         <xsl:otherwise>LineNumbers must be unique<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Description) + count(oagis:ReasonCode) + count(oagis:UserArea/hrxml:TimeCard) &gt; 0"/>
         <xsl:otherwise>Line must have at least one of Description, ReasonCode or TimeCard<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="((count(oagis:Price) = 0) and (count(oagis:Line/oagis:Price) = count(oagis:Line))) or ((count(oagis:Price) &gt; 0) and (count(oagis:Line/oagis:Price) = 0))"/>
         <xsl:otherwise>Price MOET OF op Line niveau OF voor alle Line/Lines worden opgegeven.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="((count(oagis:ItemQuantity) = 0) and (count(oagis:Line/oagis:ItemQuantity) = count(oagis:Line))) or ((count(oagis:ItemQuantity) &gt; 0) and (count(oagis:Line/oagis:ItemQuantity) = 0))"/>
         <xsl:otherwise>ItemQuantity MOET OF op Line niveau OF voor alle Line/Lines worden opgegeven.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="((count(oagis:ReasonCode) = 0) and (count(oagis:Line/oagis:ReasonCode) = count(oagis:Line))) or ((count(oagis:ReasonCode) &gt; 0) and (count(oagis:Line/oagis:ReasonCode) = 0))"/>
         <xsl:otherwise>ReasonCode MOET OF op Line niveau OF voor alle Line/Lines worden opgegeven.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line" priority="1050" mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(oagis:Description) + count(oagis:ReasonCode) + count(oagis:UserArea/hrxml:TimeCard) &gt; 0"/>
         <xsl:otherwise>Line/Line must have at least one of Description, ReasonCode or TimeCard<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:Price/oagis:PerQuantity"
                 priority="1049"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="number(text()) &gt; 0"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:Price/oagis:PerQuantity must be at least 1.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:Tax/oagis:PercentQuantity"
                 priority="1048"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(index-of(/oagis:Invoice/oagis:Header/oagis:Tax/oagis:PercentQuantity, text()))"/>
         <xsl:otherwise>Invoice/Line/Line/Tax/PercentQuantity must be available on Header level: <xsl:text/>
            <xsl:value-of select="text()"/>
            <xsl:text/>
            <xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@uom) or (@uom='BTW')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:Tax/oagis:PercentQuantity/@uom must have one of the following values: [BTW]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard"
                 priority="1047"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(../../oagis:ItemQuantity) = 1"/>
         <xsl:otherwise>ItemQuantity must be present when a TimeCard is present on Line/Line.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(count(hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId) + count(hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:PurchaseOrderNumber)) &gt;= 1"/>
         <xsl:otherwise>There must be at least one AssignmentId or PurchaseOrderNumber on header level.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData"
                 priority="1046"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:CustomerReportingRequirements) + count(hrxml:ReferenceInformation) &gt; 0"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData must contain CustomerReportingRequirements or ReferenceInformation<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation"
                 priority="1045"
                 mode="M5">

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
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId"
                 priority="1044"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCompany')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId/@idOwner must have one of the following values: [StaffingCompany]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId"
                 priority="1043"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, OIN, KvK, BTW, Fi, Vest]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId"
                 priority="1042"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, OIN, KvK, BTW, Fi, Vest]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId"
                 priority="1041"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, OIN, KvK, BTW, Fi, Vest]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId"
                 priority="1040"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='KvK') or (@idOwner='OIN') or (@idOwner='BTW') or (@idOwner='Fi')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, KvK, OIN, BTW, Fi]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName/hrxml:Affix"
                 priority="1039"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@type) or (@type='aristocraticTitle') or (@type='formOfAddress') or (@type='generation') or (@type='qualification')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName/hrxml:Affix/@type must have one of the following values: [aristocraticTitle, formOfAddress, generation, qualification]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName/hrxml:FamilyName"
                 priority="1038"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@primary) or (@primary='true') or (@primary='false')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName/hrxml:FamilyName/@primary must have one of the following values: [true, false]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id"
                 priority="1037"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id"
                 priority="1036"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName/hrxml:Affix"
                 priority="1035"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@type) or (@type='aristocraticTitle') or (@type='formOfAddress') or (@type='generation') or (@type='qualification')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName/hrxml:Affix/@type must have one of the following values: [aristocraticTitle, formOfAddress, generation, qualification]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName/hrxml:FamilyName"
                 priority="1034"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@primary) or (@primary='true') or (@primary='false')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName/hrxml:FamilyName/@primary must have one of the following values: [true, false]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime"
                 priority="1033"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:TimeInterval) + count(hrxml:Allowance) &gt; 0"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime must contain at least one TimeInterval or Allowance<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(empty(@status) or (@status='rejected') or (@status='corrected')) or (empty(@status) or (@status=''))"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/@status must have one of the following values: [rejected, corrected] OR oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/@status must be Empty<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance"
                 priority="1032"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@actionCode) or (@actionCode='Add') or (@actionCode='Change') or (@actionCode='Void') or (@actionCode='Unchanged')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/@actionCode must have one of the following values: [Add, Change, Void, Unchanged]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id"
                 priority="1031"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue"
                 priority="1030"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name) or (@name='allowance') or (@name='expense')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue/@name must have one of the following values: [allowance, expense]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval"
                 priority="1029"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:EndDateTime) + count(hrxml:Duration) &gt; 0"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval must have EndDateTime or Duration<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@actionCode) or (@actionCode='Add') or (@actionCode='Change') or (@actionCode='Void') or (@actionCode='Unchanged')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/@actionCode must have one of the following values: [Add, Change, Void, Unchanged]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"
                 priority="1028"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AdditionalRequirement) or (hrxml:AdditionalRequirement='true') or (hrxml:AdditionalRequirement='false')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must have one of the following values: [true, false]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement"
                 priority="1027"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@requirementTitle) or (@requirementTitle='InclusiveRate')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement/@requirementTitle must have one of the following values: [InclusiveRate]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id"
                 priority="1026"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount"
                 priority="1025"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@type) or (@type='hourly') or (@type='hourlyconsolidated') or (@type='hourlysplit') or (@type='4weekly') or (@type='monthly')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount/@type must have one of the following values: [hourly, hourlyconsolidated, hourlysplit, 4weekly, monthly]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Price/oagis:PerQuantity" priority="1024"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="number(text()) &gt; 0"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Price/oagis:PerQuantity must be at least 1.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:Tax/oagis:PercentQuantity"
                 priority="1023"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(index-of(/oagis:Invoice/oagis:Header/oagis:Tax/oagis:PercentQuantity, text()))"/>
         <xsl:otherwise>Invoice/Line/Tax/PercentQuantity must be available on Header level: <xsl:text/>
            <xsl:value-of select="text()"/>
            <xsl:text/>
            <xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@uom) or (@uom='BTW')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:Tax/oagis:PercentQuantity/@uom must have one of the following values: [BTW]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard" priority="1022"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(../../oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id) = 0"/>
         <xsl:otherwise>Invoice Line must not contain TimeCard on Line/Line level when it has a TimeCard itself<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(count(hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId) + count(hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:PurchaseOrderNumber)) &gt;= 1"/>
         <xsl:otherwise>There must be at least one AssignmentId or PurchaseOrderNumber on header level.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData"
                 priority="1021"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:CustomerReportingRequirements) + count(hrxml:ReferenceInformation) &gt; 0"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData must contain CustomerReportingRequirements or ReferenceInformation<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation"
                 priority="1020"
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
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId"
                 priority="1019"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCompany')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId/@idOwner must have one of the following values: [StaffingCompany]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId"
                 priority="1018"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, OIN, KvK, BTW, Fi, Vest]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId"
                 priority="1017"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, OIN, KvK, BTW, Fi, Vest]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId"
                 priority="1016"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId must be filled<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, OIN, KvK, BTW, Fi, Vest]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId"
                 priority="1015"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='KvK') or (@idOwner='OIN') or (@idOwner='BTW') or (@idOwner='Fi')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, KvK, OIN, BTW, Fi]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName/hrxml:Affix"
                 priority="1014"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@type) or (@type='aristocraticTitle') or (@type='formOfAddress') or (@type='generation') or (@type='qualification')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName/hrxml:Affix/@type must have one of the following values: [aristocraticTitle, formOfAddress, generation, qualification]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName/hrxml:FamilyName"
                 priority="1013"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@primary) or (@primary='true') or (@primary='false')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName/hrxml:FamilyName/@primary must have one of the following values: [true, false]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id"
                 priority="1012"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id"
                 priority="1011"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName/hrxml:Affix"
                 priority="1010"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@type) or (@type='aristocraticTitle') or (@type='formOfAddress') or (@type='generation') or (@type='qualification')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName/hrxml:Affix/@type must have one of the following values: [aristocraticTitle, formOfAddress, generation, qualification]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName/hrxml:FamilyName"
                 priority="1009"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@primary) or (@primary='true') or (@primary='false')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName/hrxml:FamilyName/@primary must have one of the following values: [true, false]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime"
                 priority="1008"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:TimeInterval) + count(hrxml:Allowance) &gt; 0"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime must contain at least one TimeInterval or Allowance<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(empty(@status) or (@status='rejected') or (@status='corrected')) or (empty(@status) or (@status=''))"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/@status must have one of the following values: [rejected, corrected] OR oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/@status must be Empty<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance"
                 priority="1007"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@actionCode) or (@actionCode='Add') or (@actionCode='Change') or (@actionCode='Void') or (@actionCode='Unchanged')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/@actionCode must have one of the following values: [Add, Change, Void, Unchanged]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id"
                 priority="1006"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue"
                 priority="1005"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name) or (@name='allowance') or (@name='expense')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue/@name must have one of the following values: [allowance, expense]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval"
                 priority="1004"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@actionCode) or (@actionCode='Add') or (@actionCode='Change') or (@actionCode='Void') or (@actionCode='Unchanged')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/@actionCode must have one of the following values: [Add, Change, Void, Unchanged]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:EndDateTime) + count(hrxml:Duration) &gt; 0"/>
         <xsl:otherwise>hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval must have EndDateTime or Duration<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements"
                 priority="1003"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AdditionalRequirement) or (hrxml:AdditionalRequirement='true') or (hrxml:AdditionalRequirement='false')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must have one of the following values: [true, false]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement"
                 priority="1002"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@requirementTitle) or (@requirementTitle='InclusiveRate')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement/@requirementTitle must have one of the following values: [InclusiveRate]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id"
                 priority="1001"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount"
                 priority="1000"
                 mode="M5">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@type) or (@type='hourly') or (@type='hourlyconsolidated') or (@type='hourlysplit') or (@type='4weekly') or (@type='monthly')"/>
         <xsl:otherwise>oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount/@type must have one of the following values: [hourly, hourlyconsolidated, hourlysplit, 4weekly, monthly]<xsl:value-of select="string('&#xA;')"/>
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
<xsl:template match="oagis:Invoice/oagis:Header/oagis:TotalAmount[2]" priority="1000"
                 mode="M6">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="@currency != ../oagis:TotalAmount[1]/@currency"/>
         <xsl:otherwise>oagis:Invoice/oagis:Header/oagis:TotalAmount currencies must be different for each occurrence<xsl:value-of select="string('&#xA;')"/>
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
<xsl:template match="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement[@requirementTitle = 'VersionId']"
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

   <!--PATTERN type-restrictions-3-->


	<!--RULE -->
<xsl:template match="oagis:Invoice/oagis:Header[oagis:ReasonCode='services']" priority="1000"
                 mode="M8">

		<!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(../oagis:Line/oagis:ReasonCode) = count(../oagis:Line)"/>
         <xsl:otherwise>Each Line must have a ReasonCode if the ReasonCode is 'services' in the Header.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(../oagis:Line/oagis:Line/oagis:ReasonCode) = count(../oagis:Line/oagis:Line)"/>
         <xsl:otherwise>Each Line/Line must have a ReasonCode if the ReasonCode is 'services' in the Header.<xsl:value-of select="string('&#xA;')"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M8"/>
   <xsl:template match="@*|node()" priority="-2" mode="M8">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>
</xsl:stylesheet>