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
	public int hashCode()
	{
		final int prime = 31;
		int result = 1;
		result = prime * result + ((messageFormat == null) ? 0 : messageFormat.hashCode());
		result = prime * result + ((messageType == null) ? 0 : messageType.hashCode());
		result = prime * result + ((validationType == null) ? 0 : validationType.hashCode());
		result = prime * result + ((version == null) ? 0 : version.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj)
	{
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Version other = (Version)obj;
		if (messageFormat != other.messageFormat)
			return false;
		if (messageType != other.messageType)
			return false;
		if (validationType != other.validationType)
			return false;
		if (version == null)
		{
			if (other.version != null)
				return false;
		}
		else if (!version.equals(other.version))
			return false;
		return true;
	}

}
