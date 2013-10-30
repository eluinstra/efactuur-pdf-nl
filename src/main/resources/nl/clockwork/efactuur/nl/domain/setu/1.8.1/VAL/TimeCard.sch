<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <title>Validations for TimeCard Mapping; strict=false</title>
  <ns prefix="hrxml" uri="http://ns.hr-xml.org/2007-04-15" />
  <pattern id="prohibitions">
    <rule context="hrxml:TimeCard/hrxml:ReportedResource/hrxml:Resource">
      <assert test="empty(@type)">hrxml:TimeCard/hrxml:ReportedResource/hrxml:Resource may not contain @type</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime">
      <assert test="empty(hrxml:Expense)">hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:Expense</assert>
      <assert test="empty(hrxml:TimeEvent)">hrxml:TimeCard/hrxml:ReportedTime may not contain hrxml:TimeEvent</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval">
      <assert test="empty(@dayAssignment)">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval may not contain @dayAssignment</assert>
    </rule>
  </pattern>
  <pattern id="cardinality-redefines">
    <rule context="hrxml:TimeCard">
      <assert test="count(hrxml:AdditionalData) &gt;= 1">hrxml:TimeCard must contain hrxml:AdditionalData at least 1 time(s)</assert>
      <assert test="count(hrxml:Id) &gt;= 1">hrxml:TimeCard must contain hrxml:Id at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData">
      <assert test="count(hrxml:StaffingAdditionalData) &gt;= 1">hrxml:TimeCard/hrxml:AdditionalData must contain hrxml:StaffingAdditionalData at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData">
      <assert test="count(hrxml:CustomerReportingRequirements) &gt;= 1">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData must contain hrxml:CustomerReportingRequirements at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements">
      <assert test="count(hrxml:AdditionalRequirement) &gt;= 1">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements must contain hrxml:AdditionalRequirement at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement">
      <assert test="count(@requirementTitle) &gt;= 1">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must contain @requirementTitle at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId">
      <assert test="count(@idOwner) &gt;= 1">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId must contain @idOwner at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId">
      <assert test="count(@idOwner) &gt;= 1">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId must contain @idOwner at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId">
      <assert test="count(@idOwner) &gt;= 1">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId must contain @idOwner at least 1 time(s)</assert>
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName">
      <assert test="count(hrxml:Affix) &lt;= 1">hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName may contain hrxml:Affix at most 1 time(s)</assert>
      <assert test="count(hrxml:FamilyName) &lt;= 2">hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName may contain hrxml:FamilyName at most 2 time(s)</assert>
      <assert test="count(hrxml:GivenName) &lt;= 1">hrxml:TimeCard/hrxml:ApprovalInfo/hrxml:Person/hrxml:PersonName may contain hrxml:GivenName at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:Id">
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:TimeCard/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id">
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName">
      <assert test="count(hrxml:FamilyName) &lt;= 2">hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName may contain hrxml:FamilyName at most 2 time(s)</assert>
      <assert test="count(hrxml:GivenName) &lt;= 1">hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:PersonName may contain hrxml:GivenName at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedResource/hrxml:Resource">
      <assert test="count(hrxml:Id) &lt;= 1">hrxml:TimeCard/hrxml:ReportedResource/hrxml:Resource may contain hrxml:Id at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedResource/hrxml:Resource/hrxml:Id">
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:TimeCard/hrxml:ReportedResource/hrxml:Resource/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance">
      <assert test="count(hrxml:Amount) &gt;= 1">hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance must contain hrxml:Amount at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id">
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue">
      <assert test="count(@name) &gt;= 1">hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue must contain @name at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:ReportedPersonAssignment/hrxml:Id">
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:TimeCard/hrxml:ReportedTime/hrxml:ReportedPersonAssignment/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance">
      <assert test="count(hrxml:Amount) &gt;= 1">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance must contain hrxml:Amount at least 1 time(s)</assert>
      <assert test="count(hrxml:Id) &gt;= 1">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance must contain hrxml:Id at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance/hrxml:Id">
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance/hrxml:Id/hrxml:IdValue">
      <assert test="count(@name) &gt;= 1">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance/hrxml:Id/hrxml:IdValue must contain @name at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id">
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:SubmitterInfo/hrxml:Person/hrxml:PersonName">
      <assert test="count(hrxml:FamilyName) &lt;= 2">hrxml:TimeCard/hrxml:SubmitterInfo/hrxml:Person/hrxml:PersonName may contain hrxml:FamilyName at most 2 time(s)</assert>
      <assert test="count(hrxml:GivenName) &lt;= 1">hrxml:TimeCard/hrxml:SubmitterInfo/hrxml:Person/hrxml:PersonName may contain hrxml:GivenName at most 1 time(s)</assert>
    </rule>
  </pattern>
  <pattern id="type-restrictions">
    <rule context="hrxml:TimeCard">
      <assert test="(count(hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:AssignmentId) + count(hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:PurchaseOrderNumber)) &gt;= 1">There must be at least one AssignmentId or PurchaseOrderNumber on header level.</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements">
      <assert test="count(hrxml:AdditionalRequirement[@requirementTitle = 'VersionId']) = 1">There MUST be one CustomerReportingRequirements/AdditionalRequirement with @requirementTitle equal to VersionId</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement[@requirementTitle = 'VersionId']">
      <assert test="text() = '1.8'">CustomerReportingRequirements/AdditionalRequirement must have value: 1.8 when requirementTitle is 'VersionId'.</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation">
      <assert test="if (count(hrxml:StaffingCustomerOrgUnitId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingCustomerOrgUnitId[@idOwner = 'KvK']) = 1) else ('true')">If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.</assert>
      <assert test="if (count(hrxml:StaffingCustomerId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingCustomerId[@idOwner = 'KvK']) = 1) else ('true')">If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.</assert>
      <assert test="if (count(hrxml:StaffingSupplierId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingSupplierId[@idOwner = 'KvK']) = 1) else ('true')">If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.</assert>
      <assert test="count(hrxml:StaffingCustomerId/@idOwner) = count(distinct-values(hrxml:StaffingCustomerId/@idOwner))">The same idOwner may not be given for StaffingCustomerId</assert>
      <assert test="count(hrxml:StaffingCustomerOrgUnitId/@idOwner) = count(distinct-values(hrxml:StaffingCustomerOrgUnitId/@idOwner))">The same idOwner may not be given for StaffingCustomerOrgUnitId</assert>
      <assert test="count(hrxml:StaffingSupplierId/@idOwner) = count(distinct-values(hrxml:StaffingSupplierId/@idOwner))">The same idOwner may not be given for StaffingSupplierId</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId">
      <assert test="string-length() > 0">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId must be filled</assert>
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/@idOwner must have one of the following values: [StaffingCustomer, staffingCustomer, StaffingCompany, staffingCompany, OIN, KvK, BTW, Fi, Vest]</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId">
      <assert test="string-length() > 0">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId must be filled</assert>
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/@idOwner must have one of the following values: [StaffingCustomer, staffingCustomer, StaffingCompany, staffingCompany, OIN, KvK, BTW, Fi, Vest]</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId">
      <assert test="string-length() > 0">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId must be filled</assert>
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">hrxml:TimeCard/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/@idOwner must have one of the following values: [StaffingCustomer, staffingCustomer, StaffingCompany, staffingCompany, OIN, KvK, BTW, Fi, Vest]</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id">
      <assert test="(empty(@idOwner) or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer')) or (empty(@idOwner) or (@idOwner=''))">hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id/@idOwner must have one of the following values: [StaffingCompany, staffingCompany, StaffingCustomer, staffingCustomer] OR hrxml:TimeCard/hrxml:ReportedResource/hrxml:Person/hrxml:Id/@idOwner must be Empty</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue">
      <assert test="empty(@name) or (@name='allowance') or (@name='expense') or (@name='Expense') or (@name='Allowance')">hrxml:TimeCard/hrxml:ReportedTime/hrxml:Allowance/hrxml:Id/hrxml:IdValue/@name must have one of the following values: [allowance, expense, Expense, Allowance]</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement">
      <assert test="empty(@requirementTitle) or (@requirementTitle='InclusiveRate') or (@requirementTitle='inclusiverate')">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:AdditionalData/hrxml:StaffingAdditionalData/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement/@requirementTitle must have one of the following values: [InclusiveRate, inclusiverate]</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance/hrxml:Id/hrxml:IdValue">
      <assert test="empty(@name) or (@name='expense') or (@name='allowance') or (@name='Expense') or (@name='Allowance')">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Allowance/hrxml:Id/hrxml:IdValue/@name must have one of the following values: [expense, allowance, Expense, Allowance]</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id/hrxml:IdValue">
      <assert test="empty(@name) or (@name='split') or (@name='consolidated')">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:Id/hrxml:IdValue/@name must have one of the following values: [split, consolidated]</assert>
    </rule>
    <rule context="hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount">
      <assert test="empty(@type) or (@type='hourly') or (@type='hourlysplit') or (@type='hourlyconsolidated') or (@type='daily') or (@type='dailysplit') or (@type='dailyconsolidated') or (@type='Hourly') or (@type='HourlySplit') or (@type='HourlyConsolidated') or (@type='Daily') or (@type='DailySplit') or (@type='DailyConsolidated')">hrxml:TimeCard/hrxml:ReportedTime/hrxml:TimeInterval/hrxml:RateOrAmount/@type must have one of the following values: [hourly, hourlysplit, hourlyconsolidated, daily, dailysplit, dailyconsolidated, Hourly, HourlySplit, HourlyConsolidated, Daily, DailySplit, DailyConsolidated]</assert>
    </rule>
  </pattern>
</schema>
