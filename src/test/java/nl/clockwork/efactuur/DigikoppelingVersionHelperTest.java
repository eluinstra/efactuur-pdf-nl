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

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatExceptionOfType;
import static org.junit.jupiter.params.provider.Arguments.arguments;

import java.util.Optional;
import java.util.stream.Stream;

import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.TestInstance;
import org.junit.jupiter.api.TestInstance.Lifecycle;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.MethodSource;

import nl.clockwork.efactuur.Constants.MessageFormat;
import nl.clockwork.efactuur.Constants.MessageType;

@TestInstance(Lifecycle.PER_CLASS)
public class DigikoppelingVersionHelperTest
{
	DigikoppelingVersionHelper helper = new DigikoppelingVersionHelper();

	@ParameterizedTest
	@MethodSource
	void testUblXsdVersion(String version, Optional<String> path) throws VersionNotFoundException
	{
		assertThat(helper.getXsdPath(MessageType.INVOICE,MessageFormat.UBL,version)).isEqualTo(path);
		path.ifPresent(p -> assertThat(getClass().getResource(p)).isNotNull());
	}

	private Stream<Arguments> testUblXsdVersion()
	{
		return Stream.of(arguments(Constants.MESSAGE_VERSION_UBL_1_1,Optional.of("/nl/clockwork/efactuur/nl/domain/ubl/1.1/xsd/maindoc/Invoice.xsd")),
				arguments(Constants.MESSAGE_VERSION_UBL_1_6_3,Optional.of("/nl/clockwork/efactuur/nl/domain/ubl/1.6.3/xsd/maindoc/Invoice.xsd")),
				arguments(Constants.MESSAGE_VERSION_UBL_1_7,Optional.of("/nl/clockwork/efactuur/nl/domain/ubl/1.7/xsd/maindoc/Invoice.xsd")),
				arguments(Constants.MESSAGE_VERSION_UBL_1_8,Optional.of("/nl/clockwork/efactuur/nl/domain/ubl/1.8/xsd/maindoc/Invoice.xsd")),
				arguments(Constants.MESSAGE_VERSION_UBL_1_9,Optional.of("/nl/clockwork/efactuur/nl/domain/ubl/1.9/xsd/maindoc/Invoice.xsd")),
				arguments(Constants.MESSAGE_VERSION_UBL_2_0,Optional.of("/nl/clockwork/efactuur/nl/domain/ubl/2.0/xsd/maindoc/UBL-Invoice-2.1.xsd")));
	}

	@ParameterizedTest
	@MethodSource
	void testSetuXsdVersion(String version, Optional<String> path) throws VersionNotFoundException
	{
		assertThat(helper.getXsdPath(MessageType.INVOICE,MessageFormat.SETU,version)).isEqualTo(path);
		path.ifPresent(p -> assertThat(getClass().getResource(p)).isNotNull());
	}

	private Stream<Arguments> testSetuXsdVersion()
	{
		return Stream.of(
				arguments(Constants.MESSAGE_VERSION_SETU_1_6_4,Optional.of("/nl/clockwork/efactuur/nl/domain/setu/1.6.4/SIDES/NL/2011-02/InvoiceLogiusNL.xsd")),
				arguments(Constants.MESSAGE_VERSION_SETU_1_7,Optional.of("/nl/clockwork/efactuur/nl/domain/setu/1.7/SIDES/NL/2011-02/InvoiceLogiusNL.xsd")),
				arguments(Constants.MESSAGE_VERSION_SETU_1_8,Optional.of("/nl/clockwork/efactuur/nl/domain/setu/1.8/SIDES/NL/2011-02/InvoiceLogiusNL.xsd")),
				arguments(Constants.MESSAGE_VERSION_SETU_2_0,Optional.of("/nl/clockwork/efactuur/nl/domain/setu/2.0/SIDES/NL/2015-02/InvoiceOrdinaNL.xsd")));
	}

	@ParameterizedTest
	@MethodSource
	void testUblGenericodeVersion(String version, Optional<String> path) throws VersionNotFoundException
	{
		assertThat(helper.getGenericodeXslPath(MessageType.INVOICE,MessageFormat.UBL,version)).isEqualTo(path);
		path.ifPresent(p -> assertThat(getClass().getResource(p)).isNotNull());
	}

