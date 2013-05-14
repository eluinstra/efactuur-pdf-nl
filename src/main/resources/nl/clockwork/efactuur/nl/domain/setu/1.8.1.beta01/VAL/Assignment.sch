<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <title>Validations for Assignment Mapping; strict=false</title>
  <ns prefix="hrxml" uri="http://ns.hr-xml.org/2007-04-15" />
  <ns prefix="setu" uri="http://ns.setu.nl/2008-01" />
  <pattern id="cardinality-redefines">
    <rule context="hrxml:Assignment">
      <assert test="count(hrxml:AssignmentId) &lt;= 1">hrxml:Assignment may contain hrxml:AssignmentId at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:Assignment/hrxml:AssignmentDateRange">
      <assert test="count(hrxml:ProbationaryPeriod) &lt;= 1">hrxml:Assignment/hrxml:AssignmentDateRange may contain hrxml:ProbationaryPeriod at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:Assignment/hrxml:AssignmentDateRange/hrxml:ProbationaryPeriod">
      <assert test="count(@unitOfMeasure) &gt;= 1">hrxml:Assignment/hrxml:AssignmentDateRange/hrxml:ProbationaryPeriod must contain @unitOfMeasure at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:Assignment/hrxml:AssignmentId">
      <assert test="count(hrxml:IdValue) &lt;= 2">hrxml:Assignment/hrxml:AssignmentId may contain hrxml:IdValue at most 2 time(s)</assert>
    </rule>
    <rule context="hrxml:Assignment/hrxml:ContractInformation/hrxml:ContractId">
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:Assignment/hrxml:ContractInformation/hrxml:ContractId may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:Assignment/hrxml:CustomerReportingRequirements">
      <assert test="count(hrxml:AdditionalRequirement) &gt;= 1">hrxml:Assignment/hrxml:CustomerReportingRequirements must contain hrxml:AdditionalRequirement at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:Assignment/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement">
      <assert test="count(@requirementTitle) &gt;= 1">hrxml:Assignment/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement must contain @requirementTitle at least 1 time(s)</assert>
    </rule>
    <rule context="hrxml:Assignment/hrxml:Rates">
      <assert test="count(hrxml:Multiplier) &lt;= 1">hrxml:Assignment/hrxml:Rates may contain hrxml:Multiplier at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:Assignment/hrxml:ReferenceInformation">
      <assert test="count(hrxml:HumanResourceId) &lt;= 1">hrxml:Assignment/hrxml:ReferenceInformation may contain hrxml:HumanResourceId at most 1 time(s)</assert>
      <assert test="count(hrxml:MasterOrderId) &lt;= 1">hrxml:Assignment/hrxml:ReferenceInformation may contain hrxml:MasterOrderId at most 1 time(s)</assert>
      <assert test="count(hrxml:OrderId) &lt;= 1">hrxml:Assignment/hrxml:ReferenceInformation may contain hrxml:OrderId at most 1 time(s)</assert>
      <assert test="count(hrxml:StaffingCustomerId) &lt;= 3">hrxml:Assignment/hrxml:ReferenceInformation may contain hrxml:StaffingCustomerId at most 3 time(s)</assert>
      <assert test="count(hrxml:StaffingSupplierId) &lt;= 3">hrxml:Assignment/hrxml:ReferenceInformation may contain hrxml:StaffingSupplierId at most 3 time(s)</assert>
    </rule>
    <rule context="hrxml:Assignment/hrxml:ReferenceInformation/hrxml:MasterOrderId">
      <assert test="count(hrxml:IdValue) &lt;= 1">hrxml:Assignment/hrxml:ReferenceInformation/hrxml:MasterOrderId may contain hrxml:IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:Assignment/hrxml:ReferenceInformation/hrxml:OrderId">
      <assert test="count(hrxml:IdValue) &lt;= 2">hrxml:Assignment/hrxml:ReferenceInformation/hrxml:OrderId may contain hrxml:IdValue at most 2 time(s)</assert>
    </rule>
    <rule context="hrxml:Assignment/hrxml:UserArea">
      <assert test="count(setu:AssignmentAdditionalNL) &lt;= 1">hrxml:Assignment/hrxml:UserArea may contain setu:AssignmentAdditionalNL at most 1 time(s)</assert>
    </rule>
    <rule context="hrxml:Assignment/hrxml:UserArea/setu:AssignmentAdditionalNL/setu:ProcurementOrderId">
      <assert test="count(hrxml:IdValue) &lt;= 2">hrxml:Assignment/hrxml:UserArea/setu:AssignmentAdditionalNL/setu:ProcurementOrderId may contain hrxml:IdValue at most 2 time(s)</assert>
    </rule>
  </pattern>
  <pattern id="type-restrictions">
    <rule context="hrxml:Assignment/hrxml:AssignmentId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany')">hrxml:Assignment/hrxml:AssignmentId/@idOwner must have one of the following values: [StaffingCompany, staffingCompany]</assert>
    </rule>
    <rule context="hrxml:Assignment/hrxml:AssignmentId/hrxml:IdValue[2]">
      <assert test="empty(@name) or (@name='Version') or (@name='version')">hrxml:Assignment/hrxml:AssignmentId/hrxml:IdValue/@name must have one of the following values: [Version, version]</assert>
    </rule>
    <rule context="hrxml:Assignment/hrxml:ContractInformation">
      <assert test="empty(hrxml:ContractId) or (hrxml:ContractId='')">hrxml:Assignment/hrxml:ContractInformation/hrxml:ContractId must be Empty</assert>
      <assert test="empty(hrxml:ContractVersion) or (hrxml:ContractVersion='')">hrxml:Assignment/hrxml:ContractInformation/hrxml:ContractVersion must be Empty</assert>
      <assert test="empty(hrxml:ContractVersionDate) or (hrxml:ContractVersionDate='')">hrxml:Assignment/hrxml:ContractInformation/hrxml:ContractVersionDate must be Empty</assert>
      <assert test="empty(hrxml:LegalInformation) or (hrxml:LegalInformation='')">hrxml:Assignment/hrxml:ContractInformation/hrxml:LegalInformation must be Empty</assert>
      <assert test="empty(hrxml:StaffType) or (hrxml:StaffType='')">hrxml:Assignment/hrxml:ContractInformation/hrxml:StaffType must be Empty</assert>
    </rule>
    <rule context="hrxml:Assignment/hrxml:ContractInformation/hrxml:ContractId">
      <assert test="empty(hrxml:IdValue) or (hrxml:IdValue='')">hrxml:Assignment/hrxml:ContractInformation/hrxml:ContractId/hrxml:IdValue must be Empty</assert>
    </rule>
    <rule context="hrxml:Assignment/hrxml:CustomerReportingRequirements">
      <assert test="count(hrxml:AdditionalRequirement[@requirementTitle = 'VersionId']) = 1">There MUST be one CustomerReportingRequirements/AdditionalRequirement with @requirementTitle equal to VersionId</assert>
    </rule>
    <rule context="hrxml:Assignment/hrxml:CustomerReportingRequirements/hrxml:AdditionalRequirement[@requirementTitle = 'VersionId']">
      <assert test="text() = '1.8'">CustomerReportingRequirements/AdditionalRequirement must have value: 1.8 when requirementTitle is 'VersionId'.</assert>
    </rule>
    <rule context="hrxml:Assignment/hrxml:Rates">
      <assert test="empty(@rateStatus) or (@rateStatus='Agreed') or (@rateStatus='agreed')">hrxml:Assignment/hrxml:Rates/@rateStatus must have one of the following values: [Agreed, agreed]</assert>
      <assert test="empty(hrxml:Class) or (hrxml:Class='TimeInterval') or (hrxml:Class='Allowance') or (hrxml:Class='Expense') or (hrxml:Class='timeInterval') or (hrxml:Class='allowance') or (hrxml:Class='expense')">hrxml:Assignment/hrxml:Rates/hrxml:Class must have one of the following values: [TimeInterval, Allowance, Expense, timeInterval, allowance, expense]</assert>
      <assert test="empty(hrxml:Description) or (hrxml:Description='Kostenvergoeding') or (hrxml:Description='Vervoerskosten') or (hrxml:Description='Reiskosten') or (hrxml:Description='Kilometervergoeding') or (hrxml:Description='Benzinekosten') or (hrxml:Description='Korting') or (hrxml:Description='Reisuren') or (hrxml:Description='Verblijfskosten') or (hrxml:Description='Maaltijd') or (hrxml:Description='Koffiegeld') or (hrxml:Description='Toeslag') or (hrxml:Description='Toeslag werkomstandigheden') or (hrxml:Description='Toeslag loon') or (hrxml:Description='Toeslag competentie') or (hrxml:Description='Ploegentoeslag') or (hrxml:Description='Opleidingskosten') or (hrxml:Description='Gereedschap') or (hrxml:Description='Kleding') or (hrxml:Description='Communicatiekosten') or (hrxml:Description='Vergoeding') or (hrxml:Description='Uurvergoeding') or (hrxml:Description='Dagvergoeding') or (hrxml:Description='Bijdrage ziektekosten') or (hrxml:Description='Verzekering') or (hrxml:Description='Premie') or (hrxml:Description='Bonus') or (hrxml:Description='Provisie') or (hrxml:Description='Stukloon') or (hrxml:Description='Overige') or (hrxml:Description='Budget') or (hrxml:Description='Incidentele uitkering/ vergoeding') or (hrxml:Description='Inhouding') or (hrxml:Description='Loopbaan') or (hrxml:Description='Loon') or (hrxml:Description='Reservering') or (hrxml:Description='Spaarloon') or (hrxml:Description='Werving en selectie') or (hrxml:Description='Declaratie') or (hrxml:Description='Compensatie/correctie') or (hrxml:Description='Advies/Bemiddeling') or (hrxml:Description='Afschrijving') or (hrxml:Description='Normale/standaard uren') or (hrxml:Description='Overuren') or (hrxml:Description='Ploegentoeslag') or (hrxml:Description='Reisuren') or (hrxml:Description='Onregelmatigheidstoeslag') or (hrxml:Description='Buitengewoon verlof') or (hrxml:Description='Kort verzuim') or (hrxml:Description='Feestdag') or (hrxml:Description='Onbetaald verlof') or (hrxml:Description='Training / scholing') or (hrxml:Description='Verlof') or (hrxml:Description='ADV') or (hrxml:Description='Zieke / ongeval') or (hrxml:Description='Leegloop') or (hrxml:Description='Zorgverlof') or (hrxml:Description='kostenvergoeding') or (hrxml:Description='vervoerskosten') or (hrxml:Description='reiskosten') or (hrxml:Description='kilometervergoeding') or (hrxml:Description='benzinekosten') or (hrxml:Description='korting') or (hrxml:Description='reisuren') or (hrxml:Description='verblijfskosten') or (hrxml:Description='maaltijd') or (hrxml:Description='koffiegeld') or (hrxml:Description='toeslag') or (hrxml:Description='toeslag werkomstandigheden') or (hrxml:Description='toeslag loon') or (hrxml:Description='toeslag competentie') or (hrxml:Description='ploegentoeslag') or (hrxml:Description='opleidingskosten') or (hrxml:Description='gereedschap') or (hrxml:Description='kleding') or (hrxml:Description='communicatiekosten') or (hrxml:Description='vergoeding') or (hrxml:Description='uurvergoeding') or (hrxml:Description='dagvergoeding') or (hrxml:Description='bijdrage ziektekosten') or (hrxml:Description='verzekering') or (hrxml:Description='premie') or (hrxml:Description='bonus') or (hrxml:Description='provisie') or (hrxml:Description='stukloon') or (hrxml:Description='overige') or (hrxml:Description='budget') or (hrxml:Description='incidentele uitkering/ vergoeding') or (hrxml:Description='inhouding') or (hrxml:Description='loopbaan') or (hrxml:Description='loon') or (hrxml:Description='reservering') or (hrxml:Description='spaarloon') or (hrxml:Description='werving en selectie') or (hrxml:Description='declaratie') or (hrxml:Description='compensatie/correctie') or (hrxml:Description='advies/bemiddeling') or (hrxml:Description='afschrijving') or (hrxml:Description='normale/standaard uren') or (hrxml:Description='overuren') or (hrxml:Description='ploegentoeslag') or (hrxml:Description='reisuren') or (hrxml:Description='onregelmatigheidstoeslag') or (hrxml:Description='buitengewoon verlof') or (hrxml:Description='kort verzuim') or (hrxml:Description='feestdag') or (hrxml:Description='onbetaald verlof') or (hrxml:Description='training / scholing') or (hrxml:Description='verlof') or (hrxml:Description='adv') or (hrxml:Description='zieke / ongeval') or (hrxml:Description='leegloop') or (hrxml:Description='zorgverlof')">hrxml:Assignment/hrxml:Rates/hrxml:Description must have one of the following values: [Kostenvergoeding, Vervoerskosten, Reiskosten, Kilometervergoeding, Benzinekosten, Korting, Reisuren, Verblijfskosten, Maaltijd, Koffiegeld, Toeslag, Toeslag werkomstandigheden, Toeslag loon, Toeslag competentie, Ploegentoeslag, Opleidingskosten, Gereedschap, Kleding, Communicatiekosten, Vergoeding, Uurvergoeding, Dagvergoeding, Bijdrage ziektekosten, Verzekering, Premie, Bonus, Provisie, Stukloon, Overige, Budget, Incidentele uitkering/ vergoeding, Inhouding, Loopbaan, Loon, Reservering, Spaarloon, Werving en selectie, Declaratie, Compensatie/correctie, Advies/Bemiddeling, Afschrijving, Normale/standaard uren, Overuren, Ploegentoeslag, Reisuren, Onregelmatigheidstoeslag, Buitengewoon verlof, Kort verzuim, Feestdag, Onbetaald verlof, Training / scholing, Verlof, ADV, Zieke / ongeval, Leegloop, Zorgverlof, kostenvergoeding, vervoerskosten, reiskosten, kilometervergoeding, benzinekosten, korting, reisuren, verblijfskosten, maaltijd, koffiegeld, toeslag, toeslag werkomstandigheden, toeslag loon, toeslag competentie, ploegentoeslag, opleidingskosten, gereedschap, kleding, communicatiekosten, vergoeding, uurvergoeding, dagvergoeding, bijdrage ziektekosten, verzekering, premie, bonus, provisie, stukloon, overige, budget, incidentele uitkering/ vergoeding, inhouding, loopbaan, loon, reservering, spaarloon, werving en selectie, declaratie, compensatie/correctie, advies/bemiddeling, afschrijving, normale/standaard uren, overuren, ploegentoeslag, reisuren, onregelmatigheidstoeslag, buitengewoon verlof, kort verzuim, feestdag, onbetaald verlof, training / scholing, verlof, adv, zieke / ongeval, leegloop, zorgverlof]</assert>
    </rule>
    <rule context="hrxml:Assignment/hrxml:Rates/hrxml:CustomerRateClassification">
      <assert test="empty(hrxml:IdValue) or (hrxml:IdValue='100B') or (hrxml:IdValue='100O') or (hrxml:IdValue='101B') or (hrxml:IdValue='101O') or (hrxml:IdValue='102B') or (hrxml:IdValue='102O') or (hrxml:IdValue='103B') or (hrxml:IdValue='103O') or (hrxml:IdValue='104O') or (hrxml:IdValue='105O') or (hrxml:IdValue='106B') or (hrxml:IdValue='201B') or (hrxml:IdValue='201O') or (hrxml:IdValue='202B') or (hrxml:IdValue='202O') or (hrxml:IdValue='203B') or (hrxml:IdValue='203O') or (hrxml:IdValue='300B') or (hrxml:IdValue='301B') or (hrxml:IdValue='302B') or (hrxml:IdValue='303B') or (hrxml:IdValue='304B') or (hrxml:IdValue='400O') or (hrxml:IdValue='501B') or (hrxml:IdValue='501O') or (hrxml:IdValue='502B') or (hrxml:IdValue='502O') or (hrxml:IdValue='503B') or (hrxml:IdValue='503O') or (hrxml:IdValue='600B') or (hrxml:IdValue='600O') or (hrxml:IdValue='601B') or (hrxml:IdValue='602B') or (hrxml:IdValue='602O') or (hrxml:IdValue='701B') or (hrxml:IdValue='702B') or (hrxml:IdValue='703B') or (hrxml:IdValue='801B') or (hrxml:IdValue='802B') or (hrxml:IdValue='803B') or (hrxml:IdValue='900B') or (hrxml:IdValue='900O') or (hrxml:IdValue='901O') or (hrxml:IdValue='903B') or (hrxml:IdValue='904B') or (hrxml:IdValue='904O') or (hrxml:IdValue='905B') or (hrxml:IdValue='905O') or (hrxml:IdValue='906B') or (hrxml:IdValue='907B') or (hrxml:IdValue='908B') or (hrxml:IdValue='909O') or (hrxml:IdValue='911B') or (hrxml:IdValue='911O') or (hrxml:IdValue='912B') or (hrxml:IdValue='913O') or (hrxml:IdValue='914O') or (hrxml:IdValue='Regular') or (hrxml:IdValue='Overtime') or (hrxml:IdValue='Shift') or (hrxml:IdValue='Travel') or (hrxml:IdValue='Additional') or (hrxml:IdValue='Special Leave') or (hrxml:IdValue='Short leave') or (hrxml:IdValue='Holiday') or (hrxml:IdValue='Unpaid leave') or (hrxml:IdValue='Training') or (hrxml:IdValue='Vacation') or (hrxml:IdValue='Reduction of working hours') or (hrxml:IdValue='Sick time') or (hrxml:IdValue='Work underload') or (hrxml:IdValue='Care Leave') or (hrxml:IdValue='regular') or (hrxml:IdValue='overtime') or (hrxml:IdValue='shift') or (hrxml:IdValue='travel') or (hrxml:IdValue='additional') or (hrxml:IdValue='special leave') or (hrxml:IdValue='short leave') or (hrxml:IdValue='holiday') or (hrxml:IdValue='unpaid leave') or (hrxml:IdValue='training') or (hrxml:IdValue='vacation') or (hrxml:IdValue='reduction of working hours') or (hrxml:IdValue='sick time') or (hrxml:IdValue='work underload') or (hrxml:IdValue='care leave')">hrxml:Assignment/hrxml:Rates/hrxml:CustomerRateClassification/hrxml:IdValue must have one of the following values: [100B, 100O, 101B, 101O, 102B, 102O, 103B, 103O, 104O, 105O, 106B, 201B, 201O, 202B, 202O, 203B, 203O, 300B, 301B, 302B, 303B, 304B, 400O, 501B, 501O, 502B, 502O, 503B, 503O, 600B, 600O, 601B, 602B, 602O, 701B, 702B, 703B, 801B, 802B, 803B, 900B, 900O, 901O, 903B, 904B, 904O, 905B, 905O, 906B, 907B, 908B, 909O, 911B, 911O, 912B, 913O, 914O, Regular, Overtime, Shift, Travel, Additional, Special Leave, Short leave, Holiday, Unpaid leave, Training, Vacation, Reduction of working hours, Sick time, Work underload, Care Leave, regular, overtime, shift, travel, additional, special leave, short leave, holiday, unpaid leave, training, vacation, reduction of working hours, sick time, work underload, care leave]</assert>
    </rule>
    <rule context="hrxml:Assignment/hrxml:ReferenceInformation">
      <assert test="if (count(hrxml:StaffingCustomerId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingCustomerId[@idOwner = 'KvK']) = 1) else ('true')">If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.</assert>
      <assert test="if (count(hrxml:StaffingSupplierId[@idOwner = 'Vest']) = 1) then (count(hrxml:StaffingSupplierId[@idOwner = 'KvK']) = 1) else ('true')">If code 'Vest' is an IdOwner, code 'KvK' MUST also be present.</assert>
      <assert test="empty(hrxml:PositionId) or (hrxml:PositionId='')">hrxml:Assignment/hrxml:ReferenceInformation/hrxml:PositionId must be Empty</assert>
    </rule>
    <rule context="hrxml:Assignment/hrxml:ReferenceInformation/hrxml:HumanResourceId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCompany') or (@idOwner='staffingCompany') or (@idOwner='BSN')">hrxml:Assignment/hrxml:ReferenceInformation/hrxml:HumanResourceId/@idOwner must have one of the following values: [StaffingCompany, staffingCompany, BSN]</assert>
    </rule>
    <rule context="hrxml:Assignment/hrxml:ReferenceInformation/hrxml:OrderId/hrxml:IdValue[2]">
      <assert test="empty(@name) or (@name='ReactToVersion') or (@name='reacttoversion')">hrxml:Assignment/hrxml:ReferenceInformation/hrxml:OrderId/hrxml:IdValue/@name must have one of the following values: [ReactToVersion, reacttoversion]</assert>
    </rule>
    <rule context="hrxml:Assignment/hrxml:ReferenceInformation/hrxml:PositionId">
      <assert test="empty(hrxml:IdValue) or (hrxml:IdValue='')">hrxml:Assignment/hrxml:ReferenceInformation/hrxml:PositionId/hrxml:IdValue must be Empty</assert>
    </rule>
    <rule context="hrxml:Assignment/hrxml:ReferenceInformation/hrxml:StaffingCustomerId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingSupplier') or (@idOwner='staffingSupplier') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">hrxml:Assignment/hrxml:ReferenceInformation/hrxml:StaffingCustomerId/@idOwner must have one of the following values: [StaffingCustomer, staffingCustomer, StaffingSupplier, staffingSupplier, OIN, KvK, BTW, Fi, Vest]</assert>
    </rule>
    <rule context="hrxml:Assignment/hrxml:ReferenceInformation/hrxml:StaffingSupplierId">
      <assert test="empty(@idOwner) or (@idOwner='StaffingCustomer') or (@idOwner='staffingCustomer') or (@idOwner='StaffingSupplier') or (@idOwner='staffingSupplier') or (@idOwner='OIN') or (@idOwner='KvK') or (@idOwner='BTW') or (@idOwner='Fi') or (@idOwner='Vest')">hrxml:Assignment/hrxml:ReferenceInformation/hrxml:StaffingSupplierId/@idOwner must have one of the following values: [StaffingCustomer, staffingCustomer, StaffingSupplier, staffingSupplier, OIN, KvK, BTW, Fi, Vest]</assert>
    </rule>
    <rule context="hrxml:Assignment/hrxml:StaffingShift">
      <assert test="empty(@shiftPeriod) or (@shiftPeriod='weekly') or (@shiftPeriod='monthly') or (@shiftPeriod='daily') or (@shiftPeriod='x:4weekly') or (@shiftPeriod='Weekly') or (@shiftPeriod='Monthly') or (@shiftPeriod='Daily') or (@shiftPeriod='x:4Weekly')">hrxml:Assignment/hrxml:StaffingShift/@shiftPeriod must have one of the following values: [weekly, monthly, daily, x:4weekly, Weekly, Monthly, Daily, x:4Weekly]</assert>
      <assert test="empty(hrxml:Id) or (hrxml:Id='')">hrxml:Assignment/hrxml:StaffingShift/hrxml:Id must be Empty</assert>
    </rule>
    <rule context="hrxml:Assignment/hrxml:StaffingShift/hrxml:Id">
      <assert test="empty(hrxml:IdValue) or (hrxml:IdValue='')">hrxml:Assignment/hrxml:StaffingShift/hrxml:Id/hrxml:IdValue must be Empty</assert>
    </rule>
    <rule context="hrxml:Assignment/hrxml:UserArea/setu:AssignmentAdditionalNL/setu:ProcurementOrderId/hrxml:IdValue[1]">
      <assert test="empty(@name) or (@name='')">hrxml:Assignment/hrxml:UserArea/setu:AssignmentAdditionalNL/setu:ProcurementOrderId/hrxml:IdValue/@name must be Empty</assert>
    </rule>
    <rule context="hrxml:Assignment/hrxml:UserArea/setu:AssignmentAdditionalNL/setu:ProcurementOrderId/hrxml:IdValue[2]">
      <assert test="empty(@name) or (@name='ReactToVersion') or (@name='reacttoversion')">hrxml:Assignment/hrxml:UserArea/setu:AssignmentAdditionalNL/setu:ProcurementOrderId/hrxml:IdValue/@name must have one of the following values: [ReactToVersion, reacttoversion]</assert>
    </rule>
    <rule context="hrxml:Assignment/hrxml:UserArea/setu:AssignmentAdditionalNL/setu:StaffingWorkSite/hrxml:PostalAddress">
      <assert test="matches(hrxml:CountryCode, '^[A-Z][A-Z]$')">hrxml:Assignment/hrxml:UserArea/setu:AssignmentAdditionalNL/setu:StaffingWorkSite/hrxml:PostalAddress/hrxml:CountryCode must match regular expression: ^[A-Z][A-Z]$</assert>
    </rule>
  </pattern>
</schema>
