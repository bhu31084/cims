// Decompiled by Jad v1.5.8e. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: packimports(5) braces fieldsfirst noctor nonlb space lnc 
// Source File Name:   SMTPAuthenticator.java

package in.co.paramatrix.csms.common;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class SMTPAuthenticator extends Authenticator {

            private final String SMTP_AUTH_USER = "bhushan.fegade@paramatrix.co.in";
            private final String SMTP_AUTH_PWD = "hemantdada";


            public PasswordAuthentication getPasswordAuthentication() {
/*  15*/        String username = "bhushan.fegade@paramatrix.co.in";
/*  16*/        String password = "hemantdada";
/*  17*/        return new PasswordAuthentication(username, password);
            }
}
