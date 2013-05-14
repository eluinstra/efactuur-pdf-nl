<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <title>Validations for RequestForQuotation Mapping; strict=false</title>
  <ns prefix="nl-cac" uri="urn:digi-inkoop:ubl:2.0:NL:1.7:UBL-NL-CommonAggregateComponents-2" />
  <ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" />
  <ns prefix="doc" uri="urn:oasis:names:specification:ubl:schema:xsd:RequestForQuotation-2" />
  <ns prefix="nl-cbc" uri="urn:digi-inkoop:ubl:2.0:NL:1.7:UBL-NL-CommonBasicComponents-2" />
  <ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" />
  <ns prefix="ext" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2" />
  <pattern id="cardinality-redefines">
    <rule context="doc:RequestForQuotation">
      <assert test="count(cac:Contract) &lt;= 1">doc:RequestForQuotation may contain cac:Contract at most 1 time(s)</assert>
      <assert test="count(cac:Delivery) &lt;= 1">doc:RequestForQuotation may contain cac:Delivery at most 1 time(s)</assert>
      <assert test="count(cac:DeliveryTerms) &lt;= 1">doc:RequestForQuotation may contain cac:DeliveryTerms at most 1 time(s)</assert>
      <assert test="count(cac:OriginatorCustomerParty) &gt;= 1">doc:RequestForQuotation must contain cac:OriginatorCustomerParty at least 1 time(s)</assert>
      <assert test="count(cbc:CustomizationID) &gt;= 1">doc:RequestForQuotation must contain cbc:CustomizationID at least 1 time(s)</assert>
      <assert test="count(cbc:ID) &gt;= 1">doc:RequestForQuotation must contain cbc:ID at least 1 time(s)</assert>
      <assert test="count(cbc:Note) &lt;= 1">doc:RequestForQuotation may contain cbc:Note at most 1 time(s)</assert>
      <assert test="count(cbc:ProfileID) &gt;= 1">doc:RequestForQuotation must contain cbc:ProfileID at least 1 time(s)</assert>
      <assert test="count(cbc:UBLVersionID) &gt;= 1">doc:RequestForQuotation must contain cbc:UBLVersionID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:Contract">
      <assert test="count(cbc:ID) &gt;= 1">doc:RequestForQuotation/cac:Contract must contain cbc:ID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:Delivery/cac:DeliveryAddress">
      <assert test="count(cac:Country) &gt;= 1">doc:RequestForQuotation/cac:Delivery/cac:DeliveryAddress must contain cac:Country at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:Delivery/cac:DeliveryAddress/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:RequestForQuotation/cac:Delivery/cac:DeliveryAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:Delivery/cac:RequestedDeliveryPeriod">
      <assert test="count(cbc:EndDate) &gt;= 1">doc:RequestForQuotation/cac:Delivery/cac:RequestedDeliveryPeriod must contain cbc:EndDate at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:DeliveryTerms">
      <assert test="count(cbc:ID) &gt;= 1">doc:RequestForQuotation/cac:DeliveryTerms must contain cbc:ID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:DeliveryTerms/cbc:ID">
      <assert test="count(@schemeAgencyID) &gt;= 1">doc:RequestForQuotation/cac:DeliveryTerms/cbc:ID must contain @schemeAgencyID at least 1 time(s)</assert>
      <assert test="count(@schemeAgencyName) &gt;= 1">doc:RequestForQuotation/cac:DeliveryTerms/cbc:ID must contain @schemeAgencyName at least 1 time(s)</assert>
      <assert test="count(@schemeDataURI) &gt;= 1">doc:RequestForQuotation/cac:DeliveryTerms/cbc:ID must contain @schemeDataURI at least 1 time(s)</assert>
      <assert test="count(@schemeID) &gt;= 1">doc:RequestForQuotation/cac:DeliveryTerms/cbc:ID must contain @schemeID at least 1 time(s)</assert>
      <assert test="count(@schemeName) &gt;= 1">doc:RequestForQuotation/cac:DeliveryTerms/cbc:ID must contain @schemeName at least 1 time(s)</assert>
      <assert test="count(@schemeURI) &gt;= 1">doc:RequestForQuotation/cac:DeliveryTerms/cbc:ID must contain @schemeURI at least 1 time(s)</assert>
      <assert test="count(@schemeVersionID) &gt;= 1">doc:RequestForQuotation/cac:DeliveryTerms/cbc:ID must contain @schemeVersionID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:OriginatorCustomerParty">
      <assert test="count(cac:Party) &gt;= 1">doc:RequestForQuotation/cac:OriginatorCustomerParty must contain cac:Party at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party">
      <assert test="count(cac:Contact) &gt;= 1">doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party must contain cac:Contact at least 1 time(s)</assert>
      <assert test="count(cac:PartyIdentification) &gt;= 1 and count(cac:PartyIdentification) &lt;= 3">doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party must contain cac:PartyIdentification at least 1 and at most 3 time(s)</assert>
      <assert test="count(cac:PartyName) &gt;= 1 and count(cac:PartyName) &lt;= 1">doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party must contain cac:PartyName at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:AgentParty">
      <assert test="count(cac:PartyIdentification) &gt;= 1 and count(cac:PartyIdentification) &lt;= 3">doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:AgentParty must contain cac:PartyIdentification at least 1 and at most 3 time(s)</assert>
      <assert test="count(cac:PartyName) &gt;= 1 and count(cac:PartyName) &lt;= 1">doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:AgentParty must contain cac:PartyName at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:AgentParty/cac:Contact">
      <assert test="count(cbc:Name) &gt;= 1">doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:AgentParty/cac:Contact must contain cbc:Name at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification/cbc:ID">
      <assert test="count(@schemeAgencyName) &gt;= 1">doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress">
      <assert test="count(cac:Country) &gt;= 1">doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress must contain cac:Country at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:Contact">
      <assert test="count(cbc:Name) &gt;= 1">doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:Contact must contain cbc:Name at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID">
      <assert test="count(@schemeAgencyName) &gt;= 1">doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:PhysicalLocation">
      <assert test="count(cac:Address) &gt;= 1">doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:PhysicalLocation must contain cac:Address at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address">
      <assert test="count(cac:Country) &gt;= 1">doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address must contain cac:Country at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:RequestForQuotationLine/cac:DocumentReference">
      <assert test="count(cbc:DocumentType) &gt;= 1">doc:RequestForQuotation/cac:RequestForQuotationLine/cac:DocumentReference must contain cbc:DocumentType at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:RequestForQuotationLine/cac:DocumentReference/cac:Attachment">
      <assert test="count(cbc:EmbeddedDocumentBinaryObject) &gt;= 1">doc:RequestForQuotation/cac:RequestForQuotationLine/cac:DocumentReference/cac:Attachment must contain cbc:EmbeddedDocumentBinaryObject at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem">
      <assert test="count(cbc:Quantity) &gt;= 1">doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem must contain cbc:Quantity at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress">
      <assert test="count(cac:Country) &gt;= 1">doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress must contain cac:Country at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:DeliveryParty">
      <assert test="count(cac:PartyName) &gt;= 1 and count(cac:PartyName) &lt;= 1">doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:DeliveryParty must contain cac:PartyName at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact">
      <assert test="count(cbc:Name) &gt;= 1">doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact must contain cbc:Name at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:RequestedDeliveryPeriod">
      <assert test="count(cbc:EndDate) &gt;= 1">doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:RequestedDeliveryPeriod must contain cbc:EndDate at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:DeliveryTerms">
      <assert test="count(cbc:ID) &gt;= 1">doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:DeliveryTerms must contain cbc:ID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:DeliveryTerms/cbc:ID">
      <assert test="count(@schemeAgencyID) &gt;= 1">doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:DeliveryTerms/cbc:ID must contain @schemeAgencyID at least 1 time(s)</assert>
      <assert test="count(@schemeAgencyName) &gt;= 1">doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:DeliveryTerms/cbc:ID must contain @schemeAgencyName at least 1 time(s)</assert>
      <assert test="count(@schemeDataURI) &gt;= 1">doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:DeliveryTerms/cbc:ID must contain @schemeDataURI at least 1 time(s)</assert>
      <assert test="count(@schemeID) &gt;= 1">doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:DeliveryTerms/cbc:ID must contain @schemeID at least 1 time(s)</assert>
      <assert test="count(@schemeName) &gt;= 1">doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:DeliveryTerms/cbc:ID must contain @schemeName at least 1 time(s)</assert>
      <assert test="count(@schemeURI) &gt;= 1">doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:DeliveryTerms/cbc:ID must contain @schemeURI at least 1 time(s)</assert>
      <assert test="count(@schemeVersionID) &gt;= 1">doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:DeliveryTerms/cbc:ID must contain @schemeVersionID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Item">
      <assert test="count(cbc:CatalogueIndicator) &gt;= 1">doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Item must contain cbc:CatalogueIndicator at least 1 time(s)</assert>
      <assert test="count(cbc:Description) &lt;= 1">doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Item may contain cbc:Description at most 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment">
      <assert test="count(cbc:EmbeddedDocumentBinaryObject) &gt;= 1">doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment must contain cbc:EmbeddedDocumentBinaryObject at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cbc:Quantity">
      <assert test="count(@unitCode) &gt;= 1">doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cbc:Quantity must contain @unitCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:SellerSupplierParty">
      <assert test="count(cac:Party) &gt;= 1">doc:RequestForQuotation/cac:SellerSupplierParty must contain cac:Party at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:SellerSupplierParty/cac:Party">
      <assert test="count(cac:PartyIdentification) &lt;= 3">doc:RequestForQuotation/cac:SellerSupplierParty/cac:Party may contain cac:PartyIdentification at most 3 time(s)</assert>
      <assert test="count(cac:PartyName) &gt;= 1 and count(cac:PartyName) &lt;= 1">doc:RequestForQuotation/cac:SellerSupplierParty/cac:Party must contain cac:PartyName at least 1 and at most 1 time(s)</assert>
      <assert test="count(cac:PostalAddress) &gt;= 1">doc:RequestForQuotation/cac:SellerSupplierParty/cac:Party must contain cac:PostalAddress at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:SellerSupplierParty/cac:Party/cac:Contact">
      <assert test="count(cbc:Name) &gt;= 1">doc:RequestForQuotation/cac:SellerSupplierParty/cac:Party/cac:Contact must contain cbc:Name at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID">
      <assert test="count(@schemeAgencyName) &gt;= 1">doc:RequestForQuotation/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:SellerSupplierParty/cac:Party/cac:PostalAddress">
      <assert test="count(cac:Country) &gt;= 1">doc:RequestForQuotation/cac:SellerSupplierParty/cac:Party/cac:PostalAddress must contain cac:Country at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:RequestForQuotation/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotation/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:GrantedValidityPeriod">
      <assert test="count(cbc:EndDate) &gt;= 1">doc:RequestForQuotation/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:GrantedValidityPeriod must contain cbc:EndDate at least 1 time(s)</assert>
      <assert test="count(cbc:StartDate) &gt;= 1">doc:RequestForQuotation/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:GrantedValidityPeriod must contain cbc:StartDate at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotation/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:RequestedValidityPeriod">
      <assert test="count(cbc:EndDate) &gt;= 1">doc:RequestForQuotation/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:RequestedValidityPeriod must contain cbc:EndDate at least 1 time(s)</assert>
      <assert test="count(cbc:StartDate) &gt;= 1">doc:RequestForQuotation/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:RequestedValidityPeriod must contain cbc:StartDate at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotation/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cbc:NegotiationStyle">
      <assert test="count(@listAgencyID) &gt;= 1">doc:RequestForQuotation/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cbc:NegotiationStyle must contain @listAgencyID at least 1 time(s)</assert>
      <assert test="count(@listAgencyName) &gt;= 1">doc:RequestForQuotation/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cbc:NegotiationStyle must contain @listAgencyName at least 1 time(s)</assert>
      <assert test="count(@listID) &gt;= 1">doc:RequestForQuotation/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cbc:NegotiationStyle must contain @listID at least 1 time(s)</assert>
      <assert test="count(@listName) &gt;= 1">doc:RequestForQuotation/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cbc:NegotiationStyle must contain @listName at least 1 time(s)</assert>
      <assert test="count(@listSchemeURI) &gt;= 1">doc:RequestForQuotation/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cbc:NegotiationStyle must contain @listSchemeURI at least 1 time(s)</assert>
      <assert test="count(@listURI) &gt;= 1">doc:RequestForQuotation/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cbc:NegotiationStyle must contain @listURI at least 1 time(s)</assert>
      <assert test="count(@listVersionID) &gt;= 1">doc:RequestForQuotation/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cbc:NegotiationStyle must contain @listVersionID at least 1 time(s)</assert>
    </rule>
  </pattern>
  <pattern id="type-restrictions">
    <rule context="/">
      <assert test="if(count(//cac:PartyIdentification/cbc:ID[@schemeAgencyName = 'Vest']) = 1) then (count(//cac:PartyIdentification/cbc:ID[@schemeAgencyName = 'KvK']) = 1) else ('true')">Als Vestigingsnummer is opgegeven MOET Kamer van Koophandel nummer ook opgegeven worden.</assert>
    </rule>
    <rule context="doc:RequestForQuotation">
      <assert test="every $bn in //cbc:BuildingNumber satisfies (matches($bn,'^\d+(-[ \w]+)?$'))">Huisnummer en Huisnummertoevoeging moeten achter elkaar geplaatst worden, gescheiden met een koppelteken.</assert>
      <assert test="every $id in //cac:PartyIdentification/cbc:ID satisfies (exists($id/@schemeAgencyID) and not(empty($id/@schemeAgencyID)) and exists($id/@schemeAgencyName) and not(empty($id/@schemeAgencyName)))">PartyIdentification/ID MOET @schemeAgencyID en @schemeAgencyName attributen bevatten.</assert>
      <assert test="every $pa in //cac:PostalAddress satisfies ((not(empty($pa/cbc:Postbox)) and empty($pa/cbc:StreetName) and empty($pa/cbc:BuildingNumber) and empty(cbc:Room) and empty(cbc:Floor) and empty(cbc:Department) and empty(cbc:InhouseMail) and empty(cbc:PlotIdentification)) or (empty($pa/cbc:Postbox) and (not(empty($pa/cbc:StreetName)) or not(empty($pa/cbc:BuildingNumber)) or not(empty(cbc:Room)) or not(empty(cbc:Floor)) or not(empty(cbc:Department)) or not(empty(cbc:InhouseMail)) or not(empty(cbc:PlotIdentification)))))">PostalAddress MOET OF een Postbox bevatten OF minimaal 1 van de elementen StreetName, BuildingNumber, Room, Floor, Department, InhouseMail of PlotIdentification. Beide MAG NIET.</assert>
      <assert test="( (count(cac:Delivery/cac:DeliveryAddress) = 0) and (count(cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress) = count(cac:RequestForQuotationLine/cac:LineItem)))or( (count(cac:Delivery/cac:DeliveryAddress) > 0) and (count(cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress) = 0))">Afleveradres MOET OF op algemeen niveau OF voor alle regels worden opgegeven.</assert>
      <assert test="( (count(cac:Delivery/cac:RequestedDeliveryPeriod) = 0) and (count(cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:RequestedDeliveryPeriod) = count(cac:RequestForQuotationLine/cac:LineItem)))or( (count(cac:Delivery/cac:RequestedDeliveryPeriod) > 0) and (count(cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:RequestedDeliveryPeriod) = 0))">Levertijd MOET OF op algemeen niveau OF voor alle regels worden opgegeven.</assert>
      <assert test="(count(cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact) = count(cac:RequestForQuotationLine/cac:LineItem))or(count(cac:SellerSupplierParty/cac:Party/cac:Contact) > 0)">Leverancier contactpersoon MOET voor alle regels worden opgegeven ALS NIET op algemeen niveau opgegeven.</assert>
      <assert test="empty(cbc:CustomizationID) or (cbc:CustomizationID='1.7')">Bericht MOET gebaseerd zijn op versie 1.7 van de Nederlandse specificatie.</assert>
      <assert test="empty(cbc:ProfileID) or (cbc:ProfileID='NL')">Bericht MOET op de Nederlandse (NL) specificatie gebaseerd zijn.</assert>
      <assert test="empty(cbc:UBLVersionID) or (cbc:UBLVersionID='2.0')">Bericht MOET gebaseerd zijn op UBL Versie 2.0</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:Contract/cbc:ID">
      <assert test="string-length() > 0">doc:RequestForQuotation/cac:Contract/cbc:ID must be filled</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode">
      <assert test="string-length() > 0">doc:RequestForQuotation/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must be filled</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:DeliveryTerms/cbc:ID">
      <assert test="string-length() > 0">doc:RequestForQuotation/cac:DeliveryTerms/cbc:ID must be filled</assert>
      <assert test="empty(@schemeAgencyID) or (@schemeAgencyID='88')">doc:RequestForQuotation/cac:DeliveryTerms/cbc:ID/@schemeAgencyID must have one of the following values: [88]</assert>
      <assert test="empty(@schemeAgencyName) or (@schemeAgencyName='Logius Gegevensbeheer NL-Overheid')">doc:RequestForQuotation/cac:DeliveryTerms/cbc:ID/@schemeAgencyName must have one of the following values: [Logius Gegevensbeheer NL-Overheid]</assert>
      <assert test="empty(@schemeDataURI) or (@schemeDataURI='urn:digi-inkoop:ubl:2.0:NL:1.7:gc:DeliveryTermsCode')">doc:RequestForQuotation/cac:DeliveryTerms/cbc:ID/@schemeDataURI must have one of the following values: [urn:digi-inkoop:ubl:2.0:NL:1.7:gc:DeliveryTermsCode]</assert>
      <assert test="empty(@schemeID) or (@schemeID='NL-1002')">doc:RequestForQuotation/cac:DeliveryTerms/cbc:ID/@schemeID must have one of the following values: [NL-1002]</assert>
      <assert test="empty(@schemeName) or (@schemeName='DeliveryTermsCode')">doc:RequestForQuotation/cac:DeliveryTerms/cbc:ID/@schemeName must have one of the following values: [DeliveryTermsCode]</assert>
      <assert test="empty(@schemeURI) or (@schemeURI='http://www.nltaxonomie.nl/ubl/2.0/NL/1.7/cl/gc/DeliveryTermsCode.gc')">doc:RequestForQuotation/cac:DeliveryTerms/cbc:ID/@schemeURI must have one of the following values: [http://www.nltaxonomie.nl/ubl/2.0/NL/1.7/cl/gc/DeliveryTermsCode.gc]</assert>
      <assert test="empty(@schemeVersionID) or (@schemeVersionID='1.7')">doc:RequestForQuotation/cac:DeliveryTerms/cbc:ID/@schemeVersionID must have one of the following values: [1.7]</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:AgentParty/cac:Contact">
      <assert test="matches(cbc:Telefax, '^[-0-9]*$')">Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</assert>
      <assert test="matches(cbc:Telephone, '^[-0-9]*$')">Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:AgentParty/cac:Contact/cbc:Name">
      <assert test="string-length() > 0">doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:AgentParty/cac:Contact/cbc:Name must be filled</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification/cbc:ID">
      <assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</assert>
      <assert test="empty(@schemeAgencyName) or (@schemeAgencyName='KvK') or (@schemeAgencyName='Vest') or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')">Uitgevende organisatie van de PartijIdentificatie MOET geïdentificeerd worden door een code uit de lijst: KvK, Vest, BTW, Fi, BSN, OIN, XXX.</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode">
      <assert test="string-length() > 0">doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode must be filled</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:Contact">
      <assert test="matches(cbc:Telefax, '^[-0-9]*$')">Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</assert>
      <assert test="matches(cbc:Telephone, '^[-0-9]*$')">Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:Contact/cbc:Name">
      <assert test="string-length() > 0">doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:Contact/cbc:Name must be filled</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID">
      <assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</assert>
      <assert test="empty(@schemeAgencyName) or (@schemeAgencyName='KvK') or (@schemeAgencyName='Vest') or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')">Uitgevende organisatie van de PartijIdentificatie MOET geïdentificeerd worden door een code uit de lijst: KvK, Vest, BTW, Fi, BSN, OIN, XXX.</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode">
      <assert test="string-length() > 0">doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must be filled</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:RequestForQuotationLine/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject">
      <assert test="string-length() > 0">doc:RequestForQuotation/cac:RequestForQuotationLine/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject must be filled</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode">
      <assert test="string-length() > 0">doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must be filled</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact">
      <assert test="matches(cbc:Telefax, '^[-0-9]*$')">Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</assert>
      <assert test="matches(cbc:Telephone, '^[-0-9]*$')">Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact/cbc:Name">
      <assert test="string-length() > 0">doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact/cbc:Name must be filled</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:DeliveryTerms/cbc:ID">
      <assert test="string-length() > 0">doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:DeliveryTerms/cbc:ID must be filled</assert>
      <assert test="empty(@schemeAgencyID) or (@schemeAgencyID='88')">doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:DeliveryTerms/cbc:ID/@schemeAgencyID must have one of the following values: [88]</assert>
      <assert test="empty(@schemeAgencyName) or (@schemeAgencyName='Logius Gegevensbeheer NL-Overheid')">doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:DeliveryTerms/cbc:ID/@schemeAgencyName must have one of the following values: [Logius Gegevensbeheer NL-Overheid]</assert>
      <assert test="empty(@schemeDataURI) or (@schemeDataURI='urn:digi-inkoop:ubl:2.0:NL:1.7:gc:DeliveryTermsCode')">doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:DeliveryTerms/cbc:ID/@schemeDataURI must have one of the following values: [urn:digi-inkoop:ubl:2.0:NL:1.7:gc:DeliveryTermsCode]</assert>
      <assert test="empty(@schemeID) or (@schemeID='NL-1002')">doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:DeliveryTerms/cbc:ID/@schemeID must have one of the following values: [NL-1002]</assert>
      <assert test="empty(@schemeName) or (@schemeName='DeliveryTermsCode')">doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:DeliveryTerms/cbc:ID/@schemeName must have one of the following values: [DeliveryTermsCode]</assert>
      <assert test="empty(@schemeURI) or (@schemeURI='http://www.nltaxonomie.nl/ubl/2.0/NL/1.7/cl/gc/DeliveryTermsCode.gc')">doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:DeliveryTerms/cbc:ID/@schemeURI must have one of the following values: [http://www.nltaxonomie.nl/ubl/2.0/NL/1.7/cl/gc/DeliveryTermsCode.gc]</assert>
      <assert test="empty(@schemeVersionID) or (@schemeVersionID='1.7')">doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:DeliveryTerms/cbc:ID/@schemeVersionID must have one of the following values: [1.7]</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Item">
      <assert test="(count(cbc:Description) + count(cac:BuyersItemIdentification/cbc:ID) + count(cac:SellersItemIdentification/cbc:ID) + count(cac:ManufacturersItemIdentification/cbc:ID) + count(cac:StandardItemIdentification/cbc:ID) + count(cac:CatalogueItemIdentification/cbc:ID)) > 0">Item MOET een Description OF een (party)Identification/ID bevatten.</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject">
      <assert test="string-length() > 0">doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject must be filled</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode">
      <assert test="string-length() > 0">doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode must be filled</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Item/cbc:Description">
      <assert test="string-length() > 0">doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Item/cbc:Description must be filled</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cbc:Quantity/@unitCode">
      <assert test="string-length() > 0">doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cbc:Quantity/@unitCode must be filled</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:SellerSupplierParty/cac:Party/cac:Contact">
      <assert test="matches(cbc:Telefax, '^[-0-9]*$')">Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</assert>
      <assert test="matches(cbc:Telephone, '^[-0-9]*$')">Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name">
      <assert test="string-length() > 0">doc:RequestForQuotation/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name must be filled</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID">
      <assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</assert>
      <assert test="empty(@schemeAgencyName) or (@schemeAgencyName='KvK') or (@schemeAgencyName='Vest') or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')">Uitgevende organisatie van de PartijIdentificatie MOET geïdentificeerd worden door een code uit de lijst: KvK, Vest, BTW, Fi, BSN, OIN, XXX.</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode">
      <assert test="string-length() > 0">doc:RequestForQuotation/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must be filled</assert>
    </rule>
    <rule context="doc:RequestForQuotation/cbc:ID">
      <assert test="string-length() > 0">doc:RequestForQuotation/cbc:ID must be filled</assert>
    </rule>
    <rule context="doc:RequestForQuotation/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent">
      <assert test="matches(nl-cbc:AwardDate, '^$|^[0-9]{4}-[0-9]{2}-[0-9]{2}$')">AwardDate moet een geldige datum waarde bevatten: eejj-mm-dd.</assert>
      <assert test="empty(nl-cbc:NegotiationStyle) or (nl-cbc:NegotiationStyle='E') or (nl-cbc:NegotiationStyle='S')">doc:RequestForQuotation/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cbc:NegotiationStyle must have one of the following values: [E, S]</assert>
    </rule>
    <rule context="doc:RequestForQuotation/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:GrantedValidityPeriod">
      <assert test="matches(cbc:EndDate, '^$|^[0-9]{4}-[0-9]{2}-[0-9]{2}$')">GrantedValidityPeriod/EndDate moet een geldige datum waarde bevatten: eejj-mm-dd.</assert>
      <assert test="matches(cbc:StartDate, '^$|^[0-9]{4}-[0-9]{2}-[0-9]{2}$')">GrantedValidityPeriod/StartDate moet een geldige datum waarde bevatten: eejj-mm-dd.</assert>
    </rule>
    <rule context="doc:RequestForQuotation/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:RequestedValidityPeriod">
      <assert test="matches(cbc:EndDate, '^$|^[0-9]{4}-[0-9]{2}-[0-9]{2}$')">RequestedValidityPeriod/EndDate moet een geldige datum waarde bevatten: eejj-mm-dd.</assert>
      <assert test="matches(cbc:StartDate, '^$|^[0-9]{4}-[0-9]{2}-[0-9]{2}$')">RequestedValidityPeriod/StartDate moet een geldige datum waarde bevatten: eejj-mm-dd.</assert>
    </rule>
    <rule context="doc:RequestForQuotation/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cbc:NegotiationStyle">
      <assert test="empty(@listAgencyID) or (@listAgencyID='88')">doc:RequestForQuotation/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cbc:NegotiationStyle/@listAgencyID must have one of the following values: [88]</assert>
      <assert test="empty(@listAgencyName) or (@listAgencyName='Logius Gegevensbeheer NL-Overheid')">doc:RequestForQuotation/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cbc:NegotiationStyle/@listAgencyName must have one of the following values: [Logius Gegevensbeheer NL-Overheid]</assert>
      <assert test="empty(@listID) or (@listID='NL-1003')">doc:RequestForQuotation/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cbc:NegotiationStyle/@listID must have one of the following values: [NL-1003]</assert>
      <assert test="empty(@listName) or (@listName='Onderhandelingsstijl')">doc:RequestForQuotation/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cbc:NegotiationStyle/@listName must have one of the following values: [Onderhandelingsstijl]</assert>
      <assert test="empty(@listSchemeURI) or (@listSchemeURI='urn:digi-inkoop:ubl:2.0:NL:1.7:gc:NegotiationStyleCode')">doc:RequestForQuotation/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cbc:NegotiationStyle/@listSchemeURI must have one of the following values: [urn:digi-inkoop:ubl:2.0:NL:1.7:gc:NegotiationStyleCode]</assert>
      <assert test="empty(@listURI) or (@listURI='http://www.nltaxonomie.nl/ubl/2.0/NL/1.7/cl/gc/NegotiationStyleCode.gc')">doc:RequestForQuotation/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cbc:NegotiationStyle/@listURI must have one of the following values: [http://www.nltaxonomie.nl/ubl/2.0/NL/1.7/cl/gc/NegotiationStyleCode.gc]</assert>
      <assert test="empty(@listVersionID) or (@listVersionID='1.7')">doc:RequestForQuotation/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cbc:NegotiationStyle/@listVersionID must have one of the following values: [1.7]</assert>
    </rule>
  </pattern>
</schema>
