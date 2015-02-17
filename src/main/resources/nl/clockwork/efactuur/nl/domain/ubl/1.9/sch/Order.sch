<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <title>Validations for Order Mapping; strict=false</title>
  <ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" />
  <ns prefix="doc" uri="urn:oasis:names:specification:ubl:schema:xsd:Order-2" />
  <ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" />
  <pattern id="cardinality-redefines">
    <rule context="doc:Order">
      <assert test="count(cbc:UBLVersionID) &gt;= 1">doc:Order must contain cbc:UBLVersionID at least 1 time(s)</assert>
      <assert test="count(cac:TaxTotal) &lt;= 1">doc:Order may contain cac:TaxTotal at most 1 time(s)</assert>
      <assert test="count(cbc:ProfileID) &gt;= 1">doc:Order must contain cbc:ProfileID at least 1 time(s)</assert>
      <assert test="count(cbc:Note) &lt;= 1">doc:Order may contain cbc:Note at most 1 time(s)</assert>
      <assert test="count(cbc:CustomizationID) &gt;= 1">doc:Order must contain cbc:CustomizationID at least 1 time(s)</assert>
      <assert test="count(cac:Contract) &lt;= 1">doc:Order may contain cac:Contract at most 1 time(s)</assert>
      <assert test="count(cac:Delivery) &gt;= 1">doc:Order must contain cac:Delivery at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:AccountingCustomerParty">
      <assert test="count(cac:Party) &gt;= 1">doc:Order/cac:AccountingCustomerParty must contain cac:Party at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:AccountingCustomerParty/cac:Party">
      <assert test="count(cac:PartyIdentification) &gt;= 1 and count(cac:PartyIdentification) &lt;= 3">doc:Order/cac:AccountingCustomerParty/cac:Party must contain cac:PartyIdentification at least 1 and at most 3 time(s)</assert>
      <assert test="count(cac:PartyName) &gt;= 1 and count(cac:PartyName) &lt;= 1">doc:Order/cac:AccountingCustomerParty/cac:Party must contain cac:PartyName at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification/cbc:ID">
      <assert test="count(@schemeAgencyID) &gt;= 1">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification/cbc:ID must contain @schemeAgencyID at least 1 time(s)</assert>
      <assert test="count(@schemeAgencyName) &gt;= 1">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode">
      <assert test="count(@listURI) &gt;= 1">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listURI at least 1 time(s)</assert>
      <assert test="count(@listVersionID) &gt;= 1">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listVersionID at least 1 time(s)</assert>
      <assert test="count(@listAgencyName) &gt;= 1">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listAgencyName at least 1 time(s)</assert>
      <assert test="count(@listID) &gt;= 1">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listID at least 1 time(s)</assert>
      <assert test="count(@listAgencyID) &gt;= 1">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listAgencyID at least 1 time(s)</assert>
      <assert test="count(@listName) &gt;= 1">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listName at least 1 time(s)</assert>
      <assert test="count(@listSchemeURI) &gt;= 1">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listSchemeURI at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID">
      <assert test="count(@schemeAgencyName) &gt;= 1">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)</assert>
      <assert test="count(@schemeAgencyID) &gt;= 1">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode">
      <assert test="count(@listVersionID) &gt;= 1">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listVersionID at least 1 time(s)</assert>
      <assert test="count(@listName) &gt;= 1">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listName at least 1 time(s)</assert>
      <assert test="count(@listID) &gt;= 1">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listID at least 1 time(s)</assert>
      <assert test="count(@listURI) &gt;= 1">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listURI at least 1 time(s)</assert>
      <assert test="count(@listAgencyID) &gt;= 1">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listAgencyID at least 1 time(s)</assert>
      <assert test="count(@listAgencyName) &gt;= 1">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listAgencyName at least 1 time(s)</assert>
      <assert test="count(@listSchemeURI) &gt;= 1">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listSchemeURI at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress">
      <assert test="count(cac:Country) &gt;= 1">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress must contain cac:Country at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode">
      <assert test="count(@listAgencyName) &gt;= 1">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listAgencyName at least 1 time(s)</assert>
      <assert test="count(@listID) &gt;= 1">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listID at least 1 time(s)</assert>
      <assert test="count(@listName) &gt;= 1">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listName at least 1 time(s)</assert>
      <assert test="count(@listSchemeURI) &gt;= 1">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listSchemeURI at least 1 time(s)</assert>
      <assert test="count(@listURI) &gt;= 1">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listURI at least 1 time(s)</assert>
      <assert test="count(@listVersionID) &gt;= 1">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listVersionID at least 1 time(s)</assert>
      <assert test="count(@listAgencyID) &gt;= 1">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listAgencyID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:AnticipatedMonetaryTotal">
      <assert test="count(cbc:TaxExclusiveAmount) &gt;= 1">doc:Order/cac:AnticipatedMonetaryTotal must contain cbc:TaxExclusiveAmount at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:BuyerCustomerParty">
      <assert test="count(cac:Party) &gt;= 1">doc:Order/cac:BuyerCustomerParty must contain cac:Party at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:BuyerCustomerParty/cac:Party">
      <assert test="count(cac:PartyName) &gt;= 1 and count(cac:PartyName) &lt;= 1">doc:Order/cac:BuyerCustomerParty/cac:Party must contain cac:PartyName at least 1 and at most 1 time(s)</assert>
      <assert test="count(cac:Contact) &gt;= 1">doc:Order/cac:BuyerCustomerParty/cac:Party must contain cac:Contact at least 1 time(s)</assert>
      <assert test="count(cac:PartyIdentification) &gt;= 1 and count(cac:PartyIdentification) &lt;= 3">doc:Order/cac:BuyerCustomerParty/cac:Party must contain cac:PartyIdentification at least 1 and at most 3 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty">
      <assert test="count(cac:PartyIdentification) &gt;= 1 and count(cac:PartyIdentification) &lt;= 3">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty must contain cac:PartyIdentification at least 1 and at most 3 time(s)</assert>
      <assert test="count(cac:PartyName) &lt;= 1">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty may contain cac:PartyName at most 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:Contact">
      <assert test="count(cbc:Name) &gt;= 1">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:Contact must contain cbc:Name at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification/cbc:ID">
      <assert test="count(@schemeAgencyName) &gt;= 1">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)</assert>
      <assert test="count(@schemeAgencyID) &gt;= 1">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification/cbc:ID must contain @schemeAgencyID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress">
      <assert test="count(cac:Country) &gt;= 1">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress must contain cac:Country at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode">
      <assert test="count(@listSchemeURI) &gt;= 1">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listSchemeURI at least 1 time(s)</assert>
      <assert test="count(@listName) &gt;= 1">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listName at least 1 time(s)</assert>
      <assert test="count(@listAgencyID) &gt;= 1">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listAgencyID at least 1 time(s)</assert>
      <assert test="count(@listVersionID) &gt;= 1">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listVersionID at least 1 time(s)</assert>
      <assert test="count(@listAgencyName) &gt;= 1">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listAgencyName at least 1 time(s)</assert>
      <assert test="count(@listID) &gt;= 1">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listID at least 1 time(s)</assert>
      <assert test="count(@listURI) &gt;= 1">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listURI at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:BuyerCustomerParty/cac:Party/cac:Contact">
      <assert test="count(cbc:Name) &gt;= 1">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:Contact must contain cbc:Name at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID">
      <assert test="count(@schemeAgencyID) &gt;= 1">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyID at least 1 time(s)</assert>
      <assert test="count(@schemeAgencyName) &gt;= 1">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation">
      <assert test="count(cac:Address) &gt;= 1">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation must contain cac:Address at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address">
      <assert test="count(cac:Country) &gt;= 1">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address must contain cac:Country at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode">
      <assert test="count(@listURI) &gt;= 1">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listURI at least 1 time(s)</assert>
      <assert test="count(@listSchemeURI) &gt;= 1">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listSchemeURI at least 1 time(s)</assert>
      <assert test="count(@listName) &gt;= 1">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listName at least 1 time(s)</assert>
      <assert test="count(@listVersionID) &gt;= 1">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listVersionID at least 1 time(s)</assert>
      <assert test="count(@listAgencyID) &gt;= 1">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listAgencyID at least 1 time(s)</assert>
      <assert test="count(@listAgencyName) &gt;= 1">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listAgencyName at least 1 time(s)</assert>
      <assert test="count(@listID) &gt;= 1">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must contain @listID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:Contract">
      <assert test="count(cbc:ID) &gt;= 1">doc:Order/cac:Contract must contain cbc:ID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:Delivery/cac:DeliveryAddress">
      <assert test="count(cac:Country) &gt;= 1">doc:Order/cac:Delivery/cac:DeliveryAddress must contain cac:Country at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:Delivery/cac:DeliveryAddress/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:Order/cac:Delivery/cac:DeliveryAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode">
      <assert test="count(@listSchemeURI) &gt;= 1">doc:Order/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must contain @listSchemeURI at least 1 time(s)</assert>
      <assert test="count(@listAgencyName) &gt;= 1">doc:Order/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must contain @listAgencyName at least 1 time(s)</assert>
      <assert test="count(@listVersionID) &gt;= 1">doc:Order/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must contain @listVersionID at least 1 time(s)</assert>
      <assert test="count(@listURI) &gt;= 1">doc:Order/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must contain @listURI at least 1 time(s)</assert>
      <assert test="count(@listID) &gt;= 1">doc:Order/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must contain @listID at least 1 time(s)</assert>
      <assert test="count(@listAgencyID) &gt;= 1">doc:Order/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must contain @listAgencyID at least 1 time(s)</assert>
      <assert test="count(@listName) &gt;= 1">doc:Order/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must contain @listName at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:Delivery/cac:Despatch">
      <assert test="count(cac:DespatchAddress) &gt;= 1">doc:Order/cac:Delivery/cac:Despatch must contain cac:DespatchAddress at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:Delivery/cac:Despatch/cac:DespatchAddress">
      <assert test="count(cac:Country) &gt;= 1">doc:Order/cac:Delivery/cac:Despatch/cac:DespatchAddress must contain cac:Country at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:Order/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country/cbc:IdentificationCode">
      <assert test="count(@listID) &gt;= 1">doc:Order/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country/cbc:IdentificationCode must contain @listID at least 1 time(s)</assert>
      <assert test="count(@listSchemeURI) &gt;= 1">doc:Order/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country/cbc:IdentificationCode must contain @listSchemeURI at least 1 time(s)</assert>
      <assert test="count(@listName) &gt;= 1">doc:Order/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country/cbc:IdentificationCode must contain @listName at least 1 time(s)</assert>
      <assert test="count(@listAgencyName) &gt;= 1">doc:Order/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country/cbc:IdentificationCode must contain @listAgencyName at least 1 time(s)</assert>
      <assert test="count(@listAgencyID) &gt;= 1">doc:Order/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country/cbc:IdentificationCode must contain @listAgencyID at least 1 time(s)</assert>
      <assert test="count(@listURI) &gt;= 1">doc:Order/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country/cbc:IdentificationCode must contain @listURI at least 1 time(s)</assert>
      <assert test="count(@listVersionID) &gt;= 1">doc:Order/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country/cbc:IdentificationCode must contain @listVersionID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:Delivery/cac:RequestedDeliveryPeriod">
      <assert test="count(cbc:EndDate) &gt;= 1">doc:Order/cac:Delivery/cac:RequestedDeliveryPeriod must contain cbc:EndDate at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:DeliveryTerms">
      <assert test="count(cbc:ID) &gt;= 1">doc:Order/cac:DeliveryTerms must contain cbc:ID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:DeliveryTerms/cbc:ID">
      <assert test="count(@schemeURI) &gt;= 1">doc:Order/cac:DeliveryTerms/cbc:ID must contain @schemeURI at least 1 time(s)</assert>
      <assert test="count(@schemeVersionID) &gt;= 1">doc:Order/cac:DeliveryTerms/cbc:ID must contain @schemeVersionID at least 1 time(s)</assert>
      <assert test="count(@schemeAgencyName) &gt;= 1">doc:Order/cac:DeliveryTerms/cbc:ID must contain @schemeAgencyName at least 1 time(s)</assert>
      <assert test="count(@schemeName) &gt;= 1">doc:Order/cac:DeliveryTerms/cbc:ID must contain @schemeName at least 1 time(s)</assert>
      <assert test="count(@schemeID) &gt;= 1">doc:Order/cac:DeliveryTerms/cbc:ID must contain @schemeID at least 1 time(s)</assert>
      <assert test="count(@schemeDataURI) &gt;= 1">doc:Order/cac:DeliveryTerms/cbc:ID must contain @schemeDataURI at least 1 time(s)</assert>
      <assert test="count(@schemeAgencyID) &gt;= 1">doc:Order/cac:DeliveryTerms/cbc:ID must contain @schemeAgencyID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:FreightForwarderParty">
      <assert test="count(cac:PartyName) &lt;= 1">doc:Order/cac:FreightForwarderParty may contain cac:PartyName at most 1 time(s)</assert>
      <assert test="count(cac:PartyIdentification) &gt;= 1 and count(cac:PartyIdentification) &lt;= 3">doc:Order/cac:FreightForwarderParty must contain cac:PartyIdentification at least 1 and at most 3 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:FreightForwarderParty/cac:PartyIdentification/cbc:ID">
      <assert test="count(@schemeAgencyName) &gt;= 1">doc:Order/cac:FreightForwarderParty/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)</assert>
      <assert test="count(@schemeAgencyID) &gt;= 1">doc:Order/cac:FreightForwarderParty/cac:PartyIdentification/cbc:ID must contain @schemeAgencyID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:OrderLine/cac:DocumentReference">
      <assert test="count(cbc:DocumentType) &gt;= 1">doc:Order/cac:OrderLine/cac:DocumentReference must contain cbc:DocumentType at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:OrderLine/cac:DocumentReference/cac:Attachment">
      <assert test="count(cbc:EmbeddedDocumentBinaryObject) &gt;= 1">doc:Order/cac:OrderLine/cac:DocumentReference/cac:Attachment must contain cbc:EmbeddedDocumentBinaryObject at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:OrderLine/cac:LineItem">
      <assert test="count(cbc:Quantity) &gt;= 1">doc:Order/cac:OrderLine/cac:LineItem must contain cbc:Quantity at least 1 time(s)</assert>
      <assert test="count(cac:Price) &gt;= 1">doc:Order/cac:OrderLine/cac:LineItem must contain cac:Price at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress">
      <assert test="count(cac:Country) &gt;= 1">doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress must contain cac:Country at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode">
      <assert test="count(@listID) &gt;= 1">doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must contain @listID at least 1 time(s)</assert>
      <assert test="count(@listAgencyID) &gt;= 1">doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must contain @listAgencyID at least 1 time(s)</assert>
      <assert test="count(@listSchemeURI) &gt;= 1">doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must contain @listSchemeURI at least 1 time(s)</assert>
      <assert test="count(@listURI) &gt;= 1">doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must contain @listURI at least 1 time(s)</assert>
      <assert test="count(@listVersionID) &gt;= 1">doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must contain @listVersionID at least 1 time(s)</assert>
      <assert test="count(@listAgencyName) &gt;= 1">doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must contain @listAgencyName at least 1 time(s)</assert>
      <assert test="count(@listName) &gt;= 1">doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must contain @listName at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty">
      <assert test="count(cac:PartyName) &gt;= 1 and count(cac:PartyName) &lt;= 1">doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty must contain cac:PartyName at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact">
      <assert test="count(cbc:Name) &gt;= 1">doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact must contain cbc:Name at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:RequestedDeliveryPeriod">
      <assert test="count(cbc:EndDate) &gt;= 1">doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:RequestedDeliveryPeriod must contain cbc:EndDate at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:OrderLine/cac:LineItem/cac:DeliveryTerms">
      <assert test="count(cbc:ID) &gt;= 1">doc:Order/cac:OrderLine/cac:LineItem/cac:DeliveryTerms must contain cbc:ID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID">
      <assert test="count(@schemeID) &gt;= 1">doc:Order/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID must contain @schemeID at least 1 time(s)</assert>
      <assert test="count(@schemeName) &gt;= 1">doc:Order/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID must contain @schemeName at least 1 time(s)</assert>
      <assert test="count(@schemeDataURI) &gt;= 1">doc:Order/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID must contain @schemeDataURI at least 1 time(s)</assert>
      <assert test="count(@schemeURI) &gt;= 1">doc:Order/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID must contain @schemeURI at least 1 time(s)</assert>
      <assert test="count(@schemeVersionID) &gt;= 1">doc:Order/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID must contain @schemeVersionID at least 1 time(s)</assert>
      <assert test="count(@schemeAgencyName) &gt;= 1">doc:Order/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID must contain @schemeAgencyName at least 1 time(s)</assert>
      <assert test="count(@schemeAgencyID) &gt;= 1">doc:Order/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID must contain @schemeAgencyID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:OrderLine/cac:LineItem/cac:Item">
      <assert test="count(cbc:Description) &lt;= 1">doc:Order/cac:OrderLine/cac:LineItem/cac:Item may contain cbc:Description at most 1 time(s)</assert>
      <assert test="count(cbc:CatalogueIndicator) &gt;= 1">doc:Order/cac:OrderLine/cac:LineItem/cac:Item must contain cbc:CatalogueIndicator at least 1 time(s)</assert>
      <assert test="count(cbc:Name) &gt;= 1">doc:Order/cac:OrderLine/cac:LineItem/cac:Item must contain cbc:Name at least 1 time(s)</assert>
      <assert test="count(cac:SellersItemIdentification) &gt;= 1">doc:Order/cac:OrderLine/cac:LineItem/cac:Item must contain cac:SellersItemIdentification at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:OrderLine/cac:LineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme">
      <assert test="count(cbc:Name) &gt;= 1">doc:Order/cac:OrderLine/cac:LineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme must contain cbc:Name at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:OrderLine/cac:LineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment">
      <assert test="count(cbc:EmbeddedDocumentBinaryObject) &gt;= 1">doc:Order/cac:OrderLine/cac:LineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment must contain cbc:EmbeddedDocumentBinaryObject at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:OrderLine/cac:LineItem/cbc:Quantity">
      <assert test="count(@unitCode) &gt;= 1">doc:Order/cac:OrderLine/cac:LineItem/cbc:Quantity must contain @unitCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount">
      <assert test="count(cbc:ID) &gt;= 1">doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount must contain cbc:ID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode">
      <assert test="count(@listURI) &gt;= 1">doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode must contain @listURI at least 1 time(s)</assert>
      <assert test="count(@listName) &gt;= 1">doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode must contain @listName at least 1 time(s)</assert>
      <assert test="count(@listID) &gt;= 1">doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode must contain @listID at least 1 time(s)</assert>
      <assert test="count(@listVersionID) &gt;= 1">doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode must contain @listVersionID at least 1 time(s)</assert>
      <assert test="count(@listAgencyName) &gt;= 1">doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode must contain @listAgencyName at least 1 time(s)</assert>
      <assert test="count(@listAgencyID) &gt;= 1">doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode must contain @listAgencyID at least 1 time(s)</assert>
      <assert test="count(@listSchemeURI) &gt;= 1">doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode must contain @listSchemeURI at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch">
      <assert test="count(cac:FinancialInstitution) &gt;= 1">doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch must contain cac:FinancialInstitution at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address">
      <assert test="count(cac:Country) &gt;= 1">doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address must contain cac:Country at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode">
      <assert test="count(@listName) &gt;= 1">doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode must contain @listName at least 1 time(s)</assert>
      <assert test="count(@listAgencyName) &gt;= 1">doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode must contain @listAgencyName at least 1 time(s)</assert>
      <assert test="count(@listVersionID) &gt;= 1">doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode must contain @listVersionID at least 1 time(s)</assert>
      <assert test="count(@listURI) &gt;= 1">doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode must contain @listURI at least 1 time(s)</assert>
      <assert test="count(@listSchemeURI) &gt;= 1">doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode must contain @listSchemeURI at least 1 time(s)</assert>
      <assert test="count(@listAgencyID) &gt;= 1">doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode must contain @listAgencyID at least 1 time(s)</assert>
      <assert test="count(@listID) &gt;= 1">doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode must contain @listID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution">
      <assert test="count(cbc:ID) &gt;= 1">doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution must contain cbc:ID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:PaymentMeans/cbc:PaymentMeansCode">
      <assert test="count(@listURI) &gt;= 1">doc:Order/cac:PaymentMeans/cbc:PaymentMeansCode must contain @listURI at least 1 time(s)</assert>
      <assert test="count(@listID) &gt;= 1">doc:Order/cac:PaymentMeans/cbc:PaymentMeansCode must contain @listID at least 1 time(s)</assert>
      <assert test="count(@listAgencyName) &gt;= 1">doc:Order/cac:PaymentMeans/cbc:PaymentMeansCode must contain @listAgencyName at least 1 time(s)</assert>
      <assert test="count(@listSchemeURI) &gt;= 1">doc:Order/cac:PaymentMeans/cbc:PaymentMeansCode must contain @listSchemeURI at least 1 time(s)</assert>
      <assert test="count(@listName) &gt;= 1">doc:Order/cac:PaymentMeans/cbc:PaymentMeansCode must contain @listName at least 1 time(s)</assert>
      <assert test="count(@listVersionID) &gt;= 1">doc:Order/cac:PaymentMeans/cbc:PaymentMeansCode must contain @listVersionID at least 1 time(s)</assert>
      <assert test="count(@listAgencyID) &gt;= 1">doc:Order/cac:PaymentMeans/cbc:PaymentMeansCode must contain @listAgencyID at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:SellerSupplierParty">
      <assert test="count(cac:Party) &gt;= 1">doc:Order/cac:SellerSupplierParty must contain cac:Party at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:SellerSupplierParty/cac:Party">
      <assert test="count(cac:PartyIdentification) &lt;= 3">doc:Order/cac:SellerSupplierParty/cac:Party may contain cac:PartyIdentification at most 3 time(s)</assert>
      <assert test="count(cac:PartyName) &gt;= 1 and count(cac:PartyName) &lt;= 1">doc:Order/cac:SellerSupplierParty/cac:Party must contain cac:PartyName at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:SellerSupplierParty/cac:Party/cac:Contact">
      <assert test="count(cbc:Name) &gt;= 1">doc:Order/cac:SellerSupplierParty/cac:Party/cac:Contact must contain cbc:Name at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID">
      <assert test="count(@schemeAgencyID) &gt;= 1">doc:Order/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyID at least 1 time(s)</assert>
      <assert test="count(@schemeAgencyName) &gt;= 1">doc:Order/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID must contain @schemeAgencyName at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:SellerSupplierParty/cac:Party/cac:PostalAddress">
      <assert test="count(cac:Country) &gt;= 1">doc:Order/cac:SellerSupplierParty/cac:Party/cac:PostalAddress must contain cac:Country at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country">
      <assert test="count(cbc:IdentificationCode) &gt;= 1">doc:Order/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country must contain cbc:IdentificationCode at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode">
      <assert test="count(@listName) &gt;= 1">doc:Order/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listName at least 1 time(s)</assert>
      <assert test="count(@listAgencyID) &gt;= 1">doc:Order/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listAgencyID at least 1 time(s)</assert>
      <assert test="count(@listURI) &gt;= 1">doc:Order/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listURI at least 1 time(s)</assert>
      <assert test="count(@listAgencyName) &gt;= 1">doc:Order/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listAgencyName at least 1 time(s)</assert>
      <assert test="count(@listVersionID) &gt;= 1">doc:Order/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listVersionID at least 1 time(s)</assert>
      <assert test="count(@listID) &gt;= 1">doc:Order/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listID at least 1 time(s)</assert>
      <assert test="count(@listSchemeURI) &gt;= 1">doc:Order/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must contain @listSchemeURI at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:TaxTotal">
      <assert test="count(cac:TaxSubtotal) &gt;= 1">doc:Order/cac:TaxTotal must contain cac:TaxSubtotal at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
      <assert test="count(cbc:Name) &gt;= 1">doc:Order/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme must contain cbc:Name at least 1 time(s)</assert>
    </rule>
    <rule context="doc:Order/cbc:DocumentCurrencyCode">
      <assert test="count(@listAgencyID) &gt;= 1">doc:Order/cbc:DocumentCurrencyCode must contain @listAgencyID at least 1 time(s)</assert>
      <assert test="count(@listURI) &gt;= 1">doc:Order/cbc:DocumentCurrencyCode must contain @listURI at least 1 time(s)</assert>
      <assert test="count(@listSchemeURI) &gt;= 1">doc:Order/cbc:DocumentCurrencyCode must contain @listSchemeURI at least 1 time(s)</assert>
      <assert test="count(@listID) &gt;= 1">doc:Order/cbc:DocumentCurrencyCode must contain @listID at least 1 time(s)</assert>
      <assert test="count(@listName) &gt;= 1">doc:Order/cbc:DocumentCurrencyCode must contain @listName at least 1 time(s)</assert>
      <assert test="count(@listAgencyName) &gt;= 1">doc:Order/cbc:DocumentCurrencyCode must contain @listAgencyName at least 1 time(s)</assert>
      <assert test="count(@listVersionID) &gt;= 1">doc:Order/cbc:DocumentCurrencyCode must contain @listVersionID at least 1 time(s)</assert>
    </rule>
  </pattern>
  <pattern id="type-restrictions">
    <rule context="doc:Order">
      <assert test="empty(cbc:UBLVersionID) or (cbc:UBLVersionID='2.0')">Bericht MOET gebaseerd zijn op UBL Versie 2.0</assert>
      <assert test="empty(cbc:ProfileID) or (cbc:ProfileID='NL')">Bericht MOET op de Nederlandse (NL) specificatie gebaseerd zijn.</assert>
      <assert test="empty(cbc:CustomizationID) or (cbc:CustomizationID='1.9')">Bericht MOET gebaseerd zijn op versie 1.9 van de Nederlandse specificatie.</assert>
      <assert test="every $bn in //cbc:BuildingNumber satisfies (matches($bn,'^\d+(-[ \w]+)?$'))">Huisnummer en Huisnummertoevoeging moeten achter elkaar geplaatst worden, gescheiden met een koppelteken.</assert>
      <assert test="every $id in //cac:PartyIdentification/cbc:ID satisfies (exists($id/@schemeAgencyID) and not(empty($id/@schemeAgencyID)) and exists($id/@schemeAgencyName) and not(empty($id/@schemeAgencyName)))">PartyIdentification/ID MOET @schemeAgencyID en @schemeAgencyName attributen bevatten.</assert>
      <assert test="every $pa in //cac:PostalAddress satisfies ((not(empty($pa/cbc:Postbox)) and empty($pa/cbc:StreetName) and empty($pa/cbc:BuildingNumber) and empty(cbc:Room) and empty(cbc:Floor) and empty(cbc:Department) and empty(cbc:InhouseMail) and empty(cbc:PlotIdentification)) or (empty($pa/cbc:Postbox) and (not(empty($pa/cbc:StreetName)) or not(empty($pa/cbc:BuildingNumber)) or not(empty(cbc:Room)) or not(empty(cbc:Floor)) or not(empty(cbc:Department)) or not(empty(cbc:InhouseMail)) or not(empty(cbc:PlotIdentification)))))">PostalAddress MOET OF een Postbox bevatten OF minimaal 1 van de elementen StreetName, BuildingNumber, Room, Floor, Department, InhouseMail of PlotIdentification. Beide MAG NIET.</assert>
      <assert test="( (count(cac:Delivery/cac:DeliveryAddress) = 0) and (count(cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress) = count(cac:OrderLine/cac:LineItem)))or( (count(cac:Delivery/cac:DeliveryAddress) > 0) and (count(cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress) = 0))"> Afleveradres MOET OF op algemeen niveau OF voor alle regels worden opgegeven.</assert>
      <assert test="( (count(cac:Delivery/cac:RequestedDeliveryPeriod) = 0) and (count(cac:OrderLine/cac:LineItem/cac:Delivery/cac:RequestedDeliveryPeriod) = count(cac:OrderLine/cac:LineItem)))or( (count(cac:Delivery/cac:RequestedDeliveryPeriod) > 0) and (count(cac:OrderLine/cac:LineItem/cac:Delivery/cac:RequestedDeliveryPeriod) = 0))"> Levertijd MOET OF op algemeen niveau OF voor alle regels worden opgegeven.</assert>
      <assert test="( (count(cbc:AccountingCostCode) = 0) and (count(cac:OrderLine/cac:LineItem/cbc:AccountingCostCode) = count(cac:OrderLine/cac:LineItem)))or( (count(cbc:AccountingCostCode) > 0) and (count(cac:OrderLine/cac:LineItem/cbc:AccountingCostCode) = 0))"> Kostenplaats MOET OF op algemeen niveau OF voor alle regels worden opgegeven.</assert>
      <assert test="(count(cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact) = count(cac:OrderLine/cac:LineItem))or(count(cac:SellerSupplierParty/cac:Party/cac:Contact) > 0)"> Leverancier contactpersoon MOET voor alle regels worden opgegeven ALS NIET op algemeen niveau opgegeven.</assert>
      <assert test="every $pi in //cac:PartyIdentification satisfies (if(count($pi/cbc:ID[@schemeAgencyName = 'Vest']) = 1) then (count($pi/../cac:PartyIdentification/cbc:ID[@schemeAgencyName = 'KvK']) = 1) else ('true'))">Als Vestigingsnummer is opgegeven MOET Kamer van Koophandel nummer ook opgegeven worden.</assert>
    </rule>
    <rule context="doc:Order/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification/cbc:ID">
      <assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</assert>
      <assert test="empty(@schemeAgencyName) or (@schemeAgencyName='KvK') or (@schemeAgencyName='Vest') or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')">Uitgevende organisatie van de PartijIdentificatie MOET geïdentificeerd worden door een code uit de lijst: KvK, Vest, BTW, Fi, BSN, OIN, XXX.</assert>
    </rule>
    <rule context="doc:Order/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode">
      <assert test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listURI must have one of the following values: [http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc]</assert>
      <assert test="empty(@listVersionID) or (@listVersionID='0.3')">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listVersionID must have one of the following values: [0.3]</assert>
      <assert test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listAgencyName must have one of the following values: [United Nations Economic Commission for Europe]</assert>
      <assert test="empty(@listID) or (@listID='ISO3166-1')">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listID must have one of the following values: [ISO3166-1]</assert>
      <assert test="empty(@listAgencyID) or (@listAgencyID='6')">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listAgencyID must have one of the following values: [6]</assert>
      <assert test="empty(@listName) or (@listName='Country')">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listName must have one of the following values: [Country]</assert>
      <assert test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listSchemeURI must have one of the following values: [urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode]</assert>
    </rule>
    <rule context="doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID">
      <assert test="empty(@schemeAgencyName) or (@schemeAgencyName='KvK') or (@schemeAgencyName='Vest') or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')">Uitgevende organisatie van de PartijIdentificatie MOET geïdentificeerd worden door een code uit de lijst: KvK, Vest, BTW, Fi, BSN, OIN, XXX.</assert>
      <assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</assert>
    </rule>
    <rule context="doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode">
      <assert test="empty(@listVersionID) or (@listVersionID='0.3')">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listVersionID must have one of the following values: [0.3]</assert>
      <assert test="empty(@listName) or (@listName='Country')">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listName must have one of the following values: [Country]</assert>
      <assert test="empty(@listID) or (@listID='ISO3166-1')">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listID must have one of the following values: [ISO3166-1]</assert>
      <assert test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listURI must have one of the following values: [http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc]</assert>
      <assert test="empty(@listAgencyID) or (@listAgencyID='6')">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listAgencyID must have one of the following values: [6]</assert>
      <assert test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listAgencyName must have one of the following values: [United Nations Economic Commission for Europe]</assert>
      <assert test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listSchemeURI must have one of the following values: [urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode]</assert>
    </rule>
    <rule context="doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode">
      <assert test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listAgencyName must have one of the following values: [United Nations Economic Commission for Europe]</assert>
      <assert test="string-length() > 0">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must be filled</assert>
      <assert test="empty(@listID) or (@listID='ISO3166-1')">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listID must have one of the following values: [ISO3166-1]</assert>
      <assert test="empty(@listName) or (@listName='Country')">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listName must have one of the following values: [Country]</assert>
      <assert test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listSchemeURI must have one of the following values: [urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode]</assert>
      <assert test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listURI must have one of the following values: [http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc]</assert>
      <assert test="empty(@listVersionID) or (@listVersionID='0.3')">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listVersionID must have one of the following values: [0.3]</assert>
      <assert test="empty(@listAgencyID) or (@listAgencyID='6')">doc:Order/cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listAgencyID must have one of the following values: [6]</assert>
    </rule>
    <rule context="doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:Contact/cbc:Name">
      <assert test="string-length() > 0">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:Contact/cbc:Name must be filled</assert>
    </rule>
    <rule context="doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PartyIdentification/cbc:ID">
      <assert test="empty(@schemeAgencyName) or (@schemeAgencyName='KvK') or (@schemeAgencyName='Vest') or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')">Uitgevende organisatie van de PartijIdentificatie MOET geïdentificeerd worden door een code uit de lijst: KvK, Vest, BTW, Fi, BSN, OIN, XXX.</assert>
      <assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</assert>
    </rule>
    <rule context="doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode">
      <assert test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listSchemeURI must have one of the following values: [urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode]</assert>
      <assert test="empty(@listName) or (@listName='Country')">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listName must have one of the following values: [Country]</assert>
      <assert test="empty(@listAgencyID) or (@listAgencyID='6')">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listAgencyID must have one of the following values: [6]</assert>
      <assert test="empty(@listVersionID) or (@listVersionID='0.3')">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listVersionID must have one of the following values: [0.3]</assert>
      <assert test="string-length() > 0">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode must be filled</assert>
      <assert test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listAgencyName must have one of the following values: [United Nations Economic Commission for Europe]</assert>
      <assert test="empty(@listID) or (@listID='ISO3166-1')">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listID must have one of the following values: [ISO3166-1]</assert>
      <assert test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:AgentParty/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listURI must have one of the following values: [http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc]</assert>
    </rule>
    <rule context="doc:Order/cac:BuyerCustomerParty/cac:Party/cac:Contact/cbc:Name">
      <assert test="string-length() > 0">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:Contact/cbc:Name must be filled</assert>
    </rule>
    <rule context="doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID">
      <assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</assert>
      <assert test="empty(@schemeAgencyName) or (@schemeAgencyName='KvK') or (@schemeAgencyName='Vest') or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')">Uitgevende organisatie van de PartijIdentificatie MOET geïdentificeerd worden door een code uit de lijst: KvK, Vest, BTW, Fi, BSN, OIN, XXX.</assert>
    </rule>
    <rule context="doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode">
      <assert test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listURI must have one of the following values: [http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc]</assert>
      <assert test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listSchemeURI must have one of the following values: [urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode]</assert>
      <assert test="empty(@listName) or (@listName='Country')">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listName must have one of the following values: [Country]</assert>
      <assert test="empty(@listVersionID) or (@listVersionID='0.3')">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listVersionID must have one of the following values: [0.3]</assert>
      <assert test="empty(@listAgencyID) or (@listAgencyID='6')">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listAgencyID must have one of the following values: [6]</assert>
      <assert test="string-length() > 0">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode must be filled</assert>
      <assert test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listAgencyName must have one of the following values: [United Nations Economic Commission for Europe]</assert>
      <assert test="empty(@listID) or (@listID='ISO3166-1')">doc:Order/cac:BuyerCustomerParty/cac:Party/cac:PhysicalLocation/cac:Address/cac:Country/cbc:IdentificationCode/@listID must have one of the following values: [ISO3166-1]</assert>
    </rule>
    <rule context="doc:Order/cac:Contract/cbc:ID">
      <assert test="string-length() > 0">doc:Order/cac:Contract/cbc:ID must be filled</assert>
    </rule>
    <rule context="doc:Order/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode">
      <assert test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')">doc:Order/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode/@listSchemeURI must have one of the following values: [urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode]</assert>
      <assert test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')">doc:Order/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode/@listAgencyName must have one of the following values: [United Nations Economic Commission for Europe]</assert>
      <assert test="empty(@listVersionID) or (@listVersionID='0.3')">doc:Order/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode/@listVersionID must have one of the following values: [0.3]</assert>
      <assert test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')">doc:Order/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode/@listURI must have one of the following values: [http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc]</assert>
      <assert test="string-length() > 0">doc:Order/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must be filled</assert>
      <assert test="empty(@listID) or (@listID='ISO3166-1')">doc:Order/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode/@listID must have one of the following values: [ISO3166-1]</assert>
      <assert test="empty(@listAgencyID) or (@listAgencyID='6')">doc:Order/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode/@listAgencyID must have one of the following values: [6]</assert>
      <assert test="empty(@listName) or (@listName='Country')">doc:Order/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode/@listName must have one of the following values: [Country]</assert>
    </rule>
    <rule context="doc:Order/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country/cbc:IdentificationCode">
      <assert test="empty(@listID) or (@listID='ISO3166-1')">doc:Order/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country/cbc:IdentificationCode/@listID must have one of the following values: [ISO3166-1]</assert>
      <assert test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')">doc:Order/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country/cbc:IdentificationCode/@listSchemeURI must have one of the following values: [urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode]</assert>
      <assert test="empty(@listName) or (@listName='Country')">doc:Order/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country/cbc:IdentificationCode/@listName must have one of the following values: [Country]</assert>
      <assert test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')">doc:Order/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country/cbc:IdentificationCode/@listAgencyName must have one of the following values: [United Nations Economic Commission for Europe]</assert>
      <assert test="empty(@listAgencyID) or (@listAgencyID='6')">doc:Order/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country/cbc:IdentificationCode/@listAgencyID must have one of the following values: [6]</assert>
      <assert test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')">doc:Order/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country/cbc:IdentificationCode/@listURI must have one of the following values: [http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc]</assert>
      <assert test="empty(@listVersionID) or (@listVersionID='0.3')">doc:Order/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country/cbc:IdentificationCode/@listVersionID must have one of the following values: [0.3]</assert>
      <assert test="string-length() > 0">doc:Order/cac:Delivery/cac:Despatch/cac:DespatchAddress/cac:Country/cbc:IdentificationCode must be filled</assert>
    </rule>
    <rule context="doc:Order/cac:DeliveryTerms/cbc:ID">
      <assert test="empty(@schemeURI) or (@schemeURI='http://www.nltaxonomie.nl/ubl/2.0/NL/1.8/cl/gc/DeliveryTermsCode.gc')">doc:Order/cac:DeliveryTerms/cbc:ID/@schemeURI must have one of the following values: [http://www.nltaxonomie.nl/ubl/2.0/NL/1.8/cl/gc/DeliveryTermsCode.gc]</assert>
      <assert test="empty(@schemeVersionID) or (@schemeVersionID='1.8')">doc:Order/cac:DeliveryTerms/cbc:ID/@schemeVersionID must have one of the following values: [1.8]</assert>
      <assert test="empty(@schemeAgencyName) or (@schemeAgencyName='Logius Gegevensbeheer NL-Overheid')">doc:Order/cac:DeliveryTerms/cbc:ID/@schemeAgencyName must have one of the following values: [Logius Gegevensbeheer NL-Overheid]</assert>
      <assert test="string-length() > 0">doc:Order/cac:DeliveryTerms/cbc:ID must be filled</assert>
      <assert test="empty(@schemeName) or (@schemeName='DeliveryTermsCode')">doc:Order/cac:DeliveryTerms/cbc:ID/@schemeName must have one of the following values: [DeliveryTermsCode]</assert>
      <assert test="empty(@schemeID) or (@schemeID='NL-1002')">doc:Order/cac:DeliveryTerms/cbc:ID/@schemeID must have one of the following values: [NL-1002]</assert>
      <assert test="empty(@schemeDataURI) or (@schemeDataURI='urn:digi-inkoop:ubl:2.0:NL:1.8:gc:DeliveryTermsCode')">doc:Order/cac:DeliveryTerms/cbc:ID/@schemeDataURI must have one of the following values: [urn:digi-inkoop:ubl:2.0:NL:1.8:gc:DeliveryTermsCode]</assert>
      <assert test="empty(@schemeAgencyID) or (@schemeAgencyID='88')">doc:Order/cac:DeliveryTerms/cbc:ID/@schemeAgencyID must have one of the following values: [88]</assert>
    </rule>
    <rule context="doc:Order/cac:FreightForwarderParty/cac:PartyIdentification/cbc:ID">
      <assert test="empty(@schemeAgencyName) or (@schemeAgencyName='KvK') or (@schemeAgencyName='Vest') or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')">Uitgevende organisatie van de PartijIdentificatie MOET geïdentificeerd worden door een code uit de lijst: KvK, Vest, BTW, Fi, BSN, OIN, XXX.</assert>
      <assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</assert>
    </rule>
    <rule context="doc:Order/cac:OrderLine/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject">
      <assert test="string-length() > 0">doc:Order/cac:OrderLine/cac:DocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject must be filled</assert>
    </rule>
    <rule context="doc:Order/cac:OrderLine/cac:DocumentReference/cbc:DocumentType">
      <assert test="string-length() > 0"> Indien de identificatie van een contract meegegeven wordt, moet hier 'Contract' opgegeven worden.</assert>
    </rule>
    <rule context="doc:Order/cac:OrderLine/cac:DocumentReference/cbc:ID">
      <assert test="string-length() > 0">doc:Order/cac:OrderLine/cac:DocumentReference/cbc:ID must be filled</assert>
    </rule>
    <rule context="doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode">
      <assert test="empty(@listID) or (@listID='ISO3166-1')">doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode/@listID must have one of the following values: [ISO3166-1]</assert>
      <assert test="empty(@listAgencyID) or (@listAgencyID='6')">doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode/@listAgencyID must have one of the following values: [6]</assert>
      <assert test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')">doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode/@listSchemeURI must have one of the following values: [urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode]</assert>
      <assert test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')">doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode/@listURI must have one of the following values: [http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc]</assert>
      <assert test="string-length() > 0">doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode must be filled</assert>
      <assert test="empty(@listVersionID) or (@listVersionID='0.3')">doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode/@listVersionID must have one of the following values: [0.3]</assert>
      <assert test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')">doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode/@listAgencyName must have one of the following values: [United Nations Economic Commission for Europe]</assert>
      <assert test="empty(@listName) or (@listName='Country')">doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryAddress/cac:Country/cbc:IdentificationCode/@listName must have one of the following values: [Country]</assert>
    </rule>
    <rule context="doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact/cbc:Name">
      <assert test="string-length() > 0">doc:Order/cac:OrderLine/cac:LineItem/cac:Delivery/cac:DeliveryParty/cac:Contact/cbc:Name must be filled</assert>
    </rule>
    <rule context="doc:Order/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID">
      <assert test="empty(@schemeID) or (@schemeID='NL-1002')">doc:Order/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID/@schemeID must have one of the following values: [NL-1002]</assert>
      <assert test="empty(@schemeName) or (@schemeName='DeliveryTermsCode')">doc:Order/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID/@schemeName must have one of the following values: [DeliveryTermsCode]</assert>
      <assert test="empty(@schemeDataURI) or (@schemeDataURI='urn:digi-inkoop:ubl:2.0:NL:1.8:gc:DeliveryTermsCode')">doc:Order/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID/@schemeDataURI must have one of the following values: [urn:digi-inkoop:ubl:2.0:NL:1.8:gc:DeliveryTermsCode]</assert>
      <assert test="empty(@schemeURI) or (@schemeURI='http://www.nltaxonomie.nl/ubl/2.0/NL/1.8/cl/gc/DeliveryTermsCode.gc')">doc:Order/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID/@schemeURI must have one of the following values: [http://www.nltaxonomie.nl/ubl/2.0/NL/1.8/cl/gc/DeliveryTermsCode.gc]</assert>
      <assert test="empty(@schemeVersionID) or (@schemeVersionID='1.8')">doc:Order/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID/@schemeVersionID must have one of the following values: [1.8]</assert>
      <assert test="empty(@schemeAgencyName) or (@schemeAgencyName='Logius Gegevensbeheer NL-Overheid')">doc:Order/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID/@schemeAgencyName must have one of the following values: [Logius Gegevensbeheer NL-Overheid]</assert>
      <assert test="empty(@schemeAgencyID) or (@schemeAgencyID='88')">doc:Order/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID/@schemeAgencyID must have one of the following values: [88]</assert>
      <assert test="string-length() > 0">doc:Order/cac:OrderLine/cac:LineItem/cac:DeliveryTerms/cbc:ID must be filled</assert>
    </rule>
    <rule context="doc:Order/cac:OrderLine/cac:LineItem/cac:Item">
      <assert test="(count(cbc:Description) + count(cac:BuyersItemIdentification/cbc:ID) + count(cac:SellersItemIdentification/cbc:ID) + count(cac:ManufacturersItemIdentification/cbc:ID) + count(cac:StandardItemIdentification/cbc:ID) + count(cac:CatalogueItemIdentification/cbc:ID)) > 0">Item MOET een Description OF een (party)Identification/ID bevatten.</assert>
    </rule>
    <rule context="doc:Order/cac:OrderLine/cac:LineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme">
      <assert test="empty(cbc:Name) or (cbc:Name='BTW') or (cbc:Name='Accijns') or (cbc:Name='Toeslag') or (cbc:Name='Overige')">doc:Order/cac:OrderLine/cac:LineItem/cac:Item/cac:ClassifiedTaxCategory/cac:TaxScheme/cbc:Name must have one of the following values: [BTW, Accijns, Toeslag, Overige]</assert>
    </rule>
    <rule context="doc:Order/cac:OrderLine/cac:LineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject">
      <assert test="string-length() > 0">doc:Order/cac:OrderLine/cac:LineItem/cac:Item/cac:ItemSpecificationDocumentReference/cac:Attachment/cbc:EmbeddedDocumentBinaryObject must be filled</assert>
    </rule>
    <rule context="doc:Order/cac:OrderLine/cac:LineItem/cac:Item/cbc:Name">
      <assert test="string-length() > 0">doc:Order/cac:OrderLine/cac:LineItem/cac:Item/cbc:Name must be filled</assert>
    </rule>
    <rule context="doc:Order/cac:OrderLine/cac:LineItem/cac:Price/cbc:BaseQuantity/@unitCode">
      <assert test="string-length() > 0">doc:Order/cac:OrderLine/cac:LineItem/cac:Price/cbc:BaseQuantity/@unitCode must be filled</assert>
    </rule>
    <rule context="doc:Order/cac:OrderLine/cac:LineItem/cac:Price/cbc:PriceAmount">
      <assert test="(count(../../../../cbc:PricingCurrencyCode) = 0)or( (count(../../../../cbc:PricingCurrencyCode) > 0) and (@currencyID = ../../../../cbc:PricingCurrencyCode/text()))">Valutacode op regelniveau MOET gelijk zijn aan algemeen niveau als opgegeven.</assert>
    </rule>
    <rule context="doc:Order/cac:OrderLine/cac:LineItem/cbc:Quantity/@unitCode">
      <assert test="string-length() > 0">doc:Order/cac:OrderLine/cac:LineItem/cbc:Quantity/@unitCode must be filled</assert>
    </rule>
    <rule context="doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode">
      <assert test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')">doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode/@listURI must have one of the following values: [http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc]</assert>
      <assert test="empty(@listName) or (@listName='Country')">doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode/@listName must have one of the following values: [Country]</assert>
      <assert test="empty(@listID) or (@listID='ISO3166-1')">doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode/@listID must have one of the following values: [ISO3166-1]</assert>
      <assert test="string-length() > 0">doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode must be filled</assert>
      <assert test="empty(@listVersionID) or (@listVersionID='0.3')">doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode/@listVersionID must have one of the following values: [0.3]</assert>
      <assert test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')">doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode/@listAgencyName must have one of the following values: [United Nations Economic Commission for Europe]</assert>
      <assert test="empty(@listAgencyID) or (@listAgencyID='6')">doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode/@listAgencyID must have one of the following values: [6]</assert>
      <assert test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')">doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:Country/cbc:IdentificationCode/@listSchemeURI must have one of the following values: [urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode]</assert>
    </rule>
    <rule context="doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode">
      <assert test="empty(@listName) or (@listName='Country')">doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode/@listName must have one of the following values: [Country]</assert>
      <assert test="string-length() > 0">doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode must be filled</assert>
      <assert test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')">doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode/@listAgencyName must have one of the following values: [United Nations Economic Commission for Europe]</assert>
      <assert test="empty(@listVersionID) or (@listVersionID='0.3')">doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode/@listVersionID must have one of the following values: [0.3]</assert>
      <assert test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')">doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode/@listURI must have one of the following values: [http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc]</assert>
      <assert test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')">doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode/@listSchemeURI must have one of the following values: [urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode]</assert>
      <assert test="empty(@listAgencyID) or (@listAgencyID='6')">doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode/@listAgencyID must have one of the following values: [6]</assert>
      <assert test="empty(@listID) or (@listID='ISO3166-1')">doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:Address/cac:Country/cbc:IdentificationCode/@listID must have one of the following values: [ISO3166-1]</assert>
    </rule>
    <rule context="doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID">
      <assert test="string-length() > 0">doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID must be filled</assert>
    </rule>
    <rule context="doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:ID">
      <assert test="string-length() > 0">doc:Order/cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:ID must be filled</assert>
    </rule>
    <rule context="doc:Order/cac:PaymentMeans/cbc:PaymentMeansCode">
      <assert test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/PaymentMeansCode-2.0.gc')">doc:Order/cac:PaymentMeans/cbc:PaymentMeansCode/@listURI must have one of the following values: [http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/PaymentMeansCode-2.0.gc]</assert>
      <assert test="empty(@listID) or (@listID='UN/ECE 4461')">doc:Order/cac:PaymentMeans/cbc:PaymentMeansCode/@listID must have one of the following values: [UN/ECE 4461]</assert>
      <assert test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')">doc:Order/cac:PaymentMeans/cbc:PaymentMeansCode/@listAgencyName must have one of the following values: [United Nations Economic Commission for Europe]</assert>
      <assert test="string-length() > 0">doc:Order/cac:PaymentMeans/cbc:PaymentMeansCode must be filled</assert>
      <assert test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:PaymentMeansCode')">doc:Order/cac:PaymentMeans/cbc:PaymentMeansCode/@listSchemeURI must have one of the following values: [urn:oasis:names:specification:ubl:codelist:gc:PaymentMeansCode]</assert>
      <assert test="empty(@listName) or (@listName='Payment Means')">doc:Order/cac:PaymentMeans/cbc:PaymentMeansCode/@listName must have one of the following values: [Payment Means]</assert>
      <assert test="empty(@listVersionID) or (@listVersionID='D03A')">doc:Order/cac:PaymentMeans/cbc:PaymentMeansCode/@listVersionID must have one of the following values: [D03A]</assert>
      <assert test="empty(@listAgencyID) or (@listAgencyID='6')">doc:Order/cac:PaymentMeans/cbc:PaymentMeansCode/@listAgencyID must have one of the following values: [6]</assert>
    </rule>
    <rule context="doc:Order/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name">
      <assert test="string-length() > 0">doc:Order/cac:SellerSupplierParty/cac:Party/cac:Contact/cbc:Name must be filled</assert>
    </rule>
    <rule context="doc:Order/cac:SellerSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID">
      <assert test="matches(@schemeAgencyID, '^[A-Z]{2}$')">Uitgevende organisatie van de PartijIdentificatie MOET tevens met een ISO3166-2 landencode bekend gemaakt worden (twee letters uppercase)</assert>
      <assert test="empty(@schemeAgencyName) or (@schemeAgencyName='KvK') or (@schemeAgencyName='Vest') or (@schemeAgencyName='BTW') or (@schemeAgencyName='Fi') or (@schemeAgencyName='BSN') or (@schemeAgencyName='OIN') or (@schemeAgencyName='XXX')">Uitgevende organisatie van de PartijIdentificatie MOET geïdentificeerd worden door een code uit de lijst: KvK, Vest, BTW, Fi, BSN, OIN, XXX.</assert>
    </rule>
    <rule context="doc:Order/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode">
      <assert test="empty(@listName) or (@listName='Country')">doc:Order/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listName must have one of the following values: [Country]</assert>
      <assert test="empty(@listAgencyID) or (@listAgencyID='6')">doc:Order/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listAgencyID must have one of the following values: [6]</assert>
      <assert test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc')">doc:Order/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listURI must have one of the following values: [http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/CountryIdentificationCode-2.0.gc]</assert>
      <assert test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')">doc:Order/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listAgencyName must have one of the following values: [United Nations Economic Commission for Europe]</assert>
      <assert test="empty(@listVersionID) or (@listVersionID='0.3')">doc:Order/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listVersionID must have one of the following values: [0.3]</assert>
      <assert test="empty(@listID) or (@listID='ISO3166-1')">doc:Order/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listID must have one of the following values: [ISO3166-1]</assert>
      <assert test="empty(@listSchemeURI) or (@listSchemeURI='urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode')">doc:Order/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode/@listSchemeURI must have one of the following values: [urn:oasis:names:specification:ubl:codelist:gc:CountryIdentificationCode]</assert>
      <assert test="string-length() > 0">doc:Order/cac:SellerSupplierParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode must be filled</assert>
    </rule>
    <rule context="doc:Order/cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme">
      <assert test="empty(cbc:Name) or (cbc:Name='BTW') or (cbc:Name='Accijns') or (cbc:Name='Toeslag') or (cbc:Name='Overige')"> De soort belasting/heffing MOET geïdentificeerd worden met een code uit de lijst: BTW, Accijns, Toeslag, Overige.</assert>
    </rule>
    <rule context="doc:Order/cbc:DocumentCurrencyCode">
      <assert test="empty(@listAgencyID) or (@listAgencyID='6')">doc:Order/cbc:DocumentCurrencyCode/@listAgencyID must have one of the following values: [6]</assert>
      <assert test="empty(@listURI) or (@listURI='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/cefact/CurrencyCode-2.0.gc')">doc:Order/cbc:DocumentCurrencyCode/@listURI must have one of the following values: [http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/cefact/CurrencyCode-2.0.gc]</assert>
      <assert test="empty(@listSchemeURI) or (@listSchemeURI='urn:un:unece:uncefact:codelist:specification:54217')">doc:Order/cbc:DocumentCurrencyCode/@listSchemeURI must have one of the following values: [urn:un:unece:uncefact:codelist:specification:54217]</assert>
      <assert test="empty(@listID) or (@listID='ISO 4217 Alpha')">doc:Order/cbc:DocumentCurrencyCode/@listID must have one of the following values: [ISO 4217 Alpha]</assert>
      <assert test="empty(@listName) or (@listName='Currency')">doc:Order/cbc:DocumentCurrencyCode/@listName must have one of the following values: [Currency]</assert>
      <assert test="empty(@listAgencyName) or (@listAgencyName='United Nations Economic Commission for Europe')">doc:Order/cbc:DocumentCurrencyCode/@listAgencyName must have one of the following values: [United Nations Economic Commission for Europe]</assert>
      <assert test="empty(@listVersionID) or (@listVersionID='2001')">doc:Order/cbc:DocumentCurrencyCode/@listVersionID must have one of the following values: [2001]</assert>
    </rule>
  </pattern>
</schema>
