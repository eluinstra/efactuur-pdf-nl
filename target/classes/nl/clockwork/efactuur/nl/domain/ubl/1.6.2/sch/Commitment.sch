<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns="http://purl.oclc.org/dsdl/schematron"
	xmlns:sch="http://purl.oclc.org/dsdl/schematron"
	xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
	xmlns:qdt="urn:oasis:names:specification:ubl:schema:xsd:QualifiedDataTypes-2"
	xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
	xmlns:nl-cac="urn:digi-inkoop:ubl:2.0:NL:1.6:UBL-NL-CommonAggregateComponents-2"
	xmlns:ccts="urn:oasis:names:specification:ubl:schema:xsd:CoreComponentParameters-2"
	xmlns:doc="urn:digi-inkoop:ubl:2.0:NL:1.6:UBL-NL-Commitment-2"
	queryBinding="xslt2"
	schemaVersion="ISO19757-3"
>
<sch:ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" />
<sch:ns prefix="qdt" uri="urn:oasis:names:specification:ubl:schema:xsd:QualifiedDataTypes-2" />
<sch:ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" />
<sch:ns prefix="nl-cac" uri="urn:digi-inkoop:ubl:2.0:NL:1.6:UBL-NL-CommonAggregateComponents-2" />
<sch:ns prefix="ccts" uri="urn:oasis:names:specification:ubl:schema:xsd:CoreComponentParameters-2" />
<sch:ns prefix="doc" uri="urn:digi-inkoop:ubl:2.0:NL:1.6:UBL-NL-Commitment-2" />
	<sch:pattern id="Commitment">
		<sch:rule context="/doc:Commitment">
			<sch:assert test="every $id in //cac:PartyIdentification/cbc:ID satisfies (exists($id/@schemeAgencyID) and not(empty($id/@schemeAgencyID)) and exists($id/@schemeAgencyName) and not(empty($id/@schemeAgencyName)))">  PartyIdentification/ID MOET @schemeAgencyID en @schemeAgencyName attributen bevatten.</sch:assert>
			<sch:assert test="every $bn in //cbc:BuildingNumber satisfies (matches($bn,'^\d+(-[ \w]+)?$'))">  Huisnummer en Huisnummertoevoeging moeten achter elkaar geplaatst worden, gescheiden met een koppelteken.</sch:assert>
			<sch:assert test="every $pa in //cac:PostalAddress satisfies (
(not(empty($pa/cbc:Postbox)) and empty($pa/cbc:StreetName) and empty($pa/cbc:BuildingNumber) and empty(cbc:Room) and empty(cbc:Floor) and empty(cbc:Department) and empty(cbc:InhouseMail) and empty(cbc:PlotIdentification))
 or 
