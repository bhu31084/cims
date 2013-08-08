// Decompiled by Jad v1.5.8e. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: packimports(5) braces fieldsfirst noctor nonlb space lnc 
// Source File Name:   Config.java

package in.co.paramatrix.common;

import in.co.paramatrix.common.exceptions.NoEntity;
import java.io.PrintStream;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Vector;

public class Config {

            private Hashtable _config;
            private Vector referenceKeys;

            public Config(Vector vElement) {
/*  21*/        _config = null;
/*  24*/        referenceKeys = null;
/*  34*/        _config = getHashtable(vElement);
/*  35*/        System.out.println((new StringBuilder("_config")).append(_config).toString());
            }

            private Hashtable getHashtable(Vector allConfLines) {
/*  45*/        if (allConfLines != null && allConfLines.size() > 0) {
/*  46*/            _config = new Hashtable();
/*  47*/            referenceKeys = new Vector();
/*  49*/            for (int i = 0; i < allConfLines.size(); i++) {
/*  50*/                String singleLine = (String)(String)allConfLines.elementAt(i);
/*  51*/                if (!singleLine.startsWith("#") && singleLine.indexOf("=") != -1) {
/*  54*/                    if (singleLine.startsWith(" ") || singleLine.startsWith("\t")) {
/*  56*/                        String str1 = (String)(String)allConfLines.elementAt(i - 1);
/*  57*/                        singleLine = (new StringBuilder(String.valueOf(str1))).append(singleLine.trim()).toString();
/*  58*/                        allConfLines.removeElementAt(i - 1);
/*  59*/                        allConfLines.insertElementAt(singleLine, i - 1);
/*  60*/                        allConfLines.removeElementAt(i);
/*  61*/                        i = --i;
                            }
/*  64*/                    if (singleLine.indexOf("&") != -1) {
/*  65*/                        String CheckRHSPart = singleLine.substring(singleLine.indexOf("=") + 1);
/*  66*/                        if (singleLine.indexOf(".") != -1) {
/*  75*/                            String key = singleLine.substring(0, singleLine.indexOf("=")).trim();
/*  77*/                            if (key.indexOf(".") != -1) {
/*  78*/                                String superKey = singleLine.substring(0, singleLine.indexOf(".")).trim();
/*  83*/                                String refKey = null;
/*  85*/                                if (CheckRHSPart.startsWith("&")) {
/*  86*/                                    refKey = singleLine.substring(singleLine.indexOf("&") + 1).trim();
                                        } else {
/*  89*/                                    refKey = singleLine.substring(singleLine.indexOf("=") + 1);
                                        }
/*  93*/                                if (_config.containsKey(superKey)) {
/*  94*/                                    key = key.substring(key.indexOf(".") + 1, key.length()).trim();
/*  97*/                                    try {
/*  97*/                                        addReferance(key, (Hashtable)(Hashtable)_config.get(superKey), refKey);
                                            }
/*  99*/                                    catch (ClassCastException e) {
/* 100*/                                        System.out.println((new StringBuilder(String.valueOf(key))).append(" Key not found").toString());
                                            }
                                        } else {
/* 104*/                                    addReferance(key, null, refKey);
                                        }
                                    } else {
/* 108*/                                Vector tmpVector = new Vector();
/* 109*/                                String subKey = singleLine.substring(singleLine.indexOf("&") + 1, singleLine.length()).trim();
/* 112*/                                key = singleLine.substring(0, singleLine.indexOf("=")).trim();
/* 114*/                                tmpVector.addElement(new Hashtable());
/* 115*/                                tmpVector.addElement(key);
/* 116*/                                tmpVector.addElement(subKey);
/* 117*/                                referenceKeys.addElement(tmpVector);
                                    }
                                } else {
/* 128*/                            Vector tmpVector = new Vector();
/* 129*/                            String strhashtablekey = singleLine.substring(0, singleLine.indexOf("=")).trim();
/* 134*/                            String strhashtablereference = null;
/* 136*/                            if (CheckRHSPart.charAt(0) == '&') {
/* 137*/                                strhashtablereference = singleLine.substring(singleLine.indexOf("&") + 1).trim();
                                    } else {
/* 141*/                                strhashtablereference = singleLine.substring(singleLine.indexOf("=") + 1);
                                    }
/* 146*/                            tmpVector.addElement(_config);
/* 147*/                            tmpVector.addElement(strhashtablekey.trim());
/* 148*/                            tmpVector.addElement(strhashtablereference.trim());
/* 149*/                            referenceKeys.addElement(tmpVector);
                                }
                            } else {
/* 153*/                        String key = singleLine.substring(0, singleLine.indexOf("=")).trim();
/* 155*/                        if (key.indexOf(".") == -1) {
/* 161*/                            key = singleLine.substring(0, singleLine.indexOf("=")).trim();
/* 163*/                            String value = singleLine.substring(singleLine.indexOf("=") + 1, singleLine.length()).trim();
/* 166*/                            _config.put(key.trim(), value.trim());
                                } else
/* 167*/                        if (key.indexOf(".") != -1) {
/* 174*/                            String strhashtablekey = singleLine.substring(0, singleLine.indexOf(".")).trim();
/* 176*/                            strhashtablekey = strhashtablekey.trim();
/* 177*/                            String value = singleLine.substring(singleLine.indexOf("=") + 1, singleLine.length()).trim();
/* 180*/                            if (_config.containsKey(strhashtablekey)) {
/* 181*/                                Hashtable _tmphashtable1 = (Hashtable)(Hashtable)_config.get(strhashtablekey);
/* 183*/                                key = key.substring(key.indexOf(".") + 1, key.length()).trim();
/* 185*/                                putValue(key, _tmphashtable1, value);
                                    } else {
/* 187*/                                putValue(key, null, value);
                                    }
                                }
                            }
                        }
                    }

                }
/* 195*/        _config = retriveReferenceKeysVector(_config);
/* 196*/        return _config;
            }

