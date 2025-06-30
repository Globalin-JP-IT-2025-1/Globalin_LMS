package com.library.exception;

@SuppressWarnings("serial")
public class LoanNotAllowedException extends RuntimeException {

	public LoanNotAllowedException(String message) {
		super(message);
	}

	public LoanNotAllowedException(String message, Throwable cause) {
		super(message, cause);
	}
}
