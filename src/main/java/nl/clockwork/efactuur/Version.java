package nl.clockwork.efactuur;

import nl.clockwork.efactuur.Constants.MessageFormat;
import nl.clockwork.efactuur.Constants.MessageType;
import nl.clockwork.efactuur.Constants.ValidationType;

public class Version
{
	private ValidationType validationType;
	private MessageFormat messageFormat;
	private MessageType messageType;
	private String version;

	public Version(ValidationType validationType, MessageFormat messageFormat, MessageType messageType, String version)
	{
		this.validationType = validationType;
		this.messageFormat = messageFormat;
		this.messageType = messageType;
		this.version = version;
	}

	public ValidationType getValidationType()
	{
		return validationType;
	}
	
	public MessageFormat getMessageFormat()
	{
		return messageFormat;
	}
	
	public MessageType getMessageType()
	{
		return messageType;
	}
	
	public String getVersion()
	{
		return version;
	}
	
	@Override
	public boolean equals(Object object)
	{
		if (this == object)
			return true;
		if (!(object instanceof Version))
			return false;
		Version o = (Version)object;
		return validationType == null ? o.getValidationType() == null : validationType.equals(o.getValidationType())
			&& messageFormat == null ? o.getMessageFormat() == null : messageFormat.equals(o.getMessageFormat())
			&& messageType == null ? o.getMessageType() == null : messageType.equals(o.getMessageType())
			&& version == null ? o.getVersion() == null : version.equals(o.getVersion())
		;
	}
	
	@Override
	public int hashCode()
	{
		int hash = 1;
		hash = hash * 13 + (validationType == null ? 0 : validationType.hashCode());
		hash = hash * 17 + (messageFormat == null ? 0 : messageFormat.hashCode());
		hash = hash * 19 + (messageType == null ? 0 : messageType.hashCode());
		hash = hash * 23 + (version == null ? 0 : version.hashCode());
		return hash;
	}
}
