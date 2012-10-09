<?xml version="1.0" encoding="utf-8" ?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <title>Validations for StaffingOrder Mapping</title>
  <ns prefix="ns1" uri="http://ns.hr-xml.org/2007-04-15" />
  <ns prefix="ns2" uri="http://ns.setu.nl/2008-01" />
  <pattern id="prohibitions">
  </pattern>
  <pattern id="cardinality-redefines">
    <rule context="ns1:StaffingOrder">
      <assert test="count(ns1:OrderContact) &lt;= 1">StaffingOrder may contain OrderContact at most 1 time(s)</assert>
      <assert test="count(ns1:OrderComments) &lt;= 1">StaffingOrder may contain OrderComments at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:StaffingOrder/ns1:OrderId">
      <assert test="count(ns1:IdValue) &lt;= 2">StaffingOrder/OrderId may contain IdValue at most 2 time(s)</assert>
    </rule>
    <rule context="ns1:StaffingOrder/ns1:ReferenceInformation">
      <assert test="count(ns1:MasterOrderId) &lt;= 1">StaffingOrder/ReferenceInformation may contain MasterOrderId at most 1 time(s)</assert>
      <assert test="count(ns1:StaffingCustomerId) &lt;= 2">StaffingOrder/ReferenceInformation may contain StaffingCustomerId at most 2 time(s)</assert>
      <assert test="count(ns1:StaffingCustomerOrgUnitId) &lt;= 2">StaffingOrder/ReferenceInformation may contain StaffingCustomerOrgUnitId at most 2 time(s)</assert>
      <assert test="count(ns1:IntermediaryId) &lt;= 1">StaffingOrder/ReferenceInformation may contain IntermediaryId at most 1 time(s)</assert>
      <assert test="count(ns1:StaffingSupplierId) &lt;= 2">StaffingOrder/ReferenceInformation may contain StaffingSupplierId at most 2 time(s)</assert>
    </rule>
    <rule context="ns1:StaffingOrder/ns1:ReferenceInformation/ns1:MasterOrderId">
      <assert test="count(ns1:IdValue) &lt;= 1">StaffingOrder/ReferenceInformation/MasterOrderId may contain IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:StaffingOrder/ns1:ReferenceInformation/ns1:StaffingCustomerId">
      <assert test="count(ns1:IdValue) &lt;= 1">StaffingOrder/ReferenceInformation/StaffingCustomerId may contain IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:StaffingOrder/ns1:ReferenceInformation/ns1:StaffingCustomerOrgUnitId">
      <assert test="count(ns1:IdValue) &lt;= 1">StaffingOrder/ReferenceInformation/StaffingCustomerOrgUnitId may contain IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:StaffingOrder/ns1:ReferenceInformation/ns1:StaffingSupplierId">
      <assert test="count(ns1:IdValue) &lt;= 1">StaffingOrder/ReferenceInformation/StaffingSupplierId may contain IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:StaffingOrder/ns1:CustomerReportingRequirements">
      <assert test="count(ns1:AdditionalRequirement) &gt;= 1">StaffingOrder/CustomerReportingRequirements must contain AdditionalRequirement at least 1 time(s)</assert>
    </rule>
    <rule context="ns1:StaffingOrder/ns1:CustomerReportingRequirements/ns1:AdditionalRequirement">
      <assert test="count(@requirementTitle) &gt;= 1">StaffingOrder/CustomerReportingRequirements/AdditionalRequirement must contain requirementTitle at least 1 time(s)</assert>
    </rule>
    <rule context="ns1:StaffingOrder/ns1:StaffingPosition">
      <assert test="count(ns1:Rates) &lt;= 2">StaffingOrder/StaffingPosition may contain Rates at most 2 time(s)</assert>
      <assert test="count(ns1:StaffingShift) &lt;= 1">StaffingOrder/StaffingPosition may contain StaffingShift at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:StaffingOrder/ns1:StaffingPosition/ns1:PositionHeader">
      <assert test="count(ns1:RequestedPerson) &lt;= 1">StaffingOrder/StaffingPosition/PositionHeader may contain RequestedPerson at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:StaffingOrder/ns1:StaffingPosition/ns1:PositionHeader/ns1:RequestedPerson/ns1:PersonName">
      <assert test="count(ns1:GivenName) &lt;= 1">StaffingOrder/StaffingPosition/PositionHeader/RequestedPerson/PersonName may contain GivenName at most 1 time(s)</assert>
      <assert test="count(ns1:FamilyName) &lt;= 1">StaffingOrder/StaffingPosition/PositionHeader/RequestedPerson/PersonName may contain FamilyName at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:StaffingOrder/ns1:StaffingPosition/ns1:PositionHeader/ns1:RequestedPerson/ns1:PersonId">
      <assert test="count(ns1:IdValue) &lt;= 1">StaffingOrder/StaffingPosition/PositionHeader/RequestedPerson/PersonId may contain IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:StaffingOrder/ns1:StaffingPosition/ns1:PositionHeader/ns1:ShiftWork">
      <assert test="count(ns1:Description) &gt;= 1">StaffingOrder/StaffingPosition/PositionHeader/ShiftWork must contain Description at least 1 time(s)</assert>
    </rule>
    <rule context="ns1:StaffingOrder/ns1:StaffingPosition/ns1:CustomerReportingRequirements">
      <assert test="count(ns1:CostCenterCode) &gt;= 1">StaffingOrder/StaffingPosition/CustomerReportingRequirements must contain CostCenterCode at least 1 time(s)</assert>
    </rule>
    <rule context="ns1:StaffingOrder/ns1:UserArea">
      <assert test="count(ns2:StaffingOrderAdditionalNL) &gt;= 1 and count(ns2:StaffingOrderAdditionalNL) &lt;= 1">StaffingOrder/UserArea must contain StaffingOrderAdditionalNL at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:StaffingOrder/ns1:UserArea/ns2:StaffingOrderAdditionalNL/ns2:OfferId">
      <assert test="count(ns1:IdValue) &lt;= 2">StaffingOrder/UserArea/StaffingOrderAdditionalNL/OfferId may contain IdValue at most 2 time(s)</assert>
    </rule>
    <rule context="ns1:StaffingOrder/ns1:UserArea/ns2:StaffingOrderAdditionalNL/ns2:PreviousOrderId">
      <assert test="count(ns1:IdValue) &lt;= 1">StaffingOrder/UserArea/StaffingOrderAdditionalNL/PreviousOrderId may contain IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:StaffingOrder/ns1:UserArea/ns2:StaffingOrderAdditionalNL/ns2:RFQOrderId">
      <assert test="count(ns1:IdValue) &lt;= 1">StaffingOrder/UserArea/StaffingOrderAdditionalNL/RFQOrderId may contain IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:StaffingOrder/ns1:UserArea/ns2:StaffingOrderAdditionalNL/ns2:StructuredXMLResume/ns1:EducationHistory">
      <assert test="count(ns1:SchoolOrInstitution) &lt;= 1">StaffingOrder/UserArea/StaffingOrderAdditionalNL/StructuredXMLResume/EducationHistory may contain SchoolOrInstitution at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:StaffingOrder/ns1:UserArea/ns2:StaffingOrderAdditionalNL/ns2:StructuredXMLResume/ns1:EducationHistory/ns1:SchoolOrInstitution">
      <assert test="count(ns1:LocalInstitutionClassification) &gt;= 1 and count(ns1:LocalInstitutionClassification) &lt;= 1">StaffingOrder/UserArea/StaffingOrderAdditionalNL/StructuredXMLResume/EducationHistory/SchoolOrInstitution must contain LocalInstitutionClassification at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:StaffingOrder/ns1:UserArea/ns2:StaffingOrderAdditionalNL/ns2:StructuredXMLResume/ns1:EducationHistory/ns1:SchoolOrInstitution/ns1:LocalInstitutionClassification/ns1:Id">
      <assert test="count(ns1:IdValue) &lt;= 1">StaffingOrder/UserArea/StaffingOrderAdditionalNL/StructuredXMLResume/EducationHistory/SchoolOrInstitution/LocalInstitutionClassification/Id may contain IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:StaffingOrder/ns1:UserArea/ns2:StaffingOrderAdditionalNL/ns2:StructuredXMLResume/ns1:Qualifications">
      <assert test="count(ns1:Competency) &lt;= 2">StaffingOrder/UserArea/StaffingOrderAdditionalNL/StructuredXMLResume/Qualifications may contain Competency at most 2 time(s)</assert>
    </rule>
  </pattern>
  <pattern id="type-restrictions">
    <rule context="ns1:StaffingOrder/ns1:OrderId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='')">StaffingOrder/OrderId/@idOwner may only have (one of) the following value(s): StaffingCustomer, staffingCustomer, [Empty]</assert>
    </rule>
    <rule context="ns1:StaffingOrder/ns1:OrderId/ns1:IdValue[2]">
      <assert test="empty(@name) or (@name='Version') or (@name='version')">StaffingOrder/OrderId/IdValue/@name[2] may only have (one of) the following value(s): Version, version</assert>
    </rule>
    <rule context="ns1:StaffingOrder/ns1:ReferenceInformation/ns1:StaffingCustomerId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi')">StaffingOrder/ReferenceInformation/StaffingCustomerId/@idOwner may only have (one of) the following value(s): StaffingCustomer, staffingCustomer, StaffingCompany, staffingCompany, OIN, KvK, BTW, Fi</assert>
    </rule>
    <rule context="ns1:StaffingOrder/ns1:ReferenceInformation/ns1:StaffingCustomerOrgUnitId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi')">StaffingOrder/ReferenceInformation/StaffingCustomerOrgUnitId/@idOwner may only have (one of) the following value(s): StaffingCustomer, staffingCustomer, StaffingCompany, staffingCompany, OIN, KvK, BTW, Fi</assert>
    </rule>
    <rule context="ns1:StaffingOrder/ns1:ReferenceInformation/ns1:StaffingSupplierId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi')">StaffingOrder/ReferenceInformation/StaffingSupplierId/@idOwner may only have (one of) the following value(s): StaffingCustomer, staffingCustomer, StaffingCompany, staffingCompany, OIN, KvK, BTW, Fi</assert>
    </rule>
    <rule context="ns1:StaffingOrder/ns1:CustomerReportingRequirements/ns1:AdditionalRequirement">
      <assert test="empty(@requirementTitle) or (@requirementTitle='MinimalRequiredEndDateValidityOffer') or (@requirementTitle='StartDateSubmittancePeriodOffer') or (@requirementTitle='EndDateSubmittancePeriodOffer') or (@requirementTitle='AwardDate') or (@requirementTitle='minimalRequiredEndDateValidityOffer') or (@requirementTitle='startDateSubmittancePeriodOffer') or (@requirementTitle='endDateSubmittancePeriodOffer') or (@requirementTitle='awardDate') or (@requirementTitle='VersionId')">StaffingOrder/CustomerReportingRequirements/AdditionalRequirement/@requirementTitle may only have (one of) the following value(s): MinimalRequiredEndDateValidityOffer, StartDateSubmittancePeriodOffer, EndDateSubmittancePeriodOffer, AwardDate, minimalRequiredEndDateValidityOffer, startDateSubmittancePeriodOffer, endDateSubmittancePeriodOffer, awardDate, VersionId</assert>
    </rule>
