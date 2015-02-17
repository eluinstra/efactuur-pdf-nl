<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <title>Validations for TimeCard Mapping; strict=false</title>
  <ns prefix="hrxml" uri="http://ns.hr-xml.org/2007-04-15" />
  <pattern id="prohibitions">
    <rule context="hrxml:TimeCard">
      <assert test="empty(@lang)">hrxml:TimeCard may not contain @lang</assert>
      <assert test="empty(hrxml:UserArea)">hrxml:TimeCard may not contain hrxml:UserArea</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData">
      <assert test="empty(@type)">hrxml:TimeCard/hrxml:AdditionalData may not contain @type</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements">
      <assert test="empty(hrxml:Shift)">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Shift</assert>
      <assert test="empty(hrxml:Entity)">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Entity</assert>
      <assert test="empty(hrxml:ContactName)">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ContactName</assert>
      <assert test="empty(hrxml:AccountCode)">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:AccountCode</assert>
      <assert test="empty(hrxml:CustomerJobDescription)">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobDescription</assert>
      <assert test="empty(hrxml:ExternalReqNumber)">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalReqNumber</assert>
      <assert test="empty(hrxml:LocationName)">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationName</assert>
      <assert test="empty(hrxml:CustomerJobCode)">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobCode</assert>
      <assert test="empty(hrxml:ExternalOrderNumber)">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalOrderNumber</assert>
      <assert test="empty(hrxml:ManagerName)">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ManagerName</assert>
      <assert test="empty(hrxml:SubEntity)">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SubEntity</assert>
      <assert test="empty(hrxml:LocationCode)">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationCode</assert>
      <assert test="empty(hrxml:SupervisorName)">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SupervisorName</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation">
      <assert test="empty(hrxml:UserArea)">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:UserArea</assert>
      <assert test="empty(hrxml:BillToEntityId)">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:BillToEntityId</assert>
      <assert test="empty(hrxml:OrderId)">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:OrderId</assert>
      <assert test="empty(hrxml:MasterOrderId)">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:MasterOrderId</assert>
      <assert test="empty(hrxml:InvoiceId)">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:InvoiceId</assert>
      <assert test="empty(hrxml:DocumentId)">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:DocumentId</assert>
      <assert test="empty(hrxml:HumanResourceId)">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:HumanResourceId</assert>
      <assert test="empty(hrxml:IntermediaryId)">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:IntermediaryId</assert>
      <assert test="empty(hrxml:PositionId)">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:PositionId</assert>
      <assert test="empty(hrxml:StaffingOrganizationId)">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation may not contain hrxml:StaffingOrganizationId</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId">
      <assert test="empty(@validFrom)">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId may not contain @validFrom</assert>
      <assert test="empty(@validTo)">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId may not contain @validTo</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId/hrxml:IdValue">
      <assert test="empty(@name)">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId">
      <assert test="empty(@validFrom)">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may not contain @validFrom</assert>
      <assert test="empty(@validTo)">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may not contain @validTo</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/hrxml:IdValue">
      <assert test="empty(@name)">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId">
      <assert test="empty(@validTo)">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may not contain @validTo</assert>
      <assert test="empty(@validFrom)">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may not contain @validFrom</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/hrxml:IdValue">
      <assert test="empty(@name)">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId">
      <assert test="empty(@validFrom)">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may not contain @validFrom</assert>
      <assert test="empty(@validTo)">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may not contain @validTo</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/hrxml:IdValue">
      <assert test="empty(@name)">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId">
      <assert test="empty(@validFrom)">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may not contain @validFrom</assert>
      <assert test="empty(@validTo)">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may not contain @validTo</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/hrxml:IdValue">
      <assert test="empty(@name)">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ApprovalInfo">
      <assert test="empty(@approverType)">hrxml:TimeCard/hrxml:ApprovalInfo may not contain @approverType</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Comment">
      <assert test="empty(@lang)">hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Comment may not contain @lang</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id">
      <assert test="empty(@validFrom)">hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id may not contain @validFrom</assert>
      <assert test="empty(@validTo)">hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id may not contain @validTo</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id/hrxml:IdValue">
      <assert test="empty(@name)">hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName">
      <assert test="empty(@script)">hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName may not contain @script</assert>
      <assert test="empty(hrxml:AlternateScript)">hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName may not contain hrxml:AlternateScript</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:Id">
      <assert test="empty(@validFrom)">hrxml:TimeCard/hrxml:Id may not contain @validFrom</assert>
      <assert test="empty(@validTo)">hrxml:TimeCard/hrxml:Id may not contain @validTo</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:Id/hrxml:IdValue">
      <assert test="empty(@name)">hrxml:TimeCard/hrxml:Id/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedResource">
      <assert test="empty(hrxml:Resource)">hrxml:TimeCard/hrxml:ReportedResource may not contain hrxml:Resource</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id">
      <assert test="empty(@validFrom)">hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id may not contain @validFrom</assert>
      <assert test="empty(@validTo)">hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id may not contain @validTo</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id/hrxml:IdValue">
      <assert test="empty(@name)">hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName">
      <assert test="empty(hrxml:AlternateScript)">hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName may not contain hrxml:AlternateScript</assert>
      <assert test="empty(@script)">hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName may not contain @script</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime">
      <assert test="empty(hrxml:TimeEvent)">hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:TimeEvent</assert>
      <assert test="empty(hrxml:ReportedPersonAssignment)">hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:ReportedPersonAssignment</assert>
      <assert test="empty(hrxml:Expense)">hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:Expense</assert>
      <assert test="empty(hrxml:ApprovalInfo)">hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:ApprovalInfo</assert>
      <assert test="empty(hrxml:SubmitterInfo)">hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:SubmitterInfo</assert>
      <assert test="empty(hrxml:AdditionalData)">hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:AdditionalData</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance">
      <assert test="empty(hrxml:SubmitterInfo)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance may not contain hrxml:SubmitterInfo</assert>
      <assert test="empty(hrxml:ApprovalInfo)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance may not contain hrxml:ApprovalInfo</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData">
      <assert test="empty(@type)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData may not contain @type</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData">
      <assert test="empty(hrxml:ReferenceInformation)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData may not contain hrxml:ReferenceInformation</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements">
      <assert test="empty(hrxml:ManagerName)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ManagerName</assert>
      <assert test="empty(hrxml:ContactName)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ContactName</assert>
      <assert test="empty(hrxml:LocationCode)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationCode</assert>
      <assert test="empty(hrxml:Shift)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Shift</assert>
      <assert test="empty(hrxml:AccountCode)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:AccountCode</assert>
      <assert test="empty(hrxml:Entity)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Entity</assert>
      <assert test="empty(hrxml:SubEntity)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SubEntity</assert>
      <assert test="empty(hrxml:LocationName)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationName</assert>
      <assert test="empty(hrxml:CustomerJobDescription)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobDescription</assert>
      <assert test="empty(hrxml:ExternalOrderNumber)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalOrderNumber</assert>
      <assert test="empty(hrxml:ExternalReqNumber)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalReqNumber</assert>
      <assert test="empty(hrxml:SupervisorName)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SupervisorName</assert>
      <assert test="empty(hrxml:CustomerJobCode)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobCode</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Comment">
      <assert test="empty(@lang)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Comment may not contain @lang</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id">
      <assert test="empty(@validTo)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id may not contain @validTo</assert>
      <assert test="empty(@validFrom)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id may not contain @validFrom</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval">
      <assert test="empty(hrxml:SubmitterInfo)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval may not contain hrxml:SubmitterInfo</assert>
      <assert test="empty(hrxml:PieceWork)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval may not contain hrxml:PieceWork</assert>
      <assert test="empty(hrxml:Allowance)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval may not contain hrxml:Allowance</assert>
      <assert test="empty(hrxml:ApprovalInfo)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval may not contain hrxml:ApprovalInfo</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData">
      <assert test="empty(@type)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData may not contain @type</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData">
      <assert test="empty(hrxml:ReferenceInformation)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData may not contain hrxml:ReferenceInformation</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements">
      <assert test="empty(hrxml:AccountCode)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:AccountCode</assert>
      <assert test="empty(hrxml:ExternalReqNumber)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalReqNumber</assert>
      <assert test="empty(hrxml:ManagerName)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ManagerName</assert>
      <assert test="empty(hrxml:ContactName)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ContactName</assert>
      <assert test="empty(hrxml:Shift)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Shift</assert>
      <assert test="empty(hrxml:Entity)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:Entity</assert>
      <assert test="empty(hrxml:SubEntity)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SubEntity</assert>
      <assert test="empty(hrxml:ExternalOrderNumber)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:ExternalOrderNumber</assert>
      <assert test="empty(hrxml:LocationName)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationName</assert>
      <assert test="empty(hrxml:CustomerJobDescription)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobDescription</assert>
      <assert test="empty(hrxml:SupervisorName)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:SupervisorName</assert>
      <assert test="empty(hrxml:LocationCode)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:LocationCode</assert>
      <assert test="empty(hrxml:CustomerJobCode)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may not contain hrxml:CustomerJobCode</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Comment">
      <assert test="empty(@lang)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Comment may not contain @lang</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id">
      <assert test="empty(@validTo)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id may not contain @validTo</assert>
      <assert test="empty(@validFrom)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id may not contain @validFrom</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id/hrxml:IdValue">
      <assert test="empty(@name)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount">
      <assert test="empty(@period)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount may not contain @period</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:SubmitterInfo">
      <assert test="empty(hrxml:Person)">hrxml:TimeCard/hrxml:SubmitterInfo may not contain hrxml:Person</assert>
    </rule>
  </pattern>
  <pattern id="cardinality-redefines">
    <rule context="hrxml:TimeCard">
      <assert test="count(hrxml:ReportedTime) &lt;= 1">hrxml:TimeCard may contain hrxml:ReportedTime at most 1 time(s)</assert>
      <assert test="count(hrxml:AdditionalData) &gt;= 1">hrxml:TimeCard must contain hrxml:AdditionalData at least 1 time(s)</assert>
      <assert test="count(hrxml:Id) &gt;= 1">hrxml:TimeCard must contain hrxml:Id at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData">
      <assert test="count(hrxml:StaffingAdditionalData) &gt;= 1 and count(hrxml:StaffingAdditionalData) &lt;= 1">hrxml:TimeCard/hrxml:AdditionalData must contain hrxml:StaffingAdditionalData at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements">
      <assert test="count(hrxml:AdditionalRequirement) &gt;= 1">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements must contain hrxml:AdditionalRequirement at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement">
      <assert test="count(@requirementTitle) &gt;= 1">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must contain @requirementTitle at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId">
      <assert test="count(@idOwner) &gt;= 1">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId must contain @idOwner at least 1 time(s)</assert>
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId">
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may contain hrxml:IdValue at most 1 time(s)</assert>
      <assert test="count(@idOwner) &gt;= 1">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId must contain @idOwner at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId">
      <assert test="count(@idOwner) &gt;= 1">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId must contain @idOwner at least 1 time(s)</assert>
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId">
      <assert test="count(@idOwner) &gt;= 1">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId must contain @idOwner at least 1 time(s)</assert>
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId">
      <assert test="count(@idOwner) &gt;= 1">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId must contain @idOwner at least 1 time(s)</assert>
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id">
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</assert>
      <assert test="count(@idOwner) &gt;= 1">hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:Id must contain @idOwner at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName">
      <assert test="count(hrxml:FamilyName) &lt;= 2">hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName may contain hrxml:FamilyName at most 2 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:Id">
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:TimeCard/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</assert>
      <assert test="count(@idOwner) &gt;= 1">hrxml:TimeCard/hrxml:Id must contain @idOwner at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedResource">
      <assert test="count(hrxml:Person) &gt;= 1">hrxml:TimeCard/hrxml:ReportedResource must contain hrxml:Person at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id">
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</assert>
      <assert test="count(@idOwner) &gt;= 1">hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id must contain @idOwner at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName">
      <assert test="count(hrxml:FamilyName) &lt;= 2">hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName may contain hrxml:FamilyName at most 2 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance">
      <assert test="count(hrxml:Amount) &gt;= 1">hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance must contain hrxml:Amount at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData">
      <assert test="count(hrxml:StaffingAdditionalData) &lt;= 1">hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData may contain hrxml:StaffingAdditionalData at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement">
      <assert test="count(@requirementTitle) &gt;= 1">hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must contain @requirementTitle at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id">
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</assert>
      <assert test="count(@idOwner) &gt;= 1">hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id must contain @idOwner at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue">
      <assert test="count(@name) &gt;= 1">hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue must contain @name at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements">
      <assert test="count(hrxml:AdditionalRequirement) &lt;= 1">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements may contain hrxml:AdditionalRequirement at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement">
      <assert test="count(@requirementTitle) &gt;= 1">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must contain @requirementTitle at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id">
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</assert>
      <assert test="count(@idOwner) &gt;= 1">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id must contain @idOwner at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount">
      <assert test="count(@multiplier) &gt;= 1">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount must contain @multiplier at least 1 time(s)</assert>
    </rule>
  </pattern>
  <pattern id="type-restrictions">
    <rule context="hrxml:TimeCard">
      <assert test="(count(hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId) + count(hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:PurchaseOrderNumber)) &gt;= 1">There must be at least one AssignmentId or PurchaseOrderNumber on header level.</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData">
      <assert test="count(hrxml:CustomerReportingRequirements) + count(hrxml:ReferenceInformation) &gt; 0">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData must contain CustomerReportingRequirements or ReferenceInformation</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements">
      <assert test="count(hrxml:AdditionalRequirement[@requirementTitle = 'VersionId']) = 1">There MUST be one CustomerReportingRequirements/AdditionalRequirement with @requirementTitle equal to VersionId</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation">
      <assert test="count(hrxml:StaffingCustomerId/@idOwner) = count(distinct-values(hrxml:StaffingCustomerId/@idOwner))">The same idOwner may not be given for StaffingCustomerId</assert>
      <assert test="count(hrxml:StaffingCustomerOrgUnitId/@idOwner) = count(distinct-values(hrxml:StaffingCustomerOrgUnitId/@idOwner))">The same idOwner may not be given for StaffingCustomerOrgUnitId</assert>
      <assert test="count(hrxml:StaffingSupplierId/@idOwner) = count(distinct-values(hrxml:StaffingSupplierId/@idOwner))">The same idOwner may not be given for StaffingSupplierId</assert>
      <assert test="if (count(hrxml:StaffingCustomerOrgUnitId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingCustomerOrgUnitId[@idOwner = 'KvK']) = 1) else ('true')">If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.</assert>
      <assert test="if (count(hrxml:StaffingCustomerId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingCustomerId[@idOwner = 'KvK']) = 1) else ('true')">If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.</assert>
      <assert test="if (count(hrxml:StaffingSupplierId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingSupplierId[@idOwner = 'KvK']) = 1) else ('true')">If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCompany')">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId/@idOwner must have one of the following values: [StaffingCompany]</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId">
      <assert test="string-length() > 0">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId must be filled</assert>
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, OIN, KvK, BTW, Fi, Vest]</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, OIN, KvK, BTW, Fi, Vest]</assert>
      <assert test="string-length() > 0">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId must be filled</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, OIN, KvK, BTW, Fi, Vest]</assert>
      <assert test="string-length() > 0">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId must be filled</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='KvK') or (@idOwner='OIN') or (@idOwner='BTW') or (@idOwner='Fi')">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, KvK, OIN, BTW, Fi]</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName/hrxml:Affix">
      <assert test="empty(@type) or (@type='aristocraticTitle') or (@type='formOfAddress') or (@type='generation') or (@type='qualification')">hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName/hrxml:Affix/@type must have one of the following values: [aristocraticTitle, formOfAddress, generation, qualification]</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName/hrxml:FamilyName">
      <assert test="empty(@primary) or (@primary='true') or (@primary='false')">hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName/hrxml:FamilyName/@primary must have one of the following values: [true, false]</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:Id">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')">hrxml:TimeCard/hrxml:Id/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')">hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName/hrxml:Affix">
      <assert test="empty(@type) or (@type='aristocraticTitle') or (@type='formOfAddress') or (@type='generation') or (@type='qualification')">hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName/hrxml:Affix/@type must have one of the following values: [aristocraticTitle, formOfAddress, generation, qualification]</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName/hrxml:FamilyName">
      <assert test="empty(@primary) or (@primary='true') or (@primary='false')">hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName/hrxml:FamilyName/@primary must have one of the following values: [true, false]</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime">
      <assert test="(empty(@status) or (@status='rejected') or (@status='corrected')) or (empty(@status) or (@status=''))">hrxml:TimeCard/hrxml:ReportedTime/@status must have one of the following values: [rejected, corrected] OR hrxml:TimeCard/hrxml:ReportedTime/@status must be Empty</assert>
      <assert test="count(hrxml:TimeInterval) + count(hrxml:Allowance) &gt; 0">hrxml:TimeCard/hrxml:ReportedTime must contain at least one TimeInterval or Allowance</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance">
      <assert test="empty(@actionCode) or (@actionCode='Add') or (@actionCode='Change') or (@actionCode='Void') or (@actionCode='Unchanged')">hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/@actionCode must have one of the following values: [Add, Change, Void, Unchanged]</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')">hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue">
      <assert test="empty(@name) or (@name='allowance') or (@name='expense')">hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue/@name must have one of the following values: [allowance, expense]</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval">
      <assert test="empty(@actionCode) or (@actionCode='Add') or (@actionCode='Change') or (@actionCode='Void') or (@actionCode='Unchanged')">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/@actionCode must have one of the following values: [Add, Change, Void, Unchanged]</assert>
      <assert test="count(hrxml:EndDateTime) + count(hrxml:Duration) &gt; 0">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval must have EndDateTime or Duration</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements">
      <assert test="empty(hrxml:AdditionalRequirement) or (hrxml:AdditionalRequirement='true') or (hrxml:AdditionalRequirement='false')">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must have one of the following values: [true, false]</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement">
      <assert test="empty(@requirementTitle) or (@requirementTitle='InclusiveRate')">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement/@requirementTitle must have one of the following values: [InclusiveRate]</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount">
      <assert test="empty(@type) or (@type='hourly') or (@type='hourlyconsolidated') or (@type='hourlysplit') or (@type='4weekly') or (@type='monthly')">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount/@type must have one of the following values: [hourly, hourlyconsolidated, hourlysplit, 4weekly, monthly]</assert>
    </rule>
  </pattern>
  <pattern id="type-restrictions-1">
    <rule context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement[@requirementTitle = 'VersionId']">
      <assert test="text() = '2.0'">CustomerReportingRequirements/AdditionalRequirement must have value: 2.0 when requirementTitle is 'VersionId'.</assert>
    </rule>
  </pattern>
</schema>
