// Decompiled by Jad v1.5.8e. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: packimports(5) braces fieldsfirst noctor nonlb space lnc 
// Source File Name:   LimitCrossed.java

package in.co.paramatrix.common.exceptions;


// Referenced classes of package in.co.paramatrix.common.exceptions:
//            GenericException

public class LimitCrossed extends GenericException {

            private static final long serialVersionUID = 1L;
            private String str;
            private int statusCode;

            public LimitCrossed() {
/*  15*/        str = "No Free Connection Exception.";
/*  18*/        statusCode = 122;
            }

            public LimitCrossed(String msg) {
/*  30*/        super(msg);
/*  15*/        str = "No Free Connection Exception.";
/*  18*/        statusCode = 122;
/*  31*/        str = msg;
            }

            public LimitCrossed(String msg, Throwable cause) {
/*  39*/        super(msg);
/*  15*/        str = "No Free Connection Exception.";
/*  18*/        statusCode = 122;
/*  40*/        str = msg;
            }

            public int getStatusCode() {
/*  47*/        return statusCode;
            }

            public String getMessage() {
/*  54*/        return str;
            }

            public String toString() {
/*  61*/        return str;
            }
}