(empty($pa/cbc:Postbox) and (not(empty($pa/cbc:StreetName)) or not(empty($pa/cbc:BuildingNumber)) or not(empty(cbc:Room)) or not(empty(cbc:Floor)) or not(empty(cbc:Department)) or not(empty(cbc:InhouseMail)) or not(empty(cbc:PlotIdentification))))
)">  PostalAddress MOET OF een Postbox bevatten OF minimaal 1 van de elementen StreetName, BuildingNumber, Room, Floor, Department, InhouseMail of PlotIdentification. Beide MAG NIET.</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Commitment/cbc:UBLVersionID">
			<sch:assert test="normalize-space(text()) = '2.0'">  Het bericht MOET gebaseerd zijn op UBL Versie 2.0</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Commitment/cbc:CustomizationID">
			<sch:assert test="normalize-space(text()) = '1.6'">  Bericht MOET gebaseerd zijn op versie 1.6 van de Nederlandse specificatie.</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Commitment/cbc:ProfileID">
			<sch:assert test="normalize-space(text()) = 'NL'">  Bericht MOET gebaseerd zijn op de Nederlande (NL) specificatie.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Commitment_OrderDocumentReference_Attachment">
		<sch:rule context="/doc:Commitment/cac:OrderDocumentReference/cac:Attachment">
			<sch:assert test="exists(cbc:EmbeddedDocumentBinaryObject) ">  /doc:Commitment/cac:OrderDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Commitment/cac:OrderDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject">
			<sch:assert test="string-length(@mimeCode) > 0 ">  /doc:Commitment/cac:OrderDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject/@mimeCode element should exist!</sch:assert>
			<sch:assert test="string-length(text()) > 0 ">  /doc:Commitment/cac:OrderDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Commitment_SellerSupplierParty">
		<sch:rule context="/doc:Commitment/cac:SellerSupplierParty">
			<sch:assert test="exists(cac:Party) ">  /doc:Commitment/cac:SellerSupplierParty/cac:Party element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Commitment_SellerSupplierParty_Party">
		<sch:rule context="/doc:Commitment/cac:SellerSupplierParty/cac:Party">
			<sch:assert test="count(cac:PartyName) lt 2 ">  /doc:Commitment/cac:SellerSupplierParty/cac:Party/cac:PartyName element should be less than 2!</sch:assert>
			<sch:assert test="count(cac:PartyIdentification) lt 3 ">  /doc:Commitment/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification element should be less than 3!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Commitment_SellerSupplierParty_Party_PartyIdentification">
		<sch:rule context="/doc:Commitment/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID">
			<sch:assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">  Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</sch:assert>
			<sch:assert test="(@schemeAgencyName  = 'KvK') or (@schemeAgencyName  = 'BTW') or (@schemeAgencyName = 'Fi') or (@schemeAgencyName  = 'BSN') or (@schemeAgencyName  = 'OIN') or (@schemeAgencyName  = 'XXX')">  /doc:Commitment/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID/@schemeAgencyName element sUitgevende organisatie van de PartijIdentificatie MOET ge?dentificeerd worden door een code uit de lijst: KvK, BTW, Fi, BSN, OIN, XXX.hould exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Commitment_AccountingCustomerParty">
		<sch:rule context="/doc:Commitment/cac:AccountingCustomerParty">
			<sch:assert test="exists(cac:Party) ">  /doc:Commitment/cac:AccountingCustomerParty/cac:Party element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Commitment_AccountingCustomerParty_Party">
		<sch:rule context="/doc:Commitment/cac:AccountingCustomerParty/cac:Party">
			<sch:assert test="count(cac:PartyName) lt 2 ">  /doc:Commitment/cac:AccountingCustomerParty/cac:Party/cac:PartyName element should be less than 2!</sch:assert>
			<sch:assert test="count(cac:PartyIdentification) lt 3 ">  /doc:Commitment/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification element should be less than 3!</sch:assert>
			<sch:assert test="exists(cac:PartyIdentification) ">  /doc:Commitment/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Commitment_AccountingCustomerParty_Party_PartyIdentification">
		<sch:rule context="/doc:Commitment/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID">
			<sch:assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">  Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</sch:assert>
			<sch:assert test="(@schemeAgencyName  = 'KvK') or (@schemeAgencyName  = 'BTW') or (@schemeAgencyName = 'Fi') or (@schemeAgencyName  = 'BSN') or (@schemeAgencyName  = 'OIN') or (@schemeAgencyName  = 'XXX')">  Uitgevende organisatie van de PartijIdentificatie MOET ge?dentificeerd worden door een code uit de lijst: KvK, BTW, Fi, BSN, OIN, XXX.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Commitment_TaxTotal_TaxSubtotal_TaxCategory">
		<sch:rule context="/doc:Commitment/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
			<sch:assert test="(cbc:Name = 'BTW') or (cbc:Name = 'Accijns') or (cbc:Name = 'Toeslag') or (cbc:Name = 'Overige')">  De soort belasting/heffing MOET ge?dentificeerd worden met een code uit de lijst: BTW, Accijns, Toeslag, Overige.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Commitment_TaxTotal_TaxSubtotal_TaxCategory_TaxScheme">
		<sch:rule context="/doc:Commitment/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
			<sch:assert test="exists(cbc:Name) ">  /doc:Commitment/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:Name element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Commitment/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:Name">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Commitment/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:Name element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Commitment_CommitmentLine_LineItem">
		<sch:rule context="/doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cbc:Quantity">
			<sch:assert test="string-length(@unitCode) > 0 ">  /doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cbc:Quantity/@unitCode element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cbc:Quantity">
			<sch:assert test="string-length(@unitCode) > 0 ">  /doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cbc:Quantity/@unitCode element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Commitment_CommitmentLine_LineItem_AccountingCost">
		<sch:rule context="/doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cbc:AccountingCost">
			<sch:assert test="matches(text(),'^[^@]*[@][^@]*$|^$')">  /doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cbc:AccountingCost element MOET exact 1 @-teken bevatten als het niet leeg is!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Commitment_CommitmentLine_LineItem_Delivery_RequestedDeliveryPeriod">
		<sch:rule context="/doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Delivery/cac:RequestedDeliveryPeriod">
			<sch:assert test="exists(cbc:EndDate) ">  /doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Delivery/cac:RequestedDeliveryPeriod/cbc:EndDate element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Delivery/cac:RequestedDeliveryPeriod/cbc:EndDate">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Delivery/cac:RequestedDeliveryPeriod/cbc:EndDate element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Commitment_CommitmentLine_LineItem_Item">
		<sch:rule context="/doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Item">
			<sch:assert test="exists(cbc:CatalogueIndicator) ">  /doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Item/cbc:CatalogueIndicator element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Item/cbc:CatalogueIndicator">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Item/cbc:CatalogueIndicator element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Commitment_CommitmentLine_LineItem_Item_ClassifiedTaxCategory">
		<sch:rule context="/doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme">
			<sch:assert test="(cbc:Name = 'BTW') or (cbc:Name = 'Accijns') or (cbc:Name = 'Toeslag') or (cbc:Name = 'Overige')">  De soort belasting/heffing MOET ge?dentificeerd worden met een code uit de lijst: BTW, Accijns, Toeslag, Overige.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Commitment_CommitmentLine_LineItem_Item_ClassifiedTaxCategory_TaxScheme">
		<sch:rule context="/doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme">
			<sch:assert test="exists(cbc:Name) ">  /doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme/cbc:Name element should exist!</sch:assert>
		</sch:rule>
		<sch:rule context="/doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme/cbc:Name">
			<sch:assert test="string-length(text()) > 0 ">  /doc:Commitment/nl-cac:CommitmentLine/cac:LineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme/cbc:Name element should exist!</sch:assert>
		</sch:rule>
	</sch:pattern>
</sch:schema>