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

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.fail;

import org.junit.jupiter.api.Test;

import nl.clockwork.efactuur.Constants.MessageFormat;
import nl.clockwork.efactuur.Constants.MessageType;

public class DigikoppelingVersionHelperTest
{
	DigikoppelingVersionHelper helper = new DigikoppelingVersionHelper();

	@Test
	public void testXsdVersions()
	{

		try
		{
			assertFalse(helper.getXsdPath(MessageType.INVOICE,MessageFormat.UBL,Constants.MESSAGE_VERSION_UBL_1_1).equals(""),"UBL 1.1 should return some path");
			assertFalse(helper.getXsdPath(MessageType.INVOICE,MessageFormat.UBL,Constants.MESSAGE_VERSION_UBL_1_6_3).equals(""),"UBL 1.6 should return some path");
			assertFalse(helper.getXsdPath(MessageType.INVOICE,MessageFormat.UBL,Constants.MESSAGE_VERSION_UBL_1_7).equals(""),"UBL 1.7 should return some path");
			assertFalse(helper.getXsdPath(MessageType.INVOICE,MessageFormat.UBL,Constants.MESSAGE_VERSION_UBL_1_8).equals(""),"UBL 1.8 should return some path");
			assertFalse(helper.getXsdPath(MessageType.INVOICE,MessageFormat.UBL,Constants.MESSAGE_VERSION_UBL_1_9).equals(""),"UBL 1.9 should return some path");

			assertFalse(helper.getXsdPath(MessageType.INVOICE,MessageFormat.SETU,Constants.MESSAGE_VERSION_SETU_1_6_4).equals(""),"SETU 1.6.x should return some path");
			assertFalse(helper.getXsdPath(MessageType.INVOICE,MessageFormat.SETU,Constants.MESSAGE_VERSION_SETU_1_7).equals(""),"SETU 1.7 should return some path");
			assertFalse(helper.getXsdPath(MessageType.INVOICE,MessageFormat.SETU,Constants.MESSAGE_VERSION_SETU_1_8).equals(""),"SETU 1.8 should return some path");
			assertFalse(helper.getXsdPath(MessageType.INVOICE,MessageFormat.SETU,Constants.MESSAGE_VERSION_SETU_2_0).equals(""),"SETU 2.0 should return some path");
		}
		catch (VersionNotFoundException e)
		{
			e.printStackTrace();
			assertFalse(true,"Test should not throw exceptions");
		}
	}

	@Test
	public void testGenericodeVersions()
	{
		try
		{
			assertFalse(helper.getGenericodeXslPath(MessageType.INVOICE,MessageFormat.UBL,Constants.MESSAGE_VERSION_UBL_1_1).equals(""),"UBL 1.1 should return some path");
			assertFalse(helper.getGenericodeXslPath(MessageType.INVOICE,MessageFormat.UBL,Constants.MESSAGE_VERSION_UBL_1_6_3).equals(""),"UBL 1.6 should return some path");
			assertFalse(helper.getGenericodeXslPath(MessageType.INVOICE,MessageFormat.UBL,Constants.MESSAGE_VERSION_UBL_1_7).equals(""),"UBL 1.7 should return some path");
			assertFalse(helper.getGenericodeXslPath(MessageType.INVOICE,MessageFormat.UBL,Constants.MESSAGE_VERSION_UBL_1_8).equals(""),"UBL 1.8 should return some path");
			assertFalse(helper.getGenericodeXslPath(MessageType.INVOICE,MessageFormat.UBL,Constants.MESSAGE_VERSION_UBL_1_9).equals(""),"UBL 1.9 should return some path");
		}
		catch (VersionNotFoundException e)
		{
			e.printStackTrace();
			assertFalse(true,"Test should not throw exceptions");
		}
	}