            private Hashtable retriveReferenceKeysVector(Hashtable referanceHash) {
/* 212*/        if (referanceHash != null) {
/* 213*/            for (int i = 0; i < referenceKeys.size(); i++) {
/* 214*/                Vector singleReferance = (Vector)(Vector)referenceKeys.elementAt(i);
/* 215*/                String strkey = ((String)(String)singleReferance.elementAt(1)).trim();
/* 216*/                String strReference = ((String)(String)singleReferance.elementAt(2)).trim();
/* 267*/                Hashtable subHash = (Hashtable)(Hashtable)singleReferance.elementAt(0);
/* 269*/                if (subHash.containsKey(strReference)) {
/* 270*/                    referanceHash.put(strkey, (Hashtable)(Hashtable)subHash.get(strReference));
                        } else {
/* 273*/                    subHash.put(strkey, strReference);
                        }
                    }

                }
/* 278*/        return referanceHash;
            }

            private void putValue(String key, Hashtable refHash, String value) {
/* 294*/        if (key != null && value != null) {
/* 295*/            if (key.indexOf(".") != -1) {
/* 296*/                String subKey = key.substring(0, key.indexOf(".")).trim();
/* 297*/                if (refHash == null) {
/* 298*/                    Hashtable subHash = new Hashtable();
/* 299*/                    _config.put(subKey, subHash);
/* 300*/                    key = key.substring(key.indexOf(".") + 1, key.length()).trim();
/* 302*/                    putValue(key, subHash, value);
                        } else
/* 304*/                if (_config.containsKey(subKey)) {
/* 305*/                    Hashtable subHash = (Hashtable)(Hashtable)_config.get(subKey);
/* 306*/                    refHash.put(subKey, subHash);
/* 307*/                    key = key.substring(key.indexOf(".") + 1, key.length()).trim();
/* 309*/                    putValue(key, subHash, value);
                        } else {
/* 311*/                    Hashtable subHash = new Hashtable();
/* 312*/                    refHash.put(subKey, subHash);
/* 313*/                    _config.put(subKey, subHash);
/* 314*/                    key = key.substring(key.indexOf(".") + 1, key.length()).trim();
/* 316*/                    putValue(key, subHash, value);
                        }
                    } else {
/* 320*/                refHash.put(key, value);
                    }
                }
            }

            private void addReferance(String key, Hashtable refHash, String reference) {
/* 340*/        if (key != null && reference != null) {
/* 341*/            if (key.indexOf(".") != -1) {
/* 342*/                String superKey = key.substring(0, key.indexOf(".")).trim();
/* 343*/                if (refHash == null) {
/* 344*/                    Hashtable subHash = new Hashtable();
/* 345*/                    _config.put(superKey, subHash);
/* 346*/                    key = key.substring(key.indexOf(".") + 1, key.length()).trim();
/* 348*/                    addReferance(key, subHash, reference);
                        } else
/* 350*/                if (_config.containsKey(superKey)) {
/* 351*/                    Hashtable subMap = (Hashtable)(Hashtable)_config.get(superKey);
/* 352*/                    refHash.put(superKey, subMap);
/* 353*/                    key = key.substring(key.indexOf(".") + 1, key.length()).trim();
/* 355*/                    addReferance(key, subMap, reference);
                        } else {
/* 357*/                    Hashtable subHash = new Hashtable();
/* 358*/                    refHash.put(superKey, subHash);
/* 359*/                    _config.put(superKey, subHash);
/* 360*/                    key = key.substring(key.indexOf(".") + 1, key.length()).trim();
/* 362*/                    addReferance(key, subHash, reference);
                        }
                    } else {
/* 366*/                Vector tmpVector = new Vector();
/* 367*/                tmpVector.addElement(refHash);
/* 368*/                tmpVector.addElement(key.trim());
/* 369*/                tmpVector.addElement(reference.trim());
/* 370*/                referenceKeys.addElement(tmpVector);
                    }
                }
            }

