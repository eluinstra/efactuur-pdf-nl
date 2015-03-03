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

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;
import nl.clockwork.efactuur.Constants;
import nl.clockwork.efactuur.Constants.MessageFormat;
import nl.clockwork.efactuur.Constants.MessageType;
import nl.clockwork.efactuur.DigikoppelingVersionHelper;
import nl.clockwork.efactuur.VersionNotFoundException;

import org.junit.Test;

public class DigikoppelingVersionHelperTest
{

	DigikoppelingVersionHelper helper = new DigikoppelingVersionHelper();

	@Test
	public void testXsdVersions()
	{

		try
		{
			assertFalse("UBL 1.1 should return some path",helper.getXsdPath(MessageType.INVOICE,MessageFormat.UBL,Constants.MESSAGE_VERSION_UBL_1_1).equals(""));
			assertFalse("UBL 1.6 should return some path",helper.getXsdPath(MessageType.INVOICE,MessageFormat.UBL,Constants.MESSAGE_VERSION_UBL_1_6_3).equals(""));
			assertFalse("UBL 1.7 should return some path",helper.getXsdPath(MessageType.INVOICE,MessageFormat.UBL,Constants.MESSAGE_VERSION_UBL_1_7).equals(""));
			assertFalse("UBL 1.8 should return some path",helper.getXsdPath(MessageType.INVOICE,MessageFormat.UBL,Constants.MESSAGE_VERSION_UBL_1_8).equals(""));
			assertFalse("UBL 1.9 should return some path",helper.getXsdPath(MessageType.INVOICE,MessageFormat.UBL,Constants.MESSAGE_VERSION_UBL_1_9).equals(""));

			assertFalse("SETU 1.6.x should return some path",helper
					.getXsdPath(MessageType.INVOICE,MessageFormat.SETU,Constants.MESSAGE_VERSION_SETU_1_6_4)
					.equals(""));
			assertFalse("SETU 1.7 should return some path",helper.getXsdPath(MessageType.INVOICE,MessageFormat.SETU,Constants.MESSAGE_VERSION_SETU_1_7).equals(""));
			assertFalse("SETU 1.8 should return some path",helper.getXsdPath(MessageType.INVOICE,MessageFormat.SETU,Constants.MESSAGE_VERSION_SETU_1_8).equals(""));
			assertFalse("SETU 2.0 should return some path",helper.getXsdPath(MessageType.INVOICE,MessageFormat.SETU,Constants.MESSAGE_VERSION_SETU_2_0).equals(""));

		}
		catch (VersionNotFoundException e)
		{
			e.printStackTrace();
			assertFalse("Test should not throw exceptions",true);
		}
	}

	@Test
	public void testGenericodeVersions()
	{
		try
		{
			assertFalse("UBL 1.1 should return some path",helper
					.getGenericodeXslPath(MessageType.INVOICE,MessageFormat.UBL,Constants.MESSAGE_VERSION_UBL_1_1)
					.equals(""));
			assertFalse("UBL 1.6 should return some path",helper
					.getGenericodeXslPath(MessageType.INVOICE,MessageFormat.UBL,Constants.MESSAGE_VERSION_UBL_1_6_3)
					.equals(""));
			assertFalse("UBL 1.7 should return some path",helper
					.getGenericodeXslPath(MessageType.INVOICE,MessageFormat.UBL,Constants.MESSAGE_VERSION_UBL_1_7)
					.equals(""));
			assertFalse("UBL 1.8 should return some path",helper
					.getGenericodeXslPath(MessageType.INVOICE,MessageFormat.UBL,Constants.MESSAGE_VERSION_UBL_1_8)
					.equals(""));
			assertFalse("UBL 1.9 should return some path",helper
					.getGenericodeXslPath(MessageType.INVOICE,MessageFormat.UBL,Constants.MESSAGE_VERSION_UBL_1_9)
					.equals(""));
		}
		catch (VersionNotFoundException e)
		{
			e.printStackTrace();
			assertFalse("Test should not throw exceptions",true);
		}
	}

	@Test
	public void testSchematronVersions()
	{
		try
		{
			assertFalse("UBL 1.1 should return some path",helper
					.getSchematronXslPath(MessageType.INVOICE,MessageFormat.UBL,Constants.MESSAGE_VERSION_UBL_1_1)
					.equals(""));
			assertFalse("UBL 1.6 should return some path",helper
					.getSchematronXslPath(MessageType.INVOICE,MessageFormat.UBL,Constants.MESSAGE_VERSION_UBL_1_6_3)
					.equals(""));
			assertFalse("UBL 1.7 should return some path",helper
					.getSchematronXslPath(MessageType.INVOICE,MessageFormat.UBL,Constants.MESSAGE_VERSION_UBL_1_7)
					.equals(""));
			assertFalse("UBL 1.8 should return some path",helper
					.getSchematronXslPath(MessageType.INVOICE,MessageFormat.UBL,Constants.MESSAGE_VERSION_UBL_1_8)
					.equals(""));
			assertFalse("UBL 1.9 should return some path",helper
					.getSchematronXslPath(MessageType.INVOICE,MessageFormat.UBL,Constants.MESSAGE_VERSION_UBL_1_9)
					.equals(""));

			assertFalse("SETU 1.6.x should return some path",helper
					.getSchematronXslPath(MessageType.INVOICE,MessageFormat.SETU,Constants.MESSAGE_VERSION_SETU_1_6_4)
					.equals(""));
			assertFalse("SETU 1.7 should return some path",helper
					.getSchematronXslPath(MessageType.INVOICE,MessageFormat.SETU,Constants.MESSAGE_VERSION_SETU_1_7)
					.equals(""));
			assertFalse("SETU 1.8 should return some path",helper
					.getSchematronXslPath(MessageType.INVOICE,MessageFormat.SETU,Constants.MESSAGE_VERSION_SETU_1_8)
					.equals(""));
			assertFalse("SETU 2.0 should return some path",helper
					.getSchematronXslPath(MessageType.INVOICE,MessageFormat.SETU,Constants.MESSAGE_VERSION_SETU_2_0)
					.equals(""));
		}
		catch (VersionNotFoundException e)
		{
			e.printStackTrace();
			assertFalse("Test should not throw exceptions",true);
		}
	}

