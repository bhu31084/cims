// Decompiled by Jad v1.5.8e. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: packimports(5) braces fieldsfirst noctor nonlb space lnc 
// Source File Name:   ChangeInitial.java

package in.co.paramatrix.common;


public class ChangeInitial {


            public String properCase(String username) {
/*   9*/        String changedusername = "";
/*  10*/        username = username.toLowerCase();
/*  11*/        String usernameArr[] = username.trim().split(" ");
/*  13*/        for (int i = 0; i < usernameArr.length; i++) {
/*  14*/            String initialLetter = "";
/*  15*/            if (usernameArr[i].length() != 0) {
/*  16*/                initialLetter = usernameArr[i].trim().substring(0, usernameArr[i].trim().length() - (usernameArr[i].trim().length() - 1));
/*  17*/                initialLetter = initialLetter.toUpperCase();
/*  18*/                String remainingName = usernameArr[i].trim().substring(1);
/*  19*/                changedusername = (new StringBuilder(String.valueOf(changedusername))).append(" ").append(initialLetter.trim()).append(remainingName.trim()).toString();
                    }
                }

/*  24*/        return changedusername;
            }
}
