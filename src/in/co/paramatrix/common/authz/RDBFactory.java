// Decompiled by Jad v1.5.8e. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: packimports(5) braces fieldsfirst noctor nonlb space lnc 
// Source File Name:   RDBFactory.java

package in.co.paramatrix.common.authz;

import in.co.paramatrix.common.exceptions.NoImplementation;

// Referenced classes of package in.co.paramatrix.common.authz:
//            SqliteDb, MsSQLDb, AuthzDB

public class RDBFactory {


            public static AuthzDB createRDB(String rdbms) throws NoImplementation {
/*  23*/        AuthzDB rdb = null;
/*  24*/        if (rdbms.equals("Sqlite")) {
/*  25*/            rdb = new SqliteDb();
                } else
/*  26*/        if (rdbms.equals("MsSQL")) {
/*  27*/            rdb = new MsSQLDb();
                } else {
/*  29*/            throw new NoImplementation((new StringBuilder("Supplied Database")).append(rdbms).append(" is not supported RBD factory.").toString());
                }
/*  31*/        return rdb;
            }
}
