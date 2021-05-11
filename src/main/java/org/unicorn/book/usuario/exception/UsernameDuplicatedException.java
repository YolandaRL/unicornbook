package org.unicorn.book.usuario.exception;

/**
 *
 */
public class UsernameDuplicatedException extends Exception {
    public UsernameDuplicatedException(String message) {
        super(message);
    }

    public UsernameDuplicatedException(String message, Throwable cause) {
        super(message, cause);
    }
}
