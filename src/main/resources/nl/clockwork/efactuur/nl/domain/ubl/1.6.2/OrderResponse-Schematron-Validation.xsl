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
                xmlns:doc="urn:oasis:names:specification:ubl:schema:xsd:OrderResponse-2"
                xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
                xmlns:ccts="urn:oasis:names:specification:ubl:schema:xsd:CoreComponentParameters-2"
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
         <svrl:ns-prefix-in-attribute-values uri="urn:oasis:names:specification:ubl:schema:xsd:OrderResponse-2" prefix="doc"/>
         <svrl:ns-prefix-in-attribute-values uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
                                             prefix="cac"/>
         <svrl:ns-prefix-in-attribute-values uri="urn:oasis:names:specification:ubl:schema:xsd:CoreComponentParameters-2"
                                             prefix="ccts"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse</xsl:attribute>
            <xsl:attribute name="name">OrderResponse</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M5"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_Contract</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_Contract</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M6"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_SellerSupplierParty</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_SellerSupplierParty</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M7"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_SellerSupplierParty_Party</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_SellerSupplierParty_Party</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M8"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_SellerSupplierParty_Party_PartyIdentification</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_SellerSupplierParty_Party_PartyIdentification</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M9"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_SellerSupplierParty_Party_PostalAddress</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_SellerSupplierParty_Party_PostalAddress</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M10"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_SellerSupplierParty_Party_PostalAddress_Country</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_SellerSupplierParty_Party_PostalAddress_Country</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M11"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_BuyerCustomerParty</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_BuyerCustomerParty</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M12"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_BuyerCustomerParty_Party</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_BuyerCustomerParty_Party</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M13"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_BuyerCustomerParty_Party_PartyIdentification</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_BuyerCustomerParty_Party_PartyIdentification</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M14"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_BuyerCustomerParty_Party_PostalAddress</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_BuyerCustomerParty_Party_PostalAddress</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M15"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_BuyerCustomerParty_Party_PostalAddress_Country</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_BuyerCustomerParty_Party_PostalAddress_Country</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M16"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_AccountingSupplierParty_Party</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_AccountingSupplierParty_Party</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M17"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_AccountingSupplierParty_Party_PartyIdentification</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_AccountingSupplierParty_Party_PartyIdentification</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M18"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_AccountingSupplierParty_Party_PostalAddress</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_AccountingSupplierParty_Party_PostalAddress</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M19"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_AccountingSupplierParty_Party_PostalAddress_Country</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_AccountingSupplierParty_Party_PostalAddress_Country</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M20"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_AccountingCustomerParty_Party</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_AccountingCustomerParty_Party</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M21"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_AccountingCustomerParty_Party_PartyIdentification</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_AccountingCustomerParty_Party_PartyIdentification</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M22"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_AccountingCustomerParty_Party_PostalAddress</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_AccountingCustomerParty_Party_PostalAddress</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M23"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_AccountingCustomerParty_Party_PostalAddress_Country</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_AccountingCustomerParty_Party_PostalAddress_Country</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M24"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_Delivery_DeliveryAddress</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_Delivery_DeliveryAddress</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M25"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_Delivery_DeliveryAddress_Country</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_Delivery_DeliveryAddress_Country</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M26"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_Delivery_RequestedDeliveryPeriod</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_Delivery_RequestedDeliveryPeriod</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M27"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_Delivery_DeliveryParty</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_Delivery_DeliveryParty</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M28"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M29"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_LineItem</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_LineItem</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M30"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_LineItem_Delivery_DeliveryAddress</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_LineItem_Delivery_DeliveryAddress</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M31"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_LineItem_Delivery_DeliveryAddress_Country</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_LineItem_Delivery_DeliveryAddress_Country</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M32"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_LineItem_Delivery_RequestedDeliveryPeriod</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_LineItem_Delivery_RequestedDeliveryPeriod</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M33"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_LineItem_Delivery_EstimatedDeliveryPeriod</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_LineItem_Delivery_EstimatedDeliveryPeriod</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M34"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_LineItem_Delivery_DeliveryParty</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_LineItem_Delivery_DeliveryParty</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M35"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_LineItem_Item</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_LineItem_Item</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M36"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_LineItem_Item_TransactionConditions</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_LineItem_Item_TransactionConditions</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M37"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_SellerSubstitutedLineItem</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_SellerSubstitutedLineItem</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M38"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_SellerSubstitutedLineItem_Item</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_SellerSubstitutedLineItem_Item</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M39"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_SellerSubstitutedLineItem_Item_TransactionConditions</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_SellerSubstitutedLineItem_Item_TransactionConditions</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M40"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_SellerSubstitutedLineItem_Delivery_DeliveryAddress</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_SellerSubstitutedLineItem_Delivery_DeliveryAddress</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M41"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_SellerSubstitutedLineItem_Delivery_DeliveryAddress_Country</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_SellerSubstitutedLineItem_Delivery_DeliveryAddress_Country</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M42"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_SellerSubstitutedLineItem_Delivery_RequestedDeliveryPeriod</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_SellerSubstitutedLineItem_Delivery_RequestedDeliveryPeriod</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M43"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_SellerSubstitutedLineItem_Delivery_DeliveryParty</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_SellerSubstitutedLineItem_Delivery_DeliveryParty</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M44"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_LineItem_Item_ClassifiedTaxCategory_TaxScheme</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_LineItem_Item_ClassifiedTaxCategory_TaxScheme</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M45"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_SellerSubstitutedLineItem_Item_ClassifiedTaxCategory_TaxScheme</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_SellerSubstitutedLineItem_Item_ClassifiedTaxCategory_TaxScheme</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M46"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_PaymentMeans_PayeeFinancialAccount</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_PaymentMeans_PayeeFinancialAccount</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M47"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_PaymentMeans_PayeeFinancialAccount_Country</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_PaymentMeans_PayeeFinancialAccount_Country</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M48"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_PaymentMeans_PayeeFinancialAccount_FinancialInstitutionBranch</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_PaymentMeans_PayeeFinancialAccount_FinancialInstitutionBranch</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M49"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_PaymentMeans_PayeeFinancialAccount_FinancialInstitutionBranch_FinancialInstitution</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_PaymentMeans_PayeeFinancialAccount_FinancialInstitutionBranch_FinancialInstitution</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M50"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_Delivery_EstimatedDeliveryPeriod</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_Delivery_EstimatedDeliveryPeriod</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M51"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_SellerSubstitutedLineItem_Delivery_EstimatedDeliveryPeriod</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_SellerSubstitutedLineItem_Delivery_EstimatedDeliveryPeriod</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M52"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_SellerProposedSubstituteLineItem</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_SellerProposedSubstituteLineItem</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M53"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Delivery_RequestedDeliveryPeriod</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Delivery_RequestedDeliveryPeriod</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M54"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Delivery_DeliveryAddress</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Delivery_DeliveryAddress</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M55"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Delivery_DeliveryAddress_Country</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Delivery_DeliveryAddress_Country</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M56"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Delivery_EstimatedDeliveryPeriod</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Delivery_EstimatedDeliveryPeriod</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M57"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Delivery_DeliveryParty</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Delivery_DeliveryParty</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M58"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Item</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Item</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M59"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Item_ClassifiedTaxCategory_TaxScheme</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Item_ClassifiedTaxCategory_TaxScheme</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M60"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Item_TransactionConditions</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Item_TransactionConditions</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M61"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_FreightForwarderParty</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_FreightForwarderParty</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M62"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_Delivery_PromisedDeliveryPeriod</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_Delivery_PromisedDeliveryPeriod</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M63"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_LineItem_Delivery_PromisedDeliveryPeriod</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_LineItem_Delivery_PromisedDeliveryPeriod</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M64"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_SellerSupplierParty_Party_AgentParty</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_SellerSupplierParty_Party_AgentParty</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M65"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_SellerSupplierParty_Party_AgentParty_PostalAddress</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_SellerSupplierParty_Party_AgentParty_PostalAddress</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M66"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_SellerSupplierParty_Party_AgentParty_PostalAddress_Country</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_SellerSupplierParty_Party_AgentParty_PostalAddress_Country</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M67"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_BuyerCustomerParty_Party_AgentParty</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_BuyerCustomerParty_Party_AgentParty</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M68"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_BuyerCustomerParty_Party_AgentParty_PostalAddress</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_BuyerCustomerParty_Party_AgentParty_PostalAddress</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M69"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_BuyerCustomerParty_Party_AgentParty_PostalAddress_Country</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_BuyerCustomerParty_Party_AgentParty_PostalAddress_Country</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M70"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_Delivery_Despatch_DespatchAddress</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_Delivery_Despatch_DespatchAddress</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M71"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_Delivery_Despatch_DespatchAddress_Country</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_Delivery_Despatch_DespatchAddress_Country</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M72"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_TaxTotal_TaxSubtotal_TaxCategory_TaxScheme</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_TaxTotal_TaxSubtotal_TaxCategory_TaxScheme</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M73"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_LineItem_Price</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_LineItem_Price</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M74"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_PaymentMeans</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_PaymentMeans</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M75"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_BuyerCustomerParty_Party_AgentParty_PartyIdentification</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_BuyerCustomerParty_Party_AgentParty_PartyIdentification</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M76"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_BuyerCustomerParty_Party_Contact</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_BuyerCustomerParty_Party_Contact</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M77"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_BuyerCustomerParty_Party_PhysicalLocation</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_BuyerCustomerParty_Party_PhysicalLocation</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M78"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_BuyerCustomerParty_Party_PhysicalLocation_Address</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_BuyerCustomerParty_Party_PhysicalLocation_Address</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M79"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_BuyerCustomerParty_Party_PhysicalLocation_Address_Country</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_BuyerCustomerParty_Party_PhysicalLocation_Address_Country</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M80"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_Delivery_Despatch</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_Delivery_Despatch</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M81"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_LegalMonetaryTotal</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_LegalMonetaryTotal</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M82"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_LineItem_Delivery_DeliveryParty_Contact</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_LineItem_Delivery_DeliveryParty_Contact</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M83"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_PaymentMeans_PayeeFinancialAccount_FinancialInstitutionBranch_Address</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_PaymentMeans_PayeeFinancialAccount_FinancialInstitutionBranch_Address</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M84"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_PaymentMeans_PayeeFinancialAccount_FinancialInstitutionBranch_Address_Country</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_PaymentMeans_PayeeFinancialAccount_FinancialInstitutionBranch_Address_Country</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M85"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_SellerSupplierParty_Party_Contact</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_SellerSupplierParty_Party_Contact</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M86"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_AccountingCustomerParty</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_AccountingCustomerParty</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M87"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_BuyerCustomerParty_Party_AgentParty_Contact</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_BuyerCustomerParty_Party_AgentParty_Contact</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M88"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Delivery</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Delivery</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M89"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Price</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Price</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M90"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Item_ItemSpecificationDocumentReference_Attachment</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Item_ItemSpecificationDocumentReference_Attachment</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M91"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_DocumentReference</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_DocumentReference</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M92"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_DocumentReference_Attachment</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_DocumentReference_Attachment</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M93"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_LineItem_Delivery</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_LineItem_Delivery</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M94"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_LineItem_Delivery</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_LineItem_Delivery</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M95"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_LineItem_Delivery</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_LineItem_Delivery</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M96"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_LineItem_Delivery</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_LineItem_Delivery</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M97"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_LineItem_Item_ItemSpecificationDocumentReference_Attachment</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_LineItem_Item_ItemSpecificationDocumentReference_Attachment</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M98"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_TaxTotal</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_TaxTotal</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M99"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_TaxTotal</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_TaxTotal</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M100"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_Delivery</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_Delivery</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M101"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_FreightForwarderParty_PartyIdentification</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_FreightForwarderParty_PartyIdentification</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M102"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_FreightForwarderParty_PartyIdentification</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_FreightForwarderParty_PartyIdentification</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M103"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_FreightForwarderParty_PartyIdentification</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_FreightForwarderParty_PartyIdentification</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M104"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_LineItem_DeliveryTerms</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_LineItem_DeliveryTerms</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M105"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Delivery_DeliveryParty_Contact</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Delivery_DeliveryParty_Contact</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M106"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Delivery_PromisedDeliveryPeriod</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Delivery_PromisedDeliveryPeriod</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M107"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_SellerProposedSubstituteLineItem_DeliveryTerms</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_SellerProposedSubstituteLineItem_DeliveryTerms</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M108"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_DeliveryTerms</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_DeliveryTerms</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M109"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_LineItem_Item_ClassifiedTaxCategory</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_LineItem_Item_ClassifiedTaxCategory</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M110"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Item_ClassifiedTaxCategory</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Item_ClassifiedTaxCategory</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M111"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">OrderResponse_TaxTotal_TaxSubtotal_TaxCategory</xsl:attribute>
            <xsl:attribute name="name">OrderResponse_TaxTotal_TaxSubtotal_TaxCategory</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M112"/>
      </svrl:schematron-output>
   </xsl:template>

   <!--SCHEMATRON PATTERNS-->


