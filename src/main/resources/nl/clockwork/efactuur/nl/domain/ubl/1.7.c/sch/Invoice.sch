<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <title>Validations for Invoice Mapping; strict=false</title>
  <ns prefix="nl-cac" uri="urn:digi-inkoop:ubl:2.0:NL:1.7:UBL-NL-CommonAggregateComponents-2" />
  <ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" />
  <ns prefix="nl-cbc" uri="urn:digi-inkoop:ubl:2.0:NL:1.7:UBL-NL-CommonBasicComponents-2" />
  <ns prefix="doc" uri="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2" />
  <ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" />
  <ns prefix="ext" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2" />
  <pattern id="cardinality-redefines">
    <rule context="doc:Invoice">
      <assert test="count(cac:BillingReference) &lt;= 1">doc:Invoice may contain cac:BillingReference at most 1 time(s)</assert>
      <assert test="count(cac:Delivery) &lt;= 1">doc:Invoice may contain cac:Delivery at most 1 time(s)</assert>
      <assert test="count(cac:InvoicePeriod) &lt;= 1">doc:Invoice may contain cac:InvoicePeriod at most 1 time(s)</assert>
      <assert test="count(cac:PaymentMeans) &lt;= 1">doc:Invoice may contain cac:PaymentMeans at most 1 time(s)</assert>
      <assert test="count(cac:PaymentTerms) &lt;= 3">doc:Invoice may contain cac:PaymentTerms at most 3 time(s)</assert>
      <assert test="count(cac:TaxTotal) &gt;= 1 and count(cac:TaxTotal) &lt;= 1">doc:Invoice must contain cac:TaxTotal at least 1 and at most 1 time(s)</assert>
      <assert test="count(cbc:CustomizationID) &gt;= 1">doc:Invoice must contain cbc:CustomizationID at least 1 time(s)</assert>
      <assert test="count(cbc:Note) &lt;= 1">doc:Invoice may contain cbc:Note at most 1 time(s)</assert>
      <assert test="count(cbc:ProfileID) &gt;= 1">doc:Invoice must contain cbc:ProfileID at least 1 time(s)</assert>
      <assert test="count(cbc:UBLVersionID) &gt;= 1">doc:Invoice must contain cbc:UBLVersionID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:AccountingCustomerParty">
      <assert test="count(cac:Party) &gt;= 1">doc:Invoice/cac:AccountingCustomerParty must contain cac:Party at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:AccountingCustomerParty/cac:Party">
      <assert test="count(cac:PartyIdentification) &gt;= 1 and count(cac:PartyIdentification) &lt;= 3">doc:Invoice/cac:AccountingCustomerParty/cac:Party must contain cac:PartyIdentification at least 1 and at most 3 time(s)</assert>
      <assert test="count(cac:PartyLegalEntity) &lt;= 1">doc:Invoice/cac:AccountingCustomerParty/cac:Party may contain cac:PartyLegalEntity at most 1 time(s)</assert>
      <assert test="count(cac:PartyName) &gt;= 1 and count(cac:PartyName) &lt;= 1">doc:Invoice/cac:AccountingCustomerParty/cac:Party must contain cac:PartyName at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:Contact">
      <assert test="count(cbc:Name) &gt;= 1">doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:Contact must contain cbc:Name at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID">
      <assert test="count(@schemeAgencyName) &gt;= 1">doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress">
      <assert test="count(cac:Country) &gt;= 1">doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress must contain cac:Country at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation">
      <assert test="count(cac:Address) &gt;= 1">doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation must contain cac:Address at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address">
      <assert test="count(cac:Country) &gt;= 1">doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address must contain cac:Country at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress">
      <assert test="count(cac:Country) &gt;= 1">doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress must contain cac:Country at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:AccountingSupplierParty">
      <assert test="count(cac:Party) &gt;= 1">doc:Invoice/cac:AccountingSupplierParty must contain cac:Party at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:AccountingSupplierParty/cac:Party">
      <assert test="count(cac:PartyIdentification) &gt;= 1 and count(cac:PartyIdentification) &lt;= 3">doc:Invoice/cac:AccountingSupplierParty/cac:Party must contain cac:PartyIdentification at least 1 and at most 3 time(s)</assert>
      <assert test="count(cac:PartyLegalEntity) &lt;= 1">doc:Invoice/cac:AccountingSupplierParty/cac:Party may contain cac:PartyLegalEntity at most 1 time(s)</assert>
      <assert test="count(cac:PartyName) &gt;= 1 and count(cac:PartyName) &lt;= 1">doc:Invoice/cac:AccountingSupplierParty/cac:Party must contain cac:PartyName at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:Contact">
      <assert test="count(cbc:Name) &gt;= 1">doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:Contact must contain cbc:Name at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID">
      <assert test="count(@schemeAgencyName) &gt;= 1">doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress">
      <assert test="count(cac:Country) &gt;= 1">doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress must contain cac:Country at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation">
      <assert test="count(cac:Address) &gt;= 1">doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation must contain cac:Address at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address">
      <assert test="count(cac:Country) &gt;= 1">doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address must contain cac:Country at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress">
      <assert test="count(cac:Country) &gt;= 1">doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress must contain cac:Country at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:AllowanceCharge/cac:TaxTotal">
      <assert test="count(cac:TaxSubtotal) &gt;= 1">doc:Invoice/cac:AllowanceCharge/cac:TaxTotal must contain cac:TaxSubtotal at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:AllowanceCharge/cac:TaxTotal/cac:TaxSubtotal">
      <assert test="count(cbc:TaxableAmount) &gt;= 1">doc:Invoice/cac:AllowanceCharge/cac:TaxTotal/cac:TaxSubtotal must contain cbc:TaxableAmount at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:AllowanceCharge/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
      <assert test="count(cbc:Name) &gt;= 1">doc:Invoice/cac:AllowanceCharge/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme must contain cbc:Name at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:BillingReference">
      <assert test="count(cac:InvoiceDocumentReference) &gt;= 1">doc:Invoice/cac:BillingReference must contain cac:InvoiceDocumentReference at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:BuyerCustomerParty">
      <assert test="count(cac:Party) &gt;= 1">doc:Invoice/cac:BuyerCustomerParty must contain cac:Party at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:BuyerCustomerParty/cac:Party">
      <assert test="count(cac:PartyIdentification) &gt;= 1 and count(cac:PartyIdentification) &lt;= 3">doc:Invoice/cac:BuyerCustomerParty/cac:Party must contain cac:PartyIdentification at least 1 and at most 3 time(s)</assert>
      <assert test="count(cac:PartyLegalEntity) &lt;= 1">doc:Invoice/cac:BuyerCustomerParty/cac:Party may contain cac:PartyLegalEntity at most 1 time(s)</assert>
      <assert test="count(cac:PartyName) &gt;= 1 and count(cac:PartyName) &lt;= 1">doc:Invoice/cac:BuyerCustomerParty/cac:Party must contain cac:PartyName at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:Contact">
      <assert test="count(cbc:Name) &gt;= 1">doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:Contact must contain cbc:Name at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID">
      <assert test="count(@schemeAgencyName) &gt;= 1">doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress">
      <assert test="count(cac:Country) &gt;= 1">doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress must contain cac:Country at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation">
      <assert test="count(cac:Address) &gt;= 1">doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation must contain cac:Address at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address">
      <assert test="count(cac:Country) &gt;= 1">doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address must contain cac:Country at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:Delivery/cac:DeliveryAddress">
      <assert test="count(cac:Country) &gt;= 1">doc:Invoice/cac:Delivery/cac:DeliveryAddress must contain cac:Country at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:DeliveryTerms">
      <assert test="count(cbc:ID) &gt;= 1">doc:Invoice/cac:DeliveryTerms must contain cbc:ID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:DeliveryTerms/cbc:ID">
      <assert test="count(@schemeAgencyID) &gt;= 1">doc:Invoice/cac:DeliveryTerms/cbc:ID must contain @schemeAgencyID at least 1 time(s)</assert>
      <assert test="count(@schemeAgencyName) &gt;= 1">doc:Invoice/cac:DeliveryTerms/cbc:ID must contain @schemeAgencyName at least 1 time(s)</assert>
      <assert test="count(@schemeDataURI) &gt;= 1">doc:Invoice/cac:DeliveryTerms/cbc:ID must contain @schemeDataURI at least 1 time(s)</assert>
      <assert test="count(@schemeID) &gt;= 1">doc:Invoice/cac:DeliveryTerms/cbc:ID must contain @schemeID at least 1 time(s)</assert>
      <assert test="count(@schemeName) &gt;= 1">doc:Invoice/cac:DeliveryTerms/cbc:ID must contain @schemeName at least 1 time(s)</assert>
      <assert test="count(@schemeURI) &gt;= 1">doc:Invoice/cac:DeliveryTerms/cbc:ID must contain @schemeURI at least 1 time(s)</assert>
      <assert test="count(@schemeVersionID) &gt;= 1">doc:Invoice/cac:DeliveryTerms/cbc:ID must contain @schemeVersionID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:InvoiceLine">
      <assert test="count(cac:Delivery) &lt;= 1">doc:Invoice/cac:InvoiceLine may contain cac:Delivery at most 1 time(s)</assert>
      <assert test="count(cac:OrderLineReference) &lt;= 1">doc:Invoice/cac:InvoiceLine may contain cac:OrderLineReference at most 1 time(s)</assert>
      <assert test="count(cac:Price) &gt;= 1">doc:Invoice/cac:InvoiceLine must contain cac:Price at least 1 time(s)</assert>
      <assert test="count(cac:TaxTotal) &lt;= 1">doc:Invoice/cac:InvoiceLine may contain cac:TaxTotal at most 1 time(s)</assert>
      <assert test="count(cbc:FreeOfChargeIndicator) &gt;= 1">doc:Invoice/cac:InvoiceLine must contain cbc:FreeOfChargeIndicator at least 1 time(s)</assert>
      <assert test="count(cbc:InvoicedQuantity) &gt;= 1">doc:Invoice/cac:InvoiceLine must contain cbc:InvoicedQuantity at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress">
      <assert test="count(cac:Country) &gt;= 1">doc:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress must contain cac:Country at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:InvoiceLine/cac:Item">
      <assert test="count(cbc:CatalogueIndicator) &gt;= 1">doc:Invoice/cac:InvoiceLine/cac:Item must contain cbc:CatalogueIndicator at least 1 time(s)</assert>
      <assert test="count(cbc:Description) &lt;= 1">doc:Invoice/cac:InvoiceLine/cac:Item may contain cbc:Description at most 1 time(s)</assert>
      <assert test="count(cbc:Name) &gt;= 1">doc:Invoice/cac:InvoiceLine/cac:Item must contain cbc:Name at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme">
      <assert test="count(cbc:Name) &gt;= 1">doc:Invoice/cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme must contain cbc:Name at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:InvoiceLine/cac:OrderLineReference">
      <assert test="count(cac:OrderReference) &gt;= 1">doc:Invoice/cac:InvoiceLine/cac:OrderLineReference must contain cac:OrderReference at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:InvoiceLine/cac:Price">
      <assert test="count(cbc:BaseQuantity) &gt;= 1">doc:Invoice/cac:InvoiceLine/cac:Price must contain cbc:BaseQuantity at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:InvoiceLine/cac:TaxTotal">
      <assert test="count(cac:TaxSubtotal) &gt;= 1">doc:Invoice/cac:InvoiceLine/cac:TaxTotal must contain cac:TaxSubtotal at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal">
      <assert test="count(cbc:TaxableAmount) &gt;= 1">doc:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal must contain cbc:TaxableAmount at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
      <assert test="count(cbc:Name) &gt;= 1">doc:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme must contain cbc:Name at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:InvoicePeriod">
      <assert test="count(cbc:DescriptionCode) &gt;= 1 and count(cbc:DescriptionCode) &lt;= 1">doc:Invoice/cac:InvoicePeriod must contain cbc:DescriptionCode at least 1 and at most 1 time(s)</assert>
      <assert test="count(cbc:EndDate) &gt;= 1">doc:Invoice/cac:InvoicePeriod must contain cbc:EndDate at least 1 time(s)</assert>
      <assert test="count(cbc:StartDate) &gt;= 1">doc:Invoice/cac:InvoicePeriod must contain cbc:StartDate at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:InvoicePeriod/cbc:DescriptionCode">
      <assert test="count(@listAgencyID) &gt;= 1">doc:Invoice/cac:InvoicePeriod/cbc:DescriptionCode must contain @listAgencyID at least 1 time(s)</assert>
      <assert test="count(@listAgencyName) &gt;= 1">doc:Invoice/cac:InvoicePeriod/cbc:DescriptionCode must contain @listAgencyName at least 1 time(s)</assert>
      <assert test="count(@listID) &gt;= 1">doc:Invoice/cac:InvoicePeriod/cbc:DescriptionCode must contain @listID at least 1 time(s)</assert>
      <assert test="count(@listName) &gt;= 1">doc:Invoice/cac:InvoicePeriod/cbc:DescriptionCode must contain @listName at least 1 time(s)</assert>
      <assert test="count(@listSchemeURI) &gt;= 1">doc:Invoice/cac:InvoicePeriod/cbc:DescriptionCode must contain @listSchemeURI at least 1 time(s)</assert>
      <assert test="count(@listURI) &gt;= 1">doc:Invoice/cac:InvoicePeriod/cbc:DescriptionCode must contain @listURI at least 1 time(s)</assert>
      <assert test="count(@listVersionID) &gt;= 1">doc:Invoice/cac:InvoicePeriod/cbc:DescriptionCode must contain @listVersionID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:LegalMonetaryTotal">
      <assert test="count(cbc:LineExtensionAmount) &gt;= 1">doc:Invoice/cac:LegalMonetaryTotal must contain cbc:LineExtensionAmount at least 1 time(s)</assert>
      <assert test="count(cbc:TaxExclusiveAmount) &gt;= 1">doc:Invoice/cac:LegalMonetaryTotal must contain cbc:TaxExclusiveAmount at least 1 time(s)</assert>
      <assert test="count(cbc:TaxInclusiveAmount) &gt;= 1">doc:Invoice/cac:LegalMonetaryTotal must contain cbc:TaxInclusiveAmount at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount">
      <assert test="count(cbc:ID) &gt;= 1">doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount must contain cbc:ID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch">
      <assert test="count(cac:FinancialInstitution) &gt;= 1">doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch must contain cac:FinancialInstitution at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address">
      <assert test="count(cac:Country) &gt;= 1">doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address must contain cac:Country at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution">
      <assert test="count(cbc:ID) &gt;= 1">doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution must contain cbc:ID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:PaymentTerms">
      <assert test="count(cbc:Note) &lt;= 1">doc:Invoice/cac:PaymentTerms may contain cbc:Note at most 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:PaymentTerms/cac:PenaltyPeriod">
      <assert test="count(cbc:EndDate) &gt;= 1">doc:Invoice/cac:PaymentTerms/cac:PenaltyPeriod must contain cbc:EndDate at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:PaymentTerms/cac:SettlementPeriod">
      <assert test="count(cbc:Description) &lt;= 1">doc:Invoice/cac:PaymentTerms/cac:SettlementPeriod may contain cbc:Description at most 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:SellerSupplierParty/cac:Party">
      <assert test="count(cac:PartyIdentification) &gt;= 1 and count(cac:PartyIdentification) &lt;= 3">doc:Invoice/cac:SellerSupplierParty/cac:Party must contain cac:PartyIdentification at least 1 and at most 3 time(s)</assert>
      <assert test="count(cac:PartyLegalEntity) &lt;= 1">doc:Invoice/cac:SellerSupplierParty/cac:Party may contain cac:PartyLegalEntity at most 1 time(s)</assert>
      <assert test="count(cac:PartyName) &gt;= 1 and count(cac:PartyName) &lt;= 1">doc:Invoice/cac:SellerSupplierParty/cac:Party must contain cac:PartyName at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:Contact">
      <assert test="count(cbc:Name) &gt;= 1">doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:Contact must contain cbc:Name at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID">
      <assert test="count(@schemeAgencyName) &gt;= 1">doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress">
      <assert test="count(cac:Country) &gt;= 1">doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress must contain cac:Country at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation">
      <assert test="count(cac:Address) &gt;= 1">doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation must contain cac:Address at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address">
      <assert test="count(cac:Country) &gt;= 1">doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address must contain cac:Country at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress">
      <assert test="count(cac:Country) &gt;= 1">doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress must contain cac:Country at least 1 time(s)</assert>
      <assert test="count(cbc:CityName) &gt;= 1">doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress must contain cbc:CityName at least 1 time(s)</assert>
      <assert test="count(cbc:PostalZone) &gt;= 1">doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress must contain cbc:PostalZone at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:TaxTotal">
      <assert test="count(cac:TaxSubtotal) &gt;= 1">doc:Invoice/cac:TaxTotal must contain cac:TaxSubtotal at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:TaxTotal/cac:TaxSubtotal">
      <assert test="count(cbc:TaxableAmount) &gt;= 1">doc:Invoice/cac:TaxTotal/cac:TaxSubtotal must contain cbc:TaxableAmount at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
      <assert test="count(cbc:Name) &gt;= 1">doc:Invoice/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme must contain cbc:Name at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/cbc:InvoiceTypeCode">
      <assert test="count(@listAgencyID) &gt;= 1">doc:Invoice/cbc:InvoiceTypeCode must contain @listAgencyID at least 1 time(s)</assert>
      <assert test="count(@listAgencyName) &gt;= 1">doc:Invoice/cbc:InvoiceTypeCode must contain @listAgencyName at least 1 time(s)</assert>
      <assert test="count(@listID) &gt;= 1">doc:Invoice/cbc:InvoiceTypeCode must contain @listID at least 1 time(s)</assert>
      <assert test="count(@listName) &gt;= 1">doc:Invoice/cbc:InvoiceTypeCode must contain @listName at least 1 time(s)</assert>
      <assert test="count(@listSchemeURI) &gt;= 1">doc:Invoice/cbc:InvoiceTypeCode must contain @listSchemeURI at least 1 time(s)</assert>
      <assert test="count(@listURI) &gt;= 1">doc:Invoice/cbc:InvoiceTypeCode must contain @listURI at least 1 time(s)</assert>
      <assert test="count(@listVersionID) &gt;= 1">doc:Invoice/cbc:InvoiceTypeCode must contain @listVersionID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod">
      <assert test="count(cbc:DescriptionCode) &gt;= 1 and count(cbc:DescriptionCode) &lt;= 1">doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod must contain cbc:DescriptionCode at least 1 and at most 1 time(s)</assert>
      <assert test="count(cbc:EndDate) &gt;= 1">doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod must contain cbc:EndDate at least 1 time(s)</assert>
      <assert test="count(cbc:StartDate) &gt;= 1">doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod must contain cbc:StartDate at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod/cbc:DescriptionCode">
      <assert test="count(@listAgencyID) &gt;= 1">doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod/cbc:DescriptionCode must contain @listAgencyID at least 1 time(s)</assert>
      <assert test="count(@listAgencyName) &gt;= 1">doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod/cbc:DescriptionCode must contain @listAgencyName at least 1 time(s)</assert>
      <assert test="count(@listID) &gt;= 1">doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod/cbc:DescriptionCode must contain @listID at least 1 time(s)</assert>
      <assert test="count(@listName) &gt;= 1">doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod/cbc:DescriptionCode must contain @listName at least 1 time(s)</assert>
      <assert test="count(@listSchemeURI) &gt;= 1">doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod/cbc:DescriptionCode must contain @listSchemeURI at least 1 time(s)</assert>
      <assert test="count(@listURI) &gt;= 1">doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod/cbc:DescriptionCode must contain @listURI at least 1 time(s)</assert>
      <assert test="count(@listVersionID) &gt;= 1">doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod/cbc:DescriptionCode must contain @listVersionID at least 1 time(s)</assert>
    </rule>
  </pattern>
  <pattern id="type-restrictions">
    <rule context="/">
      <assert test="if(count(//cac:PartyIdentification/cbc:ID[@schemeAgencyName = 'Vest']) = 1) then (count(//cac:PartyIdentification/cbc:ID[@schemeAgencyName = 'KvK']) = 1) else ('true')">Als Vestigingsnummer is opgegeven MOET Kamer van Koophandel nummer ook opgegeven worden.</assert>
    </rule>
    <rule context="doc:Invoice">
      <assert test="every $bn in //cbc:BuildingNumber satisfies (matches($bn,'^\d+(-[ \w]+)?$'))">Huisnummer en Huisnummertoevoeging moeten achter elkaar geplaatst worden, gescheiden met een koppelteken.</assert>
      <assert test="every $id in //cac:PartyIdentification/cbc:ID satisfies (exists($id/@schemeAgencyID) and not(empty($id/@schemeAgencyID)) and exists($id/@schemeAgencyName) and not(empty($id/@schemeAgencyName)))">PartyIdentification/ID MOET @schemeAgencyID en @schemeAgencyName attributen bevatten.</assert>
      <assert test="every $pa in //cac:PostalAddress satisfies ((not(empty($pa/cbc:Postbox)) and empty($pa/cbc:StreetName) and empty($pa/cbc:BuildingNumber) and empty(cbc:Room) and empty(cbc:Floor) and empty(cbc:Department) and empty(cbc:InhouseMail) and empty(cbc:PlotIdentification)) or (empty($pa/cbc:Postbox) and (not(empty($pa/cbc:StreetName)) or not(empty($pa/cbc:BuildingNumber)) or not(empty(cbc:Room)) or not(empty(cbc:Floor)) or not(empty(cbc:Department)) or not(empty(cbc:InhouseMail)) or not(empty(cbc:PlotIdentification)))))">PostalAddress MOET OF een Postbox bevatten OF minimaal 1 van de elementen StreetName, BuildingNumber, Room, Floor, Department, InhouseMail of PlotIdentification. Beide MAG NIET.</assert>
      <assert test="( (count(cac:Delivery/cbc:ActualDeliveryDate) = 0) and (   (count(cac:InvoiceLine/cac:Delivery/cbc:ActualDeliveryDate) ) > 0 ))or( (count(cac:Delivery/cbc:ActualDeliveryDate) > 0) and (   (count(cac:InvoiceLine/cac:Delivery/cbc:ActualDeliveryDate) ) = 0 ))"> Bericht MOET OF een ActualDeliveryDate op documentniveau OF op regelniveau bevatten.</assert>
      <assert test="(count(cac:OrderReference/cbc:ID) + count(cbc:AccountingCostCode) + count(cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:Name)) > 0"> Er moet in ieder geval een OrderReference ID, AccountingCostCode of Contact Name worden opgegeven.</assert>
      <assert test="(count(cbc:InvoiceTypeCode[text() = 'C']) + count(cbc:InvoiceTypeCode[text() = 'VC'])) = 0 or count(cac:BillingReference/cac:InvoiceDocumentReference/cbc:ID) > 0">Referentie naar andere invoice is verplicht bij (voorstel) creditnota.</assert>
      <assert test="empty(cbc:CustomizationID) or (cbc:CustomizationID='1.7')">Bericht MOET gebaseerd zijn op versie 1.7 van de Nederlandse specificatie.</assert>
      <assert test="empty(cbc:ProfileID) or (cbc:ProfileID='NL')">Bericht MOET op de Nederlandse (NL) specificatie gebaseerd zijn.</assert>
      <assert test="empty(cbc:UBLVersionID) or (cbc:UBLVersionID='2.0')">Bericht MOET gebaseerd zijn op UBL Versie 2.0</assert>
    </rule>
    <rule context="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:Contact">
      <assert test="matches(cbc:Telefax, '^[-0-9]*$')">Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</assert>
      <assert test="matches(cbc:Telephone, '^[-0-9]*$')">Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</assert>
    </rule>
    <rule context="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:Name">
      <assert test="string-length() > 0">doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:Contact/cbc:Name must be filled</assert>
    </rule>
    <rule context="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID">
      <assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</assert>
      <assert test="empty(@schemeAgencyName) or (@schemeAgencyName='KvK') or (@schemeAgencyName='Vest') or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')">Uitgevende organisatie van de PartijIdentificatie MOET geïdentificeerd worden door een code uit de lijst: KvK, Vest, BTW, Fi, BSN, OIN, XXX.</assert>
    </rule>
    <rule context="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode">
      <assert test="string-length() > 0">doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode must be filled</assert>
    </rule>
    <rule context="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode">
      <assert test="string-length() > 0">doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must be filled</assert>
    </rule>
    <rule context="doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode">
      <assert test="string-length() > 0">doc:Invoice/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must be filled</assert>
    </rule>
    <rule context="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:Contact">
      <assert test="matches(cbc:Telefax, '^[-0-9]*$')">Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</assert>
      <assert test="matches(cbc:Telephone, '^[-0-9]*$')">Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</assert>
    </rule>
    <rule context="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:Name">
      <assert test="string-length() > 0">doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:Name must be filled</assert>
    </rule>
    <rule context="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID">
      <assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</assert>
      <assert test="empty(@schemeAgencyName) or (@schemeAgencyName='KvK') or (@schemeAgencyName='Vest') or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')">Uitgevende organisatie van de PartijIdentificatie MOET geïdentificeerd worden door een code uit de lijst: KvK, Vest, BTW, Fi, BSN, OIN, XXX.</assert>
    </rule>
    <rule context="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode">
      <assert test="string-length() > 0">doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode must be filled</assert>
    </rule>
    <rule context="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode">
      <assert test="string-length() > 0">doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must be filled</assert>
    </rule>
    <rule context="doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode">
      <assert test="string-length() > 0">doc:Invoice/cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must be filled</assert>
    </rule>
    <rule context="doc:Invoice/cac:AllowanceCharge/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
      <assert test="empty(cbc:Name) or (cbc:Name='BTW') or (cbc:Name='Accijns') or (cbc:Name='Toeslag') or (cbc:Name='Overige')"> De soort belasting/heffing MOET geïdentificeerd worden met een code uit de lijst: BTW, Accijns, Toeslag, Overige.</assert>
    </rule>
    <rule context="doc:Invoice/cac:BillingReference/cac:InvoiceDocumentReference/cbc:ID">
      <assert test="string-length() > 0">doc:Invoice/cac:BillingReference/cac:InvoiceDocumentReference/cbc:ID must be filled</assert>
    </rule>
    <rule context="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:Contact">
      <assert test="matches(cbc:Telefax, '^[-0-9]*$')">Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</assert>
      <assert test="matches(cbc:Telephone, '^[-0-9]*$')">Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</assert>
    </rule>
    <rule context="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:Contact/cbc:Name">
      <assert test="string-length() > 0">doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:Contact/cbc:Name must be filled</assert>
    </rule>
    <rule context="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID">
      <assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</assert>
      <assert test="empty(@schemeAgencyName) or (@schemeAgencyName='KvK') or (@schemeAgencyName='Vest') or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')">Uitgevende organisatie van de PartijIdentificatie MOET geïdentificeerd worden door een code uit de lijst: KvK, Vest, BTW, Fi, BSN, OIN, XXX.</assert>
    </rule>
    <rule context="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode">
      <assert test="string-length() > 0">doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode must be filled</assert>
    </rule>
    <rule context="doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode">
      <assert test="string-length() > 0">doc:Invoice/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must be filled</assert>
    </rule>
    <rule context="doc:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode">
      <assert test="string-length() > 0">doc:Invoice/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must be filled</assert>
    </rule>
    <rule context="doc:Invoice/cac:DeliveryTerms/cbc:ID">
      <assert test="string-length() > 0">doc:Invoice/cac:DeliveryTerms/cbc:ID must be filled</assert>
      <assert test="empty(@schemeAgencyID) or (@schemeAgencyID='88')">doc:Invoice/cac:DeliveryTerms/cbc:ID/@schemeAgencyID must have one of the following values: [88]</assert>
      <assert test="empty(@schemeAgencyName) or (@schemeAgencyName='Logius Gegevensbeheer NL-Overheid')">doc:Invoice/cac:DeliveryTerms/cbc:ID/@schemeAgencyName must have one of the following values: [Logius Gegevensbeheer NL-Overheid]</assert>
      <assert test="empty(@schemeDataURI) or (@schemeDataURI='urn:digi-inkoop:ubl:2.0:NL:1.7:gc:DeliveryTermsCode')">doc:Invoice/cac:DeliveryTerms/cbc:ID/@schemeDataURI must have one of the following values: [urn:digi-inkoop:ubl:2.0:NL:1.7:gc:DeliveryTermsCode]</assert>
      <assert test="empty(@schemeID) or (@schemeID='NL-1002')">doc:Invoice/cac:DeliveryTerms/cbc:ID/@schemeID must have one of the following values: [NL-1002]</assert>
      <assert test="empty(@schemeName) or (@schemeName='DeliveryTermsCode')">doc:Invoice/cac:DeliveryTerms/cbc:ID/@schemeName must have one of the following values: [DeliveryTermsCode]</assert>
      <assert test="empty(@schemeURI) or (@schemeURI='http://www.nltaxonomie.nl/ubl/2.0/NL/1.7/cl/gc/DeliveryTermsCode.gc')">doc:Invoice/cac:DeliveryTerms/cbc:ID/@schemeURI must have one of the following values: [http://www.nltaxonomie.nl/ubl/2.0/NL/1.7/cl/gc/DeliveryTermsCode.gc]</assert>
      <assert test="empty(@schemeVersionID) or (@schemeVersionID='1.7')">doc:Invoice/cac:DeliveryTerms/cbc:ID/@schemeVersionID must have one of the following values: [1.7]</assert>
    </rule>
    <rule context="doc:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode">
      <assert test="string-length() > 0">doc:Invoice/cac:InvoiceLine/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must be filled</assert>
    </rule>
    <rule context="doc:Invoice/cac:InvoiceLine/cac:Item">
      <assert test="(count(cbc:Description) + count(cac:BuyersItemIdentification/cbc:ID) + count(cac:SellersItemIdentification/cbc:ID) + count(cac:ManufacturersItemIdentification/cbc:ID) + count(cac:StandardItemIdentification/cbc:ID) + count(cac:CatalogueItemIdentification/cbc:ID)) > 0">Item MOET een Description OF een (party)Identification/ID bevatten.</assert>
    </rule>
    <rule context="doc:Invoice/cac:InvoiceLine/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme">
      <assert test="empty(cbc:Name) or (cbc:Name='BTW') or (cbc:Name='Accijns') or (cbc:Name='Toeslag') or (cbc:Name='Overige')"> De soort belasting/heffing MOET geïdentificeerd worden met een code uit de lijst: BTW, Accijns, Toeslag, Overige.</assert>
    </rule>
    <rule context="doc:Invoice/cac:InvoiceLine/cac:Item/cbc:Name">
      <assert test="string-length() > 0">doc:Invoice/cac:InvoiceLine/cac:Item/cbc:Name must be filled</assert>
    </rule>
    <rule context="doc:Invoice/cac:InvoiceLine/cac:OrderLineReference/cbc:LineID">
      <assert test="string-length() > 0">doc:Invoice/cac:InvoiceLine/cac:OrderLineReference/cbc:LineID must be filled</assert>
    </rule>
    <rule context="doc:Invoice/cac:InvoiceLine/cac:Price/cbc:BaseQuantity/@unitCode">
      <assert test="string-length() > 0">doc:Invoice/cac:InvoiceLine/cac:Price/cbc:BaseQuantity/@unitCode must be filled</assert>
    </rule>
    <rule context="doc:Invoice/cac:InvoiceLine/cac:Price/cbc:PriceAmount">
      <assert test="(count(../../../cbc:PricingCurrencyCode) = 0)or( (count(../../../cbc:PricingCurrencyCode) > 0) and (@currencyID = ../../../cbc:PricingCurrencyCode/text()))"> Valutacode op regelniveau MOET gelijk zijn aan algemeen niveau als opgegeven.</assert>
    </rule>
    <rule context="doc:Invoice/cac:InvoiceLine/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
      <assert test="empty(cbc:Name) or (cbc:Name='BTW') or (cbc:Name='Accijns') or (cbc:Name='Toeslag') or (cbc:Name='Overige')"> De soort belasting/heffing MOET geïdentificeerd worden met een code uit de lijst: BTW, Accijns, Toeslag, Overige.</assert>
    </rule>
    <rule context="doc:Invoice/cac:InvoiceLine/cbc:InvoicedQuantity/@unitCode">
      <assert test="string-length() > 0">doc:Invoice/cac:InvoiceLine/cbc:InvoicedQuantity/@unitCode must be filled</assert>
    </rule>
    <rule context="doc:Invoice/cac:InvoicePeriod">
      <assert test="empty(cbc:DescriptionCode) or (cbc:DescriptionCode='I') or (cbc:DescriptionCode='D')">doc:Invoice/cac:InvoicePeriod/cbc:DescriptionCode must have one of the following values: [I, D]</assert>
    </rule>
    <rule context="doc:Invoice/cac:InvoicePeriod/cbc:DescriptionCode">
      <assert test="empty(@listAgencyID) or (@listAgencyID='88')">doc:Invoice/cac:InvoicePeriod/cbc:DescriptionCode/@listAgencyID must have one of the following values: [88]</assert>
      <assert test="empty(@listAgencyName) or (@listAgencyName='Logius Gegevensbeheer NL-Overheid')">doc:Invoice/cac:InvoicePeriod/cbc:DescriptionCode/@listAgencyName must have one of the following values: [Logius Gegevensbeheer NL-Overheid]</assert>
      <assert test="empty(@listID) or (@listID='NL-1004')">doc:Invoice/cac:InvoicePeriod/cbc:DescriptionCode/@listID must have one of the following values: [NL-1004]</assert>
      <assert test="empty(@listName) or (@listName='FactuurPeriodDescriptionCode')">doc:Invoice/cac:InvoicePeriod/cbc:DescriptionCode/@listName must have one of the following values: [FactuurPeriodDescriptionCode]</assert>
      <assert test="empty(@listSchemeURI) or (@listSchemeURI='urn:digi-inkoop:ubl:2.0:NL:1.7:gc:InvoicePeriodDescriptionCode')">doc:Invoice/cac:InvoicePeriod/cbc:DescriptionCode/@listSchemeURI must have one of the following values: [urn:digi-inkoop:ubl:2.0:NL:1.7:gc:InvoicePeriodDescriptionCode]</assert>
      <assert test="empty(@listURI) or (@listURI='http://www.nltaxonomie.nl/ubl/2.0/NL/1.7/cl/gc/InvoicePeriodDescriptionCode.gc')">doc:Invoice/cac:InvoicePeriod/cbc:DescriptionCode/@listURI must have one of the following values: [http://www.nltaxonomie.nl/ubl/2.0/NL/1.7/cl/gc/InvoicePeriodDescriptionCode.gc]</assert>
      <assert test="empty(@listVersionID) or (@listVersionID='1.7')">doc:Invoice/cac:InvoicePeriod/cbc:DescriptionCode/@listVersionID must have one of the following values: [1.7]</assert>
    </rule>
    <rule context="doc:Invoice/cac:OrderReference/cbc:ID">
      <assert test="string-length() > 0">doc:Invoice/cac:OrderReference/cbc:ID must be filled</assert>
    </rule>
    <rule context="doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode">
      <assert test="string-length() > 0">doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode must be filled</assert>
    </rule>
    <rule context="doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode">
      <assert test="string-length() > 0">doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode must be filled</assert>
    </rule>
    <rule context="doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID">
      <assert test="string-length() > 0">doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID must be filled</assert>
    </rule>
    <rule context="doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:ID">
      <assert test="string-length() > 0">doc:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:ID must be filled</assert>
    </rule>
    <rule context="doc:Invoice/cac:PaymentMeans/cbc:PaymentMeansCode">
      <assert test="string-length() > 0">doc:Invoice/cac:PaymentMeans/cbc:PaymentMeansCode must be filled</assert>
    </rule>
    <rule context="doc:Invoice/cac:PaymentTerms/cac:SettlementPeriod/cbc:DurationMeasure/@unitCode">
      <assert test="string-length() > 0">doc:Invoice/cac:PaymentTerms/cac:SettlementPeriod/cbc:DurationMeasure/@unitCode must be filled</assert>
    </rule>
    <rule context="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:Contact">
      <assert test="matches(cbc:Telefax, '^[-0-9]*$')">Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</assert>
      <assert test="matches(cbc:Telephone, '^[-0-9]*$')">Telefoon en Faxnummers mogen alleen uit nummers en afbreekstreepjes bestaan.</assert>
    </rule>
    <rule context="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name">
      <assert test="string-length() > 0">doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name must be filled</assert>
    </rule>
    <rule context="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID">
      <assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</assert>
      <assert test="empty(@schemeAgencyName) or (@schemeAgencyName='KvK') or (@schemeAgencyName='Vest') or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')">Uitgevende organisatie van de PartijIdentificatie MOET geïdentificeerd worden door een code uit de lijst: KvK, Vest, BTW, Fi, BSN, OIN, XXX.</assert>
    </rule>
    <rule context="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode">
      <assert test="string-length() > 0">doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PartyLegalEntity/cac:RegistrationAddress/cac:Country/cbc:IdentificationCode must be filled</assert>
    </rule>
    <rule context="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode">
      <assert test="string-length() > 0">doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must be filled</assert>
    </rule>
    <rule context="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode">
      <assert test="string-length() > 0">doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must be filled</assert>
    </rule>
    <rule context="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:CityName">
      <assert test="string-length() > 0">doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:CityName must be filled</assert>
    </rule>
    <rule context="doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:PostalZone">
      <assert test="string-length() > 0">doc:Invoice/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cbc:PostalZone must be filled</assert>
    </rule>
    <rule context="doc:Invoice/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
      <assert test="empty(cbc:Name) or (cbc:Name='BTW') or (cbc:Name='Accijns') or (cbc:Name='Toeslag') or (cbc:Name='Overige')"> De soort belasting/heffing MOET geïdentificeerd worden met een code uit de lijst: BTW, Accijns, Toeslag, Overige.</assert>
    </rule>
    <rule context="doc:Invoice/cbc:ID">
      <assert test="string-length() > 0">doc:Invoice/cbc:ID must be filled</assert>
      <assert test="string-length(text()) lt 25">Element lengte MOET minder dan 25 posities zijn.</assert>
    </rule>
    <rule context="doc:Invoice/cbc:InvoiceTypeCode">
      <assert test="string-length() > 0">doc:Invoice/cbc:InvoiceTypeCode must be filled</assert>
      <assert test="empty(@listAgencyID) or (@listAgencyID='88')">doc:Invoice/cbc:InvoiceTypeCode/@listAgencyID must have one of the following values: [88]</assert>
      <assert test="empty(@listAgencyName) or (@listAgencyName='Logius Gegevensbeheer NL-Overheid')">doc:Invoice/cbc:InvoiceTypeCode/@listAgencyName must have one of the following values: [Logius Gegevensbeheer NL-Overheid]</assert>
      <assert test="empty(@listID) or (@listID='NL-1001')">doc:Invoice/cbc:InvoiceTypeCode/@listID must have one of the following values: [NL-1001]</assert>
      <assert test="empty(@listName) or (@listName='FactuurSoort')">doc:Invoice/cbc:InvoiceTypeCode/@listName must have one of the following values: [FactuurSoort]</assert>
      <assert test="empty(@listSchemeURI) or (@listSchemeURI='urn:digi-inkoop:ubl:2.0:NL:1.7:gc:InvoiceTypeCode')">doc:Invoice/cbc:InvoiceTypeCode/@listSchemeURI must have one of the following values: [urn:digi-inkoop:ubl:2.0:NL:1.7:gc:InvoiceTypeCode]</assert>
      <assert test="empty(@listURI) or (@listURI='http://www.nltaxonomie.nl/ubl/2.0/NL/1.7/cl/gc/InvoiceTypeCode.gc')">doc:Invoice/cbc:InvoiceTypeCode/@listURI must have one of the following values: [http://www.nltaxonomie.nl/ubl/2.0/NL/1.7/cl/gc/InvoiceTypeCode.gc]</assert>
      <assert test="empty(@listVersionID) or (@listVersionID='1.7')">doc:Invoice/cbc:InvoiceTypeCode/@listVersionID must have one of the following values: [1.7]</assert>
    </rule>
    <rule context="doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent">
      <assert test="empty(nl-cbc:LastInvoiceOnOrderIndicator) or (nl-cbc:LastInvoiceOnOrderIndicator='true') or (nl-cbc:LastInvoiceOnOrderIndicator='false') or (nl-cbc:LastInvoiceOnOrderIndicator='1') or (nl-cbc:LastInvoiceOnOrderIndicator='0')">doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cbc:LastInvoiceOnOrderIndicator must have one of the following values: [true, false, 1, 0]</assert>
    </rule>
    <rule context="doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine">
      <assert test="index-of(//cac:InvoiceLine/cbc:ID, cbc:ID) &gt; 0">nl-cac:InvoiceLine/cbc:ID MOET verwijzen naar een bestaande cac:InvoiceLine/cbc:ID.</assert>
    </rule>
    <rule context="doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod">
      <assert test="empty(cbc:DescriptionCode) or (cbc:DescriptionCode='I') or (cbc:DescriptionCode='D')">doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod/cbc:DescriptionCode must have one of the following values: [I, D]</assert>
    </rule>
    <rule context="doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod/cbc:DescriptionCode">
      <assert test="empty(@listAgencyID) or (@listAgencyID='88')">doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod/cbc:DescriptionCode/@listAgencyID must have one of the following values: [88]</assert>
      <assert test="empty(@listAgencyName) or (@listAgencyName='Logius Gegevensbeheer NL-Overheid')">doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod/cbc:DescriptionCode/@listAgencyName must have one of the following values: [Logius Gegevensbeheer NL-Overheid]</assert>
      <assert test="empty(@listID) or (@listID='NL-1004')">doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod/cbc:DescriptionCode/@listID must have one of the following values: [NL-1004]</assert>
      <assert test="empty(@listName) or (@listName='FactuurPeriodDescriptionCode')">doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod/cbc:DescriptionCode/@listName must have one of the following values: [FactuurPeriodDescriptionCode]</assert>
      <assert test="empty(@listSchemeURI) or (@listSchemeURI='urn:digi-inkoop:ubl:2.0:NL:1.7:gc:InvoicePeriodDescriptionCode')">doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod/cbc:DescriptionCode/@listSchemeURI must have one of the following values: [urn:digi-inkoop:ubl:2.0:NL:1.7:gc:InvoicePeriodDescriptionCode]</assert>
      <assert test="empty(@listURI) or (@listURI='http://www.nltaxonomie.nl/ubl/2.0/NL/1.7/cl/gc/InvoicePeriodDescriptionCode.gc')">doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod/cbc:DescriptionCode/@listURI must have one of the following values: [http://www.nltaxonomie.nl/ubl/2.0/NL/1.7/cl/gc/InvoicePeriodDescriptionCode.gc]</assert>
      <assert test="empty(@listVersionID) or (@listVersionID='1.7')">doc:Invoice/ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/nl-cac:InvoiceLine/cac:InvoicePeriod/cbc:DescriptionCode/@listVersionID must have one of the following values: [1.7]</assert>
    </rule>
  </pattern>
</schema>
