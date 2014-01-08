<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:schold="http://www.ascc.net/xml/schematron"
                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:qdt="urn:oasis:names:specification:ubl:schema:xsd:QualifiedDataTypes-2"
                xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
                xmlns:doc="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"
                xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
                xmlns:ccts="urn:oasis:names:specification:ubl:schema:xsd:CoreComponentParameters-2"
                xmlns:ext="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"
                xmlns:nl-cbc="urn:digi-inkoop:ubl:2.0:NL:1.6:UBL-NL-CommonBasicComponents-2"
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
      <svrl:schematron-output xmlns:svrl="http://purl.oclc.org/dsdl/svrl" title="" schemaVersion="ISO19757-3">
         <xsl:comment>
            <xsl:value-of select="$archiveDirParameter"/>   
		 <xsl:value-of select="$archiveNameParameter"/>  
		 <xsl:value-of select="$fileNameParameter"/>  
		 <xsl:value-of select="$fileDirParameter"/>
         </xsl:comment>
         <svrl:ns-prefix-in-attribute-values uri="urn:oasis:names:specification:ubl:schema:xsd:QualifiedDataTypes-2"
                                             prefix="qdt"/>
         <svrl:ns-prefix-in-attribute-values uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
                                             prefix="cbc"/>
         <svrl:ns-prefix-in-attribute-values uri="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2" prefix="doc"/>
         <svrl:ns-prefix-in-attribute-values uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
                                             prefix="cac"/>
         <svrl:ns-prefix-in-attribute-values uri="urn:oasis:names:specification:ubl:schema:xsd:CoreComponentParameters-2"
                                             prefix="ccts"/>
         <svrl:ns-prefix-in-attribute-values uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"
                                             prefix="ext"/>
         <svrl:ns-prefix-in-attribute-values uri="urn:digi-inkoop:ubl:2.0:NL:1.6:UBL-NL-CommonBasicComponents-2"
                                             prefix="nl-cbc"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">RequestForQuotation_UBLExtensions</xsl:attribute>
            <xsl:attribute name="name">RequestForQuotation_UBLExtensions</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M7"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice</xsl:attribute>
            <xsl:attribute name="name">Invoice</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M8"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_AccountingCustomerParty</xsl:attribute>
            <xsl:attribute name="name">Invoice_AccountingCustomerParty</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M9"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_AccountingCustomerParty_Party</xsl:attribute>
            <xsl:attribute name="name">Invoice_AccountingCustomerParty_Party</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M10"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_AccountingCustomerParty_Party_PartyIdentification</xsl:attribute>
            <xsl:attribute name="name">Invoice_AccountingCustomerParty_Party_PartyIdentification</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M11"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_AccountingCustomerParty_Party_PartyTaxScheme</xsl:attribute>
            <xsl:attribute name="name">Invoice_AccountingCustomerParty_Party_PartyTaxScheme</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M12"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_AccountingCustomerParty_Party_Person</xsl:attribute>
            <xsl:attribute name="name">Invoice_AccountingCustomerParty_Party_Person</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M13"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_InvoicePeriod</xsl:attribute>
            <xsl:attribute name="name">Invoice_InvoicePeriod</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M14"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_OrderReference</xsl:attribute>
            <xsl:attribute name="name">Invoice_OrderReference</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M15"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_BillingReference</xsl:attribute>
            <xsl:attribute name="name">Invoice_BillingReference</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M16"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_BillingReference_InvoiceDocumentReference_ID</xsl:attribute>
            <xsl:attribute name="name">Invoice_BillingReference_InvoiceDocumentReference_ID</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M17"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_ContractDocumentReference</xsl:attribute>
            <xsl:attribute name="name">Invoice_ContractDocumentReference</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M18"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_AccountingSupplierParty</xsl:attribute>
            <xsl:attribute name="name">Invoice_AccountingSupplierParty</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M19"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_AccountingSupplierParty_Party</xsl:attribute>
            <xsl:attribute name="name">Invoice_AccountingSupplierParty_Party</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M20"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_AccountingSupplierParty_Party_PostalAddress</xsl:attribute>
            <xsl:attribute name="name">Invoice_AccountingSupplierParty_Party_PostalAddress</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M21"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_AccountingSupplierParty_Party_PostalAddress_Country</xsl:attribute>
            <xsl:attribute name="name">Invoice_AccountingSupplierParty_Party_PostalAddress_Country</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M22"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_AccountingSupplierParty_Party_PhysicalLocation</xsl:attribute>
            <xsl:attribute name="name">Invoice_AccountingSupplierParty_Party_PhysicalLocation</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M23"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_AccountingSupplierParty_Party_PhysicalLocation_Address</xsl:attribute>
            <xsl:attribute name="name">Invoice_AccountingSupplierParty_Party_PhysicalLocation_Address</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M24"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_AccountingSupplierParty_Party_PhysicalLocation_Address_Country</xsl:attribute>
            <xsl:attribute name="name">Invoice_AccountingSupplierParty_Party_PhysicalLocation_Address_Country</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M25"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_AccountingSupplierParty_Party_PartyTaxScheme_TaxScheme</xsl:attribute>
            <xsl:attribute name="name">Invoice_AccountingSupplierParty_Party_PartyTaxScheme_TaxScheme</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M26"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_AccountingSupplierParty_Party_Person</xsl:attribute>
            <xsl:attribute name="name">Invoice_AccountingSupplierParty_Party_Person</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M27"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_AccountingCustomerParty_Party_PostalAddress</xsl:attribute>
            <xsl:attribute name="name">Invoice_AccountingCustomerParty_Party_PostalAddress</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M28"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_AccountingCustomerParty_Party_PostalAddress_Country</xsl:attribute>
            <xsl:attribute name="name">Invoice_AccountingCustomerParty_Party_PostalAddress_Country</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M29"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_AccountingCustomerParty_Party_PhysicalLocation</xsl:attribute>
            <xsl:attribute name="name">Invoice_AccountingCustomerParty_Party_PhysicalLocation</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M30"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_AccountingCustomerParty_Party_PhysicalLocation_Address</xsl:attribute>
            <xsl:attribute name="name">Invoice_AccountingCustomerParty_Party_PhysicalLocation_Address</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M31"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_AccountingCustomerParty_Party_PhysicalLocation_Address_Country</xsl:attribute>
            <xsl:attribute name="name">Invoice_AccountingCustomerParty_Party_PhysicalLocation_Address_Country</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M32"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_SellerSupplierParty_Party</xsl:attribute>
            <xsl:attribute name="name">Invoice_SellerSupplierParty_Party</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M33"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_SellerSupplierParty_Party_PartyIdentification</xsl:attribute>
            <xsl:attribute name="name">Invoice_SellerSupplierParty_Party_PartyIdentification</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M34"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_SellerSupplierParty_Party_PostalAddress</xsl:attribute>
            <xsl:attribute name="name">Invoice_SellerSupplierParty_Party_PostalAddress</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M35"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_SellerSupplierParty_Party_PostalAddress_Country</xsl:attribute>
            <xsl:attribute name="name">Invoice_SellerSupplierParty_Party_PostalAddress_Country</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M36"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_SellerSupplierParty_Party_PhysicalLocation</xsl:attribute>
            <xsl:attribute name="name">Invoice_SellerSupplierParty_Party_PhysicalLocation</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M37"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_SellerSupplierParty_Party_PhysicalLocation_Address</xsl:attribute>
            <xsl:attribute name="name">Invoice_SellerSupplierParty_Party_PhysicalLocation_Address</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M38"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_SellerSupplierParty_Party_PhysicalLocation_Address_Country</xsl:attribute>
            <xsl:attribute name="name">Invoice_SellerSupplierParty_Party_PhysicalLocation_Address_Country</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M39"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_SellerSupplierParty_Party_PartyTaxScheme</xsl:attribute>
            <xsl:attribute name="name">Invoice_SellerSupplierParty_Party_PartyTaxScheme</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M40"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_SellerSupplierParty_Party_Person</xsl:attribute>
            <xsl:attribute name="name">Invoice_SellerSupplierParty_Party_Person</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M41"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_BuyerCustomerParty_Party</xsl:attribute>
            <xsl:attribute name="name">Invoice_BuyerCustomerParty_Party</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M42"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_BuyerCustomerParty_Party_PartyIdentification</xsl:attribute>
            <xsl:attribute name="name">Invoice_BuyerCustomerParty_Party_PartyIdentification</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M43"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_BuyerCustomerParty_Party_PostalAddress</xsl:attribute>
            <xsl:attribute name="name">Invoice_BuyerCustomerParty_Party_PostalAddress</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M44"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_BuyerCustomerParty_Party_PostalAddress_Country</xsl:attribute>
            <xsl:attribute name="name">Invoice_BuyerCustomerParty_Party_PostalAddress_Country</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M45"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_BuyerCustomerParty_Party_PhysicalLocation</xsl:attribute>
            <xsl:attribute name="name">Invoice_BuyerCustomerParty_Party_PhysicalLocation</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M46"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_BuyerCustomerParty_Party_PhysicalLocation_Address</xsl:attribute>
            <xsl:attribute name="name">Invoice_BuyerCustomerParty_Party_PhysicalLocation_Address</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M47"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_BuyerCustomerParty_Party_PhysicalLocation_Address_Country</xsl:attribute>
            <xsl:attribute name="name">Invoice_BuyerCustomerParty_Party_PhysicalLocation_Address_Country</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M48"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_BuyerCustomerParty_Party_PartyTaxScheme</xsl:attribute>
            <xsl:attribute name="name">Invoice_BuyerCustomerParty_Party_PartyTaxScheme</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M49"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_BuyerCustomerParty_Party_Person</xsl:attribute>
            <xsl:attribute name="name">Invoice_BuyerCustomerParty_Party_Person</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M50"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_PaymentMeans_PayeeFinancialAccount</xsl:attribute>
            <xsl:attribute name="name">Invoice_PaymentMeans_PayeeFinancialAccount</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M51"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_PaymentMeans_PayeeFinancialAccount_FinancialInstitutionBranch</xsl:attribute>
            <xsl:attribute name="name">Invoice_PaymentMeans_PayeeFinancialAccount_FinancialInstitutionBranch</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M52"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_PaymentMeans_PayeeFinancialAccount_FinancialInstitutionBranch_FinancialInstitution</xsl:attribute>
            <xsl:attribute name="name">Invoice_PaymentMeans_PayeeFinancialAccount_FinancialInstitutionBranch_FinancialInstitution</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M53"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_PaymentTerms</xsl:attribute>
            <xsl:attribute name="name">Invoice_PaymentTerms</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M54"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_PaymentTerms_SettlementPeriod</xsl:attribute>
            <xsl:attribute name="name">Invoice_PaymentTerms_SettlementPeriod</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M55"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_PaymentTerms_PenaltyPeriod</xsl:attribute>
            <xsl:attribute name="name">Invoice_PaymentTerms_PenaltyPeriod</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M56"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_TaxTotal</xsl:attribute>
            <xsl:attribute name="name">Invoice_TaxTotal</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M57"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_TaxTotal_TaxSubtotal</xsl:attribute>
            <xsl:attribute name="name">Invoice_TaxTotal_TaxSubtotal</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M58"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_LegalMonetaryTotal</xsl:attribute>
            <xsl:attribute name="name">Invoice_LegalMonetaryTotal</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M59"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_InvoiceLine</xsl:attribute>
            <xsl:attribute name="name">Invoice_InvoiceLine</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M60"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_Delivery</xsl:attribute>
            <xsl:attribute name="name">Invoice_Delivery</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M61"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_InvoiceLine_OrderLineReference</xsl:attribute>
            <xsl:attribute name="name">Invoice_InvoiceLine_OrderLineReference</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M62"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_InvoiceLine_AllowanceCharge</xsl:attribute>
            <xsl:attribute name="name">Invoice_InvoiceLine_AllowanceCharge</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M63"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_InvoiceLine_TaxTotal</xsl:attribute>
            <xsl:attribute name="name">Invoice_InvoiceLine_TaxTotal</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M64"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_InvoiceLine_TaxTotal_TaxSubtotal</xsl:attribute>
            <xsl:attribute name="name">Invoice_InvoiceLine_TaxTotal_TaxSubtotal</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M65"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_InvoiceLine_Item</xsl:attribute>
            <xsl:attribute name="name">Invoice_InvoiceLine_Item</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M66"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_InvoiceLine_Price</xsl:attribute>
            <xsl:attribute name="name">Invoice_InvoiceLine_Price</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M67"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_TaxTotal_TaxSubtotal_TaxCategory_TaxScheme</xsl:attribute>
            <xsl:attribute name="name">Invoice_TaxTotal_TaxSubtotal_TaxCategory_TaxScheme</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M68"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_InvoiceLine_Item_ClassifiedTaxCategory_TaxScheme</xsl:attribute>
            <xsl:attribute name="name">Invoice_InvoiceLine_Item_ClassifiedTaxCategory_TaxScheme</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M69"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_InvoiceLine_TaxTotal_TaxSubtotal_TaxCategory_TaxScheme</xsl:attribute>
            <xsl:attribute name="name">Invoice_InvoiceLine_TaxTotal_TaxSubtotal_TaxCategory_TaxScheme</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M70"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_PaymentMeans</xsl:attribute>
            <xsl:attribute name="name">Invoice_PaymentMeans</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M71"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_BuyerCustomerParty</xsl:attribute>
            <xsl:attribute name="name">Invoice_BuyerCustomerParty</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M72"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_BuyerCustomerParty_Party_Contact</xsl:attribute>
            <xsl:attribute name="name">Invoice_BuyerCustomerParty_Party_Contact</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M73"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_Delivery_DeliveryAddress</xsl:attribute>
            <xsl:attribute name="name">Invoice_Delivery_DeliveryAddress</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M74"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_Delivery_DeliveryAddress_Country</xsl:attribute>
            <xsl:attribute name="name">Invoice_Delivery_DeliveryAddress_Country</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M75"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_PaymentMeans_PayeeFinancialAccount_FinancialInstitutionBranch_Address</xsl:attribute>
            <xsl:attribute name="name">Invoice_PaymentMeans_PayeeFinancialAccount_FinancialInstitutionBranch_Address</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M76"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_PaymentMeans_PayeeFinancialAccount_FinancialInstitutionBranch_Address_Country</xsl:attribute>
            <xsl:attribute name="name">Invoice_PaymentMeans_PayeeFinancialAccount_FinancialInstitutionBranch_Address_Country</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M77"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_SellerSupplierParty_Party_Contact</xsl:attribute>
            <xsl:attribute name="name">Invoice_SellerSupplierParty_Party_Contact</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M78"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_DeliveryTerms</xsl:attribute>
            <xsl:attribute name="name">Invoice_DeliveryTerms</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M79"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_SellerSupplierParty</xsl:attribute>
            <xsl:attribute name="name">Invoice_SellerSupplierParty</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M80"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_PaymentMeans_PayeeFinancialAccount_Country</xsl:attribute>
            <xsl:attribute name="name">Invoice_PaymentMeans_PayeeFinancialAccount_Country</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M81"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_AccountingSupplierParty_Party_PartyIdentification</xsl:attribute>
            <xsl:attribute name="name">Invoice_AccountingSupplierParty_Party_PartyIdentification</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M82"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">Invoice_InvoiceLine_Item_ClassifiedTaxCategory</xsl:attribute>
            <xsl:attribute name="name">Invoice_InvoiceLine_Item_ClassifiedTaxCategory</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M83"/>
      </svrl:schematron-output>
   </xsl:template>

   <!--SCHEMATRON PATTERNS-->