	private Stream<Arguments> testUblGenericodeVersion()
	{
		return Stream.of(arguments(Constants.MESSAGE_VERSION_UBL_1_1,Optional.of("/nl/clockwork/efactuur/nl/domain/ubl/1.1/Genericode-Validation.xsl")),
				arguments(Constants.MESSAGE_VERSION_UBL_1_6_3,Optional.of("/nl/clockwork/efactuur/nl/domain/ubl/1.6.3/Genericode-Validation.xsl")),
				arguments(Constants.MESSAGE_VERSION_UBL_1_7,Optional.of("/nl/clockwork/efactuur/nl/domain/ubl/1.7/Genericode-Validation.xsl")),
				arguments(Constants.MESSAGE_VERSION_UBL_1_8,Optional.of("/nl/clockwork/efactuur/nl/domain/ubl/1.8/Genericode-Validation.xsl")),
				arguments(Constants.MESSAGE_VERSION_UBL_1_9,Optional.of("/nl/clockwork/efactuur/nl/domain/ubl/1.9/Genericode-Validation.xsl")),
				arguments(Constants.MESSAGE_VERSION_UBL_2_0,Optional.empty()));
	}

	@ParameterizedTest
	@MethodSource
	void testUblSchematronVersion(String version, Optional<String> path) throws VersionNotFoundException
	{
		assertThat(helper.getSchematronXslPath(MessageType.INVOICE,MessageFormat.UBL,version)).isEqualTo(path);
		path.ifPresent(p -> assertThat(getClass().getResource(p)).isNotNull());
	}

	private Stream<Arguments> testUblSchematronVersion()
	{
		return Stream.of(arguments(Constants.MESSAGE_VERSION_UBL_1_1,Optional.of("/nl/clockwork/efactuur/nl/domain/ubl/1.1/Invoice-Schematron-Validation.xsl")),
				arguments(Constants.MESSAGE_VERSION_UBL_1_6_3,Optional.of("/nl/clockwork/efactuur/nl/domain/ubl/1.6.3/Invoice-Schematron-Validation.xsl")),
				arguments(Constants.MESSAGE_VERSION_UBL_1_7,Optional.of("/nl/clockwork/efactuur/nl/domain/ubl/1.7/Invoice-Schematron-Validation.xsl")),
				arguments(Constants.MESSAGE_VERSION_UBL_1_8,Optional.of("/nl/clockwork/efactuur/nl/domain/ubl/1.8/Invoice-Schematron-Validation.xsl")),
				arguments(Constants.MESSAGE_VERSION_UBL_1_9,Optional.of("/nl/clockwork/efactuur/nl/domain/ubl/1.9/Invoice-Schematron-Validation.xsl")),
				arguments(Constants.MESSAGE_VERSION_UBL_2_0,Optional.of("/nl/clockwork/efactuur/nl/domain/ubl/2.0/si-ubl-2.0.3.5.xsl")));
	}

	@ParameterizedTest
	@MethodSource
	void testSetuSchematronVersion(String version, Optional<String> path) throws VersionNotFoundException
	{
		assertThat(helper.getSchematronXslPath(MessageType.INVOICE,MessageFormat.SETU,version)).isEqualTo(path);
		path.ifPresent(p -> assertThat(getClass().getResource(p)).isNotNull());
	}

	private Stream<Arguments> testSetuSchematronVersion()
	{
		return Stream.of(
				arguments(Constants.MESSAGE_VERSION_SETU_1_6_4,Optional.of("/nl/clockwork/efactuur/nl/domain/setu/1.6.4/Invoice-Schematron-Validation.xsl")),
				arguments(Constants.MESSAGE_VERSION_SETU_1_7,Optional.of("/nl/clockwork/efactuur/nl/domain/setu/1.7/Invoice-Schematron-Validation.xsl")),
				arguments(Constants.MESSAGE_VERSION_SETU_1_8,Optional.of("/nl/clockwork/efactuur/nl/domain/setu/1.8/Invoice-Schematron-Validation.xsl")),
				arguments(Constants.MESSAGE_VERSION_SETU_2_0,Optional.of("/nl/clockwork/efactuur/nl/domain/setu/2.0/Invoice-Schematron-Validation.xsl")));
	}

