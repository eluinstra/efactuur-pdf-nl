<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <title>Validations for RequestForQuotationCancellation Mapping</title>
  <ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" />
  <ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" />
  <ns prefix="doc" uri="urn:oasis:names:specification:ubl:schema:xsd:RequestForQuotationCancellation-2" />
  <pattern id="cardinality-redefines">
    <rule context="doc:RequestForQuotationCancellation/cac:DocumentReference">
      <assert test="count(cbc:DocumentType) &gt;= 1">doc:RequestForQuotationCancellation/cac:DocumentReference must contain cbc:DocumentType at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotationCancellation/cac:DocumentReference/cac:Attachment">
      <assert test="count(cbc:EmbeddedDocumentBinaryObject) &gt;= 1">doc:RequestForQuotationCancellation/cac:DocumentReference/cac:Attachment must contain cbc:EmbeddedDocumentBinaryObject at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty">
      <assert test="count(cac:Party) &gt;= 1">doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty must contain cac:Party at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party">
      <assert test="count(cac:Contact) &gt;= 1">doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party must contain cac:Contact at least 1 time(s)</assert>
      <assert test="count(cac:PartyIdentification) &gt;= 1 and count(cac:PartyIdentification) &lt;= 2">doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party must contain cac:PartyIdentification at least 1 and at most 2 time(s)</assert>
      <assert test="count(cac:PartyName) &gt;= 1 and count(cac:PartyName) &lt;= 1">doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party must contain cac:PartyName at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:Contact">
      <assert test="count(cbc:Name) &gt;= 1">doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:Contact must contain cbc:Name at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID">
      <assert test="count(@schemeAgencyName) &gt;= 1">doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address">
      <assert test="count(cac:Country) &gt;= 1">doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address must contain cac:Country at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotationCancellation/cac:SellerSupplierParty">
      <assert test="count(cac:Party) &gt;= 1">doc:RequestForQuotationCancellation/cac:SellerSupplierParty must contain cac:Party at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party">
      <assert test="count(cac:PartyIdentification) &lt;= 2">doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party may contain cac:PartyIdentification at most 2 time(s)</assert>
      <assert test="count(cac:PartyName) &lt;= 1">doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party may contain cac:PartyName at most 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:Contact">
      <assert test="count(cbc:Name) &gt;= 1">doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:Contact must contain cbc:Name at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID">
      <assert test="count(@schemeAgencyName) &gt;= 1">doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:PostalAddress">
      <assert test="count(cac:Country) &gt;= 1">doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:PostalAddress must contain cac:Country at least 1 time(s)</assert>
    </rule>
    <rule context="doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
  </pattern>
  <pattern id="type-restrictions">
    <rule context="doc:RequestForQuotationCancellation">
      <assert test="every $bn in //cbc:BuildingNumber satisfies (matches($bn,'^\d+(-[ \w]+)?$'))">Huisnummer en Huisnummertoevoeging moeten achter elkaar geplaatst worden, gescheiden met een koppelteken.</assert>
      <assert test="every $id in //cac:PartyIdentification/cbc:ID satisfies (exists($id/@schemeAgencyID) and not(empty($id/@schemeAgencyID)) and exists($id/@schemeAgencyName) and not(empty($id/@schemeAgencyName)))">PartyIdentification/ID MOET @schemeAgencyID en @schemeAgencyName attributen bevatten.</assert>
      <assert test="every $pa in //cac:PostalAddress satisfies ((not(empty($pa/cbc:Postbox)) and empty($pa/cbc:StreetName) and empty($pa/cbc:BuildingNumber) and empty(cbc:Room) and empty(cbc:Floor) and empty(cbc:Department) and empty(cbc:InhouseMail) and empty(cbc:PlotIdentification)) or (empty($pa/cbc:Postbox) and (not(empty($pa/cbc:StreetName)) or not(empty($pa/cbc:BuildingNumber)) or not(empty(cbc:Room)) or not(empty(cbc:Floor)) or not(empty(cbc:Department)) or not(empty(cbc:InhouseMail)) or not(empty(cbc:PlotIdentification)))))">PostalAddress MOET OF een Postbox bevatten OF minimaal 1 van de elementen StreetName, BuildingNumber, Room, Floor, Department, InhouseMail of PlotIdentification. Beide MAG NIET.</assert>
      <assert test="empty(cbc:CustomizationID) or (cbc:CustomizationID='1.6')">Bericht MOET gebaseerd zijn op versie 1.6 van de Nederlandse specificatie.</assert>
      <assert test="empty(cbc:ProfileID) or (cbc:ProfileID='NL')">Bericht MOET op de Nederlandse (NL) specificatie gebaseerd zijn.</assert>
      <assert test="empty(cbc:UBLVersionID) or (cbc:UBLVersionID='2.0')">Bericht MOET gebaseerd zijn op UBL Versie 2.0</assert>
    </rule>
    <rule context="doc:RequestForQuotationCancellation/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject">
      <assert test="string-length() > 0">doc:RequestForQuotationCancellation/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject must be filled</assert>
    </rule>
    <rule context="doc:RequestForQuotationCancellation/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode">
      <assert test="string-length() > 0">doc:RequestForQuotationCancellation/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode must be filled</assert>
    </rule>
    <rule context="doc:RequestForQuotationCancellation/cac:DocumentReference/cbc:DocumentType">
      <assert test="string-length() > 0"> Indien de identificatie van een contract meegegeven wordt, moet hier 'Contract' opgegeven worden. Bij bijlagen in de vorm van specificaties moet hier 'Specificaties' opgegeven worden</assert>
    </rule>
    <rule context="doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:Contact">
      <assert test="matches(cbc:Telefax, '^[-0-9]*$')">Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</assert>
      <assert test="matches(cbc:Telephone, '^[-0-9]*$')">Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</assert>
    </rule>
    <rule context="doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:Contact/cbc:Name">
      <assert test="string-length() > 0">doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:Contact/cbc:Name must be filled</assert>
    </rule>
    <rule context="doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID">
      <assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</assert>
      <assert test="empty(@schemeAgencyName) or (@schemeAgencyName='KvK') or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')">Uitgevende organisatie van de PartijIdentificatie MOET geïdentificeerd worden door een code uit de lijst: KvK, BTW, Fi, BSN, OIN, XXX.</assert>
    </rule>
    <rule context="doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode">
      <assert test="string-length() > 0">doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must be filled</assert>
    </rule>
    <rule context="doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:Contact">
      <assert test="matches(cbc:Telefax, '^[-0-9]*$')">Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</assert>
      <assert test="matches(cbc:Telephone, '^[-0-9]*$')">Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</assert>
    </rule>
    <rule context="doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name">
      <assert test="string-length() > 0">doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name must be filled</assert>
    </rule>
    <rule context="doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID">
      <assert test="string-length() > 0">doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID must be filled</assert>
      <assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</assert>
      <assert test="empty(@schemeAgencyName) or (@schemeAgencyName='KvK') or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')">Uitgevende organisatie van de PartijIdentificatie MOET geïdentificeerd worden door een code uit de lijst: KvK, BTW, Fi, BSN, OIN, XXX.</assert>
    </rule>
    <rule context="doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode">
      <assert test="string-length() > 0">doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must be filled</assert>
    </rule>
  </pattern>
</schema>
