<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <title>Validations for StaffingOrder Mapping; strict=false</title>
  <ns prefix="hrxml" uri="http://ns.hr-xml.org/2007-04-15" />
  <ns prefix="setu" uri="http://ns.setu.nl/2008-01" />
  <pattern id="cardinality-redefines">
    <rule context="hrxml:StaffingOrder">
      <assert test="count(hrxml:OrderComments) &lt;= 1">hrxml:StaffingOrder may contain hrxml:OrderComments at most 1 time(s)</assert>
      <assert test="count(hrxml:OrderContact) &lt;= 1">hrxml:StaffingOrder may contain hrxml:OrderContact at most 1 time(s)</assert>
      <assert test="count(hrxml:StaffingPosition) &lt;= 1">hrxml:StaffingOrder may contain hrxml:StaffingPosition at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:CustomerReportingRequirements">
      <assert test="count(hrxml:AdditionalRequirement) &gt;= 1">hrxml:StaffingOrder/hrxml:CustomerReportingRequirements must contain hrxml:AdditionalRequirement at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement">
      <assert test="count(@requirementTitle) &gt;= 1">hrxml:StaffingOrder/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must contain @requirementTitle at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:OrderId">
      <assert test="count(hrxml:IdValue) &lt;= 2">hrxml:StaffingOrder/hrxml:OrderId may contain hrxml:IdValue at most 2 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:ReferenceInformation">
      <assert test="count(hrxml:IntermediaryId) &lt;= 1">hrxml:StaffingOrder/hrxml:ReferenceInformation may contain hrxml:IntermediaryId at most 1 time(s)</assert>
      <assert test="count(hrxml:MasterOrderId) &lt;= 1">hrxml:StaffingOrder/hrxml:ReferenceInformation may contain hrxml:MasterOrderId at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:MasterOrderId">
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:MasterOrderId may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId">
      <assert test="count(@idOwner) &gt;= 1">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId must contain @idOwner at least 1 time(s)</assert>
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId">
      <assert test="count(@idOwner) &gt;= 1">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId must contain @idOwner at least 1 time(s)</assert>
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId">
      <assert test="count(@idOwner) &gt;= 1">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId must contain @idOwner at least 1 time(s)</assert>
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition">
      <assert test="count(hrxml:StaffingShift) &lt;= 1">hrxml:StaffingOrder/hrxml:StaffingPosition may contain hrxml:StaffingShift at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader">
      <assert test="count(hrxml:RequestedPerson) &lt;= 1">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader may contain hrxml:RequestedPerson at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonId">
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonId may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonName">
      <assert test="count(hrxml:FamilyName) &lt;= 1">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonName may contain hrxml:FamilyName at most 1 time(s)</assert>
      <assert test="count(hrxml:GivenName) &lt;= 1">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonName may contain hrxml:GivenName at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:ShiftWork">
      <assert test="count(hrxml:Description) &gt;= 1">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:ShiftWork must contain hrxml:Description at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:UserArea">
      <assert test="count(setu:StaffingOrderAdditionalNL) &gt;= 1 and count(setu:StaffingOrderAdditionalNL) &lt;= 1">hrxml:StaffingOrder/hrxml:UserArea must contain setu:StaffingOrderAdditionalNL at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:OfferId">
      <assert test="count(hrxml:IdValue) &lt;= 2">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:OfferId may contain hrxml:IdValue at most 2 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:PreviousOrderId">
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:PreviousOrderId may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:RFQOrderId">
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:RFQOrderId may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory">
      <assert test="count(hrxml:SchoolOrInstitution) &lt;= 1">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory may contain hrxml:SchoolOrInstitution at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution">
      <assert test="count(hrxml:Degree) &lt;= 1">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may contain hrxml:Degree at most 1 time(s)</assert>
      <assert test="count(hrxml:LocalInstitutionClassification) &lt;= 1">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may contain hrxml:LocalInstitutionClassification at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id">
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
  </pattern>
  <pattern id="type-restrictions">
    <rule context="hrxml:StaffingOrder/hrxml:CustomerReportingRequirements">
      <assert test="count(hrxml:AdditionalRequirement[@requirementTitle = 'VersionId']) = 1">There MUST be one CustomerReportingRequirements/AdditionalRequirement with @requirementTitle equal to VersionId</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement[@requirementTitle = 'VersionId']">
      <assert test="text() = '1.8'">CustomerReportingRequirements/AdditionalRequirement must have value: 1.8 when requirementTitle is 'VersionId'.</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:OrderClassification">
      <assert test="empty(@orderStatus) or (@orderStatus='new') or (@orderStatus='revised') or (@orderStatus='closed') or (@orderStatus='reopened') or (@orderStatus='cancelled') or (@orderStatus='x:Rejected') or (@orderStatus='x:rejected')">hrxml:StaffingOrder/hrxml:OrderClassification/@orderStatus must have one of the following values: [new, revised, closed, reopened, cancelled, x:Rejected, x:rejected]</assert>
      <assert test="empty(@orderType) or (@orderType='RFQ') or (@orderType='order') or (@orderType='Order')">hrxml:StaffingOrder/hrxml:OrderClassification/@orderType must have one of the following values: [RFQ, order, Order]</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:OrderId">
      <assert test="(empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer')) or (empty(@idOwner) or (@idOwner=''))">hrxml:StaffingOrder/hrxml:OrderId/@idOwner must have one of the following values: [StaffingCustomer, staffingCustomer] OR hrxml:StaffingOrder/hrxml:OrderId/@idOwner must be Empty</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:OrderId/hrxml:IdValue[2]">
      <assert test="empty(@name) or (@name='Version') or (@name='version')">hrxml:StaffingOrder/hrxml:OrderId/hrxml:IdValue/@name must have one of the following values: [Version, version]</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:ReferenceInformation">
      <assert test="if (count(hrxml:StaffingCustomerOrgUnitId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingCustomerOrgUnitId[@idOwner = 'KvK']) = 1) else ('true')">If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.</assert>
      <assert test="if (count(hrxml:StaffingCustomerId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingCustomerId[@idOwner = 'KvK']) = 1) else ('true')">If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.</assert>
      <assert test="if (count(hrxml:StaffingSupplierId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingSupplierId[@idOwner = 'KvK']) = 1) else ('true')">If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.</assert>
      <assert test="count(hrxml:StaffingCustomerId/@idOwner) = count(distinct-values(hrxml:StaffingCustomerId/@idOwner))">The same idOwner may not be given for StaffingCustomerId</assert>
      <assert test="count(hrxml:StaffingCustomerOrgUnitId/@idOwner) = count(distinct-values(hrxml:StaffingCustomerOrgUnitId/@idOwner))">The same idOwner may not be given for StaffingCustomerOrgUnitId</assert>
      <assert test="count(hrxml:StaffingSupplierId/@idOwner) = count(distinct-values(hrxml:StaffingSupplierId/@idOwner))">The same idOwner may not be given for StaffingSupplierId</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId">
      <assert test="string-length() > 0">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId must be filled</assert>
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/@idOwner must have one of the following values: [StaffingCustomer, staffingCustomer, StaffingCompany, staffingCompany, OIN, KvK, BTW, Fi, Vest]</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId">
      <assert test="string-length() > 0">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId must be filled</assert>
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/@idOwner must have one of the following values: [StaffingCustomer, staffingCustomer, StaffingCompany, staffingCompany, OIN, KvK, BTW, Fi, Vest]</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId">
      <assert test="string-length() > 0">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId must be filled</assert>
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">hrxml:StaffingOrder/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/@idOwner must have one of the following values: [StaffingCustomer, staffingCustomer, StaffingCompany, staffingCompany, OIN, KvK, BTW, Fi, Vest]</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition">
      <assert test="empty(hrxml:PositionReason) or (hrxml:PositionReason='Illness') or (hrxml:PositionReason='Peak') or (hrxml:PositionReason='Project') or (hrxml:PositionReason='Reorganisation') or (hrxml:PositionReason='Position') or (hrxml:PositionReason='Vacation') or (hrxml:PositionReason='Maternity') or (hrxml:PositionReason='Season') or (hrxml:PositionReason='Replacement') or (hrxml:PositionReason='Recruitment') or (hrxml:PositionReason='Structural') or (hrxml:PositionReason='Other') or (hrxml:PositionReason='illness') or (hrxml:PositionReason='peak') or (hrxml:PositionReason='project') or (hrxml:PositionReason='reorganisation') or (hrxml:PositionReason='position') or (hrxml:PositionReason='vacation') or (hrxml:PositionReason='maternity') or (hrxml:PositionReason='season') or (hrxml:PositionReason='replacement') or (hrxml:PositionReason='recruitment') or (hrxml:PositionReason='structural') or (hrxml:PositionReason='other')">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionReason must have one of the following values: [Illness, Peak, Project, Reorganisation, Position, Vacation, Maternity, Season, Replacement, Recruitment, Structural, Other, illness, peak, project, reorganisation, position, vacation, maternity, season, replacement, recruitment, structural, other]</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader">
      <assert test="empty(hrxml:PositionType) or (hrxml:PositionType='Recruitment &amp; Selection') or (hrxml:PositionType='recruitment &amp; selection') or (hrxml:PositionType='Secondment') or (hrxml:PositionType='secondment') or (hrxml:PositionType='Temporary Staffing') or (hrxml:PositionType='temporary staffing')">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:PositionType must have one of the following values: [Recruitment &amp; Selection, recruitment &amp; selection, Secondment, secondment, Temporary Staffing, temporary staffing]</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:PositionId">
      <assert test="empty(hrxml:Id) or (hrxml:Id='')">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:PositionId/hrxml:Id must be Empty</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='BSN')">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:RequestedPerson/hrxml:PersonId/@idOwner must have one of the following values: [StaffingCustomer, staffingCustomer, BSN]</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:ShiftWork">
      <assert test="empty(@haveShiftWork) or (@haveShiftWork='true') or (@haveShiftWork='1')">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:PositionHeader/hrxml:ShiftWork/@haveShiftWork must have one of the following values: [true, 1]</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates">
      <assert test="empty(@rateStatus) or (@rateStatus='proposed') or (@rateStatus='agreed')">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/@rateStatus must have one of the following values: [proposed, agreed]</assert>
      <assert test="empty(@rateType) or (@rateType='bill') or (@rateType='pay') or (@rateType='minPayRate') or (@rateType='maxPayRate') or (@rateType='minBillRate') or (@rateType='maxBillRate')">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/@rateType must have one of the following values: [bill, pay, minPayRate, maxPayRate, minBillRate, maxBillRate]</assert>
      <assert test="(empty(hrxml:Class) or (hrxml:Class='TimeInterval') or (hrxml:Class='Allowance') or (hrxml:Class='Expense') or (hrxml:Class='timeInterval') or (hrxml:Class='allowance') or (hrxml:Class='expense')) or (empty(hrxml:Class) or (hrxml:Class=''))">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:Class must have one of the following values: [TimeInterval, Allowance, Expense, timeInterval, allowance, expense] OR hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:Class must be Empty</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:Amount">
      <assert test="empty(@rateAmountPeriod) or (@rateAmountPeriod='x:HourlySplit') or (@rateAmountPeriod='x:HourlyConsolidated') or (@rateAmountPeriod='x:4Weekly') or (@rateAmountPeriod='hourly') or (@rateAmountPeriod='x:hourlysplit') or (@rateAmountPeriod='x:hourlyconsolidated') or (@rateAmountPeriod='daily') or (@rateAmountPeriod='weekly') or (@rateAmountPeriod='x:4weekly') or (@rateAmountPeriod='monthly') or (@rateAmountPeriod='yearly')">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:Rates/hrxml:Amount/@rateAmountPeriod must have one of the following values: [x:HourlySplit, x:HourlyConsolidated, x:4Weekly, hourly, x:hourlysplit, x:hourlyconsolidated, daily, weekly, x:4weekly, monthly, yearly]</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift">
      <assert test="empty(@shiftPeriod) or (@shiftPeriod='weekly')">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift/@shiftPeriod must have one of the following values: [weekly]</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift/hrxml:Id">
      <assert test="empty(hrxml:IdValue) or (hrxml:IdValue='')">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:StaffingShift/hrxml:Id/hrxml:IdValue must be Empty</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite/hrxml:PostalAddress">
      <assert test="matches(hrxml:CountryCode, '^[A-Z][A-Z]$')">hrxml:StaffingOrder/hrxml:StaffingPosition/hrxml:WorkSite/hrxml:PostalAddress/hrxml:CountryCode must match regular expression: ^[A-Z][A-Z]$</assert>
    </rule>
    <rule context="hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:OfferId/hrxml:IdValue[2]">
      <assert test="empty(@name) or (@name='ReactToVersion') or (@name='reacttoversion')">hrxml:StaffingOrder/hrxml:UserArea/setu:StaffingOrderAdditionalNL/setu:OfferId/hrxml:IdValue/@name must have one of the following values: [ReactToVersion, reacttoversion]</assert>
    </rule>
  </pattern>
</schema>
