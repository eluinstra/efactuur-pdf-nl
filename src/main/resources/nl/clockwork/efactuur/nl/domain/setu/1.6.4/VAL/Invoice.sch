<?xml version="1.0" encoding="utf-8" ?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <title>Validations for Invoice Mapping</title>
  <ns prefix="ns1" uri="http://www.openapplications.org/oagis" />
  <ns prefix="ns2" uri="http://ns.hr-xml.org/2007-04-15" />
  <pattern id="prohibitions">
    <rule context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:CustomerParty/ns1:Contacts/ns1:Contact/ns1:Person/ns1:PersonName/ns1:Salutation">
      <assert test="empty(@lang)">Invoice/Header/Parties/CustomerParty/Contacts/Contact/Person/PersonName/Salutation may not have attribute lang</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Line/ns1:Line">
      <assert test="empty(ns1:Line)">Invoice/Line/Line may not contain element Line</assert>
    </rule>
  </pattern>
  <pattern id="cardinality-redefines">
    <rule context="ns1:Invoice">
      <assert test="count(ns1:Header) &gt;= 1">Invoice must contain Header at least 1 time(s)</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Header">
      <assert test="count(ns1:DocumentIds) &gt;= 1">Invoice/Header must contain DocumentIds at least 1 time(s)</assert>
      <assert test="count(ns1:DocumentDateTime) &gt;= 1">Invoice/Header must contain DocumentDateTime at least 1 time(s)</assert>
      <assert test="count(ns1:Reason) &lt;= 1">Invoice/Header may contain Reason at most 1 time(s)</assert>
      <assert test="count(ns1:UserArea) &gt;= 1">Invoice/Header must contain UserArea at least 1 time(s)</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Header/ns1:DocumentIds">
      <assert test="count(ns1:DocumentId) &gt;= 1 and count(ns1:DocumentId) &lt;= 1">Invoice/Header/DocumentIds must contain DocumentId at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Header/ns1:DocumentIds/ns1:DocumentId">
      <assert test="count(ns1:Id) &gt;= 1">Invoice/Header/DocumentIds/DocumentId must contain Id at least 1 time(s)</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Header/ns1:Parties">
      <assert test="count(ns1:RemitToParty) &gt;= 1 and count(ns1:RemitToParty) &lt;= 1">Invoice/Header/Parties must contain RemitToParty at least 1 and at most 1 time(s)</assert>
      <assert test="count(ns1:CustomerParty) &gt;= 1 and count(ns1:CustomerParty) &lt;= 1">Invoice/Header/Parties must contain CustomerParty at least 1 and at most 1 time(s)</assert>
      <assert test="count(ns1:BillToParty) &gt;= 1 and count(ns1:BillToParty) &lt;= 1">Invoice/Header/Parties must contain BillToParty at least 1 and at most 1 time(s)</assert>
      <assert test="count(ns1:SupplierParty) &gt;= 1 and count(ns1:SupplierParty) &lt;= 1">Invoice/Header/Parties must contain SupplierParty at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:RemitToParty">
      <assert test="count(ns1:PartyId) &gt;= 1">Invoice/Header/Parties/RemitToParty must contain PartyId at least 1 time(s)</assert>
      <assert test="count(ns1:Name) &gt;= 1">Invoice/Header/Parties/RemitToParty must contain Name at least 1 time(s)</assert>
      <assert test="count(ns1:Addresses) &gt;= 1">Invoice/Header/Parties/RemitToParty must contain Addresses at least 1 time(s)</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:RemitToParty/ns1:PartyId">
      <assert test="count(ns1:Id) &gt;= 1">Invoice/Header/Parties/RemitToParty/PartyId must contain Id at least 1 time(s)</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:RemitToParty/ns1:Addresses">
      <assert test="count(ns1:PrimaryAddress) &gt;= 1">Invoice/Header/Parties/RemitToParty/Addresses must contain PrimaryAddress at least 1 time(s)</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:RemitToParty/ns1:Addresses/ns1:PrimaryAddress">
      <assert test="count(ns1:AddressLine) &lt;= 1">Invoice/Header/Parties/RemitToParty/Addresses/PrimaryAddress may contain AddressLine at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:RemitToParty/ns1:Contacts/ns1:Contact">
      <assert test="count(ns1:Telephone) &lt;= 1">Invoice/Header/Parties/RemitToParty/Contacts/Contact may contain Telephone at most 1 time(s)</assert>
      <assert test="count(ns1:Description) &lt;= 1">Invoice/Header/Parties/RemitToParty/Contacts/Contact may contain Description at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:RemitToParty/ns1:Contacts/ns1:Contact/ns1:Person/ns1:PersonName">
      <assert test="count(ns1:Salutation) &lt;= 1">Invoice/Header/Parties/RemitToParty/Contacts/Contact/Person/PersonName may contain Salutation at most 1 time(s)</assert>
      <assert test="count(ns1:GivenName) &lt;= 1">Invoice/Header/Parties/RemitToParty/Contacts/Contact/Person/PersonName may contain GivenName at most 1 time(s)</assert>
      <assert test="count(ns1:FamilyName) &lt;= 1">Invoice/Header/Parties/RemitToParty/Contacts/Contact/Person/PersonName may contain FamilyName at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:CustomerParty">
      <assert test="count(ns1:PartyId) &gt;= 1">Invoice/Header/Parties/CustomerParty must contain PartyId at least 1 time(s)</assert>
      <assert test="count(ns1:Name) &gt;= 1">Invoice/Header/Parties/CustomerParty must contain Name at least 1 time(s)</assert>
      <assert test="count(ns1:Addresses) &gt;= 1">Invoice/Header/Parties/CustomerParty must contain Addresses at least 1 time(s)</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:CustomerParty/ns1:PartyId">
      <assert test="count(ns1:Id) &gt;= 1">Invoice/Header/Parties/CustomerParty/PartyId must contain Id at least 1 time(s)</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:CustomerParty/ns1:Addresses">
      <assert test="count(ns1:PrimaryAddress) &gt;= 1">Invoice/Header/Parties/CustomerParty/Addresses must contain PrimaryAddress at least 1 time(s)</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:CustomerParty/ns1:Addresses/ns1:PrimaryAddress">
      <assert test="count(ns1:AddressLine) &lt;= 1">Invoice/Header/Parties/CustomerParty/Addresses/PrimaryAddress may contain AddressLine at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:CustomerParty/ns1:Contacts/ns1:Contact">
      <assert test="count(ns1:Description) &lt;= 1">Invoice/Header/Parties/CustomerParty/Contacts/Contact may contain Description at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:CustomerParty/ns1:Contacts/ns1:Contact/ns1:Person/ns1:PersonName">
      <assert test="count(ns1:Salutation) &lt;= 1">Invoice/Header/Parties/CustomerParty/Contacts/Contact/Person/PersonName may contain Salutation at most 1 time(s)</assert>
      <assert test="count(ns1:GivenName) &lt;= 1">Invoice/Header/Parties/CustomerParty/Contacts/Contact/Person/PersonName may contain GivenName at most 1 time(s)</assert>
      <assert test="count(ns1:FamilyName) &lt;= 1">Invoice/Header/Parties/CustomerParty/Contacts/Contact/Person/PersonName may contain FamilyName at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:BillToParty">
      <assert test="count(ns1:PartyId) &gt;= 1">Invoice/Header/Parties/BillToParty must contain PartyId at least 1 time(s)</assert>
      <assert test="count(ns1:Name) &gt;= 1">Invoice/Header/Parties/BillToParty must contain Name at least 1 time(s)</assert>
      <assert test="count(ns1:Addresses) &gt;= 1">Invoice/Header/Parties/BillToParty must contain Addresses at least 1 time(s)</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:BillToParty/ns1:PartyId">
      <assert test="count(ns1:Id) &gt;= 1">Invoice/Header/Parties/BillToParty/PartyId must contain Id at least 1 time(s)</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:BillToParty/ns1:Contacts/ns1:Contact">
      <assert test="count(ns1:Description) &lt;= 1">Invoice/Header/Parties/BillToParty/Contacts/Contact may contain Description at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:BillToParty/ns1:Contacts/ns1:Contact/ns1:Person/ns1:PersonName">
      <assert test="count(ns1:Salutation) &lt;= 1">Invoice/Header/Parties/BillToParty/Contacts/Contact/Person/PersonName may contain Salutation at most 1 time(s)</assert>
      <assert test="count(ns1:GivenName) &lt;= 1">Invoice/Header/Parties/BillToParty/Contacts/Contact/Person/PersonName may contain GivenName at most 1 time(s)</assert>
      <assert test="count(ns1:FamilyName) &lt;= 1">Invoice/Header/Parties/BillToParty/Contacts/Contact/Person/PersonName may contain FamilyName at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:SupplierParty">
      <assert test="count(ns1:PartyId) &gt;= 1">Invoice/Header/Parties/SupplierParty must contain PartyId at least 1 time(s)</assert>
      <assert test="count(ns1:Name) &gt;= 1">Invoice/Header/Parties/SupplierParty must contain Name at least 1 time(s)</assert>
      <assert test="count(ns1:Addresses) &gt;= 1">Invoice/Header/Parties/SupplierParty must contain Addresses at least 1 time(s)</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:SupplierParty/ns1:PartyId">
      <assert test="count(ns1:Id) &gt;= 1">Invoice/Header/Parties/SupplierParty/PartyId must contain Id at least 1 time(s)</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:SupplierParty/ns1:Addresses">
      <assert test="count(ns1:PrimaryAddress) &gt;= 1">Invoice/Header/Parties/SupplierParty/Addresses must contain PrimaryAddress at least 1 time(s)</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:SupplierParty/ns1:Addresses/ns1:PrimaryAddress">
      <assert test="count(ns1:AddressLine) &lt;= 1">Invoice/Header/Parties/SupplierParty/Addresses/PrimaryAddress may contain AddressLine at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:SupplierParty/ns1:Contacts/ns1:Contact">
      <assert test="count(ns1:Telephone) &lt;= 1">Invoice/Header/Parties/SupplierParty/Contacts/Contact may contain Telephone at most 1 time(s)</assert>
      <assert test="count(ns1:Description) &lt;= 1">Invoice/Header/Parties/SupplierParty/Contacts/Contact may contain Description at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Header/ns1:Parties/ns1:SupplierParty/ns1:Contacts/ns1:Contact/ns1:Person/ns1:PersonName">
      <assert test="count(ns1:Salutation) &lt;= 1">Invoice/Header/Parties/SupplierParty/Contacts/Contact/Person/PersonName may contain Salutation at most 1 time(s)</assert>
      <assert test="count(ns1:GivenName) &lt;= 1">Invoice/Header/Parties/SupplierParty/Contacts/Contact/Person/PersonName may contain GivenName at most 1 time(s)</assert>
      <assert test="count(ns1:FamilyName) &lt;= 1">Invoice/Header/Parties/SupplierParty/Contacts/Contact/Person/PersonName may contain FamilyName at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Header/ns1:UserArea">
      <assert test="count(ns2:StaffingAdditionalData) &gt;= 1 and count(ns2:StaffingAdditionalData) &lt;= 1">Invoice/Header/UserArea must contain StaffingAdditionalData at least 1 and at most 1 time(s)</assert>
      <assert test="count(ns2:StaffingOrganization) &lt;= 1">Invoice/Header/UserArea may contain StaffingOrganization at most 1 time(s)</assert>
      <assert test="count(ns2:StaffingOrganizationNL) &gt;= 1 and count(ns2:StaffingOrganizationNL) &lt;= 1">Invoice/Header/UserArea must contain StaffingOrganizationNL at least 1 and at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Header/ns1:UserArea/ns2:StaffingAdditionalData/ns2:CustomerReportingRequirements">
      <assert test="count(ns2:AdditionalRequirement) &gt;= 1">Invoice/Header/UserArea/StaffingAdditionalData/CustomerReportingRequirements must contain AdditionalRequirement at least 1 time(s)</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Header/ns1:UserArea/ns2:StaffingAdditionalData/ns2:CustomerReportingRequirements/ns2:AdditionalRequirement">
      <assert test="count(@requirementTitle) &gt;= 1">Invoice/Header/UserArea/StaffingAdditionalData/CustomerReportingRequirements/AdditionalRequirement must contain requirementTitle at least 1 time(s)</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Header/ns1:UserArea/ns2:StaffingAdditionalData/ns2:ReferenceInformation">
      <assert test="count(ns2:StaffingCustomerOrgUnitId) &lt;= 1">Invoice/Header/UserArea/StaffingAdditionalData/ReferenceInformation may contain StaffingCustomerOrgUnitId at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Header/ns1:UserArea/ns2:StaffingAdditionalData/ns2:ReferenceInformation/ns2:StaffingCustomerOrgUnitId">
      <assert test="count(ns2:IdValue) &lt;= 1">Invoice/Header/UserArea/StaffingAdditionalData/ReferenceInformation/StaffingCustomerOrgUnitId may contain IdValue at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Header/ns1:UserArea/ns2:StaffingOrganization">
      <assert test="count(ns2:Organization) &lt;= 1">Invoice/Header/UserArea/StaffingOrganization may contain Organization at most 1 time(s)</assert>
      <assert test="count(ns2:PaymentInfo) &lt;= 1">Invoice/Header/UserArea/StaffingOrganization may contain PaymentInfo at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Header/ns1:UserArea/ns2:StaffingOrganizationNL">
      <assert test="count(ns2:ChamberofCommerceReference) &gt;= 1">Invoice/Header/UserArea/StaffingOrganizationNL must contain ChamberofCommerceReference at least 1 time(s)</assert>
    </rule>
