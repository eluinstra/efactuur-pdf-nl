<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns="http://purl.oclc.org/dsdl/schematron"
	xmlns:sch="http://purl.oclc.org/dsdl/schematron"
	xmlns:doc="urn:oasis:names:specification:ubl:schema:xsd:RequestForQuotationCancellation-2"
	xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
	xmlns:qdt="urn:oasis:names:specification:ubl:schema:xsd:QualifiedDataTypes-2"
	xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
	xmlns:ccts="urn:oasis:names:specification:ubl:schema:xsd:CoreComponentParameters-2"
	queryBinding="xslt2"
	schemaVersion="ISO19757-3"
>
<sch:ns prefix="doc" uri="urn:oasis:names:specification:ubl:schema:xsd:RequestForQuotationCancellation-2" />
<sch:ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" />
<sch:ns prefix="qdt" uri="urn:oasis:names:specification:ubl:schema:xsd:QualifiedDataTypes-2" />
<sch:ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" />
<sch:ns prefix="ccts" uri="urn:oasis:names:specification:ubl:schema:xsd:CoreComponentParameters-2" />
	<sch:pattern id="RequestForQuotationCancellation">
		<sch:rule context="/doc:RequestForQuotationCancellation/cbc:UBLVersionID">
			<sch:assert test="normalize-space(text()) = '2.0'">  Het bericht MOET gebaseerd zijn op UBL Versie 2.0</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotationCancellation/cbc:CustomizationID">
			<sch:assert test="normalize-space(text()) = '1.6'">  Bericht MOET gebaseerd zijn op versie 1.6 van de Nederlandse specificatie.</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotationCancellation/cbc:ProfileID">
			<sch:assert test="normalize-space(text()) = 'NL'">  Bericht MOET gebaseerd zijn op de Nederlande (NL) specificatie</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotationCancellation/cac:DocumentReference">
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotationCancellation">
			<sch:assert test="exists(cbc:UBLVersionID) ">  /doc:RequestForQuotationCancellation/cbc:UBLVersionID element should exist!</sch:assert>
			<sch:assert test="exists(cbc:CustomizationID) ">  /doc:RequestForQuotationCancellation/cbc:CustomizationID element should exist!</sch:assert>
			<sch:assert test="exists(cbc:ProfileID) ">  /doc:RequestForQuotationCancellation/cbc:ProfileID element should exist!</sch:assert>
			<sch:assert test="not(empty(cbc:ID))">  /doc:RequestForQuotationCancellation/cbc:ID element should not be empty!</sch:assert>
			<sch:assert test="every $bn in //cbc:BuildingNumber satisfies (matches($bn,'^\d+(-[ \w]+)?$'))">  Huisnummer en Huisnummertoevoeging moeten achter elkaar geplaatst worden, gescheiden met een koppelteken.</sch:assert>
			<sch:assert test="every $id in //cac:PartyIdentification/cbc:ID satisfies (exists($id/@schemeAgencyID) and not(empty($id/@schemeAgencyID)) and exists($id/@schemeAgencyName) and not(empty($id/@schemeAgencyName)))">  PartyIdentification/ID MOET @schemeAgencyID en @schemeAgencyName attributen bevatten.</sch:assert>
			<sch:assert test="every $pa in //cac:PostalAddress satisfies ((not(empty($pa/cbc:Postbox)) and empty($pa/cbc:StreetName) and empty($pa/cbc:BuildingNumber) and empty(cbc:Room) and empty(cbc:Floor) and empty(cbc:Department) and empty(cbc:InhouseMail) and empty(cbc:PlotIdentification)) or (empty($pa/cbc:Postbox) and (not(empty($pa/cbc:StreetName)) or not(empty($pa/cbc:BuildingNumber)) or not(empty(cbc:Room)) or not(empty(cbc:Floor)) or not(empty(cbc:Department)) or not(empty(cbc:InhouseMail)) or not(empty(cbc:PlotIdentification)))))">  PostalAddress MOET OF een Postbox bevatten OF minimaal 1 van de elementen StreetName, BuildingNumber, Room, Floor, Department, InhouseMail of PlotIdentification. Beide MAG NIET.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotationCancellation_OriginatorCustomerParty">
		<sch:rule context="/doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty">
			<sch:assert test="exists(cac:Party) ">  /doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party">
			<sch:assert test="count(cac:PartyIdentification) lt 3">  /doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:PartyIdentification element should be less than 3!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotationCancellation_OriginatorCustomerParty_Party">
		<sch:rule context="/doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party">
			<sch:assert test="exists(cac:PartyName) ">  /doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:PartyName element should exist!</sch:assert>
			<sch:assert test="count(cac:PartyName) lt 2 ">  /doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:PartyName element should be less than 2!</sch:assert>
			<sch:assert test="exists(cac:Contact) ">  /doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:Contact element should exist!</sch:assert>
			<sch:assert test="exists(cac:PartyIdentification) ">  /doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:PartyIdentification element should exist!</sch:assert>
			<sch:assert test="count(cac:PartyIdentification) lt 3 ">  /doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:PartyIdentification element should be less than 3!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:PartyIdentification">
			<sch:assert test="not(empty(cbc:ID))">  /doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID element should not be empty!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:PartyName">
			<sch:assert test="not(empty(cbc:Name))">  /doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:PartyName/cbc:Name element should not be empty!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:Contact">
			<sch:assert test="matches(cbc:Telephone, '^[-0-9]*$')">  Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</sch:assert>
			<sch:assert test="matches(cbc:Telefax, '^[-0-9]*$')">  Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotationCancellation_OriginatorCustomerParty_Party_Contact">
		<sch:rule context="/doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:Contact/cbc:Name">
			<sch:assert test="string-length(text()) > 0 ">  /doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:Contact/cbc:Name element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:Contact">
			<sch:assert test="exists(cbc:Name) ">  /doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:Contact/cbc:Name element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotationCancellation_SellerSupplierParty">
		<sch:rule context="/doc:RequestForQuotationCancellation/cac:SellerSupplierParty">
			<sch:assert test="exists(cac:Party) ">  /doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cbc:CustomerAssignedAccountID">
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party">
			<sch:assert test="count(cac:PartyIdentification) lt 3">  /doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification element should be less than 3!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotationCancellation_SellerSupplierParty_Party">
		<sch:rule context="/doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party">
			<sch:assert test="count(cac:PartyName) lt 2 ">  /doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:PartyName element should be less than 2!</sch:assert>
			<sch:assert test="count(cac:PartyIdentification) lt 3 ">  /doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification element should be less than 3!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:PartyName">
			<sch:assert test="not(empty(cbc:Name))">  /doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:PartyName/cbc:Name element should not be empty!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:Contact">
			<sch:assert test="matches(cbc:Telephone, '^[-0-9]*$')">  Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</sch:assert>
			<sch:assert test="matches(cbc:Telefax, '^[-0-9]*$')">  Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotationCancellation_SellerSupplierParty_Party_PostalAddress">
		<sch:rule context="/doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:PostalAddress">
			<sch:assert test="exists(cac:Country) ">  /doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotationCancellation_OriginatorCustomerParty_Party_PartyIdentification">
		<sch:rule context="/doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID">
			<sch:assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">  Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</sch:assert>
			<sch:assert test="(@schemeAgencyName  = 'KvK') or (@schemeAgencyName  = 'BTW') or (@schemeAgencyName = 'Fi') or (@schemeAgencyName  = 'BSN') or (@schemeAgencyName  = 'OIN') or (@schemeAgencyName  = 'XXX')">  Uitgevende organisatie van de PartijIdentificatie MOET ge?dentificeerd worden door een code uit de lijst: KvK, BTW, Fi, BSN, OIN, XXX.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotationCancellation_SellerSupplierParty_Party_PartyIdentification">
		<sch:rule context="/doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID">
			<sch:assert test="string-length(text()) > 0 ">  /doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID element should exist!</sch:assert>
			<sch:assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">  Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</sch:assert>
			<sch:assert test="(@schemeAgencyName  = 'KvK') or (@schemeAgencyName  = 'BTW') or (@schemeAgencyName = 'Fi') or (@schemeAgencyName  = 'BSN') or (@schemeAgencyName  = 'OIN') or (@schemeAgencyName  = 'XXX')">  Uitgevende organisatie van de PartijIdentificatie MOET ge?dentificeerd worden door een code uit de lijst: KvK, BTW, Fi, BSN, OIN, XXX.</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification">
			<sch:assert test="exists(cbc:ID) ">  /doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotationCancellation_DocumentReference">
		<sch:rule context="/doc:RequestForQuotationCancellation/cac:DocumentReference/cbc:DocumentType">
			<sch:assert test="string-length(text()) > 0 ">  /doc:RequestForQuotationCancellation/cac:DocumentReference/cbc:DocumentType element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotationCancellation/cac:DocumentReference">
			<sch:assert test="exists(cbc:DocumentType) and not(empty(cbc:DocumentType))">  Indien de identificatie van een offerte meegegeven wordt, moet hier 'Offerte' opgegeven worden.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotationCancellation_DocumentReference_Attachment">
		<sch:rule context="/doc:RequestForQuotationCancellation/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject">
			<sch:assert test="string-length(text()) > 0 ">  /doc:RequestForQuotationCancellation/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject element should exist!</sch:assert>
			<sch:assert test="string-length(@mimeCode) > 0 ">  /doc:RequestForQuotationCancellation/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode element should exist!</sch:assert>
			<sch:assert test="exists(@mimeCode)">  /doc:RequestForQuotationCancellation/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotationCancellation/cac:DocumentReference/cac:Attachment">
			<sch:assert test="exists(cbc:EmbeddedDocumentBinaryObject) ">  /doc:RequestForQuotationCancellation/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotationCancellation_OriginatorCustomerParty_Party_PhysicalLocation_Address">
		<sch:rule context="/doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address">
			<sch:assert test="exists(cac:Country) ">  /doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotationCancellation_OriginatorCustomerParty_Party_PhysicalLocation_Address_Country">
		<sch:rule context="/doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode">
			<sch:assert test="string-length(text()) > 0 ">  /doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country">
			<sch:assert test="exists(cbc:IdentificationCode) ">  /doc:RequestForQuotationCancellation/cac:OriginatorCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotationCancellation_SellerSupplierParty_Party_Contact">
		<sch:rule context="/doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name">
			<sch:assert test="string-length(text()) > 0 ">  /doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:Contact">
			<sch:assert test="exists(cbc:Name) ">  /doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotationCancellation_SellerSupplierParty_Party_PostalAddress_Country">
		<sch:rule context="/doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode">
			<sch:assert test="string-length(text()) > 0 ">  /doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country">
			<sch:assert test="exists(cbc:IdentificationCode) ">  /doc:RequestForQuotationCancellation/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
</sch:schema>