<!--PATTERN OrderResponse-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cbc:UBLVersionID" priority="1008" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cbc:UBLVersionID"/>

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
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cbc:CustomizationID" priority="1007" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cbc:CustomizationID"/>

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
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cbc:ProfileID" priority="1006" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cbc:ProfileID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="normalize-space(text()) = 'NL'"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="normalize-space(text()) = 'NL'">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Bericht MOET gebaseerd zijn op de Nederlandse (NL) specificatie.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse" priority="1005" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/doc:OrderResponse"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:Note) lt 2 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:Note) lt 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cbc:Note element should be less than 2!</svrl:text>
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
               <svrl:text>  /doc:OrderResponse/cac:Delivery element should be less than 2!</svrl:text>
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
               <svrl:text>  /doc:OrderResponse/cac:TaxTotal element should be less than 2!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:OrderReference) lt 2 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:OrderReference) lt 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderReference element should be less than 2!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(  (count(cac:Delivery/cac:DeliveryAddress) = 0) and  (count(cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress) = count(cac:OrderLine/cac:LineItem)) ) or (  (count(cac:Delivery/cac:DeliveryAddress) &gt; 0) and  (count(cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress) = 0) ) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="( (count(cac:Delivery/cac:DeliveryAddress) = 0) and (count(cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress) = count(cac:OrderLine/cac:LineItem)) ) or ( (count(cac:Delivery/cac:DeliveryAddress) &gt; 0) and (count(cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress) = 0) )">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Afleveradres MOET OF op algemeen niveau OF voor alle regels worden opgegeven.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(  (count(cbc:AccountingCostCode) = 0) and  (count(cac:OrderLine/cac:LineItem/cbc:AccountingCostCode) = count(cac:OrderLine/cac:LineItem)) ) or (  (count(cbc:AccountingCostCode) &gt; 0) and  (count(cac:OrderLine/cac:LineItem/cbc:AccountingCostCode) = 0) )"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="( (count(cbc:AccountingCostCode) = 0) and (count(cac:OrderLine/cac:LineItem/cbc:AccountingCostCode) = count(cac:OrderLine/cac:LineItem)) ) or ( (count(cbc:AccountingCostCode) &gt; 0) and (count(cac:OrderLine/cac:LineItem/cbc:AccountingCostCode) = 0) )">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Kostenplaats MOET OF op algemeen niveau OF voor alle regels worden opgegeven.</svrl:text>
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
               <svrl:text>  /doc:OrderResponse/cbc:ID element should not be empty!</svrl:text>
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
               <svrl:text>  /doc:OrderResponse/cbc:UBLVersionID element should exist!</svrl:text>
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
               <svrl:text>  /doc:OrderResponse/cbc:CustomizationID element should exist!</svrl:text>
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
               <svrl:text>  /doc:OrderResponse/cbc:ProfileID element should exist!</svrl:text>
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
         <xsl:when test="(  (count(cac:Delivery/cac:PromisedDeliveryPeriod) = 0) and  (count(cac:OrderLine/cac:LineItem/cac:Delivery/cac:PromisedDeliveryPeriod) = count(cac:OrderLine/cac:LineItem)) ) or (  (count(cac:Delivery/cac:PromisedDeliveryPeriod) &gt; 0) and  (count(cac:OrderLine/cac:LineItem/cac:Delivery/cac:PromisedDeliveryPeriod) = 0) ) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="( (count(cac:Delivery/cac:PromisedDeliveryPeriod) = 0) and (count(cac:OrderLine/cac:LineItem/cac:Delivery/cac:PromisedDeliveryPeriod) = count(cac:OrderLine/cac:LineItem)) ) or ( (count(cac:Delivery/cac:PromisedDeliveryPeriod) &gt; 0) and (count(cac:OrderLine/cac:LineItem/cac:Delivery/cac:PromisedDeliveryPeriod) = 0) )">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Levertijd MOET OF op algemeen niveau OF voor alle regels worden opgegeven.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(count(cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact) = count(cac:OrderLine/cac:LineItem)) or (count(cac:SellerSupplierParty/cac:Party/cac:Contact) &gt; 0)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact) = count(cac:OrderLine/cac:LineItem)) or (count(cac:SellerSupplierParty/cac:Party/cac:Contact) &gt; 0)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Leverancier contactpersoon MOET voor alle regels worden opgegeven ALS NIET op algemeen niveau opgegeven.</svrl:text>
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
         <xsl:when test="count(cac:Contract) lt 2 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:Contract) lt 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:Contract element should be less than 2!</svrl:text>
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
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderReference" priority="1004" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderReference"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(empty(cbc:ID))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="not(empty(cbc:ID))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderReference/cbc:ID element should not be empty!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cbc:ID" priority="1003" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/doc:OrderResponse/cbc:ID"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cbc:Note" priority="1002" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/doc:OrderResponse/cbc:Note"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cbc:DocumentCurrencyCode" priority="1001" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cbc:DocumentCurrencyCode"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cbc:AccountingCostCode" priority="1000" mode="M5">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cbc:AccountingCostCode"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M5"/>
   <xsl:template match="@*|node()" priority="-2" mode="M5">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/>
   </xsl:template>

   <!--PATTERN OrderResponse_Contract-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:Contract/cbc:ID" priority="1001" mode="M6">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:Contract/cbc:ID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:Contract/cbc:ID element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:Contract" priority="1000" mode="M6">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:Contract"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:ID) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:ID)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:Contract/cbc:ID element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M6"/>
   <xsl:template match="@*|node()" priority="-2" mode="M6">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/>
   </xsl:template>

   <!--PATTERN OrderResponse_SellerSupplierParty-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:SellerSupplierParty/cbc:CustomerAssignedAccountID"
                 priority="1001"
                 mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:SellerSupplierParty/cbc:CustomerAssignedAccountID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:SellerSupplierParty/cbc:CustomerAssignedAccountID element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:SellerSupplierParty" priority="1000" mode="M7">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:SellerSupplierParty"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:Party) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:Party)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:SellerSupplierParty/cac:Party element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:CustomerAssignedAccountID) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(cbc:CustomerAssignedAccountID)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:SellerSupplierParty/cbc:CustomerAssignedAccountID element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M7"/>
   <xsl:template match="@*|node()" priority="-2" mode="M7">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/>
   </xsl:template>

   <!--PATTERN OrderResponse_SellerSupplierParty_Party-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party" priority="1003"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyName) lt 2 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:PartyName) lt 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PartyName element should be less than 2!</svrl:text>
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
               <svrl:text>  /doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PartyName element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:PartyIdentification) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(cac:PartyIdentification)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification element should exist!</svrl:text>
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
               <svrl:text>  /doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification element should be less than 3!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification"
                 priority="1002"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(empty(cbc:ID))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="not(empty(cbc:ID))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID element should not be empty!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PartyName"
                 priority="1001"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PartyName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(empty(cbc:Name))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="not(empty(cbc:Name))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PartyName/cbc:Name element should not be empty!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:Contact"
                 priority="1000"
                 mode="M8">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:Contact"/>

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
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M8"/>
   <xsl:template match="@*|node()" priority="-2" mode="M8">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/>
   </xsl:template>

   <!--PATTERN OrderResponse_SellerSupplierParty_Party_PartyIdentification-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID"
                 priority="1000"
                 mode="M9">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID"/>

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
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M9"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M9"/>
   <xsl:template match="@*|node()" priority="-2" mode="M9">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M9"/>
   </xsl:template>

   <!--PATTERN OrderResponse_SellerSupplierParty_Party_PostalAddress-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PostalAddress"
                 priority="1000"
                 mode="M10">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PostalAddress"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:Country) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:Country)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M10"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M10"/>
   <xsl:template match="@*|node()" priority="-2" mode="M10">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M10"/>
   </xsl:template>

   <!--PATTERN OrderResponse_SellerSupplierParty_Party_PostalAddress_Country-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"
                 priority="1001"
                 mode="M11">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M11"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country"
                 priority="1000"
                 mode="M11">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:IdentificationCode) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:IdentificationCode)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M11"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M11"/>
   <xsl:template match="@*|node()" priority="-2" mode="M11">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M11"/>
   </xsl:template>

   <!--PATTERN OrderResponse_BuyerCustomerParty-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:BuyerCustomerParty" priority="1000" mode="M12">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:BuyerCustomerParty"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:Party) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:Party)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M12"/>
   <xsl:template match="@*|node()" priority="-2" mode="M12">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/>
   </xsl:template>

   <!--PATTERN OrderResponse_BuyerCustomerParty_Party-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party" priority="1003"
                 mode="M13">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyName) lt 2 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:PartyName) lt 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PartyName element should be less than 2!</svrl:text>
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
               <svrl:text>  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PartyName element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:Contact) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:Contact)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:Contact element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:PartyIdentification) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(cac:PartyIdentification)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification element should exist!</svrl:text>
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
               <svrl:text>  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification element should be less than 3!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M13"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PartyName"
                 priority="1002"
                 mode="M13">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PartyName"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(empty(cbc:Name))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="not(empty(cbc:Name))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PartyName/cbc:Name element should not be empty!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M13"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification"
                 priority="1001"
                 mode="M13">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(empty(cbc:ID))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="not(empty(cbc:ID))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID element should not be empty!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M13"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:Contact"
                 priority="1000"
                 mode="M13">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:Contact"/>

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
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M13"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M13"/>
   <xsl:template match="@*|node()" priority="-2" mode="M13">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M13"/>
   </xsl:template>

   <!--PATTERN OrderResponse_BuyerCustomerParty_Party_PartyIdentification-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID"
                 priority="1000"
                 mode="M14">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID"/>

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
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M14"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M14"/>
   <xsl:template match="@*|node()" priority="-2" mode="M14">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M14"/>
   </xsl:template>

   <!--PATTERN OrderResponse_BuyerCustomerParty_Party_PostalAddress-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress"
                 priority="1000"
                 mode="M15">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M15"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M15"/>
   <xsl:template match="@*|node()" priority="-2" mode="M15">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M15"/>
   </xsl:template>

   <!--PATTERN OrderResponse_BuyerCustomerParty_Party_PostalAddress_Country-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"
                 priority="1001"
                 mode="M16">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M16"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country"
                 priority="1000"
                 mode="M16">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M16"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M16"/>
   <xsl:template match="@*|node()" priority="-2" mode="M16">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M16"/>
   </xsl:template>

   <!--PATTERN OrderResponse_AccountingSupplierParty_Party-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:AccountingSupplierParty/cac:Party"
                 priority="1000"
                 mode="M17">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:AccountingSupplierParty/cac:Party"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M17"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M17"/>
   <xsl:template match="@*|node()" priority="-2" mode="M17">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M17"/>
   </xsl:template>

   <!--PATTERN OrderResponse_AccountingSupplierParty_Party_PartyIdentification-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID"
                 priority="1000"
                 mode="M18">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M18"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M18"/>
   <xsl:template match="@*|node()" priority="-2" mode="M18">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M18"/>
   </xsl:template>

   <!--PATTERN OrderResponse_AccountingSupplierParty_Party_PostalAddress-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress"
                 priority="1000"
                 mode="M19">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M19"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M19"/>
   <xsl:template match="@*|node()" priority="-2" mode="M19">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M19"/>
   </xsl:template>

   <!--PATTERN OrderResponse_AccountingSupplierParty_Party_PostalAddress_Country-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"
                 priority="1001"
                 mode="M20">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M20"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country"
                 priority="1000"
                 mode="M20">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M20"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M20"/>
   <xsl:template match="@*|node()" priority="-2" mode="M20">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M20"/>
   </xsl:template>

   <!--PATTERN OrderResponse_AccountingCustomerParty_Party-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party"
                 priority="1000"
                 mode="M21">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyName) lt 2 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:PartyName) lt 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PartyName element should be less than 2!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:PartyIdentification) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(cac:PartyIdentification)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification element should exist!</svrl:text>
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
               <svrl:text>  /doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification element should be less than 3!</svrl:text>
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
               <svrl:text>  /doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PartyName element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M21"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M21"/>
   <xsl:template match="@*|node()" priority="-2" mode="M21">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M21"/>
   </xsl:template>

   <!--PATTERN OrderResponse_AccountingCustomerParty_Party_PartyIdentification-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID"
                 priority="1000"
                 mode="M22">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID"/>

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
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M22"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M22"/>
   <xsl:template match="@*|node()" priority="-2" mode="M22">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M22"/>
   </xsl:template>

   <!--PATTERN OrderResponse_AccountingCustomerParty_Party_PostalAddress-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress"
                 priority="1010"
                 mode="M23">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:Country) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:Country)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M23"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:PostalZone"
                 priority="1009"
                 mode="M23">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:PostalZone"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M23"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:CityName"
                 priority="1008"
                 mode="M23">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:CityName"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M23"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:PlotIdentification"
                 priority="1007"
                 mode="M23">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:PlotIdentification"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M23"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:Department"
                 priority="1006"
                 mode="M23">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:Department"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M23"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:InhouseMail"
                 priority="1005"
                 mode="M23">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:InhouseMail"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M23"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:BuildingNumber"
                 priority="1004"
                 mode="M23">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:BuildingNumber"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M23"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:StreetName"
                 priority="1003"
                 mode="M23">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:StreetName"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M23"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:Room"
                 priority="1002"
                 mode="M23">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:Room"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M23"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:Floor"
                 priority="1001"
                 mode="M23">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:Floor"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M23"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:Postbox"
                 priority="1000"
                 mode="M23">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:Postbox"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M23"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M23"/>
   <xsl:template match="@*|node()" priority="-2" mode="M23">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M23"/>
   </xsl:template>

   <!--PATTERN OrderResponse_AccountingCustomerParty_Party_PostalAddress_Country-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"
                 priority="1001"
                 mode="M24">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M24"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country"
                 priority="1000"
                 mode="M24">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:IdentificationCode) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:IdentificationCode)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M24"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M24"/>
   <xsl:template match="@*|node()" priority="-2" mode="M24">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M24"/>
   </xsl:template>

   <!--PATTERN OrderResponse_Delivery_DeliveryAddress-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:Delivery/cac:DeliveryAddress" priority="1000"
                 mode="M25">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:Delivery/cac:DeliveryAddress"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:Country) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:Country)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:Delivery/cac:DeliveryAddress/cac:Country element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M25"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M25"/>
   <xsl:template match="@*|node()" priority="-2" mode="M25">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M25"/>
   </xsl:template>

   <!--PATTERN OrderResponse_Delivery_DeliveryAddress_Country-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode"
                 priority="1001"
                 mode="M26">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M26"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:Delivery/cac:DeliveryAddress/cac:Country"
                 priority="1000"
                 mode="M26">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:Delivery/cac:DeliveryAddress/cac:Country"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:IdentificationCode) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:IdentificationCode)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M26"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M26"/>
   <xsl:template match="@*|node()" priority="-2" mode="M26">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M26"/>
   </xsl:template>

   <!--PATTERN OrderResponse_Delivery_RequestedDeliveryPeriod-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:Delivery/cac:RequestedDeliveryPeriod"
                 priority="1000"
                 mode="M27">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:Delivery/cac:RequestedDeliveryPeriod"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M27"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M27"/>
   <xsl:template match="@*|node()" priority="-2" mode="M27">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M27"/>
   </xsl:template>

   <!--PATTERN OrderResponse_Delivery_DeliveryParty-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:Delivery/cac:DeliveryParty" priority="1000"
                 mode="M28">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:Delivery/cac:DeliveryParty"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M28"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M28"/>
   <xsl:template match="@*|node()" priority="-2" mode="M28">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M28"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:DocumentReference" priority="1001"
                 mode="M29">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:DocumentReference"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:DocumentType) and not(empty(cbc:DocumentType))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(cbc:DocumentType) and not(empty(cbc:DocumentType))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  DocumentType MOET gevuld worden met de soort identificatie van het document: 'Bestelling' of 'Contract' of 'Specificatie' in geval er een bijlage meegezonden wordt.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M29"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:LineItem" priority="1000"
                 mode="M29">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:LineItem"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="not(empty(cbc:ID))"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="not(empty(cbc:ID))">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cbc:ID element should not be empty!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M29"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M29"/>
   <xsl:template match="@*|node()" priority="-2" mode="M29">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M29"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_LineItem-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:LineItem" priority="1002"
                 mode="M30">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:LineItem"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:Price) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:Price)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Price element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:Quantity) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:Quantity)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cbc:Quantity element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M30"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cbc:Quantity"
                 priority="1001"
                 mode="M30">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cbc:Quantity"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(@unitCode) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(@unitCode) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cbc:Quantity/@unitCode element should exist!</svrl:text>
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
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cbc:Quantity/@unitCode element should exist!</svrl:text>
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
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cbc:Quantity element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M30"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item" priority="1000"
                 mode="M30">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item"/>

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
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M30"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M30"/>
   <xsl:template match="@*|node()" priority="-2" mode="M30">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M30"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_LineItem_Delivery_DeliveryAddress-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress"
                 priority="1000"
                 mode="M31">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:Country) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:Country)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M31"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M31"/>
   <xsl:template match="@*|node()" priority="-2" mode="M31">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M31"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_LineItem_Delivery_DeliveryAddress_Country-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode"
                 priority="1001"
                 mode="M32">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M32"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country"
                 priority="1000"
                 mode="M32">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:IdentificationCode) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:IdentificationCode)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M32"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M32"/>
   <xsl:template match="@*|node()" priority="-2" mode="M32">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M32"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_LineItem_Delivery_RequestedDeliveryPeriod-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:RequestedDeliveryPeriod"
                 priority="1000"
                 mode="M33">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:RequestedDeliveryPeriod"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M33"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M33"/>
   <xsl:template match="@*|node()" priority="-2" mode="M33">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M33"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_LineItem_Delivery_EstimatedDeliveryPeriod-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:EstimatedDeliveryPeriod"
                 priority="1000"
                 mode="M34">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:EstimatedDeliveryPeriod"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M34"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M34"/>
   <xsl:template match="@*|node()" priority="-2" mode="M34">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M34"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_LineItem_Delivery_DeliveryParty-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty"
                 priority="1001"
                 mode="M35">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyName) lt 2 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:PartyName) lt 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:PartyName element should be less than 2!</svrl:text>
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
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:PartyName element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M35"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact"
                 priority="1000"
                 mode="M35">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact"/>

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
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M35"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M35"/>
   <xsl:template match="@*|node()" priority="-2" mode="M35">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M35"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_LineItem_Item-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item" priority="1002"
                 mode="M36">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:Description) lt 2 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:Description) lt 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cbc:Description element should be less than 2!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:Description) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:Description)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cbc:Description element should exist!</svrl:text>
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
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cbc:CatalogueIndicator element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M36"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cbc:Description"
                 priority="1001"
                 mode="M36">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cbc:Description"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cbc:Description element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M36"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cbc:CatalogueIndicator"
                 priority="1000"
                 mode="M36">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cbc:CatalogueIndicator"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cbc:CatalogueIndicator element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M36"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M36"/>
   <xsl:template match="@*|node()" priority="-2" mode="M36">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M36"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_LineItem_Item_TransactionConditions-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:TransactionConditions"
                 priority="1001"
                 mode="M37">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:TransactionConditions"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M37"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:TransactionConditions/cbc:Description"
                 priority="1000"
                 mode="M37">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:TransactionConditions/cbc:Description"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M37"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M37"/>
   <xsl:template match="@*|node()" priority="-2" mode="M37">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M37"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_SellerSubstitutedLineItem-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:SellerSubstitutedLineItem"
                 priority="1000"
                 mode="M38">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:SellerSubstitutedLineItem"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M38"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M38"/>
   <xsl:template match="@*|node()" priority="-2" mode="M38">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M38"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_SellerSubstitutedLineItem_Item-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:SellerSubstitutedLineItem/cac:Item"
                 priority="1000"
                 mode="M39">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:SellerSubstitutedLineItem/cac:Item"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M39"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M39"/>
   <xsl:template match="@*|node()" priority="-2" mode="M39">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M39"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_SellerSubstitutedLineItem_Item_TransactionConditions-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:SellerSubstitutedLineItem/cac:Item/cac:TransactionConditions"
                 priority="1000"
                 mode="M40">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:SellerSubstitutedLineItem/cac:Item/cac:TransactionConditions"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M40"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M40"/>
   <xsl:template match="@*|node()" priority="-2" mode="M40">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M40"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_SellerSubstitutedLineItem_Delivery_DeliveryAddress-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:SellerSubstitutedLineItem/cac:Delivery/cac:DeliveryAddress"
                 priority="1000"
                 mode="M41">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:SellerSubstitutedLineItem/cac:Delivery/cac:DeliveryAddress"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M41"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M41"/>
   <xsl:template match="@*|node()" priority="-2" mode="M41">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M41"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_SellerSubstitutedLineItem_Delivery_DeliveryAddress_Country-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:SellerSubstitutedLineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode"
                 priority="1001"
                 mode="M42">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:SellerSubstitutedLineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M42"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:SellerSubstitutedLineItem/cac:Delivery/cac:DeliveryAddress/cac:Country"
                 priority="1000"
                 mode="M42">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:SellerSubstitutedLineItem/cac:Delivery/cac:DeliveryAddress/cac:Country"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M42"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M42"/>
   <xsl:template match="@*|node()" priority="-2" mode="M42">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M42"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_SellerSubstitutedLineItem_Delivery_RequestedDeliveryPeriod-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:SellerSubstitutedLineItem/cac:Delivery/cac:RequestedDeliveryPeriod"
                 priority="1000"
                 mode="M43">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:SellerSubstitutedLineItem/cac:Delivery/cac:RequestedDeliveryPeriod"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M43"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M43"/>
   <xsl:template match="@*|node()" priority="-2" mode="M43">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M43"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_SellerSubstitutedLineItem_Delivery_DeliveryParty-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:SellerSubstitutedLineItem/cac:Delivery/cac:DeliveryParty"
                 priority="1000"
                 mode="M44">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:SellerSubstitutedLineItem/cac:Delivery/cac:DeliveryParty"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M44"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M44"/>
   <xsl:template match="@*|node()" priority="-2" mode="M44">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M44"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_LineItem_Item_ClassifiedTaxCategory_TaxScheme-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme/cbc:Name"
                 priority="1001"
                 mode="M45">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme/cbc:Name"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Belastingsoort MOET opgegeven worden, veelal 'BTW'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M45"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme"
                 priority="1000"
                 mode="M45">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:Name) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:Name)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Belastingsoort MOET opgegeven worden, veelal 'BTW'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M45"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M45"/>
   <xsl:template match="@*|node()" priority="-2" mode="M45">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M45"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_SellerSubstitutedLineItem_Item_ClassifiedTaxCategory_TaxScheme-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:SellerSubstitutedLineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme/cbc:Name"
                 priority="1001"
                 mode="M46">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:SellerSubstitutedLineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme/cbc:Name"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M46"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:SellerSubstitutedLineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme"
                 priority="1000"
                 mode="M46">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:SellerSubstitutedLineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M46"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M46"/>
   <xsl:template match="@*|node()" priority="-2" mode="M46">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M46"/>
   </xsl:template>

   <!--PATTERN OrderResponse_PaymentMeans_PayeeFinancialAccount-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:ID"
                 priority="1001"
                 mode="M47">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:ID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:ID element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M47"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount"
                 priority="1000"
                 mode="M47">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:ID) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:ID)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:ID element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M47"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M47"/>
   <xsl:template match="@*|node()" priority="-2" mode="M47">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M47"/>
   </xsl:template>

   <!--PATTERN OrderResponse_PaymentMeans_PayeeFinancialAccount_Country-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode"
                 priority="1001"
                 mode="M48">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M48"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country"
                 priority="1000"
                 mode="M48">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:IdentificationCode) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:IdentificationCode)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M48"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M48"/>
   <xsl:template match="@*|node()" priority="-2" mode="M48">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M48"/>
   </xsl:template>

   <!--PATTERN OrderResponse_PaymentMeans_PayeeFinancialAccount_FinancialInstitutionBranch-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch"
                 priority="1000"
                 mode="M49">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:FinancialInstitution) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(cac:FinancialInstitution)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M49"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M49"/>
   <xsl:template match="@*|node()" priority="-2" mode="M49">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M49"/>
   </xsl:template>

   <!--PATTERN OrderResponse_PaymentMeans_PayeeFinancialAccount_FinancialInstitutionBranch_FinancialInstitution-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID"
                 priority="1001"
                 mode="M50">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M50"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution"
                 priority="1000"
                 mode="M50">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:ID) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:ID)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M50"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M50"/>
   <xsl:template match="@*|node()" priority="-2" mode="M50">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M50"/>
   </xsl:template>

   <!--PATTERN OrderResponse_Delivery_EstimatedDeliveryPeriod-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:Delivery/cac:EstimatedDeliveryPeriod"
                 priority="1000"
                 mode="M51">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:Delivery/cac:EstimatedDeliveryPeriod"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M51"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M51"/>
   <xsl:template match="@*|node()" priority="-2" mode="M51">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M51"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_SellerSubstitutedLineItem_Delivery_EstimatedDeliveryPeriod-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:SellerSubstitutedLineItem/cac:Delivery/cac:EstimatedDeliveryPeriod"
                 priority="1000"
                 mode="M52">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:SellerSubstitutedLineItem/cac:Delivery/cac:EstimatedDeliveryPeriod"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M52"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M52"/>
   <xsl:template match="@*|node()" priority="-2" mode="M52">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M52"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_SellerProposedSubstituteLineItem-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem"
                 priority="1001"
                 mode="M53">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M53"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cbc:Quantity"
                 priority="1000"
                 mode="M53">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cbc:Quantity"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(@unitCode) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(@unitCode) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cbc:Quantity/@unitCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M53"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M53"/>
   <xsl:template match="@*|node()" priority="-2" mode="M53">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M53"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Delivery_RequestedDeliveryPeriod-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:RequestedDeliveryPeriod"
                 priority="1000"
                 mode="M54">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:RequestedDeliveryPeriod"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M54"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M54"/>
   <xsl:template match="@*|node()" priority="-2" mode="M54">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M54"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Delivery_DeliveryAddress-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryAddress"
                 priority="1000"
                 mode="M55">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryAddress"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:Country) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:Country)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryAddress/cac:Country element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M55"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M55"/>
   <xsl:template match="@*|node()" priority="-2" mode="M55">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M55"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Delivery_DeliveryAddress_Country-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode"
                 priority="1001"
                 mode="M56">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M56"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryAddress/cac:Country"
                 priority="1000"
                 mode="M56">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryAddress/cac:Country"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:IdentificationCode) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:IdentificationCode)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M56"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M56"/>
   <xsl:template match="@*|node()" priority="-2" mode="M56">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M56"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Delivery_EstimatedDeliveryPeriod-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:EstimatedDeliveryPeriod"
                 priority="1000"
                 mode="M57">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:EstimatedDeliveryPeriod"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M57"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M57"/>
   <xsl:template match="@*|node()" priority="-2" mode="M57">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M57"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Delivery_DeliveryParty-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryParty"
                 priority="1001"
                 mode="M58">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryParty"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:PartyName) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:PartyName)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryParty/cac:PartyName element should exist!</svrl:text>
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
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryParty/cac:PartyName element should be less than 2!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M58"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryParty/cac:Contact"
                 priority="1000"
                 mode="M58">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryParty/cac:Contact"/>

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
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M58"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M58"/>
   <xsl:template match="@*|node()" priority="-2" mode="M58">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M58"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Item-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item"
                 priority="1002"
                 mode="M59">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cbc:Description) lt 2 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cbc:Description) lt 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cbc:Description element should be less than 2!</svrl:text>
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
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cbc:CatalogueIndicator element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:Description) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:Description)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cbc:Description element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M59"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cbc:CatalogueIndicator"
                 priority="1001"
                 mode="M59">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cbc:CatalogueIndicator"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cbc:CatalogueIndicator element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M59"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cbc:Description"
                 priority="1000"
                 mode="M59">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cbc:Description"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cbc:Description element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M59"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M59"/>
   <xsl:template match="@*|node()" priority="-2" mode="M59">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M59"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Item_ClassifiedTaxCategory_TaxScheme-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme/cbc:Name"
                 priority="1001"
                 mode="M60">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme/cbc:Name"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Belastingsoort MOET opgegeven worden, veelal 'BTW'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M60"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme"
                 priority="1000"
                 mode="M60">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:Name) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:Name)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  Belastingsoort MOET opgegeven worden, veelal 'BTW'.</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M60"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M60"/>
   <xsl:template match="@*|node()" priority="-2" mode="M60">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M60"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Item_TransactionConditions-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:TransactionConditions"
                 priority="1001"
                 mode="M61">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:TransactionConditions"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M61"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:TransactionConditions/cbc:Description"
                 priority="1000"
                 mode="M61">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:TransactionConditions/cbc:Description"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M61"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M61"/>
   <xsl:template match="@*|node()" priority="-2" mode="M61">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M61"/>
   </xsl:template>

   <!--PATTERN OrderResponse_FreightForwarderParty-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:FreightForwarderParty" priority="1000" mode="M62">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:FreightForwarderParty"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyName) lt 2 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:PartyName) lt 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:FreightForwarderParty/cac:PartyName element should be less than 2!</svrl:text>
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
               <svrl:text>  /doc:OrderResponse/cac:FreightForwarderParty/cac:PartyIdentification element should be less than 3!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:PartyIdentification) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(cac:PartyIdentification)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:FreightForwarderParty/cac:PartyIdentification element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M62"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M62"/>
   <xsl:template match="@*|node()" priority="-2" mode="M62">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M62"/>
   </xsl:template>

   <!--PATTERN OrderResponse_Delivery_PromisedDeliveryPeriod-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:Delivery/cac:PromisedDeliveryPeriod"
                 priority="1001"
                 mode="M63">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:Delivery/cac:PromisedDeliveryPeriod"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:EndDate) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:EndDate)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:Delivery/cac:PromisedDeliveryPeriod/cbc:EndDate element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M63"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:Delivery/cac:PromisedDeliveryPeriod/cbc:EndDate"
                 priority="1000"
                 mode="M63">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:Delivery/cac:PromisedDeliveryPeriod/cbc:EndDate"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:Delivery/cac:PromisedDeliveryPeriod/cbc:EndDate element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M63"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M63"/>
   <xsl:template match="@*|node()" priority="-2" mode="M63">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M63"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_LineItem_Delivery_PromisedDeliveryPeriod-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:PromisedDeliveryPeriod"
                 priority="1001"
                 mode="M64">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:PromisedDeliveryPeriod"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:EndDate) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:EndDate)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:PromisedDeliveryPeriod/cbc:EndDate element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M64"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:PromisedDeliveryPeriod/cbc:EndDate"
                 priority="1000"
                 mode="M64">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:PromisedDeliveryPeriod/cbc:EndDate"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:PromisedDeliveryPeriod/cbc:EndDate element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M64"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M64"/>
   <xsl:template match="@*|node()" priority="-2" mode="M64">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M64"/>
   </xsl:template>

   <!--PATTERN OrderResponse_SellerSupplierParty_Party_AgentParty-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:AgentParty"
                 priority="1000"
                 mode="M65">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:AgentParty"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M65"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M65"/>
   <xsl:template match="@*|node()" priority="-2" mode="M65">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M65"/>
   </xsl:template>

   <!--PATTERN OrderResponse_SellerSupplierParty_Party_AgentParty_PostalAddress-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:AgentParty/cac:PostalAddress"
                 priority="1000"
                 mode="M66">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:AgentParty/cac:PostalAddress"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M66"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M66"/>
   <xsl:template match="@*|node()" priority="-2" mode="M66">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M66"/>
   </xsl:template>

   <!--PATTERN OrderResponse_SellerSupplierParty_Party_AgentParty_PostalAddress_Country-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode"
                 priority="1001"
                 mode="M67">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M67"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country"
                 priority="1000"
                 mode="M67">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M67"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M67"/>
   <xsl:template match="@*|node()" priority="-2" mode="M67">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M67"/>
   </xsl:template>

   <!--PATTERN OrderResponse_BuyerCustomerParty_Party_AgentParty-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty"
                 priority="1001"
                 mode="M68">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="count(cac:PartyName) lt 2 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(cac:PartyName) lt 2">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PartyName element should be less than 2!</svrl:text>
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
               <svrl:text>  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification element should be less than 3!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:PartyIdentification) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(cac:PartyIdentification)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M68"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:Contact"
                 priority="1000"
                 mode="M68">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:Contact"/>

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
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M68"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M68"/>
   <xsl:template match="@*|node()" priority="-2" mode="M68">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M68"/>
   </xsl:template>

   <!--PATTERN OrderResponse_BuyerCustomerParty_Party_AgentParty_PostalAddress-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress"
                 priority="1000"
                 mode="M69">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:Country) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:Country)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M69"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M69"/>
   <xsl:template match="@*|node()" priority="-2" mode="M69">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M69"/>
   </xsl:template>

   <!--PATTERN OrderResponse_BuyerCustomerParty_Party_AgentParty_PostalAddress_Country-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode"
                 priority="1001"
                 mode="M70">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M70"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country"
                 priority="1000"
                 mode="M70">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:IdentificationCode) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:IdentificationCode)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M70"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M70"/>
   <xsl:template match="@*|node()" priority="-2" mode="M70">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M70"/>
   </xsl:template>

   <!--PATTERN OrderResponse_Delivery_Despatch_DespatchAddress-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:Delivery/cac:Despatch/cac:DespatchAddress"
                 priority="1000"
                 mode="M71">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:Delivery/cac:Despatch/cac:DespatchAddress"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:Country) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:Country)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M71"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M71"/>
   <xsl:template match="@*|node()" priority="-2" mode="M71">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M71"/>
   </xsl:template>

   <!--PATTERN OrderResponse_Delivery_Despatch_DespatchAddress_Country-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country/cbc:IdentificationCode"
                 priority="1001"
                 mode="M72">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country/cbc:IdentificationCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M72"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country"
                 priority="1000"
                 mode="M72">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:IdentificationCode) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:IdentificationCode)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country/cbc:IdentificationCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M72"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M72"/>
   <xsl:template match="@*|node()" priority="-2" mode="M72">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M72"/>
   </xsl:template>

   <!--PATTERN OrderResponse_TaxTotal_TaxSubtotal_TaxCategory_TaxScheme-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:Name"
                 priority="1001"
                 mode="M73">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:Name"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M73"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme"
                 priority="1000"
                 mode="M73">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M73"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M73"/>
   <xsl:template match="@*|node()" priority="-2" mode="M73">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M73"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_LineItem_Price-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Price/cbc:PriceAmount"
                 priority="1001"
                 mode="M74">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Price/cbc:PriceAmount"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="(count(../../../../cbc:PricingCurrencyCode) = 0) or (  (count(../../../../cbc:PricingCurrencyCode) &gt; 0) and  (@currencyID = ../../../../cbc:PricingCurrencyCode/text()) )"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="(count(../../../../cbc:PricingCurrencyCode) = 0) or ( (count(../../../../cbc:PricingCurrencyCode) &gt; 0) and (@currencyID = ../../../../cbc:PricingCurrencyCode/text()) )">
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
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Price/cbc:PriceAmount/@currencyID element should not be empty!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M74"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Price/cbc:BaseQuantity"
                 priority="1000"
                 mode="M74">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Price/cbc:BaseQuantity"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(@unitCode) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(@unitCode) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Price/cbc:BaseQuantity/@unitCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M74"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M74"/>
   <xsl:template match="@*|node()" priority="-2" mode="M74">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M74"/>
   </xsl:template>

   <!--PATTERN OrderResponse_PaymentMeans-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:PaymentMeans/cbc:PaymentMeansCode"
                 priority="1000"
                 mode="M75">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:PaymentMeans/cbc:PaymentMeansCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:PaymentMeans/cbc:PaymentMeansCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M75"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M75"/>
   <xsl:template match="@*|node()" priority="-2" mode="M75">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M75"/>
   </xsl:template>

   <!--PATTERN OrderResponse_BuyerCustomerParty_Party_AgentParty_PartyIdentification-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification/cbc:ID"
                 priority="1000"
                 mode="M76">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification/cbc:ID"/>

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
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M76"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M76"/>
   <xsl:template match="@*|node()" priority="-2" mode="M76">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M76"/>
   </xsl:template>

   <!--PATTERN OrderResponse_BuyerCustomerParty_Party_Contact-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:Contact/cbc:Name"
                 priority="1001"
                 mode="M77">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:Contact/cbc:Name"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:Contact/cbc:Name element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M77"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:Contact"
                 priority="1000"
                 mode="M77">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:Contact"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:Name) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:Name)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:Contact/cbc:Name element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M77"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M77"/>
   <xsl:template match="@*|node()" priority="-2" mode="M77">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M77"/>
   </xsl:template>

   <!--PATTERN OrderResponse_BuyerCustomerParty_Party_PhysicalLocation-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation"
                 priority="1000"
                 mode="M78">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:Address) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:Address)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M78"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M78"/>
   <xsl:template match="@*|node()" priority="-2" mode="M78">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M78"/>
   </xsl:template>

   <!--PATTERN OrderResponse_BuyerCustomerParty_Party_PhysicalLocation_Address-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address"
                 priority="1000"
                 mode="M79">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:Country) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:Country)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M79"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M79"/>
   <xsl:template match="@*|node()" priority="-2" mode="M79">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M79"/>
   </xsl:template>

   <!--PATTERN OrderResponse_BuyerCustomerParty_Party_PhysicalLocation_Address_Country-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode"
                 priority="1001"
                 mode="M80">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M80"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country"
                 priority="1000"
                 mode="M80">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:IdentificationCode) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:IdentificationCode)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M80"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M80"/>
   <xsl:template match="@*|node()" priority="-2" mode="M80">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M80"/>
   </xsl:template>

   <!--PATTERN OrderResponse_Delivery_Despatch-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:Delivery/cac:Despatch" priority="1000" mode="M81">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:Delivery/cac:Despatch"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:DespatchAddress) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:DespatchAddress)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:Delivery/cac:Despatch/cac:DespatchAddress element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M81"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M81"/>
   <xsl:template match="@*|node()" priority="-2" mode="M81">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M81"/>
   </xsl:template>

   <!--PATTERN OrderResponse_LegalMonetaryTotal-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:LegalMonetaryTotal/cbc:LineExtensionAmount"
                 priority="1003"
                 mode="M82">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:LegalMonetaryTotal/cbc:LineExtensionAmount"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:LegalMonetaryTotal/cbc:LineExtensionAmount element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M82"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:LegalMonetaryTotal" priority="1002" mode="M82">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:LegalMonetaryTotal"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:LineExtensionAmount) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(cbc:LineExtensionAmount)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:LegalMonetaryTotal/cbc:LineExtensionAmount element should exist!</svrl:text>
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
               <svrl:text>  /doc:OrderResponse/cac:LegalMonetaryTotal/cbc:TaxExclusiveAmount element should exist!</svrl:text>
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
               <svrl:text>  /doc:OrderResponse/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M82"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:LegalMonetaryTotal/cbc:TaxExclusiveAmount"
                 priority="1001"
                 mode="M82">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:LegalMonetaryTotal/cbc:TaxExclusiveAmount"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:LegalMonetaryTotal/cbc:TaxExclusiveAmount element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M82"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount"
                 priority="1000"
                 mode="M82">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M82"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M82"/>
   <xsl:template match="@*|node()" priority="-2" mode="M82">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M82"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_LineItem_Delivery_DeliveryParty_Contact-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact/cbc:Name"
                 priority="1001"
                 mode="M83">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact/cbc:Name"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact/cbc:Name element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M83"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact"
                 priority="1000"
                 mode="M83">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:Name) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:Name)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact/cbc:Name element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M83"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M83"/>
   <xsl:template match="@*|node()" priority="-2" mode="M83">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M83"/>
   </xsl:template>

   <!--PATTERN OrderResponse_PaymentMeans_PayeeFinancialAccount_FinancialInstitutionBranch_Address-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address"
                 priority="1000"
                 mode="M84">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:Country) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:Country)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M84"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M84"/>
   <xsl:template match="@*|node()" priority="-2" mode="M84">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M84"/>
   </xsl:template>

   <!--PATTERN OrderResponse_PaymentMeans_PayeeFinancialAccount_FinancialInstitutionBranch_Address_Country-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode"
                 priority="1001"
                 mode="M85">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M85"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country"
                 priority="1000"
                 mode="M85">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:IdentificationCode) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:IdentificationCode)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M85"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M85"/>
   <xsl:template match="@*|node()" priority="-2" mode="M85">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M85"/>
   </xsl:template>

   <!--PATTERN OrderResponse_SellerSupplierParty_Party_Contact-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name"
                 priority="1001"
                 mode="M86">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M86"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:Contact"
                 priority="1000"
                 mode="M86">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:Contact"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:Name) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:Name)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M86"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M86"/>
   <xsl:template match="@*|node()" priority="-2" mode="M86">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M86"/>
   </xsl:template>

   <!--PATTERN OrderResponse_AccountingCustomerParty-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:AccountingCustomerParty" priority="1000"
                 mode="M87">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:AccountingCustomerParty"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:Party) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:Party)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:AccountingCustomerParty/cac:Party element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M87"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M87"/>
   <xsl:template match="@*|node()" priority="-2" mode="M87">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M87"/>
   </xsl:template>

   <!--PATTERN OrderResponse_BuyerCustomerParty_Party_AgentParty_Contact-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:Contact/cbc:Name"
                 priority="1001"
                 mode="M88">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:Contact/cbc:Name"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:Contact/cbc:Name element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M88"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:Contact"
                 priority="1000"
                 mode="M88">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:Contact"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:Name) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:Name)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:Contact/cbc:Name element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M88"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M88"/>
   <xsl:template match="@*|node()" priority="-2" mode="M88">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M88"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Delivery-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cbc:Quantity"
                 priority="1002"
                 mode="M89">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cbc:Quantity"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(@unitCode) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(@unitCode) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cbc:Quantity/@unitCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M89"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cbc:ID"
                 priority="1001"
                 mode="M89">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cbc:ID"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M89"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery"
                 priority="1000"
                 mode="M89">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M89"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M89"/>
   <xsl:template match="@*|node()" priority="-2" mode="M89">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M89"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Price-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Price/cbc:BaseQuantity"
                 priority="1000"
                 mode="M90">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Price/cbc:BaseQuantity"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(@unitCode) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(@unitCode) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Price/cbc:BaseQuantity/@unitCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M90"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M90"/>
   <xsl:template match="@*|node()" priority="-2" mode="M90">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M90"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Item_ItemSpecificationDocumentReference_Attachment-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment"
                 priority="1001"
                 mode="M91">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:EmbeddedDocumentBinaryObject) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(cbc:EmbeddedDocumentBinaryObject)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M91"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject"
                 priority="1000"
                 mode="M91">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M91"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M91"/>
   <xsl:template match="@*|node()" priority="-2" mode="M91">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M91"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_DocumentReference-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:DocumentReference/cbc:DocumentType"
                 priority="1001"
                 mode="M92">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:DocumentReference/cbc:DocumentType"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:DocumentReference/cbc:DocumentType element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M92"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:DocumentReference" priority="1000"
                 mode="M92">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:DocumentReference"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:DocumentType) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:DocumentType)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:DocumentReference/cbc:DocumentType element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M92"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M92"/>
   <xsl:template match="@*|node()" priority="-2" mode="M92">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M92"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_DocumentReference_Attachment-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject"
                 priority="1001"
                 mode="M93">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M93"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:DocumentReference/cac:Attachment"
                 priority="1000"
                 mode="M93">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:DocumentReference/cac:Attachment"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:EmbeddedDocumentBinaryObject) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(cbc:EmbeddedDocumentBinaryObject)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M93"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M93"/>
   <xsl:template match="@*|node()" priority="-2" mode="M93">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M93"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_LineItem_Delivery-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cbc:Quantity"
                 priority="1000"
                 mode="M94">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cbc:Quantity"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M94"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M94"/>
   <xsl:template match="@*|node()" priority="-2" mode="M94">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M94"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_LineItem_Delivery-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cbc:Quantity"
                 priority="1000"
                 mode="M95">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cbc:Quantity"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M95"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M95"/>
   <xsl:template match="@*|node()" priority="-2" mode="M95">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M95"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_LineItem_Delivery-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cbc:Quantity"
                 priority="1000"
                 mode="M96">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cbc:Quantity"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M96"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M96"/>
   <xsl:template match="@*|node()" priority="-2" mode="M96">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M96"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_LineItem_Delivery-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cbc:Quantity"
                 priority="1000"
                 mode="M97">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cbc:Quantity"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(@unitCode) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(@unitCode) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cbc:Quantity/@unitCode element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M97"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M97"/>
   <xsl:template match="@*|node()" priority="-2" mode="M97">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M97"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_LineItem_Item_ItemSpecificationDocumentReference_Attachment-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject"
                 priority="1001"
                 mode="M98">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M98"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment"
                 priority="1000"
                 mode="M98">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:EmbeddedDocumentBinaryObject) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="exists(cbc:EmbeddedDocumentBinaryObject)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M98"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M98"/>
   <xsl:template match="@*|node()" priority="-2" mode="M98">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M98"/>
   </xsl:template>

   <!--PATTERN OrderResponse_TaxTotal-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:TaxTotal" priority="1000" mode="M99">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:TaxTotal"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:TaxSubtotal) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:TaxSubtotal)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:TaxTotal/cac:TaxSubtotal element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M99"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M99"/>
   <xsl:template match="@*|node()" priority="-2" mode="M99">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M99"/>
   </xsl:template>

   <!--PATTERN OrderResponse_TaxTotal-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:TaxTotal" priority="1000" mode="M100">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:TaxTotal"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cac:TaxSubtotal) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cac:TaxSubtotal)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:TaxTotal/cac:TaxSubtotal element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M100"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M100"/>
   <xsl:template match="@*|node()" priority="-2" mode="M100">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M100"/>
   </xsl:template>

   <!--PATTERN OrderResponse_Delivery-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:Delivery/cbc:ID" priority="1001" mode="M101">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:Delivery/cbc:ID"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M101"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:Delivery" priority="1000" mode="M101">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:Delivery"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M101"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M101"/>
   <xsl:template match="@*|node()" priority="-2" mode="M101">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M101"/>
   </xsl:template>

   <!--PATTERN OrderResponse_FreightForwarderParty_PartyIdentification-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:FreightForwarderParty/cac:PartyIdentification/cbc:ID"
                 priority="1000"
                 mode="M102">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:FreightForwarderParty/cac:PartyIdentification/cbc:ID"/>

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
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M102"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M102"/>
   <xsl:template match="@*|node()" priority="-2" mode="M102">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M102"/>
   </xsl:template>

   <!--PATTERN OrderResponse_FreightForwarderParty_PartyIdentification-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:FreightForwarderParty/cac:PartyIdentification/cbc:ID"
                 priority="1000"
                 mode="M103">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:FreightForwarderParty/cac:PartyIdentification/cbc:ID"/>

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
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M103"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M103"/>
   <xsl:template match="@*|node()" priority="-2" mode="M103">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M103"/>
   </xsl:template>

   <!--PATTERN OrderResponse_FreightForwarderParty_PartyIdentification-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:FreightForwarderParty/cac:PartyIdentification/cbc:ID"
                 priority="1000"
                 mode="M104">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:FreightForwarderParty/cac:PartyIdentification/cbc:ID"/>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M104"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M104"/>
   <xsl:template match="@*|node()" priority="-2" mode="M104">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M104"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_LineItem_DeliveryTerms-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID"
                 priority="1001"
                 mode="M105">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID element should exist!</svrl:text>
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
         <xsl:when test="normalize-space (@schemeName) = 'DeliveryTermsCode'"/>
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
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M105"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms"
                 priority="1000"
                 mode="M105">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:ID) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:ID)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M105"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M105"/>
   <xsl:template match="@*|node()" priority="-2" mode="M105">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M105"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Delivery_DeliveryParty_Contact-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryParty/cac:Contact/cbc:Name"
                 priority="1001"
                 mode="M106">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryParty/cac:Contact/cbc:Name"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryParty/cac:Contact/cbc:Name element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M106"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryParty/cac:Contact"
                 priority="1000"
                 mode="M106">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryParty/cac:Contact"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:Name) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:Name)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryParty/cac:Contact/cbc:Name element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M106"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M106"/>
   <xsl:template match="@*|node()" priority="-2" mode="M106">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M106"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Delivery_PromisedDeliveryPeriod-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:PromisedDeliveryPeriod/cbc:EndDate"
                 priority="1001"
                 mode="M107">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:PromisedDeliveryPeriod/cbc:EndDate"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:PromisedDeliveryPeriod/cbc:EndDate element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M107"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:PromisedDeliveryPeriod"
                 priority="1000"
                 mode="M107">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:PromisedDeliveryPeriod"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:EndDate) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:EndDate)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:PromisedDeliveryPeriod/cbc:EndDate element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M107"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M107"/>
   <xsl:template match="@*|node()" priority="-2" mode="M107">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M107"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_SellerProposedSubstituteLineItem_DeliveryTerms-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID"
                 priority="1001"
                 mode="M108">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID element should exist!</svrl:text>
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
         <xsl:when test="normalize-space(@schemeURI ) = 'http://www.nltaxonomie.nl/ubl/2.0/NL/1.6/cl/gc/DeliveryTermsCode.gc'"/>
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
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M108"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms"
                 priority="1000"
                 mode="M108">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:ID) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:ID)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M108"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M108"/>
   <xsl:template match="@*|node()" priority="-2" mode="M108">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M108"/>
   </xsl:template>

   <!--PATTERN OrderResponse_DeliveryTerms-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:DeliveryTerms/cbc:ID" priority="1001" mode="M109">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:DeliveryTerms/cbc:ID"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="string-length(text()) &gt; 0 "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="string-length(text()) &gt; 0">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:DeliveryTerms/cbc:ID element should exist!</svrl:text>
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
         <xsl:when test="normalize-space(@schemeURI ) = 'http://www.nltaxonomie.nl/ubl/2.0/NL/1.6/cl/gc/DeliveryTermsCode.gc'"/>
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
         <xsl:when test="normalize-space (@schemeName) = 'DeliveryTermsCode'"/>
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
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M109"/>
   </xsl:template>

	  <!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:DeliveryTerms" priority="1000" mode="M109">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:DeliveryTerms"/>

		    <!--ASSERT -->