	@Test
	public void testXsdVersionsRainyDay()
	{
		try
		{
			helper.getXsdPath(null,null,Constants.MESSAGE_VERSION_SETU_1_8);
			fail("Expecting VersionNotFoundException when message format is unknown");
		}
		catch (Exception e)
		{
			assertTrue("Expecting VersionNotFoundException when message format is unknown",e instanceof VersionNotFoundException);
		}

		try
		{
			helper.getXsdPath(MessageType.INVOICE,MessageFormat.UBL,"0.0.0");
			fail("Expecting VersionNotFoundException when message version is unknown");
		}
		catch (Exception e)
		{
			assertTrue("Expecting VersionNotFoundException when message version is unknown",e instanceof VersionNotFoundException);
		}
	}

	@Test
	public void testGenericodeVersionsRainyDay()
	{

		try
		{
			helper.getGenericodeXslPath(MessageType.INVOICE,MessageFormat.SETU,Constants.MESSAGE_VERSION_SETU_1_6_4);
			fail("Expecting VersionNotFoundException when message format is SETU, since SETU does not have schematron validations");
		}
		catch (Exception e)
		{
			assertTrue(
					"Expecting VersionNotFoundException when message format is SETU, since SETU does not have schematron validations",
					e instanceof VersionNotFoundException);
		}

		try
		{
			helper.getGenericodeXslPath(MessageType.INVOICE,MessageFormat.SETU,Constants.MESSAGE_VERSION_SETU_1_7);
			fail("Expecting VersionNotFoundException when message format is SETU, since SETU does not have schematron validations");
		}
		catch (Exception e)
		{
			assertTrue(
					"Expecting VersionNotFoundException when message format is SETU, since SETU does not have schematron validations",
					e instanceof VersionNotFoundException);
		}

		try
		{
			helper.getGenericodeXslPath(MessageType.INVOICE,MessageFormat.SETU,Constants.MESSAGE_VERSION_SETU_1_8);
			fail("Expecting VersionNotFoundException when message format is SETU, since SETU does not have schematron validations");
		}
		catch (Exception e)
		{
			assertTrue(
					"Expecting VersionNotFoundException when message format is SETU, since SETU does not have schematron validations",
					e instanceof VersionNotFoundException);
		}

		try
		{
			helper.getGenericodeXslPath(null,null,Constants.MESSAGE_VERSION_SETU_1_8);
			fail("Expecting VersionNotFoundException when message format is unknown");
		}
		catch (Exception e)
		{
			assertTrue("Expecting VersionNotFoundException when message format is unknown",e instanceof VersionNotFoundException);
		}

		try
		{
			helper.getGenericodeXslPath(MessageType.INVOICE,MessageFormat.UBL,"0.0.0");
			fail("Expecting VersionNotFoundException when message version is unknown");
		}
		catch (Exception e)
		{
			assertTrue("Expecting VersionNotFoundException when message version is unknown",e instanceof VersionNotFoundException);
		}
	}

	@Test
	public void testSchematronVersionsRainyDay()
	{
		try
		{
			helper.getSchematronXslPath(null,null,Constants.MESSAGE_VERSION_SETU_1_8);
			fail("Expecting VersionNotFoundException when message format is unknown");
		}
		catch (Exception e)
		{
			assertTrue("Expecting VersionNotFoundException when message format is unknown",e instanceof VersionNotFoundException);
		}

		try
		{
			helper.getXsdPath(MessageType.INVOICE,MessageFormat.UBL,"0.0.0");
			fail("Expecting VersionNotFoundException when message version is unknown");
		}
		catch (Exception e)
		{
			assertTrue("Expecting VersionNotFoundException when message version is unknown",e instanceof VersionNotFoundException);
		}
	}

	@Test
	public void testRegularExpressions()
	{
		try
		{
			helper.versionToPath(Constants.MESSAGE_VERSION_UBL_1_1);
			helper.versionToPath(Constants.MESSAGE_VERSION_UBL_1_6_2);
			helper.versionToPath(Constants.MESSAGE_VERSION_UBL_1_6_3);
			helper.versionToPath(Constants.MESSAGE_VERSION_UBL_1_7);
			helper.versionToPath(Constants.MESSAGE_VERSION_UBL_1_8);
			helper.versionToPath(Constants.MESSAGE_VERSION_UBL_1_8_beta2);
			helper.versionToPath(Constants.MESSAGE_VERSION_UBL_1_9);
			helper.versionToPath(Constants.MESSAGE_VERSION_SETU_1_1);
			helper.versionToPath(Constants.MESSAGE_VERSION_SETU_1_6_4);
			helper.versionToPath(Constants.MESSAGE_VERSION_SETU_1_7);
			helper.versionToPath(Constants.MESSAGE_VERSION_SETU_1_8);
			helper.versionToPath(Constants.MESSAGE_VERSION_SETU_1_8_1_beta01);
			helper.versionToPath(Constants.MESSAGE_VERSION_SETU_2_0);
		}
		catch (Exception e)
		{
			e.printStackTrace();
			assertFalse("Test should not throw exception",true);
		}
	}
}
