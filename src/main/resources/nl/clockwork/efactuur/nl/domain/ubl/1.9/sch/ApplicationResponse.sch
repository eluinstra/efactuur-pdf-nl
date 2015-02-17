<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <title>Validations for ApplicationResponse Mapping; strict=false</title>
  <ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" />
  <ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" />
  <ns prefix="doc" uri="urn:oasis:names:specification:ubl:schema:xsd:ApplicationResponse-2" />
  <pattern id="cardinality-redefines">
    <rule context="doc:ApplicationResponse">
      <assert test="count(cbc:ProfileID) &gt;= 1">doc:ApplicationResponse must contain cbc:ProfileID at least 1 time(s)</assert>
      <assert test="count(cbc:CustomizationID) &gt;= 1">doc:ApplicationResponse must contain cbc:CustomizationID at least 1 time(s)</assert>
      <assert test="count(cbc:UBLVersionID) &gt;= 1">doc:ApplicationResponse must contain cbc:UBLVersionID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:ApplicationResponse/cac:DocumentResponse/cac:Response">
      <assert test="count(cbc:Description) &lt;= 1">doc:ApplicationResponse/cac:DocumentResponse/cac:Response may contain cbc:Description at most 1 time(s)</assert>
    </rule>
    <rule context="doc:ApplicationResponse/cac:DocumentResponse/cac:Response/cbc:ResponseCode">
      <assert test="count(@listAgencyID) &gt;= 1">doc:ApplicationResponse/cac:DocumentResponse/cac:Response/cbc:ResponseCode must contain @listAgencyID at least 1 time(s)</assert>
      <assert test="count(@listVersionID) &gt;= 1">doc:ApplicationResponse/cac:DocumentResponse/cac:Response/cbc:ResponseCode must contain @listVersionID at least 1 time(s)</assert>
      <assert test="count(@listName) &gt;= 1">doc:ApplicationResponse/cac:DocumentResponse/cac:Response/cbc:ResponseCode must contain @listName at least 1 time(s)</assert>
      <assert test="count(@listURI) &gt;= 1">doc:ApplicationResponse/cac:DocumentResponse/cac:Response/cbc:ResponseCode must contain @listURI at least 1 time(s)</assert>
      <assert test="count(@listID) &gt;= 1">doc:ApplicationResponse/cac:DocumentResponse/cac:Response/cbc:ResponseCode must contain @listID at least 1 time(s)</assert>
      <assert test="count(@listAgencyName) &gt;= 1">doc:ApplicationResponse/cac:DocumentResponse/cac:Response/cbc:ResponseCode must contain @listAgencyName at least 1 time(s)</assert>
      <assert test="count(@listSchemeURI) &gt;= 1">doc:ApplicationResponse/cac:DocumentResponse/cac:Response/cbc:ResponseCode must contain @listSchemeURI at least 1 time(s)</assert>
    </rule>
    <rule context="doc:ApplicationResponse/cac:ReceiverParty">
      <assert test="count(cac:PartyIdentification) &gt;= 1 and count(cac:PartyIdentification) &lt;= 2">doc:ApplicationResponse/cac:ReceiverParty must contain cac:PartyIdentification at least 1 and at most 2 time(s)</assert>
      <assert test="count(cac:PartyName) &lt;= 1">doc:ApplicationResponse/cac:ReceiverParty may contain cac:PartyName at most 1 time(s)</assert>
    </rule>
    <rule context="doc:ApplicationResponse/cac:ReceiverParty/cac:PartyIdentification/cbc:ID">
      <assert test="count(@schemeAgencyID) &gt;= 1">doc:ApplicationResponse/cac:ReceiverParty/cac:PartyIdentification/cbc:ID must contain @schemeAgencyID at least 1 time(s)</assert>
      <assert test="count(@schemeAgencyName) &gt;= 1">doc:ApplicationResponse/cac:ReceiverParty/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)</assert>
    </rule>
    <rule context="doc:ApplicationResponse/cac:SenderParty">
      <assert test="count(cac:PartyIdentification) &gt;= 1 and count(cac:PartyIdentification) &lt;= 2">doc:ApplicationResponse/cac:SenderParty must contain cac:PartyIdentification at least 1 and at most 2 time(s)</assert>
    </rule>
    <rule context="doc:ApplicationResponse/cac:SenderParty/cac:PartyIdentification/cbc:ID">
      <assert test="count(@schemeAgencyName) &gt;= 1">doc:ApplicationResponse/cac:SenderParty/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)</assert>
      <assert test="count(@schemeAgencyID) &gt;= 1">doc:ApplicationResponse/cac:SenderParty/cac:PartyIdentification/cbc:ID must contain @schemeAgencyID at least 1 time(s)</assert>
    </rule>
  </pattern>
  <pattern id="type-restrictions">
    <rule context="doc:ApplicationResponse">
      <assert test="empty(cbc:ProfileID) or (cbc:ProfileID='NL')">Bericht MOET op de Nederlandse (NL) specificatie gebaseerd zijn.</assert>
      <assert test="empty(cbc:CustomizationID) or (cbc:CustomizationID='1.9')">Bericht MOET gebaseerd zijn op versie 1.9 van de Nederlandse specificatie.</assert>
      <assert test="every $bn in //cbc:BuildingNumber satisfies (matches($bn,'^\d+(-[ \w]+)?$'))">Huisnummer en Huisnummertoevoeging moeten achter elkaar geplaatst worden, gescheiden met een koppelteken.</assert>
      <assert test="every $id in //cac:PartyIdentification/cbc:ID satisfies (exists($id/@schemeAgencyID) and not(empty($id/@schemeAgencyID)) and exists($id/@schemeAgencyName) and not(empty($id/@schemeAgencyName)))">PartyIdentification/ID MOET @schemeAgencyID en @schemeAgencyName attributen bevatten.</assert>
      <assert test="every $pa in //cac:PostalAddress satisfies ((not(empty($pa/cbc:Postbox)) and empty($pa/cbc:StreetName) and empty($pa/cbc:BuildingNumber) and empty(cbc:Room) and empty(cbc:Floor) and empty(cbc:Department) and empty(cbc:InhouseMail) and empty(cbc:PlotIdentification)) or (empty($pa/cbc:Postbox) and (not(empty($pa/cbc:StreetName)) or not(empty($pa/cbc:BuildingNumber)) or not(empty(cbc:Room)) or not(empty(cbc:Floor)) or not(empty(cbc:Department)) or not(empty(cbc:InhouseMail)) or not(empty(cbc:PlotIdentification)))))">PostalAddress MOET OF een Postbox bevatten OF minimaal 1 van de elementen StreetName, BuildingNumber, Room, Floor, Department, InhouseMail of PlotIdentification. Beide MAG NIET.</assert>
      <assert test="empty(cbc:UBLVersionID) or (cbc:UBLVersionID='2.0')">Bericht MOET gebaseerd zijn op UBL Versie 2.0</assert>
    </rule>
    <rule context="doc:ApplicationResponse/cac:DocumentResponse/cac:DocumentReference">
      <assert test="empty(cbc:DocumentType) or (cbc:DocumentType='inkooporder') or (cbc:DocumentType='bestellingsaanvraag')">doc:ApplicationResponse/cac:DocumentResponse/cac:DocumentReference/cbc:DocumentType must have one of the following values: [inkooporder, bestellingsaanvraag]</assert>
    </rule>
    <rule context="doc:ApplicationResponse/cac:DocumentResponse/cac:Response/cbc:ResponseCode">
      <assert test="empty(@listAgencyID) or (@listAgencyID='88')">doc:ApplicationResponse/cac:DocumentResponse/cac:Response/cbc:ResponseCode/@listAgencyID must have one of the following values: [88]</assert>
      <assert test="empty(@listVersionID) or (@listVersionID='1.9')">doc:ApplicationResponse/cac:DocumentResponse/cac:Response/cbc:ResponseCode/@listVersionID must have one of the following values: [1.9]</assert>
      <assert test="empty(@listName) or (@listName='ResponseCode')">doc:ApplicationResponse/cac:DocumentResponse/cac:Response/cbc:ResponseCode/@listName must have one of the following values: [ResponseCode]</assert>
      <assert test="empty(@listURI) or (@listURI='http://www.nltaxonomie.nl/ubl/2.0/NL/1.9/cl/gc/NL-ResponseCode-1.9.gc')">doc:ApplicationResponse/cac:DocumentResponse/cac:Response/cbc:ResponseCode/@listURI must have one of the following values: [http://www.nltaxonomie.nl/ubl/2.0/NL/1.9/cl/gc/NL-ResponseCode-1.9.gc]</assert>
      <assert test="empty(@listID) or (@listID='NL-1005')">doc:ApplicationResponse/cac:DocumentResponse/cac:Response/cbc:ResponseCode/@listID must have one of the following values: [NL-1005]</assert>
      <assert test="empty(@listAgencyName) or (@listAgencyName='Logius Gegevensbeheer NL-Overheid')">doc:ApplicationResponse/cac:DocumentResponse/cac:Response/cbc:ResponseCode/@listAgencyName must have one of the following values: [Logius Gegevensbeheer NL-Overheid]</assert>
      <assert test="empty(@listSchemeURI) or (@listSchemeURI='urn:digi-inkoop:ubl:2.0:NL:1.9:gc:ResponseCode')">doc:ApplicationResponse/cac:DocumentResponse/cac:Response/cbc:ResponseCode/@listSchemeURI must have one of the following values: [urn:digi-inkoop:ubl:2.0:NL:1.9:gc:ResponseCode]</assert>
    </rule>
    <rule context="doc:ApplicationResponse/cac:ReceiverParty/cac:PartyIdentification/cbc:ID">
      <assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</assert>
      <assert test="empty(@schemeAgencyName) or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')">Uitgevende organisatie van de PartijIdentificatie MOET geïdentificeerd worden door een code uit de lijst: BTW, Fi, BSN, OIN, XXX.</assert>
    </rule>
    <rule context="doc:ApplicationResponse/cac:SenderParty/cac:PartyIdentification/cbc:ID">
      <assert test="empty(@schemeAgencyName) or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')">Uitgevende organisatie van de PartijIdentificatie MOET geïdentificeerd worden door een code uit de lijst: BTW, Fi, BSN, OIN, XXX.</assert>
      <assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</assert>
    </rule>
    <rule context="doc:ApplicationResponse/cbc:ID">
      <assert test="string-length(text()) lt 11">Element lengte MOET minder dan 11 posities zijn.</assert>
    </rule>
  </pattern>
</schema>
