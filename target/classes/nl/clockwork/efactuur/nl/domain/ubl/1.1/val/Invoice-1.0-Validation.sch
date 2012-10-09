<?xml version="1.0" encoding="UTF-8"?>
<sch:schema queryBinding="xslt2"
	xmlns:sch="http://purl.oclc.org/dsdl/schematron" 
	xmlns:nl-inv-val="http://www.nltaxonomie.nl/ubl/2.0/NL/1.0/val/Invoice-1.0-Validation" 
	xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" 
	xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2">
	<sch:title>NL-UBL-Invoice-1.0-Validations</sch:title>
	<sch:ns prefix="nl-inv-val" uri="http://www.nltaxonomie.nl/ubl/2.0/NL/1.0/val/Invoice-1.0-Validation"/>
	<sch:ns prefix="nl-inv" uri="http://www.nltaxonomie.nl/ubl/2.0/NL/1.0/xsd/maindoc/UBL-NL-Invoice"/>
	<sch:ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"/>
	<sch:ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"/>
	<sch:pattern id="Invoice_root">
		<sch:title>Validations on root level</sch:title>
		<sch:rule context="/nl-inv:Invoice">
			<sch:assert test="normalize-space(cbc:UBLVersionID) = '2.0' ">Element MOET de waarde 2.0 bevatten.</sch:assert>
			<sch:assert test="not(exists(cbc:UBLVersionID/@schemeID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:UBLVersionID/@schemeName))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:UBLVersionID/@schemeAgencyID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:UBLVersionID/@schemeAgencyName))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:UBLVersionID/@schemeVersionID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:UBLVersionID/@schemeDateURI))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:UBLVersionID/@schemeURI))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="normalize-space(cbc:CustomizationID) = '1.0' ">Element MOET de waarde 1.0 bevatten.</sch:assert>
			<sch:assert test="not(exists(cbc:CustomizationID/@schemeID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CustomizationID/@schemeName))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CustomizationID/@schemeAgencyID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CustomizationID/@schemeAgencyName))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CustomizationID/@schemeVersionID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CustomizationID/@schemeDateURI))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CustomizationID/@schemeURI))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="normalize-space(cbc:ProfileID) = 'NL'">Element MOET de waarde 'NL' bevatten.</sch:assert>
			<sch:assert test="not(exists(cbc:ProfileID/@schemeID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ProfileID/@schemeName))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ProfileID/@schemeAgencyID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ProfileID/@schemeAgencyName))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ProfileID/@schemeVersionID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ProfileID/@schemeDateURI))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ProfileID/@schemeURI))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="string-length(cbc:ID) &lt; 11">Element lengte MOET minder dan 11 posities zijn.</sch:assert>
			<sch:assert test="not(empty(cbc:ID))">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeName))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeAgencyID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeAgencyName))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeVersionID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeDateURI))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeURI))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="normalize-space(cbc:InvoiceTypeCode/@listAgencyName) = 'Logius Gegevensbeheer NL-Overheid' ">Attribuut MOET de waarde 'Logius Gegevensbeheer NL-Overheid' bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:InvoiceTypeCode/@listAgencyID) = xs:string(88) ">Attribuut MOET de waarde '88' bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:InvoiceTypeCode/@listName) = 'FactuurSoort' ">Attribuut MOET de waarde 'FactuurSoort' bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:InvoiceTypeCode/@listID) = 'NL-1001' ">Attribuut MOET de waarde 'NL-1001' bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:InvoiceTypeCode/@listSchemeURI) = 'http://www.nltaxonomie.nl/ubl/2.0/NL/1.0/cl/gc/NL-InvoiceCode' ">Attribuut MOET de waarde 'http://www.nltaxonomie.nl/ubl/2.0/NL/1.0/cl/gc/NL-InvoiceCode' bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:InvoiceTypeCode/@listURI) = 'http://www.nltaxonomie.nl/ubl/2.0/NL/1.0/cl/gc/NL-InvoiceCode-1.0.gc' ">Attribuut MOET de waarde ´http://www.nltaxonomie.nl/ubl/2.0/NL/1.0/cl/gc/NL-InvoiceCode-1.0.gc´ bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:InvoiceTypeCode/@listVersionID) = xs:string(0.1) ">Attribuut MOET de waarde '0.1' bevatten.</sch:assert>
			<sch:assert test="not(exists(cbc:InvoiceTypeCode/@name))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:InvoiceTypeCode/@languageID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:AccountingCostCode))">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:AccountingCostCode/@name))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:AccountingCostCode/@languageID))">Attribuut MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_InvoicePeriod">
		<sch:title>Validations on InvoicePeriod ABIE.</sch:title>
		<sch:rule context="/nl-inv:Invoice/cac:InvoicePeriod">
			<sch:assert test="not(empty(cbc:StartDate))">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:StartTime))">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:EndDate)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:EndTime)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:DurationMeasure)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:DescriptionCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Description)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_OrderReference">
		<sch:title>Validations on OrderReference ASBIE.</sch:title>
		<sch:rule context="/nl-inv:Invoice/cac:OrderReference">
			<sch:assert test="not(empty(cbc:ID)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeName))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeAgencyID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeAgencyName))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeVersionID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeDateURI))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeURI))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:SalesOrderID/@schemeID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:SalesOrderID/@schemeName))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:SalesOrderID/@schemeAgencyID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:SalesOrderID/@schemeAgencyName))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:SalesOrderID/@schemeVersionID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:SalesOrderID/@schemeDateURI))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:SalesOrderID/@schemeURI))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CopyIndicator)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:UUID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:IssueDate)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:IssueTime)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CustomerReference/@languageID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:DocumentReference)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_BillingReference">
		<sch:title>Validations on BillingReference ASBIE.</sch:title>
		<sch:rule context="/nl-inv:Invoice/cac:BillingReference">
			<sch:assert test="exists(cac:InvoiceDocumentReference) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:SelfBilledInvoiceDocumentReference)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:CreditNoteDocumentReference)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:SelfBilledCreditNoteDocumentReference)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:DebitNoteDocumentReference)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:ReminderDocumentReference)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:AdditionalDocumentReference)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:BillingReferenceLine)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_BillingReference_InvoiceDocumentReference">
		<sch:title>Validations on InvoiceDocumentReference ASBIE.</sch:title>
		<sch:rule context="/nl-inv:Invoice/cac:BillingReference/cac:InvoiceDocumentReference">
			<sch:assert test="not(empty(cbc:ID)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeName))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeAgencyID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeAgencyName))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeVersionID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeDateURI))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeURI))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CopyIndicator)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:UUID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:DocumentTypeCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:DocumentType)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:XPath)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:Attachment)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_ContractDocumentReference">
		<sch:title>Validations on ContractDocumentReference ASBIE.</sch:title>
		<sch:rule context="/nl-inv:Invoice/cac:ContractDocumentReference">
			<sch:assert test="not(empty(cbc:ID)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeName))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeAgencyID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeAgencyName))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeVersionID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeDateURI))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeURI))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CopyIndicator)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:UUID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:IssueDate)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:DocumentTypeCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:DocumentType)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:XPath)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:Attachment)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingSupplierParty">
		<sch:title>Validations on AccountingSupplierParty ASBIE.</sch:title>
		<sch:rule context="/nl-inv:Invoice/cac:AccountingSupplierParty">
			<sch:assert test="not(exists(cbc:CustomerAssignedAccountID/@schemeID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CustomerAssignedAccountID/@schemeName))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CustomerAssignedAccountID/@schemeAgencyID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CustomerAssignedAccountID/@schemeAgencyName))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CustomerAssignedAccountID/@schemeVersionID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CustomerAssignedAccountID/@schemeDateURI))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CustomerAssignedAccountID/@schemeURI))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:AdditionalAccountID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:DataSendingCapability)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cac:Party) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:DespatchContact)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:AccountingContact)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:SellerContact)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingSupplierParty_Party">
		<sch:title>Validations on Party ABIE.</sch:title>
		<sch:rule context="/nl-inv:Invoice/cac:AccountingSupplierParty/cac:Party">
			<sch:assert test="not(exists(cbc:MarkCareIndicator)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:MarkAttentionIndicator)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:WebSiteURI)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:LogoReferenceID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:EndPointID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cac:PartyIdentification) and count(cac:PartyIdentification) eq 1 ">Element MOET slechts éénmaal voorkomen.</sch:assert>
			<sch:assert test="exists(cac:PartyName) and count(cac:PartyName) eq 1 ">Element MOET slechts éénmaal voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:Language)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cac:PartyTaxScheme) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:PartyLegalEntity)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:AgentParty)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingSupplierParty_Party_PartyIdentification">
		<sch:title>Validations on PartyIdentification ASBIE.</sch:title>
		<sch:rule context="/nl-inv:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification">
			<sch:assert test="not(empty(cbc:ID)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeName))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:ID/@schemeAgencyName)) ">Attribuut MOET gevuld zijn, bevat 'Kamer van Koophandel' of 'Belastingdienst' voor NL bedrijven.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeVersionID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeDateURI))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeURI))">Attribuut MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingSupplierParty_Party_PartyName">
		<sch:title>Validations on PartyName ABIE.</sch:title>
		<sch:rule context="/nl-inv:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyName">
			<sch:assert test="not(empty(cbc:Name)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:Name/@languageID))">Attribuut MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingSupplierParty_Party_PostalAddress">
		<sch:title>Validations on PostalAddress ASBIE.</sch:title>
		<sch:rule context="/nl-inv:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress">
			<sch:assert test="not(exists(cbc:ID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:AddressTypeCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:AddressFormatCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:Postbox)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:Floor)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Room)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:StreetName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:AdditionalStreetName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:BlockName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:BuildingName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:BuildingNumber)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:InhouseMail)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Department)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:MarkAttention)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:MarkCare)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CitySubdivisionName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:CityName)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:CityName/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:PostalZone)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:PostalZone/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CountrySubentity)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CountrySubentityCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Region/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:District)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:AddressLine)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cac:Country) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:LocationCoordinate)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
		<sch:pattern id="Invoice_AccountingSupplierParty_Party_PostalAddress_Country">
		<sch:title>Validations on Country ABIE.</sch:title>
		<sch:rule context="/nl-inv:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country">
			<sch:assert test="not(empty(cbc:IdentificationCode)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listAgencyName) = 'United Nations Economic Commission for Europe' ">Attribuut MOET de waarde 'United Nations Economic Commission for Europe' bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listAgencyID) = '6' ">Attribuut MOET de waarde '6' bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listName) = 'Country' ">Attribuut MOET de waarde 'Country' bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listID) = 'ISO3166-1' ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listSchemeURI) = 'urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode-2.0' ">Attribuut MOET de waarde 'urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode-2.0' bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listURI) = 'http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc' ">Attribuut MOET de waarde ´http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc´ bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listVersionID) = '0.3' ">Attribuut MOET de waarde '0.3' bevatten.</sch:assert>
			<sch:assert test="not(exists(cbc:IdentificationCode/@name))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:IdentificationCode/@languageID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Name)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingSupplierParty_Party_PhysicalAddress">
		<sch:rule context="/nl-inv:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalAddress">
			<sch:assert test="not(exists(cbc:ID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Description)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Conditions)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CountrySubentity)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CountrySubentityCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:ValidityPeriod)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cac:Address) ">Element MOET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingSupplierParty_Party_PhysicalAddress_Address">
		<sch:rule context="/nl-inv:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalAddress/cac:Address">
			<sch:assert test="not(exists(cbc:ID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:AddressTypeCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:AddressFormatCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Postbox)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Floor)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Room)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:StreetName) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:StreetName)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:StreetName/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:AdditionalStreetName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:BlockName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:BuildingName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:BuildingNumber) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:BuildingNumber)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:BuildingNumber/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:InhouseMail)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Department)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:MarkAttention)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:MarkCare)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CitySubdivisionName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:CityName)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:CityName/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:PostalZone)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:PostalZone/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CountrySubentity)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CountrySubentityCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Region/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:District)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:AddressLine)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cac:Country) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:LocationCoordinate)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingSupplierParty_Party_PhysicalAddress_Address_Country">
		<sch:rule context="/nl-inv:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalAddress/cac:Address/cac:Country">
			<sch:assert test="not(empty(cbc:IdentificationCode)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listAgencyName) = 'United Nations Economic Commission for Europe' ">Attribuut MOET de waarde 'United Nations Economic Commission for Europe' bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listAgencyID) = '6' ">Attribuut MOET de waarde '6' bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listName) = 'Country' ">Attribuut MOET de waarde 'Country' bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listID) = 'ISO3166-1' ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listSchemeURI) = 'urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode-2.0' ">Attribuut MOET de waarde 'urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode-2.0' bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listURI) = 'http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc' ">Attribuut MOET de waarde ´http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc´ bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listVersionID) = '0.3' ">Attribuut MOET de waarde '0.3' bevatten.</sch:assert>
			<sch:assert test="not(exists(cbc:IdentificationCode/@name))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:IdentificationCode/@languageID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Name)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingSupplierParty_Party_PartyTaxScheme">
		<sch:rule context="/nl-inv:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme">
			<sch:assert test="not(exists(cbc:RegistrationName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:CompanyID)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:CompanyID/@schemeName))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CompanyID/@schemeVersionID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CompanyID/@schemeDateURI))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CompanyID/@schemeURI))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:TaxLevelCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ExemptionReasonCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ExemptionReason)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:RegistrationAddress)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingSupplierParty_Party_PartyTaxScheme_TaxScheme">
		<sch:rule context="/nl-inv:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme">
			<sch:assert test="exists(cbc:ID) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Name)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:TaxTypeCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CurrencyCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:JurisdictionAddress)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingSupplierParty_Party_Contact">
		<sch:rule context="/nl-inv:Invoice/cac:AccountingSupplierParty/cac:Party/cac:Contact">
			<sch:assert test="not(exists(cbc:ID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Name)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Telephone/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Telefax)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ElectronicMail/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Note)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:OtherCommunication)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingSupplierParty_Party_Person">
		<sch:rule context="/nl-inv:Invoice/cac:AccountingSupplierParty/cac:Party/cac:Person">
			<sch:assert test="not(exists(cbc:FirstName/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:FamilyName)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:FamilyName/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Title)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:MiddleName/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:NameSuffix)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:JobTitle)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:OrganizationDepartment)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingCustomerParty">
		<sch:rule context="/nl-inv:Invoice/cac:AccountingCustomerParty">
			<sch:assert test="not(exists(cbc:CustomerAssignedAccountID/@schemeID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CustomerAssignedAccountID/@schemeName))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CustomerAssignedAccountID/@schemeAgencyID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CustomerAssignedAccountID/@schemeAgencyName))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CustomerAssignedAccountID/@schemeVersionID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CustomerAssignedAccountID/@schemeDateURI))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CustomerAssignedAccountID/@schemeURI))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:AdditionalAccountID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:DataSendingCapability)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cac:Party) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:DespatchContact)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:AccountingContact)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:SellerContact)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingCustomerParty_Party">
		<sch:rule context="/nl-inv:Invoice/cac:AccountingCustomerParty/cac:Party">
			<sch:assert test="not(exists(cbc:MarkCareIndicator)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:MarkAttentionIndicator)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:WebSiteURI)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:LogoReferenceID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:EndPointID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cac:PartyIdentification) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="exists(cac:PartyName) and count(cac:PartyName) eq 1 ">Element MOET slechts éénmaal voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:Language)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cac:PartyTaxScheme) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:PartyLegalEntity)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:AgentParty)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingCustomerParty_Party_PartyIdentification">
		<sch:rule context="/nl-inv:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification">
			<sch:assert test="not(empty(cbc:ID)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeName))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:ID/@schemeAgencyID))">Attribuut MAG NIET leeg zijn.</sch:assert>
			<sch:assert test="not(empty(cbc:ID/@schemeAgencyName))">Attribuut MAG NIET leeg zijn, bevat 'Kamer van Koophandel' of 'Belastingdienst' voor NL bedrijven.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeVersionID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeDateURI))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeURI))">Attribuut MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingCustomerParty_Party_PartyName">
		<sch:rule context="/nl-inv:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyName">
			<sch:assert test="not(empty(cbc:Name)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:Name/@languageID))">Attribuut MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingCustomerParty_Party_PostalAddress">
		<sch:rule context="/nl-inv:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress">
			<sch:assert test="not(exists(cbc:ID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:AddressTypeCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:AddressFormatCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:Postbox)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:Floor)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Room)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:StreetName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:AdditionalStreetName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:BlockName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:BuildingName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:BuildingNumber)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:InhouseMail)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Department)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:MarkAttention)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:MarkCare)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:PlotIdentification)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CitySubdivisionName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:CityName)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:CityName/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:PostalZone)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:PostalZone/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CountrySubentity)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CountrySubentityCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Region/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:District)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:AddressLine)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cac:Country) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:LocationCoordinate)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingCustomerParty_Party_PostalAddress_Country">
		<sch:rule context="/nl-inv:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country">
			<sch:assert test="not(empty(cbc:IdentificationCode)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listAgencyName) = 'United Nations Economic Commission for Europe' ">Attribuut MOET de waarde 'United Nations Economic Commission for Europe' bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listAgencyID) = '6' ">Attribuut MOET de waarde '6' bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listName) = 'Country' ">Attribuut MOET de waarde 'Country' bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listID) = 'ISO3166-1' ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listSchemeURI) = 'urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode-2.0' ">Attribuut MOET de waarde 'urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode-2.0' bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listURI) = 'http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc' ">Attribuut MOET de waarde ´http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc´ bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listVersionID) = '0.3' ">Attribuut MOET de waarde '0.3' bevatten.</sch:assert>
			<sch:assert test="not(exists(cbc:IdentificationCode/@name))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:IdentificationCode/@languageID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Name)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingCustomerParty_Party_PhysicalAddress">
		<sch:rule context="/nl-inv:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalAddress">
			<sch:assert test="not(exists(cbc:ID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Description)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Conditions)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CountrySubentity)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CountrySubentityCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:ValidityPeriod)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cac:Address) ">Element MOET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingCustomerParty_Party_PhysicalAddress_Address">
		<sch:rule context="/nl-inv:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalAddress/cac:Address">
			<sch:assert test="not(exists(cbc:ID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:AddressTypeCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:AddressFormatCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Postbox)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Floor)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Room)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:StreetName) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:StreetName)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:StreetName/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:AdditionalStreetName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:BlockName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:BuildingName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:BuildingNumber) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:BuildingNumber)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:BuildingNumber/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:InhouseMail)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Department)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:MarkAttention)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:MarkCare)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:PlotIdentification)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CitySubdivisionName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:CityName)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:CityName/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:PostalZone)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:PostalZone/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CountrySubentity)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CountrySubentityCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Region/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:District)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:AddressLine)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cac:Country) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:LocationCoordinate)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingCustomerParty_Party_PhysicalLocation_Address_Country">
		<sch:rule context="/nl-inv:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country">
			<sch:assert test="not(empty(cbc:IdentificationCode)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listAgencyName) = 'United Nations Economic Commission for Europe' ">Attribuut MOET de waarde 'United Nations Economic Commission for Europe' bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listAgencyID) = '6' ">Attribuut MOET de waarde '6' bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listName) = 'Country' ">Attribuut MOET de waarde 'Country' bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listID) = 'ISO3166-1' ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listSchemeURI) = 'urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode-2.0' ">Attribuut MOET de waarde 'urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode-2.0' bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listURI) = 'http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc' ">Attribuut MOET de waarde ´http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc´ bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listVersionID) = '0.3' ">Attribuut MOET de waarde '0.3' bevatten.</sch:assert>
			<sch:assert test="not(exists(cbc:IdentificationCode/@name))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:IdentificationCode/@languageID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Name)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingCustomerParty_Party_PartyTaxScheme">
		<sch:rule context="/nl-inv:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme">
			<sch:assert test="not(exists(cbc:RegistrationName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:CompanyID)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:CompanyID/@schemeID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CompanyID/@schemeName))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CompanyID/@schemeAgencyID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="normalize-space(cbc:CompanyID/@schemeAgencyName) = 'Belastingdienst' ">Attribuut MOET de waarde 'Belastingdienst' bevatten.</sch:assert>
			<sch:assert test="not(exists(cbc:CompanyID/@schemeVersionID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CompanyID/@schemeDateURI))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CompanyID/@schemeURI))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:TaxLevelCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ExemptionReasonCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ExemptionReason)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:RegistrationAddress)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingCustomerParty_Party_PartyTaxScheme_TaxScheme">
		<sch:rule context="/nl-inv:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme">
			<sch:assert test="exists(cbc:ID) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Name)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:TaxTypeCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CurrencyCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:JurisdictionAddress)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingCustomerParty_Party_Contact">
		<sch:rule context="/nl-inv:Invoice/cac:AccountingCustomerParty/cac:Party/cac:Contact">
			<sch:assert test="not(exists(cbc:ID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Name)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Telephone/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Telefax)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ElectronicMail/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Note)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:OtherCommunication)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_AccountingCustomerParty_Party_Person">
		<sch:rule context="/nl-inv:Invoice/cac:AccountingCustomerParty/cac:Party/cac:Person">
			<sch:assert test="not(exists(cbc:FirstName/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:FamilyName)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:FamilyName/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Title)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:MiddleName/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:NameSuffix)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:JobTitle)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:OrganizationDepartment)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_SellerSupplierParty">
		<sch:rule context="/nl-inv:Invoice/cac:SellerSupplierParty">
			<sch:assert test="not(exists(cbc:CustomerAssignedAccountID/@schemeID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CustomerAssignedAccountID/@schemeName))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CustomerAssignedAccountID/@schemeAgencyID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CustomerAssignedAccountID/@schemeAgencyName))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CustomerAssignedAccountID/@schemeVersionID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CustomerAssignedAccountID/@schemeDateURI))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CustomerAssignedAccountID/@schemeURI))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:AdditionalAccountID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:DataSendingCapability)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:DespatchContact)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:AccountingContact)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:SellerContact)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_SellerSupplierParty_Party">
		<sch:rule context="/nl-inv:Invoice/cac:SellerSupplierParty/cac:Party">
			<sch:assert test="not(exists(cbc:MarkCareIndicator)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:MarkAttentionIndicator)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:WebSiteURI)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:LogoReferenceID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:EndPointID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cac:PartyIdentification) and count(cac:PartyIdentification) eq 1 ">Element MOET slechts éénmaal voorkomen.</sch:assert>
			<sch:assert test="exists(cac:PartyName) and count(cac:PartyName) eq 1 ">Element MOET slechts éénmaal voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:Language)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cac:PartyTaxScheme) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:PartyLegalEntity)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:AgentParty)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_SellerSupplierParty_Party_PartyIdentification">
		<sch:rule context="/nl-inv:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification">
			<sch:assert test="not(empty(cbc:ID)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeName))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:ID/@schemeAgencyName))">Attribuut MAG NIET leeg zijn, bevat 'Kamer van Koophandel' of 'Belastingdienst' voor NL bedrijven.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeVersionID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeDateURI))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeURI))">Attribuut MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_SellerSupplierParty_Party_PartyName">
		<sch:rule context="/nl-inv:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyName">
			<sch:assert test="not(empty(cbc:Name)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:Name/@languageID))">Attribuut MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_SellerSupplierParty_Party_PostalAddress">
		<sch:rule context="/nl-inv:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress">
			<sch:assert test="not(exists(cbc:ID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:AddressTypeCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:AddressFormatCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:Postbox)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:Floor)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Room)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:StreetName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:AdditionalStreetName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:BlockName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:BuildingName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:BuildingNumber)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:InhouseMail)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Department)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:MarkAttention)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:MarkCare)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CitySubdivisionName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:CityName)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:CityName/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:PostalZone)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:PostalZone/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CountrySubentity)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CountrySubentityCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Region/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:District)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:AddressLine)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cac:Country) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:LocationCoordinate)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_SellerSupplierParty_Party_PostalAddress_Country">
		<sch:rule context="/nl-inv:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country">
			<sch:assert test="not(empty(cbc:IdentificationCode)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listAgencyName) = 'United Nations Economic Commission for Europe' ">Attribuut MOET de waarde 'United Nations Economic Commission for Europe' bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listAgencyID) = '6' ">Attribuut MOET de waarde '6' bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listName) = 'Country' ">Attribuut MOET de waarde 'Country' bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listID) = 'ISO3166-1' ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listSchemeURI) = 'urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode-2.0' ">Attribuut MOET de waarde 'urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode-2.0' bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listURI) = 'http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc' ">Attribuut MOET de waarde ´http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc´ bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listVersionID) = '0.3' ">Attribuut MOET de waarde '0.3' bevatten.</sch:assert>
			<sch:assert test="not(exists(cbc:IdentificationCode/@name))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:IdentificationCode/@languageID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Name)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_SellerSupplierParty_Party_PhysicalAddress">
		<sch:rule context="/nl-inv:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalAddress">
			<sch:assert test="not(exists(cbc:ID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Description)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Conditions)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CountrySubentity)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CountrySubentityCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:ValidityPeriod)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cac:Address) ">Element MOET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_SellerSupplierParty_Party_PhysicalAddress_Address">
		<sch:rule context="/nl-inv:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalAddress/cac:Address">
			<sch:assert test="not(exists(cbc:ID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:AddressTypeCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:AddressFormatCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Postbox)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Floor)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Room)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:StreetName)  ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:StreetName)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:StreetName/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:AdditionalStreetName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:BlockName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:BuildingName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:BuildingNumber) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:BuildingNumber)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:BuildingNumber/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:InhouseMail)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Department)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:MarkAttention)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:MarkCare)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CitySubdivisionName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:CityName)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:CityName/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:PostalZone)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:PostalZone/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CountrySubentity)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CountrySubentityCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Region/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:District)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:AddressLine)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cac:Country) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:LocationCoordinate)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_SellerSupplierParty_Party_PhysicalAddress_Address_Country">
		<sch:rule context="/nl-inv:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalAddress/cac:Address/cac:Country">
			<sch:assert test="not(empty(cbc:IdentificationCode)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listAgencyName) = 'United Nations Economic Commission for Europe' ">Attribuut MOET de waarde 'United Nations Economic Commission for Europe' bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listAgencyID) = '6' ">Attribuut MOET de waarde '6' bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listName) = 'Country' ">Attribuut MOET de waarde 'Country' bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listID) = 'ISO3166-1' ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listSchemeURI) = 'urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode-2.0' ">Attribuut MOET de waarde 'urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode-2.0' bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listURI) = 'http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc' ">Attribuut MOET de waarde ´http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc´ bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listVersionID) = '0.3' ">Attribuut MOET de waarde '0.3' bevatten.</sch:assert>
			<sch:assert test="not(exists(cbc:IdentificationCode/@name))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:IdentificationCode/@languageID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Name)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_SellerSupplierParty_Party_PartyTaxScheme">
		<sch:rule context="/nl-inv:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyTaxScheme">
			<sch:assert test="not(exists(cbc:RegistrationName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:CompanyID)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:CompanyID/@schemeID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CompanyID/@schemeName))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CompanyID/@schemeAgencyID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:CompanyID/@schemeAgencyName)) ">Attribuut MOET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CompanyID/@schemeVersionID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CompanyID/@schemeDateURI))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CompanyID/@schemeURI))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:TaxLevelCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ExemptionReasonCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ExemptionReason)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:RegistrationAddress)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_SellerSupplierParty_Party_PartyTaxScheme_TaxScheme">
		<sch:rule context="/nl-inv:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme">
			<sch:assert test="not(exists(cbc:ID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Name)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:TaxTypeCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CurrencyCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:JurisdictionAddress)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_SellerSupplierParty_Party_Contact">
		<sch:rule context="/nl-inv:Invoice/cac:SellerSupplierParty/cac:Party/cac:Contact">
			<sch:assert test="not(exists(cbc:ID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Name)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Telephone/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Telefax)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ElectronicMail/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Note)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:OtherCommunication)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_SellerSupplierParty_Party_Person">
		<sch:rule context="/nl-inv:Invoice/cac:SellerSupplierParty/cac:Party/cac:Person">
			<sch:assert test="not(exists(cbc:FirstName/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:FamilyName)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:FamilyName/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Title)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:MiddleName/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:NameSuffix)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:JobTitle)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:OrganizationDepartment)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_BuyerCustomerParty">
		<sch:rule context="/nl-inv:Invoice/cac:BuyerCustomerParty">
			<sch:assert test="not(exists(cbc:CustomerAssignedAccountID/@schemeID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CustomerAssignedAccountID/@schemeName))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CustomerAssignedAccountID/@schemeAgencyID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CustomerAssignedAccountID/@schemeAgencyName))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CustomerAssignedAccountID/@schemeVersionID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CustomerAssignedAccountID/@schemeDateURI))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CustomerAssignedAccountID/@schemeURI))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:AdditionalAccountID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:DataSendingCapability)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:DespatchContact)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:AccountingContact)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:SellerContact)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_BuyerCustomerParty_Party">
		<sch:rule context="/nl-inv:Invoice/cac:BuyerCustomerParty/cac:Party">
			<sch:assert test="not(exists(cbc:MarkCareIndicator)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:MarkAttentionIndicator)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:WebSiteURI)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:LogoReferenceID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:EndPointID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cac:PartyIdentification) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="exists(cac:PartyName) and count(cac:PartyName) eq 1 ">Element MOET slechts éénmaal voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:Language)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cac:PartyTaxScheme) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:PartyLegalEntity)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:AgentParty)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_BuyerCustomerParty_Party_PartyIdentification">
		<sch:rule context="/nl-inv:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification">
			<sch:assert test="not(empty(cbc:ID)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeName))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:ID/@schemeAgencyID))">Attribuut MAG NIET leeg zijn.</sch:assert>
			<sch:assert test="not(empty(cbc:ID/@schemeAgencyName)) ">Attribuut MAG NIET leeg zijn, bevat 'Kamer van Koophandel' of 'Belastingdienst voor NL bedrijven.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeVersionID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeDateURI))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeURI))">Attribuut MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_BuyerCustomerParty_Party_PartyName">
		<sch:rule context="/nl-inv:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyName">
			<sch:assert test="not(empty(cbc:Name)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:Name/@languageID))">Attribuut MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_BuyerCustomerParty_Party_PostalAddress">
		<sch:rule context="/nl-inv:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress">
			<sch:assert test="not(exists(cbc:ID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:AddressTypeCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:AddressFormatCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:Postbox)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:Floor)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Room)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:StreetName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:AdditionalStreetName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:BlockName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:BuildingName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:BuildingNumber)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:InhouseMail)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Department)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:MarkAttention)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:MarkCare)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:PlotIdentification)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CitySubdivisionName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:CityName)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:CityName/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:PostalZone)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:PostalZone/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CountrySubentity)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CountrySubentityCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Region/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:District)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:AddressLine)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cac:Country) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:LocationCoordinate)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_BuyerCustomerParty_Party_PostalAddress_Country">
		<sch:rule context="/nl-inv:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PostalAddress/cac:Country">
			<sch:assert test="not(empty(cbc:IdentificationCode)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listAgencyName) = 'United Nations Economic Commission for Europe' ">Attribuut MOET de waarde 'United Nations Economic Commission for Europe' bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listAgencyID) = '6' ">Attribuut MOET de waarde '6' bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listName) = 'Country' ">Attribuut MOET de waarde 'Country' bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listID) = 'ISO3166-1' ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listSchemeURI) = 'urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode-2.0' ">Attribuut MOET de waarde 'urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode-2.0' bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listURI) = 'http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc' ">Attribuut MOET de waarde ´http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc´ bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listVersionID) = '0.3' ">Attribuut MOET de waarde '0.3' bevatten.</sch:assert>
			<sch:assert test="not(exists(cbc:IdentificationCode/@name))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:IdentificationCode/@languageID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Name)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_BuyerCustomerParty_Party_PhysicalAddress">
		<sch:rule context="/nl-inv:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalAddress">
			<sch:assert test="not(exists(cbc:ID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Description)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Conditions)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CountrySubentity)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CountrySubentityCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:ValidityPeriod)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cac:Address) ">Element MOET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_BuyerCustomerParty_Party_PhysicalAddress_Address">
		<sch:rule context="/nl-inv:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalAddress/cac:Address">
			<sch:assert test="not(exists(cbc:ID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:AddressTypeCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:AddressFormatCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Postbox)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Floor)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Room)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:StreetName) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:StreetName)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:StreetName/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:AdditionalStreetName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:BlockName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:BuildingName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:BuildingNumber) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:BuildingNumber)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:BuildingNumber/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:InhouseMail)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Department)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:MarkAttention)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:MarkCare)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:PlotIdentification)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CitySubdivisionName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:CityName)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:CityName/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:PostalZone)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:PostalZone/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CountrySubentity)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CountrySubentityCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Region/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:District)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:AddressLine)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cac:Country) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:LocationCoordinate)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_BuyerCustomerParty_Party_PhysicalLocation_Address_Country">
		<sch:rule context="/nl-inv:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country">
			<sch:assert test="not(empty(cbc:IdentificationCode)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listAgencyName) = 'United Nations Economic Commission for Europe' ">Attribuut MOET de waarde 'United Nations Economic Commission for Europe' bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listAgencyID) = '6' ">Attribuut MOET de waarde '6' bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listName) = 'Country' ">Attribuut MOET de waarde 'Country' bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listID) = 'ISO3166-1' ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listSchemeURI) = 'urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode-2.0' ">Attribuut MOET de waarde 'urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode-2.0' bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listURI) = 'http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc' ">Attribuut MOET de waarde ´http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc´ bevatten.</sch:assert>
			<sch:assert test="normalize-space(cbc:IdentificationCode/@listVersionID) = '0.3' ">Attribuut MOET de waarde '0.3' bevatten.</sch:assert>
			<sch:assert test="not(exists(cbc:IdentificationCode/@name))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:IdentificationCode/@languageID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Name)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_BuyerCustomerParty_Party_PartyTaxScheme">
		<sch:rule context="/nl-inv:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyTaxScheme">
			<sch:assert test="not(exists(cbc:RegistrationName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:CompanyID)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:CompanyID/@schemeID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CompanyID/@schemeName))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CompanyID/@schemeAgencyID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="normalize-space(cbc:CompanyID/@schemeAgencyName) = 'Belastingdienst' ">Attribuut MOET de waarde 'Belastingdienst' bevatten.</sch:assert>
			<sch:assert test="not(exists(cbc:CompanyID/@schemeVersionID))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CompanyID/@schemeDateURI))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CompanyID/@schemeURI))">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:TaxLevelCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ExemptionReasonCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ExemptionReason)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:RegistrationAddress)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_BuyerCustomerParty_Party_PartyTaxScheme_TaxScheme">
		<sch:rule context="/nl-inv:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyTaxScheme/cac:TaxScheme">
			<sch:assert test="not(exists(cbc:ID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Name)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:TaxTypeCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CurrencyCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:JurisdictionAddress)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_BuyerCustomerParty_Party_Contact">
		<sch:rule context="/nl-inv:Invoice/cac:BuyerCustomerParty/cac:Party/cac:Contact">
			<sch:assert test="not(exists(cbc:ID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Name)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Telephone/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Telefax)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ElectronicMail/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Note)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:OtherCommunication)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_BuyerCustomerParty_Party_Person">
		<sch:rule context="/nl-inv:Invoice/cac:BuyerCustomerParty/cac:Party/cac:Person">
			<sch:assert test="not(exists(cbc:FirstName/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:FamilyName)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:FamilyName/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Title)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:MiddleName/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:NameSuffix)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:JobTitle)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:OrganizationDepartment)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_Delivery">
		<sch:rule context="/nl-inv:Invoice/cac:Delivery">
			<sch:assert test="not(exists(cbc:ID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Quantity)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:MinimumQuantity)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:MaximumQuantity)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:ActualDeliveryDate) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="not(empty(cbc:ActualDeliveryDate))">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:ActualDeliveryTime)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:LatestDeliveryDate)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:LatestDeliveryTime)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:TrackingID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:DeliveryAddress)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:DeliveryLocation)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:RequestedDeliveryPeriod)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:PromisedDeliveryPeriod)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:EstimatedDeliveryPeriod)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:DeliveryParty)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:Despatch)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_PaymentMeans">
		<sch:rule context="/nl-inv:Invoice/cac:PaymentMeans">
			<sch:assert test="not(exists(cbc:ID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:PaymentMeansCode) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:PaymentMeansCode/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:PaymentMeansCode/@name)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:PaymentDueDate)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:PaymentChannelCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:InstructionID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:InstructionNote)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:PaymentID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:CardAccount)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:PayerFinancialAccount)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_PaymentMeans_PayeeFinancialAccount">
		<sch:rule context="/nl-inv:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount">
			<sch:assert test="not(empty(cbc:ID)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeName)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeAgencyID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeAgencyName)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeVersionID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeDateURI)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeURI)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Name)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:AccountTypeCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CurrencyCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:PaymentNote)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:Country)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:CreditAccount)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_PaymentMeans_PayeeFinancialAccount_FinancialInstitutionBranch">
		<sch:rule context="/nl-inv:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch">
			<sch:assert test="not(exists(cbc:ID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Name)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cac:FinancialInstitution) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:Address)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_PaymentMeans_PayeeFinancialAccount_FinancialInstitutionBranch_FinancialInstitution">
		<sch:rule context="/nl-inv:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution">
			<sch:assert test="not(empty(cbc:ID)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeName)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeAgencyID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeAgencyName)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeVersionID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeDateURI)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeURI)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Name)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:Address)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_PaymentTerms">
		<sch:rule context="/nl-inv:Invoice/cac:PaymentTerms">
			<sch:assert test="not(exists(cbc:ID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:PaymentMeansID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:PrepaidPaymentReferenceID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Note/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ReferenceEventCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:PenaltySurchargePercent)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Amount)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_PaymentTerms_SettlementPeriod">
		<sch:rule context="/nl-inv:Invoice/cac:PaymentTerms/cac:SettlementPeriod">
			<sch:assert test="not(exists(cbc:StartDate)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:StartTime)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:EndDate)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:EndTime)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:DurationMeasure/@unitCode) ">Attribuut MOET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:DescriptionCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Description/@languageID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_PaymentTerms_PenaltyPeriod">
		<sch:rule context="/nl-inv:Invoice/cac:PaymentTerms/cac:PenaltyPeriod">
			<sch:assert test="not(exists(cbc:StartDate)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:StartTime)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:EndDate) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:EndTime)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:DurationMeasure)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:DescriptionCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Description)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_TaxTotal">
		<sch:rule context="/nl-inv:Invoice/cac:TaxTotal">
			<sch:assert test="exists(cbc:TaxAmount) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:TaxAmount/@currencyID) ">Attribuut MOET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:RoundingAmount)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:TaxEvidenceIndicator)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cac:TaxSubtotal) ">Element MOET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_TaxTotal_TaxSubtotal">
		<sch:rule context="/nl-inv:Invoice/cac:TaxTotal/cac:TaxSubtotal">
			<sch:assert test="exists(cbc:TaxableAmount) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:TaxableAmount/@currencyID) ">Attribuut MOET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:TaxAmount) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:TaxAmount/@currencyID) ">Attribuut MOET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CalculationSequenceNumeric)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:TransactionCurrencyTaxAmount)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:Percent) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:BaseUnitMeasure)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:PerUnitAmount)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:TierRange)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:TierRatePercent)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_TaxTotal_TaxSubtotal_TaxCategory">
		<sch:rule context="/nl-inv:Invoice/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory">
			<sch:assert test="exists(cbc:ID) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Name)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Percent)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:BaseUnitMeasure)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:PerUnitAmount)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:TierRange)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:TierRatePercent)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_TaxTotal_TaxSubtotal_TaxCategory_TaxScheme">
		<sch:rule context="/nl-inv:Invoice/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
			<sch:assert test="exists(cbc:ID) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Name)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:TaxTypeCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CurrencyCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:JurisdictionRegionAddress)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_LegalMonetaryTotal">
		<sch:rule context="/nl-inv:Invoice/cac:LegalMonetaryTotal">
			<sch:assert test="exists(cbc:LineExtensionAmount) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:LineExtensionAmount/@currencyID) ">Attribuut MOET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:TaxExclusiveAmount) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:TaxExclusiveAmount/@currencyID) ">Attribuut MOET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:TaxInclusiveAmount) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:TaxInclusiveAmount/@currencyID) ">Attribuut MOET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:AllowanceTotalAmount)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ChargeTotalAmount)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:PrepaidAmount)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:PayableRoundingAmount)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:PayableAmount) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:PayableAmount/@currencyID) ">Attribuut MOET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_InvoiceLine">
		<sch:rule context="/nl-inv:Invoice/cac:InvoiceLine">
			<sch:assert test="not(empty(cbc:ID)) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeName)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeAgencyID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeAgencyName)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeVersionID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeDateURI)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeURI)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:UUID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Note)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:InvoicedQuantity) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:InvoicedQuantity/@unitCode) ">Attribuut MOET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:LineExtensionAmount) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:LineExtensionAmount/@currencyID) ">Attribuut MOET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:TaxPointDate)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:AccountingCostCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:AccountingCost)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:FreeOfChargeIndicator) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="count(cac:OrderLineReference) &lt; 2 ">Element mag MAXIMAAL eenmaal voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:DespatchLineReference)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:ReceiptLineReference)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:BillingReference)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:DocumentReference)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:PricingReference)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:OriginatorParty)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:Delivery)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:PaymentTerms)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="count(cac:AllowanceCharge) &lt; 2 ">Element mag MAXIMAAL eenmaal voorkomen.</sch:assert>
			<sch:assert test="exists(cac:Item) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="exists(cac:Price) ">Element MOET eenmaal voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:DeliveryTerms)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_InvoiceLine_OrderLineReference">
		<sch:rule context="/nl-inv:Invoice/cac:InvoiceLine/cac:OrderLineReference">
			<sch:assert test="exists(cbc:LineID) and not(empty(cbc:LineID)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeName)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeAgencyID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeAgencyName)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeVersionID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeDateURI)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeURI)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:SalesOrderLineID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:UUID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:LineStatusCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cac:OrderReference) ">Element MOET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_InvoiceLine_OrderLineReference_OrderReference">
		<sch:rule context="/nl-inv:Invoice/cac:InvoiceLine/cac:OrderLineReference/cac:OrderReference">
			<sch:assert test="not(empty(cbc:ID)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeName)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeAgencyID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeAgencyName)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeVersionID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeDateURI)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeURI)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:SalesOrderID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:UUID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CopyIndicator)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:IssueDate)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:IssueTime)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CustomerReference)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:DocumentReference)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_InvoiceLine_AllowanceCharge">
		<sch:rule context="/nl-inv:Invoice/cac:InvoiceLine/cac:AllowanceCharge">
			<sch:assert test="exists(cbc:ID) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:ChargeIndicator) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:AllowanceChargeReasonCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:AllowanceChargeReason)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:PrepaidIndicator)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:SequenceNumeric)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:Amount) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:Amount/@currencyID) ">Attribuut MOET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:BaseAmount) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:BaseAmount/@currencyID) ">Attribuut MOET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:AccountingCostCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:AccountingCost)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:TaxCategory)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:TaxTotal)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:PaymentMeans)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_InvoiceLine_TaxTotal">
		<sch:rule context="/nl-inv:Invoice/cac:InvoiceLine/cac:TaxTotal">
			<sch:assert test="exists(cbc:TaxAmount) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:TaxAmount/@currencyID) ">Attribuut MOET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:RoundingAmount)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:TaxEvidenceIndicator)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cac:TaxSubtotal) ">Element MOET minimaal eenmaal voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_InvoiceLine_TaxTotal_TaxSubtotal">
		<sch:rule context="/nl-inv:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal">
			<sch:assert test="exists(cbc:TaxableAmount) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:TaxableAmount/@currencyID) ">Attribuut MOET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:TaxAmount) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:TaxAmount/@currencyID) ">Attribuut MOET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CalculationSequenceNumeric)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:TransactionCurrencyTaxAmount)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:Percent) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:BaseUnitMeasure)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:PerUnitAmount)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:TierRange)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:TierRatePercent)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_InvoiceLine_TaxTotal_TaxSubtotal_TaxCategory">
		<sch:rule context="/nl-inv:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory">
			<sch:assert test="not(exists(cbc:ID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Name)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Percent)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:BaseUnitMeasure)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:PerUnitAmount)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:TierRange)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:TierRatePercent)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_InvoiceLine_TaxTotal_TaxSubtotal_TaxCategory_TaxScheme">
		<sch:rule context="/nl-inv:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
			<sch:assert test="not(exists(cbc:ID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Name)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:TaxTypeCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:CurrencyCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:JurisdictionRegionAddress)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_InvoiceLine_Item">
		<sch:rule context="/nl-inv:Invoice/cac:InvoiceLine/cac:Item">
			<sch:assert test="count(cbc:Description) &lt; 2 ">Element MAG NIET meer dan eenmaal voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:PackQuantity)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:PackSizeNumeric)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:CatalogueIndicator) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:Name) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:HazardousRiskIndicator)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:Keyword)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:BrandName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ModelName)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:ManufacturersItemIdentification)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:StandardItemIdentification)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:CatalogueItemIdentification)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:AdditionalItemIdentification)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:CatalogueDocumentReference)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:ItemSpecificationDocumentReference)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:OriginCountry)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:CommodityClassification)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:TransactionConditions)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:HazerdousItem)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:ClassifiedTaxCategory)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:AdditionalItemProperty)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:ManufacturerParty)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:InformationContentProviderParty)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:OriginAddress)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:ItemInstance)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_InvoiceLine_Item_BuyersItemIdentification">
		<sch:rule context="/nl-inv:Invoice/cac:InvoiceLine/cac:Item/cac:BuyersItemIdentification">
			<sch:assert test="not(empty(cbc:ID)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeName)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeAgencyID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeAgencyName)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeVersionID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeDateURI)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeURI)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ExtendedID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:PhysicalAttribute)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:MeasurementDimension)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:IssuerParty)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_InvoiceLine_Item_SellersItemIdentification">
		<sch:rule context="/nl-inv:Invoice/cac:InvoiceLine/cac:Item/cac:SellersItemIdentification">
			<sch:assert test="not(empty(cbc:ID)) ">Element MOET gevuld worden.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeName)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeAgencyID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeAgencyName)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeVersionID)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeDateURI)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ID/@schemeURI)) ">Attribuut MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:ExtendedID)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:PhysicalAttribute)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:MeasurementDimension)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:IssuerParty)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
	<sch:pattern id="Invoice_InvoiceLine_Price">
		<sch:rule context="/nl-inv:Invoice/cac:InvoiceLine/cac:Price">
			<sch:assert test="exists(cbc:PriceAmount) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:PriceAmount/@currencyID) ">Attribuut MOET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:BaseQuantity) ">Element MOET voorkomen.</sch:assert>
			<sch:assert test="exists(cbc:BaseQuantity/@unitCode) ">Attribuut MOET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:PriceChangeReason)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:PriceTypeCode)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:PriceType)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cbc:OrderableUnitFactorRate)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:ValidityPeriod)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:PriceList)) ">Element MAG NIET voorkomen.</sch:assert>
			<sch:assert test="not(exists(cac:AllowanceCharge)) ">Element MAG NIET voorkomen.</sch:assert>
		</sch:rule>
	</sch:pattern>
</sch:schema>
