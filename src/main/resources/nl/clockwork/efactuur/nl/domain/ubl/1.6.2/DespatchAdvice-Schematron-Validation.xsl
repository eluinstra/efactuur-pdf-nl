<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:schold="http://www.ascc.net/xml/schematron"
                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
                xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
                xmlns:qdt="urn:oasis:names:specification:ubl:schema:xsd:QualifiedDataTypes-2"
                xmlns:ccts="urn:oasis:names:specification:ubl:schema:xsd:CoreComponentParameters-2"
                xmlns:doc="urn:oasis:names:specification:ubl:schema:xsd:DespatchAdvice-2"
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
         <svrl:ns-prefix-in-attribute-values uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
                                             prefix="cbc"/>
         <svrl:ns-prefix-in-attribute-values uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
                                             prefix="cac"/>
         <svrl:ns-prefix-in-attribute-values uri="urn:oasis:names:specification:ubl:schema:xsd:QualifiedDataTypes-2"
                                             prefix="qdt"/>
         <svrl:ns-prefix-in-attribute-values uri="urn:oasis:names:specification:ubl:schema:xsd:CoreComponentParameters-2"
                                             prefix="ccts"/>
         <svrl:ns-prefix-in-attribute-values uri="urn:oasis:names:specification:ubl:schema:xsd:DespatchAdvice-2"
                                             prefix="doc"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">DespatchAdvice</xsl:attribute>
            <xsl:attribute name="name">DespatchAdvice</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M5"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">DespatchAdvice_Shipment</xsl:attribute>
            <xsl:attribute name="name">DespatchAdvice_Shipment</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M6"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">DespatchAdvice_Shipment_Delivery</xsl:attribute>
            <xsl:attribute name="name">DespatchAdvice_Shipment_Delivery</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M7"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">DespatchAdvice_Shipment_Delivery_Despatch</xsl:attribute>
            <xsl:attribute name="name">DespatchAdvice_Shipment_Delivery_Despatch</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M8"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">DespatchAdvice_Shipment_Delivery_Despatch_DespatchAddress</xsl:attribute>
            <xsl:attribute name="name">DespatchAdvice_Shipment_Delivery_Despatch_DespatchAddress</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M9"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">DespatchAdvice_Shipment_Delivery_Despatch_DespatchAddress_Country</xsl:attribute>
            <xsl:attribute name="name">DespatchAdvice_Shipment_Delivery_Despatch_DespatchAddress_Country</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M10"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">DespatchAdvice_DespatchLine_Item</xsl:attribute>
            <xsl:attribute name="name">DespatchAdvice_DespatchLine_Item</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M11"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">DespatchAdvice_DespatchLine</xsl:attribute>
            <xsl:attribute name="name">DespatchAdvice_DespatchLine</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M12"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">DespatchAdvice_DespatchLine_OrderLineReference</xsl:attribute>
            <xsl:attribute name="name">DespatchAdvice_DespatchLine_OrderLineReference</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M13"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">DespatchAdvice_SellerSupplierParty_Party</xsl:attribute>
            <xsl:attribute name="name">DespatchAdvice_SellerSupplierParty_Party</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M14"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">DespatchAdvice_DeliveryCustomerParty_Party</xsl:attribute>
            <xsl:attribute name="name">DespatchAdvice_DeliveryCustomerParty_Party</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M15"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">DespatchAdvice_DespatchSupplierParty_Party</xsl:attribute>
            <xsl:attribute name="name">DespatchAdvice_DespatchSupplierParty_Party</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M16"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">DespatchAdvice_DeliveryCustomerParty_Party_Contact</xsl:attribute>
            <xsl:attribute name="name">DespatchAdvice_DeliveryCustomerParty_Party_Contact</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M17"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">DespatchAdvice_SellerSupplierParty_Party_Contact</xsl:attribute>
            <xsl:attribute name="name">DespatchAdvice_SellerSupplierParty_Party_Contact</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M18"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">DespatchAdvice_DespatchSupplierParty_Party_Contact</xsl:attribute>
            <xsl:attribute name="name">DespatchAdvice_DespatchSupplierParty_Party_Contact</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M19"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">DespatchAdvice_DespatchSupplierParty_Party_PartyIdentification</xsl:attribute>
            <xsl:attribute name="name">DespatchAdvice_DespatchSupplierParty_Party_PartyIdentification</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M20"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">DespatchAdvice_DespatchSupplierParty_Party_PartyIdentification</xsl:attribute>
            <xsl:attribute name="name">DespatchAdvice_DespatchSupplierParty_Party_PartyIdentification</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M21"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">DespatchAdvice_AdditionalDocumentReference_Attachment</xsl:attribute>
            <xsl:attribute name="name">DespatchAdvice_AdditionalDocumentReference_Attachment</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M22"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">DespatchAdvice_DeliveryCustomerParty_Party_PartyIdentification</xsl:attribute>
            <xsl:attribute name="name">DespatchAdvice_DeliveryCustomerParty_Party_PartyIdentification</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M23"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">DespatchAdvice_DeliveryCustomerParty_Party_PartyIdentification</xsl:attribute>
            <xsl:attribute name="name">DespatchAdvice_DeliveryCustomerParty_Party_PartyIdentification</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M24"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">DespatchAdvice_Shipment_Delivery_DeliveryAddress_Country</xsl:attribute>
            <xsl:attribute name="name">DespatchAdvice_Shipment_Delivery_DeliveryAddress_Country</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M25"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">DespatchAdvice_DespatchSupplierParty</xsl:attribute>
            <xsl:attribute name="name">DespatchAdvice_DespatchSupplierParty</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M26"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">DespatchAdvice_DeliveryCustomerParty</xsl:attribute>
            <xsl:attribute name="name">DespatchAdvice_DeliveryCustomerParty</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M27"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">DespatchAdvice_DeliveryCustomerParty</xsl:attribute>
            <xsl:attribute name="name">DespatchAdvice_DeliveryCustomerParty</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M28"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">DespatchAdvice_DeliveryCustomerParty</xsl:attribute>
            <xsl:attribute name="name">DespatchAdvice_DeliveryCustomerParty</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M29"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">DespatchAdvice_SellerSupplierParty</xsl:attribute>
            <xsl:attribute name="name">DespatchAdvice_SellerSupplierParty</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M30"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">DespatchAdvice_SellerSupplierParty_Party_PartyName</xsl:attribute>
            <xsl:attribute name="name">DespatchAdvice_SellerSupplierParty_Party_PartyName</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M31"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">DespatchAdvice_Shipment_Delivery_DeliveryAddress</xsl:attribute>
            <xsl:attribute name="name">DespatchAdvice_Shipment_Delivery_DeliveryAddress</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M32"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">DespatchAdvice_SellerSupplierParty_Party_PartyIdentification</xsl:attribute>
            <xsl:attribute name="name">DespatchAdvice_SellerSupplierParty_Party_PartyIdentification</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M33"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">DespatchAdvice_SellerSupplierParty_Party_PartyIdentification</xsl:attribute>
            <xsl:attribute name="name">DespatchAdvice_SellerSupplierParty_Party_PartyIdentification</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M34"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">DespatchAdvice_DeliveryCustomerParty_Party_PartyName</xsl:attribute>
            <xsl:attribute name="name">DespatchAdvice_DeliveryCustomerParty_Party_PartyName</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M35"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">DespatchAdvice_DespatchSupplierParty_Party_PartyName</xsl:attribute>
            <xsl:attribute name="name">DespatchAdvice_DespatchSupplierParty_Party_PartyName</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M36"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">DespatchAdvice_Shipment_Consignment</xsl:attribute>
            <xsl:attribute name="name">DespatchAdvice_Shipment_Consignment</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M37"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">DespatchAdvice_Shipment_Delivery_RequestedDeliveryPeriod</xsl:attribute>
            <xsl:attribute name="name">DespatchAdvice_Shipment_Delivery_RequestedDeliveryPeriod</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M38"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">DespatchAdvice_Shipment_Delivery_DeliveryParty</xsl:attribute>
            <xsl:attribute name="name">DespatchAdvice_Shipment_Delivery_DeliveryParty</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M39"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">DespatchAdvice_Shipment_Delivery_DeliveryParty_PartyName</xsl:attribute>
            <xsl:attribute name="name">DespatchAdvice_Shipment_Delivery_DeliveryParty_PartyName</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M40"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">DespatchAdvice_DespatchLine_OrderLineReference_OrderReference</xsl:attribute>
            <xsl:attribute name="name">DespatchAdvice_DespatchLine_OrderLineReference_OrderReference</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M41"/>
      </svrl:schematron-output>
   </xsl:template>

   <!--SCHEMATRON PATTERNS-->


