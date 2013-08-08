// Decompiled by Jad v1.5.8e. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: packimports(5) braces fieldsfirst noctor nonlb space lnc 
// Source File Name:   GenericException.java

package in.co.paramatrix.common.exceptions;


public class GenericException extends Exception {

            private static final long serialVersionUID = 1L;
            private String message;
            private int code;

            public GenericException() {
/*  16*/        message = "";
/*  19*/        code = -1;
            }

            public GenericException(String msg) {
/*  31*/        super(msg);
/*  16*/        message = "";
/*  19*/        code = -1;
/*  32*/        message = msg;
            }

            public GenericException(String msg, Throwable cause) {
/*  40*/        super(msg);
/*  16*/        message = "";
/*  19*/        code = -1;
/*  41*/        message = msg;
            }

            public GenericException(String msg, int status_code) {
/*  49*/        super(msg);
/*  16*/        message = "";
/*  19*/        code = -1;
/*  50*/        message = msg;
/*  51*/        code = status_code;
            }

            public GenericException(int status_code) {
/*  16*/        message = "";
/*  19*/        code = -1;
/*  58*/        code = status_code;
            }

            public int getStatusCode() {
/*  65*/        return code;
            }

            public int getErrorCode() {
/*  72*/        return code;
            }

            public String getErrorMessage() {
/*  80*/        return message;
            }

            public String getMessage() {
/*  88*/        return message;
            }

            public String toString() {
/*  95*/        return message;
            }
}
