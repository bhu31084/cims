// Decompiled by Jad v1.5.8e. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: packimports(5) braces fieldsfirst noctor nonlb space lnc 
// Source File Name:   ReplaceApostroph.java

package in.co.paramatrix.common;


public class ReplaceApostroph {


            public String replacesingleqt(String remark) {
/*  15*/        String updatedRemark = remark.replaceAll("'", "''");
/*  17*/        return updatedRemark;
            }
}