<!--PATTERN RequestForQuotation_UBLExtensions-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cbc:LastInvoiceOnOrderIndicator"
                 priority="1000"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cbc:LastInvoiceOnOrderIndicator"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="text() = 'true' or text() = 'false' or text() = '1' or text() = '0'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="text() = 'true' or text() = 'false' or text() = '1' or text() = '0'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  LastInvoiceOnOrderIndicator moet een geldige boolean waarde bevatten: true, false, 1, 0.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M7"/>
   <xsl:template match="@*|node()" priority="-2" mode="M7">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

   <!--PATTERN Invoice-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cbc:UBLVersionID" priority="1006" mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cbc:UBLVersionID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="normalize-space(text()) = '2.0'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="normalize-space(text()) = '2.0'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Bericht MOET gebaseerd zijn op UBL Versie 2.0</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cbc:CustomizationID" priority="1005" mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cbc:CustomizationID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="normalize-space(text()) = '1.6'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="normalize-space(text()) = '1.6'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Bericht MOET gebaseerd zijn op versie 1.6 van de Nederlandse specificatie.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cbc:ProfileID" priority="1004" mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/doc:Invoice/cbc:ProfileID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="normalize-space(text()) = 'NL'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="normalize-space(text()) = 'NL'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Bericht MOET op de Nederlandse (NL) specificatie gebaseerd zijn.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice" priority="1003" mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/doc:Invoice"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:Note) lt 2 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:Note) lt 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cbc:Note element should be less than 2!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:InvoicePeriod) lt 2 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:InvoicePeriod) lt 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:InvoicePeriod element should be less than 2!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:Delivery) lt 2 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:Delivery) lt 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:Delivery element should be less than 2!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PaymentMeans) lt 2 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:PaymentMeans) lt 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:PaymentMeans element should be less than 2!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:TaxTotal) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:TaxTotal)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:TaxTotal element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:TaxTotal) lt 2 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:TaxTotal) lt 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:TaxTotal element should be less than 2!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:BillingReference) lt 2 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cac:BillingReference) lt 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:BillingReference element should be less than 2!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(empty(cbc:ID))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="not(empty(cbc:ID))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cbc:ID element should not be empty!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:UBLVersionID) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:UBLVersionID)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cbc:UBLVersionID element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:CustomizationID) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:CustomizationID)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cbc:CustomizationID element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:ProfileID) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:ProfileID)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cbc:ProfileID element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:ID) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:ID)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cbc:ID element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(count(cac:OrderReference/cbc:ID) + count(cbc:AccountingCostCode) + count(cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:Name)) &gt; 0"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(cac:OrderReference/cbc:ID) + count(cbc:AccountingCostCode) + count(cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:Name)) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Er moet in ieder geval een OrderReference ID, AccountingCostCode of Contact Name worden opgegeven.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="every $bn in //cbc:BuildingNumber satisfies (matches($bn,'^\d+(-[ \w]+)?$'))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="every $bn in //cbc:BuildingNumber satisfies (matches($bn,'^\d+(-[ \w]+)?$'))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Huisnummer en Huisnummertoevoeging moeten achter elkaar geplaatst worden, gescheiden met een koppelteken.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="every $id in //cac:PartyIdentification/cbc:ID satisfies (exists($id/@schemeAgencyID) and not(empty($id/@schemeAgencyID)) and exists($id/@schemeAgencyName) and not(empty($id/@schemeAgencyName)))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="every $id in //cac:PartyIdentification/cbc:ID satisfies (exists($id/@schemeAgencyID) and not(empty($id/@schemeAgencyID)) and exists($id/@schemeAgencyName) and not(empty($id/@schemeAgencyName)))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  PartyIdentification/ID MOET @schemeAgencyID en @schemeAgencyName attributen bevatten.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PaymentTerms) lt 4"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:PaymentTerms) lt 4">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:PaymentTerms element should be less than 4!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="every $pa in //cac:PostalAddress satisfies ( (not(empty($pa/cbc:Postbox)) and empty($pa/cbc:StreetName) and empty($pa/cbc:BuildingNumber) and empty(cbc:Room) and empty(cbc:Floor) and empty(cbc:Department) and empty(cbc:InhouseMail) and empty(cbc:PlotIdentification))  or  (empty($pa/cbc:Postbox) and (not(empty($pa/cbc:StreetName)) or not(empty($pa/cbc:BuildingNumber)) or not(empty(cbc:Room)) or not(empty(cbc:Floor)) or not(empty(cbc:Department)) or not(empty(cbc:InhouseMail)) or not(empty(cbc:PlotIdentification)))) )"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="every $pa in //cac:PostalAddress satisfies ( (not(empty($pa/cbc:Postbox)) and empty($pa/cbc:StreetName) and empty($pa/cbc:BuildingNumber) and empty(cbc:Room) and empty(cbc:Floor) and empty(cbc:Department) and empty(cbc:InhouseMail) and empty(cbc:PlotIdentification)) or (empty($pa/cbc:Postbox) and (not(empty($pa/cbc:StreetName)) or not(empty($pa/cbc:BuildingNumber)) or not(empty(cbc:Room)) or not(empty(cbc:Floor)) or not(empty(cbc:Department)) or not(empty(cbc:InhouseMail)) or not(empty(cbc:PlotIdentification)))) )">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  PostalAddress MOET OF een Postbox bevatten OF minimaal 1 van de elementen StreetName, BuildingNumber, Room, Floor, Department, InhouseMail of PlotIdentification. Beide MAG NIET.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cbc:CopyIndicator" priority="1002" mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cbc:CopyIndicator"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cbc:ID" priority="1001" mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/doc:Invoice/cbc:ID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) lt 25"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) lt 25">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Element lengte MOET minder dan 25 posities zijn.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cbc:ID element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cbc:InvoiceTypeCode" priority="1000" mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cbc:InvoiceTypeCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="normalize-space(@listID) = 'NL-1001'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="normalize-space(@listID) = 'NL-1001'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Attribuut MOET de waarde NL-1001 bevatten.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="normalize-space(@listAgencyID) = xs:string(88)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="normalize-space(@listAgencyID) = xs:string(88)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Attribuut MOET de waarde 88 bevatten.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="normalize-space(@listAgencyName) = 'Logius Gegevensbeheer NL-Overheid'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="normalize-space(@listAgencyName) = 'Logius Gegevensbeheer NL-Overheid'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Attribuut MOET de waarde 'Logius Gegevensbeheer NL-Overheid' bevatten.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="normalize-space(@listName) = 'FactuurSoort'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="normalize-space(@listName) = 'FactuurSoort'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Attribuut MOET de waarde FactuurSoort bevatten.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cbc:InvoiceTypeCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="normalize-space(@listSchemeURI) = 'urn:digi-inkoop:ubl:2.0:NL:1.6:gc:InvoiceTypeCode'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="normalize-space(@listSchemeURI) = 'urn:digi-inkoop:ubl:2.0:NL:1.6:gc:InvoiceTypeCode'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Attribuut MOET de waarde urn:digi-inkoop:ubl:2.0:NL:1.6:gc:InvoiceTypeCode bevatten.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="normalize-space(@listVersionID) = xs:string(1.6)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="normalize-space(@listVersionID) = xs:string(1.6)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Attribuut MOET de waarde 1.6 bevatten.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="normalize-space(@listURI) = 'http://www.nltaxonomie.nl/ubl/2.0/NL/1.6/cl/gc/InvoiceTypeCode.gc'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="normalize-space(@listURI) = 'http://www.nltaxonomie.nl/ubl/2.0/NL/1.6/cl/gc/InvoiceTypeCode.gc'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Attribuut MOET de waarde http://www.nltaxonomie.nl/ubl/2.0/NL/1.6/cl/gc/InvoiceTypeCode.gc bevatten.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M8"/>
   <xsl:template match="@*|node()" priority="-2" mode="M8">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

   <!--PATTERN Invoice_AccountingCustomerParty-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingCustomerParty" priority="1001" mode="M9">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingCustomerParty"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:Party) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:Party)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:AccountingCustomerParty/cac:Party element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M9"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingCustomerParty/cac:Party" priority="1000"
                 mode="M9">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingCustomerParty/cac:Party"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyIdentification) lt 3"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cac:PartyIdentification) lt 3">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification element should be less than 3!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M9"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M9"/>
   <xsl:template match="@*|node()" priority="-2" mode="M9">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M9"/>
   </xsl:template>

   <!--PATTERN Invoice_AccountingCustomerParty_Party-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingCustomerParty/cac:Party" priority="1000"
                 mode="M10">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingCustomerParty/cac:Party"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:PartyIdentification) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(cac:PartyIdentification)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyName) lt 2 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:PartyName) lt 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyName element should be less than 2!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:PartyName) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:PartyName)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyName element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M10"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M10"/>
   <xsl:template match="@*|node()" priority="-2" mode="M10">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M10"/>
   </xsl:template>

   <!--PATTERN Invoice_AccountingCustomerParty_Party_PartyIdentification-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID"
                 priority="1000"
                 mode="M11">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="matches(@schemeAgencyID, '^[A-Z]{2}$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="matches(@schemeAgencyID, '^[A-Z]{2}$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(@schemeAgencyName  = 'KvK') or (@schemeAgencyName  = 'BTW') or (@schemeAgencyName = 'Fi') or (@schemeAgencyName  = 'BSN') or (@schemeAgencyName  = 'OIN') or (@schemeAgencyName  = 'XXX')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(@schemeAgencyName = 'KvK') or (@schemeAgencyName = 'BTW') or (@schemeAgencyName = 'Fi') or (@schemeAgencyName = 'BSN') or (@schemeAgencyName = 'OIN') or (@schemeAgencyName = 'XXX')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Uitgevende organisatie van de PartijIdentificatie MOET ge?dentificeerd worden door een code uit de lijst: KvK, BTW, Fi, BSN, OIN, XXX.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M11"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M11"/>
   <xsl:template match="@*|node()" priority="-2" mode="M11">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M11"/>
   </xsl:template>

   <!--PATTERN Invoice_AccountingCustomerParty_Party_PartyTaxScheme-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID"
                 priority="1000"
                 mode="M12">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M12"/>
   <xsl:template match="@*|node()" priority="-2" mode="M12">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/>
   </xsl:template>

   <!--PATTERN Invoice_AccountingCustomerParty_Party_Person-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:Person/cbc:FamilyName"
                 priority="1001"
                 mode="M13">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:Person/cbc:FamilyName"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M13"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:Person"
                 priority="1000"
                 mode="M13">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:Person"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M13"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M13"/>
   <xsl:template match="@*|node()" priority="-2" mode="M13">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M13"/>
   </xsl:template>

   <!--PATTERN Invoice_InvoicePeriod-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:InvoicePeriod/cbc:StartDate" priority="1002" mode="M14">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:InvoicePeriod/cbc:StartDate"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:InvoicePeriod/cbc:StartDate element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M14"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:InvoicePeriod/cbc:EndDate" priority="1001" mode="M14">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:InvoicePeriod/cbc:EndDate"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:InvoicePeriod/cbc:EndDate element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M14"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:InvoicePeriod" priority="1000" mode="M14">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:InvoicePeriod"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:StartDate) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:StartDate)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:InvoicePeriod/cbc:StartDate element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:EndDate) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:EndDate)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:InvoicePeriod/cbc:EndDate element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M14"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M14"/>
   <xsl:template match="@*|node()" priority="-2" mode="M14">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M14"/>
   </xsl:template>

   <!--PATTERN Invoice_OrderReference-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:OrderReference/cbc:ID" priority="1001" mode="M15">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:OrderReference/cbc:ID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:OrderReference/cbc:ID element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M15"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:OrderReference" priority="1000" mode="M15">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:OrderReference"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:ID) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:ID)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:OrderReference/cbc:ID element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M15"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M15"/>
   <xsl:template match="@*|node()" priority="-2" mode="M15">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M15"/>
   </xsl:template>

   <!--PATTERN Invoice_BillingReference-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:BillingReference" priority="1000" mode="M16">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:BillingReference"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:InvoiceDocumentReference) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(cac:InvoiceDocumentReference)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:BillingReference/cac:InvoiceDocumentReference element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M16"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M16"/>
   <xsl:template match="@*|node()" priority="-2" mode="M16">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M16"/>
   </xsl:template>

   <!--PATTERN Invoice_BillingReference_InvoiceDocumentReference_ID-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:BillingReference/cac:InvoiceDocumentReference/cbc:ID"
                 priority="1001"
                 mode="M17">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:BillingReference/cac:InvoiceDocumentReference/cbc:ID"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M17"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:BillingReference/cac:InvoiceDocumentReference"
                 priority="1000"
                 mode="M17">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:BillingReference/cac:InvoiceDocumentReference"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M17"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M17"/>
   <xsl:template match="@*|node()" priority="-2" mode="M17">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M17"/>
   </xsl:template>

   <!--PATTERN Invoice_ContractDocumentReference-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:ContractDocumentReference/cbc:ID" priority="1001"
                 mode="M18">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:ContractDocumentReference/cbc:ID"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M18"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:ContractDocumentReference" priority="1000" mode="M18">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:ContractDocumentReference"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M18"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M18"/>
   <xsl:template match="@*|node()" priority="-2" mode="M18">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M18"/>
   </xsl:template>

   <!--PATTERN Invoice_AccountingSupplierParty-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingSupplierParty" priority="1001" mode="M19">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingSupplierParty"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:Party) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:Party)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:AccountingSupplierParty/cac:Party element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M19"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingSupplierParty/cac:Party" priority="1000"
                 mode="M19">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingSupplierParty/cac:Party"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyIdentification) lt 3"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cac:PartyIdentification) lt 3">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification element should be less than 3!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M19"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M19"/>
   <xsl:template match="@*|node()" priority="-2" mode="M19">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M19"/>
   </xsl:template>

   <!--PATTERN Invoice_AccountingSupplierParty_Party-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingSupplierParty/cac:Party" priority="1000"
                 mode="M20">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingSupplierParty/cac:Party"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:PartyIdentification) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(cac:PartyIdentification)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:PartyName) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:PartyName)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyName element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyName) lt 2 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:PartyName) lt 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyName element should be less than 2!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M20"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M20"/>
   <xsl:template match="@*|node()" priority="-2" mode="M20">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M20"/>
   </xsl:template>

   <!--PATTERN Invoice_AccountingSupplierParty_Party_PostalAddress-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress"
                 priority="1002"
                 mode="M21">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:Country) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:Country)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M21"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:CityName"
                 priority="1001"
                 mode="M21">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:CityName"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M21"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:PostalZone"
                 priority="1000"
                 mode="M21">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:PostalZone"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M21"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M21"/>
   <xsl:template match="@*|node()" priority="-2" mode="M21">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M21"/>
   </xsl:template>

   <!--PATTERN Invoice_AccountingSupplierParty_Party_PostalAddress_Country-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"
                 priority="1001"
                 mode="M22">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M22"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country"
                 priority="1000"
                 mode="M22">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:IdentificationCode) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:IdentificationCode)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M22"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M22"/>
   <xsl:template match="@*|node()" priority="-2" mode="M22">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M22"/>
   </xsl:template>

   <!--PATTERN Invoice_AccountingSupplierParty_Party_PhysicalLocation-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation"
                 priority="1000"
                 mode="M23">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M23"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M23"/>
   <xsl:template match="@*|node()" priority="-2" mode="M23">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M23"/>
   </xsl:template>

   <!--PATTERN Invoice_AccountingSupplierParty_Party_PhysicalLocation_Address-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address"
                 priority="1004"
                 mode="M24">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M24"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:StreetName"
                 priority="1003"
                 mode="M24">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:StreetName"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M24"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:BuildingNumber"
                 priority="1002"
                 mode="M24">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:BuildingNumber"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M24"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:CityName"
                 priority="1001"
                 mode="M24">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:CityName"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M24"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:PostalZone"
                 priority="1000"
                 mode="M24">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:PostalZone"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M24"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M24"/>
   <xsl:template match="@*|node()" priority="-2" mode="M24">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M24"/>
   </xsl:template>

   <!--PATTERN Invoice_AccountingSupplierParty_Party_PhysicalLocation_Address_Country-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode"
                 priority="1001"
                 mode="M25">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M25"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country"
                 priority="1000"
                 mode="M25">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M25"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M25"/>
   <xsl:template match="@*|node()" priority="-2" mode="M25">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M25"/>
   </xsl:template>

   <!--PATTERN Invoice_AccountingSupplierParty_Party_PartyTaxScheme_TaxScheme-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme/cbc:ID"
                 priority="1001"
                 mode="M26">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme/cbc:ID"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M26"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme"
                 priority="1000"
                 mode="M26">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M26"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M26"/>
   <xsl:template match="@*|node()" priority="-2" mode="M26">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M26"/>
   </xsl:template>

   <!--PATTERN Invoice_AccountingSupplierParty_Party_Person-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:Person/cbc:FamilyName"
                 priority="1001"
                 mode="M27">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:Person/cbc:FamilyName"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M27"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:Person"
                 priority="1000"
                 mode="M27">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:Person"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M27"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M27"/>
   <xsl:template match="@*|node()" priority="-2" mode="M27">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M27"/>
   </xsl:template>

   <!--PATTERN Invoice_AccountingCustomerParty_Party_PostalAddress-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress"
                 priority="1002"
                 mode="M28">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:Country) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:Country)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M28"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:CityName"
                 priority="1001"
                 mode="M28">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:CityName"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M28"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:PostalZone"
                 priority="1000"
                 mode="M28">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:PostalZone"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M28"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M28"/>
   <xsl:template match="@*|node()" priority="-2" mode="M28">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M28"/>
   </xsl:template>

   <!--PATTERN Invoice_AccountingCustomerParty_Party_PostalAddress_Country-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"
                 priority="1001"
                 mode="M29">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M29"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country"
                 priority="1000"
                 mode="M29">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:IdentificationCode) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:IdentificationCode)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M29"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M29"/>
   <xsl:template match="@*|node()" priority="-2" mode="M29">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M29"/>
   </xsl:template>

   <!--PATTERN Invoice_AccountingCustomerParty_Party_PhysicalLocation-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation"
                 priority="1000"
                 mode="M30">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M30"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M30"/>
   <xsl:template match="@*|node()" priority="-2" mode="M30">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M30"/>
   </xsl:template>

   <!--PATTERN Invoice_AccountingCustomerParty_Party_PhysicalLocation_Address-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address"
                 priority="1004"
                 mode="M31">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M31"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:StreetName"
                 priority="1003"
                 mode="M31">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:StreetName"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M31"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:BuildingNumber"
                 priority="1002"
                 mode="M31">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:BuildingNumber"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M31"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:CityName"
                 priority="1001"
                 mode="M31">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:CityName"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M31"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:PostalZone"
                 priority="1000"
                 mode="M31">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:PostalZone"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M31"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M31"/>
   <xsl:template match="@*|node()" priority="-2" mode="M31">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M31"/>
   </xsl:template>

   <!--PATTERN Invoice_AccountingCustomerParty_Party_PhysicalLocation_Address_Country-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode"
                 priority="1001"
                 mode="M32">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M32"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country"
                 priority="1000"
                 mode="M32">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M32"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M32"/>
   <xsl:template match="@*|node()" priority="-2" mode="M32">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M32"/>
   </xsl:template>

   <!--PATTERN Invoice_SellerSupplierParty_Party-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:SellerSupplierParty/cac:Party" priority="1003"
                 mode="M33">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:SellerSupplierParty/cac:Party"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:PartyIdentification) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(cac:PartyIdentification)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:PartyName) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:PartyName)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyName element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyName) lt 2 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:PartyName) lt 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyName element should be less than 2!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M33"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification"
                 priority="1002"
                 mode="M33">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(empty(cbc:ID))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="not(empty(cbc:ID))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID element should not be empty!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M33"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyName"
                 priority="1001"
                 mode="M33">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(empty(cbc:Name))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="not(empty(cbc:Name))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyName/cbc:Name element should not be empty!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M33"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:Contact"
                 priority="1000"
                 mode="M33">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:Contact"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="matches(cbc:Telephone, '^[-0-9]*$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="matches(cbc:Telephone, '^[-0-9]*$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="matches(cbc:Telefax, '^[-0-9]*$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="matches(cbc:Telefax, '^[-0-9]*$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M33"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M33"/>
   <xsl:template match="@*|node()" priority="-2" mode="M33">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M33"/>
   </xsl:template>

   <!--PATTERN Invoice_SellerSupplierParty_Party_PartyIdentification-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID"
                 priority="1000"
                 mode="M34">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="matches(@schemeAgencyID, '^[A-Z]{2}$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="matches(@schemeAgencyID, '^[A-Z]{2}$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(@schemeAgencyName  = 'KvK') or (@schemeAgencyName  = 'BTW') or (@schemeAgencyName = 'Fi') or (@schemeAgencyName  = 'BSN') or (@schemeAgencyName  = 'OIN') or (@schemeAgencyName  = 'XXX')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(@schemeAgencyName = 'KvK') or (@schemeAgencyName = 'BTW') or (@schemeAgencyName = 'Fi') or (@schemeAgencyName = 'BSN') or (@schemeAgencyName = 'OIN') or (@schemeAgencyName = 'XXX')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Uitgevende organisatie van de PartijIdentificatie MOET ge?dentificeerd worden door een code uit de lijst: KvK, BTW, Fi, BSN, OIN, XXX.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M34"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M34"/>
   <xsl:template match="@*|node()" priority="-2" mode="M34">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M34"/>
   </xsl:template>

   <!--PATTERN Invoice_SellerSupplierParty_Party_PostalAddress-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress"
                 priority="1002"
                 mode="M35">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:Country) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:Country)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:CityName) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:CityName)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:CityName element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:PostalZone) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:PostalZone)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:PostalZone element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M35"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:CityName"
                 priority="1001"
                 mode="M35">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:CityName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:CityName element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M35"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:PostalZone"
                 priority="1000"
                 mode="M35">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:PostalZone"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:PostalZone element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M35"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M35"/>
   <xsl:template match="@*|node()" priority="-2" mode="M35">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M35"/>
   </xsl:template>

   <!--PATTERN Invoice_SellerSupplierParty_Party_PostalAddress_Country-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"
                 priority="1001"
                 mode="M36">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M36"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country"
                 priority="1000"
                 mode="M36">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:IdentificationCode) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:IdentificationCode)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M36"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M36"/>
   <xsl:template match="@*|node()" priority="-2" mode="M36">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M36"/>
   </xsl:template>

   <!--PATTERN Invoice_SellerSupplierParty_Party_PhysicalLocation-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation"
                 priority="1000"
                 mode="M37">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M37"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M37"/>
   <xsl:template match="@*|node()" priority="-2" mode="M37">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M37"/>
   </xsl:template>

   <!--PATTERN Invoice_SellerSupplierParty_Party_PhysicalLocation_Address-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address"
                 priority="1004"
                 mode="M38">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M38"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:StreetName"
                 priority="1003"
                 mode="M38">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:StreetName"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M38"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:BuildingNumber"
                 priority="1002"
                 mode="M38">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:BuildingNumber"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M38"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:CityName"
                 priority="1001"
                 mode="M38">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:CityName"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M38"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:PostalZone"
                 priority="1000"
                 mode="M38">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:PostalZone"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M38"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M38"/>
   <xsl:template match="@*|node()" priority="-2" mode="M38">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M38"/>
   </xsl:template>

   <!--PATTERN Invoice_SellerSupplierParty_Party_PhysicalLocation_Address_Country-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode"
                 priority="1001"
                 mode="M39">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M39"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country"
                 priority="1000"
                 mode="M39">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M39"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M39"/>
   <xsl:template match="@*|node()" priority="-2" mode="M39">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M39"/>
   </xsl:template>

   <!--PATTERN Invoice_SellerSupplierParty_Party_PartyTaxScheme-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID"
                 priority="1001"
                 mode="M40">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M40"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyTaxScheme"
                 priority="1000"
                 mode="M40">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyTaxScheme"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M40"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M40"/>
   <xsl:template match="@*|node()" priority="-2" mode="M40">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M40"/>
   </xsl:template>

   <!--PATTERN Invoice_SellerSupplierParty_Party_Person-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:Person/cbc:FamilyName"
                 priority="1001"
                 mode="M41">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:Person/cbc:FamilyName"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M41"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:Person"
                 priority="1000"
                 mode="M41">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:Person"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M41"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M41"/>
   <xsl:template match="@*|node()" priority="-2" mode="M41">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M41"/>
   </xsl:template>

   <!--PATTERN Invoice_BuyerCustomerParty_Party-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:BuyerCustomerParty/cac:Party" priority="1003"
                 mode="M42">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:PartyIdentification) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(cac:PartyIdentification)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:PartyName) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:PartyName)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyName element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyName) lt 2 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:PartyName) lt 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyName element should be less than 2!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M42"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification"
                 priority="1002"
                 mode="M42">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(empty(cbc:ID))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="not(empty(cbc:ID))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID element should not be empty!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M42"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyName"
                 priority="1001"
                 mode="M42">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(empty(cbc:Name))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="not(empty(cbc:Name))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyName/cbc:Name element should not be empty!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M42"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:Contact"
                 priority="1000"
                 mode="M42">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:Contact"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="matches(cbc:Telephone, '^[-0-9]*$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="matches(cbc:Telephone, '^[-0-9]*$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="matches(cbc:Telefax, '^[-0-9]*$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="matches(cbc:Telefax, '^[-0-9]*$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M42"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M42"/>
   <xsl:template match="@*|node()" priority="-2" mode="M42">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M42"/>
   </xsl:template>

   <!--PATTERN Invoice_BuyerCustomerParty_Party_PartyIdentification-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID"
                 priority="1000"
                 mode="M43">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="matches(@schemeAgencyID, '^[A-Z]{2}$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="matches(@schemeAgencyID, '^[A-Z]{2}$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(@schemeAgencyName  = 'KvK') or (@schemeAgencyName  = 'BTW') or (@schemeAgencyName = 'Fi') or (@schemeAgencyName  = 'BSN') or (@schemeAgencyName  = 'OIN') or (@schemeAgencyName  = 'XXX')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(@schemeAgencyName = 'KvK') or (@schemeAgencyName = 'BTW') or (@schemeAgencyName = 'Fi') or (@schemeAgencyName = 'BSN') or (@schemeAgencyName = 'OIN') or (@schemeAgencyName = 'XXX')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Uitgevende organisatie van de PartijIdentificatie MOET ge?dentificeerd worden door een code uit de lijst: KvK, BTW, Fi, BSN, OIN, XXX.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M43"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M43"/>
   <xsl:template match="@*|node()" priority="-2" mode="M43">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M43"/>
   </xsl:template>

   <!--PATTERN Invoice_BuyerCustomerParty_Party_PostalAddress-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress"
                 priority="1002"
                 mode="M44">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M44"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:CityName"
                 priority="1001"
                 mode="M44">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:CityName"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M44"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:PostalZone"
                 priority="1000"
                 mode="M44">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:PostalZone"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M44"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M44"/>
   <xsl:template match="@*|node()" priority="-2" mode="M44">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M44"/>
   </xsl:template>

   <!--PATTERN Invoice_BuyerCustomerParty_Party_PostalAddress_Country-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"
                 priority="1001"
                 mode="M45">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M45"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country"
                 priority="1000"
                 mode="M45">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M45"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M45"/>
   <xsl:template match="@*|node()" priority="-2" mode="M45">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M45"/>
   </xsl:template>

   <!--PATTERN Invoice_BuyerCustomerParty_Party_PhysicalLocation-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation"
                 priority="1000"
                 mode="M46">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M46"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M46"/>
   <xsl:template match="@*|node()" priority="-2" mode="M46">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M46"/>
   </xsl:template>

   <!--PATTERN Invoice_BuyerCustomerParty_Party_PhysicalLocation_Address-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address"
                 priority="1004"
                 mode="M47">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M47"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:StreetName"
                 priority="1003"
                 mode="M47">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:StreetName"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M47"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:BuildingNumber"
                 priority="1002"
                 mode="M47">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:BuildingNumber"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M47"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:CityName"
                 priority="1001"
                 mode="M47">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:CityName"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M47"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:PostalZone"
                 priority="1000"
                 mode="M47">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:PostalZone"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M47"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M47"/>
   <xsl:template match="@*|node()" priority="-2" mode="M47">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M47"/>
   </xsl:template>

   <!--PATTERN Invoice_BuyerCustomerParty_Party_PhysicalLocation_Address_Country-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode"
                 priority="1001"
                 mode="M48">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M48"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country"
                 priority="1000"
                 mode="M48">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M48"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M48"/>
   <xsl:template match="@*|node()" priority="-2" mode="M48">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M48"/>
   </xsl:template>

   <!--PATTERN Invoice_BuyerCustomerParty_Party_PartyTaxScheme-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID"
                 priority="1001"
                 mode="M49">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M49"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyTaxScheme"
                 priority="1000"
                 mode="M49">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyTaxScheme"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M49"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M49"/>
   <xsl:template match="@*|node()" priority="-2" mode="M49">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M49"/>
   </xsl:template>

   <!--PATTERN Invoice_BuyerCustomerParty_Party_Person-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:Person/cbc:FamilyName"
                 priority="1001"
                 mode="M50">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:Person/cbc:FamilyName"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M50"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:Person"
                 priority="1000"
                 mode="M50">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:Person"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M50"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M50"/>
   <xsl:template match="@*|node()" priority="-2" mode="M50">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M50"/>
   </xsl:template>

   <!--PATTERN Invoice_PaymentMeans_PayeeFinancialAccount-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:ID"
                 priority="1001"
                 mode="M51">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:ID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:ID element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M51"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount" priority="1000"
                 mode="M51">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:ID) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:ID)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:ID element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M51"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M51"/>
   <xsl:template match="@*|node()" priority="-2" mode="M51">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M51"/>
   </xsl:template>

   <!--PATTERN Invoice_PaymentMeans_PayeeFinancialAccount_FinancialInstitutionBranch-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch"
                 priority="1000"
                 mode="M52">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:FinancialInstitution) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(cac:FinancialInstitution)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M52"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M52"/>
   <xsl:template match="@*|node()" priority="-2" mode="M52">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M52"/>
   </xsl:template>

   <!--PATTERN Invoice_PaymentMeans_PayeeFinancialAccount_FinancialInstitutionBranch_FinancialInstitution-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID"
                 priority="1001"
                 mode="M53">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M53"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution"
                 priority="1000"
                 mode="M53">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:ID) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:ID)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M53"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M53"/>
   <xsl:template match="@*|node()" priority="-2" mode="M53">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M53"/>
   </xsl:template>

   <!--PATTERN Invoice_PaymentTerms-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:PaymentTerms" priority="1000" mode="M54">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:PaymentTerms"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:Note) lt 2 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:Note) lt 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:PaymentTerms/cbc:Note element should be less than 2!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M54"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M54"/>
   <xsl:template match="@*|node()" priority="-2" mode="M54">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M54"/>
   </xsl:template>

   <!--PATTERN Invoice_PaymentTerms_SettlementPeriod-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:PaymentTerms/cac:SettlementPeriod/cbc:DurationMeasure"
                 priority="1001"
                 mode="M55">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:PaymentTerms/cac:SettlementPeriod/cbc:DurationMeasure"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(@unitCode) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(@unitCode) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:PaymentTerms/cac:SettlementPeriod/cbc:DurationMeasure/@unitCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(@unitCode)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(@unitCode)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:PaymentTerms/cac:SettlementPeriod/cbc:DurationMeasure/@unitCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M55"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:PaymentTerms/cac:SettlementPeriod" priority="1000"
                 mode="M55">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:PaymentTerms/cac:SettlementPeriod"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:Description) lt 2 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:Description) lt 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:PaymentTerms/cac:SettlementPeriod/cbc:Description element should be less than 2!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M55"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M55"/>
   <xsl:template match="@*|node()" priority="-2" mode="M55">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M55"/>
   </xsl:template>

   <!--PATTERN Invoice_PaymentTerms_PenaltyPeriod-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:PaymentTerms/cac:PenaltyPeriod/cbc:EndDate"
                 priority="1001"
                 mode="M56">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:PaymentTerms/cac:PenaltyPeriod/cbc:EndDate"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:PaymentTerms/cac:PenaltyPeriod/cbc:EndDate element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M56"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:PaymentTerms/cac:PenaltyPeriod" priority="1000"
                 mode="M56">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:PaymentTerms/cac:PenaltyPeriod"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:EndDate) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:EndDate)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:PaymentTerms/cac:PenaltyPeriod/cbc:EndDate element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M56"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M56"/>
   <xsl:template match="@*|node()" priority="-2" mode="M56">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M56"/>
   </xsl:template>

   <!--PATTERN Invoice_TaxTotal-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:TaxTotal" priority="1000" mode="M57">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/doc:Invoice/cac:TaxTotal"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:TaxSubtotal) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:TaxSubtotal)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:TaxTotal/cac:TaxSubtotal element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M57"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M57"/>
   <xsl:template match="@*|node()" priority="-2" mode="M57">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M57"/>
   </xsl:template>

   <!--PATTERN Invoice_TaxTotal_TaxSubtotal-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:TaxTotal/cac:TaxSubtotal/cbc:TaxableAmount"
                 priority="1001"
                 mode="M58">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:TaxTotal/cac:TaxSubtotal/cbc:TaxableAmount"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:TaxTotal/cac:TaxSubtotal/cbc:TaxableAmount element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M58"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:TaxTotal/cac:TaxSubtotal" priority="1000" mode="M58">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:TaxTotal/cac:TaxSubtotal"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:TaxableAmount) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:TaxableAmount)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:TaxTotal/cac:TaxSubtotal/cbc:TaxableAmount element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M58"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M58"/>
   <xsl:template match="@*|node()" priority="-2" mode="M58">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M58"/>
   </xsl:template>

   <!--PATTERN Invoice_LegalMonetaryTotal-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:LegalMonetaryTotal/cbc:LineExtensionAmount"
                 priority="1003"
                 mode="M59">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:LegalMonetaryTotal/cbc:LineExtensionAmount"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:LegalMonetaryTotal/cbc:LineExtensionAmount element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M59"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:LegalMonetaryTotal/cbc:TaxExclusiveAmount"
                 priority="1002"
                 mode="M59">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:LegalMonetaryTotal/cbc:TaxExclusiveAmount"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:LegalMonetaryTotal/cbc:TaxExclusiveAmount element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M59"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount"
                 priority="1001"
                 mode="M59">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M59"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:LegalMonetaryTotal" priority="1000" mode="M59">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:LegalMonetaryTotal"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:LineExtensionAmount) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(cbc:LineExtensionAmount)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:LegalMonetaryTotal/cbc:LineExtensionAmount element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:TaxExclusiveAmount) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:TaxExclusiveAmount)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:LegalMonetaryTotal/cbc:TaxExclusiveAmount element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:TaxInclusiveAmount) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:TaxInclusiveAmount)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M59"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M59"/>
   <xsl:template match="@*|node()" priority="-2" mode="M59">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M59"/>
   </xsl:template>

   <!--PATTERN Invoice_InvoiceLine-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:InvoiceLine" priority="1003" mode="M60">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:InvoiceLine"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:OrderLineReference) lt 2 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cac:OrderLineReference) lt 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:InvoiceLine/cac:OrderLineReference element should be less than 2!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:Price) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:Price)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:InvoiceLine/cac:Price element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:InvoicedQuantity) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:InvoicedQuantity)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:InvoiceLine/cbc:InvoicedQuantity element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:FreeOfChargeIndicator) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(cbc:FreeOfChargeIndicator)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:InvoiceLine/cbc:FreeOfChargeIndicator element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:TaxTotal) lt 2 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:TaxTotal) lt 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:InvoiceLine/cac:TaxTotal element should be less than 2!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M60"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:InvoiceLine/cbc:InvoicedQuantity" priority="1002"
                 mode="M60">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:InvoiceLine/cbc:InvoicedQuantity"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:InvoiceLine/cbc:InvoicedQuantity element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(@unitCode) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(@unitCode) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:InvoiceLine/cbc:InvoicedQuantity/@unitCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M60"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:InvoiceLine/cbc:FreeOfChargeIndicator" priority="1001"
                 mode="M60">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:InvoiceLine/cbc:FreeOfChargeIndicator"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:InvoiceLine/cbc:FreeOfChargeIndicator element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M60"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:InvoiceLine/cac:Item" priority="1000" mode="M60">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:InvoiceLine/cac:Item"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(  (count(cbc:Description) = 0) and  (    (count(cac:BuyersItemIdentification/cbc:ID) + count(cac:SellersItemIdentification/cbc:ID) + count(cac:ManufacturersItemIdentification/cbc:ID) + count(cac:StandardItemIdentification/cbc:ID) + count(cac:CatalogueItemIdentification/cbc:ID)) &gt; 0  ) ) or (  (count(cbc:Description) &gt; 0) and  (    (count(cac:BuyersItemIdentification/cbc:ID) + count(cac:SellersItemIdentification/cbc:ID) + count(cac:ManufacturersItemIdentification/cbc:ID) + count(cac:StandardItemIdentification/cbc:ID) + count(cac:CatalogueItemIdentification/cbc:ID)) = 0  ) )"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="( (count(cbc:Description) = 0) and ( (count(cac:BuyersItemIdentification/cbc:ID) + count(cac:SellersItemIdentification/cbc:ID) + count(cac:ManufacturersItemIdentification/cbc:ID) + count(cac:StandardItemIdentification/cbc:ID) + count(cac:CatalogueItemIdentification/cbc:ID)) &gt; 0 ) ) or ( (count(cbc:Description) &gt; 0) and ( (count(cac:BuyersItemIdentification/cbc:ID) + count(cac:SellersItemIdentification/cbc:ID) + count(cac:ManufacturersItemIdentification/cbc:ID) + count(cac:StandardItemIdentification/cbc:ID) + count(cac:CatalogueItemIdentification/cbc:ID)) = 0 ) )">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Item MOET OF een Description OF een (party)Identification/ID bevatten.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M60"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M60"/>
   <xsl:template match="@*|node()" priority="-2" mode="M60">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M60"/>
   </xsl:template>

   <!--PATTERN Invoice_Delivery-->


	<!--RULE -->
