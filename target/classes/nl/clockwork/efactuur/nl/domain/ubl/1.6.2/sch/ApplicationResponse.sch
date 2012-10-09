<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns="http://purl.oclc.org/dsdl/schematron"
	xmlns:sch="http://purl.oclc.org/dsdl/schematron"
	xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
	xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
	xmlns:qdt="urn:oasis:names:specification:ubl:schema:xsd:QualifiedDataTypes-2"
	xmlns:ccts="urn:oasis:names:specification:ubl:schema:xsd:CoreComponentParameters-2"
	xmlns:doc="urn:oasis:names:specification:ubl:schema:xsd:ApplicationResponse-2"
	queryBinding="xslt2"
	schemaVersion="ISO19757-3"
>
<sch:ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" />
<sch:ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" />
<sch:ns prefix="qdt" uri="urn:oasis:names:specification:ubl:schema:xsd:QualifiedDataTypes-2" />
<sch:ns prefix="ccts" uri="urn:oasis:names:specification:ubl:schema:xsd:CoreComponentParameters-2" />
<sch:ns prefix="doc" uri="urn:oasis:names:specification:ubl:schema:xsd:ApplicationResponse-2" />
	<sch:pattern id="ApplicationResponse">
		<sch:rule context="/doc:ApplicationResponse">
			<sch:assert test="exists(cbc:UBLVersionID) ">/doc:ApplicationResponse/cbc:UBLVersionID element should exist!</sch:assert>
			<sch:assert test="exists(cbc:CustomizationID) ">/doc:ApplicationResponse/cbc:CustomizationID element should exist!</sch:assert>
			<sch:assert test="exists(cbc:ProfileID) ">/doc:ApplicationResponse/cbc:ProfileID element should exist!</sch:assert>
			<sch:assert test="every $bn in //cbc:BuildingNumber satisfies (matches($bn,'^\d+(-[ \w]+)?$'))">Huisnummer en Huisnummertoevoeging moeten achter elkaar geplaatst worden, gescheiden met een koppelteken.</sch:assert>
			<sch:assert test="every $id in //cac:PartyIdentification/cbc:ID satisfies (exists($id/@schemeAgencyID) and not(empty($id/@schemeAgencyID)) and exists($id/@schemeAgencyName) and not(empty($id/@schemeAgencyName)))">PartyIdentification/ID MOET @schemeAgencyID en @schemeAgencyName attributen bevatten.</sch:assert>
			<sch:assert test="every $pa in //cac:PostalAddress satisfies ((not(empty($pa/cbc:Postbox)) and empty($pa/cbc:StreetName) and empty($pa/cbc:BuildingNumber) and empty(cbc:Room) and empty(cbc:Floor) and empty(cbc:Department) and empty(cbc:InhouseMail) and empty(cbc:PlotIdentification)) or (empty($pa/cbc:Postbox) and (not(empty($pa/cbc:StreetName)) or not(empty($pa/cbc:BuildingNumber)) or not(empty(cbc:Room)) or not(empty(cbc:Floor)) or not(empty(cbc:Department)) or not(empty(cbc:InhouseMail)) or not(empty(cbc:PlotIdentification)))))">PostalAddress MOET OF een Postbox bevatten OF minimaal 1 van de elementen StreetName, BuildingNumber, Room, Floor, Department, InhouseMail of PlotIdentification. Beide MAG NIET.</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:ApplicationResponse/cbc:UBLVersionID">
			<sch:assert test="normalize-space(text()) = '2.0'">Bericht MOET gebaseerd zijn op UBL Versie 2.0</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:ApplicationResponse/cbc:CustomizationID">
			<sch:assert test="normalize-space(text()) = '1.6'">Bericht MOET gebaseerd zijn op versie 1.6 van de Nederlandse specificatie.</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:ApplicationResponse/cbc:ProfileID">
			<sch:assert test="normalize-space(text()) = 'NL'">Bericht MOET op de Nederlandse (NL) specificatie gebaseerd zijn.</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:ApplicationResponse/cbc:ID">
			<sch:assert test="string-length(text()) lt 11">Element lengte MOET minder dan 11 posities zijn.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="ApplicationResponse_SenderParty">
		<sch:rule context="/doc:ApplicationResponse/cac:SenderParty">
			<sch:assert test="exists(cac:PartyIdentification) ">/doc:ApplicationResponse/cac:SenderParty/cac:PartyIdentification element should exist!</sch:assert>
			<sch:assert test="count(cac:PartyIdentification) lt 3 ">/doc:ApplicationResponse/cac:SenderParty/cac:PartyIdentification element should be less than 3!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="ApplicationResponse_SenderParty">
		<sch:rule context="/doc:ApplicationResponse/cac:SenderParty">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="ApplicationResponse_SenderParty">
		<sch:rule context="/doc:ApplicationResponse/cac:SenderParty">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="ApplicationResponse_SenderParty_PartyIdentification">
		<sch:rule context="/doc:ApplicationResponse/cac:SenderParty/cac:PartyIdentification/cbc:ID">
			<sch:assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</sch:assert>
			<sch:assert test="(@schemeAgencyName  = 'KvK') or (@schemeAgencyName  = 'BTW') or (@schemeAgencyName = 'Fi') or (@schemeAgencyName  = 'BSN') or (@schemeAgencyName  = 'OIN') or (@schemeAgencyName  = 'XXX')">Uitgevende organisatie van de PartijIdentificatie MOET ge?dentificeerd worden door een code uit de lijst: KvK, BTW, Fi, BSN, OIN, XXX.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="ApplicationResponse_ReceiverParty">
		<sch:rule context="/doc:ApplicationResponse/cac:ReceiverParty">
			<sch:assert test="exists(cac:PartyIdentification) ">/doc:ApplicationResponse/cac:ReceiverParty/cac:PartyIdentification element should exist!</sch:assert>
			<sch:assert test="count(cac:PartyIdentification) lt 3 ">/doc:ApplicationResponse/cac:ReceiverParty/cac:PartyIdentification element should be less than 3!</sch:assert>
			<sch:assert test="count(cac:PartyName) lt 2 ">/doc:ApplicationResponse/cac:ReceiverParty/cac:PartyName element should be less than 2!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="ApplicationResponse_ReceiverParty">
		<sch:rule context="/doc:ApplicationResponse/cac:ReceiverParty/cac:PartyIdentification">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="ApplicationResponse_ReceiverParty_PartyIdentification">
		<sch:rule context="/doc:ApplicationResponse/cac:ReceiverParty/cac:PartyIdentification/cbc:ID">
			<sch:assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</sch:assert>
			<sch:assert test="(@schemeAgencyName  = 'KvK') or (@schemeAgencyName  = 'BTW') or (@schemeAgencyName = 'Fi') or (@schemeAgencyName  = 'BSN') or (@schemeAgencyName  = 'OIN') or (@schemeAgencyName  = 'XXX')">Uitgevende organisatie van de PartijIdentificatie MOET ge?dentificeerd worden door een code uit de lijst: KvK, BTW, Fi, BSN, OIN, XXX.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="ApplicationResponse_DocumentResponse_Response">
		<sch:rule context="/doc:ApplicationResponse/cac:DocumentResponse/cac:Response">
			<sch:assert test="count(cbc:Description) lt 2 ">/doc:ApplicationResponse/cac:DocumentResponse/cac:Response/cbc:Description element should be less than 2!</sch:assert>
		</sch:rule>
	</sch:pattern>
</sch:schema>