<!--PATTERN DespatchAdvice-->


	<!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cbc:UBLVersionID" priority="1007" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cbc:UBLVersionID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="normalize-space(text()) = '2.0'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="normalize-space(text()) = '2.0'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Het bericht MOET gebaseerd zijn op UBL Versie 2.0</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice" priority="1006" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/doc:DespatchAdvice"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:Shipment) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:Shipment)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:Shipment element should exist!</svrl:text>
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
               <svrl:text>/doc:DespatchAdvice/cbc:ID element should not be empty!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:SellerSupplierParty) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(cac:SellerSupplierParty)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:SellerSupplierParty element should exist!</svrl:text>
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
               <svrl:text>Huisnummer en Huisnummertoevoeging moeten achter elkaar geplaatst worden, gescheiden met een koppelteken.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="every $id in //cac:PartyIdentification/cbc:ID satisfies (exists($id/@schemeAgencyID) and not(empty($id/@schemeAgencyID)) and exists($id/@schemeAgencyName) and not(empty($id/@schemeAgencyName))) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="every $id in //cac:PartyIdentification/cbc:ID satisfies (exists($id/@schemeAgencyID) and not(empty($id/@schemeAgencyID)) and exists($id/@schemeAgencyName) and not(empty($id/@schemeAgencyName)))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>PartyIdentification/ID MOET @schemeAgencyID en @schemeAgencyName attributen bevatten.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:Note) lt 2 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:Note) lt 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cbc:Note element should be less than 2!</svrl:text>
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
               <svrl:text>/doc:DespatchAdvice/cbc:UBLVersionID element should exist!</svrl:text>
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
               <svrl:text>/doc:DespatchAdvice/cbc:CustomizationID element should exist!</svrl:text>
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
               <svrl:text>/doc:DespatchAdvice/cbc:ProfileID element should exist!</svrl:text>
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
               <svrl:text>PostalAddress MOET OF een Postbox bevatten OF minimaal 1 van de elementen StreetName, BuildingNumber, Room, Floor, Department, InhouseMail of PlotIdentification. Beide MAG NIET.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cbc:CustomizationID" priority="1005" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cbc:CustomizationID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="normalize-space(text()) = '1.6'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="normalize-space(text()) = '1.6'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Bericht MOET gebaseerd zijn op versie 1.6 van de Nederlandse specificatie.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cbc:ProfileID" priority="1004" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cbc:ProfileID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="normalize-space(text()) = 'NL'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="normalize-space(text()) = 'NL'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Bericht MOET gebaseerd zijn op de Nederlande (NL) specificatie</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DeliveryCustomerParty" priority="1003" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DeliveryCustomerParty"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:Party)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:Party)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DespatchSupplierParty" priority="1002" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DespatchSupplierParty"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:Party)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:Party)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cbc:ID" priority="1001" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/doc:DespatchAdvice/cbc:ID"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cbc:Note" priority="1000" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cbc:Note"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M5"/>
   <xsl:template match="@*|node()" priority="-2" mode="M5">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

   <!--PATTERN DespatchAdvice_Shipment-->


	<!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:Shipment" priority="1001" mode="M6">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:Shipment"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:Delivery) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:Delivery)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:Shipment/cac:Delivery element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:DeliveryInstructions) lt 2 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cbc:DeliveryInstructions) lt 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:Shipment/cbc:DeliveryInstructions element should be less than 2!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:Shipment/cbc:ID" priority="1000" mode="M6">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:Shipment/cbc:ID"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M6"/>
   <xsl:template match="@*|node()" priority="-2" mode="M6">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>

   <!--PATTERN DespatchAdvice_Shipment_Delivery-->


	<!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:Shipment/cac:Delivery" priority="1001" mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:RequestedDeliveryPeriod) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(cac:RequestedDeliveryPeriod)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:RequestedDeliveryPeriod element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:Despatch) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:Despatch)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:DeliveryAddress) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:DeliveryAddress)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cbc:TrackingID"
                 priority="1000"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cbc:TrackingID"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M7"/>
   <xsl:template match="@*|node()" priority="-2" mode="M7">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

   <!--PATTERN DespatchAdvice_Shipment_Delivery_Despatch-->


	<!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch"
                 priority="1000"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:DespatchAddress) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:DespatchAddress)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M8"/>
   <xsl:template match="@*|node()" priority="-2" mode="M8">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

   <!--PATTERN DespatchAdvice_Shipment_Delivery_Despatch_DespatchAddress-->


	<!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cbc:CountrySubentity"
                 priority="1010"
                 mode="M9">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cbc:CountrySubentity"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M9"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress"
                 priority="1009"
                 mode="M9">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:Country) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:Country)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M9"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cbc:PostalZone"
                 priority="1008"
                 mode="M9">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cbc:PostalZone"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M9"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cbc:CityName"
                 priority="1007"
                 mode="M9">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cbc:CityName"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M9"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cbc:PlotIdentification"
                 priority="1006"
                 mode="M9">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cbc:PlotIdentification"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M9"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cbc:Department"
                 priority="1005"
                 mode="M9">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cbc:Department"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M9"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cbc:InhouseMail"
                 priority="1004"
                 mode="M9">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cbc:InhouseMail"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M9"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cbc:BuildingNumber"
                 priority="1003"
                 mode="M9">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cbc:BuildingNumber"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M9"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cbc:StreetName"
                 priority="1002"
                 mode="M9">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cbc:StreetName"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M9"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cbc:Room"
                 priority="1001"
                 mode="M9">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cbc:Room"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M9"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cbc:Floor"
                 priority="1000"
                 mode="M9">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cbc:Floor"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M9"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M9"/>
   <xsl:template match="@*|node()" priority="-2" mode="M9">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M9"/>
   </xsl:template>

   <!--PATTERN DespatchAdvice_Shipment_Delivery_Despatch_DespatchAddress_Country-->


	<!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country/cbc:IdentificationCode"
                 priority="1001"
                 mode="M10">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country/cbc:IdentificationCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M10"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country"
                 priority="1000"
                 mode="M10">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:IdentificationCode) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:IdentificationCode)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country/cbc:IdentificationCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M10"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M10"/>
   <xsl:template match="@*|node()" priority="-2" mode="M10">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M10"/>
   </xsl:template>

   <!--PATTERN DespatchAdvice_DespatchLine_Item-->


	<!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DespatchLine/cac:Item/cbc:Name" priority="1003"
                 mode="M11">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DespatchLine/cac:Item/cbc:Name"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:DespatchLine/cac:Item/cbc:Name element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M11"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DespatchLine/cac:Item" priority="1002"
                 mode="M11">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DespatchLine/cac:Item"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:Description) lt 2 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:Description) lt 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:DespatchLine/cac:Item/cbc:Description element should be less than 2!</svrl:text>
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
               <svrl:text>/doc:DespatchAdvice/cac:DespatchLine/cac:Item/cbc:Name element should exist!</svrl:text>
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
               <svrl:text>/doc:DespatchAdvice/cac:DespatchLine/cac:Item/cbc:CatalogueIndicator element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M11"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DespatchLine/cac:Item/cbc:CatalogueIndicator"
                 priority="1001"
                 mode="M11">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DespatchLine/cac:Item/cbc:CatalogueIndicator"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:DespatchLine/cac:Item/cbc:CatalogueIndicator element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M11"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DespatchLine/cac:Item/cbc:Description"
                 priority="1000"
                 mode="M11">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DespatchLine/cac:Item/cbc:Description"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M11"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M11"/>
   <xsl:template match="@*|node()" priority="-2" mode="M11">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M11"/>
   </xsl:template>

   <!--PATTERN DespatchAdvice_DespatchLine-->


	<!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DespatchLine/cbc:DeliveredQuantity"
                 priority="1006"
                 mode="M12">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DespatchLine/cbc:DeliveredQuantity"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(@unitCode) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(@unitCode) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:DespatchLine/cbc:DeliveredQuantity/@unitCode element should exist!</svrl:text>
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
               <svrl:text>/doc:DespatchAdvice/cac:DespatchLine/cbc:DeliveredQuantity element should exist!</svrl:text>
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
               <svrl:text>/doc:DespatchAdvice/cac:DespatchLine/cbc:DeliveredQuantity/@unitCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DespatchLine/cac:Item" priority="1005"
                 mode="M12">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DespatchLine/cac:Item"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(  (count(cbc:Description) = 0) and  (    (count(cac:BuyersItemIdentification/cbc:ID) + count(cac:SellersItemIdentification/cbc:ID) + count(cac:ManufacturersItemIdentification/cbc:ID) + count(cac:StandardItemIdentification/cbc:ID) + count(cac:CatalogueItemIdentification/cbc:ID)) &gt; 0  ) ) or (  (count(cbc:Description) &gt; 0) and  (    (count(cac:BuyersItemIdentification/cbc:ID) + count(cac:SellersItemIdentification/cbc:ID) + count(cac:ManufacturersItemIdentification/cbc:ID) + count(cac:StandardItemIdentification/cbc:ID) + count(cac:CatalogueItemIdentification/cbc:ID)) = 0  ) )"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="( (count(cbc:Description) = 0) and ( (count(cac:BuyersItemIdentification/cbc:ID) + count(cac:SellersItemIdentification/cbc:ID) + count(cac:ManufacturersItemIdentification/cbc:ID) + count(cac:StandardItemIdentification/cbc:ID) + count(cac:CatalogueItemIdentification/cbc:ID)) &gt; 0 ) ) or ( (count(cbc:Description) &gt; 0) and ( (count(cac:BuyersItemIdentification/cbc:ID) + count(cac:SellersItemIdentification/cbc:ID) + count(cac:ManufacturersItemIdentification/cbc:ID) + count(cac:StandardItemIdentification/cbc:ID) + count(cac:CatalogueItemIdentification/cbc:ID)) = 0 ) )">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Item MOET OF een Description OF een (party)Identification/ID bevatten.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DespatchLine/cac:OrderLineReference"
                 priority="1004"
                 mode="M12">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DespatchLine/cac:OrderLineReference"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(empty(cbc:LineID))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="not(empty(cbc:LineID))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:DespatchLine/cac:OrderLineReference/cbc:LineID element should not be empty!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DespatchLine" priority="1003" mode="M12">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DespatchLine"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:DeliveredQuantity) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:DeliveredQuantity)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:DespatchLine/cbc:DeliveredQuantity element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DespatchLine/cbc:ID" priority="1002" mode="M12">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DespatchLine/cbc:ID"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DespatchLine/cbc:BackorderReason"
                 priority="1001"
                 mode="M12">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DespatchLine/cbc:BackorderReason"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DespatchLine/cbc:BackorderQuantity"
                 priority="1000"
                 mode="M12">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DespatchLine/cbc:BackorderQuantity"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(@unitCode) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(@unitCode) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:DespatchLine/cbc:BackorderQuantity/@unitCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M12"/>
   <xsl:template match="@*|node()" priority="-2" mode="M12">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/>
   </xsl:template>

   <!--PATTERN DespatchAdvice_DespatchLine_OrderLineReference-->


	<!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DespatchLine/cac:OrderLineReference/cbc:LineID"
                 priority="1002"
                 mode="M13">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DespatchLine/cac:OrderLineReference/cbc:LineID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:DespatchLine/cac:OrderLineReference/cbc:LineID element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M13"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DespatchLine/cac:OrderLineReference"
                 priority="1001"
                 mode="M13">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DespatchLine/cac:OrderLineReference"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:OrderReference) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:OrderReference)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:DespatchLine/cac:OrderLineReference/cac:OrderReference element should exist!</svrl:text>
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
               <svrl:text>/doc:DespatchAdvice/cac:DespatchLine/cac:OrderLineReference/cbc:LineID element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M13"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DespatchLine/cac:OrderLineReference/cac:OrderReference"
                 priority="1000"
                 mode="M13">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DespatchLine/cac:OrderLineReference/cac:OrderReference"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(empty(cbc:ID))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="not(empty(cbc:ID))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:DespatchLine/cac:OrderLineReference/cac:OrderReference/cbc:ID element should not be empty!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M13"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M13"/>
   <xsl:template match="@*|node()" priority="-2" mode="M13">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M13"/>
   </xsl:template>

   <!--PATTERN DespatchAdvice_SellerSupplierParty_Party-->


	<!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:PartyName"
                 priority="1003"
                 mode="M14">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:PartyName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(empty(cbc:Name))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="not(empty(cbc:Name))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:PartyName/cbc:Name element should not be empty!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M14"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification"
                 priority="1002"
                 mode="M14">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(empty(cbc:ID))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="not(empty(cbc:ID))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID element should not be empty!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M14"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party" priority="1001"
                 mode="M14">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:PartyIdentification) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(cac:PartyIdentification)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification element should exist!</svrl:text>
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
               <svrl:text>/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:PartyName element should be less than 2!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyIdentification) lt 3 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="count(cac:PartyIdentification) lt 3">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification element should be less than 3!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M14"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:Contact"
                 priority="1000"
                 mode="M14">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:Contact"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="matches(cbc:Telefax, '^[-0-9]*$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="matches(cbc:Telefax, '^[-0-9]*$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="matches(cbc:Telephone, '^[-0-9]*$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="matches(cbc:Telephone, '^[-0-9]*$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M14"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M14"/>
   <xsl:template match="@*|node()" priority="-2" mode="M14">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M14"/>
   </xsl:template>

   <!--PATTERN DespatchAdvice_DeliveryCustomerParty_Party-->


	<!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:PartyName"
                 priority="1002"
                 mode="M15">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:PartyName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(empty(cbc:Name))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="not(empty(cbc:Name))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:DeliveryCustomerPartyy/cac:Party/cac:PartyName/cbc:Name element should not be empty!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M15"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party" priority="1001"
                 mode="M15">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:PartyName) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:PartyName)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:PartyName element should exist!</svrl:text>
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
               <svrl:text>/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:PartyName element should be less than 2!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M15"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:Contact"
                 priority="1000"
                 mode="M15">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:Contact"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="matches(cbc:Telefax, '^[-0-9]*$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="matches(cbc:Telefax, '^[-0-9]*$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="matches(cbc:Telephone, '^[-0-9]*$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="matches(cbc:Telephone, '^[-0-9]*$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M15"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M15"/>
   <xsl:template match="@*|node()" priority="-2" mode="M15">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M15"/>
   </xsl:template>

   <!--PATTERN DespatchAdvice_DespatchSupplierParty_Party-->


	<!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:PartyName"
                 priority="1002"
                 mode="M16">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:PartyName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(empty(cbc:Name))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="not(empty(cbc:Name))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:PartyName/cbc:Name element should not be empty!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M16"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party" priority="1001"
                 mode="M16">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:PartyName) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:PartyName)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:PartyName element should exist!</svrl:text>
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
               <svrl:text>/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:PartyName element should be less than 2!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M16"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:Contact"
                 priority="1000"
                 mode="M16">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:Contact"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="matches(cbc:Telephone, '^[-0-9]*$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="matches(cbc:Telephone, '^[-0-9]*$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</svrl:text>
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
               <svrl:text>Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M16"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M16"/>
   <xsl:template match="@*|node()" priority="-2" mode="M16">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M16"/>
   </xsl:template>

   <!--PATTERN DespatchAdvice_DeliveryCustomerParty_Party_Contact-->


	<!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:Contact/cbc:Name"
                 priority="1004"
                 mode="M17">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:Contact/cbc:Name"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:Contact/cbc:Name element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M17"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:Contact"
                 priority="1003"
                 mode="M17">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:Contact"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:Name) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:Name)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:Contact/cbc:Name element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M17"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:Contact/cbc:Telephone"
                 priority="1002"
                 mode="M17">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:Contact/cbc:Telephone"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M17"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:Contact/cbc:Telefax"
                 priority="1001"
                 mode="M17">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:Contact/cbc:Telefax"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M17"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:Contact/cbc:ElectronicMail"
                 priority="1000"
                 mode="M17">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:Contact/cbc:ElectronicMail"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M17"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M17"/>
   <xsl:template match="@*|node()" priority="-2" mode="M17">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M17"/>
   </xsl:template>

   <!--PATTERN DespatchAdvice_SellerSupplierParty_Party_Contact-->


	<!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name"
                 priority="1004"
                 mode="M18">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M18"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:Contact"
                 priority="1003"
                 mode="M18">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:Contact"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:Name) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:Name)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M18"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:ElectronicMail"
                 priority="1002"
                 mode="M18">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:ElectronicMail"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M18"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Telefax"
                 priority="1001"
                 mode="M18">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Telefax"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M18"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Telephone"
                 priority="1000"
                 mode="M18">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Telephone"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M18"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M18"/>
   <xsl:template match="@*|node()" priority="-2" mode="M18">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M18"/>
   </xsl:template>

   <!--PATTERN DespatchAdvice_DespatchSupplierParty_Party_Contact-->


	<!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:Contact/cbc:Name"
                 priority="1004"
                 mode="M19">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:Contact/cbc:Name"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:Contact/cbc:Name element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M19"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:Contact"
                 priority="1003"
                 mode="M19">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:Contact"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:Name) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:Name)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:Contact/cbc:Name element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M19"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:Contact/cbc:Telephone"
                 priority="1002"
                 mode="M19">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:Contact/cbc:Telephone"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M19"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:Contact/cbc:ElectronicMail"
                 priority="1001"
                 mode="M19">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:Contact/cbc:ElectronicMail"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M19"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:Contact/cbc:Telefax"
                 priority="1000"
                 mode="M19">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:Contact/cbc:Telefax"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M19"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M19"/>
   <xsl:template match="@*|node()" priority="-2" mode="M19">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M19"/>
   </xsl:template>

   <!--PATTERN DespatchAdvice_DespatchSupplierParty_Party_PartyIdentification-->


	<!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID"
                 priority="1000"
                 mode="M20">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M20"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M20"/>
   <xsl:template match="@*|node()" priority="-2" mode="M20">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M20"/>
   </xsl:template>

   <!--PATTERN DespatchAdvice_DespatchSupplierParty_Party_PartyIdentification-->


	<!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID"
                 priority="1000"
                 mode="M21">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M21"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M21"/>
   <xsl:template match="@*|node()" priority="-2" mode="M21">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M21"/>
   </xsl:template>

   <!--PATTERN DespatchAdvice_AdditionalDocumentReference_Attachment-->


	<!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:AdditionalDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject"
                 priority="1001"
                 mode="M22">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:AdditionalDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M22"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:AdditionalDocumentReference/cac:Attachment"
                 priority="1000"
                 mode="M22">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:AdditionalDocumentReference/cac:Attachment"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M22"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M22"/>
   <xsl:template match="@*|node()" priority="-2" mode="M22">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M22"/>
   </xsl:template>

   <!--PATTERN DespatchAdvice_DeliveryCustomerParty_Party_PartyIdentification-->


	<!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID"
                 priority="1000"
                 mode="M23">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M23"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M23"/>
   <xsl:template match="@*|node()" priority="-2" mode="M23">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M23"/>
   </xsl:template>

   <!--PATTERN DespatchAdvice_DeliveryCustomerParty_Party_PartyIdentification-->


	<!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID"
                 priority="1000"
                 mode="M24">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M24"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M24"/>
   <xsl:template match="@*|node()" priority="-2" mode="M24">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M24"/>
   </xsl:template>

   <!--PATTERN DespatchAdvice_Shipment_Delivery_DeliveryAddress_Country-->


	<!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode"
                 priority="1001"
                 mode="M25">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M25"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cac:Country"
                 priority="1000"
                 mode="M25">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cac:Country"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:IdentificationCode) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:IdentificationCode)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M25"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M25"/>
   <xsl:template match="@*|node()" priority="-2" mode="M25">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M25"/>
   </xsl:template>

   <!--PATTERN DespatchAdvice_DespatchSupplierParty-->


	<!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party" priority="1001"
                 mode="M26">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:Contact)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:Contact)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:Contact element should exist!