	@Test
	public void testSchematronVersions()
	{
		try
		{
			assertFalse(helper.getSchematronXslPath(MessageType.INVOICE,MessageFormat.UBL,Constants.MESSAGE_VERSION_UBL_1_1).equals(""),"UBL 1.1 should return some path");
			assertFalse(helper.getSchematronXslPath(MessageType.INVOICE,MessageFormat.UBL,Constants.MESSAGE_VERSION_UBL_1_6_3).equals(""),"UBL 1.6 should return some path");
			assertFalse(helper.getSchematronXslPath(MessageType.INVOICE,MessageFormat.UBL,Constants.MESSAGE_VERSION_UBL_1_7).equals(""),"UBL 1.7 should return some path");
			assertFalse(helper.getSchematronXslPath(MessageType.INVOICE,MessageFormat.UBL,Constants.MESSAGE_VERSION_UBL_1_8).equals(""),"UBL 1.8 should return some path");
			assertFalse(helper.getSchematronXslPath(MessageType.INVOICE,MessageFormat.UBL,Constants.MESSAGE_VERSION_UBL_1_9).equals(""),"UBL 1.9 should return some path");
			assertFalse(helper.getSchematronXslPath(MessageType.INVOICE,MessageFormat.SETU,Constants.MESSAGE_VERSION_SETU_1_6_4).equals(""),"SETU 1.6.x should return some path");
			assertFalse(helper.getSchematronXslPath(MessageType.INVOICE,MessageFormat.SETU,Constants.MESSAGE_VERSION_SETU_1_7).equals(""),"SETU 1.7 should return some path");
			assertFalse(helper.getSchematronXslPath(MessageType.INVOICE,MessageFormat.SETU,Constants.MESSAGE_VERSION_SETU_1_8).equals(""),"SETU 1.8 should return some path");
			assertFalse(helper.getSchematronXslPath(MessageType.INVOICE,MessageFormat.SETU,Constants.MESSAGE_VERSION_SETU_2_0).equals(""),"SETU 2.0 should return some path");
		}
		catch (VersionNotFoundException e)
		{
			e.printStackTrace();
			assertFalse(true,"Test should not throw exceptions");
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
			assertTrue(e instanceof VersionNotFoundException,"Expecting VersionNotFoundException when message format is unknown");
		}

		try
		{
			helper.getXsdPath(MessageType.INVOICE,MessageFormat.UBL,"0.0.0");
			fail("Expecting VersionNotFoundException when message version is unknown");
		}
		catch (Exception e)
		{
			assertTrue(e instanceof VersionNotFoundException,"Expecting VersionNotFoundException when message version is unknown");
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
			assertTrue(e instanceof VersionNotFoundException,"Expecting VersionNotFoundException when message format is SETU, since SETU does not have schematron validations");
		}

		try
		{
			helper.getGenericodeXslPath(MessageType.INVOICE,MessageFormat.SETU,Constants.MESSAGE_VERSION_SETU_1_7);
			fail("Expecting VersionNotFoundException when message format is SETU, since SETU does not have schematron validations");
		}
		catch (Exception e)
		{
			assertTrue(e instanceof VersionNotFoundException,"Expecting VersionNotFoundException when message format is SETU, since SETU does not have schematron validations");
		}

		try
		{
			helper.getGenericodeXslPath(MessageType.INVOICE,MessageFormat.SETU,Constants.MESSAGE_VERSION_SETU_1_8);
			fail("Expecting VersionNotFoundException when message format is SETU, since SETU does not have schematron validations");
		}
		catch (Exception e)
		{
			assertTrue(e instanceof VersionNotFoundException,"Expecting VersionNotFoundException when message format is SETU, since SETU does not have schematron validations");
		}

		try
		{
			helper.getGenericodeXslPath(null,null,Constants.MESSAGE_VERSION_SETU_1_8);
			fail("Expecting VersionNotFoundException when message format is unknown");
		}
		catch (Exception e)
		{
			assertTrue(e instanceof VersionNotFoundException,"Expecting VersionNotFoundException when message format is unknown");
		}

		try
		{
			helper.getGenericodeXslPath(MessageType.INVOICE,MessageFormat.UBL,"0.0.0");
			fail("Expecting VersionNotFoundException when message version is unknown");
		}
		catch (Exception e)
		{
			assertTrue(e instanceof VersionNotFoundException,"Expecting VersionNotFoundException when message version is unknown");
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
			assertTrue(e instanceof VersionNotFoundException,"Expecting VersionNotFoundException when message format is unknown");
		}

		try
		{
			helper.getXsdPath(MessageType.INVOICE,MessageFormat.UBL,"0.0.0");
			fail("Expecting VersionNotFoundException when message version is unknown");
		}
		catch (Exception e)
		{
			assertTrue(e instanceof VersionNotFoundException,"Expecting VersionNotFoundException when message version is unknown");
		}
	}
}
