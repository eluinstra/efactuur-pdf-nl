<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <title>Validations for Invoice Mapping; strict=false</title>
  <ns prefix="oagis" uri="http://www.openapplications.org/oagis" />
  <ns prefix="hrxml" uri="http://ns.hr-xml.org/2007-04-15" />
  <pattern id="prohibitions">
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:Salutation">
      <assert test="empty(@lang)">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName/oagis:Salutation may not contain @lang</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements">
      <assert test="empty(hrxml:PurchaseOrderLineItem)">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:PurchaseOrderLineItem</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line">
      <assert test="empty(oagis:Line)">oagis:Invoice/oagis:Line/oagis:Line may not contain oagis:Line</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Resource">
      <assert test="empty(@type)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Resource may not contain @type</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime">
      <assert test="empty(hrxml:Expense)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:Expense</assert>
      <assert test="empty(hrxml:TimeEvent)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:TimeEvent</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval">
      <assert test="empty(@dayAssignment)">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval may not contain @dayAssignment</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Resource">
      <assert test="empty(@type)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Resource may not contain @type</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime">
      <assert test="empty(hrxml:Expense)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:Expense</assert>
      <assert test="empty(hrxml:TimeEvent)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:TimeEvent</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval">
      <assert test="empty(@dayAssignment)">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval may not contain @dayAssignment</assert>
    </rule>
  </pattern>
  <pattern id="cardinality-redefines">
    <rule context="oagis:Invoice">
      <assert test="count(oagis:Header) &gt;= 1">oagis:Invoice must contain oagis:Header at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header">
      <assert test="count(oagis:DocumentDateTime) &gt;= 1">oagis:Invoice/oagis:Header must contain oagis:DocumentDateTime at least 1 time(s)</assert>
      <assert test="count(oagis:DocumentIds) &gt;= 1">oagis:Invoice/oagis:Header must contain oagis:DocumentIds at least 1 time(s)</assert>
      <assert test="count(oagis:Parties) &gt;= 1">oagis:Invoice/oagis:Header must contain oagis:Parties at least 1 time(s)</assert>
      <assert test="count(oagis:Reason) &lt;= 1">oagis:Invoice/oagis:Header may contain oagis:Reason at most 1 time(s)</assert>
      <assert test="count(oagis:UserArea) &gt;= 1">oagis:Invoice/oagis:Header must contain oagis:UserArea at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:DocumentIds">
      <assert test="count(oagis:DocumentId) &gt;= 1 and count(oagis:DocumentId) &lt;= 1">oagis:Invoice/oagis:Header/oagis:DocumentIds must contain oagis:DocumentId at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:DocumentIds/oagis:DocumentId">
      <assert test="count(oagis:Id) &gt;= 1">oagis:Invoice/oagis:Header/oagis:DocumentIds/oagis:DocumentId must contain oagis:Id at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties">
      <assert test="count(oagis:BillToParty) &gt;= 1 and count(oagis:BillToParty) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties must contain oagis:BillToParty at least 1 and at most 1 time(s)</assert>
      <assert test="count(oagis:CustomerParty) &gt;= 1 and count(oagis:CustomerParty) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties must contain oagis:CustomerParty at least 1 and at most 1 time(s)</assert>
      <assert test="count(oagis:RemitToParty) &gt;= 1 and count(oagis:RemitToParty) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties must contain oagis:RemitToParty at least 1 and at most 1 time(s)</assert>
      <assert test="count(oagis:SupplierParty) &gt;= 1 and count(oagis:SupplierParty) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties must contain oagis:SupplierParty at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty">
      <assert test="count(oagis:Addresses) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty must contain oagis:Addresses at least 1 time(s)</assert>
      <assert test="count(oagis:Name) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty must contain oagis:Name at least 1 time(s)</assert>
      <assert test="count(oagis:PartyId) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty must contain oagis:PartyId at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact">
      <assert test="count(oagis:Description) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact may contain oagis:Description at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName">
      <assert test="count(oagis:FamilyName) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:FamilyName at most 1 time(s)</assert>
      <assert test="count(oagis:GivenName) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:GivenName at most 1 time(s)</assert>
      <assert test="count(oagis:Salutation) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:Salutation at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:PartyId">
      <assert test="count(oagis:Id) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:BillToParty/oagis:PartyId must contain oagis:Id at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty">
      <assert test="count(oagis:Addresses) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty must contain oagis:Addresses at least 1 time(s)</assert>
      <assert test="count(oagis:Name) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty must contain oagis:Name at least 1 time(s)</assert>
      <assert test="count(oagis:PartyId) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty must contain oagis:PartyId at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses">
      <assert test="count(oagis:PrimaryAddress) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses must contain oagis:PrimaryAddress at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress">
      <assert test="count(oagis:AddressLine) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:AddressLine at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact">
      <assert test="count(oagis:Description) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact may contain oagis:Description at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName">
      <assert test="count(oagis:FamilyName) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:FamilyName at most 1 time(s)</assert>
      <assert test="count(oagis:GivenName) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:GivenName at most 1 time(s)</assert>
      <assert test="count(oagis:Salutation) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:Salutation at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:PartyId">
      <assert test="count(oagis:Id) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:CustomerParty/oagis:PartyId must contain oagis:Id at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty">
      <assert test="count(oagis:Addresses) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty must contain oagis:Addresses at least 1 time(s)</assert>
      <assert test="count(oagis:Name) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty must contain oagis:Name at least 1 time(s)</assert>
      <assert test="count(oagis:PartyId) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty must contain oagis:PartyId at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses">
      <assert test="count(oagis:PrimaryAddress) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses must contain oagis:PrimaryAddress at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress">
      <assert test="count(oagis:AddressLine) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:AddressLine at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact">
      <assert test="count(oagis:Description) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact may contain oagis:Description at most 1 time(s)</assert>
      <assert test="count(oagis:Telephone) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact may contain oagis:Telephone at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName">
      <assert test="count(oagis:FamilyName) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:FamilyName at most 1 time(s)</assert>
      <assert test="count(oagis:GivenName) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:GivenName at most 1 time(s)</assert>
      <assert test="count(oagis:Salutation) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:Salutation at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:PartyId">
      <assert test="count(oagis:Id) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:RemitToParty/oagis:PartyId must contain oagis:Id at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty">
      <assert test="count(oagis:Addresses) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty must contain oagis:Addresses at least 1 time(s)</assert>
      <assert test="count(oagis:Name) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty must contain oagis:Name at least 1 time(s)</assert>
      <assert test="count(oagis:PartyId) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty must contain oagis:PartyId at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses">
      <assert test="count(oagis:PrimaryAddress) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses must contain oagis:PrimaryAddress at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress">
      <assert test="count(oagis:AddressLine) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Addresses/oagis:PrimaryAddress may contain oagis:AddressLine at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact">
      <assert test="count(oagis:Description) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact may contain oagis:Description at most 1 time(s)</assert>
      <assert test="count(oagis:Telephone) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact may contain oagis:Telephone at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName">
      <assert test="count(oagis:FamilyName) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:FamilyName at most 1 time(s)</assert>
      <assert test="count(oagis:GivenName) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:GivenName at most 1 time(s)</assert>
      <assert test="count(oagis:Salutation) &lt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:Contacts/oagis:Contact/oagis:Person/oagis:PersonName may contain oagis:Salutation at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:PartyId">
      <assert test="count(oagis:Id) &gt;= 1">oagis:Invoice/oagis:Header/oagis:Parties/oagis:SupplierParty/oagis:PartyId must contain oagis:Id at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea">
      <assert test="count(hrxml:StaffingAdditionalData) &gt;= 1 and count(hrxml:StaffingAdditionalData) &lt;= 1">oagis:Invoice/oagis:Header/oagis:UserArea must contain hrxml:StaffingAdditionalData at least 1 and at most 1 time(s)</assert>
      <assert test="count(hrxml:StaffingOrganization) &lt;= 1">oagis:Invoice/oagis:Header/oagis:UserArea may contain hrxml:StaffingOrganization at most 1 time(s)</assert>
      <assert test="count(hrxml:StaffingOrganizationNL) &gt;= 1 and count(hrxml:StaffingOrganizationNL) &lt;= 1">oagis:Invoice/oagis:Header/oagis:UserArea must contain hrxml:StaffingOrganizationNL at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements">
      <assert test="count(hrxml:AdditionalRequirement) &gt;= 1">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements must contain hrxml:AdditionalRequirement at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement">
      <assert test="count(@requirementTitle) &gt;= 1">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must contain @requirementTitle at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation">
      <assert test="count(hrxml:StaffingCustomerOrgUnitId) &lt;= 1">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may contain hrxml:StaffingCustomerOrgUnitId at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId">
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization">
      <assert test="count(hrxml:Organization) &lt;= 1">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization may contain hrxml:Organization at most 1 time(s)</assert>
      <assert test="count(hrxml:PaymentInfo) &lt;= 1">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization may contain hrxml:PaymentInfo at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganizationNL">
      <assert test="count(hrxml:ChamberofCommerceReference) &gt;= 1">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganizationNL must contain hrxml:ChamberofCommerceReference at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Charges">
      <assert test="count(oagis:TotalCharge) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Charges must contain oagis:TotalCharge at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Charges/oagis:Charge">
      <assert test="count(oagis:Description) &lt;= 1">oagis:Invoice/oagis:Line/oagis:Charges/oagis:Charge may contain oagis:Description at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges">
      <assert test="count(oagis:TotalCharge) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges must contain oagis:TotalCharge at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges/oagis:Charge">
      <assert test="count(oagis:Description) &lt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:Charges/oagis:Charge may contain oagis:Description at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea">
      <assert test="count(hrxml:StaffingAdditionalData) &lt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea may contain hrxml:StaffingAdditionalData at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard">
      <assert test="count(hrxml:AdditionalData) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard must contain hrxml:AdditionalData at least 1 time(s)</assert>
      <assert test="count(hrxml:Id) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard must contain hrxml:Id at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData">
      <assert test="count(hrxml:StaffingAdditionalData) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData must contain hrxml:StaffingAdditionalData at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData">
      <assert test="count(hrxml:CustomerReportingRequirements) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData must contain hrxml:CustomerReportingRequirements at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement">
      <assert test="count(@requirementTitle) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must contain @requirementTitle at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId">
      <assert test="count(@idOwner) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId must contain @idOwner at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId">
      <assert test="count(@idOwner) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId must contain @idOwner at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId">
      <assert test="count(@idOwner) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId must contain @idOwner at least 1 time(s)</assert>
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName">
      <assert test="count(hrxml:Affix) &lt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName may contain hrxml:Affix at most 1 time(s)</assert>
      <assert test="count(hrxml:FamilyName) &lt;= 2">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName may contain hrxml:FamilyName at most 2 time(s)</assert>
      <assert test="count(hrxml:GivenName) &lt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName may contain hrxml:GivenName at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id">
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id">
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName">
      <assert test="count(hrxml:FamilyName) &lt;= 2">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName may contain hrxml:FamilyName at most 2 time(s)</assert>
      <assert test="count(hrxml:GivenName) &lt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName may contain hrxml:GivenName at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Resource">
      <assert test="count(hrxml:Id) &lt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Resource may contain hrxml:Id at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Resource/hrxml:Id">
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Resource/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance">
      <assert test="count(hrxml:Amount) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance must contain hrxml:Amount at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id">
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue">
      <assert test="count(@name) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue must contain @name at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:ReportedPersonAssignment/hrxml:Id">
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:ReportedPersonAssignment/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance">
      <assert test="count(hrxml:Amount) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance must contain hrxml:Amount at least 1 time(s)</assert>
      <assert test="count(hrxml:Id) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance must contain hrxml:Id at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance/hrxml:Id">
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance/hrxml:Id/hrxml:IdValue">
      <assert test="count(@name) &gt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance/hrxml:Id/hrxml:IdValue must contain @name at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id">
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:SubmitterInfo/hrxml:Person/hrxml:PersonName">
      <assert test="count(hrxml:FamilyName) &lt;= 2">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:SubmitterInfo/hrxml:Person/hrxml:PersonName may contain hrxml:FamilyName at most 2 time(s)</assert>
      <assert test="count(hrxml:GivenName) &lt;= 1">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:SubmitterInfo/hrxml:Person/hrxml:PersonName may contain hrxml:GivenName at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea">
      <assert test="count(hrxml:StaffingAdditionalData) &lt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea may contain hrxml:StaffingAdditionalData at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard">
      <assert test="count(hrxml:AdditionalData) &gt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard must contain hrxml:AdditionalData at least 1 time(s)</assert>
      <assert test="count(hrxml:Id) &gt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard must contain hrxml:Id at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData">
      <assert test="count(hrxml:StaffingAdditionalData) &gt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData must contain hrxml:StaffingAdditionalData at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData">
      <assert test="count(hrxml:CustomerReportingRequirements) &gt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData must contain hrxml:CustomerReportingRequirements at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement">
      <assert test="count(@requirementTitle) &gt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must contain @requirementTitle at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId">
      <assert test="count(@idOwner) &gt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId must contain @idOwner at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId">
      <assert test="count(@idOwner) &gt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId must contain @idOwner at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId">
      <assert test="count(@idOwner) &gt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId must contain @idOwner at least 1 time(s)</assert>
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName">
      <assert test="count(hrxml:Affix) &lt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName may contain hrxml:Affix at most 1 time(s)</assert>
      <assert test="count(hrxml:FamilyName) &lt;= 2">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName may contain hrxml:FamilyName at most 2 time(s)</assert>
      <assert test="count(hrxml:GivenName) &lt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName may contain hrxml:GivenName at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id">
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id">
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName">
      <assert test="count(hrxml:FamilyName) &lt;= 2">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName may contain hrxml:FamilyName at most 2 time(s)</assert>
      <assert test="count(hrxml:GivenName) &lt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName may contain hrxml:GivenName at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Resource">
      <assert test="count(hrxml:Id) &lt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Resource may contain hrxml:Id at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Resource/hrxml:Id">
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Resource/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance">
      <assert test="count(hrxml:Amount) &gt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance must contain hrxml:Amount at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id">
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue">
      <assert test="count(@name) &gt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue must contain @name at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:ReportedPersonAssignment/hrxml:Id">
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:ReportedPersonAssignment/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance">
      <assert test="count(hrxml:Amount) &gt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance must contain hrxml:Amount at least 1 time(s)</assert>
      <assert test="count(hrxml:Id) &gt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance must contain hrxml:Id at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance/hrxml:Id">
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance/hrxml:Id/hrxml:IdValue">
      <assert test="count(@name) &gt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance/hrxml:Id/hrxml:IdValue must contain @name at least 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id">
      <assert test="count(hrxml:IdValue) &lt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:SubmitterInfo/hrxml:Person/hrxml:PersonName">
      <assert test="count(hrxml:FamilyName) &lt;= 2">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:SubmitterInfo/hrxml:Person/hrxml:PersonName may contain hrxml:FamilyName at most 2 time(s)</assert>
      <assert test="count(hrxml:GivenName) &lt;= 1">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:SubmitterInfo/hrxml:Person/hrxml:PersonName may contain hrxml:GivenName at most 1 time(s)</assert>
    </rule>
  </pattern>
  <pattern id="type-restrictions">
    <rule context="oagis:Invoice/oagis:Header">
      <assert test="empty(oagis:Reason) or (oagis:Reason='Regular') or (oagis:Reason='Pro Forma') or (oagis:Reason='Self-Billed') or (oagis:Reason='regular') or (oagis:Reason='pro forma') or (oagis:Reason='self-billed')">oagis:Invoice/oagis:Header/oagis:Reason must have one of the following values: [Regular, Pro Forma, Self-Billed, regular, pro forma, self-billed]</assert>
      <assert test="empty(oagis:ReasonCode) or (oagis:ReasonCode='Services') or (oagis:ReasonCode='Hours') or (oagis:ReasonCode='Combination') or (oagis:ReasonCode='services') or (oagis:ReasonCode='hours') or (oagis:ReasonCode='combination')">oagis:Invoice/oagis:Header/oagis:ReasonCode must have one of the following values: [Services, Hours, Combination, services, hours, combination]</assert>
      <assert test="empty(oagis:Type) or (oagis:Type='Debit') or (oagis:Type='Credit') or (oagis:Type='Both')">oagis:Invoice/oagis:Header/oagis:Type must have one of the following values: [Debit, Credit, Both]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements">
      <assert test="count(hrxml:AdditionalRequirement[@requirementTitle = 'VersionId']) = 1">There MUST be one CustomerReportingRequirements/AdditionalRequirement with @requirementTitle equal to VersionId</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement[@requirementTitle = 'VersionId']">
      <assert test="text() = '1.8'">CustomerReportingRequirements/AdditionalRequirement must have value: 1.8 when requirementTitle is 'VersionId'.</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo/hrxml:BankAccountInfo/hrxml:BankInfoByJurisdiction">
      <assert test="empty(@bankJurisdiction) or (@bankJurisdiction='NL')">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo/hrxml:BankAccountInfo/hrxml:BankInfoByJurisdiction/@bankJurisdiction must have one of the following values: [NL]</assert>
      <assert test="empty(hrxml:BankAccountKey) or (hrxml:BankAccountKey='')">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo/hrxml:BankAccountInfo/hrxml:BankInfoByJurisdiction/hrxml:BankAccountKey must be Empty</assert>
      <assert test="empty(hrxml:BankWindow) or (hrxml:BankWindow='')">oagis:Invoice/oagis:Header/oagis:UserArea/hrxml:StaffingOrganization/hrxml:PaymentInfo/hrxml:BankAccountInfo/hrxml:BankInfoByJurisdiction/hrxml:BankWindow must be Empty</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line">
      <assert test="((count(oagis:Price) = 0) and (count(oagis:Line/oagis:Price) = count(oagis:Line))) or ((count(oagis:Price) > 0) and (count(oagis:Line/oagis:Price) = 0))">Price MOET OF op Line niveau OF voor alle Line/Lines worden opgegeven.</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:Tax/oagis:PercentQuantity">
      <assert test="exists(index-of(/oagis:Invoice/oagis:Header/oagis:Tax/oagis:PercentQuantity, text()))">Invoice/Line/Line/Tax/PercentQuantity must be available on Header level: <value-of select="text()"/></assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard">
      <assert test="(count(hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId) + count(hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:PurchaseOrderNumber)) &gt;= 1">There must be at least one AssignmentId or PurchaseOrderNumber on header level.</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation">
      <assert test="if (count(hrxml:StaffingCustomerOrgUnitId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingCustomerOrgUnitId[@idOwner = 'KvK']) = 1) else ('true')">If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.</assert>
      <assert test="if (count(hrxml:StaffingCustomerId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingCustomerId[@idOwner = 'KvK']) = 1) else ('true')">If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.</assert>
      <assert test="if (count(hrxml:StaffingSupplierId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingSupplierId[@idOwner = 'KvK']) = 1) else ('true')">If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.</assert>
      <assert test="count(hrxml:StaffingCustomerId/@idOwner) = count(distinct-values(hrxml:StaffingCustomerId/@idOwner))">The same idOwner may not be given for StaffingCustomerId</assert>
      <assert test="count(hrxml:StaffingCustomerOrgUnitId/@idOwner) = count(distinct-values(hrxml:StaffingCustomerOrgUnitId/@idOwner))">The same idOwner may not be given for StaffingCustomerOrgUnitId</assert>
      <assert test="count(hrxml:StaffingSupplierId/@idOwner) = count(distinct-values(hrxml:StaffingSupplierId/@idOwner))">The same idOwner may not be given for StaffingSupplierId</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId">
      <assert test="string-length() > 0">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId must be filled</assert>
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/@idOwner must have one of the following values: [StaffingCustomer, staffingCustomer, StaffingCompany, staffingCompany, OIN, KvK, BTW, Fi, Vest]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId">
      <assert test="string-length() > 0">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId must be filled</assert>
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/@idOwner must have one of the following values: [StaffingCustomer, staffingCustomer, StaffingCompany, staffingCompany, OIN, KvK, BTW, Fi, Vest]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId">
      <assert test="string-length() > 0">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId must be filled</assert>
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/@idOwner must have one of the following values: [StaffingCustomer, staffingCustomer, StaffingCompany, staffingCompany, OIN, KvK, BTW, Fi, Vest]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id">
      <assert test="(empty(@idOwner) or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer')) or (empty(@idOwner) or (@idOwner=''))">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id/@idOwner must have one of the following values: [StaffingCompany, staffingCompany, StaffingCustomer, staffingCustomer] OR oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id/@idOwner must be Empty</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue">
      <assert test="empty(@name) or (@name='allowance') or (@name='expense') or (@name='Expense') or (@name='Allowance')">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue/@name must have one of the following values: [allowance, expense, Expense, Allowance]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement">
      <assert test="empty(@requirementTitle) or (@requirementTitle='InclusiveRate') or (@requirementTitle='inclusiverate')">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement/@requirementTitle must have one of the following values: [InclusiveRate, inclusiverate]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance/hrxml:Id/hrxml:IdValue">
      <assert test="empty(@name) or (@name='expense') or (@name='allowance') or (@name='Expense') or (@name='Allowance')">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance/hrxml:Id/hrxml:IdValue/@name must have one of the following values: [expense, allowance, Expense, Allowance]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id/hrxml:IdValue">
      <assert test="empty(@name) or (@name='split') or (@name='consolidated')">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id/hrxml:IdValue/@name must have one of the following values: [split, consolidated]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount">
      <assert test="empty(@type) or (@type='hourly') or (@type='hourlysplit') or (@type='hourlyconsolidated') or (@type='daily') or (@type='dailysplit') or (@type='dailyconsolidated') or (@type='Hourly') or (@type='HourlySplit') or (@type='HourlyConsolidated') or (@type='Daily') or (@type='DailySplit') or (@type='DailyConsolidated')">oagis:Invoice/oagis:Line/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount/@type must have one of the following values: [hourly, hourlysplit, hourlyconsolidated, daily, dailysplit, dailyconsolidated, Hourly, HourlySplit, HourlyConsolidated, Daily, DailySplit, DailyConsolidated]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:Tax/oagis:PercentQuantity">
      <assert test="exists(index-of(/oagis:Invoice/oagis:Header/oagis:Tax/oagis:PercentQuantity, text()))">Invoice/Line/Tax/PercentQuantity must be available on Header level: <value-of select="text()"/></assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard">
      <assert test="count(../../oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:Id) = 0">Invoice Line must not contain TimeCard on Line/Line level when it has a TimeCard itself</assert>
      <assert test="(count(hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId) + count(hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:PurchaseOrderNumber)) &gt;= 1">There must be at least one AssignmentId or PurchaseOrderNumber on header level.</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation">
      <assert test="if (count(hrxml:StaffingCustomerOrgUnitId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingCustomerOrgUnitId[@idOwner = 'KvK']) = 1) else ('true')">If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.</assert>
      <assert test="if (count(hrxml:StaffingCustomerId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingCustomerId[@idOwner = 'KvK']) = 1) else ('true')">If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.</assert>
      <assert test="if (count(hrxml:StaffingSupplierId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingSupplierId[@idOwner = 'KvK']) = 1) else ('true')">If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.</assert>
      <assert test="count(hrxml:StaffingCustomerId/@idOwner) = count(distinct-values(hrxml:StaffingCustomerId/@idOwner))">The same idOwner may not be given for StaffingCustomerId</assert>
      <assert test="count(hrxml:StaffingCustomerOrgUnitId/@idOwner) = count(distinct-values(hrxml:StaffingCustomerOrgUnitId/@idOwner))">The same idOwner may not be given for StaffingCustomerOrgUnitId</assert>
      <assert test="count(hrxml:StaffingSupplierId/@idOwner) = count(distinct-values(hrxml:StaffingSupplierId/@idOwner))">The same idOwner may not be given for StaffingSupplierId</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId">
      <assert test="string-length() > 0">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId must be filled</assert>
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/@idOwner must have one of the following values: [StaffingCustomer, staffingCustomer, StaffingCompany, staffingCompany, OIN, KvK, BTW, Fi, Vest]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId">
      <assert test="string-length() > 0">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId must be filled</assert>
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/@idOwner must have one of the following values: [StaffingCustomer, staffingCustomer, StaffingCompany, staffingCompany, OIN, KvK, BTW, Fi, Vest]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId">
      <assert test="string-length() > 0">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId must be filled</assert>
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/@idOwner must have one of the following values: [StaffingCustomer, staffingCustomer, StaffingCompany, staffingCompany, OIN, KvK, BTW, Fi, Vest]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id">
      <assert test="(empty(@idOwner) or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer')) or (empty(@idOwner) or (@idOwner=''))">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id/@idOwner must have one of the following values: [StaffingCompany, staffingCompany, StaffingCustomer, staffingCustomer] OR oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id/@idOwner must be Empty</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue">
      <assert test="empty(@name) or (@name='allowance') or (@name='expense') or (@name='Expense') or (@name='Allowance')">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue/@name must have one of the following values: [allowance, expense, Expense, Allowance]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement">
      <assert test="empty(@requirementTitle) or (@requirementTitle='InclusiveRate') or (@requirementTitle='inclusiverate')">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement/@requirementTitle must have one of the following values: [InclusiveRate, inclusiverate]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance/hrxml:Id/hrxml:IdValue">
      <assert test="empty(@name) or (@name='expense') or (@name='allowance') or (@name='Expense') or (@name='Allowance')">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance/hrxml:Id/hrxml:IdValue/@name must have one of the following values: [expense, allowance, Expense, Allowance]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id/hrxml:IdValue">
      <assert test="empty(@name) or (@name='split') or (@name='consolidated')">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id/hrxml:IdValue/@name must have one of the following values: [split, consolidated]</assert>
    </rule>
    <rule context="oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount">
      <assert test="empty(@type) or (@type='hourly') or (@type='hourlysplit') or (@type='hourlyconsolidated') or (@type='daily') or (@type='dailysplit') or (@type='dailyconsolidated') or (@type='Hourly') or (@type='HourlySplit') or (@type='HourlyConsolidated') or (@type='Daily') or (@type='DailySplit') or (@type='DailyConsolidated')">oagis:Invoice/oagis:Line/oagis:UserArea/hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount/@type must have one of the following values: [hourly, hourlysplit, hourlyconsolidated, daily, dailysplit, dailyconsolidated, Hourly, HourlySplit, HourlyConsolidated, Daily, DailySplit, DailyConsolidated]</assert>
    </rule>
  </pattern>
</schema>
