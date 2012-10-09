<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns="http://purl.oclc.org/dsdl/schematron"
	xmlns:sch="http://purl.oclc.org/dsdl/schematron"
	xmlns:qdt="urn:oasis:names:specification:ubl:schema:xsd:QualifiedDataTypes-2"
	xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
	xmlns:doc="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"
	xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
	xmlns:ccts="urn:oasis:names:specification:ubl:schema:xsd:CoreComponentParameters-2"
	xmlns:ext="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"
	xmlns:nl-cbc="urn:digi-inkoop:ubl:2.0:NL:1.6:UBL-NL-CommonBasicComponents-2"
	queryBinding="xslt2"
	schemaVersion="ISO19757-3"
>
<sch:ns prefix="qdt" uri="urn:oasis:names:specification:ubl:schema:xsd:QualifiedDataTypes-2" />
<sch:ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" />
<sch:ns prefix="doc" uri="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2" />
<sch:ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" />
<sch:ns prefix="ccts" uri="urn:oasis:names:specification:ubl:schema:xsd:CoreComponentParameters-2" />
<sch:ns prefix="ext" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2" />
<sch:ns prefix="nl-cbc" uri="urn:digi-inkoop:ubl:2.0:NL:1.6:UBL-NL-CommonBasicComponents-2" />
	<sch:pattern id="RequestForQuotation_UBLExtensions">
	    <!-- Manually maintained rules for the extensions (cannot be done in eDoCreator -->

		<sch:rule context="/doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cbc:LastInvoiceOnOrderIndicator">
            <sch:assert test="text() = 'true' or text() = 'false' or text() = '1' or text() = '0'">  LastInvoiceOnOrderIndicator moet een geldige boolean waarde bevatten: true, false, 1, 0.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice">
		<sch:rule context="/doc:Invoice/cbc:UBLVersionID">
			<sch:assert test="normalize-space(text()) = '2.0'">  Bericht MOET gebaseerd zijn op UBL Versie 2.0</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cbc:CustomizationID">
			<sch:assert test="normalize-space(text()) = '1.6'">  Bericht MOET gebaseerd zijn op versie 1.6 van de Nederlandse specificatie.</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cbc:ProfileID">
			<sch:assert test="normalize-space(text()) = 'NL'">  Bericht MOET op de Nederlandse (NL) specificatie gebaseerd zijn.</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice">
			<sch:assert test="count(cbc:Note) lt 2 ">  /doc:Invoice/cbc:Note element should be less than 2!</sch:assert>
			<sch:assert test="count(cac:InvoicePeriod) lt 2 ">  /doc:Invoice/cac:InvoicePeriod element should be less than 2!</sch:assert>
			<sch:assert test="count(cac:Delivery) lt 2 ">  /doc:Invoice/cac:Delivery element should be less than 2!</sch:assert>
			<sch:assert test="count(cac:PaymentMeans) lt 2 ">  /doc:Invoice/cac:PaymentMeans element should be less than 2!</sch:assert>
			<sch:assert test="exists(cac:TaxTotal) ">  /doc:Invoice/cac:TaxTotal element should exist!</sch:assert>
			<sch:assert test="count(cac:TaxTotal) lt 2 ">  /doc:Invoice/cac:TaxTotal element should be less than 2!</sch:assert>
			<sch:assert test="count(cac:BillingReference) lt 2 ">  /doc:Invoice/cac:BillingReference element should be less than 2!</sch:assert>
			<sch:assert test="not(empty(cbc:ID))">  /doc:Invoice/cbc:ID element should not be empty!</sch:assert>
			<sch:assert test="exists(cbc:UBLVersionID) ">  /doc:Invoice/cbc:UBLVersionID element should exist!</sch:assert>
			<sch:assert test="exists(cbc:CustomizationID) ">  /doc:Invoice/cbc:CustomizationID element should exist!</sch:assert>
			<sch:assert test="exists(cbc:ProfileID) ">  /doc:Invoice/cbc:ProfileID element should exist!</sch:assert>
			<sch:assert test="exists(cbc:ID) ">  /doc:Invoice/cbc:ID element should exist!</sch:assert>
			<sch:assert test="(count(cac:OrderReference/cbc:ID) + count(cbc:AccountingCostCode) + count(cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:Name)) > 0">  Er moet in ieder geval een OrderReference ID, AccountingCostCode of Contact Name worden opgegeven.</sch:assert>
			<sch:assert test="every $bn in //cbc:BuildingNumber satisfies (matches($bn,'^\d+(-[ \w]+)?$'))">  Huisnummer en Huisnummertoevoeging moeten achter elkaar geplaatst worden, gescheiden met een koppelteken.</sch:assert>
			<sch:assert test="every $id in //cac:PartyIdentification/cbc:ID satisfies (exists($id/@schemeAgencyID) and not(empty($id/@schemeAgencyID)) and exists($id/@schemeAgencyName) and not(empty($id/@schemeAgencyName)))">  PartyIdentification/ID MOET @schemeAgencyID en @schemeAgencyName attributen bevatten.</sch:assert>
			<sch:assert test="count(cac:PaymentTerms) lt 4">  /doc:Invoice/cac:PaymentTerms element should be less than 4!</sch:assert>
			<sch:assert test="every $pa in //cac:PostalAddress satisfies ((not(empty($pa/cbc:Postbox)) and empty($pa/cbc:StreetName) and empty($pa/cbc:BuildingNumber) and empty(cbc:Room) and empty(cbc:Floor) and empty(cbc:Department) and empty(cbc:InhouseMail) and empty(cbc:PlotIdentification)) or (empty($pa/cbc:Postbox) and (not(empty($pa/cbc:StreetName)) or not(empty($pa/cbc:BuildingNumber)) or not(empty(cbc:Room)) or not(empty(cbc:Floor)) or not(empty(cbc:Department)) or not(empty(cbc:InhouseMail)) or not(empty(cbc:PlotIdentification)))))">  PostalAddress MOET OF een Postbox bevatten OF minimaal 1 van de elementen StreetName, BuildingNumber, Room, Floor, Department, InhouseMail of PlotIdentification. Beide MAG NIET.</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cbc:CopyIndicator">
		</sch:rule>
		<sch:rule context="/doc:Invoice/cbc:ID">
			<sch:assert test="string-length(text()) lt 25">  Element lengte MOET minder dan 25 posities zijn.</sch:assert>
			<sch:assert test="string-length(text()) > 0 ">  /doc:Invoice/cbc:ID element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cbc:InvoiceTypeCode">
			<sch:assert test="normalize-space(@listID) = 'NL-1001'">  Attribuut MOET de waarde NL-1001 bevatten.</sch:assert>
			<sch:assert test="normalize-space(@listAgencyID) = xs:string(88)">  Attribuut MOET de waarde 88 bevatten.</sch:assert>
			<sch:assert test="normalize-space(@listAgencyName) = 'Logius Gegevensbeheer NL-Overheid'">  Attribuut MOET de waarde 'Logius Gegevensbeheer NL-Overheid' bevatten.</sch:assert>
			<sch:assert test="normalize-space(@listName) = 'FactuurSoort'">  Attribuut MOET de waarde FactuurSoort bevatten.</sch:assert>
			<sch:assert test="string-length(text()) > 0 ">  /doc:Invoice/cbc:InvoiceTypeCode element should exist!</sch:assert>
			<sch:assert test="normalize-space(@listSchemeURI) = 'urn:digi-inkoop:ubl:2.0:NL:1.6:gc:InvoiceTypeCode'">  Attribuut MOET de waarde urn:digi-inkoop:ubl:2.0:NL:1.6:gc:InvoiceTypeCode bevatten.</sch:assert>
			<sch:assert test="normalize-space(@listVersionID) = xs:string(1.6)">  Attribuut MOET de waarde 1.6 bevatten.</sch:assert>
			<sch:assert test="normalize-space(@listURI) = 'http://www.nltaxonomie.nl/ubl/2.0/NL/1.6/cl/gc/InvoiceTypeCode.gc'">  Attribuut MOET de waarde http://www.nltaxonomie.nl/ubl/2.0/NL/1.6/cl/gc/InvoiceTypeCode.gc bevatten.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingCustomerParty">
		<sch:rule context="/doc:Invoice/cac:AccountingCustomerParty">
			<sch:assert test="exists(cac:Party) ">  /doc:Invoice/cac:AccountingCustomerParty/cac:Party element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:AccountingCustomerParty/cac:Party">
			<sch:assert test="count(cac:PartyIdentification) lt 3">  /doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification element should be less than 3!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingCustomerParty_Party">
		<sch:rule context="/doc:Invoice/cac:AccountingCustomerParty/cac:Party">
			<sch:assert test="exists(cac:PartyIdentification) ">  /doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification element should exist!</sch:assert>
			<sch:assert test="count(cac:PartyName) lt 2 ">  /doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyName element should be less than 2!</sch:assert>
			<sch:assert test="exists(cac:PartyName) ">  /doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyName element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingCustomerParty_Party_PartyIdentification">
		<sch:rule context="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID">
			<sch:assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">  Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</sch:assert>
			<sch:assert test="(@schemeAgencyName  = 'KvK') or (@schemeAgencyName  = 'BTW') or (@schemeAgencyName = 'Fi') or (@schemeAgencyName  = 'BSN') or (@schemeAgencyName  = 'OIN') or (@schemeAgencyName  = 'XXX')">  Uitgevende organisatie van de PartijIdentificatie MOET ge?dentificeerd worden door een code uit de lijst: KvK, BTW, Fi, BSN, OIN, XXX.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingCustomerParty_Party_PartyTaxScheme">
		<sch:rule context="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingCustomerParty_Party_Person">
		<sch:rule context="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:Person/cbc:FamilyName">
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:Person">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_InvoicePeriod">
		<sch:rule context="/doc:Invoice/cac:InvoicePeriod/cbc:StartDate">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Invoice/cac:InvoicePeriod/cbc:StartDate element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:InvoicePeriod/cbc:EndDate">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Invoice/cac:InvoicePeriod/cbc:EndDate element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:InvoicePeriod">
			<sch:assert test="exists(cbc:StartDate) ">  /doc:Invoice/cac:InvoicePeriod/cbc:StartDate element should exist!</sch:assert>
			<sch:assert test="exists(cbc:EndDate) ">  /doc:Invoice/cac:InvoicePeriod/cbc:EndDate element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_OrderReference">
		<sch:rule context="/doc:Invoice/cac:OrderReference/cbc:ID">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Invoice/cac:OrderReference/cbc:ID element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:OrderReference">
			<sch:assert test="exists(cbc:ID) ">  /doc:Invoice/cac:OrderReference/cbc:ID element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_BillingReference">
		<sch:rule context="/doc:Invoice/cac:BillingReference">
			<sch:assert test="exists(cac:InvoiceDocumentReference) ">  /doc:Invoice/cac:BillingReference/cac:InvoiceDocumentReference element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_BillingReference_InvoiceDocumentReference_ID">
		<sch:rule context="/doc:Invoice/cac:BillingReference/cac:InvoiceDocumentReference/cbc:ID">
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:BillingReference/cac:InvoiceDocumentReference">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_ContractDocumentReference">
		<sch:rule context="/doc:Invoice/cac:ContractDocumentReference/cbc:ID">
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:ContractDocumentReference">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingSupplierParty">
		<sch:rule context="/doc:Invoice/cac:AccountingSupplierParty">
			<sch:assert test="exists(cac:Party) ">  /doc:Invoice/cac:AccountingSupplierParty/cac:Party element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:AccountingSupplierParty/cac:Party">
			<sch:assert test="count(cac:PartyIdentification) lt 3">  /doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification element should be less than 3!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingSupplierParty_Party">
		<sch:rule context="/doc:Invoice/cac:AccountingSupplierParty/cac:Party">
			<sch:assert test="exists(cac:PartyIdentification) ">  /doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification element should exist!</sch:assert>
			<sch:assert test="exists(cac:PartyName) ">  /doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyName element should exist!</sch:assert>
			<sch:assert test="count(cac:PartyName) lt 2 ">  /doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyName element should be less than 2!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingSupplierParty_Party_PostalAddress">
		<sch:rule context="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress">
			<sch:assert test="exists(cac:Country) ">  /doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:CityName">
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:PostalZone">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingSupplierParty_Party_PostalAddress_Country">
		<sch:rule context="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country">
			<sch:assert test="exists(cbc:IdentificationCode) ">  /doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingSupplierParty_Party_PhysicalLocation">
		<sch:rule context="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingSupplierParty_Party_PhysicalLocation_Address">
		<sch:rule context="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address">
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:StreetName">
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:BuildingNumber">
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:CityName">
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:PostalZone">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingSupplierParty_Party_PhysicalLocation_Address_Country">
		<sch:rule context="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode">
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingSupplierParty_Party_PartyTaxScheme_TaxScheme">
		<sch:rule context="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme/cbc:ID">
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingSupplierParty_Party_Person">
		<sch:rule context="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:Person/cbc:FamilyName">
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:Person">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingCustomerParty_Party_PostalAddress">
		<sch:rule context="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress">
			<sch:assert test="exists(cac:Country) ">  /doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:CityName">
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:PostalZone">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingCustomerParty_Party_PostalAddress_Country">
		<sch:rule context="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country">
			<sch:assert test="exists(cbc:IdentificationCode) ">  /doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingCustomerParty_Party_PhysicalLocation">
		<sch:rule context="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingCustomerParty_Party_PhysicalLocation_Address">
		<sch:rule context="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address">
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:StreetName">
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:BuildingNumber">
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:CityName">
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:PostalZone">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingCustomerParty_Party_PhysicalLocation_Address_Country">
		<sch:rule context="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode">
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_SellerSupplierParty_Party">
		<sch:rule context="/doc:Invoice/cac:SellerSupplierParty/cac:Party">
			<sch:assert test="exists(cac:PartyIdentification) ">  /doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification element should exist!</sch:assert>
			<sch:assert test="exists(cac:PartyName) ">  /doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyName element should exist!</sch:assert>
			<sch:assert test="count(cac:PartyName) lt 2 ">  /doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyName element should be less than 2!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification">
			<sch:assert test="not(empty(cbc:ID))">  /doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID element should not be empty!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyName">
			<sch:assert test="not(empty(cbc:Name))">  /doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyName/cbc:Name element should not be empty!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:Contact">
			<sch:assert test="matches(cbc:Telephone, '^[-0-9]*$')">  Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</sch:assert>
			<sch:assert test="matches(cbc:Telefax, '^[-0-9]*$')">  Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_SellerSupplierParty_Party_PartyIdentification">
		<sch:rule context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID">
			<sch:assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">  Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</sch:assert>
			<sch:assert test="(@schemeAgencyName  = 'KvK') or (@schemeAgencyName  = 'BTW') or (@schemeAgencyName = 'Fi') or (@schemeAgencyName  = 'BSN') or (@schemeAgencyName  = 'OIN') or (@schemeAgencyName  = 'XXX')">  Uitgevende organisatie van de PartijIdentificatie MOET ge?dentificeerd worden door een code uit de lijst: KvK, BTW, Fi, BSN, OIN, XXX.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_SellerSupplierParty_Party_PostalAddress">
		<sch:rule context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress">
			<sch:assert test="exists(cac:Country) ">  /doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country element should exist!</sch:assert>
			<sch:assert test="exists(cbc:CityName) ">  /doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:CityName element should exist!</sch:assert>
			<sch:assert test="exists(cbc:PostalZone) ">  /doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:PostalZone element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:CityName">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:CityName element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:PostalZone">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:PostalZone element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_SellerSupplierParty_Party_PostalAddress_Country">
		<sch:rule context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country">
			<sch:assert test="exists(cbc:IdentificationCode) ">  /doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_SellerSupplierParty_Party_PhysicalLocation">
		<sch:rule context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_SellerSupplierParty_Party_PhysicalLocation_Address">
		<sch:rule context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address">
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:StreetName">
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:BuildingNumber">
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:CityName">
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:PostalZone">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_SellerSupplierParty_Party_PhysicalLocation_Address_Country">
		<sch:rule context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode">
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_SellerSupplierParty_Party_PartyTaxScheme">
		<sch:rule context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID">
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyTaxScheme">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_SellerSupplierParty_Party_Person">
		<sch:rule context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:Person/cbc:FamilyName">
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:Person">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_BuyerCustomerParty_Party">
		<sch:rule context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party">
			<sch:assert test="exists(cac:PartyIdentification) ">  /doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification element should exist!</sch:assert>
			<sch:assert test="exists(cac:PartyName) ">  /doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyName element should exist!</sch:assert>
			<sch:assert test="count(cac:PartyName) lt 2 ">  /doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyName element should be less than 2!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification">
			<sch:assert test="not(empty(cbc:ID))">  /doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID element should not be empty!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyName">
			<sch:assert test="not(empty(cbc:Name))">  /doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyName/cbc:Name element should not be empty!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:Contact">
			<sch:assert test="matches(cbc:Telephone, '^[-0-9]*$')">  Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</sch:assert>
			<sch:assert test="matches(cbc:Telefax, '^[-0-9]*$')">  Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_BuyerCustomerParty_Party_PartyIdentification">
		<sch:rule context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID">
			<sch:assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">  Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</sch:assert>
			<sch:assert test="(@schemeAgencyName  = 'KvK') or (@schemeAgencyName  = 'BTW') or (@schemeAgencyName = 'Fi') or (@schemeAgencyName  = 'BSN') or (@schemeAgencyName  = 'OIN') or (@schemeAgencyName  = 'XXX')">  Uitgevende organisatie van de PartijIdentificatie MOET ge?dentificeerd worden door een code uit de lijst: KvK, BTW, Fi, BSN, OIN, XXX.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_BuyerCustomerParty_Party_PostalAddress">
		<sch:rule context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress">
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:CityName">
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cbc:PostalZone">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_BuyerCustomerParty_Party_PostalAddress_Country">
		<sch:rule context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode">
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_BuyerCustomerParty_Party_PhysicalLocation">
		<sch:rule context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_BuyerCustomerParty_Party_PhysicalLocation_Address">
		<sch:rule context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address">
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:StreetName">
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:BuildingNumber">
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:CityName">
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cbc:PostalZone">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_BuyerCustomerParty_Party_PhysicalLocation_Address_Country">
		<sch:rule context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode">
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_BuyerCustomerParty_Party_PartyTaxScheme">
		<sch:rule context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID">
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyTaxScheme">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_BuyerCustomerParty_Party_Person">
		<sch:rule context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:Person/cbc:FamilyName">
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:Person">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_PaymentMeans_PayeeFinancialAccount">
		<sch:rule context="/doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:ID">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:ID element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount">
			<sch:assert test="exists(cbc:ID) ">  /doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:ID element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_PaymentMeans_PayeeFinancialAccount_FinancialInstitutionBranch">
		<sch:rule context="/doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch">
			<sch:assert test="exists(cac:FinancialInstitution) ">  /doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_PaymentMeans_PayeeFinancialAccount_FinancialInstitutionBranch_FinancialInstitution">
		<sch:rule context="/doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution">
			<sch:assert test="exists(cbc:ID) ">  /doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_PaymentTerms">
		<sch:rule context="/doc:Invoice/cac:PaymentTerms">
			<sch:assert test="count(cbc:Note) lt 2 ">  /doc:Invoice/cac:PaymentTerms/cbc:Note element should be less than 2!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_PaymentTerms_SettlementPeriod">
		<sch:rule context="/doc:Invoice/cac:PaymentTerms/cac:SettlementPeriod/cbc:DurationMeasure">
			<sch:assert test="string-length(@unitCode) > 0 ">  /doc:Invoice/cac:PaymentTerms/cac:SettlementPeriod/cbc:DurationMeasure/@unitCode element should exist!</sch:assert>
			<sch:assert test="exists(@unitCode)">  /doc:Invoice/cac:PaymentTerms/cac:SettlementPeriod/cbc:DurationMeasure/@unitCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:PaymentTerms/cac:SettlementPeriod">
			<sch:assert test="count(cbc:Description) lt 2 ">  /doc:Invoice/cac:PaymentTerms/cac:SettlementPeriod/cbc:Description element should be less than 2!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_PaymentTerms_PenaltyPeriod">
		<sch:rule context="/doc:Invoice/cac:PaymentTerms/cac:PenaltyPeriod/cbc:EndDate">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Invoice/cac:PaymentTerms/cac:PenaltyPeriod/cbc:EndDate element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:PaymentTerms/cac:PenaltyPeriod">
			<sch:assert test="exists(cbc:EndDate) ">  /doc:Invoice/cac:PaymentTerms/cac:PenaltyPeriod/cbc:EndDate element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_TaxTotal">
		<sch:rule context="/doc:Invoice/cac:TaxTotal">
			<sch:assert test="exists(cac:TaxSubtotal) ">  /doc:Invoice/cac:TaxTotal/cac:TaxSubtotal element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_TaxTotal_TaxSubtotal">
		<sch:rule context="/doc:Invoice/cac:TaxTotal/cac:TaxSubtotal/cbc:TaxableAmount">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Invoice/cac:TaxTotal/cac:TaxSubtotal/cbc:TaxableAmount element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:TaxTotal/cac:TaxSubtotal">
			<sch:assert test="exists(cbc:TaxableAmount) ">  /doc:Invoice/cac:TaxTotal/cac:TaxSubtotal/cbc:TaxableAmount element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_LegalMonetaryTotal">
		<sch:rule context="/doc:Invoice/cac:LegalMonetaryTotal/cbc:LineExtensionAmount">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Invoice/cac:LegalMonetaryTotal/cbc:LineExtensionAmount element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:LegalMonetaryTotal/cbc:TaxExclusiveAmount">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Invoice/cac:LegalMonetaryTotal/cbc:TaxExclusiveAmount element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:LegalMonetaryTotal">
			<sch:assert test="exists(cbc:LineExtensionAmount) ">  /doc:Invoice/cac:LegalMonetaryTotal/cbc:LineExtensionAmount element should exist!</sch:assert>
			<sch:assert test="exists(cbc:TaxExclusiveAmount) ">  /doc:Invoice/cac:LegalMonetaryTotal/cbc:TaxExclusiveAmount element should exist!</sch:assert>
			<sch:assert test="exists(cbc:TaxInclusiveAmount) ">  /doc:Invoice/cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_InvoiceLine">
		<sch:rule context="/doc:Invoice/cac:InvoiceLine">
			<sch:assert test="count(cac:OrderLineReference) lt 2 ">  /doc:Invoice/cac:InvoiceLine/cac:OrderLineReference element should be less than 2!</sch:assert>
			<sch:assert test="exists(cac:Price) ">  /doc:Invoice/cac:InvoiceLine/cac:Price element should exist!</sch:assert>
			<sch:assert test="exists(cbc:InvoicedQuantity) ">  /doc:Invoice/cac:InvoiceLine/cbc:InvoicedQuantity element should exist!</sch:assert>
			<sch:assert test="exists(cbc:FreeOfChargeIndicator) ">  /doc:Invoice/cac:InvoiceLine/cbc:FreeOfChargeIndicator element should exist!</sch:assert>
			<sch:assert test="count(cac:TaxTotal) lt 2 ">  /doc:Invoice/cac:InvoiceLine/cac:TaxTotal element should be less than 2!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:InvoiceLine/cbc:InvoicedQuantity">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Invoice/cac:InvoiceLine/cbc:InvoicedQuantity element should exist!</sch:assert>
			<sch:assert test="string-length(@unitCode) > 0 ">  /doc:Invoice/cac:InvoiceLine/cbc:InvoicedQuantity/@unitCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:InvoiceLine/cbc:FreeOfChargeIndicator">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Invoice/cac:InvoiceLine/cbc:FreeOfChargeIndicator element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:InvoiceLine/cac:Item">
			<sch:assert test="( (count(cbc:Description) = 0) and (   (count(cac:BuyersItemIdentification/cbc:ID) + count(cac:SellersItemIdentification/cbc:ID) + count(cac:ManufacturersItemIdentification/cbc:ID) + count(cac:StandardItemIdentification/cbc:ID) + count(cac:CatalogueItemIdentification/cbc:ID)) > 0 ))or( (count(cbc:Description) > 0) and (   (count(cac:BuyersItemIdentification/cbc:ID) + count(cac:SellersItemIdentification/cbc:ID) + count(cac:ManufacturersItemIdentification/cbc:ID) + count(cac:StandardItemIdentification/cbc:ID) + count(cac:CatalogueItemIdentification/cbc:ID)) = 0 ))">  Item MOET OF een Description OF een (party)Identification/ID bevatten.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_Delivery">
		<sch:rule context="/doc:Invoice">
			<sch:assert test="(
 (count(cac:Delivery/cbc:ActualDeliveryDate) = 0) and
 (
   (count(cac:InvoiceLine/cac:Delivery/cbc:ActualDeliveryDate) ) > 0
 )
)
or
(
 (count(cac:Delivery/cbc:ActualDeliveryDate) > 0) and
 (
   (count(cac:InvoiceLine/cac:Delivery/cbc:ActualDeliveryDate) ) = 0
 )
)
">  Bericht MOET OF een ActualDeliveryDate op documentniveau OF op regelniveau bevatten.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_InvoiceLine_OrderLineReference">
		<sch:rule context="/doc:Invoice/cac:InvoiceLine/cac:OrderLineReference/cbc:LineID">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Invoice/cac:InvoiceLine/cac:OrderLineReference/cbc:LineID element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:InvoiceLine/cac:OrderLineReference">
			<sch:assert test="exists(cac:OrderReference) ">  /doc:Invoice/cac:InvoiceLine/cac:OrderLineReference/cac:OrderReference element should exist!</sch:assert>
			<sch:assert test="exists(cbc:LineID) ">  /doc:Invoice/cac:InvoiceLine/cac:OrderLineReference/cbc:LineID element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_InvoiceLine_AllowanceCharge">
		<sch:rule context="/doc:Invoice/cac:InvoiceLine/cac:AllowanceCharge/cbc:BaseAmount">
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:InvoiceLine/cac:AllowanceCharge">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_InvoiceLine_TaxTotal">
		<sch:rule context="/doc:Invoice/cac:InvoiceLine/cac:TaxTotal">
			<sch:assert test="exists(cac:TaxSubtotal) ">  /doc:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_InvoiceLine_TaxTotal_TaxSubtotal">
		<sch:rule context="/doc:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cbc:TaxableAmount">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cbc:TaxableAmount element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal">
			<sch:assert test="exists(cbc:TaxableAmount) ">  /doc:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cbc:TaxableAmount element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_InvoiceLine_Item">
		<sch:rule context="/doc:Invoice/cac:InvoiceLine/cac:Item">
			<sch:assert test="count(cbc:Description) lt 2 ">  /doc:Invoice/cac:InvoiceLine/cac:Item/cbc:Description element should be less than 2!</sch:assert>
			<sch:assert test="exists(cbc:CatalogueIndicator) ">  /doc:Invoice/cac:InvoiceLine/cac:Item/cbc:CatalogueIndicator element should exist!</sch:assert>
			<sch:assert test="exists(cbc:Name) ">  /doc:Invoice/cac:InvoiceLine/cac:Item/cbc:Name element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:InvoiceLine/cac:Item/cbc:CatalogueIndicator">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Invoice/cac:InvoiceLine/cac:Item/cbc:CatalogueIndicator element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:InvoiceLine/cac:Item/cbc:Name">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Invoice/cac:InvoiceLine/cac:Item/cbc:Name element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_InvoiceLine_Price">
		<sch:rule context="/doc:Invoice/cac:InvoiceLine/cac:Price/cbc:BaseQuantity">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Invoice/cac:InvoiceLine/cac:Price/cbc:BaseQuantity element should exist!</sch:assert>
			<sch:assert test="string-length(@unitCode) > 0 ">  /doc:Invoice/cac:InvoiceLine/cac:Price/cbc:BaseQuantity/@unitCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:InvoiceLine/cac:Price/cbc:PriceAmount">
			<sch:assert test="(count(../../../cbc:PricingCurrencyCode) = 0)or( (count(../../../cbc:PricingCurrencyCode) > 0) and (@currencyID = ../../../cbc:PricingCurrencyCode/text()))">  Valutacode op regelniveau MOET gelijk zijn aan algemeen niveau als opgegeven.</sch:assert>
			<sch:assert test="not(empty(@currencyID))">  /doc:Invoice/cac:InvoiceLine/cac:Price/cbc:PriceAmount/@currencyID element should not be empty!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:InvoiceLine/cac:Price">
			<sch:assert test="exists(cbc:BaseQuantity) ">  /doc:Invoice/cac:InvoiceLine/cac:Price/cbc:BaseQuantity element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_TaxTotal_TaxSubtotal_TaxCategory_TaxScheme">
		<sch:rule context="/doc:Invoice/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:Name">
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
			<sch:assert test="(cbc:Name = 'BTW') or (cbc:Name = 'Accijns') or (cbc:Name = 'Toeslag') or (cbc:Name = 'Overige')">  De soort belasting/heffing MOET ge?dentificeerd worden met een code uit de lijst: BTW, Accijns, Toeslag, Overige.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_InvoiceLine_Item_ClassifiedTaxCategory_TaxScheme">
		<sch:rule context="/doc:Invoice/cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme/cbc:Name">
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme">
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_InvoiceLine_TaxTotal_TaxSubtotal_TaxCategory_TaxScheme">
		<sch:rule context="/doc:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:Name">
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
			<sch:assert test=" (cbc:Name = 'BTW') or (cbc:Name = 'Accijns') or (cbc:Name = 'Toeslag') or (cbc:Name = 'Overige')">  De soort belasting/heffing MOET ge?dentificeerd worden met een code uit de lijst: BTW, Accijns, Toeslag, Overige.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_PaymentMeans">
		<sch:rule context="/doc:Invoice/cac:PaymentMeans/cbc:PaymentMeansCode">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Invoice/cac:PaymentMeans/cbc:PaymentMeansCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_BuyerCustomerParty">
		<sch:rule context="/doc:Invoice/cac:BuyerCustomerParty">
			<sch:assert test="exists(cac:Party) ">  Element MOET worden opgenomen, bevat verplichte bedrijfsidentificatienummer, bedrijfsnaam en opdrachtgever.</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party">
			<sch:assert test="count(cac:PartyIdentification) lt 3">  /doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification element should be less than 3!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_BuyerCustomerParty_Party_Contact">
		<sch:rule context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:Contact/cbc:Name">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:Contact/cbc:Name element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:Contact">
			<sch:assert test="exists(cbc:Name) ">  /doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:Contact/cbc:Name element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_Delivery_DeliveryAddress">
		<sch:rule context="/doc:Invoice/cac:Delivery/cac:DeliveryAddress">
			<sch:assert test="exists(cac:Country) ">  /doc:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_Delivery_DeliveryAddress_Country">
		<sch:rule context="/doc:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country">
			<sch:assert test="exists(cbc:IdentificationCode) ">  /doc:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_PaymentMeans_PayeeFinancialAccount_FinancialInstitutionBranch_Address">
		<sch:rule context="/doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address">
			<sch:assert test="exists(cac:Country) ">  /doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_PaymentMeans_PayeeFinancialAccount_FinancialInstitutionBranch_Address_Country">
		<sch:rule context="/doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country">
			<sch:assert test="exists(cbc:IdentificationCode) ">  /doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_SellerSupplierParty_Party_Contact">
		<sch:rule context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:Contact">
			<sch:assert test="exists(cbc:Name) ">  /doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_DeliveryTerms">
		<sch:rule context="/doc:Invoice/cac:DeliveryTerms/cbc:ID">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Invoice/cac:DeliveryTerms/cbc:ID element should exist!</sch:assert>
			<sch:assert test="normalize-space (@schemeID ) = 'NL-1002' ">  Inhoud MOET verwijzen naar: NL-1002</sch:assert>
			<sch:assert test="normalize-space (@schemeAgencyID) = xs:string(88)">  Inhoud MOET verwijzen naar: 88</sch:assert>
			<sch:assert test="normalize-space (@schemeAgencyName)  = 'Logius Gegevensbeheer NL-Overheid'">  Inhoud MOET verwijzen naar: Logius Gegevensbeheer NL-Overheid</sch:assert>
			<sch:assert test="normalize-space (@schemeDataURI)  = 'urn:digi-inkoop:ubl:2.0:NL:1.6:gc:DeliveryTermsCode'">  Inhoud MOET verwijzen naar: urn:digi-inkoop:ubl:2.0:NL:1.6:gc:DeliveryTermsCode</sch:assert>
			<sch:assert test="normalize-space(@schemeURI ) = 'http://www.nltaxonomie.nl/ubl/2.0/NL/1.6/cl/gc/DeliveryTermsCode.gc' ">  Inhoud MOET verwijzen naar: http://www.nltaxonomie.nl/ubl/2.0/NL/1.6/cl/gc/DeliveryTermsCode.gc</sch:assert>
			<sch:assert test="normalize-space (@schemeName) = 'DeliveryTermsCode' ">  Inhoud MOET verwijzen naar: DeliveryTermsCode</sch:assert>
			<sch:assert test="normalize-space (@schemeVersionID) = xs:string(1.6)">  Inhoud MOET verwijzen naar: 1.6</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:DeliveryTerms">
			<sch:assert test="exists(cbc:ID) ">  /doc:Invoice/cac:DeliveryTerms/cbc:ID element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_SellerSupplierParty">
		<sch:rule context="/doc:Invoice/cac:SellerSupplierParty/cac:Party">
			<sch:assert test="count(cac:PartyIdentification) lt 3">  /doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification element should be less than 3!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_PaymentMeans_PayeeFinancialAccount_Country">
		<sch:rule context="/doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country">
			<sch:assert test="exists(cbc:IdentificationCode) ">  /doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingSupplierParty_Party_PartyIdentification">
		<sch:rule context="/doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID">
			<sch:assert test="(@schemeAgencyName  = 'KvK') or (@schemeAgencyName  = 'BTW') or (@schemeAgencyName = 'Fi') or (@schemeAgencyName  = 'BSN') or (@schemeAgencyName  = 'OIN') or (@schemeAgencyName  = 'XXX')">  Uitgevende organisatie van de PartijIdentificatie MOET ge?dentificeerd worden door een code uit de lijst: KvK, BTW, Fi, BSN, OIN, XXX.</sch:assert>
			<sch:assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">  Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_InvoiceLine_Item_ClassifiedTaxCategory">
		<sch:rule context="/doc:Invoice/cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme">
			<sch:assert test="(cbc:Name = 'BTW') or (cbc:Name = 'Accijns') or (cbc:Name = 'Toeslag') or (cbc:Name = 'Overige')">  De soort belasting/heffing MOET ge?dentificeerd worden met een code uit de lijst: BTW, Accijns, Toeslag, Overige.</sch:assert>
		</sch:rule>
	</sch:pattern>
</sch:schema>