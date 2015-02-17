<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <title>Validations for HumanResource Mapping; strict=false</title>
  <ns prefix="hrxml" uri="http://ns.hr-xml.org/2007-04-15" />
  <ns prefix="setu" uri="http://ns.setu.nl/2012-01" />
  <pattern id="prohibitions">
    <rule context="hrxml:HumanResource">
      <assert test="empty(hrxml:ResourceScreening)">hrxml:HumanResource may not contain hrxml:ResourceScreening</assert>
      <assert test="empty(hrxml:SocialInsurance)">hrxml:HumanResource may not contain hrxml:SocialInsurance</assert>
      <assert test="empty(@lang)">hrxml:HumanResource may not contain @lang</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:HumanResourceId">
      <assert test="empty(@validFrom)">hrxml:HumanResource/hrxml:HumanResourceId may not contain @validFrom</assert>
      <assert test="empty(@validTo)">hrxml:HumanResource/hrxml:HumanResourceId may not contain @validTo</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:HumanResourceId/hrxml:IdValue">
      <assert test="empty(@name)">hrxml:HumanResource/hrxml:HumanResourceId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:HumanResourceStatus">
      <assert test="empty(@statusChangeReason)">hrxml:HumanResource/hrxml:HumanResourceStatus may not contain @statusChangeReason</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Preferences">
      <assert test="empty(hrxml:DistributionRestrictions)">hrxml:HumanResource/hrxml:Preferences may not contain hrxml:DistributionRestrictions</assert>
      <assert test="empty(hrxml:Commute)">hrxml:HumanResource/hrxml:Preferences may not contain hrxml:Commute</assert>
      <assert test="empty(hrxml:Relocation)">hrxml:HumanResource/hrxml:Preferences may not contain hrxml:Relocation</assert>
      <assert test="empty(hrxml:Travel)">hrxml:HumanResource/hrxml:Preferences may not contain hrxml:Travel</assert>
      <assert test="empty(hrxml:DesiredShift)">hrxml:HumanResource/hrxml:Preferences may not contain hrxml:DesiredShift</assert>
      <assert test="empty(hrxml:DesiredCompensation)">hrxml:HumanResource/hrxml:Preferences may not contain hrxml:DesiredCompensation</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile">
      <assert test="empty(hrxml:PositionHeader)">hrxml:HumanResource/hrxml:Profile may not contain hrxml:PositionHeader</assert>
      <assert test="empty(hrxml:Competency)">hrxml:HumanResource/hrxml:Profile may not contain hrxml:Competency</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume">
      <assert test="empty(@lang)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume may not contain @lang</assert>
      <assert test="empty(hrxml:NonXMLResume)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume may not contain hrxml:NonXMLResume</assert>
      <assert test="empty(hrxml:ResumeId)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume may not contain hrxml:ResumeId</assert>
      <assert test="empty(hrxml:UserArea)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume may not contain hrxml:UserArea</assert>
      <assert test="empty(hrxml:DistributionGuidelines)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume may not contain hrxml:DistributionGuidelines</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume">
      <assert test="empty(hrxml:ExecutiveSummary)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume may not contain hrxml:ExecutiveSummary</assert>
      <assert test="empty(hrxml:MilitaryHistory)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume may not contain hrxml:MilitaryHistory</assert>
      <assert test="empty(hrxml:RevisionDate)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume may not contain hrxml:RevisionDate</assert>
      <assert test="empty(hrxml:PublicationHistory)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume may not contain hrxml:PublicationHistory</assert>
      <assert test="empty(hrxml:Comments)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume may not contain hrxml:Comments</assert>
      <assert test="empty(hrxml:SpeakingEventsHistory)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume may not contain hrxml:SpeakingEventsHistory</assert>
      <assert test="empty(hrxml:ResumeAdditionalItems)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume may not contain hrxml:ResumeAdditionalItems</assert>
      <assert test="empty(hrxml:Languages)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume may not contain hrxml:Languages</assert>
      <assert test="empty(hrxml:PatentHistory)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume may not contain hrxml:PatentHistory</assert>
      <assert test="empty(hrxml:References)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume may not contain hrxml:References</assert>
      <assert test="empty(hrxml:Objective)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume may not contain hrxml:Objective</assert>
      <assert test="empty(hrxml:Achievements)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume may not contain hrxml:Achievements</assert>
      <assert test="empty(hrxml:Associations)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume may not contain hrxml:Associations</assert>
      <assert test="empty(hrxml:SecurityCredentials)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume may not contain hrxml:SecurityCredentials</assert>
      <assert test="empty(hrxml:ContactInfo)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume may not contain hrxml:ContactInfo</assert>
      <assert test="empty(hrxml:ProfessionalAssociations)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume may not contain hrxml:ProfessionalAssociations</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution">
      <assert test="empty(hrxml:LocationSummary)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:LocationSummary</assert>
      <assert test="empty(hrxml:PostalAddress)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:PostalAddress</assert>
      <assert test="empty(hrxml:ISCEDInstitutionClassification)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:ISCEDInstitutionClassification</assert>
      <assert test="empty(hrxml:OrganizationUnit)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:OrganizationUnit</assert>
      <assert test="empty(hrxml:SchoolName)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:SchoolName</assert>
      <assert test="empty(hrxml:Measure)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:Measure</assert>
      <assert test="empty(hrxml:School)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:School</assert>
      <assert test="empty(hrxml:Minor)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:Minor</assert>
      <assert test="empty(hrxml:Comments)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:Comments</assert>
      <assert test="empty(hrxml:UserArea)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:UserArea</assert>
      <assert test="empty(hrxml:Major)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may not contain hrxml:Major</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance">
      <assert test="empty(@enrollmentStatus)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance may not contain @enrollmentStatus</assert>
      <assert test="empty(@currentlyEnrolled)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance may not contain @currentlyEnrolled</assert>
      <assert test="empty(@studentInGoodStanding)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance may not contain @studentInGoodStanding</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance/hrxml:EndDate">
      <assert test="empty(hrxml:MonthDay)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance/hrxml:EndDate may not contain hrxml:MonthDay</assert>
      <assert test="empty(hrxml:StringDate)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance/hrxml:EndDate may not contain hrxml:StringDate</assert>
      <assert test="empty(hrxml:Year)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance/hrxml:EndDate may not contain hrxml:Year</assert>
      <assert test="empty(hrxml:YearMonth)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance/hrxml:EndDate may not contain hrxml:YearMonth</assert>
      <assert test="empty(@dateDescription)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance/hrxml:EndDate may not contain @dateDescription</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance/hrxml:StartDate">
      <assert test="empty(hrxml:YearMonth)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance/hrxml:StartDate may not contain hrxml:YearMonth</assert>
      <assert test="empty(hrxml:MonthDay)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance/hrxml:StartDate may not contain hrxml:MonthDay</assert>
      <assert test="empty(@dateDescription)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance/hrxml:StartDate may not contain @dateDescription</assert>
      <assert test="empty(hrxml:StringDate)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance/hrxml:StartDate may not contain hrxml:StringDate</assert>
      <assert test="empty(hrxml:Year)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance/hrxml:StartDate may not contain hrxml:Year</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree">
      <assert test="empty(hrxml:Comments)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:Comments</assert>
      <assert test="empty(hrxml:OtherHonors)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:OtherHonors</assert>
      <assert test="empty(hrxml:DegreeMajor)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:DegreeMajor</assert>
      <assert test="empty(hrxml:DatesOfAttendance)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:DatesOfAttendance</assert>
      <assert test="empty(hrxml:DegreeMinor)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:DegreeMinor</assert>
      <assert test="empty(hrxml:DegreeMeasure)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:DegreeMeasure</assert>
      <assert test="empty(hrxml:DegreeClassification)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:DegreeClassification</assert>
      <assert test="empty(hrxml:UserArea)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:UserArea</assert>
      <assert test="empty(@examPassed)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain @examPassed</assert>
      <assert test="empty(@graduatingDegree)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain @graduatingDegree</assert>
      <assert test="empty(hrxml:DegreeDate)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree may not contain hrxml:DegreeDate</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree/hrxml:DegreeName">
      <assert test="empty(@honorsProgram)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree/hrxml:DegreeName may not contain @honorsProgram</assert>
      <assert test="empty(@academicHonors)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree/hrxml:DegreeName may not contain @academicHonors</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id">
      <assert test="empty(@validTo)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id may not contain @validTo</assert>
      <assert test="empty(@validFrom)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id may not contain @validFrom</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id/hrxml:IdValue">
      <assert test="empty(@name)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg">
      <assert test="empty(hrxml:UserArea)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg may not contain hrxml:UserArea</assert>
      <assert test="empty(@employerOrgType)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg may not contain @employerOrgType</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo">
      <assert test="empty(hrxml:LocationSummary)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo may not contain hrxml:LocationSummary</assert>
      <assert test="empty(hrxml:InternetDomainName)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo may not contain hrxml:InternetDomainName</assert>
      <assert test="empty(@contactType)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo may not contain @contactType</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod">
      <assert test="empty(hrxml:TTYTDD)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod may not contain hrxml:TTYTDD</assert>
      <assert test="empty(hrxml:WhenAvailable)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod may not contain hrxml:WhenAvailable</assert>
      <assert test="empty(hrxml:Location)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod may not contain hrxml:Location</assert>
      <assert test="empty(hrxml:PostalAddress)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod may not contain hrxml:PostalAddress</assert>
      <assert test="empty(hrxml:Use)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod may not contain hrxml:Use</assert>
      <assert test="empty(hrxml:Pager)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod may not contain hrxml:Pager</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod/hrxml:Fax">
      <assert test="empty(hrxml:InternationalCountryCode)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:InternationalCountryCode</assert>
      <assert test="empty(hrxml:NationalNumber)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:NationalNumber</assert>
      <assert test="empty(hrxml:SubscriberNumber)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:SubscriberNumber</assert>
      <assert test="empty(hrxml:Extension)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:Extension</assert>
      <assert test="empty(hrxml:AreaCityCode)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:AreaCityCode</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod/hrxml:Mobile">
      <assert test="empty(hrxml:Extension)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:Extension</assert>
      <assert test="empty(hrxml:InternationalCountryCode)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:InternationalCountryCode</assert>
      <assert test="empty(hrxml:AreaCityCode)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:AreaCityCode</assert>
      <assert test="empty(@smsEnabled)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain @smsEnabled</assert>
      <assert test="empty(hrxml:NationalNumber)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:NationalNumber</assert>
      <assert test="empty(hrxml:SubscriberNumber)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:SubscriberNumber</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod/hrxml:Telephone">
      <assert test="empty(hrxml:SubscriberNumber)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:SubscriberNumber</assert>
      <assert test="empty(hrxml:Extension)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:Extension</assert>
      <assert test="empty(hrxml:InternationalCountryCode)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:InternationalCountryCode</assert>
      <assert test="empty(hrxml:NationalNumber)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:NationalNumber</assert>
      <assert test="empty(hrxml:AreaCityCode)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:AreaCityCode</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:PersonName">
      <assert test="empty(@script)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:PersonName may not contain @script</assert>
      <assert test="empty(hrxml:MiddleName)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:PersonName may not contain hrxml:MiddleName</assert>
      <assert test="empty(hrxml:LegalName)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:PersonName may not contain hrxml:LegalName</assert>
      <assert test="empty(hrxml:FamilyName)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:PersonName may not contain hrxml:FamilyName</assert>
      <assert test="empty(hrxml:GivenName)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:PersonName may not contain hrxml:GivenName</assert>
      <assert test="empty(hrxml:AlternateScript)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:PersonName may not contain hrxml:AlternateScript</assert>
      <assert test="empty(hrxml:Affix)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:PersonName may not contain hrxml:Affix</assert>
      <assert test="empty(hrxml:PreferredGivenName)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo/hrxml:PersonName may not contain hrxml:PreferredGivenName</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory">
      <assert test="empty(hrxml:JobLevelInfo)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory may not contain hrxml:JobLevelInfo</assert>
      <assert test="empty(hrxml:OrgInfo)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory may not contain hrxml:OrgInfo</assert>
      <assert test="empty(hrxml:JobCategory)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory may not contain hrxml:JobCategory</assert>
      <assert test="empty(hrxml:Comments)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory may not contain hrxml:Comments</assert>
      <assert test="empty(hrxml:UserArea)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory may not contain hrxml:UserArea</assert>
      <assert test="empty(@positionType)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory may not contain @positionType</assert>
      <assert test="empty(hrxml:Title)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory may not contain hrxml:Title</assert>
      <assert test="empty(hrxml:OrgSize)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory may not contain hrxml:OrgSize</assert>
      <assert test="empty(hrxml:Verification)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory may not contain hrxml:Verification</assert>
      <assert test="empty(hrxml:Compensation)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory may not contain hrxml:Compensation</assert>
      <assert test="empty(hrxml:OrgIndustry)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory may not contain hrxml:OrgIndustry</assert>
      <assert test="empty(@currentEmployer)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory may not contain @currentEmployer</assert>
      <assert test="empty(hrxml:Competency)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory may not contain hrxml:Competency</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory/hrxml:EndDate">
      <assert test="empty(hrxml:Year)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory/hrxml:EndDate may not contain hrxml:Year</assert>
      <assert test="empty(hrxml:StringDate)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory/hrxml:EndDate may not contain hrxml:StringDate</assert>
      <assert test="empty(hrxml:MonthDay)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory/hrxml:EndDate may not contain hrxml:MonthDay</assert>
      <assert test="empty(hrxml:YearMonth)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory/hrxml:EndDate may not contain hrxml:YearMonth</assert>
      <assert test="empty(@dateDescription)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory/hrxml:EndDate may not contain @dateDescription</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory/hrxml:OrgName">
      <assert test="empty(hrxml:OrgName)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory/hrxml:OrgName may not contain hrxml:OrgName</assert>
      <assert test="empty(@organizationType)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory/hrxml:OrgName may not contain @organizationType</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory/hrxml:StartDate">
      <assert test="empty(@dateDescription)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory/hrxml:StartDate may not contain @dateDescription</assert>
      <assert test="empty(hrxml:StringDate)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory/hrxml:StartDate may not contain hrxml:StringDate</assert>
      <assert test="empty(hrxml:MonthDay)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory/hrxml:StartDate may not contain hrxml:MonthDay</assert>
      <assert test="empty(hrxml:YearMonth)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory/hrxml:StartDate may not contain hrxml:YearMonth</assert>
      <assert test="empty(hrxml:Year)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory/hrxml:StartDate may not contain hrxml:Year</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:EffectiveDate/hrxml:FirstIssuedDate">
      <assert test="empty(hrxml:MonthDay)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:EffectiveDate/hrxml:FirstIssuedDate may not contain hrxml:MonthDay</assert>
      <assert test="empty(hrxml:Year)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:EffectiveDate/hrxml:FirstIssuedDate may not contain hrxml:Year</assert>
      <assert test="empty(@dateDescription)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:EffectiveDate/hrxml:FirstIssuedDate may not contain @dateDescription</assert>
      <assert test="empty(hrxml:YearMonth)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:EffectiveDate/hrxml:FirstIssuedDate may not contain hrxml:YearMonth</assert>
      <assert test="empty(hrxml:StringDate)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:EffectiveDate/hrxml:FirstIssuedDate may not contain hrxml:StringDate</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:EffectiveDate/hrxml:ValidFrom">
      <assert test="empty(@dateDescription)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:EffectiveDate/hrxml:ValidFrom may not contain @dateDescription</assert>
      <assert test="empty(hrxml:YearMonth)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:EffectiveDate/hrxml:ValidFrom may not contain hrxml:YearMonth</assert>
      <assert test="empty(hrxml:Year)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:EffectiveDate/hrxml:ValidFrom may not contain hrxml:Year</assert>
      <assert test="empty(hrxml:MonthDay)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:EffectiveDate/hrxml:ValidFrom may not contain hrxml:MonthDay</assert>
      <assert test="empty(hrxml:StringDate)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:EffectiveDate/hrxml:ValidFrom may not contain hrxml:StringDate</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:EffectiveDate/hrxml:ValidTo">
      <assert test="empty(hrxml:YearMonth)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:EffectiveDate/hrxml:ValidTo may not contain hrxml:YearMonth</assert>
      <assert test="empty(hrxml:Year)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:EffectiveDate/hrxml:ValidTo may not contain hrxml:Year</assert>
      <assert test="empty(hrxml:StringDate)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:EffectiveDate/hrxml:ValidTo may not contain hrxml:StringDate</assert>
      <assert test="empty(hrxml:MonthDay)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:EffectiveDate/hrxml:ValidTo may not contain hrxml:MonthDay</assert>
      <assert test="empty(@dateDescription)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:EffectiveDate/hrxml:ValidTo may not contain @dateDescription</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:IssuingAuthority">
      <assert test="empty(@countryCode)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:LicensesAndCertifications/hrxml:LicenseOrCertification/hrxml:IssuingAuthority may not contain @countryCode</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:Qualifications">
      <assert test="empty(hrxml:QualificationSummary)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:Qualifications may not contain hrxml:QualificationSummary</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency">
      <assert test="empty(hrxml:CompetencyId)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency may not contain hrxml:CompetencyId</assert>
      <assert test="empty(@required)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency may not contain @required</assert>
      <assert test="empty(hrxml:UserArea)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency may not contain hrxml:UserArea</assert>
      <assert test="empty(hrxml:CompetencyWeight)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency may not contain hrxml:CompetencyWeight</assert>
      <assert test="empty(hrxml:Competency)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency may not contain hrxml:Competency</assert>
      <assert test="empty(hrxml:CompetencyEvidence)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency may not contain hrxml:CompetencyEvidence</assert>
      <assert test="empty(hrxml:TaxonomyId)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency may not contain hrxml:TaxonomyId</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:SupportingMaterials">
      <assert test="empty(hrxml:Link)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:SupportingMaterials may not contain hrxml:Link</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:SupportingMaterials/hrxml:AttachmentReference">
      <assert test="empty(@context)">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:SupportingMaterials/hrxml:AttachmentReference may not contain @context</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Rates">
      <assert test="empty(hrxml:BillingMultiplier)">hrxml:HumanResource/hrxml:Rates may not contain hrxml:BillingMultiplier</assert>
      <assert test="empty(@lang)">hrxml:HumanResource/hrxml:Rates may not contain @lang</assert>
      <assert test="empty(hrxml:TimeWorkedRounding)">hrxml:HumanResource/hrxml:Rates may not contain hrxml:TimeWorkedRounding</assert>
      <assert test="empty(hrxml:StaffingShiftId)">hrxml:HumanResource/hrxml:Rates may not contain hrxml:StaffingShiftId</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Rates/hrxml:CustomerRateClassification">
      <assert test="empty(@idOwner)">hrxml:HumanResource/hrxml:Rates/hrxml:CustomerRateClassification may not contain @idOwner</assert>
      <assert test="empty(@validTo)">hrxml:HumanResource/hrxml:Rates/hrxml:CustomerRateClassification may not contain @validTo</assert>
      <assert test="empty(@validFrom)">hrxml:HumanResource/hrxml:Rates/hrxml:CustomerRateClassification may not contain @validFrom</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Rates/hrxml:ExternalRateSetId">
      <assert test="empty(@validFrom)">hrxml:HumanResource/hrxml:Rates/hrxml:ExternalRateSetId may not contain @validFrom</assert>
      <assert test="empty(@idOwner)">hrxml:HumanResource/hrxml:Rates/hrxml:ExternalRateSetId may not contain @idOwner</assert>
      <assert test="empty(@validTo)">hrxml:HumanResource/hrxml:Rates/hrxml:ExternalRateSetId may not contain @validTo</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Rates/hrxml:ExternalRateSetId/hrxml:IdValue">
      <assert test="empty(@name)">hrxml:HumanResource/hrxml:Rates/hrxml:ExternalRateSetId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Rates/hrxml:Multiplier">
      <assert test="empty(@percentIndicator)">hrxml:HumanResource/hrxml:Rates/hrxml:Multiplier may not contain @percentIndicator</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Rates/hrxml:RatesId">
      <assert test="empty(@idOwner)">hrxml:HumanResource/hrxml:Rates/hrxml:RatesId may not contain @idOwner</assert>
      <assert test="empty(@validFrom)">hrxml:HumanResource/hrxml:Rates/hrxml:RatesId may not contain @validFrom</assert>
      <assert test="empty(@validTo)">hrxml:HumanResource/hrxml:Rates/hrxml:RatesId may not contain @validTo</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Rates/hrxml:RatesId/hrxml:IdValue">
      <assert test="empty(@name)">hrxml:HumanResource/hrxml:Rates/hrxml:RatesId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ReferenceInformation">
      <assert test="empty(hrxml:StaffingOrganizationId)">hrxml:HumanResource/hrxml:ReferenceInformation may not contain hrxml:StaffingOrganizationId</assert>
      <assert test="empty(hrxml:UserArea)">hrxml:HumanResource/hrxml:ReferenceInformation may not contain hrxml:UserArea</assert>
      <assert test="empty(hrxml:AssignmentId)">hrxml:HumanResource/hrxml:ReferenceInformation may not contain hrxml:AssignmentId</assert>
      <assert test="empty(hrxml:PositionId)">hrxml:HumanResource/hrxml:ReferenceInformation may not contain hrxml:PositionId</assert>
      <assert test="empty(hrxml:TimeCardId)">hrxml:HumanResource/hrxml:ReferenceInformation may not contain hrxml:TimeCardId</assert>
      <assert test="empty(hrxml:IntermediaryId)">hrxml:HumanResource/hrxml:ReferenceInformation may not contain hrxml:IntermediaryId</assert>
      <assert test="empty(hrxml:InvoiceId)">hrxml:HumanResource/hrxml:ReferenceInformation may not contain hrxml:InvoiceId</assert>
      <assert test="empty(hrxml:MasterOrderId)">hrxml:HumanResource/hrxml:ReferenceInformation may not contain hrxml:MasterOrderId</assert>
      <assert test="empty(hrxml:BillToEntityId)">hrxml:HumanResource/hrxml:ReferenceInformation may not contain hrxml:BillToEntityId</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:OrderId">
      <assert test="empty(@validFrom)">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:OrderId may not contain @validFrom</assert>
      <assert test="empty(@validTo)">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:OrderId may not contain @validTo</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:OrderId/hrxml:IdValue">
      <assert test="empty(@name)">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:OrderId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerId">
      <assert test="empty(@validFrom)">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may not contain @validFrom</assert>
      <assert test="empty(@validTo)">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may not contain @validTo</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/hrxml:IdValue">
      <assert test="empty(@name)">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId">
      <assert test="empty(@validFrom)">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may not contain @validFrom</assert>
      <assert test="empty(@validTo)">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may not contain @validTo</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/hrxml:IdValue">
      <assert test="empty(@name)">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierId">
      <assert test="empty(@validFrom)">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may not contain @validFrom</assert>
      <assert test="empty(@validTo)">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may not contain @validTo</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/hrxml:IdValue">
      <assert test="empty(@name)">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId">
      <assert test="empty(@validFrom)">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may not contain @validFrom</assert>
      <assert test="empty(@validTo)">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may not contain @validTo</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/hrxml:IdValue">
      <assert test="empty(@name)">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ResourceInformation">
      <assert test="empty(hrxml:ResourceType)">hrxml:HumanResource/hrxml:ResourceInformation may not contain hrxml:ResourceType</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo">
      <assert test="empty(hrxml:PersonName)">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo may not contain hrxml:PersonName</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod">
      <assert test="empty(hrxml:Pager)">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod may not contain hrxml:Pager</assert>
      <assert test="empty(hrxml:Location)">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod may not contain hrxml:Location</assert>
      <assert test="empty(hrxml:WhenAvailable)">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod may not contain hrxml:WhenAvailable</assert>
      <assert test="empty(hrxml:TTYTDD)">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod may not contain hrxml:TTYTDD</assert>
      <assert test="empty(hrxml:PostalAddress)">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod may not contain hrxml:PostalAddress</assert>
      <assert test="empty(hrxml:Use)">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod may not contain hrxml:Use</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:Fax">
      <assert test="empty(hrxml:SubscriberNumber)">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:SubscriberNumber</assert>
      <assert test="empty(hrxml:NationalNumber)">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:NationalNumber</assert>
      <assert test="empty(hrxml:AreaCityCode)">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:AreaCityCode</assert>
      <assert test="empty(hrxml:InternationalCountryCode)">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:InternationalCountryCode</assert>
      <assert test="empty(hrxml:Extension)">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:Extension</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:Mobile">
      <assert test="empty(@smsEnabled)">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain @smsEnabled</assert>
      <assert test="empty(hrxml:Extension)">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:Extension</assert>
      <assert test="empty(hrxml:AreaCityCode)">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:AreaCityCode</assert>
      <assert test="empty(hrxml:SubscriberNumber)">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:SubscriberNumber</assert>
      <assert test="empty(hrxml:NationalNumber)">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:NationalNumber</assert>
      <assert test="empty(hrxml:InternationalCountryCode)">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:InternationalCountryCode</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:Telephone">
      <assert test="empty(hrxml:NationalNumber)">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:NationalNumber</assert>
      <assert test="empty(hrxml:SubscriberNumber)">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:SubscriberNumber</assert>
      <assert test="empty(hrxml:Extension)">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:Extension</assert>
      <assert test="empty(hrxml:InternationalCountryCode)">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:InternationalCountryCode</assert>
      <assert test="empty(hrxml:AreaCityCode)">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:AreaCityCode</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ResourceInformation/hrxml:PersonName">
      <assert test="empty(@script)">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:PersonName may not contain @script</assert>
      <assert test="empty(hrxml:AlternateScript)">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:PersonName may not contain hrxml:AlternateScript</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ResourceInformation/hrxml:PostalAddress">
      <assert test="empty(hrxml:Region)">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:PostalAddress may not contain hrxml:Region</assert>
      <assert test="empty(@type)">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:PostalAddress may not contain @type</assert>
      <assert test="empty(hrxml:Recipient)">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:PostalAddress may not contain hrxml:Recipient</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ResourceInformation/hrxml:PostalAddress/hrxml:DeliveryAddress">
      <assert test="empty(hrxml:AddressLine)">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:PostalAddress/hrxml:DeliveryAddress may not contain hrxml:AddressLine</assert>
      <assert test="empty(hrxml:PostOfficeBox)">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:PostalAddress/hrxml:DeliveryAddress may not contain hrxml:PostOfficeBox</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements">
      <assert test="empty(hrxml:ExternalOrderNumber)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements may not contain hrxml:ExternalOrderNumber</assert>
      <assert test="empty(hrxml:CostCenterName)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements may not contain hrxml:CostCenterName</assert>
      <assert test="empty(hrxml:LocationName)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements may not contain hrxml:LocationName</assert>
      <assert test="empty(hrxml:CostCenterCode)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements may not contain hrxml:CostCenterCode</assert>
      <assert test="empty(hrxml:ProjectCode)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements may not contain hrxml:ProjectCode</assert>
      <assert test="empty(hrxml:AccountCode)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements may not contain hrxml:AccountCode</assert>
      <assert test="empty(hrxml:Entity)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements may not contain hrxml:Entity</assert>
      <assert test="empty(hrxml:LocationCode)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements may not contain hrxml:LocationCode</assert>
      <assert test="empty(hrxml:DepartmentCode)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements may not contain hrxml:DepartmentCode</assert>
      <assert test="empty(hrxml:ExternalReqNumber)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements may not contain hrxml:ExternalReqNumber</assert>
      <assert test="empty(hrxml:PurchaseOrderLineItem)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements may not contain hrxml:PurchaseOrderLineItem</assert>
      <assert test="empty(hrxml:CustomerJobCode)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements may not contain hrxml:CustomerJobCode</assert>
      <assert test="empty(hrxml:SupervisorName)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements may not contain hrxml:SupervisorName</assert>
      <assert test="empty(hrxml:SubEntity)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements may not contain hrxml:SubEntity</assert>
      <assert test="empty(hrxml:DepartmentName)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements may not contain hrxml:DepartmentName</assert>
      <assert test="empty(hrxml:ContactName)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements may not contain hrxml:ContactName</assert>
      <assert test="empty(hrxml:ManagerName)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements may not contain hrxml:ManagerName</assert>
      <assert test="empty(hrxml:CustomerReferenceNumber)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements may not contain hrxml:CustomerReferenceNumber</assert>
      <assert test="empty(hrxml:Shift)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements may not contain hrxml:Shift</assert>
      <assert test="empty(hrxml:CustomerJobDescription)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements may not contain hrxml:CustomerJobDescription</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:OfferId">
      <assert test="empty(@validTo)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:OfferId may not contain @validTo</assert>
      <assert test="empty(@validFrom)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:OfferId may not contain @validFrom</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:OfferId/hrxml:IdValue">
      <assert test="empty(@name)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:OfferId/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift">
      <assert test="empty(hrxml:TypeHours)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift may not contain hrxml:TypeHours</assert>
      <assert test="empty(hrxml:StartTime)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift may not contain hrxml:StartTime</assert>
      <assert test="empty(hrxml:ExternalStaffingShiftSetId)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift may not contain hrxml:ExternalStaffingShiftSetId</assert>
      <assert test="empty(hrxml:Name)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift may not contain hrxml:Name</assert>
      <assert test="empty(hrxml:EndTime)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift may not contain hrxml:EndTime</assert>
      <assert test="empty(@lang)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift may not contain @lang</assert>
      <assert test="empty(hrxml:Comment)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift may not contain hrxml:Comment</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift/hrxml:Id">
      <assert test="empty(@idOwner)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift/hrxml:Id may not contain @idOwner</assert>
      <assert test="empty(@validFrom)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift/hrxml:Id may not contain @validFrom</assert>
      <assert test="empty(@validTo)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift/hrxml:Id may not contain @validTo</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift/hrxml:Id/hrxml:IdValue">
      <assert test="empty(@name)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift/hrxml:Id/hrxml:IdValue may not contain @name</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo">
      <assert test="empty(hrxml:PersonName)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo may not contain hrxml:PersonName</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod">
      <assert test="empty(hrxml:Location)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod may not contain hrxml:Location</assert>
      <assert test="empty(hrxml:WhenAvailable)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod may not contain hrxml:WhenAvailable</assert>
      <assert test="empty(hrxml:Use)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod may not contain hrxml:Use</assert>
      <assert test="empty(hrxml:PostalAddress)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod may not contain hrxml:PostalAddress</assert>
      <assert test="empty(hrxml:TTYTDD)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod may not contain hrxml:TTYTDD</assert>
      <assert test="empty(hrxml:Pager)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod may not contain hrxml:Pager</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:Fax">
      <assert test="empty(hrxml:SubscriberNumber)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:SubscriberNumber</assert>
      <assert test="empty(hrxml:InternationalCountryCode)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:InternationalCountryCode</assert>
      <assert test="empty(hrxml:Extension)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:Extension</assert>
      <assert test="empty(hrxml:NationalNumber)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:NationalNumber</assert>
      <assert test="empty(hrxml:AreaCityCode)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:Fax may not contain hrxml:AreaCityCode</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:Mobile">
      <assert test="empty(@smsEnabled)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain @smsEnabled</assert>
      <assert test="empty(hrxml:Extension)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:Extension</assert>
      <assert test="empty(hrxml:SubscriberNumber)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:SubscriberNumber</assert>
      <assert test="empty(hrxml:AreaCityCode)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:AreaCityCode</assert>
      <assert test="empty(hrxml:InternationalCountryCode)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:InternationalCountryCode</assert>
      <assert test="empty(hrxml:NationalNumber)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:Mobile may not contain hrxml:NationalNumber</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:Telephone">
      <assert test="empty(hrxml:Extension)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:Extension</assert>
      <assert test="empty(hrxml:InternationalCountryCode)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:InternationalCountryCode</assert>
      <assert test="empty(hrxml:AreaCityCode)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:AreaCityCode</assert>
      <assert test="empty(hrxml:NationalNumber)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:NationalNumber</assert>
      <assert test="empty(hrxml:SubscriberNumber)">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:Telephone may not contain hrxml:SubscriberNumber</assert>
    </rule>
  </pattern>
  <pattern id="cardinality-redefines">
    <rule context="hrxml:HumanResource">
      <assert test="count(hrxml:UserArea) &gt;= 1">hrxml:HumanResource must contain hrxml:UserArea at least 1 time(s)</assert>
      <assert test="count(hrxml:HumanResourceId) &lt;= 2">hrxml:HumanResource may contain hrxml:HumanResourceId at most 2 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:HumanResourceId">
      <assert test="count(@idOwner) &gt;= 1">hrxml:HumanResource/hrxml:HumanResourceId must contain @idOwner at least 1 time(s)</assert>
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:HumanResource/hrxml:HumanResourceId may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution">
      <assert test="count(hrxml:LocalInstitutionClassification) &lt;= 1">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may contain hrxml:LocalInstitutionClassification at most 1 time(s)</assert>
      <assert test="count(hrxml:Degree) &lt;= 1">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution may contain hrxml:Degree at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance">
      <assert test="count(hrxml:StartDate) &lt;= 1">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance may contain hrxml:StartDate at most 1 time(s)</assert>
      <assert test="count(hrxml:EndDate) &lt;= 1">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance may contain hrxml:EndDate at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance/hrxml:StartDate">
      <assert test="count(hrxml:AnyDate) &gt;= 1">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:DatesOfAttendance/hrxml:StartDate must contain hrxml:AnyDate at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id">
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id may contain hrxml:IdValue at most 1 time(s)</assert>
      <assert test="count(@idOwner) &gt;= 1">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:LocalInstitutionClassification/hrxml:Id must contain @idOwner at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo">
      <assert test="count(hrxml:ContactMethod) &lt;= 1">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:EmployerContactInfo may contain hrxml:ContactMethod at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory/hrxml:StartDate">
      <assert test="count(hrxml:AnyDate) &gt;= 1">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory/hrxml:StartDate must contain hrxml:AnyDate at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency">
      <assert test="count(@name) &gt;= 1">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency must contain @name at least 1 time(s)</assert>
      <assert test="count(@description) &gt;= 1">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:Qualifications/hrxml:Competency must contain @description at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:SupportingMaterials">
      <assert test="count(hrxml:AttachmentReference) &gt;= 1">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:SupportingMaterials must contain hrxml:AttachmentReference at least 1 time(s)</assert>
      <assert test="count(hrxml:Description) &gt;= 1">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:SupportingMaterials must contain hrxml:Description at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:SupportingMaterials/hrxml:AttachmentReference">
      <assert test="count(@mimeType) &gt;= 1">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:SupportingMaterials/hrxml:AttachmentReference must contain @mimeType at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Rates">
      <assert test="count(hrxml:Multiplier) &lt;= 1">hrxml:HumanResource/hrxml:Rates may contain hrxml:Multiplier at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Rates/hrxml:CustomerRateClassification">
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:HumanResource/hrxml:Rates/hrxml:CustomerRateClassification may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Rates/hrxml:ExternalRateSetId">
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:HumanResource/hrxml:Rates/hrxml:ExternalRateSetId may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Rates/hrxml:RatesId">
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:HumanResource/hrxml:Rates/hrxml:RatesId may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ReferenceInformation">
      <assert test="count(hrxml:OrderId) &lt;= 1">hrxml:HumanResource/hrxml:ReferenceInformation may contain hrxml:OrderId at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:OrderId">
      <assert test="count(@idOwner) &gt;= 1">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:OrderId must contain @idOwner at least 1 time(s)</assert>
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:OrderId may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerId">
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerId may contain hrxml:IdValue at most 1 time(s)</assert>
      <assert test="count(@idOwner) &gt;= 1">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerId must contain @idOwner at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId">
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId may contain hrxml:IdValue at most 1 time(s)</assert>
      <assert test="count(@idOwner) &gt;= 1">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId must contain @idOwner at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierId">
      <assert test="count(@idOwner) &gt;= 1">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierId must contain @idOwner at least 1 time(s)</assert>
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierId may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId">
      <assert test="count(@idOwner) &gt;= 1">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId must contain @idOwner at least 1 time(s)</assert>
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo">
      <assert test="count(hrxml:ContactMethod) &lt;= 1">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo may contain hrxml:ContactMethod at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ResourceInformation/hrxml:PersonName">
      <assert test="count(hrxml:FamilyName) &lt;= 2">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:PersonName may contain hrxml:FamilyName at most 2 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:UserArea">
      <assert test="count(setu:HumanResourceAdditionalNL) &gt;= 1 and count(setu:HumanResourceAdditionalNL) &lt;= 1">hrxml:HumanResource/hrxml:UserArea must contain setu:HumanResourceAdditionalNL at least 1 and at most 1 time(s)</assert>
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
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:OfferId may contain hrxml:IdValue at most 1 time(s)</assert>
      <assert test="count(@idOwner) &gt;= 1">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:OfferId must contain @idOwner at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift">
      <assert test="count(@shiftPeriod) &gt;= 1">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift must contain @shiftPeriod at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo">
      <assert test="count(hrxml:ContactMethod) &lt;= 1">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo may contain hrxml:ContactMethod at most 1 time(s)</assert>
    </rule>
  </pattern>
  <pattern id="type-restrictions">
    <rule context="hrxml:HumanResource">
      <assert test="empty(hrxml:Preferences) or (hrxml:Preferences='')">hrxml:HumanResource/hrxml:Preferences must be Empty</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:HumanResourceId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')">hrxml:HumanResource/hrxml:HumanResourceId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:HumanResourceStatus">
      <assert test="empty(@status) or (@status='new') or (@status='accepted') or (@status='x:assigned') or (@status='revised') or (@status='withdrawn') or (@status='rejected')">hrxml:HumanResource/hrxml:HumanResourceStatus/@status must have one of the following values: [new, accepted, x:assigned, revised, withdrawn, rejected]</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree">
      <assert test="empty(@degreeType) or (@degreeType='1') or (@degreeType='2') or (@degreeType='3') or (@degreeType='4') or (@degreeType='5') or (@degreeType='6')">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EducationHistory/hrxml:SchoolOrInstitution/hrxml:Degree/@degreeType must have one of the following values: [1, 2, 3, 4, 5, 6]</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory/hrxml:OrgName">
      <assert test="empty(hrxml:OrganizationName) or (hrxml:OrganizationName='')">hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:EmploymentHistory/hrxml:EmployerOrg/hrxml:PositionHistory/hrxml:OrgName/hrxml:OrganizationName must be Empty</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Profile/hrxml:Resume/hrxml:StructuredXMLResume/hrxml:SupportingMaterials">
      <assert test="(count(hrxml:AttachmentReference) = 0 and count(hrxml:Description) = 0) or (count(hrxml:AttachmentReference) = 1 and count(hrxml:AttachmentReference/@mimeType) = 1 and count(hrxml:Description) = 1 and string-length(hrxml:AttachmentReference) &gt; 0 and string-length(hrxml:AttachmentReference/@mimeType) &gt; 0 and string-length(hrxml:Description) &gt; 0)">AttachmentReference, mimeType and Description MUST all be present or none at all</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Rates">
      <assert test="count(/hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:InclusiveRate) = 1">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:InclusiveRate is mandatory if Rates are included</assert>
      <assert test="empty(@rateType) or (@rateType='pay') or (@rateType='bill')">hrxml:HumanResource/hrxml:Rates/@rateType must have one of the following values: [pay, bill]</assert>
      <assert test="(empty(hrxml:Class) or (hrxml:Class='TimeInterval') or (hrxml:Class='Allowance') or (hrxml:Class='Expense')) or (empty(hrxml:Class) or (hrxml:Class=''))">hrxml:HumanResource/hrxml:Rates/hrxml:Class must have one of the following values: [TimeInterval, Allowance, Expense] OR hrxml:HumanResource/hrxml:Rates/hrxml:Class must be Empty</assert>
      <assert test="empty(@rateStatus) or (@rateStatus='proposed') or (@rateStatus='agreed')">hrxml:HumanResource/hrxml:Rates/@rateStatus must have one of the following values: [proposed, agreed]</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:Rates/hrxml:Amount">
      <assert test="empty(@rateAmountPeriod) or (@rateAmountPeriod='hourly') or (@rateAmountPeriod='x:hourlysplit') or (@rateAmountPeriod='x:hourlyconsolidated') or (@rateAmountPeriod='daily') or (@rateAmountPeriod='weekly') or (@rateAmountPeriod='x:4weekly') or (@rateAmountPeriod='monthly') or (@rateAmountPeriod='yearly') or (@rateAmountPeriod='flatfee')">hrxml:HumanResource/hrxml:Rates/hrxml:Amount/@rateAmountPeriod must have one of the following values: [hourly, x:hourlysplit, x:hourlyconsolidated, daily, weekly, x:4weekly, monthly, yearly, flatfee]</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ReferenceInformation">
      <assert test="count(hrxml:StaffingSupplierId/@idOwner) = count(distinct-values(hrxml:StaffingSupplierId/@idOwner))">The same idOwner may not be given for StaffingSupplierId</assert>
      <assert test="if (count(hrxml:StaffingCustomerOrgUnitId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingCustomerOrgUnitId[@idOwner = 'KvK']) = 1) else ('true')">If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.</assert>
      <assert test="if (count(hrxml:StaffingCustomerId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingCustomerId[@idOwner = 'KvK']) = 1) else ('true')">If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.</assert>
      <assert test="if (count(hrxml:StaffingSupplierId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingSupplierId[@idOwner = 'KvK']) = 1) else ('true')">If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.</assert>
      <assert test="count(hrxml:StaffingCustomerOrgUnitId/@idOwner) = count(distinct-values(hrxml:StaffingCustomerOrgUnitId/@idOwner))">The same idOwner may not be given for StaffingCustomerOrgUnitId</assert>
      <assert test="count(hrxml:StaffingCustomerId/@idOwner) = count(distinct-values(hrxml:StaffingCustomerId/@idOwner))">The same idOwner may not be given for StaffingCustomerId</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:OrderId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany')">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:OrderId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany]</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerId">
      <assert test="string-length() > 0">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerId must be filled</assert>
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, OIN, KvK, BTW, Fi, Vest]</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, OIN, KvK, BTW, Fi, Vest]</assert>
      <assert test="string-length() > 0">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingCustomerOrgUnitId must be filled</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierId">
      <assert test="string-length() > 0">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierId must be filled</assert>
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, OIN, KvK, BTW, Fi, Vest]</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='StaffingCompany') or (@idOwner='KvK') or (@idOwner='OIN') or (@idOwner='BTW') or (@idOwner='Fi')">hrxml:HumanResource/hrxml:ReferenceInformation/hrxml:StaffingSupplierOrgUnitId/@idOwner must have one of the following values: [StaffingCustomer, StaffingCompany, KvK, OIN, BTW, Fi]</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:PostalAddress">
      <assert test="matches(hrxml:CountryCode, '^[A-Z][A-Z]$')">hrxml:HumanResource/hrxml:ResourceInformation/hrxml:EntityContactInfo/hrxml:ContactMethod/hrxml:PostalAddress/hrxml:CountryCode must match regular expression: ^[A-Z][A-Z]$</assert>
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
      <assert test="empty(setu:Sex) or (setu:Sex='male') or (setu:Sex='female') or (setu:Sex='unknown')">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:Sex must have one of the following values: [male, female, unknown]</assert>
      <assert test="(count(setu:OfferId) = 1) or (../../hrxml:HumanResourceStatus/@status = 'x:Confirmed' or ../../hrxml:HumanResourceStatus/@status = 'x:confirmed' or ../../hrxml:HumanResourceStatus/@status = 'x:Assigned' or ../../hrxml:HumanResourceStatus/@status = 'x:assigned')">OfferId is required when status is not x:Confirmed, x:confirmed, xAssigned or x:assigned</assert>
      <assert test="empty(setu:SETUVersionId) or (setu:SETUVersionId='1.2')">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SETUVersionId must have one of the following values: [1.2]</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements">
      <assert test="count(hrxml:AdditionalRequirement[@requirementTitle = 'VersionId']) = 1">There MUST be one CustomerReportingRequirements/AdditionalRequirement with @requirementTitle equal to VersionId</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:OfferId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCompany')">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:OfferId/@idOwner must have one of the following values: [StaffingCompany]</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift">
      <assert test="empty(@shiftPeriod) or (@shiftPeriod='weekly')">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift/@shiftPeriod must have one of the following values: [weekly]</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift/hrxml:Id">
      <assert test="empty(hrxml:IdValue) or (hrxml:IdValue='')">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:StaffingShift/hrxml:Id/hrxml:IdValue must be Empty</assert>
    </rule>
    <rule context="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:PostalAddress">
      <assert test="matches(hrxml:CountryCode, '^[A-Z][A-Z]$')">hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:SupplierContactInfo/hrxml:ContactMethod/hrxml:PostalAddress/hrxml:CountryCode must match regular expression: ^[A-Z][A-Z]$</assert>
    </rule>
  </pattern>
  <pattern id="type-restrictions-1">
    <rule context="hrxml:HumanResource/hrxml:Rates[hrxml:Class = 'TimeInterval']">
      <assert test="count(hrxml:Multiplier) = 1">hrxml:HumanResource/hrxml:Rates/hrxml:Multiplier is mandatory if hrxml:Class is TimeInterval</assert>
    </rule>
  </pattern>
  <pattern id="type-restrictions-2">
    <rule context="hrxml:HumanResource/hrxml:UserArea/setu:HumanResourceAdditionalNL/setu:CustomerReportingRequirements/hrxml:AdditionalRequirement[@requirementTitle = 'VersionId']">
      <assert test="text() = '2.0'">CustomerReportingRequirements/AdditionalRequirement must have value: 2.0 when requirementTitle is 'VersionId'.</assert>
    </rule>
  </pattern>
</schema>
