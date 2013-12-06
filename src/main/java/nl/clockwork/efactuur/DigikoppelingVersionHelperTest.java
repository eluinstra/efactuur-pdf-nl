package nl.clockwork.efactuur;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;
import nl.clockwork.efactuur.Constants;
import nl.clockwork.efactuur.Constants.MessageFormat;
import nl.clockwork.efactuur.Constants.MessageType;
import nl.clockwork.efactuur.DigikoppelingVersionHelper;
import nl.clockwork.efactuur.VersionNotFoundException;

import org.junit.Test;

public class DigikoppelingVersionHelperTest {

//	public static final Log log = LogFactory.getLog(DigikoppelingVersionHelperTest.class);
	DigikoppelingVersionHelper helper = new DigikoppelingVersionHelper();
	
	@Test
	public void testXsdVersions() {

		try
		{		
			assertFalse("UBL 1.1 should return some path...", helper.getXsdPath(MessageType.INVOICE,MessageFormat.UBL, Constants.MESSAGE_VERSION_UBL_1_1)
					.equals(""));
			assertFalse("UBL 1.6 should return some path...", helper.getXsdPath(MessageType.INVOICE,MessageFormat.UBL, Constants.MESSAGE_VERSION_UBL_1_6_3)
					.equals(""));
			assertFalse("UBL 1.7 should return some path...", helper.getXsdPath(MessageType.INVOICE,MessageFormat.UBL, Constants.MESSAGE_VERSION_UBL_1_7)
					.equals(""));

			assertFalse("SETU 1.6.x should return some path...", helper
					.getXsdPath(MessageType.INVOICE,MessageFormat.SETU, Constants.MESSAGE_VERSION_SETU_1_6_4).equals(""));
			assertFalse("SETU 1.7 should return some path...", helper.getXsdPath(MessageType.INVOICE,MessageFormat.SETU, Constants.MESSAGE_VERSION_SETU_1_7)
					.equals(""));
			assertFalse("SETU 1.8 should return some path...", helper.getXsdPath(MessageType.INVOICE,MessageFormat.SETU, Constants.MESSAGE_VERSION_SETU_1_8)
					.equals(""));
			
		} catch (VersionNotFoundException e)
		{
			e.printStackTrace();
			assertFalse("TEST SHOULD NOT THROW EXCEPTIONS ! ", true);
		}
	}

	@Test
	public void testGenericodeVersions() {
		try {
			assertFalse("UBL 1.1 should return some path...",
					helper.getGenericodeXslPath(MessageType.INVOICE,MessageFormat.UBL, Constants.MESSAGE_VERSION_UBL_1_1).equals(""));
			assertFalse("UBL 1.6 should return some path...",
					helper.getGenericodeXslPath(MessageType.INVOICE,MessageFormat.UBL, Constants.MESSAGE_VERSION_UBL_1_6_3).equals(""));
			assertFalse("UBL 1.7 should return some path...",
					helper.getGenericodeXslPath(MessageType.INVOICE,MessageFormat.UBL, Constants.MESSAGE_VERSION_UBL_1_7).equals(""));
		}
		catch (VersionNotFoundException e)
		{
			e.printStackTrace();
			assertFalse("TEST SHOULD NOT THROW EXCEPTIONS ! ", true);
		}		
	}

