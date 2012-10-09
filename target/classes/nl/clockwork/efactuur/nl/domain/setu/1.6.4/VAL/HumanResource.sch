<?xml version="1.0" encoding="utf-8" ?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <title>Validations for HumanResource Mapping</title>
  <ns prefix="ns1" uri="http://ns.hr-xml.org/2007-04-15" />
  <ns prefix="ns2" uri="http://ns.setu.nl/2008-01" />
  <pattern id="prohibitions">
  </pattern>
  <pattern id="cardinality-redefines">
    <rule context="ns1:HumanResource">
      <assert test="count(ns1:HumanResourceId) &lt;= 2">HumanResource may contain HumanResourceId at most 2 time(s)</assert>
      <assert test="count(ns1:Rates) &lt;= 2">HumanResource may contain Rates at most 2 time(s)</assert>
      <assert test="count(ns1:UserArea) &gt;= 1">HumanResource must contain UserArea at least 1 time(s)</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:HumanResourceId">
      <assert test="count(ns1:IdValue) &lt;= 2">HumanResource/HumanResourceId may contain IdValue at most 2 time(s)</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:ReferenceInformation">
      <assert test="count(ns1:StaffingSupplierId) &lt;= 2">HumanResource/ReferenceInformation may contain StaffingSupplierId at most 2 time(s)</assert>
      <assert test="count(ns1:StaffingCustomerId) &lt;= 2">HumanResource/ReferenceInformation may contain StaffingCustomerId at most 2 time(s)</assert>
      <assert test="count(ns1:IntermediaryId) &lt;= 1">HumanResource/ReferenceInformation may contain IntermediaryId at most 1 time(s)</assert>
      <assert test="count(ns1:StaffingCustomerOrgUnitId) &lt;= 2">HumanResource/ReferenceInformation may contain StaffingCustomerOrgUnitId at most 2 time(s)</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:ReferenceInformation/ns1:StaffingSupplierId">
      <assert test="count(ns1:IdValue) &lt;= 1">HumanResource/ReferenceInformation/StaffingSupplierId may contain IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:ReferenceInformation/ns1:StaffingCustomerId">
      <assert test="count(ns1:IdValue) &lt;= 1">HumanResource/ReferenceInformation/StaffingCustomerId may contain IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:ReferenceInformation/ns1:OrderId">
      <assert test="count(ns1:IdValue) &lt;= 2">HumanResource/ReferenceInformation/OrderId may contain IdValue at most 2 time(s)</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:ReferenceInformation/ns1:StaffingCustomerOrgUnitId">
      <assert test="count(ns1:IdValue) &lt;= 1">HumanResource/ReferenceInformation/StaffingCustomerOrgUnitId may contain IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:ResourceInformation">
      <assert test="count(ns1:AvailabilityDate) &lt;= 1">HumanResource/ResourceInformation may contain AvailabilityDate at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:ResourceInformation/ns1:PersonName">
      <assert test="count(ns1:FamilyName) &lt;= 2">HumanResource/ResourceInformation/PersonName may contain FamilyName at most 2 time(s)</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:ResourceInformation/ns1:PersonName/ns1:FamilyName">
      <assert test="count(@primary) &gt;= 1">HumanResource/ResourceInformation/PersonName/FamilyName must contain primary at least 1 time(s)</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:ResourceInformation/ns1:EntityContactInfo/ns1:PersonName">
      <assert test="count(ns1:GivenName) &lt;= 1">HumanResource/ResourceInformation/EntityContactInfo/PersonName may contain GivenName at most 1 time(s)</assert>
      <assert test="count(ns1:FamilyName) &lt;= 2">HumanResource/ResourceInformation/EntityContactInfo/PersonName may contain FamilyName at most 2 time(s)</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:ResourceInformation/ns1:EntityContactInfo/ns1:PersonName/ns1:FamilyName">
      <assert test="count(@primary) &gt;= 1">HumanResource/ResourceInformation/EntityContactInfo/PersonName/FamilyName must contain primary at least 1 time(s)</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:Profile/ns1:Resume/ns1:StructuredXMLResume/ns1:EmploymentHistory/ns1:EmployerOrg">
      <assert test="count(ns1:PositionHistory) &lt;= 1">HumanResource/Profile/Resume/StructuredXMLResume/EmploymentHistory/EmployerOrg may contain PositionHistory at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:Profile/ns1:Resume/ns1:StructuredXMLResume/ns1:EmploymentHistory/ns1:EmployerOrg/ns1:EmployerContactInfo/ns1:PersonName">
      <assert test="count(ns1:GivenName) &lt;= 1">HumanResource/Profile/Resume/StructuredXMLResume/EmploymentHistory/EmployerOrg/EmployerContactInfo/PersonName may contain GivenName at most 1 time(s)</assert>
      <assert test="count(ns1:FamilyName) &lt;= 2">HumanResource/Profile/Resume/StructuredXMLResume/EmploymentHistory/EmployerOrg/EmployerContactInfo/PersonName may contain FamilyName at most 2 time(s)</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:Profile/ns1:Resume/ns1:StructuredXMLResume/ns1:EmploymentHistory/ns1:EmployerOrg/ns1:EmployerContactInfo/ns1:PersonName/ns1:FamilyName">
      <assert test="count(@primary) &gt;= 1">HumanResource/Profile/Resume/StructuredXMLResume/EmploymentHistory/EmployerOrg/EmployerContactInfo/PersonName/FamilyName must contain primary at least 1 time(s)</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:Profile/ns1:Resume/ns1:StructuredXMLResume/ns1:EducationHistory">
      <assert test="count(ns1:SchoolOrInstitution) &lt;= 1">HumanResource/Profile/Resume/StructuredXMLResume/EducationHistory may contain SchoolOrInstitution at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:Profile/ns1:Resume/ns1:StructuredXMLResume/ns1:EducationHistory/ns1:SchoolOrInstitution">
      <assert test="count(ns1:Degree) &lt;= 1">HumanResource/Profile/Resume/StructuredXMLResume/EducationHistory/SchoolOrInstitution may contain Degree at most 1 time(s)</assert>
      <assert test="count(ns1:LocalInstitutionClassification) &lt;= 1">HumanResource/Profile/Resume/StructuredXMLResume/EducationHistory/SchoolOrInstitution may contain LocalInstitutionClassification at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:Profile/ns1:Resume/ns1:StructuredXMLResume/ns1:EducationHistory/ns1:SchoolOrInstitution/ns1:Degree">
      <assert test="count(ns1:DatesOfAttendance) &lt;= 1">HumanResource/Profile/Resume/StructuredXMLResume/EducationHistory/SchoolOrInstitution/Degree may contain DatesOfAttendance at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:Profile/ns1:Resume/ns1:StructuredXMLResume/ns1:EducationHistory/ns1:SchoolOrInstitution/ns1:LocalInstitutionClassification/ns1:Id">
      <assert test="count(ns1:IdValue) &lt;= 1">HumanResource/Profile/Resume/StructuredXMLResume/EducationHistory/SchoolOrInstitution/LocalInstitutionClassification/Id may contain IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:Profile/ns1:Resume/ns1:NonXMLResume/ns1:SupportingMaterials">
      <assert test="count(ns1:AttachmentReference) &gt;= 1">HumanResource/Profile/Resume/NonXMLResume/SupportingMaterials must contain AttachmentReference at least 1 time(s)</assert>
      <assert test="count(ns1:Description) &gt;= 1">HumanResource/Profile/Resume/NonXMLResume/SupportingMaterials must contain Description at least 1 time(s)</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:Profile/ns1:Resume/ns1:NonXMLResume/ns1:SupportingMaterials/ns1:AttachmentReference">
      <assert test="count(@mimeType) &gt;= 1">HumanResource/Profile/Resume/NonXMLResume/SupportingMaterials/AttachmentReference must contain mimeType at least 1 time(s)</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:UserArea">
      <assert test="count(ns2:HumanResourceAdditionalNL) &gt;= 1">HumanResource/UserArea must contain HumanResourceAdditionalNL at least 1 time(s)</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:UserArea/ns2:HumanResourceAdditionalNL">
      <assert test="count(ns2:OfferId) &gt;= 1">HumanResource/UserArea/HumanResourceAdditionalNL must contain OfferId at least 1 time(s)</assert>
      <assert test="count(ns2:CustomerReportingRequirements) &gt;= 1">HumanResource/UserArea/HumanResourceAdditionalNL must contain CustomerReportingRequirements at least 1 time(s)</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:UserArea/ns2:HumanResourceAdditionalNL/ns2:OfferId">
      <assert test="count(ns1:IdValue) &lt;= 2">HumanResource/UserArea/HumanResourceAdditionalNL/OfferId may contain IdValue at most 2 time(s)</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:UserArea/ns2:HumanResourceAdditionalNL/ns2:StaffingShift/ns1:Id">
      <assert test="count(ns1:IdValue) &lt;= 2">HumanResource/UserArea/HumanResourceAdditionalNL/StaffingShift/Id may contain IdValue at most 2 time(s)</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:UserArea/ns2:HumanResourceAdditionalNL/ns2:CustomerReportingRequirements">
      <assert test="count(ns1:CostCenterCode) &gt;= 1">HumanResource/UserArea/HumanResourceAdditionalNL/CustomerReportingRequirements must contain CostCenterCode at least 1 time(s)</assert>
      <assert test="count(ns1:AdditionalRequirement) &gt;= 1">HumanResource/UserArea/HumanResourceAdditionalNL/CustomerReportingRequirements must contain AdditionalRequirement at least 1 time(s)</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:UserArea/ns2:HumanResourceAdditionalNL/ns2:CustomerReportingRequirements/ns1:AdditionalRequirement">
      <assert test="count(@requirementTitle) &gt;= 1">HumanResource/UserArea/HumanResourceAdditionalNL/CustomerReportingRequirements/AdditionalRequirement must contain requirementTitle at least 1 time(s)</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:UserArea/ns2:HumanResourceAdditionalNL/ns2:SupplierContactInfo/ns1:PersonName">
      <assert test="count(ns1:GivenName) &lt;= 1">HumanResource/UserArea/HumanResourceAdditionalNL/SupplierContactInfo/PersonName may contain GivenName at most 1 time(s)</assert>
      <assert test="count(ns1:FamilyName) &lt;= 2">HumanResource/UserArea/HumanResourceAdditionalNL/SupplierContactInfo/PersonName may contain FamilyName at most 2 time(s)</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:UserArea/ns2:HumanResourceAdditionalNL/ns2:SupplierContactInfo/ns1:PersonName/ns1:FamilyName">
      <assert test="count(@primary) &gt;= 1">HumanResource/UserArea/HumanResourceAdditionalNL/SupplierContactInfo/PersonName/FamilyName must contain primary at least 1 time(s)</assert>
    </rule>
  </pattern>
  <pattern id="type-restrictions">
    <rule context="ns1:HumanResource">
      <assert test="empty(ns1:Preferences) or (ns1:Preferences='')">HumanResource/Preferences may only have (one of) the following value(s): [Empty]</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:HumanResourceId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer')">HumanResource/HumanResourceId/@idOwner may only have (one of) the following value(s): StaffingCompany, staffingCompany, StaffingCustomer, staffingCustomer</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:HumanResourceId/ns1:IdValue[2]">
      <assert test="empty(@name) or (@name='version') or (@name='Version')">HumanResource/HumanResourceId/IdValue/@name[2] may only have (one of) the following value(s): version, Version</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:HumanResourceStatus">
      <assert test="empty(@status) or (@status='new') or (@status='revised') or (@status='x:Updated') or (@status='x:updated') or (@status='x:Confirmed') or (@status='x:confirmed') or (@status='pending') or (@status='accepted') or (@status='withdrawn') or (@status='rejected') or (@status='x:Assigned') or (@status='x:assigned')">HumanResource/HumanResourceStatus/@status may only have (one of) the following value(s): new, revised, x:Updated, x:updated, x:Confirmed, x:confirmed, pending, accepted, withdrawn, rejected, x:Assigned, x:assigned</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:ReferenceInformation/ns1:StaffingSupplierId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi')">HumanResource/ReferenceInformation/StaffingSupplierId/@idOwner may only have (one of) the following value(s): StaffingCustomer, staffingCustomer, StaffingCompany, staffingCompany, OIN, KvK, BTW, Fi</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:ReferenceInformation/ns1:StaffingCustomerId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi')">HumanResource/ReferenceInformation/StaffingCustomerId/@idOwner may only have (one of) the following value(s): StaffingCustomer, staffingCustomer, StaffingCompany, staffingCompany, OIN, KvK, BTW, Fi</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:ReferenceInformation/ns1:OrderId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer')">HumanResource/ReferenceInformation/OrderId/@idOwner may only have (one of) the following value(s): StaffingCustomer, staffingCustomer</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:ReferenceInformation/ns1:OrderId/ns1:IdValue[2]">
      <assert test="empty(@name) or (@name='ReactToVersion') or (@name='reacttoversion')">HumanResource/ReferenceInformation/OrderId/IdValue/@name[2] may only have (one of) the following value(s): ReactToVersion, reacttoversion</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:ReferenceInformation/ns1:StaffingCustomerOrgUnitId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi')">HumanResource/ReferenceInformation/StaffingCustomerOrgUnitId/@idOwner may only have (one of) the following value(s): StaffingCustomer, staffingCustomer, StaffingCompany, staffingCompany, OIN, KvK, BTW, Fi</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:ReferenceInformation/ns1:StaffingCustomerOrgUnitId/ns1:IdValue">
      <assert test="empty(@name) or (@name='')">HumanResource/ReferenceInformation/StaffingCustomerOrgUnitId/IdValue/@name may only have (one of) the following value(s): [Empty]</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:ResourceInformation/ns1:PersonName/ns1:FamilyName">
      <assert test="empty(@primary) or (@primary='true') or (@primary='false')">HumanResource/ResourceInformation/PersonName/FamilyName/@primary may only have (one of) the following value(s): true, false</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:ResourceInformation/ns1:PersonName/ns1:Affix">
      <assert test="empty(@type) or (@type='aristocraticTitle') or (@type='formOfAddress') or (@type='generation') or (@type='qualification')">HumanResource/ResourceInformation/PersonName/Affix/@type may only have (one of) the following value(s): aristocraticTitle, formOfAddress, generation, qualification</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:ResourceInformation/ns1:EntityContactInfo/ns1:PersonName/ns1:Affix">
      <assert test="empty(@type) or (@type='aristocraticTitle') or (@type='formOfAddress') or (@type='generation') or (@type='qualification')">HumanResource/ResourceInformation/EntityContactInfo/PersonName/Affix/@type may only have (one of) the following value(s): aristocraticTitle, formOfAddress, generation, qualification</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:ResourceInformation/ns1:EntityContactInfo/ns1:ContactMethod/ns1:PostalAddress">
      <assert test="matches(ns1:CountryCode, '^[A-Z][A-Z]$')">HumanResource/ResourceInformation/EntityContactInfo/ContactMethod/PostalAddress/CountryCode must conform to the regular expression: ^[A-Z][A-Z]$</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:ResourceInformation/ns1:PostalAddress">
      <assert test="matches(ns1:CountryCode, '^[A-Z][A-Z]$')">HumanResource/ResourceInformation/PostalAddress/CountryCode must conform to the regular expression: ^[A-Z][A-Z]$</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:Rates">
      <assert test="empty(@rateType) or (@rateType='bill') or (@rateType='pay') or (@rateType='minPayRate') or (@rateType='maxPayRate') or (@rateType='minBillRate') or (@rateType='maxBillRate')">HumanResource/Rates/@rateType may only have (one of) the following value(s): bill, pay, minPayRate, maxPayRate, minBillRate, maxBillRate</assert>
      <assert test="empty(@rateStatus) or (@rateStatus='proposed')">HumanResource/Rates/@rateStatus may only have (one of) the following value(s): proposed</assert>
      <assert test="empty(ns1:Class) or (ns1:Class='')">HumanResource/Rates/Class may only have (one of) the following value(s): [Empty]</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:Rates/ns1:Amount">
      <assert test="empty(@rateAmountPeriod) or (@rateAmountPeriod='hourly') or (@rateAmountPeriod='x:Hourlysplit') or (@rateAmountPeriod='x:hourlysplit') or (@rateAmountPeriod='x:HourlyConsolidated') or (@rateAmountPeriod='x:hourlyconsolidated') or (@rateAmountPeriod='daily') or (@rateAmountPeriod='weekly') or (@rateAmountPeriod='x:4Weekly') or (@rateAmountPeriod='x:4weekly') or (@rateAmountPeriod='monthly') or (@rateAmountPeriod='yearly')">HumanResource/Rates/Amount/@rateAmountPeriod may only have (one of) the following value(s): hourly, x:Hourlysplit, x:hourlysplit, x:HourlyConsolidated, x:hourlyconsolidated, daily, weekly, x:4Weekly, x:4weekly, monthly, yearly</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:Profile/ns1:Resume/ns1:StructuredXMLResume/ns1:EmploymentHistory/ns1:EmployerOrg/ns1:EmployerContactInfo/ns1:PersonName/ns1:Affix">
      <assert test="empty(@type) or (@type='aristocraticTitle') or (@type='formOfAddress') or (@type='generation') or (@type='qualification')">HumanResource/Profile/Resume/StructuredXMLResume/EmploymentHistory/EmployerOrg/EmployerContactInfo/PersonName/Affix/@type may only have (one of) the following value(s): aristocraticTitle, formOfAddress, generation, qualification</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:Profile/ns1:Resume/ns1:StructuredXMLResume/ns1:EmploymentHistory/ns1:EmployerOrg/ns1:PositionHistory/ns1:OrgName">
      <assert test="empty(ns1:OrganizationName) or (ns1:OrganizationName='')">HumanResource/Profile/Resume/StructuredXMLResume/EmploymentHistory/EmployerOrg/PositionHistory/OrgName/OrganizationName may only have (one of) the following value(s): [Empty]</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:Profile/ns1:Resume/ns1:StructuredXMLResume/ns1:EducationHistory/ns1:SchoolOrInstitution/ns1:LocalInstitutionClassification/ns1:Id">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer')">HumanResource/Profile/Resume/StructuredXMLResume/EducationHistory/SchoolOrInstitution/LocalInstitutionClassification/Id/@idOwner may only have (one of) the following value(s): StaffingCustomer, staffingCustomer</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:Profile/ns1:Resume/ns1:StructuredXMLResume/ns1:LicensesAndCertifications/ns1:LicenseOrCertification/ns1:IssuingAuthority">
      <assert test="matches(@countryCode, '^[A-Z][A-Z]$')">HumanResource/Profile/Resume/StructuredXMLResume/LicensesAndCertifications/LicenseOrCertification/IssuingAuthority/@countryCode must conform to the regular expression: ^[A-Z][A-Z]$</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:UserArea/ns2:HumanResourceAdditionalNL/ns2:OfferId/ns1:IdValue[2]">
      <assert test="empty(@name) or (@name='Version') or (@name='version')">HumanResource/UserArea/HumanResourceAdditionalNL/OfferId/IdValue/@name[2] may only have (one of) the following value(s): Version, version</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:UserArea/ns2:HumanResourceAdditionalNL/ns2:StaffingShift">
      <assert test="empty(@shiftPeriod) or (@shiftPeriod='weekly')">HumanResource/UserArea/HumanResourceAdditionalNL/StaffingShift/@shiftPeriod may only have (one of) the following value(s): weekly</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:UserArea/ns2:HumanResourceAdditionalNL/ns2:CustomerReportingRequirements">
      <assert test="empty(ns1:AdditionalRequirement) or (ns1:AdditionalRequirement='1.6')">HumanResource/UserArea/HumanResourceAdditionalNL/CustomerReportingRequirements/AdditionalRequirement may only have (one of) the following value(s): 1.6</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:UserArea/ns2:HumanResourceAdditionalNL/ns2:CustomerReportingRequirements/ns1:AdditionalRequirement">
      <assert test="empty(@requirementTitle) or (@requirementTitle='VersionId')">HumanResource/UserArea/HumanResourceAdditionalNL/CustomerReportingRequirements/AdditionalRequirement/@requirementTitle may only have (one of) the following value(s): VersionId</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:UserArea/ns2:HumanResourceAdditionalNL/ns2:SupplierContactInfo/ns1:PersonName/ns1:Affix">
      <assert test="empty(@type) or (@type='aristocraticTitle') or (@type='formOfAddress') or (@type='generation') or (@type='qualification')">HumanResource/UserArea/HumanResourceAdditionalNL/SupplierContactInfo/PersonName/Affix/@type may only have (one of) the following value(s): aristocraticTitle, formOfAddress, generation, qualification</assert>
    </rule>
    <rule context="ns1:HumanResource/ns1:UserArea/ns2:HumanResourceAdditionalNL/ns2:SupplierContactInfo/ns1:ContactMethod/ns1:PostalAddress">
      <assert test="matches(ns1:CountryCode, '^[A-Z][A-Z]$')">HumanResource/UserArea/HumanResourceAdditionalNL/SupplierContactInfo/ContactMethod/PostalAddress/CountryCode must conform to the regular expression: ^[A-Z][A-Z]$</assert>
    </rule>
  </pattern>
</schema>
