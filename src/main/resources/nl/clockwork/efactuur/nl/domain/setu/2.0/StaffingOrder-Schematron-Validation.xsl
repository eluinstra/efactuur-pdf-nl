<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:schold="http://www.ascc.net/xml/schematron"
                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
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
                              title="Validations for StaffingOrder Mapping; strict=false"
                              schemaVersion="">
         <xsl:comment>
            <xsl:value-of select="$archiveDirParameter"/>   
		 <xsl:value-of select="$archiveNameParameter"/>  
		 <xsl:value-of select="$fileNameParameter"/>  
		 <xsl:value-of select="$fileDirParameter"/>
         </xsl:comment>
         <svrl:ns-prefix-in-attribute-values uri="http://ns.hr-xml.org/2007-04-15" prefix="hrxml"/>
         <svrl:ns-prefix-in-attribute-values uri="http://ns.setu.nl/2012-01" prefix="setu"/>
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
            <xsl:attribute name="id">type-restrictions-1</xsl:attribute>
            <xsl:attribute name="name">type-restrictions-1</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M6"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">type-restrictions-2</xsl:attribute>
            <xsl:attribute name="name">type-restrictions-2</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M7"/>
      </svrl:schematron-output>
   </xsl:template>

   <!--SCHEMATRON PATTERNS-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Validations for StaffingOrder Mapping; strict=false</svrl:text>

   <!--PATTERN prohibitions-->


	<!--RULE -->
