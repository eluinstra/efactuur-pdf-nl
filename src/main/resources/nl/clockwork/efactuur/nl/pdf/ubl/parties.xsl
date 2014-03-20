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
  xmlns:in="http://www.nltaxonomie.nl/ubl/2.0/NL/1.0/xsd/maindoc/UBL-NL-Invoice" 
  xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" 
  xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" 
  version="2.0"
  exclude-result-prefixes="in cbc cac">
  <xsl:template match="cac:AccountingSupplierParty">
    <crediteur>
      <kvk_nummer>
        <xsl:value-of select="cac:Party/cac:PartyIdentification/cbc:ID"/>
      </kvk_nummer>
      <btw_nummer>
        <xsl:value-of select="cac:Party/cac:PartyTaxScheme/cbc:CompanyID"/>
      </btw_nummer>
      <registratienummer>
        <xsl:value-of select="cac:Party/cac:PartyIdentification/cbc:ID"/>
      </registratienummer>
      <bankrekening>
        <nummer>
          <xsl:value-of select="/in:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:ID"/>
        </nummer>
        <bic>
          <xsl:value-of select="/in:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID"/>
        </bic>
      </bankrekening>
      <adres>
        <xsl:apply-templates select="cac:Party/cac:PostalAddress"/>
        <xsl:apply-templates select="cac:Party/cac:PhysicalLocation/cac:Address"/>
      </adres>
      <niet_natuurlijk_persoon>
        <naam>
          <xsl:value-of select="cac:Party/cac:PartyName/cbc:Name"/>
        </naam>
      </niet_natuurlijk_persoon>
      <xsl:apply-templates select="cac:Party/cac:Person"/>
    </crediteur>
  </xsl:template>
  <xsl:template match="cac:SellerSupplierParty">
    <leverancier>
      <btw_nummer>
        <xsl:value-of select="cac:Party/cac:PartyTaxScheme/cbc:CompanyID"/>
      </btw_nummer>
      <registratienummer>
        <xsl:value-of select="cac:Party/cac:PartyIdentification/cbc:ID"/>
      </registratienummer>
      <bankrekening>
        <nummer>
          <xsl:value-of select="/in:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:ID"/>
        </nummer>
        <bic>
          <xsl:value-of select="/in:Invoice/cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cac:FinancialInstitution/cbc:ID"/>
        </bic>
      </bankrekening>
      <adres>
        <xsl:apply-templates select="cac:Party/cac:PostalAddress"/>
        <xsl:apply-templates select="cac:Party/cac:PhysicalLocation/cac:Address"/>
      </adres>
      <niet_natuurlijk_persoon>
        <naam>
          <xsl:value-of select="cac:Party/cac:PartyName/cbc:Name"/>
        </naam>
      </niet_natuurlijk_persoon>
      <xsl:apply-templates select="cac:Party/cac:Person"/>
    </leverancier>
  </xsl:template>
  <xsl:template match="cac:BuyerCustomerParty">
    <afnemer>
      <btw_nummer>
        <xsl:value-of select="cac:Party/cac:PartyTaxScheme/cbc:CompanyID"/>
      </btw_nummer>
      <registratienummer>
        <xsl:value-of select="cac:Party/cac:PartyIdentification/cbc:ID"/>
      </registratienummer>
      <adres>
        <xsl:apply-templates select="cac:Party/cac:PostalAddress"/>
        <xsl:apply-templates select="cac:Party/cac:PhysicalLocation/cac:Address"/>
      </adres>
      <niet_natuurlijk_persoon>
        <naam>
          <xsl:value-of select="cac:Party/cac:PartyName/cbc:Name"/>
        </naam>
      </niet_natuurlijk_persoon>
      <xsl:apply-templates select="cac:Party/cac:Person"/>
    </afnemer>
  </xsl:template>
   <xsl:template match="cac:AccountingCustomerParty">
    <debiteur>
      <btw_nummer>
        <xsl:value-of select="cac:Party/cac:PartyTaxScheme/cbc:CompanyID"/>
      </btw_nummer>
      <registratienummer>
        <xsl:value-of select="cac:Party/cac:PartyIdentification/cbc:ID"/>
      </registratienummer>
      <adres>
        <xsl:apply-templates select="cac:Party/cac:PostalAddress"/>
        <xsl:apply-templates select="cac:Party/cac:PhysicalLocation/cac:Address"/>
      </adres>
      <niet_natuurlijk_persoon>
        <naam>
          <xsl:value-of select="cac:Party/cac:PartyName/cbc:Name"/>
        </naam>
      </niet_natuurlijk_persoon>
      <xsl:apply-templates select="cac:Party/cac:Person"/>
    </debiteur>
  </xsl:template>
  <xsl:template match="cac:PostalAddress">
    <postbus_adres>
      <postbusnummer>
        <xsl:value-of select="cbc:Postbox"/>
      </postbusnummer>
      <postcode>
        <xsl:value-of select="cbc:PostalZone"/>
      </postcode>
      <woonplaats>
        <xsl:value-of select="cbc:CityName"/>
      </woonplaats>
      <regio>
        <xsl:value-of select="cbc:Region"/>
      </regio>
      <landcode>
        <xsl:value-of select="cac:Country/cbc:IdentificationCode"/>
      </landcode>
    </postbus_adres>
  </xsl:template>
  <xsl:template match="cac:Address">
    <straat_adres>
      <adresregel>
        <xsl:value-of select="cbc:StreetName"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="cbc:BuildingNumber"/>
      </adresregel>
      <postcode>
        <xsl:value-of select="cbc:PostalZone"/>
      </postcode>
      <woonplaats>
        <xsl:value-of select="cbc:CityName"/>
      </woonplaats>
      <regio>
        <xsl:value-of select="cbc:Region"/>
      </regio>
      <landcode>
        <xsl:value-of select="cac:Country/cbc:IdentificationCode"/>
      </landcode>
    </straat_adres>
  </xsl:template>
  <xsl:template match="cac:Person">
    <natuurlijk_persoon>
      <voorletters>
        <xsl:value-of select="cbc:NameSuffix"/>
      </voorletters>
      <voornamen>
        <xsl:value-of select="cbc:FirstName"/>
      </voornamen>
      <voorvoegsel>
        <xsl:value-of select="cbc:MiddleName"/>
      </voorvoegsel>
      <achternaam>
        <xsl:value-of select="cbc:FamilyName"/>
      </achternaam>
    </natuurlijk_persoon>
  </xsl:template>
</xsl:stylesheet>
