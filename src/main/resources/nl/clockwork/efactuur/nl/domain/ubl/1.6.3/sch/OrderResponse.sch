<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <title>Validations for OrderResponse Mapping</title>
  <ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" />
  <ns prefix="doc" uri="urn:oasis:names:specification:ubl:schema:xsd:OrderResponse-2" />
  <ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" />
  <pattern id="cardinality-redefines">
    <rule context="doc:OrderResponse">
      <assert test="count(cac:Contract) &lt;= 1">doc:OrderResponse may contain cac:Contract at most 1 time(s)</assert>
      <assert test="count(cac:Delivery) &lt;= 1">doc:OrderResponse may contain cac:Delivery at most 1 time(s)</assert>
      <assert test="count(cac:OrderReference) &lt;= 1">doc:OrderResponse may contain cac:OrderReference at most 1 time(s)</assert>
      <assert test="count(cac:TaxTotal) &lt;= 1">doc:OrderResponse may contain cac:TaxTotal at most 1 time(s)</assert>
      <assert test="count(cbc:CustomizationID) &gt;= 1">doc:OrderResponse must contain cbc:CustomizationID at least 1 time(s)</assert>
      <assert test="count(cbc:Note) &lt;= 1">doc:OrderResponse may contain cbc:Note at most 1 time(s)</assert>
      <assert test="count(cbc:ProfileID) &gt;= 1">doc:OrderResponse must contain cbc:ProfileID at least 1 time(s)</assert>
      <assert test="count(cbc:UBLVersionID) &gt;= 1">doc:OrderResponse must contain cbc:UBLVersionID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:AccountingCustomerParty">
      <assert test="count(cac:Party) &gt;= 1">doc:OrderResponse/cac:AccountingCustomerParty must contain cac:Party at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:AccountingCustomerParty/cac:Party">
      <assert test="count(cac:PartyIdentification) &gt;= 1 and count(cac:PartyIdentification) &lt;= 2">doc:OrderResponse/cac:AccountingCustomerParty/cac:Party must contain cac:PartyIdentification at least 1 and at most 2 time(s)</assert>
      <assert test="count(cac:PartyName) &gt;= 1 and count(cac:PartyName) &lt;= 1">doc:OrderResponse/cac:AccountingCustomerParty/cac:Party must contain cac:PartyName at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification/cbc:ID">
      <assert test="count(@schemeAgencyName) &gt;= 1">doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID">
      <assert test="count(@schemeAgencyName) &gt;= 1">doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress">
      <assert test="count(cac:Country) &gt;= 1">doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress must contain cac:Country at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:BuyerCustomerParty">
      <assert test="count(cac:Party) &gt;= 1">doc:OrderResponse/cac:BuyerCustomerParty must contain cac:Party at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:BuyerCustomerParty/cac:Party">
      <assert test="count(cac:Contact) &gt;= 1">doc:OrderResponse/cac:BuyerCustomerParty/cac:Party must contain cac:Contact at least 1 time(s)</assert>
      <assert test="count(cac:PartyIdentification) &gt;= 1 and count(cac:PartyIdentification) &lt;= 2">doc:OrderResponse/cac:BuyerCustomerParty/cac:Party must contain cac:PartyIdentification at least 1 and at most 2 time(s)</assert>
      <assert test="count(cac:PartyName) &gt;= 1 and count(cac:PartyName) &lt;= 1">doc:OrderResponse/cac:BuyerCustomerParty/cac:Party must contain cac:PartyName at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty">
      <assert test="count(cac:PartyIdentification) &gt;= 1 and count(cac:PartyIdentification) &lt;= 2">doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty must contain cac:PartyIdentification at least 1 and at most 2 time(s)</assert>
      <assert test="count(cac:PartyName) &lt;= 1">doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty may contain cac:PartyName at most 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:Contact">
      <assert test="count(cbc:Name) &gt;= 1">doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:Contact must contain cbc:Name at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification/cbc:ID">
      <assert test="count(@schemeAgencyName) &gt;= 1">doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress">
      <assert test="count(cac:Country) &gt;= 1">doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress must contain cac:Country at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:Contact">
      <assert test="count(cbc:Name) &gt;= 1">doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:Contact must contain cbc:Name at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID">
      <assert test="count(@schemeAgencyName) &gt;= 1">doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation">
      <assert test="count(cac:Address) &gt;= 1">doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation must contain cac:Address at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address">
      <assert test="count(cac:Country) &gt;= 1">doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address must contain cac:Country at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:Contract">
      <assert test="count(cbc:ID) &gt;= 1">doc:OrderResponse/cac:Contract must contain cbc:ID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:Delivery/cac:DeliveryAddress">
      <assert test="count(cac:Country) &gt;= 1">doc:OrderResponse/cac:Delivery/cac:DeliveryAddress must contain cac:Country at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:Delivery/cac:DeliveryAddress/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:OrderResponse/cac:Delivery/cac:DeliveryAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:Delivery/cac:Despatch">
      <assert test="count(cac:DespatchAddress) &gt;= 1">doc:OrderResponse/cac:Delivery/cac:Despatch must contain cac:DespatchAddress at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:Delivery/cac:Despatch/cac:DespatchAddress">
      <assert test="count(cac:Country) &gt;= 1">doc:OrderResponse/cac:Delivery/cac:Despatch/cac:DespatchAddress must contain cac:Country at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:OrderResponse/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:Delivery/cac:PromisedDeliveryPeriod">
      <assert test="count(cbc:EndDate) &gt;= 1">doc:OrderResponse/cac:Delivery/cac:PromisedDeliveryPeriod must contain cbc:EndDate at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:DeliveryTerms">
      <assert test="count(cbc:ID) &gt;= 1">doc:OrderResponse/cac:DeliveryTerms must contain cbc:ID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:DeliveryTerms/cbc:ID">
      <assert test="count(@schemeAgencyID) &gt;= 1">doc:OrderResponse/cac:DeliveryTerms/cbc:ID must contain @schemeAgencyID at least 1 time(s)</assert>
      <assert test="count(@schemeAgencyName) &gt;= 1">doc:OrderResponse/cac:DeliveryTerms/cbc:ID must contain @schemeAgencyName at least 1 time(s)</assert>
      <assert test="count(@schemeDataURI) &gt;= 1">doc:OrderResponse/cac:DeliveryTerms/cbc:ID must contain @schemeDataURI at least 1 time(s)</assert>
      <assert test="count(@schemeID) &gt;= 1">doc:OrderResponse/cac:DeliveryTerms/cbc:ID must contain @schemeID at least 1 time(s)</assert>
      <assert test="count(@schemeName) &gt;= 1">doc:OrderResponse/cac:DeliveryTerms/cbc:ID must contain @schemeName at least 1 time(s)</assert>
      <assert test="count(@schemeURI) &gt;= 1">doc:OrderResponse/cac:DeliveryTerms/cbc:ID must contain @schemeURI at least 1 time(s)</assert>
      <assert test="count(@schemeVersionID) &gt;= 1">doc:OrderResponse/cac:DeliveryTerms/cbc:ID must contain @schemeVersionID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:FreightForwarderParty">
      <assert test="count(cac:PartyIdentification) &gt;= 1 and count(cac:PartyIdentification) &lt;= 2">doc:OrderResponse/cac:FreightForwarderParty must contain cac:PartyIdentification at least 1 and at most 2 time(s)</assert>
      <assert test="count(cac:PartyName) &lt;= 1">doc:OrderResponse/cac:FreightForwarderParty may contain cac:PartyName at most 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:FreightForwarderParty/cac:PartyIdentification/cbc:ID">
      <assert test="count(@schemeAgencyName) &gt;= 1">doc:OrderResponse/cac:FreightForwarderParty/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:LegalMonetaryTotal">
      <assert test="count(cbc:LineExtensionAmount) &gt;= 1">doc:OrderResponse/cac:LegalMonetaryTotal must contain cbc:LineExtensionAmount at least 1 time(s)</assert>
      <assert test="count(cbc:TaxExclusiveAmount) &gt;= 1">doc:OrderResponse/cac:LegalMonetaryTotal must contain cbc:TaxExclusiveAmount at least 1 time(s)</assert>
      <assert test="count(cbc:TaxInclusiveAmount) &gt;= 1">doc:OrderResponse/cac:LegalMonetaryTotal must contain cbc:TaxInclusiveAmount at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:DocumentReference">
      <assert test="count(cbc:DocumentType) &gt;= 1">doc:OrderResponse/cac:OrderLine/cac:DocumentReference must contain cbc:DocumentType at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:DocumentReference/cac:Attachment">
      <assert test="count(cbc:EmbeddedDocumentBinaryObject) &gt;= 1">doc:OrderResponse/cac:OrderLine/cac:DocumentReference/cac:Attachment must contain cbc:EmbeddedDocumentBinaryObject at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:LineItem">
      <assert test="count(cac:Price) &gt;= 1">doc:OrderResponse/cac:OrderLine/cac:LineItem must contain cac:Price at least 1 time(s)</assert>
      <assert test="count(cbc:Quantity) &gt;= 1">doc:OrderResponse/cac:OrderLine/cac:LineItem must contain cbc:Quantity at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress">
      <assert test="count(cac:Country) &gt;= 1">doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress must contain cac:Country at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty">
      <assert test="count(cac:PartyName) &gt;= 1 and count(cac:PartyName) &lt;= 1">doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty must contain cac:PartyName at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact">
      <assert test="count(cbc:Name) &gt;= 1">doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact must contain cbc:Name at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:PromisedDeliveryPeriod">
      <assert test="count(cbc:EndDate) &gt;= 1">doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:PromisedDeliveryPeriod must contain cbc:EndDate at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms">
      <assert test="count(cbc:ID) &gt;= 1">doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms must contain cbc:ID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID">
      <assert test="count(@schemeAgencyID) &gt;= 1">doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID must contain @schemeAgencyID at least 1 time(s)</assert>
      <assert test="count(@schemeAgencyName) &gt;= 1">doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID must contain @schemeAgencyName at least 1 time(s)</assert>
      <assert test="count(@schemeDataURI) &gt;= 1">doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID must contain @schemeDataURI at least 1 time(s)</assert>
      <assert test="count(@schemeID) &gt;= 1">doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID must contain @schemeID at least 1 time(s)</assert>
      <assert test="count(@schemeName) &gt;= 1">doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID must contain @schemeName at least 1 time(s)</assert>
      <assert test="count(@schemeURI) &gt;= 1">doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID must contain @schemeURI at least 1 time(s)</assert>
      <assert test="count(@schemeVersionID) &gt;= 1">doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID must contain @schemeVersionID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item">
      <assert test="count(cbc:CatalogueIndicator) &gt;= 1">doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item must contain cbc:CatalogueIndicator at least 1 time(s)</assert>
      <assert test="count(cbc:Description) &lt;= 1">doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item may contain cbc:Description at most 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme">
      <assert test="count(cbc:Name) &gt;= 1">doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme must contain cbc:Name at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment">
      <assert test="count(cbc:EmbeddedDocumentBinaryObject) &gt;= 1">doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment must contain cbc:EmbeddedDocumentBinaryObject at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:LineItem/cbc:Quantity">
      <assert test="count(@unitCode) &gt;= 1">doc:OrderResponse/cac:OrderLine/cac:LineItem/cbc:Quantity must contain @unitCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryAddress">
      <assert test="count(cac:Country) &gt;= 1">doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryAddress must contain cac:Country at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryAddress/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryParty">
      <assert test="count(cac:PartyName) &gt;= 1 and count(cac:PartyName) &lt;= 1">doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryParty must contain cac:PartyName at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryParty/cac:Contact">
      <assert test="count(cbc:Name) &gt;= 1">doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryParty/cac:Contact must contain cbc:Name at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:PromisedDeliveryPeriod">
      <assert test="count(cbc:EndDate) &gt;= 1">doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:PromisedDeliveryPeriod must contain cbc:EndDate at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms">
      <assert test="count(cbc:ID) &gt;= 1">doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms must contain cbc:ID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID">
      <assert test="count(@schemeAgencyID) &gt;= 1">doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID must contain @schemeAgencyID at least 1 time(s)</assert>
      <assert test="count(@schemeAgencyName) &gt;= 1">doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID must contain @schemeAgencyName at least 1 time(s)</assert>
      <assert test="count(@schemeDataURI) &gt;= 1">doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID must contain @schemeDataURI at least 1 time(s)</assert>
      <assert test="count(@schemeID) &gt;= 1">doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID must contain @schemeID at least 1 time(s)</assert>
      <assert test="count(@schemeName) &gt;= 1">doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID must contain @schemeName at least 1 time(s)</assert>
      <assert test="count(@schemeURI) &gt;= 1">doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID must contain @schemeURI at least 1 time(s)</assert>
      <assert test="count(@schemeVersionID) &gt;= 1">doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID must contain @schemeVersionID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item">
      <assert test="count(cbc:CatalogueIndicator) &gt;= 1">doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item must contain cbc:CatalogueIndicator at least 1 time(s)</assert>
      <assert test="count(cbc:Description) &lt;= 1">doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item may contain cbc:Description at most 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme">
      <assert test="count(cbc:Name) &gt;= 1">doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme must contain cbc:Name at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment">
      <assert test="count(cbc:EmbeddedDocumentBinaryObject) &gt;= 1">doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment must contain cbc:EmbeddedDocumentBinaryObject at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount">
      <assert test="count(cbc:ID) &gt;= 1">doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount must contain cbc:ID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch">
      <assert test="count(cac:FinancialInstitution) &gt;= 1">doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch must contain cac:FinancialInstitution at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address">
      <assert test="count(cac:Country) &gt;= 1">doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address must contain cac:Country at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution">
      <assert test="count(cbc:ID) &gt;= 1">doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution must contain cbc:ID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:SellerSupplierParty">
      <assert test="count(cac:Party) &gt;= 1">doc:OrderResponse/cac:SellerSupplierParty must contain cac:Party at least 1 time(s)</assert>
      <assert test="count(cbc:CustomerAssignedAccountID) &gt;= 1">doc:OrderResponse/cac:SellerSupplierParty must contain cbc:CustomerAssignedAccountID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:SellerSupplierParty/cac:Party">
      <assert test="count(cac:PartyIdentification) &gt;= 1 and count(cac:PartyIdentification) &lt;= 2">doc:OrderResponse/cac:SellerSupplierParty/cac:Party must contain cac:PartyIdentification at least 1 and at most 2 time(s)</assert>
      <assert test="count(cac:PartyName) &gt;= 1 and count(cac:PartyName) &lt;= 1">doc:OrderResponse/cac:SellerSupplierParty/cac:Party must contain cac:PartyName at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:Contact">
      <assert test="count(cbc:Name) &gt;= 1">doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:Contact must contain cbc:Name at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID">
      <assert test="count(@schemeAgencyName) &gt;= 1">doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PostalAddress">
      <assert test="count(cac:Country) &gt;= 1">doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PostalAddress must contain cac:Country at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:TaxTotal">
      <assert test="count(cac:TaxSubtotal) &gt;= 1">doc:OrderResponse/cac:TaxTotal must contain cac:TaxSubtotal at least 1 time(s)</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
      <assert test="count(cbc:Name) &gt;= 1">doc:OrderResponse/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme must contain cbc:Name at least 1 time(s)</assert>
    </rule>
  </pattern>
  <pattern id="type-restrictions">
    <rule context="doc:OrderResponse">
      <assert test="every $bn in //cbc:BuildingNumber satisfies (matches($bn,'^\d+(-[ \w]+)?$'))">Huisnummer en Huisnummertoevoeging moeten achter elkaar geplaatst worden, gescheiden met een koppelteken.</assert>
      <assert test="every $id in //cac:PartyIdentification/cbc:ID satisfies (exists($id/@schemeAgencyID) and not(empty($id/@schemeAgencyID)) and exists($id/@schemeAgencyName) and not(empty($id/@schemeAgencyName)))">PartyIdentification/ID MOET @schemeAgencyID en @schemeAgencyName attributen bevatten.</assert>
      <assert test="every $pa in //cac:PostalAddress satisfies ((not(empty($pa/cbc:Postbox)) and empty($pa/cbc:StreetName) and empty($pa/cbc:BuildingNumber) and empty(cbc:Room) and empty(cbc:Floor) and empty(cbc:Department) and empty(cbc:InhouseMail) and empty(cbc:PlotIdentification)) or (empty($pa/cbc:Postbox) and (not(empty($pa/cbc:StreetName)) or not(empty($pa/cbc:BuildingNumber)) or not(empty(cbc:Room)) or not(empty(cbc:Floor)) or not(empty(cbc:Department)) or not(empty(cbc:InhouseMail)) or not(empty(cbc:PlotIdentification)))))">PostalAddress MOET OF een Postbox bevatten OF minimaal 1 van de elementen StreetName, BuildingNumber, Room, Floor, Department, InhouseMail of PlotIdentification. Beide MAG NIET.</assert>
      <assert test="( (count(cac:Delivery/cac:DeliveryAddress) = 0) and (count(cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress) = count(cac:OrderLine/cac:LineItem)))or( (count(cac:Delivery/cac:DeliveryAddress) > 0) and (count(cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress) = 0))"> Afleveradres MOET OF op algemeen niveau OF voor alle regels worden opgegeven.</assert>
      <assert test="( (count(cbc:AccountingCostCode) = 0) and (count(cac:OrderLine/cac:LineItem/cbc:AccountingCostCode) = count(cac:OrderLine/cac:LineItem)))or( (count(cbc:AccountingCostCode) > 0) and (count(cac:OrderLine/cac:LineItem/cbc:AccountingCostCode) = 0))"> Kostenplaats MOET OF op algemeen niveau OF voor alle regels worden opgegeven.</assert>
      <assert test="(count(cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact) = count(cac:OrderLine/cac:LineItem))or(count(cac:SellerSupplierParty/cac:Party/cac:Contact) > 0)"> Leverancier contactpersoon MOET voor alle regels worden opgegeven ALS NIET op algemeen niveau opgegeven.</assert>
      <assert test="( (count(cac:Delivery/cac:PromisedDeliveryPeriod) = 0) and (count(cac:OrderLine/cac:LineItem/cac:Delivery/cac:PromisedDeliveryPeriod) = count(cac:OrderLine/cac:LineItem)))or( (count(cac:Delivery/cac:PromisedDeliveryPeriod) > 0) and (count(cac:OrderLine/cac:LineItem/cac:Delivery/cac:PromisedDeliveryPeriod) = 0))">Levertijd MOET OF op algemeen niveau OF voor alle regels worden opgegeven.</assert>
      <assert test="empty(cbc:CustomizationID) or (cbc:CustomizationID='1.6')">Bericht MOET gebaseerd zijn op versie 1.6 van de Nederlandse specificatie.</assert>
      <assert test="empty(cbc:ProfileID) or (cbc:ProfileID='NL')">Bericht MOET op de Nederlandse (NL) specificatie gebaseerd zijn.</assert>
      <assert test="empty(cbc:UBLVersionID) or (cbc:UBLVersionID='2.0')">Bericht MOET gebaseerd zijn op UBL Versie 2.0</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification/cbc:ID">
      <assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</assert>
      <assert test="empty(@schemeAgencyName) or (@schemeAgencyName='KvK') or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')">Uitgevende organisatie van de PartijIdentificatie MOET geïdentificeerd worden door een code uit de lijst: KvK, BTW, Fi, BSN, OIN, XXX.</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID">
      <assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</assert>
      <assert test="empty(@schemeAgencyName) or (@schemeAgencyName='KvK') or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')">Uitgevende organisatie van de PartijIdentificatie MOET geïdentificeerd worden door een code uit de lijst: KvK, BTW, Fi, BSN, OIN, XXX.</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode">
      <assert test="string-length() > 0">doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must be filled</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:Contact">
      <assert test="matches(cbc:Telefax, '^[-0-9]*$')">Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</assert>
      <assert test="matches(cbc:Telephone, '^[-0-9]*$')">Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:Contact/cbc:Name">
      <assert test="string-length() > 0">doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:Contact/cbc:Name must be filled</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification/cbc:ID">
      <assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</assert>
      <assert test="empty(@schemeAgencyName) or (@schemeAgencyName='KvK') or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')">Uitgevende organisatie van de PartijIdentificatie MOET geïdentificeerd worden door een code uit de lijst: KvK, BTW, Fi, BSN, OIN, XXX.</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode">
      <assert test="string-length() > 0">doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode must be filled</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:Contact">
      <assert test="matches(cbc:Telefax, '^[-0-9]*$')">Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</assert>
      <assert test="matches(cbc:Telephone, '^[-0-9]*$')">Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:Contact/cbc:Name">
      <assert test="string-length() > 0">doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:Contact/cbc:Name must be filled</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID">
      <assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</assert>
      <assert test="empty(@schemeAgencyName) or (@schemeAgencyName='KvK') or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')">Uitgevende organisatie van de PartijIdentificatie MOET geïdentificeerd worden door een code uit de lijst: KvK, BTW, Fi, BSN, OIN, XXX.</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode">
      <assert test="string-length() > 0">doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must be filled</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:Contract/cbc:ID">
      <assert test="string-length() > 0">doc:OrderResponse/cac:Contract/cbc:ID must be filled</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode">
      <assert test="string-length() > 0">doc:OrderResponse/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must be filled</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country/cbc:IdentificationCode">
      <assert test="string-length() > 0">doc:OrderResponse/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country/cbc:IdentificationCode must be filled</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:DeliveryTerms/cbc:ID">
      <assert test="string-length() > 0">doc:OrderResponse/cac:DeliveryTerms/cbc:ID must be filled</assert>
      <assert test="empty(@schemeAgencyID) or (@schemeAgencyID='88')">doc:OrderResponse/cac:DeliveryTerms/cbc:ID/@schemeAgencyID must have one of the following values: [88]</assert>
      <assert test="empty(@schemeAgencyName) or (@schemeAgencyName='Logius Gegevensbeheer NL-Overheid')">doc:OrderResponse/cac:DeliveryTerms/cbc:ID/@schemeAgencyName must have one of the following values: [Logius Gegevensbeheer NL-Overheid]</assert>
      <assert test="empty(@schemeDataURI) or (@schemeDataURI='urn:digi-inkoop:ubl:2.0:NL:1.6:gc:DeliveryTermsCode')">doc:OrderResponse/cac:DeliveryTerms/cbc:ID/@schemeDataURI must have one of the following values: [urn:digi-inkoop:ubl:2.0:NL:1.6:gc:DeliveryTermsCode]</assert>
      <assert test="empty(@schemeID) or (@schemeID='NL-1002')">doc:OrderResponse/cac:DeliveryTerms/cbc:ID/@schemeID must have one of the following values: [NL-1002]</assert>
      <assert test="empty(@schemeName) or (@schemeName='DeliveryTermsCode')">doc:OrderResponse/cac:DeliveryTerms/cbc:ID/@schemeName must have one of the following values: [DeliveryTermsCode]</assert>
      <assert test="empty(@schemeURI) or (@schemeURI='http://www.nltaxonomie.nl/ubl/2.0/NL/1.6/cl/gc/DeliveryTermsCode.gc')">doc:OrderResponse/cac:DeliveryTerms/cbc:ID/@schemeURI must have one of the following values: [http://www.nltaxonomie.nl/ubl/2.0/NL/1.6/cl/gc/DeliveryTermsCode.gc]</assert>
      <assert test="empty(@schemeVersionID) or (@schemeVersionID='1.6')">doc:OrderResponse/cac:DeliveryTerms/cbc:ID/@schemeVersionID must have one of the following values: [1.6]</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:FreightForwarderParty/cac:PartyIdentification/cbc:ID">
      <assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</assert>
      <assert test="empty(@schemeAgencyName) or (@schemeAgencyName='KvK') or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')">Uitgevende organisatie van de PartijIdentificatie MOET geïdentificeerd worden door een code uit de lijst: KvK, BTW, Fi, BSN, OIN, XXX.</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject">
      <assert test="string-length() > 0">doc:OrderResponse/cac:OrderLine/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject must be filled</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:DocumentReference/cbc:DocumentType">
      <assert test="string-length() > 0"> DocumentType MOET gevuld worden met de soort identificatie van het document: 'Bestelling' of 'Contract' of 'Specificatie' in geval er een bijlage meegezonden wordt.</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode">
      <assert test="string-length() > 0">doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must be filled</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact">
      <assert test="matches(cbc:Telefax, '^[-0-9]*$')">Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</assert>
      <assert test="matches(cbc:Telephone, '^[-0-9]*$')">Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact/cbc:Name">
      <assert test="string-length() > 0">doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact/cbc:Name must be filled</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cbc:Quantity/@unitCode">
      <assert test="string-length() > 0">doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cbc:Quantity/@unitCode must be filled</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID">
      <assert test="string-length() > 0">doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID must be filled</assert>
      <assert test="empty(@schemeAgencyID) or (@schemeAgencyID='88')">doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID/@schemeAgencyID must have one of the following values: [88]</assert>
      <assert test="empty(@schemeAgencyName) or (@schemeAgencyName='Logius Gegevensbeheer NL-Overheid')">doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID/@schemeAgencyName must have one of the following values: [Logius Gegevensbeheer NL-Overheid]</assert>
      <assert test="empty(@schemeDataURI) or (@schemeDataURI='urn:digi-inkoop:ubl:2.0:NL:1.6:gc:DeliveryTermsCode')">doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID/@schemeDataURI must have one of the following values: [urn:digi-inkoop:ubl:2.0:NL:1.6:gc:DeliveryTermsCode]</assert>
      <assert test="empty(@schemeID) or (@schemeID='NL-1002')">doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID/@schemeID must have one of the following values: [NL-1002]</assert>
      <assert test="empty(@schemeName) or (@schemeName='DeliveryTermsCode')">doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID/@schemeName must have one of the following values: [DeliveryTermsCode]</assert>
      <assert test="empty(@schemeURI) or (@schemeURI='http://www.nltaxonomie.nl/ubl/2.0/NL/1.6/cl/gc/DeliveryTermsCode.gc')">doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID/@schemeURI must have one of the following values: [http://www.nltaxonomie.nl/ubl/2.0/NL/1.6/cl/gc/DeliveryTermsCode.gc]</assert>
      <assert test="empty(@schemeVersionID) or (@schemeVersionID='1.6')">doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID/@schemeVersionID must have one of the following values: [1.6]</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item">
      <assert test="( (count(cbc:Description) = 0) and (   (count(cac:BuyersItemIdentification/cbc:ID) + count(cac:SellersItemIdentification/cbc:ID) + count(cac:ManufacturersItemIdentification/cbc:ID) + count(cac:StandardItemIdentification/cbc:ID) + count(cac:CatalogueItemIdentification/cbc:ID)) > 0 ))or( (count(cbc:Description) > 0) and (   (count(cac:BuyersItemIdentification/cbc:ID) + count(cac:SellersItemIdentification/cbc:ID) + count(cac:ManufacturersItemIdentification/cbc:ID) + count(cac:StandardItemIdentification/cbc:ID) + count(cac:CatalogueItemIdentification/cbc:ID)) = 0 ))"> Item MOET OF een Description OF een (party)Identification/ID bevatten.</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme">
      <assert test="empty(cbc:Name) or (cbc:Name='BTW') or (cbc:Name='Accijns') or (cbc:Name='Toeslag') or (cbc:Name='Overige')">doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme/cbc:Name must have one of the following values: [BTW, Accijns, Toeslag, Overige]</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject">
      <assert test="string-length() > 0">doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject must be filled</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cbc:Description">
      <assert test="string-length() > 0">doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cbc:Description must be filled</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Price/cbc:BaseQuantity/@unitCode">
      <assert test="string-length() > 0">doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Price/cbc:BaseQuantity/@unitCode must be filled</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Price/cbc:PriceAmount">
      <assert test="(count(../../../../cbc:PricingCurrencyCode) = 0)or( (count(../../../../cbc:PricingCurrencyCode) > 0) and (@currencyID = ../../../../cbc:PricingCurrencyCode/text()))">Valutacode op regelniveau MOET gelijk zijn aan algemeen niveau als opgegeven.</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:LineItem/cbc:Quantity/@unitCode">
      <assert test="string-length() > 0">doc:OrderResponse/cac:OrderLine/cac:LineItem/cbc:Quantity/@unitCode must be filled</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode">
      <assert test="string-length() > 0">doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must be filled</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryParty/cac:Contact">
      <assert test="matches(cbc:Telefax, '^[-0-9]*$')">Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</assert>
      <assert test="matches(cbc:Telephone, '^[-0-9]*$')">Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryParty/cac:Contact/cbc:Name">
      <assert test="string-length() > 0">doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryParty/cac:Contact/cbc:Name must be filled</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cbc:Quantity/@unitCode">
      <assert test="string-length() > 0">doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cbc:Quantity/@unitCode must be filled</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID">
      <assert test="string-length() > 0">doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID must be filled</assert>
      <assert test="empty(@schemeAgencyID) or (@schemeAgencyID='88')">doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID/@schemeAgencyID must have one of the following values: [88]</assert>
      <assert test="empty(@schemeAgencyName) or (@schemeAgencyName='Logius Gegevensbeheer NL-Overheid')">doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID/@schemeAgencyName must have one of the following values: [Logius Gegevensbeheer NL-Overheid]</assert>
      <assert test="empty(@schemeDataURI) or (@schemeDataURI='urn:digi-inkoop:ubl:2.0:NL:1.6:gc:DeliveryTermsCode')">doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID/@schemeDataURI must have one of the following values: [urn:digi-inkoop:ubl:2.0:NL:1.6:gc:DeliveryTermsCode]</assert>
      <assert test="empty(@schemeID) or (@schemeID='NL-1002')">doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID/@schemeID must have one of the following values: [NL-1002]</assert>
      <assert test="empty(@schemeName) or (@schemeName='DeliveryTermsCode')">doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID/@schemeName must have one of the following values: [DeliveryTermsCode]</assert>
      <assert test="empty(@schemeURI) or (@schemeURI='http://www.nltaxonomie.nl/ubl/2.0/NL/1.6/cl/gc/DeliveryTermsCode.gc')">doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID/@schemeURI must have one of the following values: [http://www.nltaxonomie.nl/ubl/2.0/NL/1.6/cl/gc/DeliveryTermsCode.gc]</assert>
      <assert test="empty(@schemeVersionID) or (@schemeVersionID='1.6')">doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID/@schemeVersionID must have one of the following values: [1.6]</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item">
      <assert test="( (count(cbc:Description) = 0) and (   (count(cac:BuyersItemIdentification/cbc:ID) + count(cac:SellersItemIdentification/cbc:ID) + count(cac:ManufacturersItemIdentification/cbc:ID) + count(cac:StandardItemIdentification/cbc:ID) + count(cac:CatalogueItemIdentification/cbc:ID)) > 0 ))or( (count(cbc:Description) > 0) and (   (count(cac:BuyersItemIdentification/cbc:ID) + count(cac:SellersItemIdentification/cbc:ID) + count(cac:ManufacturersItemIdentification/cbc:ID) + count(cac:StandardItemIdentification/cbc:ID) + count(cac:CatalogueItemIdentification/cbc:ID)) = 0 ))"> Item MOET OF een Description OF een (party)Identification/ID bevatten.</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme">
      <assert test="empty(cbc:Name) or (cbc:Name='BTW') or (cbc:Name='Accijns') or (cbc:Name='Toeslag') or (cbc:Name='Overige')">doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme/cbc:Name must have one of the following values: [BTW, Accijns, Toeslag, Overige]</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject">
      <assert test="string-length() > 0">doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject must be filled</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cbc:Description">
      <assert test="string-length() > 0">doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cbc:Description must be filled</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Price/cbc:BaseQuantity/@unitCode">
      <assert test="string-length() > 0">doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Price/cbc:BaseQuantity/@unitCode must be filled</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cbc:Quantity/@unitCode">
      <assert test="string-length() > 0">doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cbc:Quantity/@unitCode must be filled</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode">
      <assert test="string-length() > 0">doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode must be filled</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode">
      <assert test="string-length() > 0">doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode must be filled</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID">
      <assert test="string-length() > 0">doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID must be filled</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:ID">
      <assert test="string-length() > 0">doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:ID must be filled</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:PaymentMeans/cbc:PaymentMeansCode">
      <assert test="string-length() > 0">doc:OrderResponse/cac:PaymentMeans/cbc:PaymentMeansCode must be filled</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:Contact">
      <assert test="matches(cbc:Telefax, '^[-0-9]*$')">Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</assert>
      <assert test="matches(cbc:Telephone, '^[-0-9]*$')">Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name">
      <assert test="string-length() > 0">doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name must be filled</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID">
      <assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</assert>
      <assert test="empty(@schemeAgencyName) or (@schemeAgencyName='KvK') or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')">Uitgevende organisatie van de PartijIdentificatie MOET geïdentificeerd worden door een code uit de lijst: KvK, BTW, Fi, BSN, OIN, XXX.</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode">
      <assert test="string-length() > 0">doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must be filled</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:SellerSupplierParty/cbc:CustomerAssignedAccountID">
      <assert test="string-length() > 0">doc:OrderResponse/cac:SellerSupplierParty/cbc:CustomerAssignedAccountID must be filled</assert>
    </rule>
    <rule context="doc:OrderResponse/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
      <assert test="empty(cbc:Name) or (cbc:Name='BTW') or (cbc:Name='Accijns') or (cbc:Name='Toeslag') or (cbc:Name='Overige')">doc:OrderResponse/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:Name must have one of the following values: [BTW, Accijns, Toeslag, Overige]</assert>
    </rule>
  </pattern>
</schema>