<!-- Handmatige aanpassing: geen ns1:Invoice/ns1:Line controles maar */ns1:Line controles zodat de controle OF op line OF op line/line level plaats vindt -->
    <rule context="ns1:Invoice/ns1:Line">
	  <assert test="(count(ns1:Line/ns1:Price) &gt;= 1 and count(ns1:Price) = 0) or (count(ns1:Price) &gt;= 1 and count(ns1:Line/ns1:Price) = 0) ">Invoice must contain Price either on Invoice/Line level or on all Invoice/Line/Line levels.</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Line/ns1:Charges">
      <assert test="(count(../ns1:Line/ns1:Charges/ns1:TotalCharge) &gt;= 1 and count(ns1:TotalCharge) = 0) or (count(ns1:TotalCharge) &gt;= 1 and count(../ns1:Line/ns1:Charges/ns1:TotalCharge) = 0) ">Invoice must contain TotalCharge either on Invoice/Line/Charges level or on all Invoice/Line/Line/Charges levels.</assert>
    </rule>
<!-- Einde aanpassing -->
    <rule context="ns1:Invoice/ns1:Line/ns1:Charges/ns1:Charge">
      <assert test="count(ns1:Description) &lt;= 1">Invoice/Line/Charges/Charge may contain Description at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Line/ns1:Line/ns1:Charges/ns1:Charge">
      <assert test="count(ns1:Description) &lt;= 1">Invoice/Line/Line/Charges/Charge may contain Description at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Line/ns1:UserArea">
      <assert test="count(ns2:StaffingAdditionalData) &lt;= 1">Invoice/Line/UserArea may contain StaffingAdditionalData at most 1 time(s)</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Line/ns1:Line/ns1:UserArea">
      <assert test="count(ns2:StaffingAdditionalData) &lt;= 1">Invoice/Line/Line/UserArea may contain StaffingAdditionalData at most 1 time(s)</assert>
    </rule>
  </pattern>
  <pattern id="type-restrictions">
    <rule context="ns1:Invoice/ns1:Header">
      <assert test="empty(ns1:ReasonCode) or (ns1:ReasonCode='Services') or (ns1:ReasonCode='Hours') or (ns1:ReasonCode='Combination') or (ns1:ReasonCode='services') or (ns1:ReasonCode='hours') or (ns1:ReasonCode='combination')">Invoice/Header/ReasonCode may only have (one of) the following value(s): Services, Hours, Combination, services, hours, combination</assert>
      <assert test="empty(ns1:Type) or (ns1:Type='Debit') or (ns1:Type='Credit') or (ns1:Type='Both')">Invoice/Header/Type may only have (one of) the following value(s): Debit, Credit, Both</assert>
      <assert test="empty(ns1:Reason) or (ns1:Reason='Regular') or (ns1:Reason='Pro Forma') or (ns1:Reason='Self-Billed') or (ns1:Reason='regular') or (ns1:Reason='pro forma') or (ns1:Reason='self-billed')">Invoice/Header/Reason may only have (one of) the following value(s): Regular, Pro Forma, Self-Billed, regular, pro forma, self-billed</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Header/ns1:UserArea/ns2:StaffingAdditionalData/ns2:CustomerReportingRequirements">
      <assert test="empty(ns2:AdditionalRequirement) or (ns2:AdditionalRequirement='1.6')">Invoice/Header/UserArea/StaffingAdditionalData/CustomerReportingRequirements/AdditionalRequirement may only have (one of) the following value(s): 1.6</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Header/ns1:UserArea/ns2:StaffingAdditionalData/ns2:CustomerReportingRequirements/ns2:AdditionalRequirement">
      <assert test="empty(@requirementTitle) or (@requirementTitle='VersionId')">Invoice/Header/UserArea/StaffingAdditionalData/CustomerReportingRequirements/AdditionalRequirement/@requirementTitle may only have (one of) the following value(s): VersionId</assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Header/ns1:UserArea/ns2:StaffingOrganization/ns2:PaymentInfo/ns2:BankAccountInfo/ns2:BankInfoByJurisdiction">
      <assert test="empty(@bankJurisdiction) or (@bankJurisdiction='NL')">Invoice/Header/UserArea/StaffingOrganization/PaymentInfo/BankAccountInfo/BankInfoByJurisdiction/@bankJurisdiction may only have (one of) the following value(s): NL</assert>
      <assert test="empty(ns2:BankWindow) or (ns2:BankWindow='')">Invoice/Header/UserArea/StaffingOrganization/PaymentInfo/BankAccountInfo/BankInfoByJurisdiction/BankWindow may only have (one of) the following value(s): [Empty]</assert>
      <assert test="empty(ns2:BankAccountKey) or (ns2:BankAccountKey='')">Invoice/Header/UserArea/StaffingOrganization/PaymentInfo/BankAccountInfo/BankInfoByJurisdiction/BankAccountKey may only have (one of) the following value(s): [Empty]</assert>
    </rule>
  </pattern>
  <pattern id="custom-rules">
    <rule context="ns1:Invoice/ns1:Line">
	  <!-- Price may be specified EITHER on the Line OR on ALL Line/Line occurences, but not both. -->
      <assert
	    test="(
               (count(ns1:Price) = 0) and
               (count(ns1:Line/ns1:Price) = count(ns1:Line))
              )
              or
              (
               (count(ns1:Price) > 0) and
               (count(ns1:Line/ns1:Price) = 0)
              )">Price MUST be given EITHER for Line OR for ALL Line/Line elements.
	  </assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Line/ns1:Tax/ns1:PercentQuantity">
	  <!-- tax percentage must exist on the level above. -->
      <assert
	    test="exists(index-of(../../../ns1:Header/ns1:Tax/ns1:PercentQuantity, text()))">Invoice/Line/Tax/PercentQuantity must be available on Header level: <value-of select="text()" />.
	  </assert>
    </rule>
    <rule context="ns1:Invoice/ns1:Line/ns1:Line/ns1:Tax/ns1:PercentQuantity">
	  <!-- tax percentage must exist on the level above. -->
      <assert
	    test="exists(index-of(../../../ns1:Tax/ns1:PercentQuantity, text()))">Invoice/Line/Line/Tax/PercentQuantity must be available on Line level above: <value-of select="text()" />.
	  </assert>
    </rule>
  </pattern>
</schema>
