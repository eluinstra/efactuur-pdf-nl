<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns="http://purl.oclc.org/dsdl/schematron"
	xmlns:sch="http://purl.oclc.org/dsdl/schematron"
	xmlns:qdt="urn:oasis:names:specification:ubl:schema:xsd:QualifiedDataTypes-2"
	xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
	xmlns:doc="urn:oasis:names:specification:ubl:schema:xsd:OrderResponse-2"
	xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
	xmlns:ccts="urn:oasis:names:specification:ubl:schema:xsd:CoreComponentParameters-2"
	queryBinding="xslt2"
	schemaVersion="ISO19757-3"
>
<sch:ns prefix="qdt" uri="urn:oasis:names:specification:ubl:schema:xsd:QualifiedDataTypes-2" />
<sch:ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" />
<sch:ns prefix="doc" uri="urn:oasis:names:specification:ubl:schema:xsd:OrderResponse-2" />
<sch:ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" />
<sch:ns prefix="ccts" uri="urn:oasis:names:specification:ubl:schema:xsd:CoreComponentParameters-2" />
	<sch:pattern id="OrderResponse">
		<sch:rule context="/doc:OrderResponse/cbc:UBLVersionID">
			<sch:assert test="normalize-space(text()) = '2.0'">  Bericht MOET gebaseerd zijn op UBL Versie 2.0</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cbc:CustomizationID">
			<sch:assert test="normalize-space(text()) = '1.6'">  Bericht MOET gebaseerd zijn op versie 1.6 van de Nederlandse specificatie.</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cbc:ProfileID">
			<sch:assert test="normalize-space(text()) = 'NL'">  Bericht MOET gebaseerd zijn op de Nederlandse (NL) specificatie.</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse">
			<sch:assert test="count(cbc:Note) lt 2 ">  /doc:OrderResponse/cbc:Note element should be less than 2!</sch:assert>
			<sch:assert test="count(cac:Delivery) lt 2 ">  /doc:OrderResponse/cac:Delivery element should be less than 2!</sch:assert>
			<sch:assert test="count(cac:TaxTotal) lt 2 ">  /doc:OrderResponse/cac:TaxTotal element should be less than 2!</sch:assert>
			<sch:assert test="count(cac:OrderReference) lt 2 ">  /doc:OrderResponse/cac:OrderReference element should be less than 2!</sch:assert>
			<sch:assert test="( (count(cac:Delivery/cac:DeliveryAddress) = 0) and (count(cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress) = count(cac:OrderLine/cac:LineItem)))or( (count(cac:Delivery/cac:DeliveryAddress) > 0) and (count(cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress) = 0))">  Afleveradres MOET OF op algemeen niveau OF voor alle regels worden opgegeven.</sch:assert>
			<sch:assert test="( (count(cbc:AccountingCostCode) = 0) and (count(cac:OrderLine/cac:LineItem/cbc:AccountingCostCode) = count(cac:OrderLine/cac:LineItem)))or( (count(cbc:AccountingCostCode) > 0) and (count(cac:OrderLine/cac:LineItem/cbc:AccountingCostCode) = 0))">  Kostenplaats MOET OF op algemeen niveau OF voor alle regels worden opgegeven.</sch:assert>
			<sch:assert test="not(empty(cbc:ID))">  /doc:OrderResponse/cbc:ID element should not be empty!</sch:assert>
			<sch:assert test="exists(cbc:UBLVersionID) ">  /doc:OrderResponse/cbc:UBLVersionID element should exist!</sch:assert>
			<sch:assert test="exists(cbc:CustomizationID) ">  /doc:OrderResponse/cbc:CustomizationID element should exist!</sch:assert>
			<sch:assert test="exists(cbc:ProfileID) ">  /doc:OrderResponse/cbc:ProfileID element should exist!</sch:assert>
			<sch:assert test="every $bn in //cbc:BuildingNumber satisfies (matches($bn,'^\d+(-[ \w]+)?$'))">  Huisnummer en Huisnummertoevoeging moeten achter elkaar geplaatst worden, gescheiden met een koppelteken.</sch:assert>
			<sch:assert test="( (count(cac:Delivery/cac:PromisedDeliveryPeriod) = 0) and (count(cac:OrderLine/cac:LineItem/cac:Delivery/cac:PromisedDeliveryPeriod) = count(cac:OrderLine/cac:LineItem)))or( (count(cac:Delivery/cac:PromisedDeliveryPeriod) > 0) and (count(cac:OrderLine/cac:LineItem/cac:Delivery/cac:PromisedDeliveryPeriod) = 0))">  Levertijd MOET OF op algemeen niveau OF voor alle regels worden opgegeven.</sch:assert>
			<sch:assert test="(count(cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact) = count(cac:OrderLine/cac:LineItem))or(count(cac:SellerSupplierParty/cac:Party/cac:Contact) > 0)">  Leverancier contactpersoon MOET voor alle regels worden opgegeven ALS NIET op algemeen niveau opgegeven.</sch:assert>
			<sch:assert test="every $id in //cac:PartyIdentification/cbc:ID satisfies (exists($id/@schemeAgencyID) and not(empty($id/@schemeAgencyID)) and exists($id/@schemeAgencyName) and not(empty($id/@schemeAgencyName)))">  PartyIdentification/ID MOET @schemeAgencyID en @schemeAgencyName attributen bevatten.</sch:assert>
			<sch:assert test="count(cac:Contract) lt 2 ">  /doc:OrderResponse/cac:Contract element should be less than 2!</sch:assert>
			<sch:assert test="every $pa in //cac:PostalAddress satisfies ((not(empty($pa/cbc:Postbox)) and empty($pa/cbc:StreetName) and empty($pa/cbc:BuildingNumber) and empty(cbc:Room) and empty(cbc:Floor) and empty(cbc:Department) and empty(cbc:InhouseMail) and empty(cbc:PlotIdentification)) or (empty($pa/cbc:Postbox) and (not(empty($pa/cbc:StreetName)) or not(empty($pa/cbc:BuildingNumber)) or not(empty(cbc:Room)) or not(empty(cbc:Floor)) or not(empty(cbc:Department)) or not(empty(cbc:InhouseMail)) or not(empty(cbc:PlotIdentification)))))">  PostalAddress MOET OF een Postbox bevatten OF minimaal 1 van de elementen StreetName, BuildingNumber, Room, Floor, Department, InhouseMail of PlotIdentification. Beide MAG NIET.</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:OrderReference">
			<sch:assert test="not(empty(cbc:ID))">  /doc:OrderResponse/cac:OrderReference/cbc:ID element should not be empty!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cbc:ID">
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cbc:Note">
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cbc:DocumentCurrencyCode">
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cbc:AccountingCostCode">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_Contract">
		<sch:rule context="/doc:OrderResponse/cac:Contract/cbc:ID">
			<sch:assert test="string-length(text()) > 0 ">  /doc:OrderResponse/cac:Contract/cbc:ID element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:Contract">
			<sch:assert test="exists(cbc:ID) ">  /doc:OrderResponse/cac:Contract/cbc:ID element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_SellerSupplierParty">
		<sch:rule context="/doc:OrderResponse/cac:SellerSupplierParty/cbc:CustomerAssignedAccountID">
			<sch:assert test="string-length(text()) > 0 ">  /doc:OrderResponse/cac:SellerSupplierParty/cbc:CustomerAssignedAccountID element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:SellerSupplierParty">
			<sch:assert test="exists(cac:Party) ">  /doc:OrderResponse/cac:SellerSupplierParty/cac:Party element should exist!</sch:assert>
			<sch:assert test="exists(cbc:CustomerAssignedAccountID) ">  /doc:OrderResponse/cac:SellerSupplierParty/cbc:CustomerAssignedAccountID element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_SellerSupplierParty_Party">
		<sch:rule context="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party">
			<sch:assert test="count(cac:PartyName) lt 2 ">  /doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PartyName element should be less than 2!</sch:assert>
			<sch:assert test="exists(cac:PartyName) ">  /doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PartyName element should exist!</sch:assert>
			<sch:assert test="exists(cac:PartyIdentification) ">  /doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification element should exist!</sch:assert>
			<sch:assert test="count(cac:PartyIdentification) lt 3 ">  /doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification element should be less than 3!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification">
			<sch:assert test="not(empty(cbc:ID))">  /doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID element should not be empty!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PartyName">
			<sch:assert test="not(empty(cbc:Name))">  /doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PartyName/cbc:Name element should not be empty!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:Contact">
			<sch:assert test="matches(cbc:Telephone, '^[-0-9]*$')">  Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</sch:assert>
			<sch:assert test="matches(cbc:Telefax, '^[-0-9]*$')">  Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_SellerSupplierParty_Party_PartyIdentification">
		<sch:rule context="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID">
			<sch:assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">  Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</sch:assert>
			<sch:assert test="(@schemeAgencyName  = 'KvK') or (@schemeAgencyName  = 'BTW') or (@schemeAgencyName = 'Fi') or (@schemeAgencyName  = 'BSN') or (@schemeAgencyName  = 'OIN') or (@schemeAgencyName  = 'XXX')">  Uitgevende organisatie van de PartijIdentificatie MOET ge?dentificeerd worden door een code uit de lijst: KvK, BTW, Fi, BSN, OIN, XXX.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_SellerSupplierParty_Party_PostalAddress">
		<sch:rule context="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PostalAddress">
			<sch:assert test="exists(cac:Country) ">  /doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_SellerSupplierParty_Party_PostalAddress_Country">
		<sch:rule context="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode">
			<sch:assert test="string-length(text()) > 0 ">  /doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country">
			<sch:assert test="exists(cbc:IdentificationCode) ">  /doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_BuyerCustomerParty">
		<sch:rule context="/doc:OrderResponse/cac:BuyerCustomerParty">
			<sch:assert test="exists(cac:Party) ">  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_BuyerCustomerParty_Party">
		<sch:rule context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party">
			<sch:assert test="count(cac:PartyName) lt 2 ">  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PartyName element should be less than 2!</sch:assert>
			<sch:assert test="exists(cac:PartyName) ">  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PartyName element should exist!</sch:assert>
			<sch:assert test="exists(cac:Contact) ">  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:Contact element should exist!</sch:assert>
			<sch:assert test="exists(cac:PartyIdentification) ">  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification element should exist!</sch:assert>
			<sch:assert test="count(cac:PartyIdentification) lt 3 ">  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification element should be less than 3!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PartyName">
			<sch:assert test="not(empty(cbc:Name))">  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PartyName/cbc:Name element should not be empty!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification">
			<sch:assert test="not(empty(cbc:ID))">  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID element should not be empty!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:Contact">
			<sch:assert test="matches(cbc:Telephone, '^[-0-9]*$')">  Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</sch:assert>
			<sch:assert test="matches(cbc:Telefax, '^[-0-9]*$')">  Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_BuyerCustomerParty_Party_PartyIdentification">
		<sch:rule context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID">
			<sch:assert test="(@schemeAgencyName  = 'KvK') or (@schemeAgencyName  = 'BTW') or (@schemeAgencyName = 'Fi') or (@schemeAgencyName  = 'BSN') or (@schemeAgencyName  = 'OIN') or (@schemeAgencyName  = 'XXX')">  Uitgevende organisatie van de PartijIdentificatie MOET ge?dentificeerd worden door een code uit de lijst: KvK, BTW, Fi, BSN, OIN, XXX.</sch:assert>
			<sch:assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">  Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_BuyerCustomerParty_Party_PostalAddress">
		<sch:rule context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_BuyerCustomerParty_Party_PostalAddress_Country">
		<sch:rule context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode">
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_AccountingSupplierParty_Party">
		<sch:rule context="/doc:OrderResponse/cac:AccountingSupplierParty/cac:Party">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_AccountingSupplierParty_Party_PartyIdentification">
		<sch:rule context="/doc:OrderResponse/cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_AccountingSupplierParty_Party_PostalAddress">
		<sch:rule context="/doc:OrderResponse/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_AccountingSupplierParty_Party_PostalAddress_Country">
		<sch:rule context="/doc:OrderResponse/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode">
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_AccountingCustomerParty_Party">
		<sch:rule context="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party">
			<sch:assert test="count(cac:PartyName) lt 2 ">  /doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PartyName element should be less than 2!</sch:assert>
			<sch:assert test="exists(cac:PartyIdentification) ">  /doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification element should exist!</sch:assert>
			<sch:assert test="count(cac:PartyIdentification) lt 3 ">  /doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification element should be less than 3!</sch:assert>
			<sch:assert test="exists(cac:PartyName) ">  /doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PartyName element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_AccountingCustomerParty_Party_PartyIdentification">
		<sch:rule context="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID">
			<sch:assert test="(@schemeAgencyName  = 'KvK') or (@schemeAgencyName  = 'BTW') or (@schemeAgencyName = 'Fi') or (@schemeAgencyName  = 'BSN') or (@schemeAgencyName  = 'OIN') or (@schemeAgencyName  = 'XXX')">  Uitgevende organisatie van de PartijIdentificatie MOET ge?dentificeerd worden door een code uit de lijst: KvK, BTW, Fi, BSN, OIN, XXX.</sch:assert>
			<sch:assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">  Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_AccountingCustomerParty_Party_PostalAddress">
		<sch:rule context="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress">
			<sch:assert test="exists(cac:Country) ">  /doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:PostalZone">
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:CityName">
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:PlotIdentification">
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:Department">
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:InhouseMail">
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:BuildingNumber">
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:StreetName">
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:Room">
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:Floor">
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:Postbox">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_AccountingCustomerParty_Party_PostalAddress_Country">
		<sch:rule context="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode">
			<sch:assert test="string-length(text()) > 0 ">  /doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country">
			<sch:assert test="exists(cbc:IdentificationCode) ">  /doc:OrderResponse/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_Delivery_DeliveryAddress">
		<sch:rule context="/doc:OrderResponse/cac:Delivery/cac:DeliveryAddress">
			<sch:assert test="exists(cac:Country) ">  /doc:OrderResponse/cac:Delivery/cac:DeliveryAddress/cac:Country element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_Delivery_DeliveryAddress_Country">
		<sch:rule context="/doc:OrderResponse/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode">
			<sch:assert test="string-length(text()) > 0 ">  /doc:OrderResponse/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:Delivery/cac:DeliveryAddress/cac:Country">
			<sch:assert test="exists(cbc:IdentificationCode) ">  /doc:OrderResponse/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_Delivery_RequestedDeliveryPeriod">
		<sch:rule context="/doc:OrderResponse/cac:Delivery/cac:RequestedDeliveryPeriod">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_Delivery_DeliveryParty">
		<sch:rule context="/doc:OrderResponse/cac:Delivery/cac:DeliveryParty">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:DocumentReference">
			<sch:assert test="exists(cbc:DocumentType) and not(empty(cbc:DocumentType))">  DocumentType MOET gevuld worden met de soort identificatie van het document: 'Bestelling' of 'Contract' of 'Specificatie' in geval er een bijlage meegezonden wordt.</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:LineItem">
			<sch:assert test="not(empty(cbc:ID))">  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cbc:ID element should not be empty!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_LineItem">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:LineItem">
			<sch:assert test="exists(cac:Price) ">  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Price element should exist!</sch:assert>
			<sch:assert test="exists(cbc:Quantity) ">  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cbc:Quantity element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cbc:Quantity">
			<sch:assert test="string-length(@unitCode) > 0 ">  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cbc:Quantity/@unitCode element should exist!</sch:assert>
			<sch:assert test="exists(@unitCode)">  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cbc:Quantity/@unitCode element should exist!</sch:assert>
			<sch:assert test="string-length(text()) > 0 ">  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cbc:Quantity element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item">
			<sch:assert test="( (count(cbc:Description) = 0) and (   (count(cac:BuyersItemIdentification/cbc:ID) + count(cac:SellersItemIdentification/cbc:ID) + count(cac:ManufacturersItemIdentification/cbc:ID) + count(cac:StandardItemIdentification/cbc:ID) + count(cac:CatalogueItemIdentification/cbc:ID)) > 0 ))or( (count(cbc:Description) > 0) and (   (count(cac:BuyersItemIdentification/cbc:ID) + count(cac:SellersItemIdentification/cbc:ID) + count(cac:ManufacturersItemIdentification/cbc:ID) + count(cac:StandardItemIdentification/cbc:ID) + count(cac:CatalogueItemIdentification/cbc:ID)) = 0 ))">  Item MOET OF een Description OF een (party)Identification/ID bevatten.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_LineItem_Delivery_DeliveryAddress">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress">
			<sch:assert test="exists(cac:Country) ">  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_LineItem_Delivery_DeliveryAddress_Country">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode">
			<sch:assert test="string-length(text()) > 0 ">  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country">
			<sch:assert test="exists(cbc:IdentificationCode) ">  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_LineItem_Delivery_RequestedDeliveryPeriod">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:RequestedDeliveryPeriod">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_LineItem_Delivery_EstimatedDeliveryPeriod">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:EstimatedDeliveryPeriod">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_LineItem_Delivery_DeliveryParty">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty">
			<sch:assert test="count(cac:PartyName) lt 2 ">  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:PartyName element should be less than 2!</sch:assert>
			<sch:assert test="exists(cac:PartyName) ">  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:PartyName element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact">
			<sch:assert test="matches(cbc:Telephone, '^[-0-9]*$')">  Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</sch:assert>
			<sch:assert test="matches(cbc:Telefax, '^[-0-9]*$')">  Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_LineItem_Item">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item">
			<sch:assert test="count(cbc:Description) lt 2 ">  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cbc:Description element should be less than 2!</sch:assert>
			<sch:assert test="exists(cbc:Description) ">  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cbc:Description element should exist!</sch:assert>
			<sch:assert test="exists(cbc:CatalogueIndicator) ">  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cbc:CatalogueIndicator element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cbc:Description">
			<sch:assert test="string-length(text()) > 0 ">  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cbc:Description element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cbc:CatalogueIndicator">
			<sch:assert test="string-length(text()) > 0 ">  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cbc:CatalogueIndicator element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_LineItem_Item_TransactionConditions">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:TransactionConditions">
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:TransactionConditions/cbc:Description">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_SellerSubstitutedLineItem">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:SellerSubstitutedLineItem">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_SellerSubstitutedLineItem_Item">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:SellerSubstitutedLineItem/cac:Item">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_SellerSubstitutedLineItem_Item_TransactionConditions">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:SellerSubstitutedLineItem/cac:Item/cac:TransactionConditions">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_SellerSubstitutedLineItem_Delivery_DeliveryAddress">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:SellerSubstitutedLineItem/cac:Delivery/cac:DeliveryAddress">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_SellerSubstitutedLineItem_Delivery_DeliveryAddress_Country">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:SellerSubstitutedLineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode">
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:SellerSubstitutedLineItem/cac:Delivery/cac:DeliveryAddress/cac:Country">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_SellerSubstitutedLineItem_Delivery_RequestedDeliveryPeriod">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:SellerSubstitutedLineItem/cac:Delivery/cac:RequestedDeliveryPeriod">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_SellerSubstitutedLineItem_Delivery_DeliveryParty">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:SellerSubstitutedLineItem/cac:Delivery/cac:DeliveryParty">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_LineItem_Item_ClassifiedTaxCategory_TaxScheme">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme/cbc:Name">
			<sch:assert test="string-length(text()) > 0 ">  Belastingsoort MOET opgegeven worden, veelal 'BTW'.</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme">
			<sch:assert test="exists(cbc:Name) ">  Belastingsoort MOET opgegeven worden, veelal 'BTW'.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_SellerSubstitutedLineItem_Item_ClassifiedTaxCategory_TaxScheme">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:SellerSubstitutedLineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme/cbc:Name">
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:SellerSubstitutedLineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_PaymentMeans_PayeeFinancialAccount">
		<sch:rule context="/doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:ID">
			<sch:assert test="string-length(text()) > 0 ">  /doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:ID element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount">
			<sch:assert test="exists(cbc:ID) ">  /doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:ID element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_PaymentMeans_PayeeFinancialAccount_Country">
		<sch:rule context="/doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode">
			<sch:assert test="string-length(text()) > 0 ">  /doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country">
			<sch:assert test="exists(cbc:IdentificationCode) ">  /doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_PaymentMeans_PayeeFinancialAccount_FinancialInstitutionBranch">
		<sch:rule context="/doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch">
			<sch:assert test="exists(cac:FinancialInstitution) ">  /doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_PaymentMeans_PayeeFinancialAccount_FinancialInstitutionBranch_FinancialInstitution">
		<sch:rule context="/doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID">
			<sch:assert test="string-length(text()) > 0 ">  /doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution">
			<sch:assert test="exists(cbc:ID) ">  /doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_Delivery_EstimatedDeliveryPeriod">
		<sch:rule context="/doc:OrderResponse/cac:Delivery/cac:EstimatedDeliveryPeriod">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_SellerSubstitutedLineItem_Delivery_EstimatedDeliveryPeriod">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:SellerSubstitutedLineItem/cac:Delivery/cac:EstimatedDeliveryPeriod">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_SellerProposedSubstituteLineItem">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem">
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cbc:Quantity">
			<sch:assert test="string-length(@unitCode) > 0 ">  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cbc:Quantity/@unitCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Delivery_RequestedDeliveryPeriod">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:RequestedDeliveryPeriod">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Delivery_DeliveryAddress">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryAddress">
			<sch:assert test="exists(cac:Country) ">  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryAddress/cac:Country element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Delivery_DeliveryAddress_Country">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode">
			<sch:assert test="string-length(text()) > 0 ">  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryAddress/cac:Country">
			<sch:assert test="exists(cbc:IdentificationCode) ">  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Delivery_EstimatedDeliveryPeriod">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:EstimatedDeliveryPeriod">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Delivery_DeliveryParty">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryParty">
			<sch:assert test="exists(cac:PartyName) ">  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryParty/cac:PartyName element should exist!</sch:assert>
			<sch:assert test="count(cac:PartyName) lt 2 ">  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryParty/cac:PartyName element should be less than 2!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryParty/cac:Contact">
			<sch:assert test="matches(cbc:Telephone, '^[-0-9]*$')">  Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</sch:assert>
			<sch:assert test="matches(cbc:Telefax, '^[-0-9]*$')">  Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Item">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item">
			<sch:assert test="count(cbc:Description) lt 2 ">  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cbc:Description element should be less than 2!</sch:assert>
			<sch:assert test="exists(cbc:CatalogueIndicator) ">  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cbc:CatalogueIndicator element should exist!</sch:assert>
			<sch:assert test="exists(cbc:Description) ">  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cbc:Description element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cbc:CatalogueIndicator">
			<sch:assert test="string-length(text()) > 0 ">  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cbc:CatalogueIndicator element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cbc:Description">
			<sch:assert test="string-length(text()) > 0 ">  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cbc:Description element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Item_ClassifiedTaxCategory_TaxScheme">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme/cbc:Name">
			<sch:assert test="string-length(text()) > 0 ">  Belastingsoort MOET opgegeven worden, veelal 'BTW'.</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme">
			<sch:assert test="exists(cbc:Name) ">  Belastingsoort MOET opgegeven worden, veelal 'BTW'.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Item_TransactionConditions">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:TransactionConditions">
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:TransactionConditions/cbc:Description">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_FreightForwarderParty">
		<sch:rule context="/doc:OrderResponse/cac:FreightForwarderParty">
			<sch:assert test="count(cac:PartyName) lt 2 ">  /doc:OrderResponse/cac:FreightForwarderParty/cac:PartyName element should be less than 2!</sch:assert>
			<sch:assert test="count(cac:PartyIdentification) lt 3 ">  /doc:OrderResponse/cac:FreightForwarderParty/cac:PartyIdentification element should be less than 3!</sch:assert>
			<sch:assert test="exists(cac:PartyIdentification) ">  /doc:OrderResponse/cac:FreightForwarderParty/cac:PartyIdentification element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_Delivery_PromisedDeliveryPeriod">
		<sch:rule context="/doc:OrderResponse/cac:Delivery/cac:PromisedDeliveryPeriod">
			<sch:assert test="exists(cbc:EndDate) ">  /doc:OrderResponse/cac:Delivery/cac:PromisedDeliveryPeriod/cbc:EndDate element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:Delivery/cac:PromisedDeliveryPeriod/cbc:EndDate">
			<sch:assert test="string-length(text()) > 0 ">  /doc:OrderResponse/cac:Delivery/cac:PromisedDeliveryPeriod/cbc:EndDate element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_LineItem_Delivery_PromisedDeliveryPeriod">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:PromisedDeliveryPeriod">
			<sch:assert test="exists(cbc:EndDate) ">  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:PromisedDeliveryPeriod/cbc:EndDate element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:PromisedDeliveryPeriod/cbc:EndDate">
			<sch:assert test="string-length(text()) > 0 ">  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:PromisedDeliveryPeriod/cbc:EndDate element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_SellerSupplierParty_Party_AgentParty">
		<sch:rule context="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:AgentParty">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_SellerSupplierParty_Party_AgentParty_PostalAddress">
		<sch:rule context="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:AgentParty/cac:PostalAddress">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_SellerSupplierParty_Party_AgentParty_PostalAddress_Country">
		<sch:rule context="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode">
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_BuyerCustomerParty_Party_AgentParty">
		<sch:rule context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty">
			<sch:assert test="count(cac:PartyName) lt 2 ">  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PartyName element should be less than 2!</sch:assert>
			<sch:assert test="count(cac:PartyIdentification) lt 3 ">  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification element should be less than 3!</sch:assert>
			<sch:assert test="exists(cac:PartyIdentification) ">  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:Contact">
			<sch:assert test="matches(cbc:Telefax, '^[-0-9]*$')">  Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</sch:assert>
			<sch:assert test="matches(cbc:Telephone, '^[-0-9]*$')">  Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_BuyerCustomerParty_Party_AgentParty_PostalAddress">
		<sch:rule context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress">
			<sch:assert test="exists(cac:Country) ">  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_BuyerCustomerParty_Party_AgentParty_PostalAddress_Country">
		<sch:rule context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode">
			<sch:assert test="string-length(text()) > 0 ">  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country">
			<sch:assert test="exists(cbc:IdentificationCode) ">  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_Delivery_Despatch_DespatchAddress">
		<sch:rule context="/doc:OrderResponse/cac:Delivery/cac:Despatch/cac:DespatchAddress">
			<sch:assert test="exists(cac:Country) ">  /doc:OrderResponse/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_Delivery_Despatch_DespatchAddress_Country">
		<sch:rule context="/doc:OrderResponse/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country/cbc:IdentificationCode">
			<sch:assert test="string-length(text()) > 0 ">  /doc:OrderResponse/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country">
			<sch:assert test="exists(cbc:IdentificationCode) ">  /doc:OrderResponse/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_TaxTotal_TaxSubtotal_TaxCategory_TaxScheme">
		<sch:rule context="/doc:OrderResponse/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:Name">
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_LineItem_Price">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Price/cbc:PriceAmount">
			<sch:assert test="(count(../../../../cbc:PricingCurrencyCode) = 0)or( (count(../../../../cbc:PricingCurrencyCode) > 0) and (@currencyID = ../../../../cbc:PricingCurrencyCode/text()))">  Valutacode op regelniveau MOET gelijk zijn aan algemeen niveau als opgegeven.</sch:assert>
			<sch:assert test="not(empty(@currencyID))">  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Price/cbc:PriceAmount/@currencyID element should not be empty!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Price/cbc:BaseQuantity">
			<sch:assert test="string-length(@unitCode) > 0 ">  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Price/cbc:BaseQuantity/@unitCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_PaymentMeans">
		<sch:rule context="/doc:OrderResponse/cac:PaymentMeans/cbc:PaymentMeansCode">
			<sch:assert test="string-length(text()) > 0 ">  /doc:OrderResponse/cac:PaymentMeans/cbc:PaymentMeansCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_BuyerCustomerParty_Party_AgentParty_PartyIdentification">
		<sch:rule context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification/cbc:ID">
			<sch:assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">  Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</sch:assert>
			<sch:assert test="(@schemeAgencyName  = 'KvK') or (@schemeAgencyName  = 'BTW') or (@schemeAgencyName = 'Fi') or (@schemeAgencyName  = 'BSN') or (@schemeAgencyName  = 'OIN') or (@schemeAgencyName  = 'XXX')">  Uitgevende organisatie van de PartijIdentificatie MOET ge?dentificeerd worden door een code uit de lijst: KvK, BTW, Fi, BSN, OIN, XXX.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_BuyerCustomerParty_Party_Contact">
		<sch:rule context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:Contact/cbc:Name">
			<sch:assert test="string-length(text()) > 0 ">  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:Contact/cbc:Name element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:Contact">
			<sch:assert test="exists(cbc:Name) ">  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:Contact/cbc:Name element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_BuyerCustomerParty_Party_PhysicalLocation">
		<sch:rule context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation">
			<sch:assert test="exists(cac:Address) ">  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_BuyerCustomerParty_Party_PhysicalLocation_Address">
		<sch:rule context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address">
			<sch:assert test="exists(cac:Country) ">  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_BuyerCustomerParty_Party_PhysicalLocation_Address_Country">
		<sch:rule context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode">
			<sch:assert test="string-length(text()) > 0 ">  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country">
			<sch:assert test="exists(cbc:IdentificationCode) ">  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_Delivery_Despatch">
		<sch:rule context="/doc:OrderResponse/cac:Delivery/cac:Despatch">
			<sch:assert test="exists(cac:DespatchAddress) ">  /doc:OrderResponse/cac:Delivery/cac:Despatch/cac:DespatchAddress element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_LegalMonetaryTotal">
		<sch:rule context="/doc:OrderResponse/cac:LegalMonetaryTotal/cbc:LineExtensionAmount">
			<sch:assert test="string-length(text()) > 0 ">  /doc:OrderResponse/cac:LegalMonetaryTotal/cbc:LineExtensionAmount element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:LegalMonetaryTotal">
			<sch:assert test="exists(cbc:LineExtensionAmount) ">  /doc:OrderResponse/cac:LegalMonetaryTotal/cbc:LineExtensionAmount element should exist!</sch:assert>
			<sch:assert test="exists(cbc:TaxExclusiveAmount) ">  /doc:OrderResponse/cac:LegalMonetaryTotal/cbc:TaxExclusiveAmount element should exist!</sch:assert>
			<sch:assert test="exists(cbc:TaxInclusiveAmount) ">  /doc:OrderResponse/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:LegalMonetaryTotal/cbc:TaxExclusiveAmount">
			<sch:assert test="string-length(text()) > 0 ">  /doc:OrderResponse/cac:LegalMonetaryTotal/cbc:TaxExclusiveAmount element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount">
			<sch:assert test="string-length(text()) > 0 ">  /doc:OrderResponse/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_LineItem_Delivery_DeliveryParty_Contact">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact/cbc:Name">
			<sch:assert test="string-length(text()) > 0 ">  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact/cbc:Name element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact">
			<sch:assert test="exists(cbc:Name) ">  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact/cbc:Name element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_PaymentMeans_PayeeFinancialAccount_FinancialInstitutionBranch_Address">
		<sch:rule context="/doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address">
			<sch:assert test="exists(cac:Country) ">  /doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_PaymentMeans_PayeeFinancialAccount_FinancialInstitutionBranch_Address_Country">
		<sch:rule context="/doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode">
			<sch:assert test="string-length(text()) > 0 ">  /doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country">
			<sch:assert test="exists(cbc:IdentificationCode) ">  /doc:OrderResponse/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_SellerSupplierParty_Party_Contact">
		<sch:rule context="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name">
			<sch:assert test="string-length(text()) > 0 ">  /doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:Contact">
			<sch:assert test="exists(cbc:Name) ">  /doc:OrderResponse/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_AccountingCustomerParty">
		<sch:rule context="/doc:OrderResponse/cac:AccountingCustomerParty">
			<sch:assert test="exists(cac:Party) ">  /doc:OrderResponse/cac:AccountingCustomerParty/cac:Party element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_BuyerCustomerParty_Party_AgentParty_Contact">
		<sch:rule context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:Contact/cbc:Name">
			<sch:assert test="string-length(text()) > 0 ">  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:Contact/cbc:Name element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:Contact">
			<sch:assert test="exists(cbc:Name) ">  /doc:OrderResponse/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:Contact/cbc:Name element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Delivery">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cbc:Quantity">
			<sch:assert test="string-length(@unitCode) > 0 ">  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cbc:Quantity/@unitCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cbc:ID">
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Price">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Price/cbc:BaseQuantity">
			<sch:assert test="string-length(@unitCode) > 0 ">  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Price/cbc:BaseQuantity/@unitCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Item_ItemSpecificationDocumentReference_Attachment">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment">
			<sch:assert test="exists(cbc:EmbeddedDocumentBinaryObject) ">  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject">
			<sch:assert test="string-length(text()) > 0 ">  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_DocumentReference">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:DocumentReference/cbc:DocumentType">
			<sch:assert test="string-length(text()) > 0 ">  /doc:OrderResponse/cac:OrderLine/cac:DocumentReference/cbc:DocumentType element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:DocumentReference">
			<sch:assert test="exists(cbc:DocumentType) ">  /doc:OrderResponse/cac:OrderLine/cac:DocumentReference/cbc:DocumentType element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_DocumentReference_Attachment">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject">
			<sch:assert test="string-length(text()) > 0 ">  /doc:OrderResponse/cac:OrderLine/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:DocumentReference/cac:Attachment">
			<sch:assert test="exists(cbc:EmbeddedDocumentBinaryObject) ">  /doc:OrderResponse/cac:OrderLine/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_LineItem_Delivery">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cbc:Quantity">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_LineItem_Delivery">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cbc:Quantity">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_LineItem_Delivery">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cbc:Quantity">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_LineItem_Delivery">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cbc:Quantity">
			<sch:assert test="string-length(@unitCode) > 0 ">  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Delivery/cbc:Quantity/@unitCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_LineItem_Item_ItemSpecificationDocumentReference_Attachment">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject">
			<sch:assert test="string-length(text()) > 0 ">  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment">
			<sch:assert test="exists(cbc:EmbeddedDocumentBinaryObject) ">  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_TaxTotal">
		<sch:rule context="/doc:OrderResponse/cac:TaxTotal">
			<sch:assert test="exists(cac:TaxSubtotal) ">  /doc:OrderResponse/cac:TaxTotal/cac:TaxSubtotal element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_TaxTotal">
		<sch:rule context="/doc:OrderResponse/cac:TaxTotal">
			<sch:assert test="exists(cac:TaxSubtotal) ">  /doc:OrderResponse/cac:TaxTotal/cac:TaxSubtotal element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_Delivery">
		<sch:rule context="/doc:OrderResponse/cac:Delivery/cbc:ID">
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:Delivery">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_FreightForwarderParty_PartyIdentification">
		<sch:rule context="/doc:OrderResponse/cac:FreightForwarderParty/cac:PartyIdentification/cbc:ID">
			<sch:assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">  Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_FreightForwarderParty_PartyIdentification">
		<sch:rule context="/doc:OrderResponse/cac:FreightForwarderParty/cac:PartyIdentification/cbc:ID">
			<sch:assert test="(@schemeAgencyName  = 'KvK') or (@schemeAgencyName  = 'BTW') or (@schemeAgencyName = 'Fi') or (@schemeAgencyName  = 'BSN') or (@schemeAgencyName  = 'OIN') or (@schemeAgencyName  = 'XXX')">  Uitgevende organisatie van de PartijIdentificatie MOET ge?dentificeerd worden door een code uit de lijst: KvK, BTW, Fi, BSN, OIN, XXX.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_FreightForwarderParty_PartyIdentification">
		<sch:rule context="/doc:OrderResponse/cac:FreightForwarderParty/cac:PartyIdentification/cbc:ID">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_LineItem_DeliveryTerms">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID">
			<sch:assert test="string-length(text()) > 0 ">  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID element should exist!</sch:assert>
			<sch:assert test="normalize-space (@schemeID ) = 'NL-1002' ">  Inhoud MOET verwijzen naar: NL-1002</sch:assert>
			<sch:assert test="normalize-space (@schemeAgencyID) = xs:string(88)">  Inhoud MOET verwijzen naar: 88</sch:assert>
			<sch:assert test="normalize-space (@schemeAgencyName)  = 'Logius Gegevensbeheer NL-Overheid'">  Inhoud MOET verwijzen naar: Logius Gegevensbeheer NL-Overheid</sch:assert>
			<sch:assert test="normalize-space (@schemeDataURI)  = 'urn:digi-inkoop:ubl:2.0:NL:1.6:gc:DeliveryTermsCode'">  Inhoud MOET verwijzen naar: urn:digi-inkoop:ubl:2.0:NL:1.6:gc:DeliveryTermsCode</sch:assert>
			<sch:assert test="normalize-space(@schemeURI ) = 'http://www.nltaxonomie.nl/ubl/2.0/NL/1.6/cl/gc/DeliveryTermsCode.gc' ">  Inhoud MOET verwijzen naar: http://www.nltaxonomie.nl/ubl/2.0/NL/1.6/cl/gc/DeliveryTermsCode.gc</sch:assert>
			<sch:assert test="normalize-space (@schemeName) = 'DeliveryTermsCode'">  Inhoud MOET verwijzen naar: DeliveryTermsCode</sch:assert>
			<sch:assert test="normalize-space (@schemeVersionID) = xs:string(1.6)">  Inhoud MOET verwijzen naar: 1.6</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms">
			<sch:assert test="exists(cbc:ID) ">  /doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Delivery_DeliveryParty_Contact">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryParty/cac:Contact/cbc:Name">
			<sch:assert test="string-length(text()) > 0 ">  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryParty/cac:Contact/cbc:Name element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryParty/cac:Contact">
			<sch:assert test="exists(cbc:Name) ">  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:DeliveryParty/cac:Contact/cbc:Name element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Delivery_PromisedDeliveryPeriod">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:PromisedDeliveryPeriod/cbc:EndDate">
			<sch:assert test="string-length(text()) > 0 ">  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:PromisedDeliveryPeriod/cbc:EndDate element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:PromisedDeliveryPeriod">
			<sch:assert test="exists(cbc:EndDate) ">  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Delivery/cac:PromisedDeliveryPeriod/cbc:EndDate element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_SellerProposedSubstituteLineItem_DeliveryTerms">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID">
			<sch:assert test="string-length(text()) > 0 ">  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID element should exist!</sch:assert>
			<sch:assert test="normalize-space (@schemeID ) = 'NL-1002' ">  Inhoud MOET verwijzen naar: NL-1002</sch:assert>
			<sch:assert test="normalize-space (@schemeAgencyID) = xs:string(88)">  Inhoud MOET verwijzen naar: 88</sch:assert>
			<sch:assert test="normalize-space (@schemeAgencyName)  = 'Logius Gegevensbeheer NL-Overheid'">  Inhoud MOET verwijzen naar: Logius Gegevensbeheer NL-Overheid</sch:assert>
			<sch:assert test="normalize-space (@schemeDataURI)  = 'urn:digi-inkoop:ubl:2.0:NL:1.6:gc:DeliveryTermsCode'">  Inhoud MOET verwijzen naar: urn:digi-inkoop:ubl:2.0:NL:1.6:gc:DeliveryTermsCode</sch:assert>
			<sch:assert test="normalize-space(@schemeURI ) = 'http://www.nltaxonomie.nl/ubl/2.0/NL/1.6/cl/gc/DeliveryTermsCode.gc'">  Inhoud MOET verwijzen naar: http://www.nltaxonomie.nl/ubl/2.0/NL/1.6/cl/gc/DeliveryTermsCode.gc</sch:assert>
			<sch:assert test="normalize-space (@schemeName) = 'DeliveryTermsCode' ">  Inhoud MOET verwijzen naar: DeliveryTermsCode</sch:assert>
			<sch:assert test="normalize-space (@schemeVersionID) = xs:string(1.6)">  Inhoud MOET verwijzen naar: 1.6</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms">
			<sch:assert test="exists(cbc:ID) ">  /doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:DeliveryTerms/cbc:ID element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_DeliveryTerms">
		<sch:rule context="/doc:OrderResponse/cac:DeliveryTerms/cbc:ID">
			<sch:assert test="string-length(text()) > 0 ">  /doc:OrderResponse/cac:DeliveryTerms/cbc:ID element should exist!</sch:assert>
			<sch:assert test="normalize-space (@schemeID ) = 'NL-1002' ">  Inhoud MOET verwijzen naar: NL-1002</sch:assert>
			<sch:assert test="normalize-space (@schemeAgencyID) = xs:string(88)">  Inhoud MOET verwijzen naar: 88</sch:assert>
			<sch:assert test="normalize-space (@schemeAgencyName)  = 'Logius Gegevensbeheer NL-Overheid'">  Inhoud MOET verwijzen naar: Logius Gegevensbeheer NL-Overheid</sch:assert>
			<sch:assert test="normalize-space (@schemeDataURI)  = 'urn:digi-inkoop:ubl:2.0:NL:1.6:gc:DeliveryTermsCode'">  Inhoud MOET verwijzen naar: urn:digi-inkoop:ubl:2.0:NL:1.6:gc:DeliveryTermsCode</sch:assert>
			<sch:assert test="normalize-space(@schemeURI ) = 'http://www.nltaxonomie.nl/ubl/2.0/NL/1.6/cl/gc/DeliveryTermsCode.gc'">  Inhoud MOET verwijzen naar: http://www.nltaxonomie.nl/ubl/2.0/NL/1.6/cl/gc/DeliveryTermsCode.gc</sch:assert>
			<sch:assert test="normalize-space (@schemeName) = 'DeliveryTermsCode'">  Inhoud MOET verwijzen naar: DeliveryTermsCode</sch:assert>
			<sch:assert test="normalize-space (@schemeVersionID) = xs:string(1.6)">  Inhoud MOET verwijzen naar: 1.6</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:OrderResponse/cac:DeliveryTerms">
			<sch:assert test="exists(cbc:ID) ">  /doc:OrderResponse/cac:DeliveryTerms/cbc:ID element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_LineItem_Item_ClassifiedTaxCategory">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:LineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme">
			<sch:assert test="(cbc:Name = 'BTW') or (cbc:Name = 'Accijns') or (cbc:Name = 'Toeslag') or (cbc:Name = 'Overige')">  De soort belasting/heffing MOET ge?dentificeerd worden met een code uit de lijst: BTW, Accijns, Toeslag, Overige.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_OrderLine_SellerProposedSubstituteLineItem_Item_ClassifiedTaxCategory">
		<sch:rule context="/doc:OrderResponse/cac:OrderLine/cac:SellerProposedSubstituteLineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme">
			<sch:assert test="(cbc:Name = 'BTW') or (cbc:Name = 'Accijns') or (cbc:Name = 'Toeslag') or (cbc:Name = 'Overige')">  De soort belasting/heffing MOET ge?dentificeerd worden met een code uit de lijst: BTW, Accijns, Toeslag, Overige.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="OrderResponse_TaxTotal_TaxSubtotal_TaxCategory">
		<sch:rule context="/doc:OrderResponse/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
			<sch:assert test="(cbc:Name = 'BTW') or (cbc:Name = 'Accijns') or (cbc:Name = 'Toeslag') or (cbc:Name = 'Overige')">  De soort belasting/heffing MOET ge?dentificeerd worden met een code uit de lijst: BTW, Accijns, Toeslag, Overige.</sch:assert>
		</sch:rule>
	</sch:pattern>
</sch:schema>