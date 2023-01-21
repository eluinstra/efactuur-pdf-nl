<?xml version="1.0" encoding="utf-8"?>
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
<xsl:stylesheet xpath-default-namespace="http://www.clockwork.nl/ezp/pdf/canonical" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:fox="http://xmlgraphics.apache.org/fop/extensions" xmlns:nl="http://ns.hr-xml.org/2007-04-15"
	version="2.0">

	<xsl:decimal-format decimal-separator="," grouping-separator="." />
	<xsl:decimal-format name="european" decimal-separator="," grouping-separator="." />

	<xsl:variable name="date_format" select="'[D01]-[M01]-[Y]'" />
	<xsl:variable name="date_time_format" select="'[H01]:[m01]:[s01] [D01]-[M01]-[Y]'" />
	<xsl:variable name="decimal_format" select="'###.###.###.##0,00'" />

	<xsl:param name="message_id" required="yes" />
	<xsl:param name="message_format" required="yes" />
	<xsl:param name="message_version" required="yes" />
	<xsl:param name="bericht_soort" required="yes" />
	<xsl:param name="message_date" required="yes" as="xs:dateTime" />
	<xsl:param name="original_message_type" required="yes" />

	<xsl:template match="/">
		<fo:root>
			<fo:layout-master-set>
				<fo:simple-page-master master-name="page" page-width="210mm" page-height="297mm" margin-top="5mm" margin-left="5mm" margin-right="5mm">
					<fo:region-body region-name="body" margin-top="1.5cm" margin-bottom="1cm" />
					<fo:region-before region-name="header" extent="1.5cm" />
					<fo:region-after region-name="footer" extent="1cm" />
				</fo:simple-page-master>
				<fo:page-sequence-master master-name="content">
					<fo:repeatable-page-master-reference master-reference="page" />
				</fo:page-sequence-master>
			</fo:layout-master-set>
			<xsl:call-template name="Content" />
		</fo:root>
	</xsl:template>

	<xsl:template name="Content">
		<fo:page-sequence id="page-sequence" master-reference="content" font-family="Times" font-size="11pt" line-height="1.1">
			<fo:static-content flow-name="header">
				<xsl:call-template name="header" />
			</fo:static-content>
			<fo:static-content flow-name="footer">
				<xsl:call-template name="footer" />
			</fo:static-content>
			<fo:flow flow-name="body">
				<xsl:call-template name="body" />
			</fo:flow>
		</fo:page-sequence>
	</xsl:template>

	<xsl:template name="header">
		<fo:block>
			<fo:table table-layout="fixed" width="100%">
				<fo:table-column column-width="30%" />
				<fo:table-column column-width="70%" />
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell>
							<fo:block text-align="left">
								BerichtSoort:
								<xsl:value-of select="$bericht_soort" />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block text-align="right">
								Berichtnummer:
								<xsl:value-of select="$message_id" />
							</fo:block>
						</fo:table-cell>

					</fo:table-row>
					<fo:table-row>
						<fo:table-cell>
							<fo:block text-align="left">
								Invoice Formaat:
								<xsl:value-of select="$message_format" />
								<xsl:value-of select="$message_version" />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block text-align="right">
								Ontvangst Digipoort:
								<xsl:value-of select="format-dateTime($message_date,$date_time_format)" />
							</fo:block>
						</fo:table-cell>
					</fo:table-row>

					<fo:table-row>
						<fo:table-cell>
							<fo:block text-align="left" font-weight="bold">
								<xsl:value-of select="/bericht/factuur/factuurtype" />
								Factuur
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block text-align="left">
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>

	</xsl:template>

	<xsl:template name="footer">
		<fo:block text-align="center">
			Pagina
			<fo:page-number />
		</fo:block>
	</xsl:template>

	<xsl:template name="body">
		<fo:table table-layout="fixed" width="100%">
			<fo:table-column column-width="50%" />
			<fo:table-column column-width="50%" />
			<fo:table-body>
				<fo:table-row>
					<fo:table-cell xsl:use-attribute-sets="main-table-cell">
						<xsl:call-template name="leverancier" />
					</fo:table-cell>
					<fo:table-cell xsl:use-attribute-sets="main-table-cell">
						<xsl:call-template name="factuur_info" />
					</fo:table-cell>
				</fo:table-row>
				<fo:table-row>
					<fo:table-cell xsl:use-attribute-sets="main-table-cell">
						<xsl:call-template name="crediteur" />
					</fo:table-cell>
					<fo:table-cell xsl:use-attribute-sets="main-table-cell">
						<xsl:call-template name="crediteur_info" />
					</fo:table-cell>
				</fo:table-row>
				<fo:table-row>
					<fo:table-cell xsl:use-attribute-sets="main-table-cell">
						<xsl:call-template name="afnemer" />
					</fo:table-cell>
					<fo:table-cell xsl:use-attribute-sets="main-table-cell">
						<xsl:call-template name="debiteur" />
					</fo:table-cell>
				</fo:table-row>
				<fo:table-row>
					<fo:table-cell xsl:use-attribute-sets="main-table-cell">
						<xsl:call-template name="betreft" />
					</fo:table-cell>
					<fo:table-cell xsl:use-attribute-sets="main-table-cell">
						<xsl:call-template name="referentie" />
					</fo:table-cell>
				</fo:table-row>
				<fo:table-row>
					<fo:table-cell number-columns-spanned="2" xsl:use-attribute-sets="main-table-cell">
						<xsl:if test="$original_message_type = 'UBL'">
							<xsl:call-template name="factuurregels_ubl" />
						</xsl:if>
						<xsl:if test="$original_message_type = 'SETU'">
							<xsl:call-template name="factuurregels_setu" />
						</xsl:if>
					</fo:table-cell>
				</fo:table-row>
				<fo:table-row>
					<fo:table-cell xsl:use-attribute-sets="main-table-cell">
						<xsl:call-template name="opmerkingen_en_betalingscondities" />
					</fo:table-cell>

					<fo:table-cell xsl:use-attribute-sets="main-table-cell">
						<xsl:call-template name="totaalbedragen" />
					</fo:table-cell>
				</fo:table-row>
				<fo:table-row>
					<fo:table-cell number-columns-spanned="2" xsl:use-attribute-sets="main-table-cell">
						<xsl:call-template name="bijlages" />
					</fo:table-cell>
				</fo:table-row>
			</fo:table-body>
		</fo:table>
	</xsl:template>

	<xsl:template name="leverancier">
		<fo:block font-weight="bold">
			Leverancier
		</fo:block>
		<xsl:apply-templates select="/bericht/leverancier/niet_natuurlijk_persoon" />
		<xsl:apply-templates select="/bericht/leverancier/adres" />
	</xsl:template>

	<xsl:template match="niet_natuurlijk_persoon">
		<fo:block font-weight="bold">
			<xsl:value-of select="naam" />
		</fo:block>
		<xsl:if test="contactpersoon/naam!=''">
			<fo:block>
				t.a.v.
				<xsl:value-of select="contactpersoon/naam" />
			</fo:block>
		</xsl:if>
		<xsl:if test="contactpersoon/telefoonnummer!=''">
			<fo:block>
				tel.:
				<xsl:value-of select="contactpersoon/telefoonnummer" />
			</fo:block>
		</xsl:if>
		<xsl:if test="contactpersoon/email!=''">
			<fo:block>
				email:
				<xsl:value-of select="contactpersoon/email" />
			</fo:block>
		</xsl:if>
	</xsl:template>

	<xsl:template name="factuur_info">
		<fo:block>
			Debiteurennummer:
			<xsl:value-of select="/bericht/debiteur/registratienummer" />
		</fo:block>
		<fo:block>
			Factuurnummer:
			<xsl:value-of select="/bericht/factuur/factuurnummer" />
		</fo:block>
		<fo:block>
			Factuurdatum:
			<xsl:apply-templates select="/bericht/factuur/datum" mode="date" /><!--xsl:value-of select="format-dateTime(/bericht/factuur/datum,$date_format)"/ -->
		</fo:block>
		<fo:block>
			<xsl:call-template name="vervaldatum"></xsl:call-template>
		</fo:block>
		<fo:block>
			Inkooporder:
			<xsl:value-of select="/bericht/factuur/inkooporder" />
		</fo:block>
	</xsl:template>

	<xsl:template name="vervaldatum">
		<xsl:choose>
			<xsl:when test="format-dateTime(/bericht/factuur/betalingscondities/conditie/setu_vervaldatum,$date_format) != ''">
				Vervaldatum:
				<xsl:value-of select="format-dateTime(/bericht/factuur/betalingscondities/conditie/setu_vervaldatum,$date_format)" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="/bericht/factuur/referentie/factuur_oorspronkelijk/verval_datum != ''">
					Vervaldatum:
					<xsl:value-of select="format-date(/bericht/factuur/referentie/factuur_oorspronkelijk/verval_datum, $date_format)" />
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="crediteur">
		<fo:block font-weight="bold">
			Crediteur
		</fo:block>
		<xsl:apply-templates select="/bericht/crediteur/niet_natuurlijk_persoon" />
		<xsl:apply-templates select="/bericht/crediteur/adres" />
	</xsl:template>

	<xsl:template name="crediteur_info">
		<fo:block>
			<fo:leader />
		</fo:block>
		<fo:block>
			BTW Nummer:
			<xsl:value-of select="/bericht/crediteur/btw_nummer" />
		</fo:block>
		<fo:block>
			IBAN:
			<xsl:value-of select="/bericht/crediteur/bankrekening/nummer" />
		</fo:block>
		<fo:block>
			BIC:
			<xsl:value-of select="/bericht/crediteur/bankrekening/bic" />
		</fo:block>
		<fo:block>
			KvK:
			<xsl:value-of select="/bericht/crediteur/kvk_nummer" />
		</fo:block>
	</xsl:template>

	<xsl:template name="afnemer">
		<fo:block font-weight="bold">
			Afnemer
		</fo:block>
		<xsl:apply-templates select="/bericht/afnemer/niet_natuurlijk_persoon" />
		<xsl:apply-templates select="/bericht/afnemer/adres" />
	</xsl:template>

	<xsl:template name="debiteur">
		<fo:block font-weight="bold">
			Debiteur
		</fo:block>
		<xsl:apply-templates select="/bericht/debiteur/niet_natuurlijk_persoon" />
		<xsl:apply-templates select="/bericht/debiteur/adres" />
		<fo:block>
			<xsl:value-of select="/bericht/debiteur/btw_nummer" />
		</fo:block>
	</xsl:template>

	<xsl:template name="betreft">
		<fo:block font-weight="bold">
			Betreft
		</fo:block>

		<xsl:for-each select="/bericht/factuur/omschrijving/item">
			<fo:block>
				<xsl:value-of select="." />
			</fo:block>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="referentie">
		<xsl:choose>
			<xsl:when
				test="/bericht/factuur/referentie/contract/nummer != '' or /bericht/factuur/referentie/factuur_oorspronkelijk/factuurnummer_leverancier != '' or /bericht/factuur/referentie/factuur_oorspronkelijk/datum != ''">

				<fo:block font-weight="bold">
					Referentie
				</fo:block>

				<xsl:if test="/bericht/factuur/referentie/contract/nummer != ''">
					<fo:block>
						Contractnummer:
						<xsl:value-of select="/bericht/factuur/referentie/contract/nummer" />
					</fo:block>
				</xsl:if>

				<xsl:if test="/bericht/factuur/referentie/factuur_oorspronkelijk/factuurnummer_leverancier != ''">
					<fo:block>
						Factuurnummer:
						<xsl:value-of select="/bericht/factuur/referentie/factuur_oorspronkelijk/factuurnummer_leverancier" />
					</fo:block>
				</xsl:if>

				<xsl:if test="/bericht/factuur/referentie/factuur_oorspronkelijk/datum != ''">
					<fo:block>
						Factuurdatum:
						<xsl:value-of select="/bericht/factuur/referentie/factuur_oorspronkelijk/datum" />
					</fo:block>
				</xsl:if>

			</xsl:when>
			<xsl:otherwise>
				<fo:block></fo:block>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="factuurregels_setu">
		<fo:block border="solid 1px black">
			<fo:table table-omit-header-at-break="false">
				<fo:table-column column-width="5%" border-right="solid 1px black" />
				<fo:table-column column-width="42%" border-right="solid 1px black" />
				<fo:table-column column-width="11%" border-right="solid 1px black" />
				<fo:table-column column-width="10%" border-right="solid 1px black" />
				<fo:table-column column-width="8%" border-right="solid 1px black" />
				<fo:table-column column-width="10%" border-right="solid 1px black" />
				<fo:table-column column-width="12%" />
				<fo:table-header font-weight="bold">
					<fo:table-row>
						<fo:table-cell xsl:use-attribute-sets="factuur-table-cell" padding-bottom=".5em">
							<fo:block>
								Nr
							</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="factuur-table-cell">
							<fo:block>
								Omschrijving
							</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="factuur-table-cell">
							<fo:block>
								Dienst/uur
							</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="factuur-table-cell">
							<fo:block>
								Prijs
							</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="factuur-table-cell">
							<fo:block>
								BTW% </fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="factuur-table-cell">
							<fo:block>
								Toeslag
							</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="factuur-table-cell">
							<fo:block>
								Totaal(<xsl:value-of select="/bericht/factuur/@currency" />)
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-header>
				<fo:table-body>
					<xsl:for-each select="/bericht/factuur/factuur_regel">
						<xsl:call-template name="factuurregel" />
					</xsl:for-each>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>


	<xsl:template name="factuurregels_ubl">
		<fo:block border="solid 1px black">
			<fo:table table-omit-header-at-break="false" table-layout="fixed" width="100%">
				<fo:table-column column-width="5%" border-right="solid 1px black" />
				<fo:table-column column-width="41%" border-right="solid 1px black" />
				<fo:table-column column-width="11%" border-right="solid 1px black" />
				<fo:table-column column-width="11%" border-right="solid 1px black" />
				<fo:table-column column-width="8%" border-right="solid 1px black" />
				<fo:table-column column-width="10%" border-right="solid 1px black" />
				<fo:table-column column-width="12%" />
				<fo:table-header font-weight="bold">
					<fo:table-row>
						<fo:table-cell xsl:use-attribute-sets="factuur-table-cell" padding-bottom=".5em">
							<fo:block>
								Nr
							</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="factuur-table-cell">
							<fo:block>
								Omschrijving
							</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="factuur-table-cell">
							<fo:block>
								Aantal
							</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="factuur-table-cell">
							<fo:block>
								Prijs
							</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="factuur-table-cell">
							<fo:block>
								BTW%
							</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="factuur-table-cell">
							<fo:block>
								Toeslag
							</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="factuur-table-cell">
							<fo:block>
								Totaal(<xsl:value-of select="/bericht/factuur/@currency" />)
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-header>
				<fo:table-body>
					<xsl:for-each select="/bericht/factuur/factuur_regel">
						<xsl:call-template name="factuurregel" />
					</xsl:for-each>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>

	<xsl:template name="factuurregel">
		<fo:table-row>
			<fo:table-cell text-align="right" xsl:use-attribute-sets="factuur-table-cell">
				<fo:block>
					<xsl:value-of select="replace(regelnummer,'^0*(..*)','$1')" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="factuur-table-cell">
				<fo:block>
					<xsl:value-of select="omschrijving" />
					<xsl:if test="not(empty(@bijlage))">
						<fo:basic-link internal-destination="{@bijlage}">
							<fo:inline font-style="italic">
								(Zie Bijlage <xsl:value-of select="@bijlage" />)
							</fo:inline>
						</fo:basic-link>
					</xsl:if>
				</fo:block>
				<xsl:for-each select="extra_omschrijving/omschrijving_regel">
					<fo:block>
						<xsl:value-of select="." />
					</fo:block>
				</xsl:for-each>
			</fo:table-cell>
			<fo:table-cell text-align="right" xsl:use-attribute-sets="factuur-table-cell">
				<fo:block>
					<xsl:apply-templates select="aantal" mode="number" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell text-align="right" xsl:use-attribute-sets="factuur-table-cell">
				<fo:block>
					<xsl:apply-templates select="bedrag/prijs" mode="number" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell text-align="right" xsl:use-attribute-sets="factuur-table-cell">
				<fo:block>
					<xsl:apply-templates select="bedrag/btw/percentage" mode="number" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell text-align="right" xsl:use-attribute-sets="factuur-table-cell">
				<fo:block>
					<xsl:apply-templates select="bedrag/toeslag/bedrag" mode="number" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell text-align="right" xsl:use-attribute-sets="factuur-table-cell">
				<fo:block>
					<xsl:apply-templates select="bedrag/totaal_ex_btw" mode="number" />
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>

	<xsl:template name="opmerkingen_en_betalingscondities">
		<fo:block>
			<fo:table table-layout="fixed" width="100%">
				<fo:table-column column-width="100%" />
				<fo:table-body>
					<xsl:if test="/bericht/factuur/opmerkingen!=''">
						<fo:table-row>
							<fo:table-cell xsl:use-attribute-sets="main-table-cell">
								<xsl:call-template name="opmerkingen" />
							</fo:table-cell>
						</fo:table-row>
					</xsl:if>

					<fo:table-row>
						<fo:table-cell xsl:use-attribute-sets="main-table-cell">
							<xsl:call-template name="betalingscondities" />
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>

	<xsl:template name="opmerkingen">
		<fo:block font-weight="bold">
			Opmerkingen:
		</fo:block>
		<fo:block border="black 0px solid">
			<xsl:value-of select="/bericht/factuur/opmerkingen" />
		</fo:block>
	</xsl:template>

	<xsl:template name="betalingscondities">
		<fo:block font-weight="bold">
			Betalingscondities
		</fo:block>
		<xsl:for-each select="/bericht/factuur/betalingscondities/conditie">
			<fo:block border="black 0px solid">
				<!--xsl:apply-templates select="child::node()" mode="betalingsconditie"/ -->
				<xsl:apply-templates select="omschrijving" mode="betalingsconditie" />
				<xsl:apply-templates select="kortingspercentage" mode="betalingsconditie" />
				<xsl:apply-templates select="setu_start_datum" mode="betalingsconditie" />
				<xsl:apply-templates select="setu_vervaldatum" mode="betalingsconditie" />
				<xsl:apply-templates select="setu_aantal_dagen" mode="betalingsconditie" />
				<xsl:apply-templates select="ubl_looptijd" mode="betalingsconditie" />
			</fo:block>
		</xsl:for-each>
	</xsl:template>


	<xsl:template match="omschrijving" mode="betalingsconditie">
		<fo:block>
			Omschrijving:
			<xsl:value-of select="child::node()" />
		</fo:block>
	</xsl:template>

	<xsl:template match="kortingspercentage" mode="betalingsconditie">
		<fo:block>
			Kortingspercentage:
			<xsl:apply-templates select="child::node()" mode="number" />
			%
		</fo:block>
	</xsl:template>

	<xsl:template match="setu_aantal_dagen" mode="betalingsconditie">
		<fo:block>
			Aantal Dagen:
			<xsl:apply-templates select="child::node()" mode="number" />
		</fo:block>
	</xsl:template>

	<xsl:template match="setu_start_datum" mode="betalingsconditie">
		<fo:block>
			Startdatum:
			<xsl:apply-templates select="child::node()" mode="date" /><!--xsl:value-of select="format-dateTime(child::node(),$date_format)"/ -->
		</fo:block>
	</xsl:template>

	<xsl:template match="setu_vervaldatum" mode="betalingsconditie">
		<fo:block>
			Vervaldatum:
			<xsl:apply-templates select="child::node()" mode="date" /><!--xsl:value-of select="format-date(child::node(),$date_format)"/ -->
		</fo:block>
	</xsl:template>

	<xsl:template match="ubl_looptijd" mode="betalingsconditie">
		<fo:block>
			Looptijd:
			<xsl:value-of select="child::node()" />
			<xsl:value-of select="@type" />
		</fo:block>
	</xsl:template>

	<xsl:template name="totaalbedragen">
		<fo:block>
			<fo:table table-layout="fixed" width="100%">
				<fo:table-column column-width="70%" />
				<fo:table-column column-width="30%" />
				<fo:table-header>
					<fo:table-row>
						<fo:table-cell number-columns-spanned="2">
							<fo:block font-weight="bold">
								Factuur totalen
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-header>
				<fo:table-footer>
					<fo:table-row font-weight="bold" border-top="black 1px solid">
						<fo:table-cell padding-top="1em">
							<fo:block>
								<xsl:choose>
									<xsl:when test="/bericht/factuur/factuurtype = 'Credit'">
										<xsl:text>Totaal te ontvangen:</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>Totaal te betalen:</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell padding-top="1em" text-align="right">
							<fo:block>
								<xsl:apply-templates select="/bericht/factuur/totalen_factuur/bedrag_totaal" mode="number" />
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-footer>
				<fo:table-body>
					<xsl:if test="/bericht/factuur/totalen_factuur/korting != ''">
						<fo:table-row>
							<fo:table-cell>
								<fo:block>
									Kortingen:
								</fo:block>
							</fo:table-cell>
							<fo:table-cell text-align="right">
								<fo:block>
									-<xsl:apply-templates select="/bericht/factuur/totalen_factuur/korting" mode="number" />
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:if>
					<xsl:if test="/bericht/factuur/totalen_factuur/toeslag!=''">
						<fo:table-row>
							<fo:table-cell>
								<fo:block>
									Toeslagen:
								</fo:block>
							</fo:table-cell>
							<fo:table-cell text-align="right">
								<fo:block>
									<xsl:apply-templates select="/bericht/factuur/totalen_factuur/toeslag" mode="number" />
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:if>
					<fo:table-row>
						<fo:table-cell>
							<fo:block>
								Totaal ex BTW:
							</fo:block>
						</fo:table-cell>
						<fo:table-cell text-align="right">
							<fo:block>
								<xsl:apply-templates select="/bericht/factuur/totalen_factuur/excl_btw_incl_korting" mode="number" />
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<xsl:for-each select="/bericht/factuur/totalen_factuur/btw">
						<fo:table-row>
							<fo:table-cell>
								<fo:block>
									BTW (<xsl:apply-templates select="percentage" mode="number" />%)<xsl:if test="over and over != ''"> over <xsl:value-of select="over" /></xsl:if>:
								</fo:block>
							</fo:table-cell>
							<fo:table-cell text-align="right">
								<fo:block>
									<xsl:apply-templates select="bedrag" mode="number" />
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:for-each>
					<xsl:if test="/bericht/factuur/totalen_factuur/afrondingscorrectie and /bericht/factuur/totalen_factuur/afrondingscorrectie != ''">
						<fo:table-row>
							<fo:table-cell>
								<fo:block>
									Afrondingscorrectie:
								</fo:block>
							</fo:table-cell>
							<fo:table-cell text-align="right">
								<fo:block>
									<xsl:apply-templates select="/bericht/factuur/totalen_factuur/afrondingscorrectie" mode="number" />
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:if>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>

	<xsl:template name="bijlages">
		<fo:block>
			<xsl:for-each select="/bericht/bijlages/bijlage">
				<fo:block id="{@id}" break-before="page" font-weight="bold">
					Bijlage
					<xsl:value-of select="@id" />
				</fo:block>
				<xsl:apply-templates select="nl:TimeCard" />
			</xsl:for-each>
		</fo:block>
	</xsl:template>

	<xsl:template match="nl:TimeCard">
		<fo:block>
			Urenstaat
		</fo:block>
		<fo:block>
			<fo:table table-omit-header-at-break="false">
				<fo:table-column column-width="25%" />
				<fo:table-column column-width="75%" />
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell number-columns-spanned="2">
							<fo:block font-weight="bold">
								Resource
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row>
						<fo:table-cell>
							<fo:block>Id</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>
								<xsl:value-of select="nl:ReportedResource/nl:Person/nl:Id/nl:IdValue" />
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row>
						<fo:table-cell>
							<fo:block>Naam</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>
								<xsl:value-of select="nl:ReportedResource/nl:Person/nl:PersonName/nl:LegalName" />
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<xsl:for-each select="nl:ReportedTime/nl:TimeInterval">
						<fo:table-row>
							<fo:table-cell number-columns-spanned="2">
								<fo:block font-weight="bold">
									Periode
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						<fo:table-row>
							<fo:table-cell>
								<fo:block>Startdatum</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block>
									<xsl:apply-templates select="nl:StartDateTime" mode="date" />
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						<fo:table-row>
							<fo:table-cell>
								<fo:block>Einddatum</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block>
									<xsl:apply-templates select="nl:EndDateTime" mode="date" />
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						<fo:table-row>
							<fo:table-cell>
								<fo:block>Tarief</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block>
									<xsl:apply-templates select="nl:RateOrAmount" mode="number" />
									<xsl:text> </xsl:text>
									<xsl:value-of select="nl:RateOrAmount/@currency" />
									(<xsl:value-of select="nl:RateOrAmount/@type" />
									<xsl:if test="nl:RateOrAmount/@multiplier and number(nl:RateOrAmount/@multiplier) != 100">
										<xsl:text> * </xsl:text>
										<xsl:value-of select="nl:RateOrAmount/@multiplier" />
									</xsl:if>)
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						<fo:table-row>
							<fo:table-cell>
								<fo:block>Duur</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block>
									<xsl:apply-templates select="nl:Duration" mode="number" />
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						<fo:table-row>
							<fo:table-cell>
								<fo:block>Opmerking</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block>
									<xsl:apply-templates select="nl:Comment" />
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:for-each>
					<xsl:for-each select="nl:ReportedTime/nl:Allowance">
						<fo:table-row>
							<fo:table-cell number-columns-spanned="2">
								<fo:block font-weight="bold">
									Vergoeding
									<xsl:value-of select="@type" />
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						<fo:table-row>
							<fo:table-cell>
								<fo:block>Startdatum</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block>
									<xsl:apply-templates select="nl:StartDate" mode="date" />
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						<fo:table-row>
							<fo:table-cell>
								<fo:block>Einddatum</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block>
									<xsl:apply-templates select="nl:EndDate" mode="date" />
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						<fo:table-row>
							<fo:table-cell>
								<fo:block>Prijs</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block>
									<xsl:apply-templates select="nl:Amount" mode="number" />
									<xsl:text> </xsl:text>
									<xsl:value-of select="nl:Amount/@currency" />
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						<fo:table-row>
							<fo:table-cell>
								<fo:block>Aantal</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block>
									<xsl:apply-templates select="nl:Quantity" mode="number" />
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:for-each>
					<fo:table-row>
						<fo:table-cell number-columns-spanned="2">
							<fo:block font-weight="bold">
								Project
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row>
						<fo:table-cell>
							<fo:block>Ordernummer</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>
								<xsl:value-of select="nl:AdditionalData/nl:StaffingAdditionalData/nl:CustomerReportingRequirements/nl:PurchaseOrderNumber" />
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row>
						<fo:table-cell>
							<fo:block>Projectcode</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>
								<xsl:value-of select="nl:AdditionalData/nl:StaffingAdditionalData/nl:CustomerReportingRequirements/nl:ProjectCode" />
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row>
						<fo:table-cell>
							<fo:block>Referentienummer</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>
								<xsl:choose>
									<xsl:when test="nl:AdditionalData/nl:StaffingAdditionalData/nl:CustomerReportingRequirements/nl:CustomerReferenceNumber!=''">
										<xsl:value-of select="nl:AdditionalData/nl:StaffingAdditionalData/nl:CustomerReportingRequirements/nl:CustomerReferenceNumber" />
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="/nl:Invoice/nl:Header/nl:UserArea/nl:StaffingAdditionalData/nl:CustomerReportingRequirements/nl:CustomerReferenceNumber" />
									</xsl:otherwise>
								</xsl:choose>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>

	<xsl:template match="//adres">

		<xsl:apply-templates select="postadres" mode="detail"></xsl:apply-templates>
		<xsl:apply-templates select="adres" mode="detail"></xsl:apply-templates>

	</xsl:template>

	<xsl:template match="postadres" mode="detail">
		<xsl:call-template name="addresstemplate" />
	</xsl:template>

	<xsl:template match="adres" mode="detail">
		<xsl:call-template name="addresstemplate" />
	</xsl:template>

	<xsl:template name="addresstemplate">
		<!-- SETU ONLY -->
		<xsl:for-each select="adresregel">
			<fo:block>
				<xsl:value-of select="." />
			</fo:block>
		</xsl:for-each>
		<!-- END SETU ONLY -->

		<xsl:if test="postbusnummer!=''">
			<fo:block>
				Postbus
				<xsl:value-of select="postbusnummer" />
			</fo:block>
		</xsl:if>
		<xsl:if test="straat!=''">
			<fo:block>
				<!-- DIGIFACT-45 -->
				<xsl:value-of select="straat" />
				<xsl:text> </xsl:text>
				<xsl:value-of select="huisnummer" />
			</fo:block>
		</xsl:if>

		<xsl:if test="postcode!=''">
			<fo:block>
				<xsl:value-of select="postcode" />, <xsl:value-of select="woonplaats" />
			</fo:block>
		</xsl:if>
		<xsl:if test="regio!=''">
			<fo:block>
				<xsl:value-of select="regio" />
			</fo:block>
		</xsl:if>
		<xsl:if test="landcode!=''">
			<fo:block>
				<xsl:value-of select="landcode" />
			</fo:block>
		</xsl:if>
	</xsl:template>

	<xsl:template match="*|node()" mode="number">
		<xsl:if test="fn:string-length(.)>0">
			<xsl:value-of select="format-number(.,$decimal_format,'european')" />
		</xsl:if>
	</xsl:template>

	<xsl:template match="*|node()" mode="date">
		<xsl:choose>
			<xsl:when test="fn:string-length(.)=10">
				<xsl:value-of select="format-date(.,$date_format)" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="format-dateTime(.,$date_format)" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="*|node()" mode="dateTime">
		<xsl:choose>
			<xsl:when test="fn:string-length(.)=10">
				<xsl:value-of select="format-date(.,$date_time_format)" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="format-dateTime(.,$date_time_format)" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:attribute-set name="main-table-cell">
		<xsl:attribute name="padding">.75em</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="factuur-table-cell">
		<xsl:attribute name="padding">0em .2em</xsl:attribute>
	</xsl:attribute-set>

</xsl:stylesheet>