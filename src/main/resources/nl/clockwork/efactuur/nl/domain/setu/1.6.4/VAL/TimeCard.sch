<?xml version="1.0" encoding="utf-8" ?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <title>Validations for TimeCard Mapping</title>
  <ns prefix="ns1" uri="http://ns.hr-xml.org/2007-04-15" />
  <pattern id="prohibitions">
    <rule context="ns1:TimeCard/ns1:ReportedResource/ns1:Resource">
      <assert test="empty(@type)">TimeCard/ReportedResource/Resource may not have attribute type</assert>
    </rule>
    <rule context="ns1:TimeCard/ns1:ReportedTime/ns1:TimeInterval">
      <assert test="empty(@dayAssignment)">TimeCard/ReportedTime/TimeInterval may not have attribute dayAssignment</assert>
    </rule>
    <rule context="ns1:TimeCard/ns1:ReportedTime/ns1:TimeInterval/ns1:Id/ns1:IdValue">
      <assert test="empty(@name)">TimeCard/ReportedTime/TimeInterval/Id/IdValue may not have attribute name</assert>
    </rule>
  </pattern>
  <pattern id="cardinality-redefines">
    <rule context="ns1:TimeCard">
      <assert test="count(ns1:Id) &gt;= 1">TimeCard must contain Id at least 1 time(s)</assert>
      <assert test="count(ns1:AdditionalData) &gt;= 1">TimeCard must contain AdditionalData at least 1 time(s)</assert>
    </rule>
    <rule context="ns1:TimeCard/ns1:Id">
      <assert test="count(ns1:IdValue) &lt;= 1">TimeCard/Id may contain IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:TimeCard/ns1:ReportedResource/ns1:Person/ns1:Id">
      <assert test="count(ns1:IdValue) &lt;= 1">TimeCard/ReportedResource/Person/Id may contain IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:TimeCard/ns1:ReportedResource/ns1:Person/ns1:PersonName">
      <assert test="count(ns1:GivenName) &lt;= 1">TimeCard/ReportedResource/Person/PersonName may contain GivenName at most 1 time(s)</assert>
      <assert test="count(ns1:FamilyName) &lt;= 2">TimeCard/ReportedResource/Person/PersonName may contain FamilyName at most 2 time(s)</assert>
    </rule>
    <rule context="ns1:TimeCard/ns1:ReportedResource/ns1:Resource">
      <assert test="count(ns1:Id) &lt;= 1">TimeCard/ReportedResource/Resource may contain Id at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:TimeCard/ns1:ReportedResource/ns1:Resource/ns1:Id">
      <assert test="count(ns1:IdValue) &lt;= 1">TimeCard/ReportedResource/Resource/Id may contain IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:TimeCard/ns1:ReportedTime/ns1:ReportedPersonAssignment/ns1:Id">
      <assert test="count(ns1:IdValue) &lt;= 1">TimeCard/ReportedTime/ReportedPersonAssignment/Id may contain IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:TimeCard/ns1:ReportedTime/ns1:TimeInterval/ns1:Id">
      <assert test="count(ns1:IdValue) &lt;= 1">TimeCard/ReportedTime/TimeInterval/Id may contain IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:TimeCard/ns1:ReportedTime/ns1:TimeInterval/ns1:Allowance">
      <assert test="count(ns1:Amount) &gt;= 1">TimeCard/ReportedTime/TimeInterval/Allowance must contain Amount at least 1 time(s)</assert>
    </rule>
    <rule context="ns1:TimeCard/ns1:ReportedTime/ns1:TimeInterval/ns1:Allowance/ns1:Id">
      <assert test="count(ns1:IdValue) &lt;= 1">TimeCard/ReportedTime/TimeInterval/Allowance/Id may contain IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:TimeCard/ns1:ReportedTime/ns1:TimeInterval/ns1:Allowance/ns1:Id/ns1:IdValue">
      <assert test="count(@name) &gt;= 1">TimeCard/ReportedTime/TimeInterval/Allowance/Id/IdValue must contain name at least 1 time(s)</assert>
    </rule>
    <rule context="ns1:TimeCard/ns1:ReportedTime/ns1:TimeInterval/ns1:AdditionalData">
      <assert test="count(ns1:StaffingAdditionalData) &gt;= 1 and count(ns1:StaffingAdditionalData) &lt;= 1">TimeCard/ReportedTime/TimeInterval/AdditionalData must contain StaffingAdditionalData at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:TimeCard/ns1:ReportedTime/ns1:TimeEvent/ns1:Id">
      <assert test="count(ns1:IdValue) &lt;= 1">TimeCard/ReportedTime/TimeEvent/Id may contain IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:TimeCard/ns1:ReportedTime/ns1:Allowance">
      <assert test="count(ns1:Amount) &gt;= 1">TimeCard/ReportedTime/Allowance must contain Amount at least 1 time(s)</assert>
    </rule>
    <rule context="ns1:TimeCard/ns1:ReportedTime/ns1:Allowance/ns1:Id/ns1:IdValue">
      <assert test="count(@name) &gt;= 1">TimeCard/ReportedTime/Allowance/Id/IdValue must contain name at least 1 time(s)</assert>
    </rule>
    <rule context="ns1:TimeCard/ns1:SubmitterInfo/ns1:Person/ns1:Id">
      <assert test="count(ns1:IdValue) &lt;= 1">TimeCard/SubmitterInfo/Person/Id may contain IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:TimeCard/ns1:SubmitterInfo/ns1:Person/ns1:PersonName">
      <assert test="count(ns1:GivenName) &lt;= 1">TimeCard/SubmitterInfo/Person/PersonName may contain GivenName at most 1 time(s)</assert>
      <assert test="count(ns1:FamilyName) &lt;= 2">TimeCard/SubmitterInfo/Person/PersonName may contain FamilyName at most 2 time(s)</assert>
    </rule>
    <rule context="ns1:TimeCard/ns1:ApprovalInfo/ns1:Person/ns1:Id">
      <assert test="count(ns1:IdValue) &lt;= 1">TimeCard/ApprovalInfo/Person/Id may contain IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:TimeCard/ns1:ApprovalInfo/ns1:Person/ns1:PersonName">
      <assert test="count(ns1:GivenName) &lt;= 1">TimeCard/ApprovalInfo/Person/PersonName may contain GivenName at most 1 time(s)</assert>
      <assert test="count(ns1:FamilyName) &lt;= 2">TimeCard/ApprovalInfo/Person/PersonName may contain FamilyName at most 2 time(s)</assert>
      <assert test="count(ns1:Affix) &lt;= 1">TimeCard/ApprovalInfo/Person/PersonName may contain Affix at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:TimeCard/ns1:AdditionalData">
      <assert test="count(ns1:StaffingAdditionalData) &gt;= 1">TimeCard/AdditionalData must contain StaffingAdditionalData at least 1 time(s)</assert>
    </rule>
    <rule context="ns1:TimeCard/ns1:AdditionalData/ns1:StaffingAdditionalData/ns1:CustomerReportingRequirements">
      <assert test="count(ns1:AdditionalRequirement) &gt;= 1">TimeCard/AdditionalData/StaffingAdditionalData/CustomerReportingRequirements must contain AdditionalRequirement at least 1 time(s)</assert>
    </rule>
    <rule context="ns1:TimeCard/ns1:AdditionalData/ns1:StaffingAdditionalData/ns1:CustomerReportingRequirements/ns1:AdditionalRequirement">
      <assert test="count(@requirementTitle) &gt;= 1">TimeCard/AdditionalData/StaffingAdditionalData/CustomerReportingRequirements/AdditionalRequirement must contain requirementTitle at least 1 time(s)</assert>
    </rule>
    <rule context="ns1:TimeCard/ns1:AdditionalData/ns1:StaffingAdditionalData/ns1:ReferenceInformation">
      <assert test="count(ns1:StaffingSupplierId) &lt;= 2">TimeCard/AdditionalData/StaffingAdditionalData/ReferenceInformation may contain StaffingSupplierId at most 2 time(s)</assert>
      <assert test="count(ns1:StaffingCustomerId) &lt;= 2">TimeCard/AdditionalData/StaffingAdditionalData/ReferenceInformation may contain StaffingCustomerId at most 2 time(s)</assert>
      <assert test="count(ns1:StaffingCustomerOrgUnitId) &lt;= 2">TimeCard/AdditionalData/StaffingAdditionalData/ReferenceInformation may contain StaffingCustomerOrgUnitId at most 2 time(s)</assert>
    </rule>
    <rule context="ns1:TimeCard/ns1:AdditionalData/ns1:StaffingAdditionalData/ns1:ReferenceInformation/ns1:StaffingSupplierId">
      <assert test="count(ns1:IdValue) &lt;= 1">TimeCard/AdditionalData/StaffingAdditionalData/ReferenceInformation/StaffingSupplierId may contain IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:TimeCard/ns1:AdditionalData/ns1:StaffingAdditionalData/ns1:ReferenceInformation/ns1:StaffingCustomerId">
      <assert test="count(ns1:IdValue) &lt;= 1">TimeCard/AdditionalData/StaffingAdditionalData/ReferenceInformation/StaffingCustomerId may contain IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:TimeCard/ns1:AdditionalData/ns1:StaffingAdditionalData/ns1:ReferenceInformation/ns1:StaffingCustomerOrgUnitId">
      <assert test="count(ns1:IdValue) &lt;= 1">TimeCard/AdditionalData/StaffingAdditionalData/ReferenceInformation/StaffingCustomerOrgUnitId may contain IdValue at most 1 time(s)</assert>
    </rule>
  </pattern>
  <pattern id="type-restrictions">
    <rule context="ns1:TimeCard/ns1:ReportedResource/ns1:Person/ns1:Id">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer')">TimeCard/ReportedResource/Person/Id/@idOwner may only have (one of) the following value(s): StaffingCompany, staffingCompany, StaffingCustomer, staffingCustomer</assert>
    </rule>
    <rule context="ns1:TimeCard/ns1:ReportedTime/ns1:TimeInterval/ns1:RateOrAmount">
      <assert test="empty(@type) or (@type='hourly') or (@type='hourlysplit') or (@type='hourlyconsolidated') or (@type='daily') or (@type='dailysplit') or (@type='dailyconsolidated') or (@type='Hourly') or (@type='HourlySplit') or (@type='HourlyConsolidated') or (@type='Daily') or (@type='DailySplit') or (@type='DailyConsolidated')">TimeCard/ReportedTime/TimeInterval/RateOrAmount/@type may only have (one of) the following value(s): hourly, hourlysplit, hourlyconsolidated, daily, dailysplit, dailyconsolidated, Hourly, HourlySplit, HourlyConsolidated, Daily, DailySplit, DailyConsolidated</assert>
    </rule>
    <rule context="ns1:TimeCard/ns1:ReportedTime/ns1:TimeInterval/ns1:Allowance/ns1:Id/ns1:IdValue">
      <assert test="empty(@name) or (@name='expense') or (@name='allowance') or (@name='Expense') or (@name='Allowance')">TimeCard/ReportedTime/TimeInterval/Allowance/Id/IdValue/@name may only have (one of) the following value(s): expense, allowance, Expense, Allowance</assert>
    </rule>
    <rule context="ns1:TimeCard/ns1:ReportedTime/ns1:TimeInterval/ns1:AdditionalData/ns1:StaffingAdditionalData/ns1:CustomerReportingRequirements/ns1:AdditionalRequirement">
      <assert test="empty(@requirementTitle) or (@requirementTitle='InclusiveRate') or (@requirementTitle='inclusiverate')">TimeCard/ReportedTime/TimeInterval/AdditionalData/StaffingAdditionalData/CustomerReportingRequirements/AdditionalRequirement/@requirementTitle may only have (one of) the following value(s): InclusiveRate, inclusiverate</assert>
    </rule>
    <rule context="ns1:TimeCard/ns1:ReportedTime/ns1:TimeEvent/ns1:RateOrAmount">
      <assert test="empty(@type) or (@type='hourly') or (@type='hourlysplit') or (@type='hourlyconsolidated') or (@type='daily') or (@type='dailysplit') or (@type='dailyconsolidated') or (@type='Hourly') or (@type='HourlySplit') or (@type='HourlyConsolidated') or (@type='Daily') or (@type='DailySplit') or (@type='DailyConsolidated')">TimeCard/ReportedTime/TimeEvent/RateOrAmount/@type may only have (one of) the following value(s): hourly, hourlysplit, hourlyconsolidated, daily, dailysplit, dailyconsolidated, Hourly, HourlySplit, HourlyConsolidated, Daily, DailySplit, DailyConsolidated</assert>
    </rule>
    <rule context="ns1:TimeCard/ns1:ReportedTime/ns1:Allowance/ns1:Id/ns1:IdValue">
      <assert test="empty(@name) or (@name='allowance') or (@name='expense') or (@name='Expense') or (@name='Allowance')">TimeCard/ReportedTime/Allowance/Id/IdValue/@name may only have (one of) the following value(s): allowance, expense, Expense, Allowance</assert>
    </rule>
    <rule context="ns1:TimeCard/ns1:AdditionalData/ns1:StaffingAdditionalData/ns1:CustomerReportingRequirements">
      <assert test="empty(ns1:AdditionalRequirement) or (ns1:AdditionalRequirement='1.6')">TimeCard/AdditionalData/StaffingAdditionalData/CustomerReportingRequirements/AdditionalRequirement may only have (one of) the following value(s): 1.6</assert>
    </rule>
    <rule context="ns1:TimeCard/ns1:AdditionalData/ns1:StaffingAdditionalData/ns1:CustomerReportingRequirements/ns1:AdditionalRequirement">
      <assert test="empty(@requirementTitle) or (@requirementTitle='VersionId')">TimeCard/AdditionalData/StaffingAdditionalData/CustomerReportingRequirements/AdditionalRequirement/@requirementTitle may only have (one of) the following value(s): VersionId</assert>
    </rule>
    <rule context="ns1:TimeCard/ns1:AdditionalData/ns1:StaffingAdditionalData/ns1:ReferenceInformation/ns1:StaffingSupplierId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi')">TimeCard/AdditionalData/StaffingAdditionalData/ReferenceInformation/StaffingSupplierId/@idOwner may only have (one of) the following value(s): StaffingCustomer, staffingCustomer, StaffingCompany, staffingCompany, OIN, KvK, BTW, Fi</assert>
    </rule>
    <rule context="ns1:TimeCard/ns1:AdditionalData/ns1:StaffingAdditionalData/ns1:ReferenceInformation/ns1:StaffingCustomerId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi')">TimeCard/AdditionalData/StaffingAdditionalData/ReferenceInformation/StaffingCustomerId/@idOwner may only have (one of) the following value(s): StaffingCustomer, staffingCustomer, StaffingCompany, staffingCompany, OIN, KvK, BTW, Fi</assert>
    </rule>
    <rule context="ns1:TimeCard/ns1:AdditionalData/ns1:StaffingAdditionalData/ns1:ReferenceInformation/ns1:StaffingCustomerOrgUnitId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi')">TimeCard/AdditionalData/StaffingAdditionalData/ReferenceInformation/StaffingCustomerOrgUnitId/@idOwner may only have (one of) the following value(s): StaffingCustomer, staffingCustomer, StaffingCompany, staffingCompany, OIN, KvK, BTW, Fi</assert>
    </rule>
  </pattern>
</schema>
