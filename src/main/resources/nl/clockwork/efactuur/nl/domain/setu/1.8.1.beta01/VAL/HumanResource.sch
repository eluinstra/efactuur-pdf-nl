<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <title>Validations for HumanResource Mapping; strict=false</title>
  <ns prefix="hrxml" uri="http://ns.hr-xml.org/2007-04-15" />
  <ns prefix="setu" uri="http://ns.setu.nl/2008-01" />
  <pattern id="cardinality-redefines">
    <rule context="hrxml:HumanResource">
      <assert test="count(hrxml:HumanResourceId) &lt;= 2">hrxml:HumanResource may contain hrxml:HumanResourceId at most 2 time(s)</assert>
      <assert test="count(hrxml:Rates) &lt;= 2">hrxml:HumanResource may contain hrxml:Rates at most 2 time(s)</assert>
      <assert test="count(hrxml:UserArea) &gt;= 1">hrxml:HumanResource must contain hrxml:UserArea at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:HumanResourceId">
      <assert test="count(hrxml:IdValue) &lt;= 2">hrxml:HumanResource/hrxml:HumanResourceId may contain hrxml:IdValue at most 2 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution">
      <assert test="count(hrxml:LocalInstitutionClassification) &lt;= 1">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may contain hrxml:LocalInstitutionClassification at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree">
      <assert test="count(hrxml:DatesOfAttendance) &lt;= 1">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may contain hrxml:DatesOfAttendance at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id">
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg">
      <assert test="count(hrxml:PositionHistory) &lt;= 1">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg may contain hrxml:PositionHistory at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:PersonName">
      <assert test="count(hrxml:FamilyName) &lt;= 2">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:PersonName may contain hrxml:FamilyName at most 2 time(s)</assert>
      <assert test="count(hrxml:GivenName) &lt;= 1">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:PersonName may contain hrxml:GivenName at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:PersonName/hrxml:FamilyName">
      <assert test="count(@primary) &gt;= 1">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:PersonName/hrxml:FamilyName must contain @primary at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ReferenceInformation">
      <assert test="count(hrxml:IntermediaryId) &lt;= 1">hrxml:HumanResource/hrxml:ReferenceInformation may contain hrxml:IntermediaryId at most 1 time(s)</assert>
      <assert test="count(hrxml:OrderId) &lt;= 1">hrxml:HumanResource/hrxml:ReferenceInformation may contain hrxml:OrderId at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:OrderId">
      <assert test="count(hrxml:IdValue) &lt;= 2">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:OrderId may contain hrxml:IdValue at most 2 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerId">
      <assert test="count(@idOwner) &gt;= 1">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerId must contain @idOwner at least 1 time(s)</assert>
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId">
      <assert test="count(@idOwner) &gt;= 1">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId must contain @idOwner at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierId">
      <assert test="count(@idOwner) &gt;= 1">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierId must contain @idOwner at least 1 time(s)</assert>
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ResourceInformation">
      <assert test="count(hrxml:AvailabilityDate) &lt;= 1">hrxml:HumanResource/hrxml:ResourceInformation may contain hrxml:AvailabilityDate at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:PersonName">
      <assert test="count(hrxml:FamilyName) &lt;= 2">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:PersonName may contain hrxml:FamilyName at most 2 time(s)</assert>
      <assert test="count(hrxml:GivenName) &lt;= 1">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:PersonName may contain hrxml:GivenName at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:PersonName/hrxml:FamilyName">
      <assert test="count(@primary) &gt;= 1">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:PersonName/hrxml:FamilyName must contain @primary at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ResourceInformation/hrxml:PersonName">
      <assert test="count(hrxml:FamilyName) &lt;= 2">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:PersonName may contain hrxml:FamilyName at most 2 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ResourceInformation/hrxml:PersonName/hrxml:FamilyName">
      <assert test="count(@primary) &gt;= 1">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:PersonName/hrxml:FamilyName must contain @primary at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:UserArea">
      <assert test="count(setu:HumanResourceAdditionalNL) &gt;= 1">hrxml:HumanResource/hrxml:UserArea must contain setu:HumanResourceAdditionalNL at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL">
      <assert test="count(setu:CustomerReportingRequirements) &gt;= 1">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL must contain setu:CustomerReportingRequirements at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements">
      <assert test="count(hrxml:AdditionalRequirement) &gt;= 1">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements must contain hrxml:AdditionalRequirement at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements/hrxml:AdditionalRequirement">
      <assert test="count(@requirementTitle) &gt;= 1">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements/hrxml:AdditionalRequirement must contain @requirementTitle at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:OfferId">
      <assert test="count(hrxml:IdValue) &lt;= 2">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:OfferId may contain hrxml:IdValue at most 2 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:PersonName">
      <assert test="count(hrxml:FamilyName) &lt;= 2">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:PersonName may contain hrxml:FamilyName at most 2 time(s)</assert>
      <assert test="count(hrxml:GivenName) &lt;= 1">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:PersonName may contain hrxml:GivenName at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:PersonName/hrxml:FamilyName">
      <assert test="count(@primary) &gt;= 1">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:PersonName/hrxml:FamilyName must contain @primary at least 1 time(s)</assert>
    </rule>
  </pattern>
  <pattern id="type-restrictions">
    <rule context="hrxml:HumanResource">
      <assert test="empty(hrxml:Preferences) or (hrxml:Preferences='')">hrxml:HumanResource/hrxml:Preferences must be Empty</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:HumanResourceId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer')">hrxml:HumanResource/hrxml:HumanResourceId/@idOwner must have one of the following values: [StaffingCompany, staffingCompany, StaffingCustomer, staffingCustomer]</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:HumanResourceId/hrxml:IdValue[2]">
      <assert test="empty(@name) or (@name='version') or (@name='Version')">hrxml:HumanResource/hrxml:HumanResourceId/hrxml:IdValue/@name must have one of the following values: [version, Version]</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:HumanResourceStatus">
      <assert test="empty(@status) or (@status='new') or (@status='revised') or (@status='x:Updated') or (@status='x:updated') or (@status='x:Confirmed') or (@status='x:confirmed') or (@status='pending') or (@status='accepted') or (@status='withdrawn') or (@status='rejected') or (@status='x:Assigned') or (@status='x:assigned')">hrxml:HumanResource/hrxml:HumanResourceStatus/@status must have one of the following values: [new, revised, x:Updated, x:updated, x:Confirmed, x:confirmed, pending, accepted, withdrawn, rejected, x:Assigned, x:assigned]</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:PersonName/hrxml:Affix">
      <assert test="empty(@type) or (@type='aristocraticTitle') or (@type='formOfAddress') or (@type='generation') or (@type='qualification')">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:PersonName/hrxml:Affix/@type must have one of the following values: [aristocraticTitle, formOfAddress, generation, qualification]</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:PersonName/hrxml:FamilyName">
      <assert test="empty(@primary) or (@primary='true') or (@primary='false')">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:PersonName/hrxml:FamilyName/@primary must have one of the following values: [true, false]</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory/hrxml:OrgName">
      <assert test="empty(hrxml:OrganizationName) or (hrxml:OrganizationName='')">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory/hrxml:OrgName/hrxml:OrganizationName must be Empty</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:IssuingAuthority">
      <assert test="matches(@countryCode, '^[A-Z][A-Z]$')">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:IssuingAuthority/@countryCode must match regular expression: ^[A-Z][A-Z]$</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:SupportingMaterials">
      <assert test="(count(hrxml:AttachmentReference) = 0 and count(hrxml:Description) = 0) or (count(hrxml:AttachmentReference) = 1 and count(hrxml:AttachmentReference/@mimeType) = 1 and count(hrxml:Description) = 1 and string-length(hrxml:AttachmentReference) &gt; 0 and string-length(hrxml:AttachmentReference/@mimeType) &gt; 0 and string-length(hrxml:Description) &gt; 0)">AttachmentReference, mimeType and Description MUST all be present or none at all</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Rates">
      <assert test="empty(@rateStatus) or (@rateStatus='proposed')">hrxml:HumanResource/hrxml:Rates/@rateStatus must have one of the following values: [proposed]</assert>
      <assert test="empty(@rateType) or (@rateType='bill') or (@rateType='pay') or (@rateType='minPayRate') or (@rateType='maxPayRate') or (@rateType='minBillRate') or (@rateType='maxBillRate')">hrxml:HumanResource/hrxml:Rates/@rateType must have one of the following values: [bill, pay, minPayRate, maxPayRate, minBillRate, maxBillRate]</assert>
      <assert test="(empty(hrxml:Class) or (hrxml:Class='TimeInterval') or (hrxml:Class='timeInterval') or (hrxml:Class='Allowance') or (hrxml:Class='allowance') or (hrxml:Class='Expense') or (hrxml:Class='expense')) or (empty(hrxml:Class) or (hrxml:Class=''))">hrxml:HumanResource/hrxml:Rates/hrxml:Class must have one of the following values: [TimeInterval, timeInterval, Allowance, allowance, Expense, expense] OR hrxml:HumanResource/hrxml:Rates/hrxml:Class must be Empty</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Rates/hrxml:Amount">
      <assert test="empty(@rateAmountPeriod) or (@rateAmountPeriod='hourly') or (@rateAmountPeriod='x:Hourlysplit') or (@rateAmountPeriod='x:hourlysplit') or (@rateAmountPeriod='x:HourlyConsolidated') or (@rateAmountPeriod='x:hourlyconsolidated') or (@rateAmountPeriod='daily') or (@rateAmountPeriod='weekly') or (@rateAmountPeriod='x:4Weekly') or (@rateAmountPeriod='x:4weekly') or (@rateAmountPeriod='monthly') or (@rateAmountPeriod='yearly')">hrxml:HumanResource/hrxml:Rates/hrxml:Amount/@rateAmountPeriod must have one of the following values: [hourly, x:Hourlysplit, x:hourlysplit, x:HourlyConsolidated, x:hourlyconsolidated, daily, weekly, x:4Weekly, x:4weekly, monthly, yearly]</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ReferenceInformation">
      <assert test="if (count(hrxml:StaffingCustomerOrgUnitId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingCustomerOrgUnitId[@idOwner = 'KvK']) = 1) else ('true')">If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.</assert>
      <assert test="if (count(hrxml:StaffingCustomerId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingCustomerId[@idOwner = 'KvK']) = 1) else ('true')">If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.</assert>
      <assert test="if (count(hrxml:StaffingSupplierId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingSupplierId[@idOwner = 'KvK']) = 1) else ('true')">If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.</assert>
      <assert test="count(hrxml:StaffingCustomerId/@idOwner) = count(distinct-values(hrxml:StaffingCustomerId/@idOwner))">The same idOwner may not be given for StaffingCustomerId</assert>
      <assert test="count(hrxml:StaffingCustomerOrgUnitId/@idOwner) = count(distinct-values(hrxml:StaffingCustomerOrgUnitId/@idOwner))">The same idOwner may not be given for StaffingCustomerOrgUnitId</assert>
      <assert test="count(hrxml:StaffingSupplierId/@idOwner) = count(distinct-values(hrxml:StaffingSupplierId/@idOwner))">The same idOwner may not be given for StaffingSupplierId</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:OrderId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer')">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:OrderId/@idOwner must have one of the following values: [StaffingCustomer, staffingCustomer]</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:OrderId/hrxml:IdValue[2]">
      <assert test="empty(@name) or (@name='ReactToVersion') or (@name='reacttoversion')">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:OrderId/hrxml:IdValue/@name must have one of the following values: [ReactToVersion, reacttoversion]</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerId">
      <assert test="string-length() > 0">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerId must be filled</assert>
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/@idOwner must have one of the following values: [StaffingCustomer, staffingCustomer, StaffingCompany, staffingCompany, OIN, KvK, BTW, Fi, Vest]</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId">
      <assert test="string-length() > 0">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId must be filled</assert>
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/@idOwner must have one of the following values: [StaffingCustomer, staffingCustomer, StaffingCompany, staffingCompany, OIN, KvK, BTW, Fi, Vest]</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierId">
      <assert test="string-length() > 0">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierId must be filled</assert>
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/@idOwner must have one of the following values: [StaffingCustomer, staffingCustomer, StaffingCompany, staffingCompany, OIN, KvK, BTW, Fi, Vest]</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:PostalAddress">
      <assert test="matches(hrxml:CountryCode, '^[A-Z][A-Z]$')">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:PostalAddress/hrxml:CountryCode must match regular expression: ^[A-Z][A-Z]$</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:PersonName/hrxml:Affix">
      <assert test="empty(@type) or (@type='aristocraticTitle') or (@type='formOfAddress') or (@type='generation') or (@type='qualification')">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:PersonName/hrxml:Affix/@type must have one of the following values: [aristocraticTitle, formOfAddress, generation, qualification]</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:PersonName/hrxml:FamilyName">
      <assert test="empty(@primary) or (@primary='true') or (@primary='false')">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:PersonName/hrxml:FamilyName/@primary must have one of the following values: [true, false]</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ResourceInformation/hrxml:PersonName/hrxml:Affix">
      <assert test="empty(@type) or (@type='aristocraticTitle') or (@type='formOfAddress') or (@type='generation') or (@type='qualification')">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:PersonName/hrxml:Affix/@type must have one of the following values: [aristocraticTitle, formOfAddress, generation, qualification]</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ResourceInformation/hrxml:PersonName/hrxml:FamilyName">
      <assert test="empty(@primary) or (@primary='true') or (@primary='false')">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:PersonName/hrxml:FamilyName/@primary must have one of the following values: [true, false]</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ResourceInformation/hrxml:PostalAddress">
      <assert test="matches(hrxml:CountryCode, '^[A-Z][A-Z]$')">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:PostalAddress/hrxml:CountryCode must match regular expression: ^[A-Z][A-Z]$</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL">
      <assert test="(count(setu:OfferId) = 1) or (../../hrxml:HumanResourceStatus/@status = 'x:Confirmed' or ../../hrxml:HumanResourceStatus/@status = 'x:confirmed' or ../../hrxml:HumanResourceStatus/@status = 'x:Assigned' or ../../hrxml:HumanResourceStatus/@status = 'x:assigned')">OfferId is required when status is not x:Confirmed, x:confirmed, xAssigned or x:assigned</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements">
      <assert test="count(hrxml:AdditionalRequirement[@requirementTitle = 'VersionId']) = 1">There MUST be one CustomerReportingRequirements/AdditionalRequirement with @requirementTitle equal to VersionId</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements/hrxml:AdditionalRequirement[@requirementTitle = 'VersionId']">
      <assert test="text() = '1.8'">CustomerReportingRequirements/AdditionalRequirement must have value: 1.8 when requirementTitle is 'VersionId'.</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:OfferId/hrxml:IdValue[2]">
      <assert test="empty(@name) or (@name='Version') or (@name='version')">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:OfferId/hrxml:IdValue/@name must have one of the following values: [Version, version]</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift">
      <assert test="empty(@shiftPeriod) or (@shiftPeriod='weekly')">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift/@shiftPeriod must have one of the following values: [weekly]</assert>
      <assert test="empty(hrxml:Id) or (hrxml:Id='')">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift/hrxml:Id must be Empty</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:PostalAddress">
      <assert test="matches(hrxml:CountryCode, '^[A-Z][A-Z]$')">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:PostalAddress/hrxml:CountryCode must match regular expression: ^[A-Z][A-Z]$</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:PersonName/hrxml:Affix">
      <assert test="empty(@type) or (@type='aristocraticTitle') or (@type='formOfAddress') or (@type='generation') or (@type='qualification')">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:PersonName/hrxml:Affix/@type must have one of the following values: [aristocraticTitle, formOfAddress, generation, qualification]</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:PersonName/hrxml:FamilyName">
      <assert test="empty(@primary) or (@primary='true') or (@primary='false')">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:PersonName/hrxml:FamilyName/@primary must have one of the following values: [true, false]</assert>
    </rule>
  </pattern>
</schema>
