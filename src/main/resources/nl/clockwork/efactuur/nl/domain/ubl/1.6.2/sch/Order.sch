<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns="http://purl.oclc.org/dsdl/schematron"
	xmlns:sch="http://purl.oclc.org/dsdl/schematron"
	xmlns:doc="urn:oasis:names:specification:ubl:schema:xsd:Order-2"
	xmlns:qdt="urn:oasis:names:specification:ubl:schema:xsd:QualifiedDataTypes-2"
	xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
	xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
	xmlns:ccts="urn:oasis:names:specification:ubl:schema:xsd:CoreComponentParameters-2"
	queryBinding="xslt2"
	schemaVersion="ISO19757-3"
>
<sch:ns prefix="doc" uri="urn:oasis:names:specification:ubl:schema:xsd:Order-2" />
<sch:ns prefix="qdt" uri="urn:oasis:names:specification:ubl:schema:xsd:QualifiedDataTypes-2" />
<sch:ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" />
<sch:ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" />
<sch:ns prefix="ccts" uri="urn:oasis:names:specification:ubl:schema:xsd:CoreComponentParameters-2" />
	<sch:pattern id="Order">
		<sch:rule context="/doc:Order">
			<sch:assert test="count(cac:TaxTotal) lt 2 ">  /doc:Order/cac:TaxTotal element should be less than 2!</sch:assert>
			<sch:assert test="count(cbc:Note) lt 2 ">  /doc:Order/cbc:Note element should be less than 2!</sch:assert>
			<sch:assert test="count(cac:Contract) lt 2 ">  /doc:Order/cac:Contract element should be less than 2!</sch:assert>
			<sch:assert test="( (count(cac:Delivery/cac:DeliveryAddress) = 0) and (count(cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress) = count(cac:OrderLine/cac:LineItem)))or( (count(cac:Delivery/cac:DeliveryAddress) > 0) and (count(cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress) = 0))">  Afleveradres MOET OF op algemeen niveau OF voor alle regels worden opgegeven.</sch:assert>
			<sch:assert test="( (count(cac:Delivery/cac:RequestedDeliveryPeriod) = 0) and (count(cac:OrderLine/cac:LineItem/cac:Delivery/cac:RequestedDeliveryPeriod) = count(cac:OrderLine/cac:LineItem)))or( (count(cac:Delivery/cac:RequestedDeliveryPeriod) > 0) and (count(cac:OrderLine/cac:LineItem/cac:Delivery/cac:RequestedDeliveryPeriod) = 0))">  Levertijd MOET OF op algemeen niveau OF voor alle regels worden opgegeven.</sch:assert>
			<sch:assert test="( (count(cbc:AccountingCostCode) = 0) and (count(cac:OrderLine/cac:LineItem/cbc:AccountingCostCode) = count(cac:OrderLine/cac:LineItem)))or( (count(cbc:AccountingCostCode) > 0) and (count(cac:OrderLine/cac:LineItem/cbc:AccountingCostCode) = 0))">  Kostenplaats MOET OF op algemeen niveau OF voor alle regels worden opgegeven.</sch:assert>
			<sch:assert test="not(empty(cbc:ID))">  /doc:Order/cbc:ID element should not be empty!</sch:assert>
			<sch:assert test="exists(cbc:UBLVersionID) ">  /doc:Order/cbc:UBLVersionID element should exist!</sch:assert>
			<sch:assert test="exists(cbc:CustomizationID) ">  /doc:Order/cbc:CustomizationID element should exist!</sch:assert>
			<sch:assert test="exists(cbc:ProfileID) ">  /doc:Order/cbc:ProfileID element should exist!</sch:assert>
			<sch:assert test="exists(cbc:IssueDate) ">  /doc:Order/cbc:IssueDate element should exist!</sch:assert>
			<sch:assert test="every $bn in //cbc:BuildingNumber satisfies (matches($bn,'^\d+(-[ \w]+)?$'))">  Huisnummer en Huisnummertoevoeging moeten achter elkaar geplaatst worden, gescheiden met een koppelteken.</sch:assert>
			<sch:assert test="(count(cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact) = count(cac:OrderLine/cac:LineItem))or(count(cac:SellerSupplierParty/cac:Party/cac:Contact) > 0)">  Leverancier contactpersoon MOET voor alle regels worden opgegeven ALS NIET op algemeen niveau opgegeven.</sch:assert>
			<sch:assert test="every $id in //cac:PartyIdentification/cbc:ID satisfies (exists($id/@schemeAgencyID) and not(empty($id/@schemeAgencyID)) and exists($id/@schemeAgencyName) and not(empty($id/@schemeAgencyName)))">  PartyIdentification/ID MOET @schemeAgencyID en @schemeAgencyName attributen bevatten.</sch:assert>
			<sch:assert test="exists(cac:Delivery) ">  /doc:Order/cac:Delivery element should exist!</sch:assert>
			<sch:assert test="every $pa in //cac:PostalAddress satisfies ((not(empty($pa/cbc:Postbox)) and empty($pa/cbc:StreetName) and empty($pa/cbc:BuildingNumber) and empty(cbc:Room) and empty(cbc:Floor) and empty(cbc:Department) and empty(cbc:InhouseMail) and empty(cbc:PlotIdentification)) or (empty($pa/cbc:Postbox) and (not(empty($pa/cbc:StreetName)) or not(empty($pa/cbc:BuildingNumber)) or not(empty(cbc:Room)) or not(empty(cbc:Floor)) or not(empty(cbc:Department)) or not(empty(cbc:InhouseMail)) or not(empty(cbc:PlotIdentification)))))">  PostalAddress MOET OF een Postbox bevatten OF minimaal 1 van de elementen StreetName, BuildingNumber, Room, Floor, Department, InhouseMail of PlotIdentification. Beide MAG NIET.</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cbc:UBLVersionID">
			<sch:assert test="normalize-space(text())= '2.0'">  Bericht MOET gebaseerd zijn op UBL versie 2.0.</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cbc:CustomizationID">
			<sch:assert test="normalize-space(text())= '1.6'">  Bericht MOET gebaseerd zijn op versie 1.6 van de Nederlandse specificatie.</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cbc:ProfileID">
			<sch:assert test="normalize-space(text())= 'NL'">  Bericht MOET gebaseerd zijn op de Nederlandse (NL) specificatie.</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cbc:IssueDate">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Order/cbc:IssueDate element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cbc:ID">
		</sch:rule>
		<sch:rule context="/doc:Order/cbc:Note">
		</sch:rule>
		<sch:rule context="/doc:Order/cbc:DocumentCurrencyCode">
		</sch:rule>
		<sch:rule context="/doc:Order/cbc:AccountingCostCode">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_TaxTotal">
		<sch:rule context="/doc:Order/cac:TaxTotal">
			<sch:assert test="exists(cac:TaxSubtotal) ">  Per soort belasting, veelal 'BTW', MOET een element worden opgenomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_BuyerCustomerParty">
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cbc:SupplierAssignedAccountID">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty">
			<sch:assert test="exists(cac:Party) ">  Element MOET worden opgenomen, bevat verplichte bedrijfsidentificatienummer, bedrijfsnaam en opdrachtgever.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_BuyerCustomerParty_Party">
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party">
			<sch:assert test="count(cac:PartyName) lt 2 ">  /doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PartyName element should be less than 2!</sch:assert>
			<sch:assert test="exists(cac:Contact) ">  /doc:Order/cac:BuyerCustomerParty/cac:Party/cac:Contact element should exist!</sch:assert>
			<sch:assert test="exists(cac:PartyIdentification) ">  Element MOET worden opgenomen, bedrijfsidentificatie is verplicht (Kamer van Koophandel nummer voor Nederlandse bedrijven).</sch:assert>
			<sch:assert test="exists(cac:PartyName) ">  Element MOET worden opgenomen, bedrijfsnaam is verplicht.</sch:assert>
			<sch:assert test="count(cac:PartyIdentification) lt 3 ">  /doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification element should be less than 3!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification">
			<sch:assert test="not(empty(cbc:ID))">  /doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID element should not be empty!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PartyName">
			<sch:assert test="not(empty(cbc:Name))">  /doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PartyName/cbc:Name element should not be empty!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:Contact">
			<sch:assert test="matches(cbc:Telephone, '^[-0-9]*$')">  Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</sch:assert>
			<sch:assert test="matches(cbc:Telefax, '^[-0-9]*$')">  Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_BuyerCustomerParty_Party_PartyIdentification">
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID">
			<sch:assert test="(@schemeAgencyName  = 'KvK') or (@schemeAgencyName  = 'BTW') or (@schemeAgencyName = 'Fi') or (@schemeAgencyName  = 'BSN') or (@schemeAgencyName  = 'OIN') or (@schemeAgencyName  = 'XXX')">  Uitgevende organisatie van de PartijIdentificatie MOET ge?dentificeerd worden door een code uit de lijst: KvK, BTW, Fi, BSN, OIN, XXX.</sch:assert>
			<sch:assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">  Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_BuyerCustomerParty_Party_PostalAddress">
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_BuyerCustomerParty_Party_PostalAddress_Country">
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_BuyerCustomerParty_Party_Contact">
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:Contact/cbc:Name">
			<sch:assert test="string-length(text()) > 0 ">  Element MOET worden opgenomen,  naam opdrachtgever is verplicht.</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:Contact">
			<sch:assert test="exists(cbc:Name) ">  Element MOET worden opgenomen,  naam opdrachtgever is verplicht.</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:Contact/cbc:ElectronicMail">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:Contact/cbc:Telefax">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:Contact/cbc:Telephone">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_SellerSupplierParty">
		<sch:rule context="/doc:Order/cac:SellerSupplierParty/cbc:CustomerAssignedAccountID">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:SellerSupplierParty">
			<sch:assert test="exists(cac:Party) ">  Element MOET worden opgenomen, bevat verplichte bedrijfsnaam.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_SellerSupplierParty_Party">
		<sch:rule context="/doc:Order/cac:SellerSupplierParty/cac:Party">
			<sch:assert test="count(cac:PartyName) lt 2 ">  /doc:Order/cac:SellerSupplierParty/cac:Party/cac:PartyName element should be less than 2!</sch:assert>
			<sch:assert test="exists(cac:PartyName) ">  /doc:Order/cac:SellerSupplierParty/cac:Party/cac:PartyName element should exist!</sch:assert>
			<sch:assert test="count(cac:PartyIdentification) lt 3 ">  /doc:Order/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification element should be less than 3!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:SellerSupplierParty/cac:Party/cac:PartyName">
			<sch:assert test="not(empty(cbc:Name))">  /doc:Order/cac:SellerSupplierParty/cac:Party/cac:PartyName/cbc:Name element should not be empty!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:SellerSupplierParty/cac:Party/cac:Contact">
			<sch:assert test="matches(cbc:Telefax, '^[-0-9]*$')">   Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</sch:assert>
			<sch:assert test="matches(cbc:Telephone, '^[-0-9]*$')">   Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_SellerSupplierParty_Party_PartyIdentification">
		<sch:rule context="/doc:Order/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID">
			<sch:assert test="(@schemeAgencyName  = 'KvK') or (@schemeAgencyName  = 'BTW') or (@schemeAgencyName = 'Fi') or (@schemeAgencyName  = 'BSN') or (@schemeAgencyName  = 'OIN') or (@schemeAgencyName  = 'XXX')">  Uitgevende organisatie van de PartijIdentificatie MOET ge?dentificeerd worden door een code uit de lijst: KvK, BTW, Fi, BSN, OIN, XXX.</sch:assert>
			<sch:assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">  Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_SellerSupplierParty_Party_PostalAddress">
		<sch:rule context="/doc:Order/cac:SellerSupplierParty/cac:Party/cac:PostalAddress">
			<sch:assert test="exists(cac:Country) ">  /doc:Order/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:PostalZone">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:CityName">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:PlotIdentification">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:Department">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:InhouseMail">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:BuildingNumber">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:StreetName">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:Room">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:Floor">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:Postbox">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_SellerSupplierParty_Party_PostalAddress_Country">
		<sch:rule context="/doc:Order/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Order/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country">
			<sch:assert test="exists(cbc:IdentificationCode) ">  /doc:Order/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_AccountingCustomerParty_Party">
		<sch:rule context="/doc:Order/cac:AccountingCustomerParty/cac:Party">
			<sch:assert test="count(cac:PartyName) lt 2 ">  /doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PartyName element should be less than 2!</sch:assert>
			<sch:assert test="exists(cac:PartyIdentification) ">  /doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification element should exist!</sch:assert>
			<sch:assert test="count(cac:PartyIdentification) lt 3">  /doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification element should be less than 3!</sch:assert>
			<sch:assert test="exists(cac:PartyName) ">  /doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PartyName element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_AccountingCustomerParty_Party_PartyIdentification">
		<sch:rule context="/doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID">
			<sch:assert test="(@schemeAgencyName  = 'KvK') or (@schemeAgencyName  = 'BTW') or (@schemeAgencyName = 'Fi') or (@schemeAgencyName  = 'BSN') or (@schemeAgencyName  = 'OIN') or (@schemeAgencyName  = 'XXX')">  Uitgevende organisatie van de PartijIdentificatie MOET ge?dentificeerd worden door een code uit de lijst: KvK, BTW, Fi, BSN, OIN, XXX.</sch:assert>
			<sch:assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">  Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_AccountingCustomerParty_Party_PostalAddress">
		<sch:rule context="/doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress">
			<sch:assert test="exists(cac:Country) ">  /doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:PostalZone">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:CityName">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:PlotIdentification">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:Department">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:InhouseMail">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:BuildingNumber">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:StreetName">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:Room">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:Floor">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:Postbox">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_AccountingCustomerParty_Party_PostalAddress_Country">
		<sch:rule context="/doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country">
			<sch:assert test="exists(cbc:IdentificationCode) ">  /doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_Delivery_DeliveryAddress">
		<sch:rule context="/doc:Order/cac:Delivery/cac:DeliveryAddress">
			<sch:assert test="exists(cac:Country) ">  /doc:Order/cac:Delivery/cac:DeliveryAddress/cac:Country element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:Delivery/cac:DeliveryAddress/cbc:PostalZone">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:Delivery/cac:DeliveryAddress/cbc:CityName">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:Delivery/cac:DeliveryAddress/cbc:PlotIdentification">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:Delivery/cac:DeliveryAddress/cbc:Department">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:Delivery/cac:DeliveryAddress/cbc:InhouseMail">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:Delivery/cac:DeliveryAddress/cbc:BuildingNumber">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:Delivery/cac:DeliveryAddress/cbc:StreetName">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:Delivery/cac:DeliveryAddress/cbc:Room">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:Delivery/cac:DeliveryAddress/cbc:Floor">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_Delivery_DeliveryAddress_Country">
		<sch:rule context="/doc:Order/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Order/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:Delivery/cac:DeliveryAddress/cac:Country">
			<sch:assert test="exists(cbc:IdentificationCode) ">  /doc:Order/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_Delivery_RequestedDeliveryPeriod">
		<sch:rule context="/doc:Order/cac:Delivery/cac:RequestedDeliveryPeriod">
			<sch:assert test="exists(cbc:EndDate) ">  Element MOET worden opgenomen, leveranciersnummer is verplicht.</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:Delivery/cac:RequestedDeliveryPeriod/cbc:EndDate">
			<sch:assert test="string-length(text()) > 0 ">  Element MOET worden opgenomen, leveranciersnummer is verplicht.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_Delivery_DeliveryParty">
		<sch:rule context="/doc:Order/cac:Delivery/cac:DeliveryParty">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_AnticipatedMonetaryTotal">
		<sch:rule context="/doc:Order/cac:AnticipatedMonetaryTotal/cbc:TaxExclusiveAmount">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Order/cac:AnticipatedMonetaryTotal/cbc:TaxExclusiveAmount element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:AnticipatedMonetaryTotal">
			<sch:assert test="exists(cbc:TaxExclusiveAmount) ">  /doc:Order/cac:AnticipatedMonetaryTotal/cbc:TaxExclusiveAmount element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_OrderLine_DocumentReference">
		<sch:rule context="/doc:Order/cac:OrderLine/cac:DocumentReference/cbc:DocumentType">
			<sch:assert test="string-length(text()) > 0 ">  Element MOET worden opgenomen, geeft type document aan zoals Offerte of Contract.</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:OrderLine/cac:DocumentReference/cbc:ID">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Order/cac:OrderLine/cac:DocumentReference/cbc:ID element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:OrderLine/cac:DocumentReference">
			<sch:assert test="exists(cbc:ID) ">  /doc:Order/cac:OrderLine/cac:DocumentReference/cbc:ID element should exist!</sch:assert>
			<sch:assert test="exists(cbc:DocumentType) and not(empty(cbc:DocumentType))">  Indien de identificatie van een contract meegegeven wordt, moet hier 'Contract' opgegeven worden.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_OrderLine_LineItem">
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem">
			<sch:assert test="exists(cac:Price) ">  Element MOET worden opgenomen, bevat de verplichte prijs.</sch:assert>
			<sch:assert test="exists(cbc:Quantity) ">  /doc:Order/cac:OrderLine/cac:LineItem/cbc:Quantity element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cbc:Quantity">
			<sch:assert test="string-length(@unitCode) > 0 ">  /doc:Order/cac:OrderLine/cac:LineItem/cbc:Quantity/@unitCode element should exist!</sch:assert>
			<sch:assert test="string-length(text()) > 0 ">  /doc:Order/cac:OrderLine/cac:LineItem/cbc:Quantity element should exist!</sch:assert>
			<sch:assert test="exists(@unitCode)">  /doc:Order/cac:OrderLine/cac:LineItem/cbc:Quantity/@unitCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cac:Item">
			<sch:assert test="( (count(cbc:Description) = 0) and (   (count(cac:BuyersItemIdentification/cbc:ID) + count(cac:SellersItemIdentification/cbc:ID) + count(cac:ManufacturersItemIdentification/cbc:ID) + count(cac:StandardItemIdentification/cbc:ID) + count(cac:CatalogueItemIdentification/cbc:ID)) > 0 ))or( (count(cbc:Description) > 0) and (   (count(cac:BuyersItemIdentification/cbc:ID) + count(cac:SellersItemIdentification/cbc:ID) + count(cac:ManufacturersItemIdentification/cbc:ID) + count(cac:StandardItemIdentification/cbc:ID) + count(cac:CatalogueItemIdentification/cbc:ID)) = 0 ))">  Item MOET OF een Description OF een (party)Identification/ID bevatten.</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cbc:ID">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cbc:Note">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cbc:AccountingCostCode">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_OrderLine_LineItem_Delivery_DeliveryAddress">
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress">
			<sch:assert test="exists(cac:Country) ">  /doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cbc:PostalZone">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cbc:CityName">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cbc:PlotIdentification">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cbc:Department">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cbc:InhouseMail">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cbc:BuildingNumber">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cbc:StreetName">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cbc:Room">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cbc:Floor">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_OrderLine_LineItem_Delivery_DeliveryAddress_Country">
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country">
			<sch:assert test="exists(cbc:IdentificationCode) ">  /doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_OrderLine_LineItem_Delivery_RequestedDeliveryPeriod">
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:RequestedDeliveryPeriod/cbc:EndDate">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:RequestedDeliveryPeriod/cbc:EndDate element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:RequestedDeliveryPeriod">
			<sch:assert test="exists(cbc:EndDate) ">  /doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:RequestedDeliveryPeriod/cbc:EndDate element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_OrderLine_LineItem_Delivery_DeliveryParty">
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty">
			<sch:assert test="exists(cac:PartyName) ">  /doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:PartyName element should exist!</sch:assert>
			<sch:assert test="count(cac:PartyName) lt 2 ">  /doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:PartyName element should be less than 2!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact">
			<sch:assert test="matches(cbc:Telefax, '^[-0-9]*$')">  Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</sch:assert>
			<sch:assert test="matches(cbc:Telephone, '^[-0-9]*$')">  Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_OrderLine_LineItem_Item">
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cac:Item">
			<sch:assert test="count(cbc:Description) lt 2 ">  /doc:Order/cac:OrderLine/cac:LineItem/cac:Item/cbc:Description element should be less than 2!</sch:assert>
			<sch:assert test="exists(cac:SellersItemIdentification) ">  Element MOET worden opgenomen, bevat verplichte productidentificatie van leverantier</sch:assert>
			<sch:assert test="exists(cbc:CatalogueIndicator) ">  /doc:Order/cac:OrderLine/cac:LineItem/cac:Item/cbc:CatalogueIndicator element should exist!</sch:assert>
			<sch:assert test="exists(cbc:Name) ">  /doc:Order/cac:OrderLine/cac:LineItem/cac:Item/cbc:Name element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cac:Item/cbc:CatalogueIndicator">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Order/cac:OrderLine/cac:LineItem/cac:Item/cbc:CatalogueIndicator element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cac:Item/cbc:Name">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Order/cac:OrderLine/cac:LineItem/cac:Item/cbc:Name element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cac:Item/cbc:Description">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_OrderLine_LineItem_Item_TransactionConditions">
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cac:Item/cac:TransactionConditions">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cac:Item/cac:TransactionConditions/cbc:Description">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_OrderLine_LineItem_Item_ClassifiedTaxCategory_TaxScheme">
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme/cbc:Name">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme">
			<sch:assert test="(cbc:Name = 'BTW') or (cbc:Name = 'Accijns') or (cbc:Name = 'Toeslag') or (cbc:Name = 'Overige')">  De soort belasting/heffing MOET ge?dentificeerd worden met een code uit de lijst: BTW, Accijns, Toeslag, Overige.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_PaymentMeans_PayeeFinancialAccount_FinancialInstitutionBranch">
		<sch:rule context="/doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch">
			<sch:assert test="exists(cac:FinancialInstitution) ">  /doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cbc:Name">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_PaymentMeans_PayeeFinancialAccount_FinancialInstitutionBranch_FinancialInstitution">
		<sch:rule context="/doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution">
			<sch:assert test="exists(cbc:ID) ">  /doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:Name">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_PaymentMeans_PayeeFinancialAccount">
		<sch:rule context="/doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:ID">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:ID element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount">
			<sch:assert test="exists(cbc:ID) ">  /doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:ID element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_PaymentMeans_PayeeFinancialAccount_Country">
		<sch:rule context="/doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country">
			<sch:assert test="exists(cbc:IdentificationCode) ">  /doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_Contract">
		<sch:rule context="/doc:Order/cac:Contract/cbc:ID">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Order/cac:Contract/cbc:ID element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:Contract">
			<sch:assert test="exists(cbc:ID) ">  /doc:Order/cac:Contract/cbc:ID element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_BuyerCustomerParty_Party_AgentParty">
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty">
			<sch:assert test="count(cac:PartyName) lt 2 ">  /doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PartyName element should be less than 2!</sch:assert>
			<sch:assert test="count(cac:PartyIdentification) lt 3 ">  /doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification element should be less than 3!</sch:assert>
			<sch:assert test="exists(cac:PartyIdentification) ">  /doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:Contact">
			<sch:assert test="matches(cbc:Telephone, '^[-0-9]*$')">  Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</sch:assert>
			<sch:assert test="matches(cbc:Telefax, '^[-0-9]*$')">  Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_BuyerCustomerParty_Party_AgentParty_PostalAddress">
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress">
			<sch:assert test="exists(cac:Country) ">  /doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cbc:PostalZone">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cbc:CityName">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cbc:PlotIdentification">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cbc:Department">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cbc:InhouseMail">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cbc:BuildingNumber">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cbc:StreetName">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cbc:Room">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cbc:Floor">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cbc:Postbox">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_BuyerCustomerParty_Party_AgentParty_PostalAddress_Country">
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country">
			<sch:assert test="exists(cbc:IdentificationCode) ">  /doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_BuyerCustomerParty_Party_AgentParty_PartyIdentification">
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification/cbc:ID">
			<sch:assert test="(@schemeAgencyName  = 'KvK') or (@schemeAgencyName  = 'BTW') or (@schemeAgencyName = 'Fi') or (@schemeAgencyName  = 'BSN') or (@schemeAgencyName  = 'OIN') or (@schemeAgencyName  = 'XXX')">  Uitgevende organisatie van de PartijIdentificatie MOET ge?dentificeerd worden door een code uit de lijst: KvK, BTW, Fi, BSN, OIN, XXX.</sch:assert>
			<sch:assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">  Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_SellerSupplierParty_Party_AgentParty">
		<sch:rule context="/doc:Order/cac:SellerSupplierParty/cac:Party/cac:AgentParty">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_SellerSupplierParty_Party_AgentParty_PostalAddress">
		<sch:rule context="/doc:Order/cac:SellerSupplierParty/cac:Party/cac:AgentParty/cac:PostalAddress">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_SellerSupplierParty_Party_AgentParty_PostalAddress_Country">
		<sch:rule context="/doc:Order/cac:SellerSupplierParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:SellerSupplierParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_SellerSupplierParty_Party_AgentParty_PartyIdentification">
		<sch:rule context="/doc:Order/cac:SellerSupplierParty/cac:Party/cac:AgentParty/cac:PartyIdentification/cbc:ID">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_PaymentMeans_PayeeFinancialAccount_FinancialInstitutionBranch_Address">
		<sch:rule context="/doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address">
			<sch:assert test="exists(cac:Country) ">  /doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cbc:PostalZone">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cbc:CityName">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cbc:PlotIdentification">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cbc:Department">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cbc:InhouseMail">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cbc:BuildingNumber">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cbc:StreetName">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cbc:Room">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cbc:Floor">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cbc:Postbox">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_PaymentMeans_PayeeFinancialAccount_FinancialInstitutionBranch_Address_Country">
		<sch:rule context="/doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country">
			<sch:assert test="exists(cbc:IdentificationCode) ">  /doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_FreightForwarderParty">
		<sch:rule context="/doc:Order/cac:FreightForwarderParty">
			<sch:assert test="count(cac:PartyName) lt 2 ">  /doc:Order/cac:FreightForwarderParty/cac:PartyName element should be less than 2!</sch:assert>
			<sch:assert test="count(cac:PartyIdentification) lt 3 ">  /doc:Order/cac:FreightForwarderParty/cac:PartyIdentification element should be less than 3!</sch:assert>
			<sch:assert test="exists(cac:PartyIdentification) ">  /doc:Order/cac:FreightForwarderParty/cac:PartyIdentification element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_BuyerCustomerParty_Party_PhysicalLocation_Address">
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address">
			<sch:assert test="exists(cac:Country) ">  /doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:StreetName">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:InhouseMail">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:Department">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:PlotIdentification">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:CityName">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:PostalZone">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_BuyerCustomerParty_Party_PhysicalLocation_Address_Country">
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country">
			<sch:assert test="exists(cbc:IdentificationCode) ">  /doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_BuyerCustomerParty_Party_PhysicalLocation">
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation">
			<sch:assert test="exists(cac:Address) ">  /doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cbc:Description">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_Delivery_Despatch">
		<sch:rule context="/doc:Order/cac:Delivery/cac:Despatch">
			<sch:assert test="exists(cac:DespatchAddress) ">  /doc:Order/cac:Delivery/cac:Despatch/cac:DespatchAddress element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_Delivery_Despatch_DespatchAddress">
		<sch:rule context="/doc:Order/cac:Delivery/cac:Despatch/cac:DespatchAddress">
			<sch:assert test="exists(cac:Country) ">  /doc:Order/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:Delivery/cac:Despatch/cac:DespatchAddress/cbc:PostalZone">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:Delivery/cac:Despatch/cac:DespatchAddress/cbc:CityName">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:Delivery/cac:Despatch/cac:DespatchAddress/cbc:PlotIdentification">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:Delivery/cac:Despatch/cac:DespatchAddress/cbc:Department">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:Delivery/cac:Despatch/cac:DespatchAddress/cbc:InhouseMail">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:Delivery/cac:Despatch/cac:DespatchAddress/cbc:BuildingNumber">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:Delivery/cac:Despatch/cac:DespatchAddress/cbc:StreetName">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:Delivery/cac:Despatch/cac:DespatchAddress/cbc:Room">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:Delivery/cac:Despatch/cac:DespatchAddress/cbc:Floor">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_Delivery_Despatch_DespatchAddress_Country">
		<sch:rule context="/doc:Order/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country/cbc:IdentificationCode">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Order/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country">
			<sch:assert test="exists(cbc:IdentificationCode) ">  /doc:Order/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_TaxTotal_TaxSubtotal_TaxCategory_TaxScheme">
	</sch:pattern>
	<sch:pattern id="Order_OrderLine_LineItem_Price">
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cac:Price/cbc:PriceAmount">
			<sch:assert test="(count(../../../../cbc:PricingCurrencyCode) = 0)or( (count(../../../../cbc:PricingCurrencyCode) > 0) and (@currencyID = ../../../../cbc:PricingCurrencyCode/text()))">  Valutacode op regelniveau MOET gelijk zijn aan algemeen niveau als opgegeven.</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cac:Price">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cac:Price/cbc:BaseQuantity">
			<sch:assert test="string-length(@unitCode) > 0 ">  /doc:Order/cac:OrderLine/cac:LineItem/cac:Price/cbc:BaseQuantity/@unitCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_PaymentMeans">
		<sch:rule context="/doc:Order/cac:PaymentMeans/cbc:PaymentMeansCode">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Order/cac:PaymentMeans/cbc:PaymentMeansCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:PaymentMeans">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_OrderLine_LineItem_Delivery_DeliveryParty_Contact">
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact/cbc:Name">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact/cbc:Name element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact">
			<sch:assert test="exists(cbc:Name) ">  /doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact/cbc:Name element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact/cbc:ElectronicMail">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact/cbc:Telefax">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact/cbc:Telephone">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_SellerSupplierParty_Party_Contact">
		<sch:rule context="/doc:Order/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Order/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:SellerSupplierParty/cac:Party/cac:Contact">
			<sch:assert test="exists(cbc:Name) ">  /doc:Order/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:ElectronicMail">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Telefax">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Telephone">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_BuyerCustomerParty_Party_AgentParty_Contact">
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:Contact">
			<sch:assert test="exists(cbc:Name) ">  /doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:Contact/cbc:Name element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:Contact/cbc:Name">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:Contact/cbc:Name element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:Contact/cbc:ElectronicMail">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:Contact/cbc:Telefax">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:Contact/cbc:Telephone">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_FreightForwarderParty_PartyIdentification">
		<sch:rule context="/doc:Order/cac:FreightForwarderParty/cac:PartyIdentification/cbc:ID">
			<sch:assert test="(@schemeAgencyName  = 'KvK') or (@schemeAgencyName  = 'BTW') or (@schemeAgencyName = 'Fi') or (@schemeAgencyName  = 'BSN') or (@schemeAgencyName  = 'OIN') or (@schemeAgencyName  = 'XXX')">  Uitgevende organisatie van de PartijIdentificatie MOET ge?dentificeerd worden door een code uit de lijst: KvK, BTW, Fi, BSN, OIN, XXX.</sch:assert>
			<sch:assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">  Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_AccountingCustomerParty">
		<sch:rule context="/doc:Order/cac:AccountingCustomerParty">
			<sch:assert test="exists(cac:Party) ">  /doc:Order/cac:AccountingCustomerParty/cac:Party element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_DeliveryTerms">
		<sch:rule context="/doc:Order/cac:DeliveryTerms">
			<sch:assert test="exists(cbc:ID) ">  /doc:Order/cac:DeliveryTerms/cbc:ID element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:DeliveryTerms/cbc:ID">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Order/cac:DeliveryTerms/cbc:ID element should exist!</sch:assert>
			<sch:assert test="normalize-space (@schemeID ) = 'NL-1002'">  Inhoud MOET verwijzen naar: NL-1002</sch:assert>
			<sch:assert test="normalize-space (@schemeAgencyID) = xs:string(88)">  Inhoud MOET verwijzen naar: 88</sch:assert>
			<sch:assert test="normalize-space (@schemeAgencyName)  = 'Logius Gegevensbeheer NL-Overheid' ">  Inhoud MOET verwijzen naar: Logius Gegevensbeheer NL-Overheid</sch:assert>
			<sch:assert test="normalize-space (@schemeDataURI)  = 'urn:digi-inkoop:ubl:2.0:NL:1.6:gc:DeliveryTermsCode'">  Inhoud MOET verwijzen naar: urn:digi-inkoop:ubl:2.0:NL:1.6:gc:DeliveryTermsCode</sch:assert>
			<sch:assert test="normalize-space (@schemeName) = 'DeliveryTermsCode' ">  Inhoud MOET verwijzen naar: DeliveryTermsCode</sch:assert>
			<sch:assert test="normalize-space (@schemeVersionID) = xs:string(1.6)">  Inhoud MOET verwijzen naar: 1.6</sch:assert>
			<sch:assert test="normalize-space(@schemeURI ) = 'http://www.nltaxonomie.nl/ubl/2.0/NL/1.6/cl/gc/DeliveryTermsCode.gc' ">  Inhoud MOET verwijzen naar: http://www.nltaxonomie.nl/ubl/2.0/NL/1.6/cl/gc/DeliveryTermsCode.gc</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:DeliveryTerms/cbc:SpecialTerms">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_OrderLine_DocumentReference_Attachment">
		<sch:rule context="/doc:Order/cac:OrderLine/cac:DocumentReference/cac:Attachment">
			<sch:assert test="exists(cbc:EmbeddedDocumentBinaryObject) ">  /doc:Order/cac:OrderLine/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:OrderLine/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Order/cac:OrderLine/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_OrderLine_LineItem_DeliveryTerms">
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cac:DeliveryTerms">
			<sch:assert test="exists(cbc:ID) ">  /doc:Order/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:SpecialTerms">
		</sch:rule>
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Order/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID element should exist!</sch:assert>
			<sch:assert test="normalize-space (@schemeAgencyID) = xs:string(88)">  Inhoud MOET verwijzen naar: 88</sch:assert>
			<sch:assert test="normalize-space (@schemeID ) = 'NL-1002'">  Inhoud MOET verwijzen naar: NL-1002</sch:assert>
			<sch:assert test="normalize-space (@schemeAgencyName)  = 'Logius Gegevensbeheer NL-Overheid'">  Inhoud MOET verwijzen naar: Logius Gegevensbeheer NL-Overheid</sch:assert>
			<sch:assert test="normalize-space (@schemeDataURI)  = 'urn:digi-inkoop:ubl:2.0:NL:1.6:gc:DeliveryTermsCode' ">  Inhoud MOET verwijzen naar:  urn:digi-inkoop:ubl:2.0:NL:1.6:gc:DeliveryTermsCode</sch:assert>
			<sch:assert test="normalize-space(@schemeURI ) = 'http://www.nltaxonomie.nl/ubl/2.0/NL/1.6/cl/gc/DeliveryTermsCode.gc' ">  Inhoud MOET verwijzen naar: http://www.nltaxonomie.nl/ubl/2.0/NL/1.6/cl/gc/DeliveryTermsCode.gc</sch:assert>
			<sch:assert test="normalize-space (@schemeName) = 'DeliveryTermsCode'">  Inhoud MOET verwijzen naar: DeliveryTermsCode</sch:assert>
			<sch:assert test="normalize-space (@schemeVersionID) = xs:string(1.6)">  Inhoud MOET verwijzen naar: 1.6</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_OrderLine_LineItem_Item_ItemSpecificationDocumentReference_Attachment">
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Order/cac:OrderLine/cac:LineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Order/cac:OrderLine/cac:LineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment">
			<sch:assert test="exists(cbc:EmbeddedDocumentBinaryObject) ">  /doc:Order/cac:OrderLine/cac:LineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Order_TaxTotal_TaxSubtotal_TaxCategory">
		<sch:rule context="/doc:Order/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
			<sch:assert test="(cbc:Name = 'BTW') or (cbc:Name = 'Accijns') or (cbc:Name = 'Toeslag') or (cbc:Name = 'Overige')">  De soort belasting/heffing MOET ge?dentificeerd worden met een code uit de lijst: BTW, Accijns, Toeslag, Overige.</sch:assert>
		</sch:rule>
	</sch:pattern>
</sch:schema>