	@ParameterizedTest
	@MethodSource
	void testIllegalArgumentXsdPath(MessageType type, MessageFormat format, String version) throws VersionNotFoundException
	{
		Assertions.assertThatIllegalArgumentException().isThrownBy(() -> helper.getXsdPath(type,format,version));
	}

	private Stream<Arguments> testIllegalArgumentXsdPath()
	{
		return Stream.of(arguments(null,null,null),
				arguments(null,null,""),
				arguments(null,null,"0"),
				arguments(null,null,"a"),
				arguments(null,null,"A"),
				arguments(null,null,"!"),
				arguments(null,null,Constants.MESSAGE_VERSION_SETU_1_8));
	}

	@ParameterizedTest
	@MethodSource
	void testInvalidXsdPath(MessageType type, MessageFormat format, String version) throws VersionNotFoundException
	{
		assertThatExceptionOfType(VersionNotFoundException.class).isThrownBy(() -> helper.getXsdPath(type,format,version));
	}

	private Stream<Arguments> testInvalidXsdPath()
	{
		return Stream.of(arguments(MessageType.INVOICE,MessageFormat.UBL,"0.0.0"));
	}

	@ParameterizedTest
	@MethodSource
	void testIllegalArgumentGenericodeXslPath(MessageType type, MessageFormat format, String version) throws VersionNotFoundException
	{
		Assertions.assertThatIllegalArgumentException().isThrownBy(() -> helper.getGenericodeXslPath(type,format,version));
	}

	private Stream<Arguments> testIllegalArgumentGenericodeXslPath()
	{
		return Stream.of(arguments(null,null,null),
				arguments(null,null,""),
				arguments(null,null,"0"),
				arguments(null,null,"a"),
				arguments(null,null,"A"),
				arguments(null,null,"!"),
				arguments(null,null,Constants.MESSAGE_VERSION_SETU_1_8));
	}

	@ParameterizedTest
	@MethodSource
	void testInvalidGenericodeXslPath(MessageType type, MessageFormat format, String version) throws VersionNotFoundException
	{
		assertThatExceptionOfType(VersionNotFoundException.class).isThrownBy(() -> helper.getGenericodeXslPath(type,format,version));
	}

	private Stream<Arguments> testInvalidGenericodeXslPath()
	{
		return Stream.of(arguments(MessageType.INVOICE,MessageFormat.SETU,Constants.MESSAGE_VERSION_SETU_1_6_4),
				arguments(MessageType.INVOICE,MessageFormat.SETU,Constants.MESSAGE_VERSION_SETU_1_7),
				arguments(MessageType.INVOICE,MessageFormat.SETU,Constants.MESSAGE_VERSION_SETU_1_8),
				arguments(MessageType.INVOICE,MessageFormat.UBL,"0.0.0"));
	}

	@ParameterizedTest
	@MethodSource
	void testIllegalArgumentSchematronXslPath(MessageType type, MessageFormat format, String version) throws VersionNotFoundException
	{
		Assertions.assertThatIllegalArgumentException().isThrownBy(() -> helper.getSchematronXslPath(type,format,version));
	}

	private Stream<Arguments> testIllegalArgumentSchematronXslPath()
	{
		return Stream.of(arguments(null,null,null),
				arguments(null,null,""),
				arguments(null,null,"0"),
				arguments(null,null,"a"),
				arguments(null,null,"A"),
				arguments(null,null,"!"),
				arguments(null,null,Constants.MESSAGE_VERSION_SETU_1_8));
	}

	@ParameterizedTest
	@MethodSource
	void testInvalidSchematronXslPath(MessageType type, MessageFormat format, String version) throws VersionNotFoundException
	{
		assertThatExceptionOfType(VersionNotFoundException.class).isThrownBy(() -> helper.getSchematronXslPath(type,format,version));
	}

	private Stream<Arguments> testInvalidSchematronXslPath()
	{
		return Stream.of(arguments(MessageType.INVOICE,MessageFormat.UBL,"0.0.0"));
	}
}