<xsl:template match="/doc:Invoice" priority="1000" mode="M61">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/doc:Invoice"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(  (count(cac:Delivery/cbc:ActualDeliveryDate) = 0) and  (    (count(cac:InvoiceLine/cac:Delivery/cbc:ActualDeliveryDate) ) &gt; 0  ) ) or (  (count(cac:Delivery/cbc:ActualDeliveryDate) &gt; 0) and  (    (count(cac:InvoiceLine/cac:Delivery/cbc:ActualDeliveryDate) ) = 0  ) ) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="( (count(cac:Delivery/cbc:ActualDeliveryDate) = 0) and ( (count(cac:InvoiceLine/cac:Delivery/cbc:ActualDeliveryDate) ) &gt; 0 ) ) or ( (count(cac:Delivery/cbc:ActualDeliveryDate) &gt; 0) and ( (count(cac:InvoiceLine/cac:Delivery/cbc:ActualDeliveryDate) ) = 0 ) )">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Bericht MOET OF een ActualDeliveryDate op documentniveau OF op regelniveau bevatten.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M61"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M61"/>
   <xsl:template match="@*|node()" priority="-2" mode="M61">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M61"/>
   </xsl:template>

   <!--PATTERN Invoice_InvoiceLine_OrderLineReference-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:InvoiceLine/cac:OrderLineReference/cbc:LineID"
                 priority="1001"
                 mode="M62">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:InvoiceLine/cac:OrderLineReference/cbc:LineID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:InvoiceLine/cac:OrderLineReference/cbc:LineID element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M62"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:InvoiceLine/cac:OrderLineReference" priority="1000"
                 mode="M62">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:InvoiceLine/cac:OrderLineReference"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:OrderReference) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:OrderReference)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:InvoiceLine/cac:OrderLineReference/cac:OrderReference element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:LineID) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:LineID)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:InvoiceLine/cac:OrderLineReference/cbc:LineID element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M62"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M62"/>
   <xsl:template match="@*|node()" priority="-2" mode="M62">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M62"/>
   </xsl:template>

   <!--PATTERN Invoice_InvoiceLine_AllowanceCharge-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:InvoiceLine/cac:AllowanceCharge/cbc:BaseAmount"
                 priority="1001"
                 mode="M63">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:InvoiceLine/cac:AllowanceCharge/cbc:BaseAmount"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M63"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:InvoiceLine/cac:AllowanceCharge" priority="1000"
                 mode="M63">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:InvoiceLine/cac:AllowanceCharge"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M63"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M63"/>
   <xsl:template match="@*|node()" priority="-2" mode="M63">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M63"/>
   </xsl:template>

   <!--PATTERN Invoice_InvoiceLine_TaxTotal-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:InvoiceLine/cac:TaxTotal" priority="1000" mode="M64">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:InvoiceLine/cac:TaxTotal"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:TaxSubtotal) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:TaxSubtotal)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M64"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M64"/>
   <xsl:template match="@*|node()" priority="-2" mode="M64">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M64"/>
   </xsl:template>

   <!--PATTERN Invoice_InvoiceLine_TaxTotal_TaxSubtotal-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cbc:TaxableAmount"
                 priority="1001"
                 mode="M65">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cbc:TaxableAmount"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cbc:TaxableAmount element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M65"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal"
                 priority="1000"
                 mode="M65">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:TaxableAmount) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:TaxableAmount)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cbc:TaxableAmount element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M65"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M65"/>
   <xsl:template match="@*|node()" priority="-2" mode="M65">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M65"/>
   </xsl:template>

   <!--PATTERN Invoice_InvoiceLine_Item-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:InvoiceLine/cac:Item" priority="1002" mode="M66">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:InvoiceLine/cac:Item"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:Description) lt 2 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:Description) lt 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:InvoiceLine/cac:Item/cbc:Description element should be less than 2!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:CatalogueIndicator) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:CatalogueIndicator)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:InvoiceLine/cac:Item/cbc:CatalogueIndicator element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:Name) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:Name)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:InvoiceLine/cac:Item/cbc:Name element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M66"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:InvoiceLine/cac:Item/cbc:CatalogueIndicator"
                 priority="1001"
                 mode="M66">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:InvoiceLine/cac:Item/cbc:CatalogueIndicator"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:InvoiceLine/cac:Item/cbc:CatalogueIndicator element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M66"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:InvoiceLine/cac:Item/cbc:Name" priority="1000"
                 mode="M66">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:InvoiceLine/cac:Item/cbc:Name"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:InvoiceLine/cac:Item/cbc:Name element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M66"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M66"/>
   <xsl:template match="@*|node()" priority="-2" mode="M66">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M66"/>
   </xsl:template>

   <!--PATTERN Invoice_InvoiceLine_Price-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:InvoiceLine/cac:Price/cbc:BaseQuantity" priority="1002"
                 mode="M67">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:InvoiceLine/cac:Price/cbc:BaseQuantity"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:InvoiceLine/cac:Price/cbc:BaseQuantity element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(@unitCode) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(@unitCode) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:InvoiceLine/cac:Price/cbc:BaseQuantity/@unitCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M67"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:InvoiceLine/cac:Price/cbc:PriceAmount" priority="1001"
                 mode="M67">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:InvoiceLine/cac:Price/cbc:PriceAmount"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(count(../../../cbc:PricingCurrencyCode) = 0) or (  (count(../../../cbc:PricingCurrencyCode) &gt; 0) and  (@currencyID = ../../../cbc:PricingCurrencyCode/text()) )"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(../../../cbc:PricingCurrencyCode) = 0) or ( (count(../../../cbc:PricingCurrencyCode) &gt; 0) and (@currencyID = ../../../cbc:PricingCurrencyCode/text()) )">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Valutacode op regelniveau MOET gelijk zijn aan algemeen niveau als opgegeven.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(empty(@currencyID))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="not(empty(@currencyID))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:InvoiceLine/cac:Price/cbc:PriceAmount/@currencyID element should not be empty!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M67"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:InvoiceLine/cac:Price" priority="1000" mode="M67">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:InvoiceLine/cac:Price"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:BaseQuantity) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:BaseQuantity)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:InvoiceLine/cac:Price/cbc:BaseQuantity element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M67"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M67"/>
   <xsl:template match="@*|node()" priority="-2" mode="M67">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M67"/>
   </xsl:template>

   <!--PATTERN Invoice_TaxTotal_TaxSubtotal_TaxCategory_TaxScheme-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:Name"
                 priority="1001"
                 mode="M68">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:Name"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M68"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme"
                 priority="1000"
                 mode="M68">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(cbc:Name = 'BTW') or (cbc:Name = 'Accijns') or (cbc:Name = 'Toeslag') or (cbc:Name = 'Overige')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(cbc:Name = 'BTW') or (cbc:Name = 'Accijns') or (cbc:Name = 'Toeslag') or (cbc:Name = 'Overige')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  De soort belasting/heffing MOET ge?dentificeerd worden met een code uit de lijst: BTW, Accijns, Toeslag, Overige.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M68"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M68"/>
   <xsl:template match="@*|node()" priority="-2" mode="M68">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M68"/>
   </xsl:template>

   <!--PATTERN Invoice_InvoiceLine_Item_ClassifiedTaxCategory_TaxScheme-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme/cbc:Name"
                 priority="1001"
                 mode="M69">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme/cbc:Name"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M69"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme"
                 priority="1000"
                 mode="M69">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M69"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M69"/>
   <xsl:template match="@*|node()" priority="-2" mode="M69">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M69"/>
   </xsl:template>

   <!--PATTERN Invoice_InvoiceLine_TaxTotal_TaxSubtotal_TaxCategory_TaxScheme-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:Name"
                 priority="1001"
                 mode="M70">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:Name"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M70"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme"
                 priority="1000"
                 mode="M70">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test=" (cbc:Name = 'BTW') or (cbc:Name = 'Accijns') or (cbc:Name = 'Toeslag') or (cbc:Name = 'Overige')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(cbc:Name = 'BTW') or (cbc:Name = 'Accijns') or (cbc:Name = 'Toeslag') or (cbc:Name = 'Overige')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  De soort belasting/heffing MOET ge?dentificeerd worden met een code uit de lijst: BTW, Accijns, Toeslag, Overige.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M70"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M70"/>
   <xsl:template match="@*|node()" priority="-2" mode="M70">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M70"/>
   </xsl:template>

   <!--PATTERN Invoice_PaymentMeans-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:PaymentMeans/cbc:PaymentMeansCode" priority="1000"
                 mode="M71">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:PaymentMeans/cbc:PaymentMeansCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:PaymentMeans/cbc:PaymentMeansCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M71"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M71"/>
   <xsl:template match="@*|node()" priority="-2" mode="M71">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M71"/>
   </xsl:template>

   <!--PATTERN Invoice_BuyerCustomerParty-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:BuyerCustomerParty" priority="1001" mode="M72">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:BuyerCustomerParty"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:Party) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:Party)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Element MOET worden opgenomen, bevat verplichte bedrijfsidentificatienummer, bedrijfsnaam en opdrachtgever.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M72"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:BuyerCustomerParty/cac:Party" priority="1000"
                 mode="M72">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyIdentification) lt 3"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cac:PartyIdentification) lt 3">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification element should be less than 3!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M72"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M72"/>
   <xsl:template match="@*|node()" priority="-2" mode="M72">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M72"/>
   </xsl:template>

   <!--PATTERN Invoice_BuyerCustomerParty_Party_Contact-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:Contact/cbc:Name"
                 priority="1001"
                 mode="M73">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:Contact/cbc:Name"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:Contact/cbc:Name element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M73"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:Contact"
                 priority="1000"
                 mode="M73">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:Contact"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:Name) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:Name)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:Contact/cbc:Name element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M73"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M73"/>
   <xsl:template match="@*|node()" priority="-2" mode="M73">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M73"/>
   </xsl:template>

   <!--PATTERN Invoice_Delivery_DeliveryAddress-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:Delivery/cac:DeliveryAddress" priority="1000"
                 mode="M74">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:Delivery/cac:DeliveryAddress"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:Country) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:Country)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M74"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M74"/>
   <xsl:template match="@*|node()" priority="-2" mode="M74">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M74"/>
   </xsl:template>

   <!--PATTERN Invoice_Delivery_DeliveryAddress_Country-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode"
                 priority="1001"
                 mode="M75">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M75"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country"
                 priority="1000"
                 mode="M75">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:IdentificationCode) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:IdentificationCode)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M75"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M75"/>
   <xsl:template match="@*|node()" priority="-2" mode="M75">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M75"/>
   </xsl:template>

   <!--PATTERN Invoice_PaymentMeans_PayeeFinancialAccount_FinancialInstitutionBranch_Address-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address"
                 priority="1000"
                 mode="M76">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:Country) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:Country)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M76"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M76"/>
   <xsl:template match="@*|node()" priority="-2" mode="M76">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M76"/>
   </xsl:template>

   <!--PATTERN Invoice_PaymentMeans_PayeeFinancialAccount_FinancialInstitutionBranch_Address_Country-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode"
                 priority="1001"
                 mode="M77">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M77"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country"
                 priority="1000"
                 mode="M77">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:IdentificationCode) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:IdentificationCode)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M77"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M77"/>
   <xsl:template match="@*|node()" priority="-2" mode="M77">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M77"/>
   </xsl:template>

   <!--PATTERN Invoice_SellerSupplierParty_Party_Contact-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name"
                 priority="1001"
                 mode="M78">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M78"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:Contact"
                 priority="1000"
                 mode="M78">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:Contact"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:Name) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:Name)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M78"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M78"/>
   <xsl:template match="@*|node()" priority="-2" mode="M78">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M78"/>
   </xsl:template>

   <!--PATTERN Invoice_DeliveryTerms-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:DeliveryTerms/cbc:ID" priority="1001" mode="M79">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:DeliveryTerms/cbc:ID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:DeliveryTerms/cbc:ID element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="normalize-space (@schemeID ) = 'NL-1002' "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="normalize-space (@schemeID ) = 'NL-1002'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Inhoud MOET verwijzen naar: NL-1002</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="normalize-space (@schemeAgencyID) = xs:string(88)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="normalize-space (@schemeAgencyID) = xs:string(88)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Inhoud MOET verwijzen naar: 88</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="normalize-space (@schemeAgencyName)  = 'Logius Gegevensbeheer NL-Overheid'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="normalize-space (@schemeAgencyName) = 'Logius Gegevensbeheer NL-Overheid'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Inhoud MOET verwijzen naar: Logius Gegevensbeheer NL-Overheid</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="normalize-space (@schemeDataURI)  = 'urn:digi-inkoop:ubl:2.0:NL:1.6:gc:DeliveryTermsCode'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="normalize-space (@schemeDataURI) = 'urn:digi-inkoop:ubl:2.0:NL:1.6:gc:DeliveryTermsCode'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Inhoud MOET verwijzen naar: urn:digi-inkoop:ubl:2.0:NL:1.6:gc:DeliveryTermsCode</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="normalize-space(@schemeURI ) = 'http://www.nltaxonomie.nl/ubl/2.0/NL/1.6/cl/gc/DeliveryTermsCode.gc' "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="normalize-space(@schemeURI ) = 'http://www.nltaxonomie.nl/ubl/2.0/NL/1.6/cl/gc/DeliveryTermsCode.gc'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Inhoud MOET verwijzen naar: http://www.nltaxonomie.nl/ubl/2.0/NL/1.6/cl/gc/DeliveryTermsCode.gc</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="normalize-space (@schemeName) = 'DeliveryTermsCode' "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="normalize-space (@schemeName) = 'DeliveryTermsCode'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Inhoud MOET verwijzen naar: DeliveryTermsCode</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="normalize-space (@schemeVersionID) = xs:string(1.6)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="normalize-space (@schemeVersionID) = xs:string(1.6)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Inhoud MOET verwijzen naar: 1.6</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M79"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:DeliveryTerms" priority="1000" mode="M79">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:DeliveryTerms"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:ID) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:ID)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:DeliveryTerms/cbc:ID element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M79"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M79"/>
   <xsl:template match="@*|node()" priority="-2" mode="M79">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M79"/>
   </xsl:template>

   <!--PATTERN Invoice_SellerSupplierParty-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:SellerSupplierParty/cac:Party" priority="1000"
                 mode="M80">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:SellerSupplierParty/cac:Party"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyIdentification) lt 3"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cac:PartyIdentification) lt 3">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification element should be less than 3!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M80"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M80"/>
   <xsl:template match="@*|node()" priority="-2" mode="M80">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M80"/>
   </xsl:template>

   <!--PATTERN Invoice_PaymentMeans_PayeeFinancialAccount_Country-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode"
                 priority="1001"
                 mode="M81">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M81"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country"
                 priority="1000"
                 mode="M81">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:IdentificationCode) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:IdentificationCode)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M81"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M81"/>
   <xsl:template match="@*|node()" priority="-2" mode="M81">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M81"/>
   </xsl:template>

   <!--PATTERN Invoice_AccountingSupplierParty_Party_PartyIdentification-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID"
                 priority="1000"
                 mode="M82">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(@schemeAgencyName  = 'KvK') or (@schemeAgencyName  = 'BTW') or (@schemeAgencyName = 'Fi') or (@schemeAgencyName  = 'BSN') or (@schemeAgencyName  = 'OIN') or (@schemeAgencyName  = 'XXX')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(@schemeAgencyName = 'KvK') or (@schemeAgencyName = 'BTW') or (@schemeAgencyName = 'Fi') or (@schemeAgencyName = 'BSN') or (@schemeAgencyName = 'OIN') or (@schemeAgencyName = 'XXX')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Uitgevende organisatie van de PartijIdentificatie MOET ge?dentificeerd worden door een code uit de lijst: KvK, BTW, Fi, BSN, OIN, XXX.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="matches(@schemeAgencyID, '^[A-Z]{2}$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="matches(@schemeAgencyID, '^[A-Z]{2}$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M82"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M82"/>
   <xsl:template match="@*|node()" priority="-2" mode="M82">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M82"/>
   </xsl:template>

   <!--PATTERN Invoice_InvoiceLine_Item_ClassifiedTaxCategory-->


	<!--RULE -->
<xsl:template match="/doc:Invoice/cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme"
                 priority="1000"
                 mode="M83">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:Invoice/cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(cbc:Name = 'BTW') or (cbc:Name = 'Accijns') or (cbc:Name = 'Toeslag') or (cbc:Name = 'Overige')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(cbc:Name = 'BTW') or (cbc:Name = 'Accijns') or (cbc:Name = 'Toeslag') or (cbc:Name = 'Overige')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  De soort belasting/heffing MOET ge?dentificeerd worden met een code uit de lijst: BTW, Accijns, Toeslag, Overige.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M83"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M83"/>
   <xsl:template match="@*|node()" priority="-2" mode="M83">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M83"/>
   </xsl:template>
</xsl:stylesheet>