</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M26"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DespatchSupplierParty" priority="1000"
                 mode="M26">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DespatchSupplierParty"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M26"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M26"/>
   <xsl:template match="@*|node()" priority="-2" mode="M26">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M26"/>
   </xsl:template>

   <!--PATTERN DespatchAdvice_DeliveryCustomerParty-->


	<!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DeliveryCustomerParty" priority="1002"
                 mode="M27">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DeliveryCustomerParty"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:Party) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:Party)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M27"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DeliveryCustomerParty/cbc:CustomerAssignedAccountID"
                 priority="1001"
                 mode="M27">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DeliveryCustomerParty/cbc:CustomerAssignedAccountID"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M27"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party" priority="1000"
                 mode="M27">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:Contact)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:Contact)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:Contact should exists!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M27"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M27"/>
   <xsl:template match="@*|node()" priority="-2" mode="M27">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M27"/>
   </xsl:template>

   <!--PATTERN DespatchAdvice_DeliveryCustomerParty-->


	<!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DeliveryCustomerParty" priority="1000"
                 mode="M28">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DeliveryCustomerParty"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M28"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M28"/>
   <xsl:template match="@*|node()" priority="-2" mode="M28">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M28"/>
   </xsl:template>

   <!--PATTERN DespatchAdvice_DeliveryCustomerParty-->


	<!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DeliveryCustomerParty" priority="1000"
                 mode="M29">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DeliveryCustomerParty"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M29"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M29"/>
   <xsl:template match="@*|node()" priority="-2" mode="M29">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M29"/>
   </xsl:template>

   <!--PATTERN DespatchAdvice_SellerSupplierParty-->


	<!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:SellerSupplierParty" priority="1002" mode="M30">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:SellerSupplierParty"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:Party) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:Party)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M30"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party" priority="1001"
                 mode="M30">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:Contact)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:Contact)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:Contact element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M30"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:SellerSupplierParty/cbc:CustomerAssignedAccountID"
                 priority="1000"
                 mode="M30">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:SellerSupplierParty/cbc:CustomerAssignedAccountID"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M30"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M30"/>
   <xsl:template match="@*|node()" priority="-2" mode="M30">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M30"/>
   </xsl:template>

   <!--PATTERN DespatchAdvice_SellerSupplierParty_Party_PartyName-->


	<!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:PartyName/cbc:Name"
                 priority="1001"
                 mode="M31">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:PartyName/cbc:Name"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:PartyName/cbc:Name element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M31"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:PartyName"
                 priority="1000"
                 mode="M31">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:PartyName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:Name) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:Name)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:PartyName/cbc:Name element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M31"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M31"/>
   <xsl:template match="@*|node()" priority="-2" mode="M31">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M31"/>
   </xsl:template>

   <!--PATTERN DespatchAdvice_Shipment_Delivery_DeliveryAddress-->


	<!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress"
                 priority="1009"
                 mode="M32">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:Country) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:Country)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cac:Country element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M32"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cbc:Floor"
                 priority="1008"
                 mode="M32">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cbc:Floor"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M32"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cbc:Room"
                 priority="1007"
                 mode="M32">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cbc:Room"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M32"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cbc:StreetName"
                 priority="1006"
                 mode="M32">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cbc:StreetName"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M32"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cbc:BuildingNumber"
                 priority="1005"
                 mode="M32">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cbc:BuildingNumber"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M32"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cbc:InhouseMail"
                 priority="1004"
                 mode="M32">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cbc:InhouseMail"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M32"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cbc:Department"
                 priority="1003"
                 mode="M32">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cbc:Department"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M32"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cbc:PlotIdentification"
                 priority="1002"
                 mode="M32">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cbc:PlotIdentification"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M32"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cbc:CityName"
                 priority="1001"
                 mode="M32">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cbc:CityName"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M32"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cbc:PostalZone"
                 priority="1000"
                 mode="M32">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cbc:PostalZone"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M32"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M32"/>
   <xsl:template match="@*|node()" priority="-2" mode="M32">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M32"/>
   </xsl:template>

   <!--PATTERN DespatchAdvice_SellerSupplierParty_Party_PartyIdentification-->


	<!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID"
                 priority="1000"
                 mode="M33">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="matches(@schemeAgencyID, '^[A-Z]{2}$')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="matches(@schemeAgencyID, '^[A-Z]{2}$')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M33"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M33"/>
   <xsl:template match="@*|node()" priority="-2" mode="M33">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M33"/>
   </xsl:template>

   <!--PATTERN DespatchAdvice_SellerSupplierParty_Party_PartyIdentification-->


	<!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID"
                 priority="1000"
                 mode="M34">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(@schemeAgencyName  = 'KvK') or (@schemeAgencyName  = 'BTW') or (@schemeAgencyName = 'Fi') or (@schemeAgencyName  = 'BSN') or (@schemeAgencyName  = 'OIN') or (@schemeAgencyName  = 'XXX')"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(@schemeAgencyName = 'KvK') or (@schemeAgencyName = 'BTW') or (@schemeAgencyName = 'Fi') or (@schemeAgencyName = 'BSN') or (@schemeAgencyName = 'OIN') or (@schemeAgencyName = 'XXX')">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>Uitgevende organisatie van de PartijIdentificatie MOET ge?dentificeerd worden door een code uit de lijst: KvK, BTW, Fi, BSN, OIN, XXX.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M34"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M34"/>
   <xsl:template match="@*|node()" priority="-2" mode="M34">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M34"/>
   </xsl:template>

   <!--PATTERN DespatchAdvice_DeliveryCustomerParty_Party_PartyName-->


	<!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:PartyName/cbc:Name"
                 priority="1000"
                 mode="M35">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:PartyName/cbc:Name"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M35"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M35"/>
   <xsl:template match="@*|node()" priority="-2" mode="M35">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M35"/>
   </xsl:template>

   <!--PATTERN DespatchAdvice_DespatchSupplierParty_Party_PartyName-->


	<!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:PartyName/cbc:Name"
                 priority="1000"
                 mode="M36">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:PartyName/cbc:Name"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M36"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M36"/>
   <xsl:template match="@*|node()" priority="-2" mode="M36">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M36"/>
   </xsl:template>

   <!--PATTERN DespatchAdvice_Shipment_Consignment-->


	<!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:Shipment/cac:Consignment" priority="1001"
                 mode="M37">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:Shipment/cac:Consignment"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M37"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:Shipment/cac:Consignment/cbc:ID" priority="1000"
                 mode="M37">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:Shipment/cac:Consignment/cbc:ID"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M37"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M37"/>
   <xsl:template match="@*|node()" priority="-2" mode="M37">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M37"/>
   </xsl:template>

   <!--PATTERN DespatchAdvice_Shipment_Delivery_RequestedDeliveryPeriod-->


	<!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:RequestedDeliveryPeriod"
                 priority="1001"
                 mode="M38">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:RequestedDeliveryPeriod"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:EndDate) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:EndDate)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:RequestedDeliveryPeriod/cbc:EndDate element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M38"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:RequestedDeliveryPeriod/cbc:EndDate"
                 priority="1000"
                 mode="M38">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:RequestedDeliveryPeriod/cbc:EndDate"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:RequestedDeliveryPeriod/cbc:EndDate element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M38"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M38"/>
   <xsl:template match="@*|node()" priority="-2" mode="M38">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M38"/>
   </xsl:template>

   <!--PATTERN DespatchAdvice_Shipment_Delivery_DeliveryParty-->


	<!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryParty"
                 priority="1000"
                 mode="M39">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryParty"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyName) lt 2 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:PartyName) lt 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryParty/cac:PartyName element should be less than 2!</svrl:text>
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
               <svrl:text>/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryParty/cac:PartyName element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M39"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M39"/>
   <xsl:template match="@*|node()" priority="-2" mode="M39">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M39"/>
   </xsl:template>

   <!--PATTERN DespatchAdvice_Shipment_Delivery_DeliveryParty_PartyName-->


	<!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryParty/cac:PartyName/cbc:Name"
                 priority="1000"
                 mode="M40">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryParty/cac:PartyName/cbc:Name"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M40"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M40"/>
   <xsl:template match="@*|node()" priority="-2" mode="M40">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M40"/>
   </xsl:template>

   <!--PATTERN DespatchAdvice_DespatchLine_OrderLineReference_OrderReference-->


	<!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DespatchLine/cac:OrderLineReference/cac:OrderReference"
                 priority="1001"
                 mode="M41">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DespatchLine/cac:OrderLineReference/cac:OrderReference"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M41"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:DespatchAdvice/cac:DespatchLine/cac:OrderLineReference/cac:OrderReference/cbc:ID"
                 priority="1000"
                 mode="M41">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:DespatchAdvice/cac:DespatchLine/cac:OrderLineReference/cac:OrderReference/cbc:ID"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M41"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M41"/>
   <xsl:template match="@*|node()" priority="-2" mode="M41">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M41"/>
   </xsl:template>
</xsl:stylesheet>