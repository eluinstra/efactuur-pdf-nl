/*
 * Copyright 2011 Clockwork
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package nl.clockwork.efactuur;


import java.util.HashMap;
import java.util.Map;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.experimental.FieldDefaults;

public class Constants
{
	public static final Map<String, nl.clockwork.efactuur.Constants.MessageType> rootTagToMessageType =
			new HashMap<String, nl.clockwork.efactuur.Constants.MessageType>()
			{
				private static final long serialVersionUID = 1L;

				{
					put("ApplicationResponse", nl.clockwork.efactuur.Constants.MessageType.APPLICATION_RESPONSE);
					put("Commitment", nl.clockwork.efactuur.Constants.MessageType.COMMITMENT);
					put("DespatchAdvice", nl.clockwork.efactuur.Constants.MessageType.DESPATCH_ADVICE);
					put("HumanResource", nl.clockwork.efactuur.Constants.MessageType.HUMAN_RESOURCE);
					put("Invoice", nl.clockwork.efactuur.Constants.MessageType.INVOICE);
					put("Order", nl.clockwork.efactuur.Constants.MessageType.ORDER);
					put("OrderResponse", nl.clockwork.efactuur.Constants.MessageType.ORDER_RESPONSE);
					put("Quotation", nl.clockwork.efactuur.Constants.MessageType.QUOTATION);
					put("RequestForQuotation", nl.clockwork.efactuur.Constants.MessageType.REQUEST_FOR_QUOTATION);
					put("RequestForQuotationCancellation", nl.clockwork.efactuur.Constants.MessageType.REQUEST_FOR_QUOTATION_CANCELLATION);
					put("StaffingOrder", nl.clockwork.efactuur.Constants.MessageType.STAFFING_ORDER);
					put("TimeCard", nl.clockwork.efactuur.Constants.MessageType.TIME_CARD);
				}
			};

	public static final Map<BerichtSoort, MessageType> berichtSoortToMessageType = new HashMap<BerichtSoort, MessageType>()
	{
		private static final long serialVersionUID = 1L;

		{
			put(BerichtSoort.BUDGETCHECK_ANTWOORD_UBL, nl.clockwork.efactuur.Constants.MessageType.APPLICATION_RESPONSE);

			put(BerichtSoort.ADVANCED_SHIPPING_NOTICE_UBL, nl.clockwork.efactuur.Constants.MessageType.DESPATCH_ADVICE);

			put(BerichtSoort.OFFERTE_HRXML, nl.clockwork.efactuur.Constants.MessageType.HUMAN_RESOURCE);
			put(BerichtSoort.BESTELLING_BEVESTIGING_HRXML, nl.clockwork.efactuur.Constants.MessageType.HUMAN_RESOURCE);
			put(BerichtSoort.AFWIJZING_HRXML, nl.clockwork.efactuur.Constants.MessageType.HUMAN_RESOURCE);

			put(BerichtSoort.OFFERTE_AANVRAAG_HRXML, nl.clockwork.efactuur.Constants.MessageType.STAFFING_ORDER);
			put(BerichtSoort.BESTELLING_HRXML, nl.clockwork.efactuur.Constants.MessageType.STAFFING_ORDER);

			put(BerichtSoort.OFFERTE_AANVRAAG_UBL, nl.clockwork.efactuur.Constants.MessageType.REQUEST_FOR_QUOTATION);
			put(BerichtSoort.AFWIJZING_UBL, nl.clockwork.efactuur.Constants.MessageType.REQUEST_FOR_QUOTATION_CANCELLATION);

			put(BerichtSoort.OFFERTE_UBL, nl.clockwork.efactuur.Constants.MessageType.QUOTATION);

			put(BerichtSoort.BUDGETCHECK_VRAAG_UBL, nl.clockwork.efactuur.Constants.MessageType.COMMITMENT);
			put(BerichtSoort.BESTELLING_VERPLICHTING_UBL, nl.clockwork.efactuur.Constants.MessageType.COMMITMENT);

			put(BerichtSoort.BESTELLING_UBL, nl.clockwork.efactuur.Constants.MessageType.ORDER);
			put(BerichtSoort.BESTELLING_BEVESTIGING_UBL, nl.clockwork.efactuur.Constants.MessageType.ORDER_RESPONSE);

			put(BerichtSoort.VOORSTEL_FACTUUR_HRXML, nl.clockwork.efactuur.Constants.MessageType.INVOICE);
			put(BerichtSoort.VOORSTEL_FACTUUR_UBL, nl.clockwork.efactuur.Constants.MessageType.INVOICE);
			put(BerichtSoort.FACTUUR_HRXML, nl.clockwork.efactuur.Constants.MessageType.INVOICE);
			put(BerichtSoort.FACTUUR_AKKOORD_HRXML, nl.clockwork.efactuur.Constants.MessageType.INVOICE);
			put(BerichtSoort.FACTUUR_UBL, nl.clockwork.efactuur.Constants.MessageType.INVOICE);
			put(BerichtSoort.FACTUUR_AKKOORD_UBL, nl.clockwork.efactuur.Constants.MessageType.INVOICE);

			put(BerichtSoort.TIMECARD_HRXML, nl.clockwork.efactuur.Constants.MessageType.TIME_CARD);
		}
	};

	public static final Map<String, String> ublMajorVersionToSpecificVersion = new HashMap<String, String>()
	{
		private static final long serialVersionUID = 1L;

		{
			put("1.0", nl.clockwork.efactuur.Constants.MESSAGE_VERSION_UBL_1_1);
			put("1.1", nl.clockwork.efactuur.Constants.MESSAGE_VERSION_UBL_1_1);
			put("1.6", nl.clockwork.efactuur.Constants.MESSAGE_VERSION_UBL_1_6_3);
			put("1.7", nl.clockwork.efactuur.Constants.MESSAGE_VERSION_UBL_1_7);
			put("1.8", nl.clockwork.efactuur.Constants.MESSAGE_VERSION_UBL_1_8);
			put("1.9", nl.clockwork.efactuur.Constants.MESSAGE_VERSION_UBL_1_9);
			put("urn:cen.eu:en16931:2017#compliant#urn:fdc:nen.nl:nlcius:v1.0", nl.clockwork.efactuur.Constants.MESSAGE_VERSION_UBL_2_0);
		}
	};

	public static final Map<String, String> setuMajorVersionToSpecificVersion = new HashMap<String, String>()
	{
		private static final long serialVersionUID = 1L;

		{
			put("1.1", nl.clockwork.efactuur.Constants.MESSAGE_VERSION_SETU_1_1);
			put("1.6", nl.clockwork.efactuur.Constants.MESSAGE_VERSION_SETU_1_6_4);
			put("1.7", nl.clockwork.efactuur.Constants.MESSAGE_VERSION_SETU_1_7);
			put("1.8", nl.clockwork.efactuur.Constants.MESSAGE_VERSION_SETU_1_8_1);
			put("2.0", nl.clockwork.efactuur.Constants.MESSAGE_VERSION_SETU_2_0);
		}
	};

	public static final String MESSAGE_FORMAT_UBL = MessageFormat.UBL.name();
	public static final String MESSAGE_FORMAT_SETU = MessageFormat.SETU.name();

	public static final String MESSAGE_VERSION_UBL_1_1 = "1.1";
	public static final String MESSAGE_VERSION_UBL_1_6_2 = "1.6.2";
	public static final String MESSAGE_VERSION_UBL_1_6_3 = "1.6.3";
	public static final String MESSAGE_VERSION_UBL_1_7 = "1.7";
	public static final String MESSAGE_VERSION_UBL_1_8_beta2 = "1.8.beta2";
	public static final String MESSAGE_VERSION_UBL_1_8 = "1.8";
	public static final String MESSAGE_VERSION_UBL_1_9 = "1.9";
	public static final String MESSAGE_VERSION_UBL_2_0 = "2.0";

	public static final String MESSAGE_VERSION_SETU_1_1 = "1.1";
	public static final String MESSAGE_VERSION_SETU_1_6_4 = "1.6.4";
	public static final String MESSAGE_VERSION_SETU_1_7 = "1.7";
	public static final String MESSAGE_VERSION_SETU_1_8 = "1.8";
	public static final String MESSAGE_VERSION_SETU_1_8_1_beta01 = "1.8.1.beta01";
	public static final String MESSAGE_VERSION_SETU_1_8_1 = "1.8.1";
	public static final String MESSAGE_VERSION_SETU_2_0 = "2.0";

	public static final String MESSAGE_TYPE_INVOICE = MessageType.INVOICE.name();
	public static final String MESSAGE_TYPE_COMMITMENT = MessageType.COMMITMENT.name();
	public static final String MESSAGE_TYPE_QUOTATION = MessageType.QUOTATION.name();
	public static final String MESSAGE_TYPE_ORDER_RESPONSE = MessageType.ORDER_RESPONSE.name();
	public static final String MESSAGE_TYPE_DESPATCH_ADVICE = MessageType.DESPATCH_ADVICE.name();
	public static final String MESSAGE_TYPE_APPLICATION_RESPONSE = MessageType.APPLICATION_RESPONSE.name();
	public static final String MESSAGE_TYPE_REQUEST_FOR_QUOTATION = MessageType.REQUEST_FOR_QUOTATION.name();
	public static final String MESSAGE_TYPE_REQUEST_FOR_QUOTATION_CANCELLATION = MessageType.REQUEST_FOR_QUOTATION_CANCELLATION.name();
	public static final String MESSAGE_TYPE_ORDER = MessageType.ORDER.name();
	public static final String MESSAGE_TYPE_HUMAN_RESOURCE = MessageType.HUMAN_RESOURCE.name();
	public static final String MESSAGE_TYPE_TIME_CARD = MessageType.TIME_CARD.name();
	public static final String MESSAGE_TYPE_STAFFING_ORDER = MessageType.STAFFING_ORDER.name();

	// Efactureren
	public static final String AFLEVERBERICHT_BERICHTSOORT_EFACTUUR = "e-factuur";
	public static final String AFLEVERBERICHT_BERICHTSOORT_MFACTUUR = "m-factuur";
	public static final String AFLEVERBERICHT_BERICHTSOORT_EFACTUUR_UBL = "e-factuur-ubl";
	public static final String AFLEVERBERICHT_BERICHTSOORT_MFACTUUR_HRXML = "m-factuur-hrxml";

	// DigiInkoop : Stroom A
	public static final String AFLEVERBERICHT_BERICHTSOORT_BUDGETCHECK_VRAAG_UBL = "BUDGETCHECK-VRAAG-UBL";
	public static final String AFLEVERBERICHT_BERICHTSOORT_BUDGETCHECK_ANTWOORD_UBL = "BUDGETCHECK-ANTWOORD-UBL";
	public static final String AFLEVERBERICHT_BERICHTSOORT_BESTELLING_VERPLICHTING_UBL = "BESTELLING-VERPLICHTING-UBL";
	public static final String AFLEVERBERICHT_BERICHTSOORT_TIMECARD_HRXML = "TIMECARD-HRXML";
	public static final String AFLEVERBERICHT_BERICHTSOORT_FACTUUR_UBL = "FACTUUR-UBL";
	public static final String AFLEVERBERICHT_BERICHTSOORT_FACTUUR_AKKOORD_UBL = "FACTUUR-AKKOORD-UBL";
	public static final String AFLEVERBERICHT_BERICHTSOORT_FACTUUR_HRXML = "FACTUUR-HRXML";
	public static final String AFLEVERBERICHT_BERICHTSOORT_FACTUUR_AKKOORD_HRXML = "FACTUUR-AKKOORD-HRXML";

	@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
	@AllArgsConstructor
	@Getter
	public enum BerichtSoort
	{
		BUDGETCHECK_ANTWOORD_UBL("BUDGETCHECK-ANTWOORD-UBL"),
		BUDGETCHECK_VRAAG_UBL("BUDGETCHECK-VRAAG-UBL"),
		BESTELLING_VERPLICHTING_UBL("BESTELLING-VERPLICHTING-UBL"),
		TIMECARD_HRXML("TIMECARD-HRXML"),
		FACTUUR_UBL("FACTUUR-UBL"),
		FACTUUR_AKKOORD_UBL("FACTUUR-AKKOORD-UBL"),
		FACTUUR_HRXML("FACTUUR-HRXML"),
		FACTUUR_AKKOORD_HRXML("FACTUUR-AKKOORD-HRXML"),
		ADVANCED_SHIPPING_NOTICE_UBL("ADVANCED-SHIPPING-NOTICE-UBL"),
		OFFERTE_HRXML("OFFERTE-HRXML"),
		BESTELLING_BEVESTIGING_HRXML("BESTELLING-BEVESTIGING-HRXML"),
		VOORSTEL_FACTUUR_HRXML("VOORSTEL-FACTUUR-HRXML"),
		AFWIJZING_HRXML("AFWIJZING-HRXML"),
		VOORSTEL_FACTUUR_UBL("VOORSTEL-FACTUUR-UBL"),
		BESTELLING_UBL("BESTELLING-UBL"),
		BESTELLING_BEVESTIGING_UBL("BESTELLING-BEVESTIGING-UBL"),
		OFFERTE_AANVRAAG_HRXML("OFFERTE-AANVRAAG-HRXML"),
		BESTELLING_HRXML("BESTELLING-HRXML"),
		OFFERTE_UBL("OFFERTE-UBL"),
		OFFERTE_AANVRAAG_UBL("OFFERTE-AANVRAAG-UBL"),
		AFWIJZING_UBL("AFWIJZING-UBL"),
		E_FACTUUR("E-Factuur"),
		M_FACTUUR("M-Factuur"),
		E_FACTUUR_UBL("E-Factuur-UBL"),
		E_FACTUUR_HRXML("E-Factuur-HRXML");

		String value;

		public static final BerichtSoort getBerichtSoort(String value)
		{
			for (BerichtSoort berichtSoort : BerichtSoort.values())
				if (value.equals(berichtSoort.value))
					return berichtSoort;
			return null;
		}
	};

	@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
	@AllArgsConstructor
	@Getter
	public enum MessageType
	{
		INVOICE("Invoice"),
		COMMITMENT("Commitment"),
		QUOTATION("Quotation"),
		ORDER_RESPONSE("OrderResponse"),
		DESPATCH_ADVICE("DespatchAdvice"),
		APPLICATION_RESPONSE("ApplicationResponse"),
		REQUEST_FOR_QUOTATION("RequestForQuotation"),
		REQUEST_FOR_QUOTATION_CANCELLATION("RequestForQuotationCancellation"),
		ORDER("Order"),
		HUMAN_RESOURCE("HumanResource"),
		TIME_CARD("TimeCard"),
		STAFFING_ORDER("StaffingOrder");

		String value;

		public static final MessageType getMessageType(String value)
		{
			for (MessageType messageType : MessageType.values())
				if (value.equals(messageType.value))
					return messageType;
			return null;
		}
	};

	public enum MessageFormat
	{
		UBL, SETU;
	};

	@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
	@AllArgsConstructor
	@Getter
	public enum ValidationType
	{
		UNKNOWN(0), SCHEMA(1), SCHEMATRON(2), GENERICODE(3), INVOICE_TO_CANONICAL(4), CANONICAL_TO_PDF(5), TESTCASE(6);

		int id;

		ValidationType()
		{
			this(0);
		}

		public static final ValidationType getValidationType(int id)
		{
			for (ValidationType validationType : ValidationType.values())
				if (id == validationType.id)
					return validationType;
			return null;
		}
	};
}