	@Test
	public void testSchematronVersions() {
		try {
			assertFalse("UBL 1.1 should return some path...",
					helper.getSchematronXslPath(MessageType.INVOICE,MessageFormat.UBL, Constants.MESSAGE_VERSION_UBL_1_1).equals(""));
			assertFalse("UBL 1.6 should return some path...",
					helper.getSchematronXslPath(MessageType.INVOICE,MessageFormat.UBL, Constants.MESSAGE_VERSION_UBL_1_6_3).equals(""));
			assertFalse("UBL 1.7 should return some path...",
					helper.getSchematronXslPath(MessageType.INVOICE,MessageFormat.UBL, Constants.MESSAGE_VERSION_UBL_1_7).equals(""));
	
			assertFalse("SETU 1.6.x should return some path...",
					helper.getSchematronXslPath(MessageType.INVOICE,MessageFormat.SETU, Constants.MESSAGE_VERSION_SETU_1_6_4).equals(""));
			assertFalse("SETU 1.7 should return some path...",
					helper.getSchematronXslPath(MessageType.INVOICE,MessageFormat.SETU, Constants.MESSAGE_VERSION_SETU_1_7).equals(""));
			assertFalse("SETU 1.8 should return some path...",			
					helper.getSchematronXslPath(MessageType.INVOICE,MessageFormat.SETU, Constants.MESSAGE_VERSION_SETU_1_8).equals(""));
		}
		catch (VersionNotFoundException e)
		{
			e.printStackTrace();
			assertFalse("TEST SHOULD NOT THROW EXCEPTIONS ! ", true);
		}
	}

	@Test
	public void testXsdVersionsRainyDay() {
		try {
			helper.getXsdPath(MessageType.UNKNOWN,MessageFormat.UNKNOWN, Constants.MESSAGE_VERSION_SETU_1_8);
			fail("Expecting VersionNotFoundException when message format is unknown");
		} catch (Exception e) {
			assertTrue("Expecting VersionNotFoundException when message format is unknown", e instanceof VersionNotFoundException);
//			log.info("Expected: " + e.getMessage());
		}

		try {
			helper.getXsdPath(MessageType.INVOICE,MessageFormat.UBL, "0.0.0");
			fail("Expecting VersionNotFoundException when message version is unknown");
		} catch (Exception e) {
			assertTrue("Expecting VersionNotFoundException when message version is unknown", e instanceof VersionNotFoundException);
//			log.info("Expected: " + e.getMessage());
		}

		// try {
		// helper.getXsdPath(MessageFormat.UBL, "%%%%%");
		// fail("Expecting VersionNotFoundException when message version is invalid format");
		// } catch (Exception e) {
		// assertEquals("Expecting VersionNotFoundException when message version is invalid format", VersionNotFoundException.class, e.getClass());
		// log.info("Expected: " + e.getMessage());
		// }
	}

	@Test
	public void testGenericodeVersionsRainyDay() {

		try {
			helper.getGenericodeXslPath(MessageType.INVOICE,MessageFormat.SETU, Constants.MESSAGE_VERSION_SETU_1_6_4);
			fail("Expecting VersionNotFoundException when message format is SETU, since SETU does not have schematron validations");
		} catch (Exception e) {
//			log.info("Exception class is : " + e.getClass());
			assertTrue("Expecting VersionNotFoundException when message format is SETU, since SETU does not have schematron validations",
					e instanceof VersionNotFoundException);
//			log.info("Expected : " + e.getMessage());
		}

		try {
			helper.getGenericodeXslPath(MessageType.INVOICE,MessageFormat.SETU, Constants.MESSAGE_VERSION_SETU_1_7);
			fail("Expecting VersionNotFoundException when message format is SETU, since SETU does not have schematron validations");
		} catch (Exception e) {
//			log.info("Exception class is : " + e.getClass());
			assertTrue("Expecting VersionNotFoundException when message format is SETU, since SETU does not have schematron validations",
					e instanceof VersionNotFoundException);
//			log.info("Expected : " + e.getMessage());
		}

		try {
			helper.getGenericodeXslPath(MessageType.INVOICE,MessageFormat.SETU, Constants.MESSAGE_VERSION_SETU_1_8);
			fail("Expecting VersionNotFoundException when message format is SETU, since SETU does not have schematron validations");
		} catch (Exception e) {
//			log.info("Exception class is : " + e.getClass());
			assertTrue("Expecting VersionNotFoundException when message format is SETU, since SETU does not have schematron validations",
					e instanceof VersionNotFoundException);
//			log.info("Expected : " + e.getMessage());
		}

		try {
			helper.getGenericodeXslPath(MessageType.UNKNOWN,MessageFormat.UNKNOWN, Constants.MESSAGE_VERSION_SETU_1_8);
			fail("Expecting VersionNotFoundException when message format is unknown");
		} catch (Exception e) {
//			log.info("Exception class is : " + e.getClass());
			assertTrue("Expecting VersionNotFoundException when message format is unknown", e instanceof VersionNotFoundException);
//			log.info("Expected : " + e.getMessage());
		}

		try {
			helper.getGenericodeXslPath(MessageType.INVOICE,MessageFormat.UBL, "0.0.0");
			fail("Expecting VersionNotFoundException when message version is unknown");
		} catch (Exception e) {
//			log.info("Exception class is : " + e.getClass());
			assertTrue("Expecting VersionNotFoundException when message version is unknown", e instanceof VersionNotFoundException);
//			log.info("Expected : " + e.getMessage());
		}

		// try {
		// helper.getGenericodeXslPath(MessageFormat.UBL, "%%%%%");
		// fail("Expecting VersionNotFoundException when message version is invalidad format");
		// } catch (Exception e) {
		// log.info("Exception class is : " + e.getClass());
		// assertTrue("Expecting VersionNotFoundException when message version is invalid format", e instanceof VersionNotFoundException);
		// log.info("Expected : " + e.getMessage());
		// }
	}

