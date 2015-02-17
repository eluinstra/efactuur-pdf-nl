<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <title>Validations for StaffingOrder Mapping; strict=false</title>
  <ns prefix="hrxml" uri="http://ns.hr-xml.org/2007-04-15" />
  <ns prefix="setu" uri="http://ns.setu.nl/2012-01" />
  <pattern id="prohibitions">
    <rule context="hrxml:StaffingOrder">
      <assert test="empty(@lang)">hrxml:StaffingOrder may not contain @lang</assert>
      <assert test="empty(hrxml:PositionQuantityOpen)">hrxml:StaffingOrder may not contain hrxml:PositionQuantityOpen</assert>
      <assert test="empty(hrxml:BillToAttention)">hrxml:StaffingOrder may not contain hrxml:BillToAttention</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:CustomerReportingRequirements">
      <assert test="empty(hrxml:LocationCode)">hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:LocationCode</assert>
      <assert test="empty(hrxml:ManagerName)">hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:ManagerName</assert>
      <assert test="empty(hrxml:SubEntity)">hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:SubEntity</assert>
      <assert test="empty(hrxml:PurchaseOrderLineItem)">hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:PurchaseOrderLineItem</assert>
      <assert test="empty(hrxml:SupervisorName)">hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:SupervisorName</assert>
      <assert test="empty(hrxml:ExternalReqNumber)">hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalReqNumber</assert>
      <assert test="empty(hrxml:ExternalOrderNumber)">hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalOrderNumber</assert>
      <assert test="empty(hrxml:ContactName)">hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:ContactName</assert>
      <assert test="empty(hrxml:PurchaseOrderNumber)">hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:PurchaseOrderNumber</assert>
      <assert test="empty(hrxml:CustomerJobDescription)">hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobDescription</assert>
      <assert test="empty(hrxml:LocationName)">hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:LocationName</assert>
      <assert test="empty(hrxml:CustomerJobCode)">hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobCode</assert>
      <assert test="empty(hrxml:Entity)">hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:Entity</assert>
      <assert test="empty(hrxml:AccountCode)">hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:AccountCode</assert>
      <assert test="empty(hrxml:Shift)">hrxml:StaffingOrder/hrxml:CustomerReportingRequirements may not contain hrxml:Shift</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo">
      <assert test="empty(hrxml:ContactId)">hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo may not contain hrxml:ContactId</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod">
      <assert test="empty(hrxml:Use)">hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod may not contain hrxml:Use</assert>
      <assert test="empty(hrxml:TTYTDD)">hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod may not contain hrxml:TTYTDD</assert>
      <assert test="empty(hrxml:Location)">hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod may not contain hrxml:Location</assert>
      <assert test="empty(hrxml:PostalAddress)">hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod may not contain hrxml:PostalAddress</assert>
      <assert test="empty(hrxml:WhenAvailable)">hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod may not contain hrxml:WhenAvailable</assert>
      <assert test="empty(hrxml:Pager)">hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod may not contain hrxml:Pager</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Fax">
      <assert test="empty(hrxml:SubscriberNumber)">hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:SubscriberNumber</assert>
      <assert test="empty(hrxml:InternationalCountryCode)">hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:InternationalCountryCode</assert>
      <assert test="empty(hrxml:Extension)">hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:Extension</assert>
      <assert test="empty(hrxml:NationalNumber)">hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:NationalNumber</assert>
      <assert test="empty(hrxml:AreaCityCode)">hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:AreaCityCode</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Mobile">
      <assert test="empty(hrxml:AreaCityCode)">hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:AreaCityCode</assert>
      <assert test="empty(@smsEnabled)">hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain @smsEnabled</assert>
      <assert test="empty(hrxml:Extension)">hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:Extension</assert>
      <assert test="empty(hrxml:InternationalCountryCode)">hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:InternationalCountryCode</assert>
      <assert test="empty(hrxml:NationalNumber)">hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:NationalNumber</assert>
      <assert test="empty(hrxml:SubscriberNumber)">hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:SubscriberNumber</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Telephone">
      <assert test="empty(hrxml:SubscriberNumber)">hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:SubscriberNumber</assert>
      <assert test="empty(hrxml:NationalNumber)">hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:NationalNumber</assert>
      <assert test="empty(hrxml:AreaCityCode)">hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:AreaCityCode</assert>
      <assert test="empty(hrxml:Extension)">hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:Extension</assert>
      <assert test="empty(hrxml:InternationalCountryCode)">hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:InternationalCountryCode</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:PersonName">
      <assert test="empty(hrxml:Affix)">hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:PersonName may not contain hrxml:Affix</assert>
      <assert test="empty(hrxml:PreferredGivenName)">hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:PersonName may not contain hrxml:PreferredGivenName</assert>
      <assert test="empty(hrxml:MiddleName)">hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:PersonName may not contain hrxml:MiddleName</assert>
      <assert test="empty(hrxml:FamilyName)">hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:PersonName may not contain hrxml:FamilyName</assert>
      <assert test="empty(hrxml:AlternateScript)">hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:PersonName may not contain hrxml:AlternateScript</assert>
      <assert test="empty(hrxml:GivenName)">hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:PersonName may not contain hrxml:GivenName</assert>
      <assert test="empty(@script)">hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:PersonName may not contain @script</assert>
      <assert test="empty(hrxml:LegalName)">hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:PersonName may not contain hrxml:LegalName</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:OrderId/hrxml:IdValue">
      <assert test="empty(@name)">hrxml:StaffingOrder/hrxml:OrderId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:ReferenceInformation">
      <assert test="empty(hrxml:BillToEntityId)">hrxml:StaffingOrder/hrxml:ReferenceInformation may not contain hrxml:BillToEntityId</assert>
      <assert test="empty(hrxml:HumanResourceId)">hrxml:StaffingOrder/hrxml:ReferenceInformation may not contain hrxml:HumanResourceId</assert>
      <assert test="empty(hrxml:UserArea)">hrxml:StaffingOrder/hrxml:ReferenceInformation may not contain hrxml:UserArea</assert>
      <assert test="empty(hrxml:AssignmentId)">hrxml:StaffingOrder/hrxml:ReferenceInformation may not contain hrxml:AssignmentId</assert>
      <assert test="empty(hrxml:StaffingOrganizationId)">hrxml:StaffingOrder/hrxml:ReferenceInformation may not contain hrxml:StaffingOrganizationId</assert>
      <assert test="empty(hrxml:TimeCardId)">hrxml:StaffingOrder/hrxml:ReferenceInformation may not contain hrxml:TimeCardId</assert>
      <assert test="empty(hrxml:InvoiceId)">hrxml:StaffingOrder/hrxml:ReferenceInformation may not contain hrxml:InvoiceId</assert>
      <assert test="empty(hrxml:PositionId)">hrxml:StaffingOrder/hrxml:ReferenceInformation may not contain hrxml:PositionId</assert>
      <assert test="empty(hrxml:IntermediaryId)">hrxml:StaffingOrder/hrxml:ReferenceInformation may not contain hrxml:IntermediaryId</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:MasterOrderId">
      <assert test="empty(@validFrom)">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:MasterOrderId may not contain @validFrom</assert>
      <assert test="empty(@validTo)">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:MasterOrderId may not contain @validTo</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:MasterOrderId/hrxml:IdValue">
      <assert test="empty(@name)">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:MasterOrderId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId">
      <assert test="empty(@validFrom)">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may not contain @validFrom</assert>
      <assert test="empty(@validTo)">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may not contain @validTo</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/hrxml:IdValue">
      <assert test="empty(@name)">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId">
      <assert test="empty(@validTo)">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may not contain @validTo</assert>
      <assert test="empty(@validFrom)">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may not contain @validFrom</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/hrxml:IdValue">
      <assert test="empty(@name)">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId">
      <assert test="empty(@validTo)">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may not contain @validTo</assert>
      <assert test="empty(@validFrom)">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may not contain @validFrom</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/hrxml:IdValue">
      <assert test="empty(@name)">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId">
      <assert test="empty(@validFrom)">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may not contain @validFrom</assert>
      <assert test="empty(@validTo)">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may not contain @validTo</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/hrxml:IdValue">
      <assert test="empty(@name)">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition">
      <assert test="empty(@lang)">hrxml:StaffingOrder/hrxml:StaffingPosition may not contain @lang</assert>
      <assert test="empty(hrxml:InvoiceInfo)">hrxml:StaffingOrder/hrxml:StaffingPosition may not contain hrxml:InvoiceInfo</assert>
      <assert test="empty(hrxml:WorkSiteEnvironment)">hrxml:StaffingOrder/hrxml:StaffingPosition may not contain hrxml:WorkSiteEnvironment</assert>
      <assert test="empty(hrxml:PositionRequirements)">hrxml:StaffingOrder/hrxml:StaffingPosition may not contain hrxml:PositionRequirements</assert>
      <assert test="empty(hrxml:ReportToPerson)">hrxml:StaffingOrder/hrxml:StaffingPosition may not contain hrxml:ReportToPerson</assert>
      <assert test="empty(hrxml:DepartmentName)">hrxml:StaffingOrder/hrxml:StaffingPosition may not contain hrxml:DepartmentName</assert>
      <assert test="empty(hrxml:PositionContact)">hrxml:StaffingOrder/hrxml:StaffingPosition may not contain hrxml:PositionContact</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements">
      <assert test="empty(hrxml:ContactName)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:ContactName</assert>
      <assert test="empty(hrxml:ExternalOrderNumber)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalOrderNumber</assert>
      <assert test="empty(hrxml:ManagerName)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:ManagerName</assert>
      <assert test="empty(hrxml:LocationCode)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:LocationCode</assert>
      <assert test="empty(hrxml:DepartmentName)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:DepartmentName</assert>
      <assert test="empty(hrxml:CostCenterName)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:CostCenterName</assert>
      <assert test="empty(hrxml:LocationName)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:LocationName</assert>
      <assert test="empty(hrxml:CustomerJobDescription)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobDescription</assert>
      <assert test="empty(hrxml:SubEntity)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:SubEntity</assert>
      <assert test="empty(hrxml:PurchaseOrderLineItem)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:PurchaseOrderLineItem</assert>
      <assert test="empty(hrxml:ExternalReqNumber)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalReqNumber</assert>
      <assert test="empty(hrxml:AdditionalRequirement)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:AdditionalRequirement</assert>
      <assert test="empty(hrxml:AccountCode)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:AccountCode</assert>
      <assert test="empty(hrxml:ProjectCode)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:ProjectCode</assert>
      <assert test="empty(hrxml:CustomerReferenceNumber)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerReferenceNumber</assert>
      <assert test="empty(hrxml:CostCenterCode)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:CostCenterCode</assert>
      <assert test="empty(hrxml:Shift)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:Shift</assert>
      <assert test="empty(hrxml:Entity)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:Entity</assert>
      <assert test="empty(hrxml:DepartmentCode)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:DepartmentCode</assert>
      <assert test="empty(hrxml:SupervisorName)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:SupervisorName</assert>
      <assert test="empty(hrxml:PurchaseOrderNumber)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:PurchaseOrderNumber</assert>
      <assert test="empty(hrxml:CustomerJobCode)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobCode</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionDateRange">
      <assert test="empty(hrxml:PositionDuration)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionDateRange may not contain hrxml:PositionDuration</assert>
      <assert test="empty(hrxml:StartAsSoonAsPossible)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionDateRange may not contain hrxml:StartAsSoonAsPossible</assert>
      <assert test="empty(hrxml:ExtensionParameters)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionDateRange may not contain hrxml:ExtensionParameters</assert>
      <assert test="empty(hrxml:MaxStartDate)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionDateRange may not contain hrxml:MaxStartDate</assert>
      <assert test="empty(hrxml:MaxNeedEndDate)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionDateRange may not contain hrxml:MaxNeedEndDate</assert>
      <assert test="empty(hrxml:ActualEndDate)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionDateRange may not contain hrxml:ActualEndDate</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader">
      <assert test="empty(hrxml:PositionSpecificCondition)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:PositionSpecificCondition</assert>
      <assert test="empty(hrxml:OvertimeInfo)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:OvertimeInfo</assert>
      <assert test="empty(hrxml:BusyPeriodInfo)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:BusyPeriodInfo</assert>
      <assert test="empty(hrxml:HolidayWork)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:HolidayWork</assert>
      <assert test="empty(@validTo)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain @validTo</assert>
      <assert test="empty(hrxml:ReportToPositionId)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:ReportToPositionId</assert>
      <assert test="empty(@validFrom)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain @validFrom</assert>
      <assert test="empty(hrxml:FormattedPositionDescription)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:FormattedPositionDescription</assert>
      <assert test="empty(hrxml:PositionMustEndByInfo)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:PositionMustEndByInfo</assert>
      <assert test="empty(hrxml:Quantity)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:Quantity</assert>
      <assert test="empty(hrxml:TransitionInfo)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:TransitionInfo</assert>
      <assert test="empty(hrxml:TypeOfHours)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:TypeOfHours</assert>
      <assert test="empty(hrxml:PositionStatus)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:PositionStatus</assert>
      <assert test="empty(hrxml:LocalStaffingPositionInfo)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:LocalStaffingPositionInfo</assert>
      <assert test="empty(hrxml:SpecialInstructions)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:SpecialInstructions</assert>
      <assert test="empty(hrxml:JobCategory)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may not contain hrxml:JobCategory</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:JobId">
      <assert test="empty(hrxml:Domain)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:JobId may not contain hrxml:Domain</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:PositionId">
      <assert test="empty(hrxml:Domain)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:PositionId may not contain hrxml:Domain</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson">
      <assert test="empty(hrxml:Supplier)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson may not contain hrxml:Supplier</assert>
      <assert test="empty(@currentlyAssigned)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson may not contain @currentlyAssigned</assert>
      <assert test="empty(@mandatory)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson may not contain @mandatory</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonId">
      <assert test="empty(@validTo)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonId may not contain @validTo</assert>
      <assert test="empty(@validFrom)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonId may not contain @validFrom</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonId/hrxml:IdValue">
      <assert test="empty(@name)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonName">
      <assert test="empty(hrxml:AlternateScript)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonName may not contain hrxml:AlternateScript</assert>
      <assert test="empty(@script)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonName may not contain @script</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates">
      <assert test="empty(@lang)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates may not contain @lang</assert>
      <assert test="empty(hrxml:BillingMultiplier)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates may not contain hrxml:BillingMultiplier</assert>
      <assert test="empty(hrxml:TimeWorkedRounding)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates may not contain hrxml:TimeWorkedRounding</assert>
      <assert test="empty(hrxml:StaffingShiftId)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates may not contain hrxml:StaffingShiftId</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:CustomerRateClassification">
      <assert test="empty(@validFrom)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:CustomerRateClassification may not contain @validFrom</assert>
      <assert test="empty(@validTo)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:CustomerRateClassification may not contain @validTo</assert>
      <assert test="empty(@idOwner)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:CustomerRateClassification may not contain @idOwner</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:ExternalRateSetId">
      <assert test="empty(@validTo)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:ExternalRateSetId may not contain @validTo</assert>
      <assert test="empty(@validFrom)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:ExternalRateSetId may not contain @validFrom</assert>
      <assert test="empty(@idOwner)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:ExternalRateSetId may not contain @idOwner</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:ExternalRateSetId/hrxml:IdValue">
      <assert test="empty(@name)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:ExternalRateSetId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:Multiplier">
      <assert test="empty(@percentIndicator)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:Multiplier may not contain @percentIndicator</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:RatesId">
      <assert test="empty(@validTo)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:RatesId may not contain @validTo</assert>
      <assert test="empty(@validFrom)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:RatesId may not contain @validFrom</assert>
      <assert test="empty(@idOwner)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:RatesId may not contain @idOwner</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:RatesId/hrxml:IdValue">
      <assert test="empty(@name)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:RatesId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift">
      <assert test="empty(hrxml:Name)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift may not contain hrxml:Name</assert>
      <assert test="empty(hrxml:Comment)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift may not contain hrxml:Comment</assert>
      <assert test="empty(hrxml:ExternalStaffingShiftSetId)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift may not contain hrxml:ExternalStaffingShiftSetId</assert>
      <assert test="empty(hrxml:TypeHours)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift may not contain hrxml:TypeHours</assert>
      <assert test="empty(@lang)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift may not contain @lang</assert>
      <assert test="empty(hrxml:StartTime)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift may not contain hrxml:StartTime</assert>
      <assert test="empty(hrxml:EndTime)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift may not contain hrxml:EndTime</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift/hrxml:Id">
      <assert test="empty(@idOwner)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift/hrxml:Id may not contain @idOwner</assert>
      <assert test="empty(@validFrom)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift/hrxml:Id may not contain @validFrom</assert>
      <assert test="empty(@validTo)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift/hrxml:Id may not contain @validTo</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift/hrxml:Id/hrxml:IdValue">
      <assert test="empty(@name)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift/hrxml:Id/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite">
      <assert test="empty(hrxml:TravelDirections)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite may not contain hrxml:TravelDirections</assert>
      <assert test="empty(hrxml:WorkSiteId)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite may not contain hrxml:WorkSiteId</assert>
      <assert test="empty(hrxml:StructuredTravelDirections)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite may not contain hrxml:StructuredTravelDirections</assert>
      <assert test="empty(hrxml:WorkSiteDetail)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite may not contain hrxml:WorkSiteDetail</assert>
      <assert test="empty(hrxml:ParkingInstructions)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite may not contain hrxml:ParkingInstructions</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite/hrxml:PostalAddress">
      <assert test="empty(hrxml:Region)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite/hrxml:PostalAddress may not contain hrxml:Region</assert>
      <assert test="empty(@type)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite/hrxml:PostalAddress may not contain @type</assert>
      <assert test="empty(hrxml:Recipient)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite/hrxml:PostalAddress may not contain hrxml:Recipient</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite/hrxml:PostalAddress/hrxml:DeliveryAddress">
      <assert test="empty(hrxml:AddressLine)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite/hrxml:PostalAddress/hrxml:DeliveryAddress may not contain hrxml:AddressLine</assert>
      <assert test="empty(hrxml:PostOfficeBox)">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite/hrxml:PostalAddress/hrxml:DeliveryAddress may not contain hrxml:PostOfficeBox</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:OfferId">
      <assert test="empty(@validFrom)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:OfferId may not contain @validFrom</assert>
      <assert test="empty(@validTo)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:OfferId may not contain @validTo</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:OfferId/hrxml:IdValue">
      <assert test="empty(@name)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:OfferId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:PreviousOrderId">
      <assert test="empty(@validTo)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:PreviousOrderId may not contain @validTo</assert>
      <assert test="empty(@validFrom)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:PreviousOrderId may not contain @validFrom</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:PreviousOrderId/hrxml:IdValue">
      <assert test="empty(@name)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:PreviousOrderId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:RFQOrderId">
      <assert test="empty(@validTo)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:RFQOrderId may not contain @validTo</assert>
      <assert test="empty(@validFrom)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:RFQOrderId may not contain @validFrom</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:RFQOrderId/hrxml:IdValue">
      <assert test="empty(@name)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:RFQOrderId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume">
      <assert test="empty(hrxml:Objective)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:Objective</assert>
      <assert test="empty(hrxml:SecurityCredentials)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:SecurityCredentials</assert>
      <assert test="empty(hrxml:PatentHistory)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:PatentHistory</assert>
      <assert test="empty(hrxml:SupportingMaterials)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:SupportingMaterials</assert>
      <assert test="empty(hrxml:RevisionDate)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:RevisionDate</assert>
      <assert test="empty(hrxml:ResumeAdditionalItems)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:ResumeAdditionalItems</assert>
      <assert test="empty(hrxml:ProfessionalAssociations)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:ProfessionalAssociations</assert>
      <assert test="empty(hrxml:MilitaryHistory)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:MilitaryHistory</assert>
      <assert test="empty(hrxml:References)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:References</assert>
      <assert test="empty(hrxml:SpeakingEventsHistory)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:SpeakingEventsHistory</assert>
      <assert test="empty(hrxml:Associations)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:Associations</assert>
      <assert test="empty(hrxml:Achievements)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:Achievements</assert>
      <assert test="empty(hrxml:EmploymentHistory)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:EmploymentHistory</assert>
      <assert test="empty(hrxml:ExecutiveSummary)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:ExecutiveSummary</assert>
      <assert test="empty(hrxml:Comments)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:Comments</assert>
      <assert test="empty(hrxml:Languages)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:Languages</assert>
      <assert test="empty(hrxml:ContactInfo)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:ContactInfo</assert>
      <assert test="empty(hrxml:PublicationHistory)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume may not contain hrxml:PublicationHistory</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution">
      <assert test="empty(hrxml:Minor)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:Minor</assert>
      <assert test="empty(hrxml:SchoolName)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:SchoolName</assert>
      <assert test="empty(hrxml:Major)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:Major</assert>
      <assert test="empty(hrxml:PostalAddress)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:PostalAddress</assert>
      <assert test="empty(hrxml:Comments)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:Comments</assert>
      <assert test="empty(hrxml:School)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:School</assert>
      <assert test="empty(hrxml:UserArea)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:UserArea</assert>
      <assert test="empty(hrxml:OrganizationUnit)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:OrganizationUnit</assert>
      <assert test="empty(hrxml:Measure)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:Measure</assert>
      <assert test="empty(hrxml:ISCEDInstitutionClassification)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:ISCEDInstitutionClassification</assert>
      <assert test="empty(hrxml:LocationSummary)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:LocationSummary</assert>
      <assert test="empty(hrxml:DatesOfAttendance)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:DatesOfAttendance</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree">
      <assert test="empty(hrxml:DegreeDate)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:DegreeDate</assert>
      <assert test="empty(hrxml:DegreeMinor)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:DegreeMinor</assert>
      <assert test="empty(hrxml:UserArea)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:UserArea</assert>
      <assert test="empty(hrxml:DegreeClassification)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:DegreeClassification</assert>
      <assert test="empty(@examPassed)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain @examPassed</assert>
      <assert test="empty(hrxml:OtherHonors)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:OtherHonors</assert>
      <assert test="empty(@graduatingDegree)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain @graduatingDegree</assert>
      <assert test="empty(hrxml:DatesOfAttendance)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:DatesOfAttendance</assert>
      <assert test="empty(hrxml:Comments)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:Comments</assert>
      <assert test="empty(hrxml:DegreeMajor)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:DegreeMajor</assert>
      <assert test="empty(hrxml:DegreeName)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:DegreeName</assert>
      <assert test="empty(hrxml:DegreeMeasure)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:DegreeMeasure</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id">
      <assert test="empty(@validFrom)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id may not contain @validFrom</assert>
      <assert test="empty(@validTo)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id may not contain @validTo</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id/hrxml:IdValue">
      <assert test="empty(@name)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification">
      <assert test="empty(hrxml:EffectiveDate)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification may not contain hrxml:EffectiveDate</assert>
      <assert test="empty(hrxml:Description)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification may not contain hrxml:Description</assert>
      <assert test="empty(hrxml:IssuingAuthority)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification may not contain hrxml:IssuingAuthority</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications">
      <assert test="empty(hrxml:QualificationSummary)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications may not contain hrxml:QualificationSummary</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency">
      <assert test="empty(hrxml:UserArea)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency may not contain hrxml:UserArea</assert>
      <assert test="empty(hrxml:CompetencyId)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency may not contain hrxml:CompetencyId</assert>
      <assert test="empty(hrxml:TaxonomyId)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency may not contain hrxml:TaxonomyId</assert>
      <assert test="empty(@required)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency may not contain @required</assert>
      <assert test="empty(hrxml:Competency)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency may not contain hrxml:Competency</assert>
      <assert test="empty(hrxml:CompetencyWeight)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency may not contain hrxml:CompetencyWeight</assert>
      <assert test="empty(hrxml:CompetencyEvidence)">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency may not contain hrxml:CompetencyEvidence</assert>
    </rule>
  </pattern>
  <pattern id="cardinality-redefines">
    <rule context="hrxml:StaffingOrder">
      <assert test="count(hrxml:OrderContact) &gt;= 1">hrxml:StaffingOrder must contain hrxml:OrderContact at least 1 time(s)</assert>
      <assert test="count(hrxml:StaffingPosition) &lt;= 1">hrxml:StaffingOrder may contain hrxml:StaffingPosition at most 1 time(s)</assert>
      <assert test="count(hrxml:UserArea) &gt;= 1">hrxml:StaffingOrder must contain hrxml:UserArea at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:CustomerReportingRequirements">
      <assert test="count(hrxml:AdditionalRequirement) &gt;= 1">hrxml:StaffingOrder/hrxml:CustomerReportingRequirements must contain hrxml:AdditionalRequirement at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement">
      <assert test="count(@requirementTitle) &gt;= 1">hrxml:StaffingOrder/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must contain @requirementTitle at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo">
      <assert test="count(hrxml:ContactMethod) &lt;= 1">hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo may contain hrxml:ContactMethod at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:PersonName">
      <assert test="count(hrxml:FormattedName) &gt;= 1">hrxml:StaffingOrder/hrxml:OrderContact/hrxml:ContactInfo/hrxml:PersonName must contain hrxml:FormattedName at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:OrderId">
      <assert test="count(@idOwner) &gt;= 1">hrxml:StaffingOrder/hrxml:OrderId must contain @idOwner at least 1 time(s)</assert>
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:StaffingOrder/hrxml:OrderId may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:ReferenceInformation">
      <assert test="count(hrxml:StaffingCustomerId) &gt;= 1">hrxml:StaffingOrder/hrxml:ReferenceInformation must contain hrxml:StaffingCustomerId at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:MasterOrderId">
      <assert test="count(@idOwner) &gt;= 1">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:MasterOrderId must contain @idOwner at least 1 time(s)</assert>
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:MasterOrderId may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId">
      <assert test="count(@idOwner) &gt;= 1">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId must contain @idOwner at least 1 time(s)</assert>
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId">
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may contain hrxml:IdValue at most 1 time(s)</assert>
      <assert test="count(@idOwner) &gt;= 1">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId must contain @idOwner at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId">
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may contain hrxml:IdValue at most 1 time(s)</assert>
      <assert test="count(@idOwner) &gt;= 1">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId must contain @idOwner at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId">
      <assert test="count(@idOwner) &gt;= 1">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId must contain @idOwner at least 1 time(s)</assert>
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition">
      <assert test="count(hrxml:StaffingShift) &lt;= 1">hrxml:StaffingOrder/hrxml:StaffingPosition may contain hrxml:StaffingShift at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader">
      <assert test="count(hrxml:RequestedPerson) &lt;= 1">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may contain hrxml:RequestedPerson at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonId">
      <assert test="count(@idOwner) &gt;= 1">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonId must contain @idOwner at least 1 time(s)</assert>
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonId may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonName">
      <assert test="count(hrxml:FamilyName) &lt;= 2">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonName may contain hrxml:FamilyName at most 2 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:ShiftWork">
      <assert test="count(hrxml:Description) &gt;= 1">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:ShiftWork must contain hrxml:Description at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates">
      <assert test="count(hrxml:Multiplier) &lt;= 1">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates may contain hrxml:Multiplier at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:CustomerRateClassification">
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:CustomerRateClassification may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:ExternalRateSetId">
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:ExternalRateSetId may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:RatesId">
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:RatesId may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift">
      <assert test="count(hrxml:Hours) &gt;= 1">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift must contain hrxml:Hours at least 1 time(s)</assert>
      <assert test="count(@shiftPeriod) &gt;= 1">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift must contain @shiftPeriod at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:UserArea">
      <assert test="count(setu:StaffingOrderAdditionalNL) &gt;= 1 and count(setu:StaffingOrderAdditionalNL) &lt;= 1">hrxml:StaffingOrder/hrxml:UserArea must contain setu:StaffingOrderAdditionalNL at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:OfferId">
      <assert test="count(@idOwner) &gt;= 1">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:OfferId must contain @idOwner at least 1 time(s)</assert>
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:OfferId may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:PreviousOrderId">
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:PreviousOrderId may contain hrxml:IdValue at most 1 time(s)</assert>
      <assert test="count(@idOwner) &gt;= 1">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:PreviousOrderId must contain @idOwner at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:RFQOrderId">
      <assert test="count(@idOwner) &gt;= 1">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:RFQOrderId must contain @idOwner at least 1 time(s)</assert>
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:RFQOrderId may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution">
      <assert test="count(hrxml:Degree) &lt;= 1">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may contain hrxml:Degree at most 1 time(s)</assert>
      <assert test="count(hrxml:LocalInstitutionClassification) &lt;= 1">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may contain hrxml:LocalInstitutionClassification at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id">
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</assert>
      <assert test="count(@idOwner) &gt;= 1">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id must contain @idOwner at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency">
      <assert test="count(@description) &gt;= 1">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency must contain @description at least 1 time(s)</assert>
      <assert test="count(@name) &gt;= 1">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency must contain @name at least 1 time(s)</assert>
    </rule>
  </pattern>
  <pattern id="type-restrictions">
    <rule context="hrxml:StaffingOrder/hrxml:CustomerReportingRequirements">
      <assert test="count(hrxml:AdditionalRequirement[@requirementTitle = 'VersionId']) = 1">There MUST be one CustomerReportingRequirements/AdditionalRequirement with @requirementTitle equal to VersionId</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:OrderClassification">
      <assert test="empty(@orderStatus) or (@orderStatus='new') or (@orderStatus='closed')">hrxml:StaffingOrder/hrxml:OrderClassification/@orderStatus must have one of the following values: [new, closed]</assert>
      <assert test="empty(@orderType) or (@orderType='RFQ') or (@orderType='order')">hrxml:StaffingOrder/hrxml:OrderClassification/@orderType must have one of the following values: [RFQ, order]</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:OrderContact">
      <assert test="empty(@contactType) or (@contactType='created by') or (@contactType='authorized by') or (@contactType='first day contact') or (@contactType='placed by') or (@contactType='placed on behalf of') or (@contactType='supervisor') or (@contactType='submitted by')">hrxml:StaffingOrder/hrxml:OrderContact/@contactType must have one of the following values: [created by, authorized by, first day contact, placed by, placed on behalf of, supervisor, submitted by]</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:OrderId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')">hrxml:StaffingOrder/hrxml:OrderId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:PositionQuantity">
      <assert test="number(text()) &gt; 0">hrxml:StaffingOrder/hrxml:PositionQuantity must be at least 1.</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:ReferenceInformation">
      <assert test="count(hrxml:StaffingSupplierOrgUnitId/@idOwner) = count(distinct-values(hrxml:StaffingSupplierOrgUnitId/@idOwner))">The same idOwner may not be given for StaffingSupplierOrgUnitId</assert>
      <assert test="count(hrxml:StaffingSupplierId/@idOwner) = count(distinct-values(hrxml:StaffingSupplierId/@idOwner))">The same idOwner may not be given for StaffingSupplierId</assert>
      <assert test="count(hrxml:StaffingCustomerId/@idOwner) = count(distinct-values(hrxml:StaffingCustomerId/@idOwner))">The same idOwner may not be given for StaffingCustomerId</assert>
      <assert test="count(hrxml:StaffingCustomerOrgUnitId/@idOwner) = count(distinct-values(hrxml:StaffingCustomerOrgUnitId/@idOwner))">The same idOwner may not be given for StaffingCustomerOrgUnitId</assert>
      <assert test="if (count(hrxml:StaffingCustomerOrgUnitId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingCustomerOrgUnitId[@idOwner = 'KvK']) = 1) else ('true')">If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.</assert>
      <assert test="if (count(hrxml:StaffingCustomerId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingCustomerId[@idOwner = 'KvK']) = 1) else ('true')">If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.</assert>
      <assert test="if (count(hrxml:StaffingSupplierId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingSupplierId[@idOwner = 'KvK']) = 1) else ('true')">If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.</assert>
      <assert test="if (count(hrxml:StaffingSupplierOrgUnitId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingSupplierOrgUnitId[@idOwner = 'KvK']) = 1) else ('true')">If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:MasterOrderId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:MasterOrderId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId">
      <assert test="string-length() > 0">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId must be filled</assert>
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, OIN, KvK, BTW, Fi, Vest]</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId">
      <assert test="string-length() > 0">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId must be filled</assert>
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, OIN, KvK, BTW, Fi, Vest]</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId">
      <assert test="string-length() > 0">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId must be filled</assert>
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, OIN, KvK, BTW, Fi, Vest]</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId">
      <assert test="string-length() > 0">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId must be filled</assert>
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='KvK') or (@idOwner='OIN') or (@idOwner='BTW') or (@idOwner='Fi')">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, KvK, OIN, BTW, Fi]</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition">
      <assert test="empty(hrxml:PositionReason) or (hrxml:PositionReason='Illness') or (hrxml:PositionReason='Peak') or (hrxml:PositionReason='Project') or (hrxml:PositionReason='Reorganisation') or (hrxml:PositionReason='Position') or (hrxml:PositionReason='Vacation') or (hrxml:PositionReason='Maternity') or (hrxml:PositionReason='Season') or (hrxml:PositionReason='Replacement') or (hrxml:PositionReason='Recruitment') or (hrxml:PositionReason='Structural') or (hrxml:PositionReason='Other')">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionReason must have one of the following values: [Illness, Peak, Project, Reorganisation, Position, Vacation, Maternity, Season, Replacement, Recruitment, Structural, Other]</assert>
      <assert test="empty(hrxml:CustomerReportingRequirements) or (hrxml:CustomerReportingRequirements='')">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:CustomerReportingRequirements must be Empty</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader">
      <assert test="empty(hrxml:PositionType) or (hrxml:PositionType='recruitment and selection') or (hrxml:PositionType='secondment') or (hrxml:PositionType='temporary staffing')">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:PositionType must have one of the following values: [recruitment and selection, secondment, temporary staffing]</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:PositionId">
      <assert test="empty(hrxml:Id) or (hrxml:Id='')">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:PositionId/hrxml:Id must be Empty</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson">
      <assert test="count(hrxml:PersonName) + count(hrxml:PersonId) &gt; 0">hrxml:StaffingOrder/hrxml:PositionHeader/hrxml:RequestedPerson - PersonName OR PersonId is mandatory.</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='BSN')">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonId/@idOwner must have one of the following values: [StaffingCustomer, staffingCustomer, BSN]</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonName/hrxml:Affix">
      <assert test="empty(@type) or (@type='aristocraticTitle') or (@type='formOfAddress') or (@type='generation') or (@type='qualification')">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonName/hrxml:Affix/@type must have one of the following values: [aristocraticTitle, formOfAddress, generation, qualification]</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:ShiftWork">
      <assert test="empty(@haveShiftWork) or (@haveShiftWork='true')">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:ShiftWork/@haveShiftWork must have one of the following values: [true]</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates">
      <assert test="(empty(hrxml:Class) or (hrxml:Class='TimeInterval') or (hrxml:Class='Allowance') or (hrxml:Class='Expense')) or (empty(hrxml:Class) or (hrxml:Class=''))">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:Class must have one of the following values: [TimeInterval, Allowance, Expense] OR hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:Class must be Empty</assert>
      <assert test="empty(@rateType) or (@rateType='pay') or (@rateType='bill') or (@rateType='minPayRate') or (@rateType='maxPayRate') or (@rateType='minBillRate') or (@rateType='maxBillRate')">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/@rateType must have one of the following values: [pay, bill, minPayRate, maxPayRate, minBillRate, maxBillRate]</assert>
      <assert test="count(/hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:InclusiveRate) = 1">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:InclusiveRate is mandatory if Rates are included</assert>
      <assert test="empty(@rateStatus) or (@rateStatus='proposed') or (@rateStatus='agreed')">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/@rateStatus must have one of the following values: [proposed, agreed]</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:Amount">
      <assert test="empty(@rateAmountPeriod) or (@rateAmountPeriod='hourly') or (@rateAmountPeriod='x:hourlysplit') or (@rateAmountPeriod='x:hourlyconsolidated') or (@rateAmountPeriod='daily') or (@rateAmountPeriod='weekly') or (@rateAmountPeriod='x:4weekly') or (@rateAmountPeriod='monthly') or (@rateAmountPeriod='yearly') or (@rateAmountPeriod='flatfee')">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:Amount/@rateAmountPeriod must have one of the following values: [hourly, x:hourlysplit, x:hourlyconsolidated, daily, weekly, x:4weekly, monthly, yearly, flatfee]</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift">
      <assert test="empty(@shiftPeriod) or (@shiftPeriod='weekly') or (@shiftPeriod='monthly') or (@shiftPeriod='daily')">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift/@shiftPeriod must have one of the following values: [weekly, monthly, daily]</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift/hrxml:Id">
      <assert test="empty(hrxml:IdValue) or (hrxml:IdValue='')">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift/hrxml:Id/hrxml:IdValue must be Empty</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite/hrxml:PostalAddress">
      <assert test="matches(hrxml:CountryCode, '^[A-Z][A-Z]$')">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite/hrxml:PostalAddress/hrxml:CountryCode must match regular expression: ^[A-Z][A-Z]$</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL">
      <assert test="empty(setu:SETUVersionId) or (setu:SETUVersionId='1.2')">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:SETUVersionId must have one of the following values: [1.2]</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:OfferId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCompany')">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:OfferId/@idOwner must have one of the following values: [StaffingCompany]</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:PreviousOrderId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:PreviousOrderId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:RFQOrderId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:RFQOrderId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree">
      <assert test="empty(@degreeType) or (@degreeType='1') or (@degreeType='2') or (@degreeType='3') or (@degreeType='4') or (@degreeType='5') or (@degreeType='6')">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree/@degreeType must have one of the following values: [1, 2, 3, 4, 5, 6]</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id">
      <assert test="empty(hrxml:IdValue) or (hrxml:IdValue='SOI-2006')">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id/hrxml:IdValue must have one of the following values: [SOI-2006]</assert>
    </rule>
  </pattern>
  <pattern id="type-restrictions-1">
    <rule context="hrxml:StaffingOrder/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement[@requirementTitle = 'VersionId']">
      <assert test="text() = '2.0'">CustomerReportingRequirements/AdditionalRequirement must have value: 2.0 when requirementTitle is 'VersionId'.</assert>
    </rule>
  </pattern>
  <pattern id="type-restrictions-2">
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates[hrxml:Class = 'TimeInterval']">
      <assert test="count(hrxml:Multiplier) = 1">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:Multiplier is mandatory if hrxml:Class is TimeInterval</assert>
    </rule>
  </pattern>
</schema>
