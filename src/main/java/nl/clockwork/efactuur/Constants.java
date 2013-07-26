package nl.clockwork.efactuur;


public class Constants
{
	
	public static final String MESSAGE_FORMAT_UNKNOWN = MessageFormat.UNKNOWN.name();
	public static final String MESSAGE_FORMAT_UBL = MessageFormat.UBL.name();
	public static final String MESSAGE_FORMAT_SETU = MessageFormat.SETU.name();
		
	public static final String MESSAGE_VERSION_UBL_old = "old";
	public static final String MESSAGE_VERSION_UBL_1_1 = "1.1";
	public static final String MESSAGE_VERSION_UBL_1_6_2 = "1.6.2";
	public static final String MESSAGE_VERSION_UBL_1_6_3 = "1.6.3";
	public static final String MESSAGE_VERSION_UBL_1_7 = "1.7";
	public static final String MESSAGE_VERSION_UBL_1_8_beta2 = "1.8.beta2";
	public static final String MESSAGE_VERSION_UBL_DEFAULT = MESSAGE_VERSION_UBL_1_8_beta2;

	public static final String MESSAGE_VERSION_SETU_1_1 = "1.1";
	public static final String MESSAGE_VERSION_SETU_1_6_4 = "1.6.4";
	public static final String MESSAGE_VERSION_SETU_1_7 = "1.7";
	public static final String MESSAGE_VERSION_SETU_1_8 = "1.8";
	public static final String MESSAGE_VERSION_SETU_1_8_1_beta01 = "1.8.1.beta01";
	public static final String MESSAGE_VERSION_SETU_DEFAULT = MESSAGE_VERSION_SETU_1_8_1_beta01;

	public static final String MESSAGE_TYPE_UNKNOWN = MessageType.UNKNOWN.name();
	public static final String MESSAGE_TYPE_INVOICE = MessageType.INVOICE.name();
	public static final String MESSAGE_TYPE_COMMITMENT = MessageType.COMMITMENT.name();
	public static final String MESSAGE_TYPE_QUOTATION = MessageType.QUOTATION.name();
	public static final String MESSAGE_TYPE_ORDER_RESPONSE = MessageType.ORDER_RESPONSE.name();
	public static final String MESSAGE_TYPE_DESPATCH_ADVICE = MessageType.DESPATCH_ADVICE.name();
	public static final String MESSAGE_TYPE_APPLIACTION_RESPONSE = MessageType.APPLICATION_RESPONSE.name();
	public static final String MESSAGE_TYPE_REQUEST_FOR_QUOTATION = MessageType.REQUEST_FOR_QUOTATION.name();
	public static final String MESSAGE_TYPE_REQUEST_FOR_QUOTATION_CANCELLATION = MessageType.REQUEST_FOR_QUOTATION_CANCELLATION.name();
	public static final String MESSAGE_TYPE_ORDER = MessageType.ORDER.name();
	public static final String MESSAGE_TYPE_HUMAN_RESOURCE = MessageType.HUMAN_RESOURCE.name();
	public static final String MESSAGE_TYPE_TIME_CARD = MessageType.TIME_CARD.name();
	public static final String MESSAGE_TYPE_STAFFING_ORDER = MessageType.STAFFING_ORDER.name();

	// the property values
	public static final String AFLEVERBERICHT_BERICHTSOORT_EFACTUUR = "e-factuur";
	public static final String AFLEVERBERICHT_BERICHTSOORT_MFACTUUR = "m-factuur";

	public static final String AFLEVERBERICHT_BERICHTSOORT_BUDGETCHECK_VRAAG_UBL = "BUDGETCHECK-VRAAG-UBL";
	public static final String AFLEVERBERICHT_BERICHTSOORT_BESTELLING_VERPLICHTING_UBL = "BESTELLING-VERPLICHTING-UBL";
	public static final String AFLEVERBERICHT_BERICHTSOORT_TIMECARD_HRXML = "TIMECARD-HRXML";
	public static final String AFLEVERBERICHT_BERICHTSOORT_FACTUUR_UBL = "FACTUUR-UBL";
	public static final String AFLEVERBERICHT_BERICHTSOORT_FACTUUR_AKKOORD_UBL = "FACTUUR-AKKOORD-UBL";	
	public static final String AFLEVERBERICHT_BERICHTSOORT_FACTUUR_SETU = "FACTUUR-SETU";	
	public static final String AFLEVERBERICHT_BERICHTSOORT_FACTUUR_AKKOORD_SETU = "FACTUUR-AKKOORD-SETU";
	
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