<!-- Handmatige test inserted voor VersionId: waarde 1.6 met title VersionId MOET, de andere title inhoud MAG, maar de elementwaarde is dan vrij in te vullen -->
    <rule context="ns1:StaffingOrder/ns1:CustomerReportingRequirements">
	  <assert test="count(ns1:AdditionalRequirement[@requirementTitle = 'VersionId']) = 1">StaffingOrder/CustomerReportingRequirements/AdditionalRequirement/@requirementTitle must have at least the value: VersionId</assert>
	  <assert test="(ns1:AdditionalRequirement = '1.6') and (ns1:AdditionalRequirement/@requirementTitle = 'VersionId')">StaffingOrder/CustomerReportingRequirements/AdditionalRequirement must have value: 1.6 when StaffingOrder/CustomerReportingRequirements/AdditionalRequirement is 'VersionId'.</assert>
    </rule>
<!-- Einde aanpassing -->
    <rule context="ns1:StaffingOrder/ns1:OrderClassification">
      <assert test="empty(@orderStatus) or (@orderStatus='new') or (@orderStatus='revised') or (@orderStatus='closed') or (@orderStatus='reopened') or (@orderStatus='cancelled') or (@orderStatus='x:Rejected') or (@orderStatus='x:rejected')">StaffingOrder/OrderClassification/@orderStatus may only have (one of) the following value(s): new, revised, closed, reopened, cancelled, x:Rejected, x:rejected</assert>
      <assert test="empty(@orderType) or (@orderType='RFQ') or (@orderType='order')">StaffingOrder/OrderClassification/@orderType may only have (one of) the following value(s): RFQ, order</assert>
    </rule>
    <rule context="ns1:StaffingOrder/ns1:StaffingPosition">
      <assert test="empty(ns1:PositionReason) or (ns1:PositionReason='Illness') or (ns1:PositionReason='Peak') or (ns1:PositionReason='Project') or (ns1:PositionReason='Reorganisation') or (ns1:PositionReason='Position') or (ns1:PositionReason='Vacation') or (ns1:PositionReason='Maternity') or (ns1:PositionReason='Season') or (ns1:PositionReason='Replacement') or (ns1:PositionReason='Recruitment') or (ns1:PositionReason='Structural') or (ns1:PositionReason='Other') or (ns1:PositionReason='illness') or (ns1:PositionReason='peak') or (ns1:PositionReason='project') or (ns1:PositionReason='reorganisation') or (ns1:PositionReason='position') or (ns1:PositionReason='vacation') or (ns1:PositionReason='maternity') or (ns1:PositionReason='season') or (ns1:PositionReason='replacement') or (ns1:PositionReason='recruitment') or (ns1:PositionReason='structural') or (ns1:PositionReason='other')">StaffingOrder/StaffingPosition/PositionReason may only have (one of) the following value(s): Illness, Peak, Project, Reorganisation, Position, Vacation, Maternity, Season, Replacement, Recruitment, Structural, Other, illness, peak, project, reorganisation, position, vacation, maternity, season, replacement, recruitment, structural, other</assert>
    </rule>
    <rule context="ns1:StaffingOrder/ns1:StaffingPosition/ns1:PositionHeader">
      <assert test="empty(ns1:PositionType) or (ns1:PositionType='Recruitment &amp; Selection') or (ns1:PositionType='recruitment &amp; selection') or (ns1:PositionType='Secondment') or (ns1:PositionType='secondment') or (ns1:PositionType='Temporary Staffing') or (ns1:PositionType='temporary staffing')">StaffingOrder/StaffingPosition/PositionHeader/PositionType may only have (one of) the following value(s): Recruitment &amp; Selection, recruitment &amp; selection, Secondment, secondment, Temporary Staffing, temporary staffing</assert>
    </rule>
    <rule context="ns1:StaffingOrder/ns1:StaffingPosition/ns1:PositionHeader/ns1:PositionId">
      <assert test="empty(ns1:Id) or (ns1:Id='')">StaffingOrder/StaffingPosition/PositionHeader/PositionId/Id may only have (one of) the following value(s): [Empty]</assert>
    </rule>
    <rule context="ns1:StaffingOrder/ns1:StaffingPosition/ns1:PositionHeader/ns1:RequestedPerson/ns1:PersonId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='BSN')">StaffingOrder/StaffingPosition/PositionHeader/RequestedPerson/PersonId/@idOwner may only have (one of) the following value(s): StaffingCustomer, staffingCustomer, BSN</assert>
    </rule>
    <rule context="ns1:StaffingOrder/ns1:StaffingPosition/ns1:PositionHeader/ns1:ShiftWork">
      <assert test="empty(@haveShiftWork) or (@haveShiftWork='true') or (@haveShiftWork='1')">StaffingOrder/StaffingPosition/PositionHeader/ShiftWork/@haveShiftWork may only have (one of) the following value(s): true, 1</assert>
      <assert test="empty(ns1:Description) or (ns1:Description='3-shift') or (ns1:Description='4-shift') or (ns1:Description='5-shift') or (ns1:Description='')">StaffingOrder/StaffingPosition/PositionHeader/ShiftWork/Description may only have (one of) the following value(s): 3-shift, 4-shift, 5-shift, [Empty]</assert>
    </rule>
    <rule context="ns1:StaffingOrder/ns1:StaffingPosition/ns1:Rates">
      <assert test="empty(@rateType) or (@rateType='bill') or (@rateType='pay') or (@rateType='minPayRate') or (@rateType='maxPayRate') or (@rateType='minBillRate') or (@rateType='maxBillRate')">StaffingOrder/StaffingPosition/Rates/@rateType may only have (one of) the following value(s): bill, pay, minPayRate, maxPayRate, minBillRate, maxBillRate</assert>
      <assert test="empty(@rateStatus) or (@rateStatus='proposed') or (@rateStatus='')">StaffingOrder/StaffingPosition/Rates/@rateStatus may only have (one of) the following value(s): proposed, [Empty]</assert>
      <assert test="empty(ns1:Class) or (ns1:Class='TimeInterval') or (ns1:Class='Allowance') or (ns1:Class='Expense') or (ns1:Class='timeInterval') or (ns1:Class='allowance') or (ns1:Class='expense') or (ns1:Class='')">StaffingOrder/StaffingPosition/Rates/Class may only have (one of) the following value(s): TimeInterval, Allowance, Expense, timeInterval, allowance, expense, [Empty]</assert>
    </rule>
    <rule context="ns1:StaffingOrder/ns1:StaffingPosition/ns1:Rates/ns1:Amount">
      <assert test="empty(@rateAmountPeriod) or (@rateAmountPeriod='x:HourlySplit') or (@rateAmountPeriod='x:HourlyConsolidated') or (@rateAmountPeriod='x:4Weekly') or (@rateAmountPeriod='hourly') or (@rateAmountPeriod='x:hourlysplit') or (@rateAmountPeriod='x:hourlyconsolidated') or (@rateAmountPeriod='daily') or (@rateAmountPeriod='weekly') or (@rateAmountPeriod='x:4weekly') or (@rateAmountPeriod='monthly') or (@rateAmountPeriod='yearly')">StaffingOrder/StaffingPosition/Rates/Amount/@rateAmountPeriod may only have (one of) the following value(s): x:HourlySplit, x:HourlyConsolidated, x:4Weekly, hourly, x:hourlysplit, x:hourlyconsolidated, daily, weekly, x:4weekly, monthly, yearly</assert>
    </rule>
    <rule context="ns1:StaffingOrder/ns1:StaffingPosition/ns1:WorkSite/ns1:PostalAddress">
      <assert test="matches(ns1:CountryCode, '^[A-Z][A-Z]$')">StaffingOrder/StaffingPosition/WorkSite/PostalAddress/CountryCode must conform to the regular expression: ^[A-Z][A-Z]$</assert>
    </rule>
    <rule context="ns1:StaffingOrder/ns1:StaffingPosition/ns1:StaffingShift">
      <assert test="empty(@shiftPeriod) or (@shiftPeriod='weekly')">StaffingOrder/StaffingPosition/StaffingShift/@shiftPeriod may only have (one of) the following value(s): weekly</assert>
    </rule>
    <rule context="ns1:StaffingOrder/ns1:StaffingPosition/ns1:StaffingShift/ns1:Id">
      <assert test="empty(ns1:IdValue) or (ns1:IdValue='')">StaffingOrder/StaffingPosition/StaffingShift/Id/IdValue may only have (one of) the following value(s): [Empty]</assert>
    </rule>
    <rule context="ns1:StaffingOrder/ns1:UserArea/ns2:StaffingOrderAdditionalNL/ns2:OfferId/ns1:IdValue[2]">
      <assert test="empty(@name) or (@name='ReactToVersion') or (@name='reacttoversion')">StaffingOrder/UserArea/StaffingOrderAdditionalNL/OfferId/IdValue/@name[2] may only have (one of) the following value(s): ReactToVersion, reacttoversion</assert>
    </rule>
  </pattern>
</schema>
