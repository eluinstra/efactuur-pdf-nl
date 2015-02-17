/**
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


public class Constants
{
	// HashMap containing the root-tag of a message mapped that message's messageType
	public final static HashMap<String, nl.clockwork.efactuur.Constants.MessageType> rootTagToMessageType = new HashMap<String, nl.clockwork.efactuur.Constants.MessageType>()
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
	
	// HashMap containing the root-tag of a message mapped that message's messageType
	public final static HashMap<BerichtSoort, MessageType> berichtSoortToMessageType = new HashMap<BerichtSoort, MessageType>()
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
	
	// HashMap containing the major ubl versions mapped to their specific versions in the efactuur project.
	public final static HashMap<String, String> ublMajorVersionToSpecificVersion = new HashMap<String, String>()
	{
		private static final long serialVersionUID = 1L;

		{
			put("1.0", nl.clockwork.efactuur.Constants.MESSAGE_VERSION_UBL_1_1);
			put("1.1", nl.clockwork.efactuur.Constants.MESSAGE_VERSION_UBL_1_1);
			put("1.6", nl.clockwork.efactuur.Constants.MESSAGE_VERSION_UBL_1_6_3);
			put("1.7", nl.clockwork.efactuur.Constants.MESSAGE_VERSION_UBL_1_7);
			put("1.8", nl.clockwork.efactuur.Constants.MESSAGE_VERSION_UBL_1_8);
			put("1.9", nl.clockwork.efactuur.Constants.MESSAGE_VERSION_UBL_1_9);
		}		
	};

	// HashMap containing the major setu versions mapped to their specific versions in the efactuur project.
	public final static HashMap<String, String> setuMajorVersionToSpecificVersion = new HashMap<String, String>()
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
	
	public static final String MESSAGE_FORMAT_UNKNOWN = MessageFormat.UNKNOWN.name();
	public static final String MESSAGE_FORMAT_UBL = MessageFormat.UBL.name();
	public static final String MESSAGE_FORMAT_SETU = MessageFormat.SETU.name();
		
	public static final String MESSAGE_VERSION_UBL_old = "old";
	public static final String MESSAGE_VERSION_UBL_1_1 = "1.1";
	public static final String MESSAGE_VERSION_UBL_1_6_2 = "1.6.2";
	public static final String MESSAGE_VERSION_UBL_1_6_3 = "1.6.3";
	public static final String MESSAGE_VERSION_UBL_1_7 = "1.7";
	public static final String MESSAGE_VERSION_UBL_1_8_beta2 = "1.8.beta2";
	public static final String MESSAGE_VERSION_UBL_1_8 = "1.8";
	public static final String MESSAGE_VERSION_UBL_1_9 = "1.9";
	public static final String MESSAGE_VERSION_UBL_DEFAULT = MESSAGE_VERSION_UBL_1_8;

	public static final String MESSAGE_VERSION_SETU_1_1 = "1.1";
	public static final String MESSAGE_VERSION_SETU_1_6_4 = "1.6.4";
	public static final String MESSAGE_VERSION_SETU_1_7 = "1.7";
	public static final String MESSAGE_VERSION_SETU_1_8 = "1.8";
	public static final String MESSAGE_VERSION_SETU_1_8_1_beta01 = "1.8.1.beta01";
	public static final String MESSAGE_VERSION_SETU_1_8_1 = "1.8.1";
	public static final String MESSAGE_VERSION_SETU_2_0 = "2.0";
	public static final String MESSAGE_VERSION_SETU_DEFAULT = MESSAGE_VERSION_SETU_1_8_1;

	public static final String MESSAGE_TYPE_UNKNOWN = MessageType.UNKNOWN.name();
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

	// DigiInkoop : Stroom A
	public static final String AFLEVERBERICHT_BERICHTSOORT_BUDGETCHECK_VRAAG_UBL = "BUDGETCHECK-VRAAG-UBL";
	public static final String AFLEVERBERICHT_BERICHTSOORT_BUDGETCHECK_ANTWOORD_UBL = "BUDGETCHECK-ANTWOORD-UBL";
	public static final String AFLEVERBERICHT_BERICHTSOORT_BESTELLING_VERPLICHTING_UBL = "BESTELLING-VERPLICHTING-UBL";
	public static final String AFLEVERBERICHT_BERICHTSOORT_TIMECARD_HRXML = "TIMECARD-HRXML";
	public static final String AFLEVERBERICHT_BERICHTSOORT_FACTUUR_UBL = "FACTUUR-UBL";
	public static final String AFLEVERBERICHT_BERICHTSOORT_FACTUUR_AKKOORD_UBL = "FACTUUR-AKKOORD-UBL";	
	public static final String AFLEVERBERICHT_BERICHTSOORT_FACTUUR_HRXML = "FACTUUR-HRXML";	
	public static final String AFLEVERBERICHT_BERICHTSOORT_FACTUUR_AKKOORD_HRXML = "FACTUUR-AKKOORD-HRXML";
	
	
	public enum BerichtSoort
	{		
		BUDGETCHECK_ANTWOORD_UBL(0),
		BUDGETCHECK_VRAAG_UBL(1),
		BESTELLING_VERPLICHTING_UBL(2),
		TIMECARD_HRXML(3),
		FACTUUR_UBL(4),
		FACTUUR_AKKOORD_UBL(5),
		FACTUUR_HRXML(6),
		FACTUUR_AKKOORD_HRXML(7),
		ADVANCED_SHIPPING_NOTICE_UBL(8),
		OFFERTE_HRXML(9),
		BESTELLING_BEVESTIGING_HRXML(10),
		VOORSTEL_FACTUUR_HRXML(11),
		AFWIJZING_HRXML(12),
		VOORSTEL_FACTUUR_UBL(13),
		BESTELLING_UBL(14),
		BESTELLING_BEVESTIGING_UBL(15),
		OFFERTE_AANVRAAG_HRXML(16),
		BESTELLING_HRXML(17),
		OFFERTE_UBL(18),
		OFFERTE_AANVRAAG_UBL(19),
		AFWIJZING_UBL(20),
		E_FACTUUR(21),
		M_FACTUUR(22);
		
		private final int id;

		BerichtSoort(int id)
		{
			this.id = id;
		}

		public final int id()
		{
			return id;
		}

		public final static BerichtSoort getBerichtSoort(int id)
		{
			for (BerichtSoort berichtSoort: BerichtSoort.values())
				if (id == berichtSoort.id)
					return berichtSoort;
			return null;
		}
		public final static BerichtSoort parseString(String messageFormatStr)
		{
			try
			{
				return valueOf(messageFormatStr);
			}
			catch (NullPointerException e)
			{
				throw new RuntimeException("Can not parse null value for message format",e);
			}
			catch (IllegalArgumentException e)
			{
				throw new RuntimeException("Message format value '" + messageFormatStr + "' unknown",e);
			}
		}		
	};	
	
	public enum MessageType
	{
		UNKNOWN(0), INVOICE(1), COMMITMENT(2), QUOTATION(3), ORDER_RESPONSE(4), DESPATCH_ADVICE(5), APPLICATION_RESPONSE(6), REQUEST_FOR_QUOTATION(7), REQUEST_FOR_QUOTATION_CANCELLATION(8), ORDER(9), HUMAN_RESOURCE(10), TIME_CARD(11), STAFFING_ORDER(12);

		private final int id;

		MessageType(int id)
		{
			this.id = id;
		}

		public final int id()
		{
			return id;
		}

		public final static MessageType getMessageType(int id)
		{
			for (MessageType messageType: MessageType.values())
				if (id == messageType.id)
					return messageType;
			return null;
		}
	};
	
	public enum MessageFormat
	{
		UNKNOWN(0), UBL(1), SETU(2);

		private final int id;

		MessageFormat(int id)
		{
			this.id = id;
		}

		public final int id()
		{
			return id;
		}

		public final static MessageFormat getMessageFormat(int id)
		{
			for (MessageFormat messageFormat: MessageFormat.values())
				if (id == messageFormat.id)
					return messageFormat;
			return null;
		}

		public final static MessageFormat parseString(String messageFormatStr)
		{
			try
			{
				return valueOf(messageFormatStr);
			}
			catch (NullPointerException e)
			{
				throw new RuntimeException("Can not parse null value for message format",e);
			}
			catch (IllegalArgumentException e)
			{
				throw new RuntimeException("Message format value '" + messageFormatStr + "' unknown",e);
			}
		}
	};

	public enum ValidationType
	{
		UNKNOWN(0), SCHEMA(1), SCHEMATRON(2), GENERICODE(3), INVOICE_TO_CANONICAL(4), CANONICAL_TO_PDF(5), TESTCASE(6);

		private final int id;

		ValidationType()
		{
			this(0);
		}

		ValidationType(int id)
		{
			this.id = id;
		}

		public final int id()
		{
			return id;
		}

		public final static ValidationType getValidationType(int id)
		{
			// return ValidationType.values().length < id ?
			// ValidationType.values()[id] : null;
			for (ValidationType validationType: ValidationType.values())
				if (id == validationType.id)
					return validationType;
			return null;
		}
	};
}
