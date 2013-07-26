package nl.clockwork.efactuur;

import nl.clockwork.efactuur.Constants.MessageFormat;
import nl.clockwork.efactuur.Constants.MessageType;
import nl.clockwork.efactuur.Constants.ValidationType;

public interface VersionHelper {

	public String findPathFor(ValidationType validationType, MessageType messageType, MessageFormat format, String version);

	public String getCanonicalToPDFPath(MessageType type, MessageFormat format, String version);

	public String getInvoiceToCanonicalPath(MessageType type, MessageFormat format, String version);
	public String getXsdPath(MessageType type, MessageFormat format, String version);

	public String getGenericodeXslPath(MessageType type, MessageFormat format, String version);

	public String getSchematronXslPath(MessageType type, MessageFormat format, String version);

	public String getTestXmlPath(MessageType type, MessageFormat format, String version);

	public String versionToPath(String version);
}