<xsl:template match="hrxml:StaffingOrder" priority="1056" mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="hrxml:StaffingOrder"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@lang)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder may not contain @lang</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PositionQuantityOpen)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:PositionQuantityOpen)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder may not contain hrxml:PositionQuantityOpen</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:BillToAttention)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:BillToAttention)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder may not contain hrxml:BillToAttention</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:CustomerReportingRequirements" priority="1055"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:CustomerReportingRequirements"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationCode)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:LocationCode)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:LocationCode</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:ManagerName</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:SubEntity</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PurchaseOrderLineItem)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:PurchaseOrderLineItem)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:PurchaseOrderLineItem</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:SupervisorName</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalReqNumber</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalOrderNumber</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:ContactName</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PurchaseOrderNumber)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:PurchaseOrderNumber)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:PurchaseOrderNumber</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobDescription</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:LocationName</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobCode</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:Entity</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:AccountCode</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:Shift</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo"
                 priority="1054"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ContactId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:ContactId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo may not contain hrxml:ContactId</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod"
                 priority="1053"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Use)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:Use)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod may not contain hrxml:Use</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:TTYTDD)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:TTYTDD)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod may not contain hrxml:TTYTDD</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Location)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:Location)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod may not contain hrxml:Location</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PostalAddress)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:PostalAddress)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod may not contain hrxml:PostalAddress</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:WhenAvailable)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:WhenAvailable)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod may not contain hrxml:WhenAvailable</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Pager)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:Pager)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod may not contain hrxml:Pager</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Fax"
                 priority="1052"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Fax"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubscriberNumber)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:SubscriberNumber)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:SubscriberNumber</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:InternationalCountryCode)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:InternationalCountryCode)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:InternationalCountryCode</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Extension)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:Extension)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:Extension</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:NationalNumber)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:NationalNumber)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:NationalNumber</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AreaCityCode)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:AreaCityCode)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:AreaCityCode</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Mobile"
                 priority="1051"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Mobile"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AreaCityCode)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:AreaCityCode)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:AreaCityCode</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@smsEnabled)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@smsEnabled)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain @smsEnabled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Extension)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:Extension)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:Extension</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:InternationalCountryCode)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:InternationalCountryCode)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:InternationalCountryCode</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:NationalNumber)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:NationalNumber)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:NationalNumber</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubscriberNumber)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:SubscriberNumber)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:SubscriberNumber</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Telephone"
                 priority="1050"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Telephone"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SubscriberNumber)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:SubscriberNumber)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:SubscriberNumber</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:NationalNumber)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:NationalNumber)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:NationalNumber</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AreaCityCode)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:AreaCityCode)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:AreaCityCode</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Extension)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:Extension)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:Extension</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:InternationalCountryCode)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:InternationalCountryCode)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:InternationalCountryCode</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:PersonName"
                 priority="1049"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:PersonName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Affix)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:Affix)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:PersonName may not contain hrxml:Affix</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PreferredGivenName)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:PreferredGivenName)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:PersonName may not contain hrxml:PreferredGivenName</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:MiddleName)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:MiddleName)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:PersonName may not contain hrxml:MiddleName</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:FamilyName)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:FamilyName)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:PersonName may not contain hrxml:FamilyName</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:PersonName may not contain hrxml:AlternateScript</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:GivenName)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:GivenName)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:PersonName may not contain hrxml:GivenName</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:PersonName may not contain @script</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LegalName)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:LegalName)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:PersonName may not contain hrxml:LegalName</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:OrderId/hrxml:IdValue" priority="1048"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:OrderId/hrxml:IdValue"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@name)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:OrderId/hrxml:IdValue may not contain @name</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation" priority="1047"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:ReferenceInformation"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:BillToEntityId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:BillToEntityId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation may not contain hrxml:BillToEntityId</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation may not contain hrxml:HumanResourceId</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation may not contain hrxml:UserArea</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AssignmentId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:AssignmentId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation may not contain hrxml:AssignmentId</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation may not contain hrxml:StaffingOrganizationId</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:TimeCardId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:TimeCardId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation may not contain hrxml:TimeCardId</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation may not contain hrxml:InvoiceId</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation may not contain hrxml:PositionId</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation may not contain hrxml:IntermediaryId</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:MasterOrderId"
                 priority="1046"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:MasterOrderId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@validFrom)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:MasterOrderId may not contain @validFrom</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:MasterOrderId may not contain @validTo</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:MasterOrderId/hrxml:IdValue"
                 priority="1045"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:MasterOrderId/hrxml:IdValue"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@name)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:MasterOrderId/hrxml:IdValue may not contain @name</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId"
                 priority="1044"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@validFrom)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may not contain @validFrom</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may not contain @validTo</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/hrxml:IdValue"
                 priority="1043"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/hrxml:IdValue"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@name)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/hrxml:IdValue may not contain @name</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId"
                 priority="1042"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@validTo)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may not contain @validTo</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may not contain @validFrom</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/hrxml:IdValue"
                 priority="1041"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/hrxml:IdValue"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@name)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/hrxml:IdValue may not contain @name</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId"
                 priority="1040"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@validTo)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may not contain @validTo</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may not contain @validFrom</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/hrxml:IdValue"
                 priority="1039"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/hrxml:IdValue"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@name)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/hrxml:IdValue may not contain @name</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId"
                 priority="1038"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@validFrom)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may not contain @validFrom</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may not contain @validTo</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/hrxml:IdValue"
                 priority="1037"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/hrxml:IdValue"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@name)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/hrxml:IdValue may not contain @name</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition" priority="1036" mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@lang)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition may not contain @lang</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:InvoiceInfo)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:InvoiceInfo)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition may not contain hrxml:InvoiceInfo</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:WorkSiteEnvironment)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:WorkSiteEnvironment)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition may not contain hrxml:WorkSiteEnvironment</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PositionRequirements)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:PositionRequirements)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition may not contain hrxml:PositionRequirements</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ReportToPerson)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:ReportToPerson)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition may not contain hrxml:ReportToPerson</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DepartmentName)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:DepartmentName)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition may not contain hrxml:DepartmentName</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PositionContact)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:PositionContact)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition may not contain hrxml:PositionContact</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements"
                 priority="1035"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ContactName)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:ContactName)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:ContactName</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalOrderNumber</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:ManagerName</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:LocationCode</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DepartmentName)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:DepartmentName)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:DepartmentName</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CostCenterName)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:CostCenterName)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:CostCenterName</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:LocationName</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobDescription</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:SubEntity</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PurchaseOrderLineItem)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:PurchaseOrderLineItem)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:PurchaseOrderLineItem</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalReqNumber</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AdditionalRequirement)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:AdditionalRequirement)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:AdditionalRequirement</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:AccountCode</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ProjectCode)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:ProjectCode)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:ProjectCode</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerReferenceNumber)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:CustomerReferenceNumber)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerReferenceNumber</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CostCenterCode)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:CostCenterCode)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:CostCenterCode</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:Shift</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:Entity</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DepartmentCode)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:DepartmentCode)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:DepartmentCode</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:SupervisorName</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PurchaseOrderNumber)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:PurchaseOrderNumber)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:PurchaseOrderNumber</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobCode</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionDateRange"
                 priority="1034"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionDateRange"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PositionDuration)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:PositionDuration)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionDateRange may not contain hrxml:PositionDuration</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:StartAsSoonAsPossible)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:StartAsSoonAsPossible)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionDateRange may not contain hrxml:StartAsSoonAsPossible</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExtensionParameters)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:ExtensionParameters)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionDateRange may not contain hrxml:ExtensionParameters</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:MaxStartDate)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:MaxStartDate)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionDateRange may not contain hrxml:MaxStartDate</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:MaxNeedEndDate)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:MaxNeedEndDate)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionDateRange may not contain hrxml:MaxNeedEndDate</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ActualEndDate)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:ActualEndDate)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionDateRange may not contain hrxml:ActualEndDate</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader"
                 priority="1033"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PositionSpecificCondition)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:PositionSpecificCondition)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:PositionSpecificCondition</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:OvertimeInfo)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:OvertimeInfo)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:OvertimeInfo</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:BusyPeriodInfo)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:BusyPeriodInfo)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:BusyPeriodInfo</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:HolidayWork)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:HolidayWork)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:HolidayWork</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain @validTo</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ReportToPositionId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:ReportToPositionId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:ReportToPositionId</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain @validFrom</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:FormattedPositionDescription)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:FormattedPositionDescription)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:FormattedPositionDescription</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PositionMustEndByInfo)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:PositionMustEndByInfo)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:PositionMustEndByInfo</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Quantity)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:Quantity)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:Quantity</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:TransitionInfo)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:TransitionInfo)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:TransitionInfo</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:TypeOfHours)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:TypeOfHours)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:TypeOfHours</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PositionStatus)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:PositionStatus)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:PositionStatus</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocalStaffingPositionInfo)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:LocalStaffingPositionInfo)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:LocalStaffingPositionInfo</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SpecialInstructions)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:SpecialInstructions)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:SpecialInstructions</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:JobCategory)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:JobCategory)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:JobCategory</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:JobId"
                 priority="1032"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:JobId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Domain)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:Domain)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:JobId may not contain hrxml:Domain</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:PositionId"
                 priority="1031"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:PositionId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Domain)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:Domain)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:PositionId may not contain hrxml:Domain</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson"
                 priority="1030"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Supplier)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:Supplier)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson may not contain hrxml:Supplier</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@currentlyAssigned)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@currentlyAssigned)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson may not contain @currentlyAssigned</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@mandatory)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@mandatory)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson may not contain @mandatory</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonId"
                 priority="1029"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@validTo)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonId may not contain @validTo</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonId may not contain @validFrom</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonId/hrxml:IdValue"
                 priority="1028"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonId/hrxml:IdValue"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@name)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonId/hrxml:IdValue may not contain @name</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonName"
                 priority="1027"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AlternateScript)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:AlternateScript)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonName may not contain hrxml:AlternateScript</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonName may not contain @script</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates" priority="1026"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@lang)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates may not contain @lang</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:BillingMultiplier)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:BillingMultiplier)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates may not contain hrxml:BillingMultiplier</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:TimeWorkedRounding)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:TimeWorkedRounding)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates may not contain hrxml:TimeWorkedRounding</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:StaffingShiftId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:StaffingShiftId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates may not contain hrxml:StaffingShiftId</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:CustomerRateClassification"
                 priority="1025"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:CustomerRateClassification"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@validFrom)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:CustomerRateClassification may not contain @validFrom</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:CustomerRateClassification may not contain @validTo</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@idOwner)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:CustomerRateClassification may not contain @idOwner</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:ExternalRateSetId"
                 priority="1024"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:ExternalRateSetId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@validTo)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:ExternalRateSetId may not contain @validTo</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:ExternalRateSetId may not contain @validFrom</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@idOwner)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:ExternalRateSetId may not contain @idOwner</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:ExternalRateSetId/hrxml:IdValue"
                 priority="1023"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:ExternalRateSetId/hrxml:IdValue"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@name)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:ExternalRateSetId/hrxml:IdValue may not contain @name</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:Multiplier"
                 priority="1022"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:Multiplier"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@percentIndicator)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@percentIndicator)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:Multiplier may not contain @percentIndicator</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:RatesId"
                 priority="1021"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:RatesId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@validTo)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:RatesId may not contain @validTo</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:RatesId may not contain @validFrom</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@idOwner)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:RatesId may not contain @idOwner</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:RatesId/hrxml:IdValue"
                 priority="1020"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:RatesId/hrxml:IdValue"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@name)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:RatesId/hrxml:IdValue may not contain @name</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift"
                 priority="1019"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Name)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:Name)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift may not contain hrxml:Name</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Comment)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:Comment)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift may not contain hrxml:Comment</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExternalStaffingShiftSetId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:ExternalStaffingShiftSetId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift may not contain hrxml:ExternalStaffingShiftSetId</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:TypeHours)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:TypeHours)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift may not contain hrxml:TypeHours</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@lang)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@lang)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift may not contain @lang</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:StartTime)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:StartTime)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift may not contain hrxml:StartTime</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:EndTime)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:EndTime)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift may not contain hrxml:EndTime</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift/hrxml:Id"
                 priority="1018"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift/hrxml:Id"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@idOwner)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift/hrxml:Id may not contain @idOwner</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift/hrxml:Id may not contain @validFrom</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift/hrxml:Id may not contain @validTo</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift/hrxml:Id/hrxml:IdValue"
                 priority="1017"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift/hrxml:Id/hrxml:IdValue"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@name)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift/hrxml:Id/hrxml:IdValue may not contain @name</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite"
                 priority="1016"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:TravelDirections)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:TravelDirections)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite may not contain hrxml:TravelDirections</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:WorkSiteId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:WorkSiteId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite may not contain hrxml:WorkSiteId</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:StructuredTravelDirections)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:StructuredTravelDirections)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite may not contain hrxml:StructuredTravelDirections</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:WorkSiteDetail)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:WorkSiteDetail)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite may not contain hrxml:WorkSiteDetail</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ParkingInstructions)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:ParkingInstructions)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite may not contain hrxml:ParkingInstructions</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite/hrxml:PostalAddress"
                 priority="1015"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite/hrxml:PostalAddress"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Region)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:Region)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite/hrxml:PostalAddress may not contain hrxml:Region</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@type)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@type)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite/hrxml:PostalAddress may not contain @type</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Recipient)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:Recipient)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite/hrxml:PostalAddress may not contain hrxml:Recipient</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite/hrxml:PostalAddress/hrxml:DeliveryAddress"
                 priority="1014"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite/hrxml:PostalAddress/hrxml:DeliveryAddress"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:AddressLine)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:AddressLine)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite/hrxml:PostalAddress/hrxml:DeliveryAddress may not contain hrxml:AddressLine</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PostOfficeBox)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:PostOfficeBox)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite/hrxml:PostalAddress/hrxml:DeliveryAddress may not contain hrxml:PostOfficeBox</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:OfferId"
                 priority="1013"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:OfferId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@validFrom)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:OfferId may not contain @validFrom</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:OfferId may not contain @validTo</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:OfferId/hrxml:IdValue"
                 priority="1012"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:OfferId/hrxml:IdValue"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@name)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:OfferId/hrxml:IdValue may not contain @name</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:PreviousOrderId"
                 priority="1011"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:PreviousOrderId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@validTo)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:PreviousOrderId may not contain @validTo</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:PreviousOrderId may not contain @validFrom</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:PreviousOrderId/hrxml:IdValue"
                 priority="1010"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:PreviousOrderId/hrxml:IdValue"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@name)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:PreviousOrderId/hrxml:IdValue may not contain @name</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:RFQOrderId"
                 priority="1009"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:RFQOrderId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validTo)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@validTo)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:RFQOrderId may not contain @validTo</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:RFQOrderId may not contain @validFrom</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:RFQOrderId/hrxml:IdValue"
                 priority="1008"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:RFQOrderId/hrxml:IdValue"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@name)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:RFQOrderId/hrxml:IdValue may not contain @name</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume"
                 priority="1007"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Objective)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:Objective)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:Objective</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SecurityCredentials)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:SecurityCredentials)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:SecurityCredentials</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PatentHistory)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:PatentHistory)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:PatentHistory</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SupportingMaterials)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:SupportingMaterials)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:SupportingMaterials</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:RevisionDate)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:RevisionDate)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:RevisionDate</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ResumeAdditionalItems)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:ResumeAdditionalItems)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:ResumeAdditionalItems</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ProfessionalAssociations)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:ProfessionalAssociations)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:ProfessionalAssociations</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:MilitaryHistory)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:MilitaryHistory)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:MilitaryHistory</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:References)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:References)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:References</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SpeakingEventsHistory)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:SpeakingEventsHistory)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:SpeakingEventsHistory</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Associations)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:Associations)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:Associations</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Achievements)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:Achievements)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:Achievements</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:EmploymentHistory)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:EmploymentHistory)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:EmploymentHistory</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ExecutiveSummary)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:ExecutiveSummary)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:ExecutiveSummary</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Comments)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:Comments)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:Comments</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Languages)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:Languages)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:Languages</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ContactInfo)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:ContactInfo)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:ContactInfo</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PublicationHistory)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:PublicationHistory)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:PublicationHistory</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution"
                 priority="1006"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Minor)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:Minor)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:Minor</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:SchoolName)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:SchoolName)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:SchoolName</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Major)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:Major)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:Major</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PostalAddress)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:PostalAddress)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:PostalAddress</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Comments)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:Comments)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:Comments</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:School)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:School)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:School</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:UserArea</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:OrganizationUnit)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:OrganizationUnit)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:OrganizationUnit</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Measure)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:Measure)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:Measure</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:ISCEDInstitutionClassification)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:ISCEDInstitutionClassification)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:ISCEDInstitutionClassification</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:LocationSummary)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:LocationSummary)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:LocationSummary</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DatesOfAttendance)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:DatesOfAttendance)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:DatesOfAttendance</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree"
                 priority="1005"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DegreeDate)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:DegreeDate)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:DegreeDate</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DegreeMinor)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:DegreeMinor)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:DegreeMinor</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:UserArea</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DegreeClassification)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:DegreeClassification)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:DegreeClassification</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@examPassed)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@examPassed)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain @examPassed</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:OtherHonors)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:OtherHonors)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:OtherHonors</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@graduatingDegree)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@graduatingDegree)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain @graduatingDegree</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DatesOfAttendance)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:DatesOfAttendance)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:DatesOfAttendance</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Comments)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:Comments)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:Comments</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DegreeMajor)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:DegreeMajor)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:DegreeMajor</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DegreeName)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:DegreeName)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:DegreeName</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:DegreeMeasure)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:DegreeMeasure)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:DegreeMeasure</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id"
                 priority="1004"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@validFrom)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@validFrom)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id may not contain @validFrom</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id may not contain @validTo</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id/hrxml:IdValue"
                 priority="1003"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id/hrxml:IdValue"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@name)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@name)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id/hrxml:IdValue may not contain @name</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification"
                 priority="1002"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:EffectiveDate)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:EffectiveDate)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification may not contain hrxml:EffectiveDate</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Description)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:Description)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification may not contain hrxml:Description</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:IssuingAuthority)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:IssuingAuthority)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification may not contain hrxml:IssuingAuthority</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications"
                 priority="1001"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:QualificationSummary)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:QualificationSummary)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications may not contain hrxml:QualificationSummary</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency"
                 priority="1000"
                 mode="M3">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:UserArea)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:UserArea)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency may not contain hrxml:UserArea</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CompetencyId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:CompetencyId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency may not contain hrxml:CompetencyId</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:TaxonomyId)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:TaxonomyId)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency may not contain hrxml:TaxonomyId</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@required)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(@required)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency may not contain @required</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Competency)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:Competency)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency may not contain hrxml:Competency</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CompetencyWeight)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="empty(hrxml:CompetencyWeight)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency may not contain hrxml:CompetencyWeight</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CompetencyEvidence)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:CompetencyEvidence)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency may not contain hrxml:CompetencyEvidence</svrl:text>
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
<xsl:template match="hrxml:StaffingOrder" priority="1028" mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="hrxml:StaffingOrder"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:OrderContact) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:OrderContact) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder must contain hrxml:OrderContact at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingPosition) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:StaffingPosition) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder may contain hrxml:StaffingPosition at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:UserArea) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:UserArea) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder must contain hrxml:UserArea at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:CustomerReportingRequirements" priority="1027"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:CustomerReportingRequirements"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:AdditionalRequirement) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:AdditionalRequirement) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:CustomerReportingRequirements must contain hrxml:AdditionalRequirement at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement"
                 priority="1026"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@requirementTitle) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@requirementTitle) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must contain @requirementTitle at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo"
                 priority="1025"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:ContactMethod) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:ContactMethod) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo may contain hrxml:ContactMethod at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:PersonName"
                 priority="1024"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:PersonName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:FormattedName) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:FormattedName) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:PersonName must contain hrxml:FormattedName at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:OrderId" priority="1023" mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:OrderId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@idOwner) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:OrderId must contain @idOwner at least 1 time(s)</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:OrderId may contain hrxml:IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation" priority="1022"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:ReferenceInformation"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingCustomerId) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:StaffingCustomerId) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation must contain hrxml:StaffingCustomerId at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:MasterOrderId"
                 priority="1021"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:MasterOrderId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@idOwner) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:MasterOrderId must contain @idOwner at least 1 time(s)</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:MasterOrderId may contain hrxml:IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId"
                 priority="1020"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@idOwner) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId must contain @idOwner at least 1 time(s)</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may contain hrxml:IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId"
                 priority="1019"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may contain hrxml:IdValue at most 1 time(s)</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId must contain @idOwner at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId"
                 priority="1018"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may contain hrxml:IdValue at most 1 time(s)</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId must contain @idOwner at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId"
                 priority="1017"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@idOwner) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId must contain @idOwner at least 1 time(s)</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may contain hrxml:IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition" priority="1016" mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingShift) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:StaffingShift) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition may contain hrxml:StaffingShift at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader"
                 priority="1015"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:RequestedPerson) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:RequestedPerson) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may contain hrxml:RequestedPerson at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonId"
                 priority="1014"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@idOwner) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonId must contain @idOwner at least 1 time(s)</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonId may contain hrxml:IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonName"
                 priority="1013"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:FamilyName) &lt;= 2"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:FamilyName) &lt;= 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonName may contain hrxml:FamilyName at most 2 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:ShiftWork"
                 priority="1012"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:ShiftWork"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:Description) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:Description) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:ShiftWork must contain hrxml:Description at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates" priority="1011"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:Multiplier) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:Multiplier) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates may contain hrxml:Multiplier at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:CustomerRateClassification"
                 priority="1010"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:CustomerRateClassification"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:CustomerRateClassification may contain hrxml:IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:ExternalRateSetId"
                 priority="1009"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:ExternalRateSetId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:ExternalRateSetId may contain hrxml:IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:RatesId"
                 priority="1008"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:RatesId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:RatesId may contain hrxml:IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift"
                 priority="1007"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:Hours) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:Hours) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift must contain hrxml:Hours at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@shiftPeriod) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@shiftPeriod) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift must contain @shiftPeriod at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea" priority="1006" mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:UserArea"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(setu:StaffingOrderAdditionalNL) &gt;= 1 and count(setu:StaffingOrderAdditionalNL) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(setu:StaffingOrderAdditionalNL) &gt;= 1 and count(setu:StaffingOrderAdditionalNL) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea must contain setu:StaffingOrderAdditionalNL at least 1 and at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:OfferId"
                 priority="1005"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:OfferId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@idOwner) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:OfferId must contain @idOwner at least 1 time(s)</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:OfferId may contain hrxml:IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:PreviousOrderId"
                 priority="1004"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:PreviousOrderId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:PreviousOrderId may contain hrxml:IdValue at most 1 time(s)</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:PreviousOrderId must contain @idOwner at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:RFQOrderId"
                 priority="1003"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:RFQOrderId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@idOwner) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@idOwner) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:RFQOrderId must contain @idOwner at least 1 time(s)</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:RFQOrderId may contain hrxml:IdValue at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution"
                 priority="1002"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:Degree) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:Degree) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may contain hrxml:Degree at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:LocalInstitutionClassification) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:LocalInstitutionClassification) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may contain hrxml:LocalInstitutionClassification at most 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id"
                 priority="1001"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:IdValue) &lt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:IdValue) &lt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id must contain @idOwner at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency"
                 priority="1000"
                 mode="M4">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@description) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@description) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency must contain @description at least 1 time(s)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(@name) &gt;= 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(@name) &gt;= 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency must contain @name at least 1 time(s)</svrl:text>
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
<xsl:template match="hrxml:StaffingOrder/hrxml:CustomerReportingRequirements" priority="1028"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:CustomerReportingRequirements"/>

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
<xsl:template match="hrxml:StaffingOrder/hrxml:OrderClassification" priority="1027" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:OrderClassification"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@orderStatus) or (@orderStatus='new') or (@orderStatus='closed')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@orderStatus) or (@orderStatus='new') or (@orderStatus='closed')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:OrderClassification/@orderStatus must have one of the following values: [new, closed]</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:OrderClassification/@orderType must have one of the following values: [RFQ, order]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:OrderContact" priority="1026" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:OrderContact"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@contactType) or (@contactType='created by') or (@contactType='authorized by') or (@contactType='first day contact') or (@contactType='placed by') or (@contactType='placed on behalf of') or (@contactType='supervisor') or (@contactType='submitted by')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@contactType) or (@contactType='created by') or (@contactType='authorized by') or (@contactType='first day contact') or (@contactType='placed by') or (@contactType='placed on behalf of') or (@contactType='supervisor') or (@contactType='submitted by')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:OrderContact/@contactType must have one of the following values: [created by, authorized by, first day contact, placed by, placed on behalf of, supervisor, submitted by]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:OrderId" priority="1025" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:OrderId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:OrderId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:PositionQuantity" priority="1024" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:PositionQuantity"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="number(text()) &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="number(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:PositionQuantity must be at least 1.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation" priority="1023"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:ReferenceInformation"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:StaffingSupplierOrgUnitId/@idOwner) = count(distinct-values(hrxml:StaffingSupplierOrgUnitId/@idOwner))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:StaffingSupplierOrgUnitId/@idOwner) = count(distinct-values(hrxml:StaffingSupplierOrgUnitId/@idOwner))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>The same idOwner may not be given for StaffingSupplierOrgUnitId</svrl:text>
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
         <xsl:when test="if (count(hrxml:StaffingSupplierOrgUnitId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingSupplierOrgUnitId[@idOwner = 'KvK']) = 1) else ('true')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="if (count(hrxml:StaffingSupplierOrgUnitId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingSupplierOrgUnitId[@idOwner = 'KvK']) = 1) else ('true')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:MasterOrderId"
                 priority="1022"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:MasterOrderId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:MasterOrderId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId"
                 priority="1021"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId must be filled</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, OIN, KvK, BTW, Fi, Vest]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId"
                 priority="1020"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId must be filled</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, OIN, KvK, BTW, Fi, Vest]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId"
                 priority="1019"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId must be filled</svrl:text>
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
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, OIN, KvK, BTW, Fi, Vest]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId"
                 priority="1018"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length() &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length() &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId must be filled</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='KvK') or (@idOwner='OIN') or (@idOwner='BTW') or (@idOwner='Fi')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='KvK') or (@idOwner='OIN') or (@idOwner='BTW') or (@idOwner='Fi')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, KvK, OIN, BTW, Fi]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition" priority="1017" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PositionReason) or (hrxml:PositionReason='Illness') or (hrxml:PositionReason='Peak') or (hrxml:PositionReason='Project') or (hrxml:PositionReason='Reorganisation') or (hrxml:PositionReason='Position') or (hrxml:PositionReason='Vacation') or (hrxml:PositionReason='Maternity') or (hrxml:PositionReason='Season') or (hrxml:PositionReason='Replacement') or (hrxml:PositionReason='Recruitment') or (hrxml:PositionReason='Structural') or (hrxml:PositionReason='Other')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:PositionReason) or (hrxml:PositionReason='Illness') or (hrxml:PositionReason='Peak') or (hrxml:PositionReason='Project') or (hrxml:PositionReason='Reorganisation') or (hrxml:PositionReason='Position') or (hrxml:PositionReason='Vacation') or (hrxml:PositionReason='Maternity') or (hrxml:PositionReason='Season') or (hrxml:PositionReason='Replacement') or (hrxml:PositionReason='Recruitment') or (hrxml:PositionReason='Structural') or (hrxml:PositionReason='Other')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionReason must have one of the following values: [Illness, Peak, Project, Reorganisation, Position, Vacation, Maternity, Season, Replacement, Recruitment, Structural, Other]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:CustomerReportingRequirements) or (hrxml:CustomerReportingRequirements='')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:CustomerReportingRequirements) or (hrxml:CustomerReportingRequirements='')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements must be Empty</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader"
                 priority="1016"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:PositionType) or (hrxml:PositionType='recruitment and selection') or (hrxml:PositionType='secondment') or (hrxml:PositionType='temporary staffing')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:PositionType) or (hrxml:PositionType='recruitment and selection') or (hrxml:PositionType='secondment') or (hrxml:PositionType='temporary staffing')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:PositionType must have one of the following values: [recruitment and selection, secondment, temporary staffing]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:PositionId"
                 priority="1015"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:PositionId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:Id) or (hrxml:Id='')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:Id) or (hrxml:Id='')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:PositionId/hrxml:Id must be Empty</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson"
                 priority="1014"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:PersonName) + count(hrxml:PersonId) &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(hrxml:PersonName) + count(hrxml:PersonId) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:PositionHeader/hrxml:RequestedPerson - PersonName OR PersonId is mandatory.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonId"
                 priority="1013"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='BSN')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='BSN')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonId/@idOwner must have one of the following values: [StaffingCustomer, staffingCustomer, BSN]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonName/hrxml:Affix"
                 priority="1012"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonName/hrxml:Affix"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@type) or (@type='aristocraticTitle') or (@type='formOfAddress') or (@type='generation') or (@type='qualification')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@type) or (@type='aristocraticTitle') or (@type='formOfAddress') or (@type='generation') or (@type='qualification')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonName/hrxml:Affix/@type must have one of the following values: [aristocraticTitle, formOfAddress, generation, qualification]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:ShiftWork"
                 priority="1011"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:ShiftWork"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@haveShiftWork) or (@haveShiftWork='true')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@haveShiftWork) or (@haveShiftWork='true')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:ShiftWork/@haveShiftWork must have one of the following values: [true]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates" priority="1010"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(empty(hrxml:Class) or (hrxml:Class='TimeInterval') or (hrxml:Class='Allowance') or (hrxml:Class='Expense')) or (empty(hrxml:Class) or (hrxml:Class=''))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(empty(hrxml:Class) or (hrxml:Class='TimeInterval') or (hrxml:Class='Allowance') or (hrxml:Class='Expense')) or (empty(hrxml:Class) or (hrxml:Class=''))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:Class must have one of the following values: [TimeInterval, Allowance, Expense] OR hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:Class must be Empty</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@rateType) or (@rateType='pay') or (@rateType='bill') or (@rateType='minPayRate') or (@rateType='maxPayRate') or (@rateType='minBillRate') or (@rateType='maxBillRate')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@rateType) or (@rateType='pay') or (@rateType='bill') or (@rateType='minPayRate') or (@rateType='maxPayRate') or (@rateType='minBillRate') or (@rateType='maxBillRate')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/@rateType must have one of the following values: [pay, bill, minPayRate, maxPayRate, minBillRate, maxBillRate]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(/hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:InclusiveRate) = 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(/hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:InclusiveRate) = 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:InclusiveRate is mandatory if Rates are included</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@rateStatus) or (@rateStatus='proposed') or (@rateStatus='agreed')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@rateStatus) or (@rateStatus='proposed') or (@rateStatus='agreed')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/@rateStatus must have one of the following values: [proposed, agreed]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:Amount"
                 priority="1009"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:Amount"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@rateAmountPeriod) or (@rateAmountPeriod='hourly') or (@rateAmountPeriod='x:hourlysplit') or (@rateAmountPeriod='x:hourlyconsolidated') or (@rateAmountPeriod='daily') or (@rateAmountPeriod='weekly') or (@rateAmountPeriod='x:4weekly') or (@rateAmountPeriod='monthly') or (@rateAmountPeriod='yearly') or (@rateAmountPeriod='flatfee')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@rateAmountPeriod) or (@rateAmountPeriod='hourly') or (@rateAmountPeriod='x:hourlysplit') or (@rateAmountPeriod='x:hourlyconsolidated') or (@rateAmountPeriod='daily') or (@rateAmountPeriod='weekly') or (@rateAmountPeriod='x:4weekly') or (@rateAmountPeriod='monthly') or (@rateAmountPeriod='yearly') or (@rateAmountPeriod='flatfee')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:Amount/@rateAmountPeriod must have one of the following values: [hourly, x:hourlysplit, x:hourlyconsolidated, daily, weekly, x:4weekly, monthly, yearly, flatfee]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift"
                 priority="1008"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@shiftPeriod) or (@shiftPeriod='weekly') or (@shiftPeriod='monthly') or (@shiftPeriod='daily')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@shiftPeriod) or (@shiftPeriod='weekly') or (@shiftPeriod='monthly') or (@shiftPeriod='daily')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift/@shiftPeriod must have one of the following values: [weekly, monthly, daily]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift/hrxml:Id"
                 priority="1007"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift/hrxml:Id"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:IdValue) or (hrxml:IdValue='')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:IdValue) or (hrxml:IdValue='')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift/hrxml:Id/hrxml:IdValue must be Empty</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite/hrxml:PostalAddress"
                 priority="1006"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite/hrxml:PostalAddress"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="matches(hrxml:CountryCode, '^[A-Z][A-Z]$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="matches(hrxml:CountryCode, '^[A-Z][A-Z]$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite/hrxml:PostalAddress/hrxml:CountryCode must match regular expression: ^[A-Z][A-Z]$</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL"
                 priority="1005"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(setu:SETUVersionId) or (setu:SETUVersionId='1.2')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(setu:SETUVersionId) or (setu:SETUVersionId='1.2')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:SETUVersionId must have one of the following values: [1.2]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:OfferId"
                 priority="1004"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:OfferId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCompany')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@idOwner) or (@idOwner='StaffingCompany')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:OfferId/@idOwner must have one of the following values: [StaffingCompany]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:PreviousOrderId"
                 priority="1003"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:PreviousOrderId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:PreviousOrderId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:RFQOrderId"
                 priority="1002"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:RFQOrderId"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:RFQOrderId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree"
                 priority="1001"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(@degreeType) or (@degreeType='1') or (@degreeType='2') or (@degreeType='3') or (@degreeType='4') or (@degreeType='5') or (@degreeType='6')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(@degreeType) or (@degreeType='1') or (@degreeType='2') or (@degreeType='3') or (@degreeType='4') or (@degreeType='5') or (@degreeType='6')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree/@degreeType must have one of the following values: [1, 2, 3, 4, 5, 6]</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id"
                 priority="1000"
                 mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="empty(hrxml:IdValue) or (hrxml:IdValue='SOI-2006')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="empty(hrxml:IdValue) or (hrxml:IdValue='SOI-2006')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id/hrxml:IdValue must have one of the following values: [SOI-2006]</svrl:text>
            </svrl:failed-assert>
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
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement[@requirementTitle = 'VersionId']"/>

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
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates[hrxml:Class = 'TimeInterval']"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(hrxml:Multiplier) = 1"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(hrxml:Multiplier) = 1">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:Multiplier is mandatory if hrxml:Class is TimeInterval</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M7"/>
   <xsl:template match="@*|node()" priority="-2" mode="M7">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>
</xsl:stylesheet>