<?xml version="1.0" encoding="UTF-8"?>
<!--

    Copyright 2011 Clockwork

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

-->
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns="http://www.clockwork.nl/ezp/pdf/canonical" 
  xmlns:xs="http://www.w3.org/2001/XMLSchema" 
  xmlns:in="http://www.openapplications.org/oagis" 
  xmlns:nl="http://ns.hr-xml.org/2007-04-15" 
  version="2.0"
  exclude-result-prefixes="in nl">
 <xsl:template match="in:RemitToParty">
    <crediteur>
      <btw_nummer><xsl:value-of select="in:TaxId"/></btw_nummer>
      <kvk_nummer>
        <xsl:value-of select="/in:Invoice/in:Header/in:UserArea/nl:StaffingOrganizationNL/nl:ChamberofCommerceReference"/>
      </kvk_nummer>
      <registratienummer>
        <xsl:value-of select="in:PartyId/in:Id"/>
      </registratienummer>
      <bankrekening>
        <nummer>
          <xsl:value-of select="/in:Invoice/in:Header/in:UserArea/nl:StaffingOrganization/nl:PaymentInfo/nl:BankAccountInfo/nl:BankInfoByJurisdiction/nl:BankAccountNumber"/>
        </nummer>
        <bic>
          <xsl:value-of select="/in:Invoice/in:Header/in:UserArea/nl:StaffingOrganization/nl:PaymentInfo/nl:BankAccountInfo/nl:BankInfoByJurisdiction/nl:BankCode"/>
        </bic>
      </bankrekening>
      <adres>
        <xsl:choose>
          <xsl:when test="in:Addresses/in:PrimaryAddress">
            <xsl:apply-templates select="in:Addresses/in:PrimaryAddress"/>
          </xsl:when>
          <xsl:otherwise>
             <xsl:apply-templates select="in:Contacts/in:Contact/in:Addresses/in:PrimaryAddress"/>
          </xsl:otherwise>
        </xsl:choose>
      </adres>
      <niet_natuurlijk_persoon>
        <naam>
          <xsl:value-of select="in:Name"/>
        </naam>
      </niet_natuurlijk_persoon>
      <xsl:apply-templates select="in:Contacts/in:Contact"/>
    </crediteur>
  </xsl:template>
  <xsl:template match="in:SupplierParty">
    <leverancier>
     <btw_nummer><xsl:value-of select="in:TaxId"/></btw_nummer>
      <registratienummer>
        <xsl:value-of select="in:PartyId/in:Id"/>
      </registratienummer>
      <adres>
        <xsl:choose>
          <xsl:when test="in:Addresses/in:PrimaryAddress">
            <xsl:apply-templates select="in:Addresses/in:PrimaryAddress"/>
          </xsl:when>
          <xsl:otherwise>
          <blerk/>
             <xsl:apply-templates select="in:Contacts/in:Contact/in:Addresses/in:PrimaryAddress"/>
          </xsl:otherwise>
        </xsl:choose>
      </adres>
      <niet_natuurlijk_persoon>
        <naam>
          <xsl:value-of select="in:Name"/>
        </naam>
      </niet_natuurlijk_persoon>
      <xsl:apply-templates select="in:Contacts/in:Contact"/>
    </leverancier>
  </xsl:template>
  <xsl:template match="in:BillToParty">
    <debiteur>
      <btw_nummer><xsl:value-of select="in:TaxId"/></btw_nummer>
      <registratienummer>
        <xsl:value-of select="in:PartyId/in:Id"/>
      </registratienummer>
    <adres>
        <xsl:choose>
          <xsl:when test="in:Addresses/in:PrimaryAddress">
            <xsl:apply-templates select="in:Addresses/in:PrimaryAddress"/>
          </xsl:when>
          <xsl:otherwise>
             <xsl:apply-templates select="in:Contacts/in:Contact/in:Addresses/in:PrimaryAddress"/>
          </xsl:otherwise>
        </xsl:choose>
      </adres>
      <niet_natuurlijk_persoon>
        <naam>
          <xsl:value-of select="in:Name"/>
        </naam>
      </niet_natuurlijk_persoon>
      <xsl:apply-templates select="in:Contacts/in:Contact"/>
    </debiteur>
  </xsl:template>
   <xsl:template match="in:CustomerParty">
    <afnemer>
      <btw_nummer><xsl:value-of select="in:TaxId"/></btw_nummer>
      <registratienummer>
        <xsl:value-of select="in:PartyId/in:Id"/>
      </registratienummer>      
      <adres>
        <xsl:choose>
          <xsl:when test="in:Addresses/in:PrimaryAddress">
            <xsl:apply-templates select="in:Addresses/in:PrimaryAddress"/>
          </xsl:when>
          <xsl:otherwise>
             <xsl:apply-templates select="in:Contacts/in:Contact/in:Addresses/in:PrimaryAddress"/>
          </xsl:otherwise>
        </xsl:choose>
      </adres>
      <niet_natuurlijk_persoon>
        <naam>
          <xsl:value-of select="in:Name"/>
        </naam>
      </niet_natuurlijk_persoon>
      <xsl:apply-templates select="in:Contacts/in:Contact"/>
    </afnemer>
  </xsl:template>
  <xsl:template match="in:PrimaryAddress">
    <straat_adres>
      <xsl:for-each select="in:AddressLine">
        <adresregel>
          <xsl:value-of select="."/>
        </adresregel>
      </xsl:for-each>
      <postcode>
        <xsl:value-of select="in:PostalCode"/>
      </postcode>
      <plaats>
        <xsl:value-of select="in:City"/>
      </plaats>
    </straat_adres>
  </xsl:template>
  <xsl:template match="in:Contact">
    <natuurlijk_persoon>
      <voornaam>
        <xsl:value-of select="in:PersonName/in:GivenName"/>
      </voornaam>
      <achternaam>
        <xsl:value-of select="in:PersonName/in:FamilyName"/>
      </achternaam>
    </natuurlijk_persoon>
  </xsl:template>  
  
  
</xsl:stylesheet>