	@Test
	public void testSchematronVersionsRainyDay() {
		try {
			helper.getSchematronXslPath(MessageType.UNKNOWN,MessageFormat.UNKNOWN, Constants.MESSAGE_VERSION_SETU_1_8);
			fail("Expecting VersionNotFoundException when message format is unknown");
		} catch (Exception e) {
//			log.info("Exception class is : " + e.getClass());
			assertTrue("Expecting VersionNotFoundException when message format is unknown", e instanceof VersionNotFoundException);
//			log.info("Expected: " + e.getMessage());
		}

		try {
			helper.getXsdPath(MessageType.INVOICE,MessageFormat.UBL, "0.0.0");
			fail("Expecting VersionNotFoundException when message version is unknown");
		} catch (Exception e) {
//			log.info("Exception class is : " + e.getClass());
			assertTrue("Expecting VersionNotFoundException when message version is unknown", e instanceof VersionNotFoundException);
//			log.info("Expected : " + e.getMessage());
		}

		// try {
		// helper.getXsdPath(MessageType.INVOICE,MessageFormat.UBL, "%%%%%");
		// fail("Expecting VersionNotFoundException when message version is invalid format");
		// } catch (Exception e) {
		// log.info("Exception class is : " + e.getClass());
		// assertTrue("Expecting VersionNotFoundException when message version is invalid format", e instanceof VersionNotFoundException);
		// log.info("Expected : " + e.getMessage());
		// }
	}
	
	@Test
	public void testRegularExpressions() {
		try {
			helper.versionToPath(Constants.MESSAGE_VERSION_UBL_1_1);
			helper.versionToPath(Constants.MESSAGE_VERSION_UBL_1_6_2);
			helper.versionToPath(Constants.MESSAGE_VERSION_UBL_1_6_3);
			helper.versionToPath(Constants.MESSAGE_VERSION_UBL_1_7);
			helper.versionToPath(Constants.MESSAGE_VERSION_UBL_1_8_beta2);
			helper.versionToPath(Constants.MESSAGE_VERSION_SETU_1_1);
			helper.versionToPath(Constants.MESSAGE_VERSION_SETU_1_6_4);
			helper.versionToPath(Constants.MESSAGE_VERSION_SETU_1_7);
			helper.versionToPath(Constants.MESSAGE_VERSION_SETU_1_8);
			helper.versionToPath(Constants.MESSAGE_VERSION_SETU_1_8_1_beta01);
		} catch (Exception e) {
			e.printStackTrace();
			assertFalse("Test should not throw Exception !", true);
		}
	}
}
