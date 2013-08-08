// Decompiled by Jad v1.5.8e. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: packimports(5) braces fieldsfirst noctor nonlb space lnc 
// Source File Name:   NoImplementation.java

package in.co.paramatrix.common.exceptions;


// Referenced classes of package in.co.paramatrix.common.exceptions:
//            GenericException

public class NoImplementation extends GenericException {

            private static final long serialVersionUID = 1L;
            private String str;
            private int statusCode;

            public NoImplementation() {
/*  16*/        str = "NoImplementation";
/*  19*/        statusCode = 112;
            }

            public NoImplementation(String msg) {
/*  31*/        super(msg);
/*  16*/        str = "NoImplementation";
/*  19*/        statusCode = 112;
/*  32*/        str = msg;
            }

            public NoImplementation(String msg, Throwable cause) {
/*  40*/        super(msg);
/*  16*/        str = "NoImplementation";
/*  19*/        statusCode = 112;
/*  41*/        str = msg;
            }

            public int getStatusCode() {
/*  48*/        return statusCode;
            }

            public String getMessage() {
/*  55*/        return str;
            }

            public String toString() {
/*  62*/        return str;
            }
}
