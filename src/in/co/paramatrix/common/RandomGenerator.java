// Decompiled by Jad v1.5.8e. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: packimports(5) braces fieldsfirst noctor nonlb space lnc 
// Source File Name:   RandomGenerator.java

package in.co.paramatrix.common;

import in.co.paramatrix.common.exceptions.InvalidData;
import java.util.Random;

public class RandomGenerator {

            private static Random rn = new Random();
            private static String universe = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_";

            private RandomGenerator() {
            }

            public static String getRandomString(int minSize, int maxSize) throws InvalidData {
/*  34*/        if (minSize < 1 || maxSize < 0 || minSize > maxSize) {
/*  35*/            throw new InvalidData("getRandomString: Invalid arguments. Either minSize is < 1, maxSize is < 0 or minSize > maxSize.");
                }
                int size;
/*  39*/        if (maxSize == 0) {
/*  40*/            size = minSize;
                } else {
/*  42*/            size = minSize + Math.abs(rn.nextInt() % ((maxSize - minSize) + 1));
                }
/*  44*/        StringBuffer strbuf = new StringBuffer(size);
/*  45*/        for (int i = 0; i < size; i++) {
/*  46*/            int j = Math.abs(rn.nextInt() % universe.length());
/*  47*/            strbuf = strbuf.append(universe.charAt(j));
                }

/*  49*/        return strbuf.toString();
            }

}
