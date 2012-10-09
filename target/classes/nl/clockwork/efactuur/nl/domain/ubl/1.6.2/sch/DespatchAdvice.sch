<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns="http://purl.oclc.org/dsdl/schematron"
	xmlns:sch="http://purl.oclc.org/dsdl/schematron"
	xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
	xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
	xmlns:qdt="urn:oasis:names:specification:ubl:schema:xsd:QualifiedDataTypes-2"
	xmlns:ccts="urn:oasis:names:specification:ubl:schema:xsd:CoreComponentParameters-2"
	xmlns:doc="urn:oasis:names:specification:ubl:schema:xsd:DespatchAdvice-2"
	queryBinding="xslt2"
	schemaVersion="ISO19757-3"
>
<sch:ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" />
<sch:ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" />
<sch:ns prefix="qdt" uri="urn:oasis:names:specification:ubl:schema:xsd:QualifiedDataTypes-2" />
<sch:ns prefix="ccts" uri="urn:oasis:names:specification:ubl:schema:xsd:CoreComponentParameters-2" />
<sch:ns prefix="doc" uri="urn:oasis:names:specification:ubl:schema:xsd:DespatchAdvice-2" />
	<sch:pattern id="DespatchAdvice">
		<sch:rule context="/doc:DespatchAdvice/cbc:UBLVersionID">
			<sch:assert test="normalize-space(text()) = '2.0'">Het bericht MOET gebaseerd zijn op UBL Versie 2.0</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice">
			<sch:assert test="exists(cac:Shipment) ">/doc:DespatchAdvice/cac:Shipment element should exist!</sch:assert>
			<sch:assert test="not(empty(cbc:ID))">/doc:DespatchAdvice/cbc:ID element should not be empty!</sch:assert>
			<sch:assert test="exists(cac:SellerSupplierParty) ">/doc:DespatchAdvice/cac:SellerSupplierParty element should exist!</sch:assert>
			<sch:assert test="every $bn in //cbc:BuildingNumber satisfies (matches($bn,'^\d+(-[ \w]+)?$'))">Huisnummer en Huisnummertoevoeging moeten achter elkaar geplaatst worden, gescheiden met een koppelteken.</sch:assert>
			<sch:assert test="every $id in //cac:PartyIdentification/cbc:ID satisfies (exists($id/@schemeAgencyID) and not(empty($id/@schemeAgencyID)) and exists($id/@schemeAgencyName) and not(empty($id/@schemeAgencyName)))">PartyIdentification/ID MOET @schemeAgencyID en @schemeAgencyName attributen bevatten.</sch:assert>
			<sch:assert test="count(cbc:Note) lt 2 ">/doc:DespatchAdvice/cbc:Note element should be less than 2!</sch:assert>
			<sch:assert test="exists(cbc:UBLVersionID) ">/doc:DespatchAdvice/cbc:UBLVersionID element should exist!</sch:assert>
			<sch:assert test="exists(cbc:CustomizationID) ">/doc:DespatchAdvice/cbc:CustomizationID element should exist!</sch:assert>
			<sch:assert test="exists(cbc:ProfileID) ">/doc:DespatchAdvice/cbc:ProfileID element should exist!</sch:assert>
			<sch:assert test="every $pa in //cac:PostalAddress satisfies ((not(empty($pa/cbc:Postbox)) and empty($pa/cbc:StreetName) and empty($pa/cbc:BuildingNumber) and empty(cbc:Room) and empty(cbc:Floor) and empty(cbc:Department) and empty(cbc:InhouseMail) and empty(cbc:PlotIdentification)) or (empty($pa/cbc:Postbox) and (not(empty($pa/cbc:StreetName)) or not(empty($pa/cbc:BuildingNumber)) or not(empty(cbc:Room)) or not(empty(cbc:Floor)) or not(empty(cbc:Department)) or not(empty(cbc:InhouseMail)) or not(empty(cbc:PlotIdentification)))))">PostalAddress MOET OF een Postbox bevatten OF minimaal 1 van de elementen StreetName, BuildingNumber, Room, Floor, Department, InhouseMail of PlotIdentification. Beide MAG NIET.</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cbc:CustomizationID">
			<sch:assert test="normalize-space(text()) = '1.6'">Bericht MOET gebaseerd zijn op versie 1.6 van de Nederlandse specificatie.</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cbc:ProfileID">
			<sch:assert test="normalize-space(text()) = 'NL'">Bericht MOET gebaseerd zijn op de Nederlande (NL) specificatie</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:DeliveryCustomerParty">
			<sch:assert test="exists(cac:Party)">/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:DespatchSupplierParty">
			<sch:assert test="exists(cac:Party)">/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cbc:ID">
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cbc:Note">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="DespatchAdvice_Shipment">
		<sch:rule context="/doc:DespatchAdvice/cac:Shipment">
			<sch:assert test="exists(cac:Delivery) ">/doc:DespatchAdvice/cac:Shipment/cac:Delivery element should exist!</sch:assert>
			<sch:assert test="count(cbc:DeliveryInstructions) lt 2 ">/doc:DespatchAdvice/cac:Shipment/cbc:DeliveryInstructions element should be less than 2!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:Shipment/cbc:ID">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="DespatchAdvice_Shipment_Delivery">
		<sch:rule context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery">
			<sch:assert test="exists(cac:RequestedDeliveryPeriod) ">/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:RequestedDeliveryPeriod element should exist!</sch:assert>
			<sch:assert test="exists(cac:Despatch) ">/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch element should exist!</sch:assert>
			<sch:assert test="exists(cac:DeliveryAddress) ">/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cbc:TrackingID">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="DespatchAdvice_Shipment_Delivery_Despatch">
		<sch:rule context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch">
			<sch:assert test="exists(cac:DespatchAddress) ">/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="DespatchAdvice_Shipment_Delivery_Despatch_DespatchAddress">
		<sch:rule context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cbc:CountrySubentity">
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress">
			<sch:assert test="exists(cac:Country) ">/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cbc:PostalZone">
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cbc:CityName">
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cbc:PlotIdentification">
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cbc:Department">
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cbc:InhouseMail">
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cbc:BuildingNumber">
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cbc:StreetName">
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cbc:Room">
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cbc:Floor">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="DespatchAdvice_Shipment_Delivery_Despatch_DespatchAddress_Country">
		<sch:rule context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country/cbc:IdentificationCode">
			<sch:assert test="string-length(text()) > 0 ">/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country">
			<sch:assert test="exists(cbc:IdentificationCode) ">/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="DespatchAdvice_DespatchLine_Item">
		<sch:rule context="/doc:DespatchAdvice/cac:DespatchLine/cac:Item/cbc:Name">
			<sch:assert test="string-length(text()) > 0 ">/doc:DespatchAdvice/cac:DespatchLine/cac:Item/cbc:Name element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:DespatchLine/cac:Item">
			<sch:assert test="count(cbc:Description) lt 2 ">/doc:DespatchAdvice/cac:DespatchLine/cac:Item/cbc:Description element should be less than 2!</sch:assert>
			<sch:assert test="exists(cbc:Name) ">/doc:DespatchAdvice/cac:DespatchLine/cac:Item/cbc:Name element should exist!</sch:assert>
			<sch:assert test="exists(cbc:CatalogueIndicator) ">/doc:DespatchAdvice/cac:DespatchLine/cac:Item/cbc:CatalogueIndicator element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:DespatchLine/cac:Item/cbc:CatalogueIndicator">
			<sch:assert test="string-length(text()) > 0 ">/doc:DespatchAdvice/cac:DespatchLine/cac:Item/cbc:CatalogueIndicator element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:DespatchLine/cac:Item/cbc:Description">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="DespatchAdvice_DespatchLine">
		<sch:rule context="/doc:DespatchAdvice/cac:DespatchLine/cbc:DeliveredQuantity">
			<sch:assert test="string-length(@unitCode) > 0 ">/doc:DespatchAdvice/cac:DespatchLine/cbc:DeliveredQuantity/@unitCode element should exist!</sch:assert>
			<sch:assert test="string-length(text()) > 0 ">/doc:DespatchAdvice/cac:DespatchLine/cbc:DeliveredQuantity element should exist!</sch:assert>
			<sch:assert test="exists(@unitCode)">/doc:DespatchAdvice/cac:DespatchLine/cbc:DeliveredQuantity/@unitCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:DespatchLine/cac:Item">
			<sch:assert test="( (count(cbc:Description) = 0) and (   (count(cac:BuyersItemIdentification/cbc:ID) + count(cac:SellersItemIdentification/cbc:ID) + count(cac:ManufacturersItemIdentification/cbc:ID) + count(cac:StandardItemIdentification/cbc:ID) + count(cac:CatalogueItemIdentification/cbc:ID)) > 0 ))or( (count(cbc:Description) > 0) and (   (count(cac:BuyersItemIdentification/cbc:ID) + count(cac:SellersItemIdentification/cbc:ID) + count(cac:ManufacturersItemIdentification/cbc:ID) + count(cac:StandardItemIdentification/cbc:ID) + count(cac:CatalogueItemIdentification/cbc:ID)) = 0 ))">Item MOET OF een Description OF een (party)Identification/ID bevatten.</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:DespatchLine/cac:OrderLineReference">
			<sch:assert test="not(empty(cbc:LineID))">/doc:DespatchAdvice/cac:DespatchLine/cac:OrderLineReference/cbc:LineID element should not be empty!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:DespatchLine">
			<sch:assert test="exists(cbc:DeliveredQuantity) ">/doc:DespatchAdvice/cac:DespatchLine/cbc:DeliveredQuantity element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:DespatchLine/cbc:ID">
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:DespatchLine/cbc:BackorderReason">
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:DespatchLine/cbc:BackorderQuantity">
			<sch:assert test="string-length(@unitCode) > 0 ">/doc:DespatchAdvice/cac:DespatchLine/cbc:BackorderQuantity/@unitCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="DespatchAdvice_DespatchLine_OrderLineReference">
		<sch:rule context="/doc:DespatchAdvice/cac:DespatchLine/cac:OrderLineReference/cbc:LineID">
			<sch:assert test="string-length(text()) > 0 ">/doc:DespatchAdvice/cac:DespatchLine/cac:OrderLineReference/cbc:LineID element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:DespatchLine/cac:OrderLineReference">
			<sch:assert test="exists(cac:OrderReference) ">/doc:DespatchAdvice/cac:DespatchLine/cac:OrderLineReference/cac:OrderReference element should exist!</sch:assert>
			<sch:assert test="exists(cbc:LineID) ">/doc:DespatchAdvice/cac:DespatchLine/cac:OrderLineReference/cbc:LineID element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:DespatchLine/cac:OrderLineReference/cac:OrderReference">
			<sch:assert test="not(empty(cbc:ID))">/doc:DespatchAdvice/cac:DespatchLine/cac:OrderLineReference/cac:OrderReference/cbc:ID element should not be empty!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="DespatchAdvice_SellerSupplierParty_Party">
		<sch:rule context="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:PartyName">
			<sch:assert test="not(empty(cbc:Name))">/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:PartyName/cbc:Name element should not be empty!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification">
			<sch:assert test="not(empty(cbc:ID))">/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID element should not be empty!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party">
			<sch:assert test="exists(cac:PartyIdentification) ">/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification element should exist!</sch:assert>
			<sch:assert test="count(cac:PartyName) lt 2 ">/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:PartyName element should be less than 2!</sch:assert>
			<sch:assert test="count(cac:PartyIdentification) lt 3 ">/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification element should be less than 3!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:Contact">
			<sch:assert test="matches(cbc:Telefax, '^[-0-9]*$')">Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</sch:assert>
			<sch:assert test="matches(cbc:Telephone, '^[-0-9]*$')">Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="DespatchAdvice_DeliveryCustomerParty_Party">
		<sch:rule context="/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:PartyName">
			<sch:assert test="not(empty(cbc:Name))">/doc:DespatchAdvice/cac:DeliveryCustomerPartyy/cac:Party/cac:PartyName/cbc:Name element should not be empty!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party">
			<sch:assert test="exists(cac:PartyName) ">/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:PartyName element should exist!</sch:assert>
			<sch:assert test="count(cac:PartyName) lt 2 ">/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:PartyName element should be less than 2!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:Contact">
			<sch:assert test="matches(cbc:Telefax, '^[-0-9]*$')">Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</sch:assert>
			<sch:assert test="matches(cbc:Telephone, '^[-0-9]*$')">Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="DespatchAdvice_DespatchSupplierParty_Party">
		<sch:rule context="/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:PartyName">
			<sch:assert test="not(empty(cbc:Name))">/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:PartyName/cbc:Name element should not be empty!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party">
			<sch:assert test="exists(cac:PartyName) ">/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:PartyName element should exist!</sch:assert>
			<sch:assert test="count(cac:PartyName) lt 2 ">/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:PartyName element should be less than 2!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:Contact">
			<sch:assert test="matches(cbc:Telephone, '^[-0-9]*$')">Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</sch:assert>
			<sch:assert test="matches(cbc:Telefax, '^[-0-9]*$')">Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="DespatchAdvice_DeliveryCustomerParty_Party_Contact">
		<sch:rule context="/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:Contact/cbc:Name">
			<sch:assert test="string-length(text()) > 0 ">/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:Contact/cbc:Name element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:Contact">
			<sch:assert test="exists(cbc:Name) ">/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:Contact/cbc:Name element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:Contact/cbc:Telephone">
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:Contact/cbc:Telefax">
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:Contact/cbc:ElectronicMail">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="DespatchAdvice_SellerSupplierParty_Party_Contact">
		<sch:rule context="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name">
			<sch:assert test="string-length(text()) > 0 ">/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:Contact">
			<sch:assert test="exists(cbc:Name) ">/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:ElectronicMail">
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Telefax">
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Telephone">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="DespatchAdvice_DespatchSupplierParty_Party_Contact">
		<sch:rule context="/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:Contact/cbc:Name">
			<sch:assert test="string-length(text()) > 0 ">/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:Contact/cbc:Name element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:Contact">
			<sch:assert test="exists(cbc:Name) ">/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:Contact/cbc:Name element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:Contact/cbc:Telephone">
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:Contact/cbc:ElectronicMail">
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:Contact/cbc:Telefax">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="DespatchAdvice_DespatchSupplierParty_Party_PartyIdentification">
		<sch:rule context="/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="DespatchAdvice_DespatchSupplierParty_Party_PartyIdentification">
		<sch:rule context="/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="DespatchAdvice_AdditionalDocumentReference_Attachment">
		<sch:rule context="/doc:DespatchAdvice/cac:AdditionalDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject">
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:AdditionalDocumentReference/cac:Attachment">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="DespatchAdvice_DeliveryCustomerParty_Party_PartyIdentification">
		<sch:rule context="/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="DespatchAdvice_DeliveryCustomerParty_Party_PartyIdentification">
		<sch:rule context="/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="DespatchAdvice_Shipment_Delivery_DeliveryAddress_Country">
		<sch:rule context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode">
			<sch:assert test="string-length(text()) > 0 ">/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cac:Country">
			<sch:assert test="exists(cbc:IdentificationCode) ">/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="DespatchAdvice_DespatchSupplierParty">
		<sch:rule context="/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party">
			<sch:assert test="exists(cac:Contact)">/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:Contact element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:DespatchSupplierParty">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="DespatchAdvice_DeliveryCustomerParty">
		<sch:rule context="/doc:DespatchAdvice/cac:DeliveryCustomerParty">
			<sch:assert test="exists(cac:Party) ">/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:DeliveryCustomerParty/cbc:CustomerAssignedAccountID">
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party">
			<sch:assert test="exists(cac:Contact)">/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:Contact should exists!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="DespatchAdvice_DeliveryCustomerParty">
		<sch:rule context="/doc:DespatchAdvice/cac:DeliveryCustomerParty">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="DespatchAdvice_DeliveryCustomerParty">
		<sch:rule context="/doc:DespatchAdvice/cac:DeliveryCustomerParty">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="DespatchAdvice_SellerSupplierParty">
		<sch:rule context="/doc:DespatchAdvice/cac:SellerSupplierParty">
			<sch:assert test="exists(cac:Party) ">/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party">
			<sch:assert test="exists(cac:Contact)">/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:Contact element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:SellerSupplierParty/cbc:CustomerAssignedAccountID">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="DespatchAdvice_SellerSupplierParty_Party_PartyName">
		<sch:rule context="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:PartyName/cbc:Name">
			<sch:assert test="string-length(text()) > 0 ">/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:PartyName/cbc:Name element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:PartyName">
			<sch:assert test="exists(cbc:Name) ">/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:PartyName/cbc:Name element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="DespatchAdvice_Shipment_Delivery_DeliveryAddress">
		<sch:rule context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress">
			<sch:assert test="exists(cac:Country) ">/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cac:Country element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cbc:Floor">
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cbc:Room">
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cbc:StreetName">
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cbc:BuildingNumber">
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cbc:InhouseMail">
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cbc:Department">
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cbc:PlotIdentification">
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cbc:CityName">
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryAddress/cbc:PostalZone">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="DespatchAdvice_SellerSupplierParty_Party_PartyIdentification">
		<sch:rule context="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID">
			<sch:assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="DespatchAdvice_SellerSupplierParty_Party_PartyIdentification">
		<sch:rule context="/doc:DespatchAdvice/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID">
			<sch:assert test="(@schemeAgencyName  = 'KvK') or (@schemeAgencyName  = 'BTW') or (@schemeAgencyName = 'Fi') or (@schemeAgencyName  = 'BSN') or (@schemeAgencyName  = 'OIN') or (@schemeAgencyName  = 'XXX')">Uitgevende organisatie van de PartijIdentificatie MOET ge?dentificeerd worden door een code uit de lijst: KvK, BTW, Fi, BSN, OIN, XXX.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="DespatchAdvice_DeliveryCustomerParty_Party_PartyName">
		<sch:rule context="/doc:DespatchAdvice/cac:DeliveryCustomerParty/cac:Party/cac:PartyName/cbc:Name">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="DespatchAdvice_DespatchSupplierParty_Party_PartyName">
		<sch:rule context="/doc:DespatchAdvice/cac:DespatchSupplierParty/cac:Party/cac:PartyName/cbc:Name">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="DespatchAdvice_Shipment_Consignment">
		<sch:rule context="/doc:DespatchAdvice/cac:Shipment/cac:Consignment">
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:Shipment/cac:Consignment/cbc:ID">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="DespatchAdvice_Shipment_Delivery_RequestedDeliveryPeriod">
		<sch:rule context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:RequestedDeliveryPeriod">
			<sch:assert test="exists(cbc:EndDate) ">/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:RequestedDeliveryPeriod/cbc:EndDate element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:RequestedDeliveryPeriod/cbc:EndDate">
			<sch:assert test="string-length(text()) > 0 ">/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:RequestedDeliveryPeriod/cbc:EndDate element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="DespatchAdvice_Shipment_Delivery_DeliveryParty">
		<sch:rule context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryParty">
			<sch:assert test="count(cac:PartyName) lt 2 ">/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryParty/cac:PartyName element should be less than 2!</sch:assert>
			<sch:assert test="exists(cac:PartyName) ">/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryParty/cac:PartyName element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="DespatchAdvice_Shipment_Delivery_DeliveryParty_PartyName">
		<sch:rule context="/doc:DespatchAdvice/cac:Shipment/cac:Delivery/cac:DeliveryParty/cac:PartyName/cbc:Name">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="DespatchAdvice_DespatchLine_OrderLineReference_OrderReference">
		<sch:rule context="/doc:DespatchAdvice/cac:DespatchLine/cac:OrderLineReference/cac:OrderReference">
		</sch:rule>
		<sch:rule context="/doc:DespatchAdvice/cac:DespatchLine/cac:OrderLineReference/cac:OrderReference/cbc:ID">
		</sch:rule>
	</sch:pattern>
</sch:schema>