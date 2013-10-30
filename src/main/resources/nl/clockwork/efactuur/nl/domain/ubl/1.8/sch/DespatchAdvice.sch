<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <title>Validations for DespatchAdvice Mapping; strict=false</title>
  <ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" />
  <ns prefix="doc" uri="urn:oasis:names:specification:ubl:schema:xsd:DespatchAdvice-2" />
  <ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" />
  <pattern id="cardinality-redefines">
    <rule context="doc:DespatchAdvice">
      <assert test="count(cac:SellerSupplierParty) &gt;= 1">doc:DespatchAdvice must contain cac:SellerSupplierParty at least 1 time(s)</assert>
      <assert test="count(cac:Shipment) &gt;= 1">doc:DespatchAdvice must contain cac:Shipment at least 1 time(s)</assert>
      <assert test="count(cbc:CustomizationID) &gt;= 1">doc:DespatchAdvice must contain cbc:CustomizationID at least 1 time(s)</assert>
      <assert test="count(cbc:Note) &lt;= 1">doc:DespatchAdvice may contain cbc:Note at most 1 time(s)</assert>
      <assert test="count(cbc:ProfileID) &gt;= 1">doc:DespatchAdvice must contain cbc:ProfileID at least 1 time(s)</assert>
      <assert test="count(cbc:UBLVersionID) &gt;= 1">doc:DespatchAdvice must contain cbc:UBLVersionID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:DespatchAdvice/cac:DeliveryCustomerParty">
      <assert test="count(cac:Party) &gt;= 1">doc:DespatchAdvice/cac:DeliveryCustomerParty must contain cac:Party at least 1 time(s)</assert>
    </rule>
    <rule context="doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party">
      <assert test="count(cac:Contact) &gt;= 1">doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party must contain cac:Contact at least 1 time(s)</assert>
      <assert test="count(cac:PartyName) &gt;= 1 and count(cac:PartyName) &lt;= 1">doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party must contain cac:PartyName at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:Contact">
      <assert test="count(cbc:Name) &gt;= 1">doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:Contact must contain cbc:Name at least 1 time(s)</assert>
    </rule>
    <rule context="doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID">
      <assert test="count(@schemeAgencyName) &gt;= 1">doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)</assert>
    </rule>
    <rule context="doc:DespatchAdvice/cac:DespatchLine">
      <assert test="count(cbc:DeliveredQuantity) &gt;= 1">doc:DespatchAdvice/cac:DespatchLine must contain cbc:DeliveredQuantity at least 1 time(s)</assert>
    </rule>
    <rule context="doc:DespatchAdvice/cac:DespatchLine/cac:Item">
      <assert test="count(cbc:CatalogueIndicator) &gt;= 1">doc:DespatchAdvice/cac:DespatchLine/cac:Item must contain cbc:CatalogueIndicator at least 1 time(s)</assert>
      <assert test="count(cbc:Description) &lt;= 1">doc:DespatchAdvice/cac:DespatchLine/cac:Item may contain cbc:Description at most 1 time(s)</assert>
      <assert test="count(cbc:Name) &gt;= 1">doc:DespatchAdvice/cac:DespatchLine/cac:Item must contain cbc:Name at least 1 time(s)</assert>
    </rule>
    <rule context="doc:DespatchAdvice/cac:DespatchLine/cac:OrderLineReference">
      <assert test="count(cac:OrderReference) &gt;= 1">doc:DespatchAdvice/cac:DespatchLine/cac:OrderLineReference must contain cac:OrderReference at least 1 time(s)</assert>
    </rule>
    <rule context="doc:DespatchAdvice/cac:DespatchLine/cbc:DeliveredQuantity">
      <assert test="count(@unitCode) &gt;= 1">doc:DespatchAdvice/cac:DespatchLine/cbc:DeliveredQuantity must contain @unitCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:DespatchAdvice/cac:DespatchSupplierParty">
      <assert test="count(cac:Party) &gt;= 1">doc:DespatchAdvice/cac:DespatchSupplierParty must contain cac:Party at least 1 time(s)</assert>
    </rule>
    <rule context="doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party">
      <assert test="count(cac:Contact) &gt;= 1">doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party must contain cac:Contact at least 1 time(s)</assert>
      <assert test="count(cac:PartyName) &gt;= 1 and count(cac:PartyName) &lt;= 1">doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party must contain cac:PartyName at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:Contact">
      <assert test="count(cbc:Name) &gt;= 1">doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:Contact must contain cbc:Name at least 1 time(s)</assert>
    </rule>
    <rule context="doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID">
      <assert test="count(@schemeAgencyName) &gt;= 1">doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)</assert>
    </rule>
    <rule context="doc:DespatchAdvice/cac:SellerSupplierParty">
      <assert test="count(cac:Party) &gt;= 1">doc:DespatchAdvice/cac:SellerSupplierParty must contain cac:Party at least 1 time(s)</assert>
    </rule>
    <rule context="doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party">
      <assert test="count(cac:Contact) &gt;= 1">doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party must contain cac:Contact at least 1 time(s)</assert>
      <assert test="count(cac:PartyIdentification) &gt;= 1 and count(cac:PartyIdentification) &lt;= 3">doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party must contain cac:PartyIdentification at least 1 and at most 3 time(s)</assert>
      <assert test="count(cac:PartyName) &lt;= 1">doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party may contain cac:PartyName at most 1 time(s)</assert>
    </rule>
    <rule context="doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:Contact">
      <assert test="count(cbc:Name) &gt;= 1">doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:Contact must contain cbc:Name at least 1 time(s)</assert>
    </rule>
    <rule context="doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID">
      <assert test="count(@schemeAgencyName) &gt;= 1">doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)</assert>
    </rule>
    <rule context="doc:DespatchAdvice/cac:Shipment">
      <assert test="count(cac:Delivery) &gt;= 1">doc:DespatchAdvice/cac:Shipment must contain cac:Delivery at least 1 time(s)</assert>
      <assert test="count(cbc:DeliveryInstructions) &lt;= 1">doc:DespatchAdvice/cac:Shipment may contain cbc:DeliveryInstructions at most 1 time(s)</assert>
    </rule>
    <rule context="doc:DespatchAdvice/cac:Shipment/cac:Delivery">
      <assert test="count(cac:DeliveryAddress) &gt;= 1">doc:DespatchAdvice/cac:Shipment/cac:Delivery must contain cac:DeliveryAddress at least 1 time(s)</assert>
      <assert test="count(cac:Despatch) &gt;= 1">doc:DespatchAdvice/cac:Shipment/cac:Delivery must contain cac:Despatch at least 1 time(s)</assert>
      <assert test="count(cac:RequestedDeliveryPeriod) &gt;= 1">doc:DespatchAdvice/cac:Shipment/cac:Delivery must contain cac:RequestedDeliveryPeriod at least 1 time(s)</assert>
    </rule>
    <rule context="doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress">
      <assert test="count(cac:Country) &gt;= 1">doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress must contain cac:Country at least 1 time(s)</assert>
    </rule>
    <rule context="doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryParty">
      <assert test="count(cac:PartyName) &gt;= 1 and count(cac:PartyName) &lt;= 1">doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryParty must contain cac:PartyName at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch">
      <assert test="count(cac:DespatchAddress) &gt;= 1">doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch must contain cac:DespatchAddress at least 1 time(s)</assert>
    </rule>
    <rule context="doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress">
      <assert test="count(cac:Country) &gt;= 1">doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress must contain cac:Country at least 1 time(s)</assert>
    </rule>
    <rule context="doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:RequestedDeliveryPeriod">
      <assert test="count(cbc:EndDate) &gt;= 1">doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:RequestedDeliveryPeriod must contain cbc:EndDate at least 1 time(s)</assert>
    </rule>
  </pattern>
  <pattern id="type-restrictions">
    <rule context="doc:DespatchAdvice">
      <assert test="every $bn in //cbc:BuildingNumber satisfies (matches($bn,'^\d+(-[ \w]+)?$'))">Huisnummer en Huisnummertoevoeging moeten achter elkaar geplaatst worden, gescheiden met een koppelteken.</assert>
      <assert test="every $id in //cac:PartyIdentification/cbc:ID satisfies (exists($id/@schemeAgencyID) and not(empty($id/@schemeAgencyID)) and exists($id/@schemeAgencyName) and not(empty($id/@schemeAgencyName)))">PartyIdentification/ID MOET @schemeAgencyID en @schemeAgencyName attributen bevatten.</assert>
      <assert test="every $pa in //cac:PostalAddress satisfies ((not(empty($pa/cbc:Postbox)) and empty($pa/cbc:StreetName) and empty($pa/cbc:BuildingNumber) and empty(cbc:Room) and empty(cbc:Floor) and empty(cbc:Department) and empty(cbc:InhouseMail) and empty(cbc:PlotIdentification)) or (empty($pa/cbc:Postbox) and (not(empty($pa/cbc:StreetName)) or not(empty($pa/cbc:BuildingNumber)) or not(empty(cbc:Room)) or not(empty(cbc:Floor)) or not(empty(cbc:Department)) or not(empty(cbc:InhouseMail)) or not(empty(cbc:PlotIdentification)))))">PostalAddress MOET OF een Postbox bevatten OF minimaal 1 van de elementen StreetName, BuildingNumber, Room, Floor, Department, InhouseMail of PlotIdentification. Beide MAG NIET.</assert>
      <assert test="every $pi in //cac:PartyIdentification satisfies (if(count($pi/cbc:ID[@schemeAgencyName = 'Vest']) = 1) then (count($pi/../cac:PartyIdentification/cbc:ID[@schemeAgencyName = 'KvK']) = 1) else ('true'))">Als Vestigingsnummer is opgegeven MOET Kamer van Koophandel nummer ook opgegeven worden.</assert>
      <assert test="empty(cbc:CustomizationID) or (cbc:CustomizationID='1.8')">Bericht MOET gebaseerd zijn op versie 1.8 van de Nederlandse specificatie.</assert>
      <assert test="empty(cbc:ProfileID) or (cbc:ProfileID='NL')">Bericht MOET op de Nederlandse (NL) specificatie gebaseerd zijn.</assert>
      <assert test="empty(cbc:UBLVersionID) or (cbc:UBLVersionID='2.0')">Bericht MOET gebaseerd zijn op UBL Versie 2.0</assert>
    </rule>
    <rule context="doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:Contact/cbc:Name">
      <assert test="string-length() > 0">doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:Contact/cbc:Name must be filled</assert>
    </rule>
    <rule context="doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID">
      <assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</assert>
      <assert test="empty(@schemeAgencyName) or (@schemeAgencyName='KvK') or (@schemeAgencyName='Vest') or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')">Uitgevende organisatie van de PartijIdentificatie MOET geïdentificeerd worden door een code uit de lijst: KvK, Vest, BTW, Fi, BSN, OIN, XXX.</assert>
    </rule>
    <rule context="doc:DespatchAdvice/cac:DespatchLine/cac:Item">
      <assert test="(count(cbc:Description) + count(cac:BuyersItemIdentification/cbc:ID) + count(cac:SellersItemIdentification/cbc:ID) + count(cac:ManufacturersItemIdentification/cbc:ID) + count(cac:StandardItemIdentification/cbc:ID) + count(cac:CatalogueItemIdentification/cbc:ID)) > 0">Item MOET een Description OF een (party)Identification/ID bevatten.</assert>
    </rule>
    <rule context="doc:DespatchAdvice/cac:DespatchLine/cac:Item/cbc:Name">
      <assert test="string-length() > 0">doc:DespatchAdvice/cac:DespatchLine/cac:Item/cbc:Name must be filled</assert>
    </rule>
    <rule context="doc:DespatchAdvice/cac:DespatchLine/cac:OrderLineReference/cbc:LineID">
      <assert test="string-length() > 0">doc:DespatchAdvice/cac:DespatchLine/cac:OrderLineReference/cbc:LineID must be filled</assert>
    </rule>
    <rule context="doc:DespatchAdvice/cac:DespatchLine/cbc:BackorderQuantity/@unitCode">
      <assert test="string-length() > 0">doc:DespatchAdvice/cac:DespatchLine/cbc:BackorderQuantity/@unitCode must be filled</assert>
    </rule>
    <rule context="doc:DespatchAdvice/cac:DespatchLine/cbc:DeliveredQuantity/@unitCode">
      <assert test="string-length() > 0">doc:DespatchAdvice/cac:DespatchLine/cbc:DeliveredQuantity/@unitCode must be filled</assert>
    </rule>
    <rule context="doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:Contact/cbc:Name">
      <assert test="string-length() > 0">doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:Contact/cbc:Name must be filled</assert>
    </rule>
    <rule context="doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID">
      <assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</assert>
      <assert test="empty(@schemeAgencyName) or (@schemeAgencyName='KvK') or (@schemeAgencyName='Vest') or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')">Uitgevende organisatie van de PartijIdentificatie MOET geïdentificeerd worden door een code uit de lijst: KvK, Vest, BTW, Fi, BSN, OIN, XXX.</assert>
    </rule>
    <rule context="doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name">
      <assert test="string-length() > 0">doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name must be filled</assert>
    </rule>
    <rule context="doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID">
      <assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</assert>
      <assert test="empty(@schemeAgencyName) or (@schemeAgencyName='KvK') or (@schemeAgencyName='Vest') or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')">Uitgevende organisatie van de PartijIdentificatie MOET geïdentificeerd worden door een code uit de lijst: KvK, Vest, BTW, Fi, BSN, OIN, XXX.</assert>
    </rule>
    <rule context="doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:PartyName/cbc:Name">
      <assert test="string-length() > 0">doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:PartyName/cbc:Name must be filled</assert>
    </rule>
    <rule context="doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode">
      <assert test="string-length() > 0">doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must be filled</assert>
    </rule>
    <rule context="doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country/cbc:IdentificationCode">
      <assert test="string-length() > 0">doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country/cbc:IdentificationCode must be filled</assert>
    </rule>
  </pattern>
</schema>
