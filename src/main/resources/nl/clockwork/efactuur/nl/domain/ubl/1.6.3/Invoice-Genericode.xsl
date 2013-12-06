<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<axsl:stylesheet xmlns:axsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sch="http://www.ascc.net/xml/schematron" xmlns:iso="http://purl.oclc.org/dsdl/schematron" xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" xmlns:nl-cbc="urn:digi-inkoop:ubl:2.0:NL:1.6:UBL-NL-CommonBasicComponents-2" version="2.0"><!--Importing stylesheet additions-->
   <axsl:output method="text"/><!--Implementers: please note that overriding process-prolog or process-root is 
    the preferred method for meta-stylesheets to use where possible. -->

   <axsl:param name="archiveDirParameter"/>
   <axsl:param name="archiveNameParameter"/>
   <axsl:param name="fileNameParameter"/>
   <axsl:param name="fileDirParameter"/>

<!--PHASES-->


<!--PROLOG-->


<!--KEYS-->


<!--DEFAULT RULES-->


<!--MODE: SCHEMATRON-FULL-PATH-->
<!--This mode can be used to generate an ugly though full XPath for locators-->

   <axsl:template match="*" mode="schematron-get-full-path">
      <axsl:apply-templates select="parent::*" mode="schematron-get-full-path"/>
      <axsl:text>/</axsl:text>
      <axsl:choose>
         <axsl:when test="namespace-uri()=''">
            <axsl:value-of select="name()"/>
            <axsl:variable name="p" select="1+    count(preceding-sibling::*[name()=name(current())])"/>
            <axsl:if test="$p&gt;1 or following-sibling::*[name()=name(current())]">[<axsl:value-of select="$p"/>]</axsl:if>
         </axsl:when>
         <axsl:otherwise>
            <axsl:text>*[local-name()='</axsl:text>
            <axsl:value-of select="local-name()"/>
            <axsl:text>' and namespace-uri()='</axsl:text>
            <axsl:value-of select="namespace-uri()"/>
            <axsl:text>']</axsl:text>
            <axsl:variable name="p" select="1+   count(preceding-sibling::*[local-name()=local-name(current())])"/>
            <axsl:if test="$p&gt;1 or following-sibling::*[local-name()=local-name(current())]">[<axsl:value-of select="$p"/>]</axsl:if>
         </axsl:otherwise>
      </axsl:choose>
   </axsl:template>
   <axsl:template match="@*" mode="schematron-get-full-path">
      <axsl:text>/</axsl:text>
      <axsl:choose>
         <axsl:when test="namespace-uri()=''">@<axsl:value-of select="name()"/>
         </axsl:when>
         <axsl:otherwise>
            <axsl:text>@*[local-name()='</axsl:text>
            <axsl:value-of select="local-name()"/>
            <axsl:text>' and namespace-uri()='</axsl:text>
            <axsl:value-of select="namespace-uri()"/>
            <axsl:text>']</axsl:text>
         </axsl:otherwise>
      </axsl:choose>
   </axsl:template>

<!--MODE: SCHEMATRON-FULL-PATH-2-->
<!--This mode can be used to generate prefixed XPath for humans-->

   <axsl:template match="node() | @*" mode="schematron-get-full-path-2">
      <axsl:for-each select="ancestor-or-self::*">
         <axsl:text>/</axsl:text>
         <axsl:value-of select="name(.)"/>
         <axsl:if test="preceding-sibling::*[name(.)=name(current())]">
            <axsl:text>[</axsl:text>
            <axsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/>
            <axsl:text>]</axsl:text>
         </axsl:if>
      </axsl:for-each>
      <axsl:if test="not(self::*)">
         <axsl:text/>/@<axsl:value-of select="name(.)"/>
      </axsl:if>
   </axsl:template>

<!--MODE: GENERATE-ID-FROM-PATH -->

   <axsl:template match="/" mode="generate-id-from-path"/>
   <axsl:template match="text()" mode="generate-id-from-path">
      <axsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <axsl:value-of select="concat('.text-', 1+count(preceding-sibling::text()), '-')"/>
   </axsl:template>
   <axsl:template match="comment()" mode="generate-id-from-path">
      <axsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <axsl:value-of select="concat('.comment-', 1+count(preceding-sibling::comment()), '-')"/>
   </axsl:template>
   <axsl:template match="processing-instruction()" mode="generate-id-from-path">
      <axsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <axsl:value-of select="concat('.processing-instruction-', 1+count(preceding-sibling::processing-instruction()), '-')"/>
   </axsl:template>
   <axsl:template match="@*" mode="generate-id-from-path">
      <axsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <axsl:value-of select="concat('.@', name())"/>
   </axsl:template>
   <axsl:template match="*" mode="generate-id-from-path" priority="-0.5">
      <axsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <axsl:text>.</axsl:text>
      <axsl:value-of select="concat('.',name(),'-',1+count(preceding-sibling::*[name()=name(current())]),'-')"/>
   </axsl:template><!--MODE: SCHEMATRON-FULL-PATH-3-->
<!--This mode can be used to generate prefixed XPath for humans 
	(Top-level element has index)-->

   <axsl:template match="node() | @*" mode="schematron-get-full-path-3">
      <axsl:for-each select="ancestor-or-self::*">
         <axsl:text>/</axsl:text>
         <axsl:value-of select="name(.)"/>
         <axsl:if test="parent::*">
            <axsl:text>[</axsl:text>
            <axsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/>
            <axsl:text>]</axsl:text>
         </axsl:if>
      </axsl:for-each>
      <axsl:if test="not(self::*)">
         <axsl:text/>/@<axsl:value-of select="name(.)"/>
      </axsl:if>
   </axsl:template>

<!--MODE: GENERATE-ID-2 -->

   <axsl:template match="/" mode="generate-id-2">U</axsl:template>
   <axsl:template match="*" mode="generate-id-2" priority="2">
      <axsl:text>U</axsl:text>
      <axsl:number level="multiple" count="*"/>
   </axsl:template>
   <axsl:template match="node()" mode="generate-id-2">
      <axsl:text>U.</axsl:text>
      <axsl:number level="multiple" count="*"/>
      <axsl:text>n</axsl:text>
      <axsl:number count="node()"/>
   </axsl:template>
   <axsl:template match="@*" mode="generate-id-2">
      <axsl:text>U.</axsl:text>
      <axsl:number level="multiple" count="*"/>
      <axsl:text>_</axsl:text>
      <axsl:value-of select="string-length(local-name(.))"/>
      <axsl:text>_</axsl:text>
      <axsl:value-of select="translate(name(),':','.')"/>
   </axsl:template><!--Strip characters-->
   <axsl:template match="text()" priority="-1"/>

<!--SCHEMA METADATA-->

   <axsl:template match="/"><!--Root node processing collects all assertions-->
      <axsl:variable name="result">
         <axsl:apply-templates select="/" mode="M4"/>
      </axsl:variable>
      <axsl:if test="normalize-space(string($result))">
         <axsl:message terminate="yes">
            <axsl:value-of select="string($result)" disable-output-escaping="yes"/>
         </axsl:message>
      </axsl:if>
   </axsl:template>

<!--SCHEMATRON PATTERNS-->


<!--PATTERN UBL-QualifiedDataTypes-2.0-->


	<!--RULE -->

   <axsl:template match="@currencyID" priority="1021" mode="M4">

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="( false() or ( ( not(../@currencyCodeListVersionID!='2001') ) and contains('AEDAFNALLAMDANGAOAARSAUDAWGAZMBAMBBDBDTBGNBHDBIFBMDBNDBOBBRLBSDBTNBWPBYRBZDCADCDFCHFCLPCNYCOPCRCCUPCVECYPCZKDJFDKKDOPDZDEEKEGPERNETBEURFJDFKPGBPGELGHCGIPGMDGNFGTQGYDHKDHNLHRKHTGHUFIDRILSINRIQDIRRISKJMDJODJPYKESKGSKHRKMFKPWKRWKWDKYDKZTLAKLBPLKRLRDLSLLTLLVLLYDMADMDLMGFMKDMMKMNTMOPMROMTLMURMVRMWKMXNMYRMZMNADNGNNIONOKNPRNZDOMRPABPENPGKPHPPKRPLNPYGQARROLRUBRWFSARSBDSCRSDDSEKSGDSHPSITSKKSLLSOSSRGSTDSVCSYPSZLTHBTJSTMMTNDTOPTRLTTDTWDTZSUAHUGXUSDUYUUZSVEBVNDVUVWSTXAFXAGXAUXCDXDRXOFXPDXPFXPTYERYUMZARZMKZWD',concat('',.,'')) ) ) "/>
         <axsl:otherwise>Value supplied '<axsl:text/>
            <axsl:value-of select="."/>
            <axsl:text/>' is unacceptable for constraints identified by 'Currency' in the context '@currencyID'<axsl:text>: </axsl:text>
            <axsl:apply-templates select="." mode="schematron-get-full-path-3"/>
            <axsl:text xml:space="preserve">
</axsl:text></axsl:otherwise>
      </axsl:choose>
<!--       <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M4"/> -->
   </axsl:template>

	<!--RULE -->

   <axsl:template match="cbc:AllowanceChargeReasonCode" priority="1020" mode="M4">

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="( false() or ( ( not(@listName!='Adjustment Reason Description') ) and ( not(@listID!='UN/ECE 4465') ) and ( not(@listVersionID!='D03A') ) and ( not(@listSchemeURI!='urn:oasis:names:specification:ubl:codelist:gc:AllowanceChargeReasonCode') ) and ( not(@listURI!='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/AllowanceChargeReasonCode-2.0.gc') ) and ( not(@listAgencyName!='United Nations Economic Commission for Europe') ) and ( not(@listAgencyID!='6') ) and contains('1234567891011121314151617181920212223242526272829303132333435363738394041424344454647484950515253545556575859606162636465666768697071727374757677787980818283848586878889ZZZ',concat('',.,'')) ) ) "/>
         <axsl:otherwise>Value supplied '<axsl:text/>
            <axsl:value-of select="."/>
            <axsl:text/>' is unacceptable for constraints identified by 'AllowanceChargeReason' in the context 'cbc:AllowanceChargeReasonCode'<axsl:text>: </axsl:text>
            <axsl:apply-templates select="." mode="schematron-get-full-path-3"/>
            <axsl:text xml:space="preserve">
</axsl:text></axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M4"/>
   </axsl:template>

	<!--RULE -->

   <axsl:template match="cbc:ChannelCode" priority="1019" mode="M4">

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="( false() or ( ( not(@listName!='Communication Address Code Qualifier') ) and ( not(@listID!='UN/ECE 3155') ) and ( not(@listVersionID!='D03A') ) and ( not(@listSchemeURI!='urn:oasis:names:specification:ubl:codelist:gc:ChannelCode') ) and ( not(@listURI!='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/ChannelCode-2.0.gc') ) and ( not(@listAgencyName!='United Nations Economic Commission for Europe') ) and ( not(@listAgencyID!='6') ) and contains('AAABACADAEAFAGAHAIAJAKALAMANAOAPCAEIEMEXFTFXGMIEIMMAPBPSSWTETGTLTMTTTXXFXGXHXIXJ',concat('',.,'')) ) ) "/>
         <axsl:otherwise>Value supplied '<axsl:text/>
            <axsl:value-of select="."/>
            <axsl:text/>' is unacceptable for constraints identified by 'Channel' in the context 'cbc:ChannelCode'<axsl:text>: </axsl:text>
            <axsl:apply-templates select="." mode="schematron-get-full-path-3"/>
            <axsl:text xml:space="preserve">
</axsl:text></axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M4"/>
   </axsl:template>

	<!--RULE -->

   <axsl:template match="cbc:CardChipCode" priority="1018" mode="M4">

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="( false() or ( ( not(@listName!='Chip') ) and ( not(@listID!='') ) and ( not(@listVersionID!='2.0') ) and ( not(@listSchemeURI!='urn:oasis:names:specification:ubl:codelist:gc:ChipCode') ) and ( not(@listURI!='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/ChipCode-2.0.gc') ) and ( not(@listAgencyName!='OASIS Universal Business Language') ) and ( not(@listAgencyID!='UBL') ) and contains('ChipMagneticStripe',concat('',.,'')) ) ) "/>
         <axsl:otherwise>Value supplied '<axsl:text/>
            <axsl:value-of select="."/>
            <axsl:text/>' is unacceptable for constraints identified by 'Chip' in the context 'cbc:CardChipCode'<axsl:text>: </axsl:text>
            <axsl:apply-templates select="." mode="schematron-get-full-path-3"/>
            <axsl:text xml:space="preserve">
</axsl:text></axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M4"/>
   </axsl:template>

	<!--RULE -->

   <axsl:template match="cbc:IdentificationCode" priority="1017" mode="M4">

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="( false() or (contains('AFALDZASADAOAIAQAGARAMAWAUATAZBSBHBDBBBYBEBZBJBMBTBOBABWBVBRIOBNBGBFBIKHCMCACVKYCFTDCLCNCXCCCOKMCGCKCRCIHRCUCYCZDKDJDMDOTPECEGSVGQEREEETFKFOFJFIFRFXGFPFTFGAGMGEDEGHGIGRGLGDGPGUGTGNGWGYHTHMHNHKHUISINIDIRIQIEILITJMJPJOKZKEKIKPKRKWKGLALVLBLSLRLYLILTLUMOMGMWMYMVMLMTMHMQMRMUYTMXFMMDMCMNMSMAMZMMNANRNPANNLNCNZNINENGNUNFMPNOOMPKPWPAPGPYPEPHPNPLPTPRQARERORURWSHKNLCPMVCWSSMSASNSCSLSGSKSISBSOZAGSESLKSDSRSJSZSECHSYSTTWTJTZTHMKTGTKTOTTTNTRTMTCTVUGUAAEGBUMUSUYUZVUVAVEVNVGVIWFEHYEYUZRZMZW',concat('',.,'')) ) ) "/>
         <axsl:otherwise>Value supplied '<axsl:text/>
            <axsl:value-of select="."/>
            <axsl:text/>' is unacceptable for constraints identified by 'CountryIdentification' in the context 'cbc:IdentificationCode'<axsl:text>: </axsl:text>
            <axsl:apply-templates select="." mode="schematron-get-full-path-3"/>
            <axsl:text xml:space="preserve">
</axsl:text></axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M4"/>
   </axsl:template>

	<!--RULE -->

   <axsl:template match="cbc:DocumentCurrencyCode |                          cbc:TaxCurrencyCode |                          cbc:PricingCurrencyCode |                          cbc:PaymentCurrencyCode |                          cbc:PaymentAlternativeCurrencyCode |                          cbc:RequestedInvoiceCurrencyCode |                          cbc:SourceCurrencyCode |                          cbc:TargetCurrencyCode |                          cbc:CurrencyCode" priority="1016" mode="M4">

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="( false() or ( ( not(@listName!='Currency') ) and ( not(@listID!='ISO 4217 Alpha') ) and ( not(@listVersionID!='2001') ) and ( not(@listSchemeURI!='urn:un:unece:uncefact:codelist:specification:54217') ) and ( not(@listURI!='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/cefact/CurrencyCode-2.0.gc') ) and ( not(@listAgencyName!='United Nations Economic Commission for Europe') ) and ( not(@listAgencyID!='6') ) and contains('AEDAFNALLAMDANGAOAARSAUDAWGAZMBAMBBDBDTBGNBHDBIFBMDBNDBOBBRLBSDBTNBWPBYRBZDCADCDFCHFCLPCNYCOPCRCCUPCVECYPCZKDJFDKKDOPDZDEEKEGPERNETBEURFJDFKPGBPGELGHCGIPGMDGNFGTQGYDHKDHNLHRKHTGHUFIDRILSINRIQDIRRISKJMDJODJPYKESKGSKHRKMFKPWKRWKWDKYDKZTLAKLBPLKRLRDLSLLTLLVLLYDMADMDLMGFMKDMMKMNTMOPMROMTLMURMVRMWKMXNMYRMZMNADNGNNIONOKNPRNZDOMRPABPENPGKPHPPKRPLNPYGQARROLRUBRWFSARSBDSCRSDDSEKSGDSHPSITSKKSLLSOSSRGSTDSVCSYPSZLTHBTJSTMMTNDTOPTRLTTDTWDTZSUAHUGXUSDUYUUZSVEBVNDVUVWSTXAFXAGXAUXCDXDRXOFXPDXPFXPTYERYUMZARZMKZWD',concat('',.,'')) ) ) "/>
         <axsl:otherwise>Value supplied '<axsl:text/>
            <axsl:value-of select="."/>
            <axsl:text/>' is unacceptable for constraints identified by 'Currency' in the context 'cbc:DocumentCurrencyCode |                          cbc:TaxCurrencyCode |                          cbc:PricingCurrencyCode |                          cbc:PaymentCurrencyCode |                          cbc:PaymentAlternativeCurrencyCode |                          cbc:RequestedInvoiceCurrencyCode |                          cbc:SourceCurrencyCode |                          cbc:TargetCurrencyCode |                          cbc:CurrencyCode'<axsl:text>: </axsl:text>
            <axsl:apply-templates select="." mode="schematron-get-full-path-3"/>
            <axsl:text xml:space="preserve">
</axsl:text></axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M4"/>
   </axsl:template>

	<!--RULE -->

   <axsl:template match="cbc:DocumentStatusCode" priority="1015" mode="M4">

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="( false() or ( ( not(@listName!='Document Status') ) and ( not(@listID!='') ) and ( not(@listVersionID!='2.0') ) and ( not(@listSchemeURI!='urn:oasis:names:specification:ubl:codelist:gc:DocumentStatusCode') ) and ( not(@listURI!='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/DocumentStatusCode-2.0.gc') ) and ( not(@listAgencyName!='OASIS Universal Business Language') ) and ( not(@listAgencyID!='UBL') ) and contains('CancelledDisputedNoStatusRevised',concat('',.,'')) ) ) "/>
         <axsl:otherwise>Value supplied '<axsl:text/>
            <axsl:value-of select="."/>
            <axsl:text/>' is unacceptable for constraints identified by 'DocumentStatus' in the context 'cbc:DocumentStatusCode'<axsl:text>: </axsl:text>
            <axsl:apply-templates select="." mode="schematron-get-full-path-3"/>
            <axsl:text xml:space="preserve">
</axsl:text></axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M4"/>
   </axsl:template>

	<!--RULE -->

   <axsl:template match="cbc:LatitudeDirectionCode" priority="1014" mode="M4">

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="( false() or ( ( not(@listName!='Latitude Direction') ) and ( not(@listID!='') ) and ( not(@listVersionID!='2.0') ) and ( not(@listSchemeURI!='urn:oasis:names:specification:ubl:codelist:gc:LatitudeDirectionCode') ) and ( not(@listURI!='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/LatitudeDirectionCode-2.0.gc') ) and ( not(@listAgencyName!='OASIS Universal Business Language') ) and ( not(@listAgencyID!='UBL') ) and contains('NorthSouth',concat('',.,'')) ) ) "/>
         <axsl:otherwise>Value supplied '<axsl:text/>
            <axsl:value-of select="."/>
            <axsl:text/>' is unacceptable for constraints identified by 'LatitudeDirection' in the context 'cbc:LatitudeDirectionCode'<axsl:text>: </axsl:text>
            <axsl:apply-templates select="." mode="schematron-get-full-path-3"/>
            <axsl:text xml:space="preserve">
</axsl:text></axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M4"/>
   </axsl:template>

	<!--RULE -->

   <axsl:template match="cbc:LineStatusCode" priority="1013" mode="M4">

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="( false() or ( ( not(@listName!='Line Status') ) and ( not(@listID!='') ) and ( not(@listVersionID!='2.0') ) and ( not(@listSchemeURI!='urn:oasis:names:specification:ubl:codelist:gc:LineStatusCode') ) and ( not(@listURI!='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/LineStatusCode-2.0.gc') ) and ( not(@listAgencyName!='OASIS Universal Business Language') ) and ( not(@listAgencyID!='UBL') ) and contains('AddedCancelledDisputedNoStatusRevised',concat('',.,'')) ) ) "/>
         <axsl:otherwise>Value supplied '<axsl:text/>
            <axsl:value-of select="."/>
            <axsl:text/>' is unacceptable for constraints identified by 'LineStatus' in the context 'cbc:LineStatusCode'<axsl:text>: </axsl:text>
            <axsl:apply-templates select="." mode="schematron-get-full-path-3"/>
            <axsl:text xml:space="preserve">
</axsl:text></axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M4"/>
   </axsl:template>

	<!--RULE -->

   <axsl:template match="cbc:LongitudeDirectionCode" priority="1012" mode="M4">

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="( false() or ( ( not(@listName!='Longitude Direction') ) and ( not(@listID!='') ) and ( not(@listVersionID!='2.0') ) and ( not(@listSchemeURI!='urn:oasis:names:specification:ubl:codelist:gc:LongitudeDirectionCode') ) and ( not(@listURI!='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/LongitudeDirectionCode-2.0.gc') ) and ( not(@listAgencyName!='OASIS Universal Business Language') ) and ( not(@listAgencyID!='UBL') ) and contains('EastWest',concat('',.,'')) ) ) "/>
         <axsl:otherwise>Value supplied '<axsl:text/>
            <axsl:value-of select="."/>
            <axsl:text/>' is unacceptable for constraints identified by 'LongitudeDirection' in the context 'cbc:LongitudeDirectionCode'<axsl:text>: </axsl:text>
            <axsl:apply-templates select="." mode="schematron-get-full-path-3"/>
            <axsl:text xml:space="preserve">
</axsl:text></axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M4"/>
   </axsl:template>

	<!--RULE -->

   <axsl:template match="cbc:MathematicOperatorCode" priority="1011" mode="M4">

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="( false() or ( ( not(@listName!='Operator') ) and ( not(@listID!='') ) and ( not(@listVersionID!='2.0') ) and ( not(@listSchemeURI!='urn:oasis:names:specification:ubl:codelist:gc:OperatorCode') ) and ( not(@listURI!='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/OperatorCode-2.0.gc') ) and ( not(@listAgencyName!='OASIS Universal Business Language') ) and ( not(@listAgencyID!='UBL') ) and contains('DivideMultiply',concat('',.,'')) ) ) "/>
         <axsl:otherwise>Value supplied '<axsl:text/>
            <axsl:value-of select="."/>
            <axsl:text/>' is unacceptable for constraints identified by 'Operator' in the context 'cbc:MathematicOperatorCode'<axsl:text>: </axsl:text>
            <axsl:apply-templates select="." mode="schematron-get-full-path-3"/>
            <axsl:text xml:space="preserve">
</axsl:text></axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M4"/>
   </axsl:template>

	<!--RULE -->

   <axsl:template match="cbc:PackagingTypeCode" priority="1010" mode="M4">

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="( false() or ( ( not(@listName!='Packaging Type') ) and ( not(@listID!='UN/ECE rec 21') ) and ( not(@listVersionID!='Revision 5') ) and ( not(@listSchemeURI!='urn:oasis:names:specification:ubl:codelist:gc:PackagingTypeCode') ) and ( not(@listURI!='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/PackagingTypeCode-2.0.gc') ) and ( not(@listAgencyName!='United Nations Economic Commission for Europe') ) and ( not(@listAgencyID!='6') ) and contains('1A1B1D1G1W2C3A3H434A4B4C4D4F4G4H5H5L5M6H6PAAABACADAEAFAGAHAIAJAMAPATAVBABBBCBDBEBFBGBHBIBJBKBLBMBNBOBOBPBQBQBRBSBTBUBVBVBWBXBYBZCACBCCCDCECFCGCHCICJCKCLCMCNCOCPCQCRCSCTCUCVCWCXCYCZDADBDCDGDHDIDJDKDLDMDNDPDRDSDTDUDVDWDXDYECEDEEEFEGEHEIENFCFDFIFLFOFPFRFTFWFXGBGIGRGUGZHAHBHCHGHRIAIBICIDIEIFIGIHIKILINIZJCJGJRJTJYKGLGLTLVLZMBMCMRMSMTMWMXNANENFNGNSNTNUNVPAPBPCPDPEPFPGPHPIPJPKPLPNPOPRPTPUPVPXPYPZQAQBQCQDQFQGQHQJQKQLQMQNQPQQQRQSRDRGRJRKRLRORTRZSASBSCSDSESHSISKSLSMSOSPSSSTSUSVSWSXSYSZTBTCTDTITKTLTNTOTRTSTUTVTYTZUCVAVGVIVKVLVOVPVQVRVYWAWBWCWDWFWGWHWJWKWLWMWNWPWQWRWSWTWUWVWWWXWYWZXAXBXCXDXFXGXHXJXKYAYBYCYDYFYGYHYJYKYLYMYNYPYQYRYSYTYVYWYXYYYZZAZBZCZDZFZGZHZJZKZLZMZNZPZQZRZSZTZUZVZWZXZYZZ',concat('',.,'')) ) ) "/>
         <axsl:otherwise>Value supplied '<axsl:text/>
            <axsl:value-of select="."/>
            <axsl:text/>' is unacceptable for constraints identified by 'PackagingType' in the context 'cbc:PackagingTypeCode'<axsl:text>: </axsl:text>
            <axsl:apply-templates select="." mode="schematron-get-full-path-3"/>
            <axsl:text xml:space="preserve">
</axsl:text></axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M4"/>
   </axsl:template>

	<!--RULE -->

   <axsl:template match="cbc:PaymentMeansCode" priority="1009" mode="M4">

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="( false() or ( ( not(@listName!='Payment Means') ) and ( not(@listID!='UN/ECE 4461') ) and ( not(@listVersionID!='D03A') ) and ( not(@listSchemeURI!='urn:oasis:names:specification:ubl:codelist:gc:PaymentMeansCode') ) and ( not(@listURI!='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/PaymentMeansCode-2.0.gc') ) and ( not(@listAgencyName!='United Nations Economic Commission for Europe') ) and ( not(@listAgencyID!='6') ) and contains('1234567891011121314151617181920212223242526272829303132333435363738394041424344454647484950515253606162636465666770747576777891929394959697ZZZ',concat('',.,'')) ) ) "/>
         <axsl:otherwise>Value supplied '<axsl:text/>
            <axsl:value-of select="."/>
            <axsl:text/>' is unacceptable for constraints identified by 'PaymentMeans' in the context 'cbc:PaymentMeansCode'<axsl:text>: </axsl:text>
            <axsl:apply-templates select="." mode="schematron-get-full-path-3"/>
            <axsl:text xml:space="preserve">
</axsl:text></axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M4"/>
   </axsl:template>

	<!--RULE -->

   <axsl:template match="cbc:SubstitutionStatusCode" priority="1008" mode="M4">

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="( false() or ( ( not(@listName!='Substitution Status') ) and ( not(@listID!='') ) and ( not(@listVersionID!='2.0') ) and ( not(@listSchemeURI!='urn:oasis:names:specification:ubl:codelist:gc:SubstitutionStatusCode') ) and ( not(@listURI!='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/SubstitutionStatusCode-2.0.gc') ) and ( not(@listAgencyName!='OASIS Universal Business Language') ) and ( not(@listAgencyID!='UBL') ) and contains('OriginalSubstitution',concat('',.,'')) ) ) "/>
         <axsl:otherwise>Value supplied '<axsl:text/>
            <axsl:value-of select="."/>
            <axsl:text/>' is unacceptable for constraints identified by 'SubstitutionStatus' in the context 'cbc:SubstitutionStatusCode'<axsl:text>: </axsl:text>
            <axsl:apply-templates select="." mode="schematron-get-full-path-3"/>
            <axsl:text xml:space="preserve">
</axsl:text></axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M4"/>
   </axsl:template>

	<!--RULE -->

   <axsl:template match="cbc:TransportationStatusCode" priority="1007" mode="M4">

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="( false() or ( ( not(@listName!='Transportation Status') ) and ( not(@listID!='UN/ECE rec 24') ) and ( not(@listVersionID!='Third Revision') ) and ( not(@listSchemeURI!='urn:oasis:names:specification:ubl:codelist:gc:TransportationStatusCode') ) and ( not(@listURI!='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/TransportationStatusCode-2.0.gc') ) and ( not(@listAgencyName!='United Nations Economic Commission for Europe') ) and ( not(@listAgencyID!='6') ) and contains('12345678910111213141516171819202122232425262728293031323334353637383940414445464748495051535457585960616263646566676869707172737475767778798081828384858687888990919293949596979899100101102103104105106107108109110111112113114115116117118119120121123124125126127128129130131132133134135136137138139140141142143144145146147148149150151152153154155156157158159161162163164165166167168169170171172174175176177178179180181182183184185186187188189190191192193194195196197198199200201202203204205206207208209210211212213214215216218219220222224225227228229231232233234235236238239240241242243247248250251253254255256258260265266267269270271272273274275276277278279280281282283284285286287288291292295297298299300301302306307308309310311312313314315316317318319320321322323324325326327328329330331332333334335336337338339340341342343344345346347348349350351352353354355356357358+359+360+361+362+363',concat('',.,'')) ) ) "/>
         <axsl:otherwise>Value supplied '<axsl:text/>
            <axsl:value-of select="."/>
            <axsl:text/>' is unacceptable for constraints identified by 'TransportationStatus' in the context 'cbc:TransportationStatusCode'<axsl:text>: </axsl:text>
            <axsl:apply-templates select="." mode="schematron-get-full-path-3"/>
            <axsl:text xml:space="preserve">
</axsl:text></axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M4"/>
   </axsl:template>

	<!--RULE -->

   <axsl:template match="cbc:TransportEquipmentTypeCode" priority="1006" mode="M4">

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="( false() or ( ( not(@listName!='Equipment type code qualifier') ) and ( not(@listID!='UN/ECE 8053') ) and ( not(@listVersionID!='D.05B') ) and ( not(@listSchemeURI!='urn:oasis:names:specification:ubl:codelist:gc:TransportEquipmentTypeCode') ) and ( not(@listURI!='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/TransportEquipmentTypeCode-2.0.gc') ) and ( not(@listAgencyName!='United Nations Economic Commission for Europe') ) and ( not(@listAgencyID!='6') ) and contains('AAABADAEAGAHAIAJAKALAMANAOAPAQATBLBPNBPOBPPBPQBPRBPSBPTBPUBPVBPWBPXBPYBRBXCHCNDPAEFPEYPFPNFPRILLARLUMPAPAPBPPFPPLPPAPSTRFRGRGFRORRSPPSTRSWTETPTSTSUUL',concat('',.,'')) ) ) "/>
         <axsl:otherwise>Value supplied '<axsl:text/>
            <axsl:value-of select="."/>
            <axsl:text/>' is unacceptable for constraints identified by 'TransportEquipmentType' in the context 'cbc:TransportEquipmentTypeCode'<axsl:text>: </axsl:text>
            <axsl:apply-templates select="." mode="schematron-get-full-path-3"/>
            <axsl:text xml:space="preserve">
</axsl:text></axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M4"/>
   </axsl:template>

	<!--RULE -->

   <axsl:template match="cbc:TransportModeCode" priority="1005" mode="M4">

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="( false() or ( ( not(@listName!='Transport Mode') ) and ( not(@listID!='UN/ECE rec 16') ) and ( not(@listVersionID!='Presented by the CDWG') ) and ( not(@listSchemeURI!='urn:oasis:names:specification:ubl:codelist:gc:TransportModeCode') ) and ( not(@listURI!='http://docs.oasis-open.org/ubl/os-UBL-2.0-update/cl/gc/default/TransportModeCode-2.0.gc') ) and ( not(@listAgencyName!='United Nations Economic Commission for Europe') ) and ( not(@listAgencyID!='6') ) and contains('0123456789',concat('',.,'')) ) ) "/>
         <axsl:otherwise>Value supplied '<axsl:text/>
            <axsl:value-of select="."/>
            <axsl:text/>' is unacceptable for constraints identified by 'TransportMode' in the context 'cbc:TransportModeCode'<axsl:text>: </axsl:text>
            <axsl:apply-templates select="." mode="schematron-get-full-path-3"/>
            <axsl:text xml:space="preserve">
</axsl:text></axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M4"/>
   </axsl:template>

	<!--RULE -->

   <axsl:template match="cbc:InvoiceTypeCode" priority="1004" mode="M4">

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="( false() or (contains('DCVDVCP',concat('',.,'')) ) ) "/>
         <axsl:otherwise>Value supplied '<axsl:text/>
            <axsl:value-of select="."/>
            <axsl:text/>' is unacceptable for constraints identified by 'InvoiceTypeCode' in the context 'cbc:InvoiceTypeCode'<axsl:text>: </axsl:text>
            <axsl:apply-templates select="." mode="schematron-get-full-path-3"/>
            <axsl:text xml:space="preserve">
</axsl:text></axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M4"/>
   </axsl:template>

	<!--RULE -->

   <axsl:template match="cbc:ActionCode" priority="1003" mode="M4">

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="( false() or ( ( not(@listName!='ActieCode') ) and ( not(@listID!='') ) and ( not(@listVersionID!='1.4') ) and ( not(@listSchemeURI!='') ) and ( not(@listURI!='http://www.nltaxonomie.nl/ubl/2.0/NL/1.4/cl/gc/NL-ActionCode-1.4.gc') ) and ( not(@listAgencyName!='Logius Gegevensbeheer NL-Overheid') ) and ( not(@listAgencyID!='88') ) and contains('CV',concat('',.,'')) ) ) "/>
         <axsl:otherwise>Value supplied '<axsl:text/>
            <axsl:value-of select="."/>
            <axsl:text/>' is unacceptable for constraints identified by 'ActionCode' in the context 'cbc:ActionCode'<axsl:text>: </axsl:text>
            <axsl:apply-templates select="." mode="schematron-get-full-path-3"/>
            <axsl:text xml:space="preserve">
</axsl:text></axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M4"/>
   </axsl:template>

	<!--RULE -->

   <axsl:template match="cac:DeliveryTerms/cbc:ID" priority="1002" mode="M4">

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="( false() or ( ( not(@listName!='Leveringsvoorwaarden') ) and ( not(@schemeID!='NL-1002') ) and ( not(@listVersionID!='1.6') ) and ( not(@listSchemeURI!='urn:digi-inkoop:ubl:2.0:NL:1.6:gc:DeliveryTermsCode') ) and ( not(@listURI!='http://www.nltaxonomie.nl/ubl/2.0/NL/1.6/cl/gc/DeliveryTermsCode.gc') ) and ( not(@listAgencyName!='Logius Gegevensbeheer NL-Overheid') ) and ( not(@listAgencyID!='88') ) and contains('EXWFCAFASFOBFOTFOPFORCFRCIFCPTCIPDAFDESDEQDDUDDP',concat('',.,'')) ) ) "/>
         <axsl:otherwise>Value supplied '<axsl:text/>
            <axsl:value-of select="."/>
            <axsl:text/>' is unacceptable for constraints identified by 'DeliveryTermsCode' in the context 'cac:DeliveryTerms/cbc:ID'<axsl:text>: </axsl:text>
            <axsl:apply-templates select="." mode="schematron-get-full-path-3"/>
            <axsl:text xml:space="preserve">
</axsl:text></axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M4"/>
   </axsl:template>

	<!--RULE -->

   <axsl:template match="nl-cbc:NegotiationStyle" priority="1001" mode="M4">

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="( false() or ( ( not(@listName!='Onderhandelinsstijl') ) and ( not(@listID!='NL-1003') ) and ( not(@listVersionID!='1.6') ) and ( not(@listSchemeURI!='urn:digi-inkoop:ubl:2.0:NL:1.6:gc:NegotiationStyleCode') ) and ( not(@listURI!='http://www.nltaxonomie.nl/ubl/2.0/NL/1.6/cl/gc/NegotiationStyleCode.gc') ) and ( not(@listAgencyName!='Logius Gegevensbeheer NL-Overheid') ) and ( not(@listAgencyID!='88') ) and contains('ES',concat('',.,'')) ) ) "/>
         <axsl:otherwise>Value supplied '<axsl:text/>
            <axsl:value-of select="."/>
            <axsl:text/>' is unacceptable for constraints identified by 'NegotiationStyleCode' in the context 'nl-cbc:NegotiationStyle'<axsl:text>: </axsl:text>
            <axsl:apply-templates select="." mode="schematron-get-full-path-3"/>
            <axsl:text xml:space="preserve">
</axsl:text></axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M4"/>
   </axsl:template>

	<!--RULE -->

   <axsl:template match="cac:Response/cbc:ResponseCode" priority="1000" mode="M4">

		<!--ASSERT -->

      <axsl:choose>
         <axsl:when test="( false() or ( ( not(@listName!='ResponseCode') ) and ( not(@listID!='') ) and ( not(@listVersionID!='1.4') ) and ( not(@listSchemeURI!='') ) and ( not(@listURI!='http://www.nltaxonomie.nl/ubl/2.0/NL/1.4/cl/gc/NL-ResponseCode-1.4.gc') ) and ( not(@listAgencyName!='Logius Gegevensbeheer NL-Overheid') ) and ( not(@listAgencyID!='88') ) and contains('OKNOK',concat('',.,'')) ) ) "/>
         <axsl:otherwise>Value supplied '<axsl:text/>
            <axsl:value-of select="."/>
            <axsl:text/>' is unacceptable for constraints identified by 'ResponseCode' in the context 'cac:Response/cbc:ResponseCode'<axsl:text>: </axsl:text>
            <axsl:apply-templates select="." mode="schematron-get-full-path-3"/>
            <axsl:text xml:space="preserve">
</axsl:text></axsl:otherwise>
      </axsl:choose>
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M4"/>
   </axsl:template>
   <axsl:template match="text()" priority="-1" mode="M4"/>
   <axsl:template match="@*|node()" priority="-2" mode="M4">
      <axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M4"/>
   </axsl:template>
</axsl:stylesheet>