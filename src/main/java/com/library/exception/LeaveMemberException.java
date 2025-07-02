package com.library.exception;

import org.springframework.security.core.AuthenticationException;

@SuppressWarnings("serial")
public class LeaveMemberException extends AuthenticationException {
	
	public LeaveMemberException(String message) {
		super(message);
	}
	
}