            public Object getValue(String key) throws NoEntity {
/* 386*/        if (key != null) {
/* 387*/            Object value = null;
/* 388*/            if (key.indexOf(".") != -1) {
/* 389*/                String subKey = key.substring(0, key.indexOf(".")).trim();
/* 390*/                if (_config.containsKey(subKey)) {
/* 391*/                    Hashtable subHash = (Hashtable)(Hashtable)_config.get(subKey);
/* 392*/                    key = key.substring(key.indexOf(".") + 1, key.length()).trim();
/* 394*/                    value = searchKey(subHash, key);
/* 395*/                    return value;
                        } else {
/* 397*/                    throw new NoEntity((new StringBuilder("NoEntity For Key : ")).append(key).toString());
                        }
                    }
/* 400*/            value = _config.get(key);
/* 401*/            if (value == null) {
/* 402*/                throw new NoEntity((new StringBuilder("NoEntity For Key : ")).append(key).toString());
                    } else {
/* 404*/                return value;
                    }
                } else {
/* 407*/            return null;
                }
            }

            private Object searchKey(Hashtable lhtable, String key) throws NoEntity {
/* 422*/        if (lhtable != null && key != null) {
/* 423*/            if (key.indexOf(".") != -1) {
/* 424*/                String subHashKey = key.substring(0, key.indexOf(".")).trim();
/* 425*/                if (lhtable.containsKey(subHashKey)) {
/* 426*/                    Hashtable subHash = (Hashtable)(Hashtable)lhtable.get(subHashKey);
/* 427*/                    key = key.substring(key.indexOf(".") + 1, key.length()).trim();
/* 429*/                    return searchKey(subHash, key);
                        } else {
/* 431*/                    throw new NoEntity((new StringBuilder("NoEntity For Key : ")).append(key).toString());
                        }
                    }
/* 434*/            Object value = lhtable.get(key);
/* 435*/            if (value == null) {
/* 436*/                throw new NoEntity((new StringBuilder("NoValue found For Key : ")).append(key).toString());
                    } else {
/* 438*/                return value;
                    }
                } else {
/* 441*/            return null;
                }
            }

            public boolean containsKey(String Key) {
/* 447*/        String key = Key;
/* 448*/        String value = null;
/* 449*/        Hashtable hash1 = new Hashtable();
/* 450*/        for (Enumeration enum1 = _config.keys(); enum1.hasMoreElements(); hash1.put(enum1.nextElement(), _config.get(enum1.nextElement()))) { }
/* 455*/        if (key != null) {
/* 459*/            while (key.indexOf(".") != -1)  {
/* 459*/                int index = key.indexOf(".");
/* 460*/                int length = key.length();
/* 461*/                value = key.substring(index + 1, length).trim();
/* 462*/                key = key.substring(0, index).trim();
/* 463*/                Object obj = hash1.get(key);
/* 465*/                if (obj instanceof Hashtable) {
/* 466*/                    hash1 = (Hashtable)obj;
/* 467*/                    key = value;
                        } else {
/* 469*/                    String value1 = (String)obj;
/* 470*/                    return value.equals(value1);
                        }
                    }
                }
/* 474*/        System.out.println((new StringBuilder("config")).append(_config).toString());
/* 475*/        return hash1.containsKey(key);
            }

            public void putValue(String Key, Hashtable hash) {
/* 484*/        String value = null;
/* 485*/        String key = Key;
/* 486*/        Hashtable hash1 = _config;
/* 487*/        System.out.println((new StringBuilder("config")).append(_config).toString());
/* 489*/        for (; key.indexOf(".") != -1; key = value) {
/* 489*/            int index = key.indexOf(".");
/* 490*/            int length = key.length();
/* 491*/            value = key.substring(index + 1, length).trim();
/* 492*/            key = key.substring(0, index).trim();
/* 493*/            Hashtable hash2 = (Hashtable)(Hashtable)hash1.get(key);
/* 494*/            hash1 = hash2;
/* 495*/            if (value.indexOf(".") == -1) {
/* 496*/                hash1.put(value, hash);
                    }
                }

/* 500*/        if (key.indexOf(".") == -1) {
/* 501*/            hash1.put(key, hash);
                }
/* 503*/        System.out.println((new StringBuilder("config")).append(_config).toString());
            }

            public void putValue(String Key, String message) {
/* 510*/        String value = null;
/* 511*/        String key = Key;
/* 512*/        Hashtable hash1 = _config;
/* 513*/        System.out.println((new StringBuilder("config")).append(_config).toString());
/* 516*/        try {
/* 516*/            for (; key.indexOf(".") != -1; key = value) {
/* 516*/                int index = key.indexOf(".");
/* 517*/                int length = key.length();
/* 518*/                value = key.substring(index + 1, length).trim();
/* 519*/                key = key.substring(0, index).trim();
/* 520*/                Hashtable hash2 = (Hashtable)(Hashtable)hash1.get(key);
/* 521*/                hash1 = hash2;
/* 522*/                if (value.indexOf(".") == -1) {
/* 523*/                    hash1.put(value, "message");
                        }
                    }

                }
/* 528*/        catch (Exception e) {
/* 530*/            e.printStackTrace();
/* 531*/            System.out.println((new StringBuilder("Key not found")).append(key).toString());
                }
/* 533*/        if (key.indexOf(".") == -1) {
/* 534*/            hash1.put(key, message);
                }
/* 536*/        System.out.println((new StringBuilder("config")).append(_config).toString());
            }
}
