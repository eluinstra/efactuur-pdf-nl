package nl.clockwork.efactuur;

import java.util.HashMap;

import nl.clockwork.efactuur.Constants.MessageFormat;
import nl.clockwork.efactuur.Constants.MessageType;
import nl.clockwork.efactuur.Constants.ValidationType;


public class DigikoppelingVersionHelper implements nl.clockwork.efactuur.VersionHelper
{

	// regular expression that a version should match
	// 1 . 8 . 1 . beta 02
	static String versionRegExp = "[0-9a-zA-Z]{1}[\\.|_]{1}[0-9a-zA-Z]+[\\.|_]?[0-9a-zA-Z]*[\\.|_]?(beta)?[0-9]*";

	static String pdfTransformationRootPath = "/nl/clockwork/efactuur/nl/pdf";
	static String ublPdfTransformationRootPath = pdfTransformationRootPath + "/ubl";
	static String setuPdfTransformationValidationRootPath = pdfTransformationRootPath + "/setu";

	static String ublValidationRootPath = "/nl/clockwork/efactuur/nl/domain/ubl";
	static String setuValidationRootPath = "/nl/clockwork/efactuur/nl/domain/setu";

	private final static HashMap<Version,String> pathResolver = new HashMap<Version,String>()
	{
		private static final long serialVersionUID = 1L;
		{
			
			// UBL Invoice
			
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.INVOICE,Constants.MESSAGE_VERSION_UBL_1_1),ublValidationRootPath + "/1.1/xsd/maindoc/Invoice.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.INVOICE,Constants.MESSAGE_VERSION_UBL_1_6_2),ublValidationRootPath + "/1.6.2/xsd/maindoc/Invoice.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.INVOICE,Constants.MESSAGE_VERSION_UBL_1_6_3),ublValidationRootPath + "/1.6.3/xsd/maindoc/Invoice.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.INVOICE,Constants.MESSAGE_VERSION_UBL_1_7),ublValidationRootPath + "/1.7/xsd/maindoc/Invoice.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.INVOICE,Constants.MESSAGE_VERSION_UBL_1_8_beta2),ublValidationRootPath + "/1.8.beta2/xsd/maindoc/Invoice.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.INVOICE,Constants.MESSAGE_VERSION_UBL_1_8),ublValidationRootPath + "/1.8/xsd/maindoc/Invoice.xsd");
			

			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.INVOICE,Constants.MESSAGE_VERSION_UBL_1_1),ublValidationRootPath + "/1.1/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.INVOICE,Constants.MESSAGE_VERSION_UBL_1_6_2),ublValidationRootPath + "/1.6.2/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.INVOICE,Constants.MESSAGE_VERSION_UBL_1_6_3),ublValidationRootPath + "/1.6.3/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.INVOICE,Constants.MESSAGE_VERSION_UBL_1_7),ublValidationRootPath + "/1.7/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.INVOICE,Constants.MESSAGE_VERSION_UBL_1_8_beta2),ublValidationRootPath + "/1.8.beta2/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.INVOICE,Constants.MESSAGE_VERSION_UBL_1_8),ublValidationRootPath + "/1.8/Invoice-Genericode.xsl");
			

			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.INVOICE,Constants.MESSAGE_VERSION_UBL_1_1),ublValidationRootPath + "/1.1/Invoice-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.INVOICE,Constants.MESSAGE_VERSION_UBL_1_6_2),ublValidationRootPath + "/1.6.2/Invoice-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.INVOICE,Constants.MESSAGE_VERSION_UBL_1_6_3),ublValidationRootPath + "/1.6.3/Invoice-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.INVOICE,Constants.MESSAGE_VERSION_UBL_1_7),ublValidationRootPath + "/1.7/Invoice-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.INVOICE,Constants.MESSAGE_VERSION_UBL_1_8_beta2),ublValidationRootPath + "/1.8.beta2/Invoice-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.INVOICE,Constants.MESSAGE_VERSION_UBL_1_8),ublValidationRootPath + "/1.8/Invoice-Validation.xsl");
			

			put(new Version(ValidationType.INVOICE_TO_CANONICAL,MessageFormat.UBL,MessageType.INVOICE,Constants.MESSAGE_VERSION_UBL_1_1),ublPdfTransformationRootPath + "/InvoiceToFactuurCanonical_1_1_namespace_patch.xsl");
			put(new Version(ValidationType.INVOICE_TO_CANONICAL,MessageFormat.UBL,MessageType.INVOICE,Constants.MESSAGE_VERSION_UBL_1_6_2),ublPdfTransformationRootPath + "/InvoiceToFactuurCanonical.xsl");
			put(new Version(ValidationType.INVOICE_TO_CANONICAL,MessageFormat.UBL,MessageType.INVOICE,Constants.MESSAGE_VERSION_UBL_1_6_3),ublPdfTransformationRootPath + "/InvoiceToFactuurCanonical.xsl");
			put(new Version(ValidationType.INVOICE_TO_CANONICAL,MessageFormat.UBL,MessageType.INVOICE,Constants.MESSAGE_VERSION_UBL_1_7),ublPdfTransformationRootPath + "/InvoiceToFactuurCanonical.xsl");
			put(new Version(ValidationType.INVOICE_TO_CANONICAL,MessageFormat.UBL,MessageType.INVOICE,Constants.MESSAGE_VERSION_UBL_1_8_beta2),ublPdfTransformationRootPath + "/InvoiceToFactuurCanonical.xsl");
			put(new Version(ValidationType.INVOICE_TO_CANONICAL,MessageFormat.UBL,MessageType.INVOICE,Constants.MESSAGE_VERSION_UBL_1_8),ublPdfTransformationRootPath + "/InvoiceToFactuurCanonical.xsl");
			

			put(new Version(ValidationType.CANONICAL_TO_PDF,MessageFormat.UBL,MessageType.INVOICE,Constants.MESSAGE_VERSION_UBL_1_1),pdfTransformationRootPath + "/CanonicalToFactuurPDF.xsl");
			put(new Version(ValidationType.CANONICAL_TO_PDF,MessageFormat.UBL,MessageType.INVOICE,Constants.MESSAGE_VERSION_UBL_1_6_2),pdfTransformationRootPath + "/CanonicalToFactuurPDF.xsl");
			put(new Version(ValidationType.CANONICAL_TO_PDF,MessageFormat.UBL,MessageType.INVOICE,Constants.MESSAGE_VERSION_UBL_1_6_3),pdfTransformationRootPath + "/CanonicalToFactuurPDF.xsl");
			put(new Version(ValidationType.CANONICAL_TO_PDF,MessageFormat.UBL,MessageType.INVOICE,Constants.MESSAGE_VERSION_UBL_1_7),pdfTransformationRootPath + "/CanonicalToFactuurPDF.xsl");
			put(new Version(ValidationType.CANONICAL_TO_PDF,MessageFormat.UBL,MessageType.INVOICE,Constants.MESSAGE_VERSION_UBL_1_8_beta2),pdfTransformationRootPath + "/CanonicalToFactuurPDF.xsl");
			put(new Version(ValidationType.CANONICAL_TO_PDF,MessageFormat.UBL,MessageType.INVOICE,Constants.MESSAGE_VERSION_UBL_1_8),pdfTransformationRootPath + "/CanonicalToFactuurPDF.xsl");
			

			put(new Version(ValidationType.TESTCASE,MessageFormat.UBL,MessageType.INVOICE,Constants.MESSAGE_VERSION_UBL_1_1),ublValidationRootPath + "/1.1/xml/UBL-NL-Invoice-1.0-Example00.xml");
			put(new Version(ValidationType.TESTCASE,MessageFormat.UBL,MessageType.INVOICE,Constants.MESSAGE_VERSION_UBL_1_6_2),ublValidationRootPath + "/1.6.2/xml/UBL-Invoice-1.6-Example07.xml");
			put(new Version(ValidationType.TESTCASE,MessageFormat.UBL,MessageType.INVOICE,Constants.MESSAGE_VERSION_UBL_1_6_3),ublValidationRootPath + "/1.6.3/xml/UBL-Invoice-1.6-Example07.xml");
			put(new Version(ValidationType.TESTCASE,MessageFormat.UBL,MessageType.INVOICE,Constants.MESSAGE_VERSION_UBL_1_7),ublValidationRootPath + "/1.7/xml/UBL-Invoice-Example07.xml");
			put(new Version(ValidationType.TESTCASE,MessageFormat.UBL,MessageType.INVOICE,Constants.MESSAGE_VERSION_UBL_1_8),ublValidationRootPath + "/1.8/xml/UBL-Invoice-Example07.xml");
			put(new Version(ValidationType.TESTCASE,MessageFormat.UBL,MessageType.INVOICE,Constants.MESSAGE_VERSION_UBL_1_8_beta2),ublValidationRootPath + "/1.8.beta2/xml/UBL-Invoice-Example07.xml");

			// SETU: Invoice
			
			put(new Version(ValidationType.SCHEMA,MessageFormat.SETU,MessageType.INVOICE,Constants.MESSAGE_VERSION_SETU_1_1),setuValidationRootPath + "/1.1/SIDES/Invoice.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.SETU,MessageType.INVOICE,Constants.MESSAGE_VERSION_SETU_1_6_4),setuValidationRootPath + "/1.6.4/SIDES/Invoice.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.SETU,MessageType.INVOICE,Constants.MESSAGE_VERSION_SETU_1_7),setuValidationRootPath + "/1.7/SIDES/Invoice.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.SETU,MessageType.INVOICE,Constants.MESSAGE_VERSION_SETU_1_8),setuValidationRootPath + "/1.8/SIDES/Invoice.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.SETU,MessageType.INVOICE,Constants.MESSAGE_VERSION_SETU_1_8_1_beta01),setuValidationRootPath + "/1.8.1.beta01/SIDES/Invoice.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.SETU,MessageType.INVOICE,Constants.MESSAGE_VERSION_SETU_1_8_1),setuValidationRootPath + "/1.8.1/SIDES/Invoice.xsd");
			
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.SETU,MessageType.INVOICE,Constants.MESSAGE_VERSION_SETU_1_1),"");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.SETU,MessageType.INVOICE,Constants.MESSAGE_VERSION_SETU_1_6_4),setuValidationRootPath + "/1.6.4/Invoice-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.SETU,MessageType.INVOICE,Constants.MESSAGE_VERSION_SETU_1_7),setuValidationRootPath + "/1.7/Invoice-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.SETU,MessageType.INVOICE,Constants.MESSAGE_VERSION_SETU_1_8),setuValidationRootPath + "/1.8/Invoice-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.SETU,MessageType.INVOICE,Constants.MESSAGE_VERSION_SETU_1_8_1_beta01),setuValidationRootPath + "/1.8.1.beta01/Invoice-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.SETU,MessageType.INVOICE,Constants.MESSAGE_VERSION_SETU_1_8_1),setuValidationRootPath + "/1.8.1/Invoice-Validation.xsl");

			put(new Version(ValidationType.INVOICE_TO_CANONICAL,MessageFormat.SETU,MessageType.INVOICE,Constants.MESSAGE_VERSION_SETU_1_1),setuPdfTransformationValidationRootPath + "/InvoiceToFactuurCanonical.xsl");
			put(new Version(ValidationType.INVOICE_TO_CANONICAL,MessageFormat.SETU,MessageType.INVOICE,Constants.MESSAGE_VERSION_SETU_1_6_4),setuPdfTransformationValidationRootPath + "/InvoiceToFactuurCanonical.xsl");
			put(new Version(ValidationType.INVOICE_TO_CANONICAL,MessageFormat.SETU,MessageType.INVOICE,Constants.MESSAGE_VERSION_SETU_1_7),setuPdfTransformationValidationRootPath + "/InvoiceToFactuurCanonical.xsl");
			put(new Version(ValidationType.INVOICE_TO_CANONICAL,MessageFormat.SETU,MessageType.INVOICE,Constants.MESSAGE_VERSION_SETU_1_8),setuPdfTransformationValidationRootPath + "/InvoiceToFactuurCanonical.xsl");
			put(new Version(ValidationType.INVOICE_TO_CANONICAL,MessageFormat.SETU,MessageType.INVOICE,Constants.MESSAGE_VERSION_SETU_1_8_1_beta01),setuPdfTransformationValidationRootPath + "/InvoiceToFactuurCanonical.xsl");
			put(new Version(ValidationType.INVOICE_TO_CANONICAL,MessageFormat.SETU,MessageType.INVOICE,Constants.MESSAGE_VERSION_SETU_1_8_1),setuPdfTransformationValidationRootPath + "/InvoiceToFactuurCanonical.xsl");

			put(new Version(ValidationType.CANONICAL_TO_PDF,MessageFormat.SETU,MessageType.INVOICE,Constants.MESSAGE_VERSION_SETU_1_1),pdfTransformationRootPath + "/CanonicalToFactuurPDF.xsl");
			put(new Version(ValidationType.CANONICAL_TO_PDF,MessageFormat.SETU,MessageType.INVOICE,Constants.MESSAGE_VERSION_SETU_1_6_4),pdfTransformationRootPath + "/CanonicalToFactuurPDF.xsl");
			put(new Version(ValidationType.CANONICAL_TO_PDF,MessageFormat.SETU,MessageType.INVOICE,Constants.MESSAGE_VERSION_SETU_1_7),pdfTransformationRootPath + "/CanonicalToFactuurPDF.xsl");
			put(new Version(ValidationType.CANONICAL_TO_PDF,MessageFormat.SETU,MessageType.INVOICE,Constants.MESSAGE_VERSION_SETU_1_8),pdfTransformationRootPath + "/CanonicalToFactuurPDF.xsl");
			put(new Version(ValidationType.CANONICAL_TO_PDF,MessageFormat.SETU,MessageType.INVOICE,Constants.MESSAGE_VERSION_SETU_1_8_1_beta01),pdfTransformationRootPath + "/CanonicalToFactuurPDF.xsl");
			put(new Version(ValidationType.CANONICAL_TO_PDF,MessageFormat.SETU,MessageType.INVOICE,Constants.MESSAGE_VERSION_SETU_1_8_1),pdfTransformationRootPath + "/CanonicalToFactuurPDF.xsl");

			put(new Version(ValidationType.TESTCASE,MessageFormat.SETU,MessageType.INVOICE,Constants.MESSAGE_VERSION_SETU_1_1),setuValidationRootPath + "/1.1/XML/example_invoice_2011-1.xml");
			put(new Version(ValidationType.TESTCASE,MessageFormat.SETU,MessageType.INVOICE,Constants.MESSAGE_VERSION_SETU_1_6_4),setuValidationRootPath + "/1.6.4/XML/EBF_Invoice.xml");
			put(new Version(ValidationType.TESTCASE,MessageFormat.SETU,MessageType.INVOICE,Constants.MESSAGE_VERSION_SETU_1_7),setuValidationRootPath + "/1.7/XML/EBF_Invoice.xml");
			put(new Version(ValidationType.TESTCASE,MessageFormat.SETU,MessageType.INVOICE,Constants.MESSAGE_VERSION_SETU_1_8),setuValidationRootPath + "/1.8/XML/EBF_Invoice.xml");
			put(new Version(ValidationType.TESTCASE,MessageFormat.SETU,MessageType.INVOICE,Constants.MESSAGE_VERSION_SETU_1_8_1_beta01),setuValidationRootPath + "/1.8.1.beta01/XML/EBF_Invoice.xml");
			put(new Version(ValidationType.TESTCASE,MessageFormat.SETU,MessageType.INVOICE,Constants.MESSAGE_VERSION_SETU_1_8_1),setuValidationRootPath + "/1.8.1/XML/EBF_Invoice.xml");
			
			// UBL: Commitment
			
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.COMMITMENT,Constants.MESSAGE_VERSION_UBL_1_6_2),ublValidationRootPath + "/1.6.2/xsd/maindoc/Commitment.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.COMMITMENT,Constants.MESSAGE_VERSION_UBL_1_6_3),ublValidationRootPath + "/1.6.3/xsd/maindoc/Commitment.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.COMMITMENT,Constants.MESSAGE_VERSION_UBL_1_7),ublValidationRootPath + "/1.7/xsd/maindoc/Commitment-NL-1.7.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.COMMITMENT,Constants.MESSAGE_VERSION_UBL_1_8_beta2),ublValidationRootPath + "/1.8.beta2/xsd/maindoc/Commitment-NL-1.8.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.COMMITMENT,Constants.MESSAGE_VERSION_UBL_1_8),ublValidationRootPath + "/1.8/xsd/maindoc/Commitment-NL-1.8.xsd");

			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.COMMITMENT,Constants.MESSAGE_VERSION_UBL_1_1),ublValidationRootPath + "/1.1/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.COMMITMENT,Constants.MESSAGE_VERSION_UBL_1_6_2),ublValidationRootPath + "/1.6.2/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.COMMITMENT,Constants.MESSAGE_VERSION_UBL_1_6_3),ublValidationRootPath + "/1.6.3/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.COMMITMENT,Constants.MESSAGE_VERSION_UBL_1_7),ublValidationRootPath + "/1.7/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.COMMITMENT,Constants.MESSAGE_VERSION_UBL_1_8_beta2),ublValidationRootPath + "/1.8.beta2/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.COMMITMENT,Constants.MESSAGE_VERSION_UBL_1_8),ublValidationRootPath + "/1.8/Invoice-Genericode.xsl");

			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.COMMITMENT,Constants.MESSAGE_VERSION_UBL_1_1),ublValidationRootPath + "/1.1/Commitment-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.COMMITMENT,Constants.MESSAGE_VERSION_UBL_1_6_2),ublValidationRootPath + "/1.6.2/Commitment-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.COMMITMENT,Constants.MESSAGE_VERSION_UBL_1_6_3),ublValidationRootPath + "/1.6.3/Commitment-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.COMMITMENT,Constants.MESSAGE_VERSION_UBL_1_7),ublValidationRootPath + "/1.7/Commitment-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.COMMITMENT,Constants.MESSAGE_VERSION_UBL_1_8_beta2),ublValidationRootPath + "/1.8.beta2/Commitment-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.COMMITMENT,Constants.MESSAGE_VERSION_UBL_1_8),ublValidationRootPath + "/1.8/Commitment-Validation.xsl");

			
			// UBL: Quotation
			
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.QUOTATION,Constants.MESSAGE_VERSION_UBL_1_6_2),ublValidationRootPath + "/1.6.2/xsd/maindoc/Quotation.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.QUOTATION,Constants.MESSAGE_VERSION_UBL_1_6_3),ublValidationRootPath + "/1.6.3/xsd/maindoc/Quotation.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.QUOTATION,Constants.MESSAGE_VERSION_UBL_1_7),ublValidationRootPath + "/1.7/xsd/maindoc/Quotation.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.QUOTATION,Constants.MESSAGE_VERSION_UBL_1_8_beta2),ublValidationRootPath + "/1.8.beta2/xsd/maindoc/Quotation.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.QUOTATION,Constants.MESSAGE_VERSION_UBL_1_8),ublValidationRootPath + "/1.8/xsd/maindoc/Quotation.xsd");

			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.QUOTATION,Constants.MESSAGE_VERSION_UBL_1_1),ublValidationRootPath + "/1.1/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.QUOTATION,Constants.MESSAGE_VERSION_UBL_1_6_2),ublValidationRootPath + "/1.6.2/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.QUOTATION,Constants.MESSAGE_VERSION_UBL_1_6_3),ublValidationRootPath + "/1.6.3/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.QUOTATION,Constants.MESSAGE_VERSION_UBL_1_7),ublValidationRootPath + "/1.7/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.QUOTATION,Constants.MESSAGE_VERSION_UBL_1_8_beta2),ublValidationRootPath + "/1.8.beta2/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.QUOTATION,Constants.MESSAGE_VERSION_UBL_1_8),ublValidationRootPath + "/1.8/Invoice-Genericode.xsl");

			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.QUOTATION,Constants.MESSAGE_VERSION_UBL_1_1),ublValidationRootPath + "/1.1/Quotation-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.QUOTATION,Constants.MESSAGE_VERSION_UBL_1_6_2),ublValidationRootPath + "/1.6.2/Quotation-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.QUOTATION,Constants.MESSAGE_VERSION_UBL_1_6_3),ublValidationRootPath + "/1.6.3/Quotation-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.QUOTATION,Constants.MESSAGE_VERSION_UBL_1_7),ublValidationRootPath + "/1.7/Quotation-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.QUOTATION,Constants.MESSAGE_VERSION_UBL_1_8_beta2),ublValidationRootPath + "/1.8.beta2/Quotation-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.QUOTATION,Constants.MESSAGE_VERSION_UBL_1_8),ublValidationRootPath + "/1.8/Quotation-Validation.xsl");

			
			// UBL: Order Response
			
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.ORDER_RESPONSE,Constants.MESSAGE_VERSION_UBL_1_6_2),ublValidationRootPath + "/1.6.2/xsd/maindoc/OrderResponse.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.ORDER_RESPONSE,Constants.MESSAGE_VERSION_UBL_1_6_3),ublValidationRootPath + "/1.6.3/xsd/maindoc/OrderResponse.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.ORDER_RESPONSE,Constants.MESSAGE_VERSION_UBL_1_7),ublValidationRootPath + "/1.7/xsd/maindoc/OrderResponse.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.ORDER_RESPONSE,Constants.MESSAGE_VERSION_UBL_1_8_beta2),ublValidationRootPath + "/1.8.beta2/xsd/maindoc/OrderResponse.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.ORDER_RESPONSE,Constants.MESSAGE_VERSION_UBL_1_8),ublValidationRootPath + "/1.8/xsd/maindoc/OrderResponse.xsd");

			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.ORDER_RESPONSE,Constants.MESSAGE_VERSION_UBL_1_1),ublValidationRootPath + "/1.1/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.ORDER_RESPONSE,Constants.MESSAGE_VERSION_UBL_1_6_2),ublValidationRootPath + "/1.6.2/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.ORDER_RESPONSE,Constants.MESSAGE_VERSION_UBL_1_6_3),ublValidationRootPath + "/1.6.3/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.ORDER_RESPONSE,Constants.MESSAGE_VERSION_UBL_1_7),ublValidationRootPath + "/1.7/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.ORDER_RESPONSE,Constants.MESSAGE_VERSION_UBL_1_8_beta2),ublValidationRootPath + "/1.8.beta2/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.ORDER_RESPONSE,Constants.MESSAGE_VERSION_UBL_1_8),ublValidationRootPath + "/1.8/Invoice-Genericode.xsl");

			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.ORDER_RESPONSE,Constants.MESSAGE_VERSION_UBL_1_1),ublValidationRootPath + "/1.1/OrderResponse-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.ORDER_RESPONSE,Constants.MESSAGE_VERSION_UBL_1_6_2),ublValidationRootPath + "/1.6.2/OrderResponse-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.ORDER_RESPONSE,Constants.MESSAGE_VERSION_UBL_1_6_3),ublValidationRootPath + "/1.6.3/OrderResponse-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.ORDER_RESPONSE,Constants.MESSAGE_VERSION_UBL_1_7),ublValidationRootPath + "/1.7/OrderResponse-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.ORDER_RESPONSE,Constants.MESSAGE_VERSION_UBL_1_8_beta2),ublValidationRootPath + "/1.8.beta2/OrderResponse-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.ORDER_RESPONSE,Constants.MESSAGE_VERSION_UBL_1_8),ublValidationRootPath + "/1.8/OrderResponse-Validation.xsl");
			
			
			// UBL: Despatch Advice
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.DESPATCH_ADVICE,Constants.MESSAGE_VERSION_UBL_1_6_2),ublValidationRootPath + "/1.6.2/xsd/maindoc/DespatchAdvice.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.DESPATCH_ADVICE,Constants.MESSAGE_VERSION_UBL_1_6_3),ublValidationRootPath + "/1.6.3/xsd/maindoc/DespatchAdvice.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.DESPATCH_ADVICE,Constants.MESSAGE_VERSION_UBL_1_7),ublValidationRootPath + "/1.7/xsd/maindoc/DespatchAdvice.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.DESPATCH_ADVICE,Constants.MESSAGE_VERSION_UBL_1_8_beta2),ublValidationRootPath + "/1.8.beta2/xsd/maindoc/DespatchAdvice.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.DESPATCH_ADVICE,Constants.MESSAGE_VERSION_UBL_1_8),ublValidationRootPath + "/1.8/xsd/maindoc/DespatchAdvice.xsd");

			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.DESPATCH_ADVICE,Constants.MESSAGE_VERSION_UBL_1_1),ublValidationRootPath + "/1.1/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.DESPATCH_ADVICE,Constants.MESSAGE_VERSION_UBL_1_6_2),ublValidationRootPath + "/1.6.2/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.DESPATCH_ADVICE,Constants.MESSAGE_VERSION_UBL_1_6_3),ublValidationRootPath + "/1.6.3/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.DESPATCH_ADVICE,Constants.MESSAGE_VERSION_UBL_1_7),ublValidationRootPath + "/1.7/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.DESPATCH_ADVICE,Constants.MESSAGE_VERSION_UBL_1_8_beta2),ublValidationRootPath + "/1.8.beta2/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.DESPATCH_ADVICE,Constants.MESSAGE_VERSION_UBL_1_8),ublValidationRootPath + "/1.8/Invoice-Genericode.xsl");

			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.DESPATCH_ADVICE,Constants.MESSAGE_VERSION_UBL_1_1),ublValidationRootPath + "/1.1/DespatchAdvice-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.DESPATCH_ADVICE,Constants.MESSAGE_VERSION_UBL_1_6_2),ublValidationRootPath + "/1.6.2/DespatchAdvice-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.DESPATCH_ADVICE,Constants.MESSAGE_VERSION_UBL_1_6_3),ublValidationRootPath + "/1.6.3/DespatchAdvice-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.DESPATCH_ADVICE,Constants.MESSAGE_VERSION_UBL_1_7),ublValidationRootPath + "/1.7/DespatchAdvice-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.DESPATCH_ADVICE,Constants.MESSAGE_VERSION_UBL_1_8_beta2),ublValidationRootPath + "/1.8.beta2/DespatchAdvice-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.DESPATCH_ADVICE,Constants.MESSAGE_VERSION_UBL_1_8),ublValidationRootPath + "/1.8/DespatchAdvice-Validation.xsl");

			// UBL: Application Response 
			
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.APPLICATION_RESPONSE,Constants.MESSAGE_VERSION_UBL_1_6_2),ublValidationRootPath + "/1.6.2/xsd/maindoc/ApplicationResponse.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.APPLICATION_RESPONSE,Constants.MESSAGE_VERSION_UBL_1_6_3),ublValidationRootPath + "/1.6.3/xsd/maindoc/ApplicationResponse.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.APPLICATION_RESPONSE,Constants.MESSAGE_VERSION_UBL_1_7),ublValidationRootPath + "/1.7/xsd/maindoc/ApplicationResponse.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.APPLICATION_RESPONSE,Constants.MESSAGE_VERSION_UBL_1_8_beta2),ublValidationRootPath + "/1.8.beta2/xsd/maindoc/ApplicationResponse.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.APPLICATION_RESPONSE,Constants.MESSAGE_VERSION_UBL_1_8),ublValidationRootPath + "/1.8/xsd/maindoc/ApplicationResponse.xsd");

			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.APPLICATION_RESPONSE,Constants.MESSAGE_VERSION_UBL_1_1),ublValidationRootPath + "/1.1/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.APPLICATION_RESPONSE,Constants.MESSAGE_VERSION_UBL_1_6_2),ublValidationRootPath + "/1.6.2/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.APPLICATION_RESPONSE,Constants.MESSAGE_VERSION_UBL_1_6_3),ublValidationRootPath + "/1.6.3/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.APPLICATION_RESPONSE,Constants.MESSAGE_VERSION_UBL_1_7),ublValidationRootPath + "/1.7/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.APPLICATION_RESPONSE,Constants.MESSAGE_VERSION_UBL_1_8_beta2),ublValidationRootPath + "/1.8.beta2/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.APPLICATION_RESPONSE,Constants.MESSAGE_VERSION_UBL_1_8),ublValidationRootPath + "/1.8Invoice-Genericode.xsl");

			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.APPLICATION_RESPONSE,Constants.MESSAGE_VERSION_UBL_1_1),ublValidationRootPath + "/1.1/ApplicationResponse-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.APPLICATION_RESPONSE,Constants.MESSAGE_VERSION_UBL_1_6_2),ublValidationRootPath + "/1.6.2/ApplicationResponse-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.APPLICATION_RESPONSE,Constants.MESSAGE_VERSION_UBL_1_6_3),ublValidationRootPath + "/1.6.3/ApplicationResponse-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.APPLICATION_RESPONSE,Constants.MESSAGE_VERSION_UBL_1_7),ublValidationRootPath + "/1.7/ApplicationResponse-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.APPLICATION_RESPONSE,Constants.MESSAGE_VERSION_UBL_1_8_beta2),ublValidationRootPath + "/1.8.beta2/ApplicationResponse-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.APPLICATION_RESPONSE,Constants.MESSAGE_VERSION_UBL_1_8),ublValidationRootPath + "/1.8/ApplicationResponse-Validation.xsl");

			// UBL: Request For Quotation
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.REQUEST_FOR_QUOTATION,Constants.MESSAGE_VERSION_UBL_1_6_2),ublValidationRootPath + "/1.6.2/xsd/maindoc/RequestForQuotation.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.REQUEST_FOR_QUOTATION,Constants.MESSAGE_VERSION_UBL_1_6_3),ublValidationRootPath + "/1.6.3/xsd/maindoc/RequestForQuotation.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.REQUEST_FOR_QUOTATION,Constants.MESSAGE_VERSION_UBL_1_7),ublValidationRootPath + "/1.7/xsd/maindoc/RequestForQuotation.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.REQUEST_FOR_QUOTATION,Constants.MESSAGE_VERSION_UBL_1_8_beta2),ublValidationRootPath + "/1.8.beta2/xsd/maindoc/RequestForQuotation.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.REQUEST_FOR_QUOTATION,Constants.MESSAGE_VERSION_UBL_1_8),ublValidationRootPath + "/1.8/xsd/maindoc/RequestForQuotation.xsd");

			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.REQUEST_FOR_QUOTATION,Constants.MESSAGE_VERSION_UBL_1_1),ublValidationRootPath + "/1.1/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.REQUEST_FOR_QUOTATION,Constants.MESSAGE_VERSION_UBL_1_6_2),ublValidationRootPath + "/1.6.2/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.REQUEST_FOR_QUOTATION,Constants.MESSAGE_VERSION_UBL_1_6_3),ublValidationRootPath + "/1.6.3/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.REQUEST_FOR_QUOTATION,Constants.MESSAGE_VERSION_UBL_1_7),ublValidationRootPath + "/1.7/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.REQUEST_FOR_QUOTATION,Constants.MESSAGE_VERSION_UBL_1_8_beta2),ublValidationRootPath + "/1.8.beta2/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.REQUEST_FOR_QUOTATION,Constants.MESSAGE_VERSION_UBL_1_8),ublValidationRootPath + "/1.8/Invoice-Genericode.xsl");

			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.REQUEST_FOR_QUOTATION,Constants.MESSAGE_VERSION_UBL_1_1),ublValidationRootPath + "/1.1/RequestForQuotation-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.REQUEST_FOR_QUOTATION,Constants.MESSAGE_VERSION_UBL_1_6_2),ublValidationRootPath + "/1.6.2/RequestForQuotation-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.REQUEST_FOR_QUOTATION,Constants.MESSAGE_VERSION_UBL_1_6_3),ublValidationRootPath + "/1.6.3/RequestForQuotation-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.REQUEST_FOR_QUOTATION,Constants.MESSAGE_VERSION_UBL_1_7),ublValidationRootPath + "/1.7/RequestForQuotation-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.REQUEST_FOR_QUOTATION,Constants.MESSAGE_VERSION_UBL_1_8_beta2),ublValidationRootPath + "/1.8.beta2/RequestForQuotation-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.REQUEST_FOR_QUOTATION,Constants.MESSAGE_VERSION_UBL_1_8),ublValidationRootPath + "/1.8/RequestForQuotation-Validation.xsl");
			
			
			// UBL: Request for Quotation Cancellation
			
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.REQUEST_FOR_QUOTATION_CANCELLATION,Constants.MESSAGE_VERSION_UBL_1_6_2),ublValidationRootPath + "/1.6.2/xsd/maindoc/RequestForQuotationCancellation.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.REQUEST_FOR_QUOTATION_CANCELLATION,Constants.MESSAGE_VERSION_UBL_1_6_3),ublValidationRootPath + "/1.6.3/xsd/maindoc/RequestForQuotationCancellation.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.REQUEST_FOR_QUOTATION_CANCELLATION,Constants.MESSAGE_VERSION_UBL_1_7),ublValidationRootPath + "/1.7/xsd/maindoc/RequestForQuotationCancellation.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.REQUEST_FOR_QUOTATION_CANCELLATION,Constants.MESSAGE_VERSION_UBL_1_8_beta2),ublValidationRootPath + "/1.8.beta2/xsd/maindoc/RequestForQuotationCancellation.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.REQUEST_FOR_QUOTATION_CANCELLATION,Constants.MESSAGE_VERSION_UBL_1_8),ublValidationRootPath + "/1.8/xsd/maindoc/RequestForQuotationCancellation.xsd");

			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.REQUEST_FOR_QUOTATION_CANCELLATION,Constants.MESSAGE_VERSION_UBL_1_1),ublValidationRootPath + "/1.1/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.REQUEST_FOR_QUOTATION_CANCELLATION,Constants.MESSAGE_VERSION_UBL_1_6_2),ublValidationRootPath + "/1.6.2/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.REQUEST_FOR_QUOTATION_CANCELLATION,Constants.MESSAGE_VERSION_UBL_1_6_3),ublValidationRootPath + "/1.6.3/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.REQUEST_FOR_QUOTATION_CANCELLATION,Constants.MESSAGE_VERSION_UBL_1_7),ublValidationRootPath + "/1.7/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.REQUEST_FOR_QUOTATION_CANCELLATION,Constants.MESSAGE_VERSION_UBL_1_8_beta2),ublValidationRootPath + "/1.8.beta2/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.REQUEST_FOR_QUOTATION_CANCELLATION,Constants.MESSAGE_VERSION_UBL_1_8),ublValidationRootPath + "/1.8/Invoice-Genericode.xsl");

			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.REQUEST_FOR_QUOTATION_CANCELLATION,Constants.MESSAGE_VERSION_UBL_1_1),ublValidationRootPath + "/1.1/RequestForQuotationCancellation-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.REQUEST_FOR_QUOTATION_CANCELLATION,Constants.MESSAGE_VERSION_UBL_1_6_2),ublValidationRootPath + "/1.6.2/RequestForQuotationCancellation-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.REQUEST_FOR_QUOTATION_CANCELLATION,Constants.MESSAGE_VERSION_UBL_1_6_3),ublValidationRootPath + "/1.6.3/RequestForQuotationCancellation-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.REQUEST_FOR_QUOTATION_CANCELLATION,Constants.MESSAGE_VERSION_UBL_1_7),ublValidationRootPath + "/1.7/RequestForQuotationCancellation-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.REQUEST_FOR_QUOTATION_CANCELLATION,Constants.MESSAGE_VERSION_UBL_1_8_beta2),ublValidationRootPath + "/1.8.beta2/RequestForQuotationCancellation-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.REQUEST_FOR_QUOTATION_CANCELLATION,Constants.MESSAGE_VERSION_UBL_1_8),ublValidationRootPath + "/1.8/RequestForQuotationCancellation-Validation.xsl");
	
			
			// UBL : Order
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.ORDER,Constants.MESSAGE_VERSION_UBL_1_6_2),ublValidationRootPath + "/1.6.2/xsd/maindoc/Order.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.ORDER,Constants.MESSAGE_VERSION_UBL_1_6_3),ublValidationRootPath + "/1.6.3/xsd/maindoc/Order.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.ORDER,Constants.MESSAGE_VERSION_UBL_1_7),ublValidationRootPath + "/1.7/xsd/maindoc/Order.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.ORDER,Constants.MESSAGE_VERSION_UBL_1_8_beta2),ublValidationRootPath + "/1.8.beta2/xsd/maindoc/Order.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.UBL,MessageType.ORDER,Constants.MESSAGE_VERSION_UBL_1_8),ublValidationRootPath + "/1.8/xsd/maindoc/Order.xsd");

			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.ORDER,Constants.MESSAGE_VERSION_UBL_1_1),ublValidationRootPath + "/1.1/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.ORDER,Constants.MESSAGE_VERSION_UBL_1_6_2),ublValidationRootPath + "/1.6.2/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.ORDER,Constants.MESSAGE_VERSION_UBL_1_6_3),ublValidationRootPath + "/1.6.3/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.ORDER,Constants.MESSAGE_VERSION_UBL_1_7),ublValidationRootPath + "/1.7/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.ORDER,Constants.MESSAGE_VERSION_UBL_1_8_beta2),ublValidationRootPath + "/1.8.beta2/Invoice-Genericode.xsl");
			put(new Version(ValidationType.GENERICODE,MessageFormat.UBL,MessageType.ORDER,Constants.MESSAGE_VERSION_UBL_1_8),ublValidationRootPath + "/1.8/Invoice-Genericode.xsl");

			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.ORDER,Constants.MESSAGE_VERSION_UBL_1_1),ublValidationRootPath + "/1.1/Order-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.ORDER,Constants.MESSAGE_VERSION_UBL_1_6_2),ublValidationRootPath + "/1.6.2/Order-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.ORDER,Constants.MESSAGE_VERSION_UBL_1_6_3),ublValidationRootPath + "/1.6.3/Order-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.ORDER,Constants.MESSAGE_VERSION_UBL_1_7),ublValidationRootPath + "/1.7/Order-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.ORDER,Constants.MESSAGE_VERSION_UBL_1_8_beta2),ublValidationRootPath + "/1.8.beta2/Order-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.UBL,MessageType.ORDER,Constants.MESSAGE_VERSION_UBL_1_8),ublValidationRootPath + "/1.8/Order-Validation.xsl");
			
			
			// SETU Messages 
			
			// SETU: Human Resource
			put(new Version(ValidationType.SCHEMA,MessageFormat.SETU,MessageType.HUMAN_RESOURCE,Constants.MESSAGE_VERSION_SETU_1_6_4),setuValidationRootPath + "/1.6.4/SIDES/HumanResource.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.SETU,MessageType.HUMAN_RESOURCE,Constants.MESSAGE_VERSION_SETU_1_7),setuValidationRootPath + "/1.7/SIDES/HumanResource.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.SETU,MessageType.HUMAN_RESOURCE,Constants.MESSAGE_VERSION_SETU_1_8),setuValidationRootPath + "/1.8/SIDES/HumanResource.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.SETU,MessageType.HUMAN_RESOURCE,Constants.MESSAGE_VERSION_SETU_1_8_1_beta01),setuValidationRootPath + "/1.8.1.beta01/SIDES/HumanResource.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.SETU,MessageType.HUMAN_RESOURCE,Constants.MESSAGE_VERSION_SETU_1_8_1),setuValidationRootPath + "/1.8.1/SIDES/HumanResource.xsd");

			put(new Version(ValidationType.SCHEMATRON,MessageFormat.SETU,MessageType.HUMAN_RESOURCE,Constants.MESSAGE_VERSION_SETU_1_1),"");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.SETU,MessageType.HUMAN_RESOURCE,Constants.MESSAGE_VERSION_SETU_1_6_4),setuValidationRootPath + "/1.6.4/HumanResource-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.SETU,MessageType.HUMAN_RESOURCE,Constants.MESSAGE_VERSION_SETU_1_7),setuValidationRootPath + "/1.7/HumanResource-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.SETU,MessageType.HUMAN_RESOURCE,Constants.MESSAGE_VERSION_SETU_1_8),setuValidationRootPath + "/1.8/HumanResource-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.SETU,MessageType.HUMAN_RESOURCE,Constants.MESSAGE_VERSION_SETU_1_8_1_beta01),setuValidationRootPath + "/1.8.1.beta01/HumanResource-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.SETU,MessageType.HUMAN_RESOURCE,Constants.MESSAGE_VERSION_SETU_1_8_1),setuValidationRootPath + "/1.8.1/HumanResource-Validation.xsl");

			// SETU: Time Card
			put(new Version(ValidationType.SCHEMA,MessageFormat.SETU,MessageType.TIME_CARD,Constants.MESSAGE_VERSION_SETU_1_6_4),setuValidationRootPath + "/1.6.4/SIDES/TimeCardAdditionalData.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.SETU,MessageType.TIME_CARD,Constants.MESSAGE_VERSION_SETU_1_7),setuValidationRootPath + "/1.7/SIDES/TimeCardAdditionalData.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.SETU,MessageType.TIME_CARD,Constants.MESSAGE_VERSION_SETU_1_8),setuValidationRootPath + "/1.8/SIDES/TimeCardAdditionalData.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.SETU,MessageType.TIME_CARD,Constants.MESSAGE_VERSION_SETU_1_8_1_beta01),setuValidationRootPath + "/1.8.1.beta01/SIDES/TimeCardAdditionalData.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.SETU,MessageType.TIME_CARD,Constants.MESSAGE_VERSION_SETU_1_8_1),setuValidationRootPath + "/1.8.1/SIDES/TimeCardAdditionalData.xsd");

			put(new Version(ValidationType.SCHEMATRON,MessageFormat.SETU,MessageType.TIME_CARD,Constants.MESSAGE_VERSION_SETU_1_1),"");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.SETU,MessageType.TIME_CARD,Constants.MESSAGE_VERSION_SETU_1_6_4),setuValidationRootPath + "/1.6.4/TimeCard-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.SETU,MessageType.TIME_CARD,Constants.MESSAGE_VERSION_SETU_1_7),setuValidationRootPath + "/1.7/TimeCard-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.SETU,MessageType.TIME_CARD,Constants.MESSAGE_VERSION_SETU_1_8),setuValidationRootPath + "/1.8/TimeCard-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.SETU,MessageType.TIME_CARD,Constants.MESSAGE_VERSION_SETU_1_8_1_beta01),setuValidationRootPath + "/1.8.1.beta01/TimeCard-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.SETU,MessageType.TIME_CARD,Constants.MESSAGE_VERSION_SETU_1_8_1),setuValidationRootPath + "/1.8.1/TimeCard-Validation.xsl");

			// SETU: Staffing Order 
			put(new Version(ValidationType.SCHEMA,MessageFormat.SETU,MessageType.STAFFING_ORDER,Constants.MESSAGE_VERSION_SETU_1_6_4),setuValidationRootPath + "/1.6.4/SIDES/StaffingOrder.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.SETU,MessageType.STAFFING_ORDER,Constants.MESSAGE_VERSION_SETU_1_7),setuValidationRootPath + "/1.7/SIDES/StaffingOrder.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.SETU,MessageType.STAFFING_ORDER,Constants.MESSAGE_VERSION_SETU_1_8),setuValidationRootPath + "/1.8/SIDES/StaffingOrder.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.SETU,MessageType.STAFFING_ORDER,Constants.MESSAGE_VERSION_SETU_1_8_1_beta01),setuValidationRootPath + "/1.8.1.beta01/SIDES/StaffingOrder.xsd");
			put(new Version(ValidationType.SCHEMA,MessageFormat.SETU,MessageType.STAFFING_ORDER,Constants.MESSAGE_VERSION_SETU_1_8_1),setuValidationRootPath + "/1.8.1/SIDES/StaffingOrder.xsd");

			put(new Version(ValidationType.SCHEMATRON,MessageFormat.SETU,MessageType.STAFFING_ORDER,Constants.MESSAGE_VERSION_SETU_1_1),"");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.SETU,MessageType.STAFFING_ORDER,Constants.MESSAGE_VERSION_SETU_1_6_4),setuValidationRootPath + "/1.6.4/StaffingOrder-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.SETU,MessageType.STAFFING_ORDER,Constants.MESSAGE_VERSION_SETU_1_7),setuValidationRootPath + "/1.7/StaffingOrder-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.SETU,MessageType.STAFFING_ORDER,Constants.MESSAGE_VERSION_SETU_1_8),setuValidationRootPath + "/1.8/StaffingOrder-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.SETU,MessageType.STAFFING_ORDER,Constants.MESSAGE_VERSION_SETU_1_8_1_beta01),setuValidationRootPath + "/1.8.1.beta01/StaffingOrder-Validation.xsl");
			put(new Version(ValidationType.SCHEMATRON,MessageFormat.SETU,MessageType.STAFFING_ORDER,Constants.MESSAGE_VERSION_SETU_1_8_1),setuValidationRootPath + "/1.8.1/StaffingOrder-Validation.xsl");

		}
	};

	public String findPathFor(ValidationType validationType, MessageType messageType, MessageFormat format, String version) throws VersionNotFoundException
	{
		Version v = new Version(validationType,format,messageType,version);
		if (pathResolver.containsKey(v))
		{
			String path = pathResolver.get(v);
			return path;
		}
		throw new VersionNotFoundException("Could not find " + validationType + " for " + format + " " + version);
	}

	public String getCanonicalToPDFPath(MessageType type, MessageFormat format, String version) throws VersionNotFoundException
	{
		version = versionToPath(version);
		return findPathFor(ValidationType.CANONICAL_TO_PDF,type,format,version);
	}

	public String getInvoiceToCanonicalPath(MessageType type, MessageFormat format, String version) throws VersionNotFoundException
	{
		version = versionToPath(version);
		return findPathFor(ValidationType.INVOICE_TO_CANONICAL,type,format,version);
	}

	public String getXsdPath(MessageType type, MessageFormat format, String version) throws VersionNotFoundException
	{
		version = versionToPath(version);
		return findPathFor(ValidationType.SCHEMA,type,format,version);
	}

	public String getGenericodeXslPath(MessageType type, MessageFormat format, String version) throws VersionNotFoundException
	{
		version = versionToPath(version);
		return findPathFor(ValidationType.GENERICODE,type,format,version);
	}

	public String getSchematronXslPath(MessageType type, MessageFormat format, String version) throws VersionNotFoundException
	{
		version = versionToPath(version);
		return findPathFor(ValidationType.SCHEMATRON,type,format,version);
	}

	public String getTestXmlPath(MessageType type, MessageFormat format, String version) throws VersionNotFoundException
	{
		version = versionToPath(version);
		return findPathFor(ValidationType.TESTCASE,type,format,version);
	}

	public String versionToPath(String version)
	{
		if (!version.matches(versionRegExp))
		{
			throw new IllegalArgumentException("Version '" + version + "' does not match regexp '" + versionRegExp + "'");
		}
		return version.replace("_",".");
	}
}