<xsl:choose>
         <xsl:when test="exists(cbc:ID) "/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="exists(cbc:ID)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>  /doc:OrderResponse/cac:DeliveryTerms/cbc:ID element should exist!</svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M109"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M109"/>
   <xsl:template match="@*|node()" priority="-2" mode="M109">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M109"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_LineItem_Item_ClassifiedTaxCategory-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme"
                 priority="1000"
                 mode="M110">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme"/>

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
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M110"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M110"/>
   <xsl:template match="@*|node()" priority="-2" mode="M110">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M110"/>
   </xsl:template>

   <!--PATTERN OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Item_ClassifiedTaxCategory-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme"
                 priority="1000"
                 mode="M111">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme"/>

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
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M111"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M111"/>
   <xsl:template match="@*|node()" priority="-2" mode="M111">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M111"/>
   </xsl:template>

   <!--PATTERN OrderResponse_TaxTotal_TaxSubtotal_TaxCategory-->


	<!--RULE -->
<xsl:template match="/doc:OrderResponse/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme"
                 priority="1000"
                 mode="M112">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="/doc:OrderResponse/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme"/>

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
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M112"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M112"/>
   <xsl:template match="@*|node()" priority="-2" mode="M112">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M112"/>
   </xsl:template>
</xsl:stylesheet>