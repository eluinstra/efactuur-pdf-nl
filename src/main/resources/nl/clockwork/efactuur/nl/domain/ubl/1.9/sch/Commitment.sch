<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <title>Validations for Commitment Mapping; strict=false</title>
  <ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" />
  <ns prefix="nl-cac" uri="urn:digi-inkoop:ubl:2.0:NL:1.8:UBL-NL-CommonAggregateComponents-2" />
  <ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" />
  <ns prefix="doc" uri="urn:digi-inkoop:ubl:2.0:NL:1.8:UBL-NL-Commitment-2" />
  <pattern id="cardinality-redefines">
    <rule context="doc:Commitment/cac:AccountingCustomerParty">
      <assert test="count(cac:Party) &gt;= 1">doc:Commitment/cac:AccountingCustomerParty must contain cac:Party at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Commitment/cac:AccountingCustomerParty/cac:Party">
      <assert test="count(cac:PartyIdentification) &gt;= 1 and count(cac:PartyIdentification) &lt;= 2">doc:Commitment/cac:AccountingCustomerParty/cac:Party must contain cac:PartyIdentification at least 1 and at most 2 time(s)</assert>
      <assert test="count(cac:PartyName) &lt;= 1">doc:Commitment/cac:AccountingCustomerParty/cac:Party may contain cac:PartyName at most 1 time(s)</assert>
    </rule>
    <rule context="doc:Commitment/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID">
      <assert test="count(@schemeAgencyID) &gt;= 1">doc:Commitment/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyID at least 1 time(s)</assert>
      <assert test="count(@schemeAgencyName) &gt;= 1">doc:Commitment/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Commitment/cac:DocumentReference/cac:Attachment">
      <assert test="count(cbc:EmbeddedDocumentBinaryObject) &gt;= 1">doc:Commitment/cac:DocumentReference/cac:Attachment must contain cbc:EmbeddedDocumentBinaryObject at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Commitment/cac:SellerSupplierParty">
      <assert test="count(cac:Party) &gt;= 1">doc:Commitment/cac:SellerSupplierParty must contain cac:Party at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Commitment/cac:SellerSupplierParty/cac:Party">
      <assert test="count(cac:PartyIdentification) &lt;= 3">doc:Commitment/cac:SellerSupplierParty/cac:Party may contain cac:PartyIdentification at most 3 time(s)</assert>
      <assert test="count(cac:PartyName) &lt;= 1">doc:Commitment/cac:SellerSupplierParty/cac:Party may contain cac:PartyName at most 1 time(s)</assert>
    </rule>
    <rule context="doc:Commitment/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID">
      <assert test="count(@schemeAgencyID) &gt;= 1">doc:Commitment/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyID at least 1 time(s)</assert>
      <assert test="count(@schemeAgencyName) &gt;= 1">doc:Commitment/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Commitment/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
      <assert test="count(cbc:Name) &gt;= 1">doc:Commitment/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme must contain cbc:Name at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Commitment/cbc:ActionCode">
      <assert test="count(@listID) &gt;= 1">doc:Commitment/cbc:ActionCode must contain @listID at least 1 time(s)</assert>
      <assert test="count(@listAgencyName) &gt;= 1">doc:Commitment/cbc:ActionCode must contain @listAgencyName at least 1 time(s)</assert>
      <assert test="count(@listURI) &gt;= 1">doc:Commitment/cbc:ActionCode must contain @listURI at least 1 time(s)</assert>
      <assert test="count(@listVersionID) &gt;= 1">doc:Commitment/cbc:ActionCode must contain @listVersionID at least 1 time(s)</assert>
      <assert test="count(@listSchemeURI) &gt;= 1">doc:Commitment/cbc:ActionCode must contain @listSchemeURI at least 1 time(s)</assert>
      <assert test="count(@listAgencyID) &gt;= 1">doc:Commitment/cbc:ActionCode must contain @listAgencyID at least 1 time(s)</assert>
      <assert test="count(@listName) &gt;= 1">doc:Commitment/cbc:ActionCode must contain @listName at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Commitment/cbc:DocumentCurrencyCode">
      <assert test="count(@listAgencyID) &gt;= 1">doc:Commitment/cbc:DocumentCurrencyCode must contain @listAgencyID at least 1 time(s)</assert>
      <assert test="count(@listName) &gt;= 1">doc:Commitment/cbc:DocumentCurrencyCode must contain @listName at least 1 time(s)</assert>
      <assert test="count(@listAgencyName) &gt;= 1">doc:Commitment/cbc:DocumentCurrencyCode must contain @listAgencyName at least 1 time(s)</assert>
      <assert test="count(@listSchemeURI) &gt;= 1">doc:Commitment/cbc:DocumentCurrencyCode must contain @listSchemeURI at least 1 time(s)</assert>
      <assert test="count(@listID) &gt;= 1">doc:Commitment/cbc:DocumentCurrencyCode must contain @listID at least 1 time(s)</assert>
      <assert test="count(@listVersionID) &gt;= 1">doc:Commitment/cbc:DocumentCurrencyCode must contain @listVersionID at least 1 time(s)</assert>
      <assert test="count(@listURI) &gt;= 1">doc:Commitment/cbc:DocumentCurrencyCode must contain @listURI at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Delivery/cac:RequestedDeliveryPeriod">
      <assert test="count(cbc:StartDate) &gt;= 1">doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Delivery/cac:RequestedDeliveryPeriod must contain cbc:StartDate at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Item">
      <assert test="count(cbc:CatalogueIndicator) &gt;= 1">doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Item must contain cbc:CatalogueIndicator at least 1 time(s)</assert>
      <assert test="count(cbc:Description) &lt;= 1">doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Item may contain cbc:Description at most 1 time(s)</assert>
    </rule>
    <rule context="doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme">
      <assert test="count(cbc:Name) &gt;= 1">doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme must contain cbc:Name at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Commitment/nl-cac:CommitmentLine/cac:SellerSupplierParty">
      <assert test="count(cac:Party) &gt;= 1">doc:Commitment/nl-cac:CommitmentLine/cac:SellerSupplierParty must contain cac:Party at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Commitment/nl-cac:CommitmentLine/cac:SellerSupplierParty/cac:Party">
      <assert test="count(cac:PartyIdentification) &lt;= 3">doc:Commitment/nl-cac:CommitmentLine/cac:SellerSupplierParty/cac:Party may contain cac:PartyIdentification at most 3 time(s)</assert>
      <assert test="count(cac:PartyName) &lt;= 1">doc:Commitment/nl-cac:CommitmentLine/cac:SellerSupplierParty/cac:Party may contain cac:PartyName at most 1 time(s)</assert>
    </rule>
    <rule context="doc:Commitment/nl-cac:CommitmentLine/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID">
      <assert test="count(@schemeAgencyID) &gt;= 1">doc:Commitment/nl-cac:CommitmentLine/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyID at least 1 time(s)</assert>
      <assert test="count(@schemeAgencyName) &gt;= 1">doc:Commitment/nl-cac:CommitmentLine/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Commitment/nl-cac:CommitmentLine/nl-cac:CommitmentLineReference">
      <assert test="count(cac:DocumentReference) &gt;= 1">doc:Commitment/nl-cac:CommitmentLine/nl-cac:CommitmentLineReference must contain cac:DocumentReference at least 1 time(s)</assert>
    </rule>
  </pattern>
  <pattern id="type-restrictions">
    <rule context="doc:Commitment">
      <assert test="empty(cbc:UBLVersionID) or (cbc:UBLVersionID='2.0')">Bericht MOET gebaseerd zijn op UBL Versie 2.0</assert>
      <assert test="empty(cbc:CustomizationID) or (cbc:CustomizationID='1.9')">Bericht MOET gebaseerd zijn op versie 1.9 van de Nederlandse specificatie.</assert>
      <assert test="empty(cbc:ProfileID) or (cbc:ProfileID='NL')">Bericht MOET op de Nederlandse (NL) specificatie gebaseerd zijn.</assert>
      <assert test="every $bn in //cbc:BuildingNumber satisfies (matches($bn,'^\d+(-[ \w]+)?$'))">Huisnummer en Huisnummertoevoeging moeten achter elkaar geplaatst worden, gescheiden met een koppelteken.</assert>
      <assert test="every $id in //cac:PartyIdentification/cbc:ID satisfies (exists($id/@schemeAgencyID) and not(empty($id/@schemeAgencyID)) and exists($id/@schemeAgencyName) and not(empty($id/@schemeAgencyName)))">PartyIdentification/ID MOET @schemeAgencyID en @schemeAgencyName attributen bevatten.</assert>
      <assert test="every $pa in //cac:PostalAddress satisfies ((not(empty($pa/cbc:Postbox)) and empty($pa/cbc:StreetName) and empty($pa/cbc:BuildingNumber) and empty(cbc:Room) and empty(cbc:Floor) and empty(cbc:Department) and empty(cbc:InhouseMail) and empty(cbc:PlotIdentification)) or (empty($pa/cbc:Postbox) and (not(empty($pa/cbc:StreetName)) or not(empty($pa/cbc:BuildingNumber)) or not(empty(cbc:Room)) or not(empty(cbc:Floor)) or not(empty(cbc:Department)) or not(empty(cbc:InhouseMail)) or not(empty(cbc:PlotIdentification)))))">PostalAddress MOET OF een Postbox bevatten OF minimaal 1 van de elementen StreetName, BuildingNumber, Room, Floor, Department, InhouseMail of PlotIdentification. Beide MAG NIET.</assert>
      <assert test="every $pi in //cac:PartyIdentification satisfies (if(count($pi/cbc:ID[@schemeAgencyName = 'Vest']) = 1) then (count($pi/../cac:PartyIdentification/cbc:ID[@schemeAgencyName = 'KvK']) = 1) else ('true'))">Als Vestigingsnummer is opgegeven MOET Kamer van Koophandel nummer ook opgegeven worden.</assert>
      <assert test="( (count(cac:SellerSupplierParty) = 0) and (count(nl-cac:CommitmentLine/cac:SellerSupplierParty) = count(nl-cac:CommitmentLine))) or ( (count(cac:SellerSupplierParty) > 0) and (count(nl-cac:CommitmentLine/cac:SellerSupplierParty) = 0))">SellerSupplierParty MOET OF op algemeen niveau OF voor alle regels worden opgegeven.</assert>
      <assert test="empty(cbc:ActionCode) or (cbc:ActionCode='R') or (cbc:ActionCode='V')">doc:Commitment/cbc:ActionCode must have one of the following values: [R, V]</assert>
    </rule>
    <rule context="doc:Commitment/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID">
      <assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</assert>
      <assert test="empty(@schemeAgencyName) or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')">Uitgevende organisatie van de PartijIdentificatie MOET geïdentificeerd worden door een code uit de lijst: BTW, Fi, BSN, OIN, XXX.</assert>
    </rule>
    <rule context="doc:Commitment/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject">
      <assert test="string-length() > 0">doc:Commitment/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject must be filled</assert>
    </rule>
    <rule context="doc:Commitment/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode">
      <assert test="string-length() > 0">doc:Commitment/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode must be filled</assert>
    </rule>
    <rule context="doc:Commitment/cac:SellerSupplierParty">
      <assert test="(//doc:Commitment/cbc:ActionCode != 'V') or (cac:Party/cac:PartyName/cbc:Name != '')">Naam van leverancier MOET worden opgegeven indien berichttype 'V' is.</assert>
    </rule>
    <rule context="doc:Commitment/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID">
      <assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</assert>
      <assert test="empty(@schemeAgencyName) or (@schemeAgencyName='KvK') or (@schemeAgencyName='Vest') or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')">Uitgevende organisatie van de PartijIdentificatie MOET geïdentificeerd worden door een code uit de lijst: KvK, Vest, BTW, Fi, BSN, OIN, XXX.</assert>
    </rule>
    <rule context="doc:Commitment/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
      <assert test="empty(cbc:Name) or (cbc:Name='BTW') or (cbc:Name='Accijns') or (cbc:Name='Toeslag') or (cbc:Name='Overige')">doc:Commitment/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:Name must have one of the following values: [BTW, Accijns, Toeslag, Overige]</assert>
    </rule>
    <rule context="doc:Commitment/cbc:ActionCode">
      <assert test="empty(@listID) or (@listID='NL-1006')">doc:Commitment/cbc:ActionCode/@listID must have one of the following values: [NL-1006]</assert>
      <assert test="empty(@listAgencyName) or (@listAgencyName='Logius Gegevensbeheer NL-Overheid')">doc:Commitment/cbc:ActionCode/@listAgencyName must have one of the following values: [Logius Gegevensbeheer NL-Overheid]</assert>
      <assert test="empty(@listURI) or (@listURI='http://www.nltaxonomie.nl/ubl/2.0/NL/1.9/cl/gc/NL-ActionCode-1.9.gc')">doc:Commitment/cbc:ActionCode/@listURI must have one of the following values: [http://www.nltaxonomie.nl/ubl/2.0/NL/1.9/cl/gc/NL-ActionCode-1.9.gc]</assert>
      <assert test="empty(@listVersionID) or (@listVersionID='1.9')">doc:Commitment/cbc:ActionCode/@listVersionID must have one of the following values: [1.9]</assert>
      <assert test="empty(@listSchemeURI) or (@listSchemeURI='urn:digi-inkoop:ubl:2.0:NL:1.9:gc:ActionCode')">doc:Commitment/cbc:ActionCode/@listSchemeURI must have one of the following values: [urn:digi-inkoop:ubl:2.0:NL:1.9:gc:ActionCode]</assert>
      <assert test="empty(@listAgencyID) or (@listAgencyID='88')">doc:Commitment/cbc:ActionCode/@listAgencyID must have one of the following values: [88]</assert>
      <assert test="empty(@listName) or (@listName='ActieCode')">doc:Commitment/cbc:ActionCode/@listName must have one of the following values: [ActieCode]</assert>
    </rule>
    <rule context="doc:Commitment/cbc:DocumentCurrencyCode">
      <assert test="empty(@listAgencyID) or (@listAgencyID='6')">doc:Commitment/cbc:DocumentCurrencyCode/@listAgencyID must have one of the following values: [6]</assert>
      <assert test="empty(@listName) or (@listName='Currency')">doc:Commitment/cbc:DocumentCurrencyCode/@listName must have one of the following values: [Currency]</assert>
      <assert test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')">doc:Commitment/cbc:DocumentCurrencyCode/@listAgencyName must have one of the following values: [United Nations Economic Commission for Europe]</assert>
      <assert test="empty(@listSchemeURI) or (@listSchemeURI='urn:un:unece:uncefact:codelist:specification:54217')">doc:Commitment/cbc:DocumentCurrencyCode/@listSchemeURI must have one of the following values: [urn:un:unece:uncefact:codelist:specification:54217]</assert>
      <assert test="empty(@listID) or (@listID='ISO 4217 Alpha')">doc:Commitment/cbc:DocumentCurrencyCode/@listID must have one of the following values: [ISO 4217 Alpha]</assert>
      <assert test="empty(@listVersionID) or (@listVersionID='2001')">doc:Commitment/cbc:DocumentCurrencyCode/@listVersionID must have one of the following values: [2001]</assert>
      <assert test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/cefact/CurrencyCode-2.0.gc')">doc:Commitment/cbc:DocumentCurrencyCode/@listURI must have one of the following values: [http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/cefact/CurrencyCode-2.0.gc]</assert>
    </rule>
    <rule context="doc:Commitment/nl-cac:CommitmentLine/cac:LineItem">
      <assert test="matches(cbc:AccountingCost, '^[^@]*[@][^@]*$|^$')">/doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cbc:AccountingCost element MOET exact 1 @-teken bevatten als het niet leeg is!</assert>
    </rule>
    <rule context="doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Item">
      <assert test="(count(cbc:Description) + count(cac:BuyersItemIdentification/cbc:ID) + count(cac:SellersItemIdentification/cbc:ID) + count(cac:ManufacturersItemIdentification/cbc:ID) + count(cac:StandardItemIdentification/cbc:ID) + count(cac:CatalogueItemIdentification/cbc:ID)) > 0">Item MOET een Description OF een (party)Identification/ID bevatten.</assert>
    </rule>
    <rule context="doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme">
      <assert test="empty(cbc:Name) or (cbc:Name='BTW') or (cbc:Name='Accijns') or (cbc:Name='Toeslag') or (cbc:Name='Overige')">doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme/cbc:Name must have one of the following values: [BTW, Accijns, Toeslag, Overige]</assert>
    </rule>
    <rule context="doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Item/cbc:Description">
      <assert test="string-length() > 0">doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Item/cbc:Description must be filled</assert>
    </rule>
    <rule context="doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cbc:Quantity/@unitCode">
      <assert test="string-length() > 0">doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cbc:Quantity/@unitCode must be filled</assert>
    </rule>
    <rule context="doc:Commitment/nl-cac:CommitmentLine/cac:SellerSupplierParty">
      <assert test="(//doc:Commitment/cbc:ActionCode != 'V') or (cac:Party/cac:PartyName/cbc:Name != '')">Naam van leverancier MOET worden opgegeven indien berichttype 'V' is.</assert>
    </rule>
    <rule context="doc:Commitment/nl-cac:CommitmentLine/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID">
      <assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</assert>
      <assert test="empty(@schemeAgencyName) or (@schemeAgencyName='KvK') or (@schemeAgencyName='Vest') or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')">Uitgevende organisatie van de PartijIdentificatie MOET geïdentificeerd worden door een code uit de lijst: KvK, Vest, BTW, Fi, BSN, OIN, XXX.</assert>
    </rule>
  </pattern>
</schema>
