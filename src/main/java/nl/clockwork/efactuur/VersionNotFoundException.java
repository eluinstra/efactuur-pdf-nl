package nl.clockwork.efactuur;


public class VersionNotFoundException extends RuntimeException {
	private static final long serialVersionUID = 1L;

	public VersionNotFoundException(String message) {
		super(message);
	}
}
