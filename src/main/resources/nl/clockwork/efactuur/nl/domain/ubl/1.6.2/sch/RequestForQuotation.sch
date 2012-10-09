<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns="http://purl.oclc.org/dsdl/schematron"
	xmlns:sch="http://purl.oclc.org/dsdl/schematron"
	xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
	xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
	xmlns:doc="urn:oasis:names:specification:ubl:schema:xsd:RequestForQuotation-2"
	xmlns:qdt="urn:oasis:names:specification:ubl:schema:xsd:QualifiedDataTypes-2"
	xmlns:ccts="urn:oasis:names:specification:ubl:schema:xsd:CoreComponentParameters-2"
	xmlns:ext="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"
	xmlns:nl-cbc="urn:digi-inkoop:ubl:2.0:NL:1.6:UBL-NL-CommonBasicComponents-2"
	xmlns:nl-cac="urn:digi-inkoop:ubl:2.0:NL:1.6:UBL-NL-CommonAggregateComponents-2"
	queryBinding="xslt2"
	schemaVersion="ISO19757-3"
>
<sch:ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" />
<sch:ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" />
<sch:ns prefix="doc" uri="urn:oasis:names:specification:ubl:schema:xsd:RequestForQuotation-2" />
<sch:ns prefix="qdt" uri="urn:oasis:names:specification:ubl:schema:xsd:QualifiedDataTypes-2" />
<sch:ns prefix="ccts" uri="urn:oasis:names:specification:ubl:schema:xsd:CoreComponentParameters-2" />
<sch:ns prefix="ext" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2" />
<sch:ns prefix="nl-cbc" uri="urn:digi-inkoop:ubl:2.0:NL:1.6:UBL-NL-CommonBasicComponents-2" />
<sch:ns prefix="nl-cac" uri="urn:digi-inkoop:ubl:2.0:NL:1.6:UBL-NL-CommonAggregateComponents-2" />
	<sch:pattern id="RequestForQuotation_UBLExtensions">
	    <!-- Manually maintained rules for the extensions (cannot be done in eDoCreator -->

		<sch:rule context="/doc:RequestForQuotation/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cbc:AwardDate">
            <sch:assert test="matches(text(), '^[0-9]{4}-[0-9]{2}-[0-9]{2}$')">  AwardDate moet een geldige datum waarde bevatten: eejj-mm-dd.</sch:assert>
		</sch:rule>

		<sch:rule context="/doc:RequestForQuotation/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cbc:NegotiationStyle">
		    <sch:assert test="text() = 'E' or text() = 'S'">Element NegotiationStyle MOET de waarde 'E' (eenvoudig) of 'S' (standaard) bevatten.</sch:assert>
		</sch:rule>
											   
		<sch:rule context="/doc:RequestForQuotation/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:GrantedValidityPeriod">
			<sch:assert test="exists(cbc:StartDate) ">/doc:RequestForQuotation/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:GrantedValidityPeriod/cbc:StartDate should exist!</sch:assert>
			<sch:assert test="exists(cbc:EndDate) ">/doc:RequestForQuotation/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:GrantedValidityPeriod/cbc:EndDate should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:GrantedValidityPeriod/cbc:StartDate">
            <sch:assert test="matches(text(), '^[0-9]{4}-[0-9]{2}-[0-9]{2}$')">  GrantedValidityPeriod/StartDate moet een geldige datum waarde bevatten: eejj-mm-dd.</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:GrantedValidityPeriod/cbc:EndDate">
            <sch:assert test="matches(text(), '^[0-9]{4}-[0-9]{2}-[0-9]{2}$')">  GrantedValidityPeriod/EndDate moet een geldige datum waarde bevatten: eejj-mm-dd.</sch:assert>
		</sch:rule>

		<sch:rule context="/doc:RequestForQuotation/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:RequestedValidityPeriod">
			<sch:assert test="exists(cbc:StartDate) ">/doc:RequestForQuotation/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:RequestedValidityPeriod/cbc:StartDate should exist!</sch:assert>
			<sch:assert test="exists(cbc:EndDate) ">/doc:RequestForQuotation/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:RequestedValidityPeriod/cbc:EndDate should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:RequestedValidityPeriod/cbc:StartDate">
            <sch:assert test="matches(text(), '^[0-9]{4}-[0-9]{2}-[0-9]{2}$')">  RequestedValidityPeriod/StartDate moet een geldige datum waarde bevatten: eejj-mm-dd.</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:RequestedValidityPeriod/cbc:EndDate">
            <sch:assert test="matches(text(), '^[0-9]{4}-[0-9]{2}-[0-9]{2}$')">  RequestedValidityPeriod/EndDate moet een geldige datum waarde bevatten: eejj-mm-dd.</sch:assert>
		</sch:rule>

		<sch:rule context="/doc:RequestForQuotation/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cbc:NegotiationStyle">
			<sch:assert test="normalize-space(@listID) = 'NL-1003'">Attribuut MOET de waarde NL-1003 bevatten.</sch:assert>
			<sch:assert test="normalize-space(@listAgencyID) = xs:string(88)">Attribuut MOET de waarde 88 bevatten.</sch:assert>
			<sch:assert test="normalize-space(@listAgencyName) = 'Logius Gegevensbeheer NL-Overheid'">Attribuut MOET de waarde 'Logius Gegevensbeheer NL-Overheid' bevatten.</sch:assert>
			<sch:assert test="normalize-space(@listName) = 'Onderhandelingsstijl'">Attribuut MOET de waarde Onderhandelingsstijl bevatten.</sch:assert>
			<sch:assert test="normalize-space(@listVersionID) = xs:string(1.6)">Attribuut MOET de waarde 1.6 bevatten.</sch:assert>
			<sch:assert test="normalize-space(@listSchemeURI) = 'urn:digi-inkoop:ubl:2.0:NL:1.6:gc:NegotiationStyleCode'">Attribuut MOET de waarde urn:digi-inkoop:ubl:2.0:NL:1.6:gc:NegotiationStyleCode bevatten.</sch:assert>
			<sch:assert test="normalize-space(@listURI) = 'http://www.nltaxonomie.nl/ubl/2.0/NL/1.6/cl/gc/NegotiationStyleCode.gc'">Attribuut MOET de waarde http://www.nltaxonomie.nl/ubl/2.0/NL/1.6/cl/gc/NegotiationStyleCode.gc bevatten.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation">
		<sch:rule context="/doc:RequestForQuotation/cbc:UBLVersionID">
			<sch:assert test="normalize-space(text()) = '2.0'">  Bericht MOET gebaseerd zijn op UBL versie 2.0.</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/cbc:CustomizationID">
			<sch:assert test="normalize-space(text()) = '1.6'">  Bericht MOET gebaseerd zijn op versie 1.6 van de Nederlandse specificatie.</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/cbc:ProfileID">
			<sch:assert test="normalize-space(text())= 'NL'">  Bericht MOET gebaseerd zijn op de Nederlandse (NL) specificatie.</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/cbc:ID">
			<sch:assert test="string-length(text()) > 0 ">  /doc:RequestForQuotation/cbc:ID element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation">
			<sch:assert test="count(cbc:Note) lt 2 ">  /doc:RequestForQuotation/cbc:Note element should be less than 2!</sch:assert>
			<sch:assert test="count(cac:Delivery) lt 2 ">  /doc:RequestForQuotation/cac:Delivery element should be less than 2!</sch:assert>
			<sch:assert test="count(cac:Contract) lt 2 ">  /doc:RequestForQuotation/cac:Contract element should be less than 2!</sch:assert>
			<sch:assert test="exists(cac:OriginatorCustomerParty) ">  /doc:RequestForQuotation/cac:OriginatorCustomerParty element should exist!</sch:assert>
			<sch:assert test="exists(cac:SellerSupplierParty) ">  /doc:RequestForQuotation/cac:SellerSupplierParty element should exist!</sch:assert>
			<sch:assert test="( (count(cac:Delivery/cac:DeliveryAddress) = 0) and (count(cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress) = count(cac:RequestForQuotationLine/cac:LineItem)))or( (count(cac:Delivery/cac:DeliveryAddress) > 0) and (count(cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress) = 0))">  Afleveradres MOET OF op algemeen niveau OF voor alle regels worden opgegeven.</sch:assert>
			<sch:assert test="( (count(cac:Delivery/cac:RequestedDeliveryPeriod) = 0) and (count(cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:RequestedDeliveryPeriod) = count(cac:RequestForQuotationLine/cac:LineItem)))or( (count(cac:Delivery/cac:RequestedDeliveryPeriod) > 0) and (count(cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:RequestedDeliveryPeriod) = 0))">  Levertijd MOET OF op algemeen niveau OF voor alle regels worden opgegeven.</sch:assert>
			<sch:assert test="exists(cbc:UBLVersionID) ">  /doc:RequestForQuotation/cbc:UBLVersionID element should exist!</sch:assert>
			<sch:assert test="exists(cbc:CustomizationID) ">  /doc:RequestForQuotation/cbc:CustomizationID element should exist!</sch:assert>
			<sch:assert test="exists(cbc:ProfileID) ">  /doc:RequestForQuotation/cbc:ProfileID element should exist!</sch:assert>
			<sch:assert test="exists(cbc:ID) ">  /doc:RequestForQuotation/cbc:ID element should exist!</sch:assert>
			<sch:assert test="every $bn in //cbc:BuildingNumber satisfies (matches($bn,'^\d+(-[ \w]+)?$'))">  Huisnummer en Huisnummertoevoeging moeten achter elkaar geplaatst worden, gescheiden met een koppelteken.</sch:assert>
			<sch:assert test="(count(cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact) = count(cac:RequestForQuotationLine/cac:LineItem))or(count(cac:SellerSupplierParty/cac:Party/cac:Contact) > 0)">  Leverancier contactpersoon MOET voor alle regels worden opgegeven ALS NIET op algemeen niveau opgegeven.</sch:assert>
			<sch:assert test="every $id in //cac:PartyIdentification/cbc:ID satisfies (exists($id/@schemeAgencyID) and not(empty($id/@schemeAgencyID)) and exists($id/@schemeAgencyName) and not(empty($id/@schemeAgencyName)))">  PartyIdentification/ID MOET @schemeAgencyID en @schemeAgencyName attributen bevatten.</sch:assert>
			<sch:assert test="count(cac:DeliveryTerms) lt 2 ">  /doc:RequestForQuotation/cac:DeliveryTerms element should be less than 2!</sch:assert>
			<sch:assert test="every $pa in //cac:PostalAddress satisfies ((not(empty($pa/cbc:Postbox)) and empty($pa/cbc:StreetName) and empty($pa/cbc:BuildingNumber) and empty(cbc:Room) and empty(cbc:Floor) and empty(cbc:Department) and empty(cbc:InhouseMail) and empty(cbc:PlotIdentification)) or (empty($pa/cbc:Postbox) and (not(empty($pa/cbc:StreetName)) or not(empty($pa/cbc:BuildingNumber)) or not(empty(cbc:Room)) or not(empty(cbc:Floor)) or not(empty(cbc:Department)) or not(empty(cbc:InhouseMail)) or not(empty(cbc:PlotIdentification)))))">  PostalAddress MOET OF een Postbox bevatten OF minimaal 1 van de elementen StreetName, BuildingNumber, Room, Floor, Department, InhouseMail of PlotIdentification. Beide MAG NIET.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation_AdditionalDocumentReference_Attachment">
		<sch:rule context="/doc:RequestForQuotation/cac:AdditionalDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject">
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/cac:AdditionalDocumentReference/cac:Attachment">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation_OriginatorCustomerParty">
		<sch:rule context="/doc:RequestForQuotation/cac:OriginatorCustomerParty">
			<sch:assert test="exists(cac:Party) ">  /doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party">
			<sch:assert test="count(cac:PartyIdentification) lt 3">  /doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:PartyIdentification element should be less than 3!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation_OriginatorCustomerParty_Party">
		<sch:rule context="/doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party">
			<sch:assert test="count(cac:PartyName) lt 2 ">  /doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:PartyName element should be less than 2!</sch:assert>
			<sch:assert test="exists(cac:PartyName) ">  /doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:PartyName element should exist!</sch:assert>
			<sch:assert test="exists(cac:PartyIdentification) ">  /doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:PartyIdentification element should exist!</sch:assert>
			<sch:assert test="exists(cac:Contact) ">  /doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:Contact element should exist!</sch:assert>
			<sch:assert test="count(cac:PartyIdentification) lt 3 ">  /doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:PartyIdentification element should be less than 3!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:PartyIdentification">
			<sch:assert test="not(empty(cbc:ID))">  /doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID element should not be empty!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:PartyName">
			<sch:assert test="not(empty(cbc:Name))">  /doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:PartyName/cbc:Name element should not be empty!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:AgentParty">
			<sch:assert test="count(cac:PartyIdentification) lt 3">  /doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:PartyIdentification element should be less than 3!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:Contact">
			<sch:assert test="matches(cbc:Telephone, '^[-0-9]*$')">  Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</sch:assert>
			<sch:assert test="matches(cbc:Telefax, '^[-0-9]*$')">  Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation_OriginatorCustomerParty_Party_PartyIdentification">
		<sch:rule context="/doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID">
			<sch:assert test="(@schemeAgencyName  = 'KvK') or (@schemeAgencyName  = 'BTW') or (@schemeAgencyName = 'Fi') or (@schemeAgencyName  = 'BSN') or (@schemeAgencyName  = 'OIN') or (@schemeAgencyName  = 'XXX')">  Uitgevende organisatie van de PartijIdentificatie MOET ge?dentificeerd worden door een code uit de lijst: KvK, BTW, Fi, BSN, OIN, XXX.</sch:assert>
			<sch:assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">  Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation_OriginatorCustomerParty_Party_PostalAddress">
		<sch:rule context="/doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:PostalAddress">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation_OriginatorCustomerParty_Party_PostalAddress_Country">
		<sch:rule context="/doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode">
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:PostalAddress/cac:Country">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation_OriginatorCustomerParty_Party_Contact">
		<sch:rule context="/doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:Contact/cbc:Name">
			<sch:assert test="string-length(text()) > 0 ">  /doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:Contact/cbc:Name element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:Contact">
			<sch:assert test="exists(cbc:Name) ">  /doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:Contact/cbc:Name element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation_OriginatorCustomerParty_Party_AgentParty">
		<sch:rule context="/doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:AgentParty">
			<sch:assert test="count(cac:PartyName) lt 2 ">  /doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:AgentParty/cac:PartyName element should be less than 2!</sch:assert>
			<sch:assert test="exists(cac:PartyName) ">  /doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:AgentParty/cac:PartyName element should exist!</sch:assert>
			<sch:assert test="exists(cac:PartyIdentification) ">  /doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification element should exist!</sch:assert>
			<sch:assert test="count(cac:PartyIdentification) lt 3 ">  /doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification element should be less than 3!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:AgentParty/cac:Contact">
			<sch:assert test="matches(cbc:Telefax, '^[-0-9]*$')">  Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</sch:assert>
			<sch:assert test="matches(cbc:Telephone, '^[-0-9]*$')">  Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation_OriginatorCustomerParty_Party_AgentParty_PartyIdentification">
		<sch:rule context="/doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification/cbc:ID">
			<sch:assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">  Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</sch:assert>
			<sch:assert test="(@schemeAgencyName  = 'KvK') or (@schemeAgencyName  = 'BTW') or (@schemeAgencyName = 'Fi') or (@schemeAgencyName  = 'BSN') or (@schemeAgencyName  = 'OIN') or (@schemeAgencyName  = 'XXX')">  Uitgevende organisatie van de PartijIdentificatie MOET ge?dentificeerd worden door een code uit de lijst: KvK, BTW, Fi, BSN, OIN, XXX.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation_OriginatorCustomerParty_Party_AgentParty_PostalAddress">
		<sch:rule context="/doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress">
			<sch:assert test="exists(cac:Country) ">  /doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation_OriginatorCustomerParty_Party_AgentParty_PostalAddress_Country">
		<sch:rule context="/doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode">
			<sch:assert test="string-length(text()) > 0 ">  /doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country">
			<sch:assert test="exists(cbc:IdentificationCode) ">  /doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation_SellerSupplierParty">
		<sch:rule context="/doc:RequestForQuotation/cac:SellerSupplierParty">
			<sch:assert test="exists(cac:Party) ">  /doc:RequestForQuotation/cac:SellerSupplierParty/cac:Party element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/cac:SellerSupplierParty/cac:Party">
			<sch:assert test="count(cac:PartyIdentification) lt 3">  /doc:RequestForQuotation/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification element should be less than 3!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation_SellerSupplierParty_Party">
		<sch:rule context="/doc:RequestForQuotation/cac:SellerSupplierParty/cac:Party">
			<sch:assert test="count(cac:PartyName) lt 2 ">  /doc:RequestForQuotation/cac:SellerSupplierParty/cac:Party/cac:PartyName element should be less than 2!</sch:assert>
			<sch:assert test="exists(cac:PartyName) ">  /doc:RequestForQuotation/cac:SellerSupplierParty/cac:Party/cac:PartyName element should exist!</sch:assert>
			<sch:assert test="exists(cac:PostalAddress) ">  /doc:RequestForQuotation/cac:SellerSupplierParty/cac:Party/cac:PostalAddress element should exist!</sch:assert>
			<sch:assert test="count(cac:PartyIdentification) lt 3 ">  /doc:RequestForQuotation/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification element should be less than 3!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/cac:SellerSupplierParty/cac:Party/cac:PartyName">
			<sch:assert test="not(empty(cbc:Name))">  /doc:RequestForQuotation/cac:SellerSupplierParty/cac:Party/cac:PartyName/cbc:Name element should not be empty!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/cac:SellerSupplierParty/cac:Party/cac:Contact">
			<sch:assert test="matches(cbc:Telefax, '^[-0-9]*$')">  Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</sch:assert>
			<sch:assert test="matches(cbc:Telephone, '^[-0-9]*$')">  Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation_SellerSupplierParty_Party_PostalAddress">
		<sch:rule context="/doc:RequestForQuotation/cac:SellerSupplierParty/cac:Party/cac:PostalAddress">
			<sch:assert test="exists(cac:Country) ">  /doc:RequestForQuotation/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation_SellerSupplierParty_Party_PostalAddress_Country">
		<sch:rule context="/doc:RequestForQuotation/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode">
			<sch:assert test="string-length(text()) > 0 ">  /doc:RequestForQuotation/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country">
			<sch:assert test="exists(cbc:IdentificationCode) ">  /doc:RequestForQuotation/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation_SellerSupplierParty_Party_Contact">
		<sch:rule context="/doc:RequestForQuotation/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name">
			<sch:assert test="string-length(text()) > 0 ">  /doc:RequestForQuotation/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/cac:SellerSupplierParty/cac:Party/cac:Contact">
			<sch:assert test="exists(cbc:Name) ">  /doc:RequestForQuotation/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation_Delivery_DeliveryAddress">
		<sch:rule context="/doc:RequestForQuotation/cac:Delivery/cac:DeliveryAddress">
			<sch:assert test="exists(cac:Country) ">  /doc:RequestForQuotation/cac:Delivery/cac:DeliveryAddress/cac:Country element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation_Delivery_DeliveryAddress_Country">
		<sch:rule context="/doc:RequestForQuotation/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode">
			<sch:assert test="string-length(text()) > 0 ">  /doc:RequestForQuotation/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/cac:Delivery/cac:DeliveryAddress/cac:Country">
			<sch:assert test="exists(cbc:IdentificationCode) ">  /doc:RequestForQuotation/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation_Delivery_RequestedDeliveryPeriod">
		<sch:rule context="/doc:RequestForQuotation/cac:Delivery/cac:RequestedDeliveryPeriod/cbc:EndDate">
			<sch:assert test="string-length(text()) > 0 ">  /doc:RequestForQuotation/cac:Delivery/cac:RequestedDeliveryPeriod/cbc:EndDate element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/cac:Delivery/cac:RequestedDeliveryPeriod">
			<sch:assert test="exists(cbc:EndDate) ">  /doc:RequestForQuotation/cac:Delivery/cac:RequestedDeliveryPeriod/cbc:EndDate element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation_Delivery_DeliveryParty">
		<sch:rule context="/doc:RequestForQuotation/cac:Delivery/cac:DeliveryParty">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation_RequestForQuotationLine">
		<sch:rule context="/doc:RequestForQuotation/cac:RequestForQuotationLine/cac:DocumentReference">
			<sch:assert test="exists(cbc:DocumentType) and not(empty(cbc:DocumentType))">  Indien de identificatie van een contract meegegeven wordt, moet hier 'Contract' opgegeven worden. Bij bijlagen in de vorm van specificaties moet hier 'Specificaties' opgegeven worden</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem">
			<sch:assert test="not(empty(cbc:ID))">  /doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cbc:ID element should not be empty!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation_RequestForQuotationLine_LineItem">
		<sch:rule context="/doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cbc:Quantity">
			<sch:assert test="string-length(@unitCode) > 0 ">  /doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cbc:Quantity/@unitCode element should exist!</sch:assert>
			<sch:assert test="string-length(text()) > 0 ">  /doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cbc:Quantity element should exist!</sch:assert>
			<sch:assert test="exists(@unitCode)">  /doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cbc:Quantity/@unitCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Item">
			<sch:assert test="( (count(cbc:Description) = 0) and (   (count(cac:BuyersItemIdentification/cbc:ID) + count(cac:SellersItemIdentification/cbc:ID) + count(cac:ManufacturersItemIdentification/cbc:ID) + count(cac:StandardItemIdentification/cbc:ID) + count(cac:CatalogueItemIdentification/cbc:ID)) > 0 ))or( (count(cbc:Description) > 0) and (   (count(cac:BuyersItemIdentification/cbc:ID) + count(cac:SellersItemIdentification/cbc:ID) + count(cac:ManufacturersItemIdentification/cbc:ID) + count(cac:StandardItemIdentification/cbc:ID) + count(cac:CatalogueItemIdentification/cbc:ID)) = 0 ))">  Item MOET OF een Description OF een (party)Identification/ID bevatten</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem">
			<sch:assert test="exists(cbc:Quantity) ">  /doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cbc:Quantity element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation_RequestForQuotationLine_LineItem_Item">
		<sch:rule context="/doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Item">
			<sch:assert test="count(cbc:Description) lt 2 ">  /doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Item/cbc:Description element should be less than 2!</sch:assert>
			<sch:assert test="exists(cbc:CatalogueIndicator) ">  /doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Item/cbc:CatalogueIndicator element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Item/cbc:Description">
			<sch:assert test="string-length(text()) > 0 ">  /doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Item/cbc:Description element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Item/cbc:CatalogueIndicator">
			<sch:assert test="string-length(text()) > 0 ">  /doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Item/cbc:CatalogueIndicator element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation_RequestForQuotationLine_LineItem_Item_TransactionConditions">
		<sch:rule context="/doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Item/cac:TransactionConditions">
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Item/cac:TransactionConditions/cbc:Description">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation_Contract">
		<sch:rule context="/doc:RequestForQuotation/cac:Contract/cbc:ID">
			<sch:assert test="string-length(text()) > 0 ">  /doc:RequestForQuotation/cac:Contract/cbc:ID element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/cac:Contract">
			<sch:assert test="exists(cbc:ID) ">  /doc:RequestForQuotation/cac:Contract/cbc:ID element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation_RequestForQuotationLine_LineItem_Item_ItemSpecificationDocumentReference">
		<sch:rule context="/doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Item/cac:ItemSpecificationDocumentReference">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation_RequestForQuotationLine_LineItem_Item_ItemSpecificationDocumentReference_Attachment">
		<sch:rule context="/doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject">
			<sch:assert test="string-length(@mimeCode) > 0 ">  /doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode element should exist!</sch:assert>
			<sch:assert test="exists(@mimeCode)">  /doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode element should exist!</sch:assert>
			<sch:assert test="string-length(text()) > 0 ">  /doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment">
			<sch:assert test="exists(cbc:EmbeddedDocumentBinaryObject) ">  /doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation_OriginatorCustomerParty_Party_PhysicalLocation">
		<sch:rule context="/doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:PhysicalLocation">
			<sch:assert test="exists(cac:Address) ">  /doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation_OriginatorCustomerParty_Party_PhysicalLocation_Address">
		<sch:rule context="/doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address">
			<sch:assert test="exists(cac:Country) ">  /doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation_OriginatorCustomerParty_Party_PhysicalLocation_Address_Country">
		<sch:rule context="/doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode">
			<sch:assert test="string-length(text()) > 0 ">  /doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country">
			<sch:assert test="exists(cbc:IdentificationCode) ">  /doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation_RequestForQuotationLine_LineItem_Delivery_DeliveryAddress">
		<sch:rule context="/doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress">
			<sch:assert test="exists(cac:Country) ">  /doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation_RequestForQuotationLine_LineItem_Delivery_DeliveryAddress_Country">
		<sch:rule context="/doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode">
			<sch:assert test="string-length(text()) > 0 ">  /doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country">
			<sch:assert test="exists(cbc:IdentificationCode) ">  /doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation_RequestForQuotationLine_LineItem_Delivery_DeliveryParty">
		<sch:rule context="/doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:DeliveryParty">
			<sch:assert test="exists(cac:PartyName) ">  /doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:PartyName element should exist!</sch:assert>
			<sch:assert test="count(cac:PartyName) lt 2 ">  /doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:PartyName element should be less than 2!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact">
			<sch:assert test="matches(cbc:Telephone, '^[-0-9]*$')">  Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</sch:assert>
			<sch:assert test="matches(cbc:Telefax, '^[-0-9]*$')">  Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation_OriginatorCustomerParty_Party_AgentParty_Contact">
		<sch:rule context="/doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:AgentParty/cac:Contact/cbc:Name">
			<sch:assert test="string-length(text()) > 0 ">  /doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:AgentParty/cac:Contact/cbc:Name element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:AgentParty/cac:Contact">
			<sch:assert test="exists(cbc:Name) ">  /doc:RequestForQuotation/cac:OriginatorCustomerParty/cac:Party/cac:AgentParty/cac:Contact/cbc:Name element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation_RequestForQuotationLine_LineItem_Delivery_DeliveryParty_Contact">
		<sch:rule context="/doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact/cbc:Name">
			<sch:assert test="string-length(text()) > 0 ">  /doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact/cbc:Name element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact">
			<sch:assert test="exists(cbc:Name) ">  /doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact/cbc:Name element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation_RequestForQuotationLine_LineItem_Delivery_RequestedDeliveryPeriod">
		<sch:rule context="/doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:RequestedDeliveryPeriod">
			<sch:assert test="exists(cbc:EndDate) ">  /doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:RequestedDeliveryPeriod/cbc:EndDate element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:RequestedDeliveryPeriod/cbc:EndDate">
			<sch:assert test="string-length(text()) > 0 ">  /doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:Delivery/cac:RequestedDeliveryPeriod/cbc:EndDate element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation_DeliveryTerms">
		<sch:rule context="/doc:RequestForQuotation/cac:DeliveryTerms/cbc:ID">
			<sch:assert test="string-length(text()) > 0 ">  /doc:RequestForQuotation/cac:DeliveryTerms/cbc:ID element should exist!</sch:assert>
			<sch:assert test="normalize-space (@schemeID ) = 'NL-1002' ">  Inhoud MOET verwijzen naar: NL-1002</sch:assert>
			<sch:assert test="normalize-space (@schemeAgencyID) = xs:string(88)">  Inhoud MOET verwijzen naar: 88</sch:assert>
			<sch:assert test="normalize-space (@schemeAgencyName)  = 'Logius Gegevensbeheer NL-Overheid'">  Inhoud MOET verwijzen naar: Logius Gegevensbeheer NL-Overheid</sch:assert>
			<sch:assert test="normalize-space (@schemeDataURI)  = 'urn:digi-inkoop:ubl:2.0:NL:1.6:gc:DeliveryTermsCode'">  Inhoud MOET verwijzen naar: urn:digi-inkoop:ubl:2.0:NL:1.6:gc:DeliveryTermsCode</sch:assert>
			<sch:assert test="normalize-space(@schemeURI ) = 'http://www.nltaxonomie.nl/ubl/2.0/NL/1.6/cl/gc/DeliveryTermsCode.gc' ">  Inhoud MOET verwijzen naar: http://www.nltaxonomie.nl/ubl/2.0/NL/1.6/cl/gc/DeliveryTermsCode.gc</sch:assert>
			<sch:assert test="normalize-space (@schemeName) = 'DeliveryTermsCode'">  Inhoud MOET verwijzen naar: DeliveryTermsCode</sch:assert>
			<sch:assert test="normalize-space (@schemeVersionID) = xs:string(1.6)">  Inhoud MOET verwijzen naar: 1.6</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/cac:DeliveryTerms">
			<sch:assert test="exists(cbc:ID) ">  /doc:RequestForQuotation/cac:DeliveryTerms/cbc:ID element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation_RequestForQuotationLine_DocumentReference_Attachment">
		<sch:rule context="/doc:RequestForQuotation/cac:RequestForQuotationLine/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject">
			<sch:assert test="string-length(text()) > 0 ">  /doc:RequestForQuotation/cac:RequestForQuotationLine/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/cac:RequestForQuotationLine/cac:DocumentReference/cac:Attachment">
			<sch:assert test="exists(cbc:EmbeddedDocumentBinaryObject) ">  /doc:RequestForQuotation/cac:RequestForQuotationLine/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation_RequestForQuotationLine_LineItem_DeliveryTerms">
		<sch:rule context="/doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:DeliveryTerms/cbc:ID">
			<sch:assert test="string-length(text()) > 0 ">  /doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:DeliveryTerms/cbc:ID element should exist!</sch:assert>
			<sch:assert test="normalize-space (@schemeID ) = 'NL-1002' ">  Inhoud MOET verwijzen naar: NL-1002</sch:assert>
			<sch:assert test="normalize-space (@schemeAgencyID) = xs:string(88)">  Inhoud MOET verwijzen naar: 88</sch:assert>
			<sch:assert test="normalize-space (@schemeAgencyName)  = 'Logius Gegevensbeheer NL-Overheid'">  Inhoud MOET verwijzen naar: Logius Gegevensbeheer NL-Overheid</sch:assert>
			<sch:assert test="normalize-space (@schemeDataURI)  = 'urn:digi-inkoop:ubl:2.0:NL:1.6:gc:DeliveryTermsCode'">  Inhoud MOET verwijzen naar: urn:digi-inkoop:ubl:2.0:NL:1.6:gc:DeliveryTermsCode</sch:assert>
			<sch:assert test="normalize-space(@schemeURI ) = 'http://www.nltaxonomie.nl/ubl/2.0/NL/1.6/cl/gc/DeliveryTermsCode.gc' ">  Inhoud MOET verwijzen naar: http://www.nltaxonomie.nl/ubl/2.0/NL/1.6/cl/gc/DeliveryTermsCode.gc</sch:assert>
			<sch:assert test="normalize-space (@schemeName) = 'DeliveryTermsCode' ">  Inhoud MOET verwijzen naar: DeliveryTermsCode</sch:assert>
			<sch:assert test="normalize-space (@schemeVersionID) = xs:string(1.6)">  Inhoud MOET verwijzen naar: 1.6</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:DeliveryTerms">
			<sch:assert test="exists(cbc:ID) ">  /doc:RequestForQuotation/cac:RequestForQuotationLine/cac:LineItem/cac:DeliveryTerms/cbc:ID element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="RequestForQuotation_SellerSupplierParty_Party_PartyIdentification">
		<sch:rule context="/doc:RequestForQuotation/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID">
			<sch:assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">  Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</sch:assert>
			<sch:assert test="(@schemeAgencyName  = 'KvK') or (@schemeAgencyName  = 'BTW') or (@schemeAgencyName = 'Fi') or (@schemeAgencyName  = 'BSN') or (@schemeAgencyName  = 'OIN') or (@schemeAgencyName  = 'XXX')">  Uitgevende organisatie van de PartijIdentificatie MOET ge?dentificeerd worden door een code uit de lijst: KvK, BTW, Fi, BSN, OIN, XXX.</sch:assert>
		</sch:rule>
	</sch:pattern>
</sch:schema>