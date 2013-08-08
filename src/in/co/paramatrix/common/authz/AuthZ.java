// Decompiled by Jad v1.5.8e. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: packimports(5) braces fieldsfirst noctor nonlb space lnc 
// Source File Name:   AuthZ.java

package in.co.paramatrix.common.authz;

import in.co.paramatrix.common.Config;
import in.co.paramatrix.common.Logger;
import in.co.paramatrix.common.exceptions.*;
import in.co.paramatrix.common.exceptions.InternalError;

import java.io.PrintStream;
import java.util.Date;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Vector;
import java.util.regex.Pattern;

// Referenced classes of package in.co.paramatrix.common.authz:
//            RDBFactory, AuthzDB

public class AuthZ {

            private static Object instanceLock = null;
            private Object casheLock;
            private static AuthZ instance = null;
            private static Config __config = null;
            private AuthzDB rdb;
            private Logger __logger;
            private Hashtable userSigs;
            private Hashtable opSigs;
            private boolean destroyed;
            private int allowAbsentOps;
            private String opPattern;
            private String rolePattern;
            private String userPattern;

            private AuthZ(Config cf) throws InitFailed {
/*  30*/        casheLock = null;
/*  41*/        rdb = null;
/*  44*/        __logger = null;
/*  50*/        userSigs = null;
/*  56*/        opSigs = null;
/*  62*/        destroyed = false;
/*  74*/        allowAbsentOps = 0;
/*  77*/        opPattern = null;
/*  80*/        rolePattern = null;
/*  83*/        userPattern = null;
/*  95*/        __config = cf;
/*  98*/        try {
/*  98*/            __logger = Logger.getInstance();
                }
/*  99*/        catch (NoInit e) {
/* 100*/            System.out.println(e.getMessage());
                }
/* 103*/        casheLock = new int[1];
/* 104*/        userSigs = new Hashtable();
/* 105*/        opSigs = new Hashtable();
/* 108*/        try {
/* 108*/            opPattern = (String)__config.getValue("authz.op-pattern");
/* 109*/            Pattern.compile(opPattern);
                }
/* 110*/        catch (NoEntity e) {
/* 111*/            __logger.error((new StringBuilder("[AuthZ][Constructor] : ")).append(e.getMessage()).toString());
/* 112*/            throw new InitFailed(e.getMessage());
                }
/* 116*/        try {
/* 116*/            rolePattern = (String)__config.getValue("authz.role-pattern");
/* 117*/            Pattern.compile(rolePattern);
                }
/* 118*/        catch (NoEntity e) {
/* 119*/            __logger.error((new StringBuilder("[AuthZ][Constructor] : ")).append(e.getMessage()).toString());
/* 120*/            throw new InitFailed(e.getMessage());
                }
/* 124*/        try {
/* 124*/            userPattern = (String)__config.getValue("authz.user-pattern");
/* 125*/            Pattern.compile(userPattern);
                }
/* 126*/        catch (NoEntity e) {
/* 127*/            __logger.error((new StringBuilder("[AuthZ][Constructor] : ")).append(e.getMessage()).toString());
/* 128*/            throw new InitFailed(e.getMessage());
                }
/* 132*/        try {
/* 132*/            allowAbsentOps = Integer.parseInt((String)__config.getValue("authz.allow_absent_ops"));
                }
/* 134*/        catch (NoEntity e) {
/* 135*/            __logger.error((new StringBuilder("[AuthZ][Constructor] : ")).append(e.getMessage()).toString());
/* 136*/            throw new InitFailed(e.getMessage());
                }
/* 139*/        String db_name = null;
/* 141*/        try {
/* 141*/            db_name = (String)__config.getValue("authz.database-name");
                }
/* 142*/        catch (NoEntity e) {
/* 143*/            throw new InitFailed("Database Name not found.");
                }
/* 147*/        try {
/* 147*/            rdb = RDBFactory.createRDB(db_name);
                }
/* 148*/        catch (NoImplementation e) {
/* 149*/            throw new InitFailed(e.getMessage());
                }
/* 153*/        try {
/* 153*/            rdb.init(__config);
                }
/* 154*/        catch (InitFailed e) {
/* 155*/            throw e;
                }
/* 159*/        try {
/* 159*/            checkCache();
                }
/* 160*/        catch (LimitReached e) {
/* 161*/            __logger.error((new StringBuilder("[AuthZ][Constructor] : ")).append(e.getMessage()).toString());
                }
/* 162*/        catch (InternalError e) {
/* 163*/            __logger.error((new StringBuilder("[AuthZ][Constructor] : ")).append(e.getMessage()).toString());
                }
/* 164*/        catch (InvalidData e) {
/* 165*/            __logger.error((new StringBuilder("[AuthZ][Constructor] : ")).append(e.getMessage()).toString());
                }
/* 167*/        __logger.info((new StringBuilder("AuthZ initialized at : ")).append((new Date()).toString()).toString());
            }

            private void checkCache() throws InvalidData, LimitReached, InternalError {
/* 188*/        synchronized (casheLock) {
/* 189*/            rdb.checkCache();
                }
            }

            public static void init(Config cf) throws InvalidData {
/* 207*/        synchronized (instanceLock) {
/* 208*/            if (instance == null) {
/* 210*/                try {
/* 210*/                    instance = new AuthZ(cf);
                        }
/* 211*/                catch (InitFailed e) {
/* 212*/                    throw new InvalidData("Data missing/inconsistency in configuration");
                        }
                    }
                }
            }

            public static void reload() throws NoInit, InvalidData {
/* 236*/        if (instance != null) {
/* 237*/            synchronized (instanceLock) {
/* 238*/                instance = null;
/* 240*/                try {
/* 240*/                    init(__config);
                        }
/* 241*/                catch (InvalidData e) {
/* 242*/                    System.err.println("[AuthZ][reload] : Data missing/inconsistency in configuration");
/* 244*/                    throw e;
                        }
                    }
                } else {
/* 248*/            throw new NoInit("AuthZ class not initialized yet.");
                }
            }

            public static AuthZ getInstance() throws NoInit {
/* 261*/        if (instance == null) {
/* 262*/            throw new NoInit("AuthZ Class not intialized yet.");
                } else {
/* 264*/            return instance;
                }
            }

            public void destroy() {
/* 274*/        destroyed = true;
/* 275*/        instance = null;
            }

            private void checkObjectDestroyed() throws EntityDestroyed {
/* 286*/        if (destroyed) {
/* 287*/            throw new EntityDestroyed("AuthZ instance is destroyed.");
                } else {
/* 289*/            return;
                }
            }

            public void addOp(String op) throws LimitReached, EntityDestroyed, InvalidEntity, LimitCrossed, InternalError {
/* 312*/        checkObjectDestroyed();
/* 314*/        if (op == null) {
/* 315*/            throw new InvalidEntity("operation name can not be Null");
                }
/* 318*/        if (op.trim().length() == 0) {
/* 319*/            throw new InvalidEntity("operation name can not be blank or space.");
                }
/* 322*/        if (!Pattern.matches(opPattern, op)) {
/* 323*/            throw new InvalidEntity("operation name should contain ._a-zA-Z0-9 only.");
                } else {
/* 326*/            rdb.addOp(op);
/* 327*/            return;
                }
            }

            public void removeOp(String op) throws NoEntity, EntityDestroyed, InvalidEntity, LimitCrossed, InternalError {
/* 348*/        checkObjectDestroyed();
/* 350*/        if (op == null) {
/* 351*/            throw new InvalidEntity("operation name can not be Null");
                }
/* 354*/        if (op.trim().length() == 0) {
/* 355*/            throw new InvalidEntity("operation name can not be blank or space.");
                }
/* 358*/        if (opSigs.containsKey(op)) {
/* 359*/            opSigs.remove(op);
                }
/* 362*/        Vector lvUsersName = getUsersForOp(op);
/* 363*/        for (int i = 0; i < lvUsersName.size(); i++) {
/* 364*/            String user = (String)lvUsersName.elementAt(i);
/* 365*/            if (userSigs.containsKey(user)) {
/* 366*/                userSigs.remove(user);
                    }
                }

/* 369*/        rdb.removeOp(op);
            }

            public Vector getUsersForOp(String op) throws NoEntity, EntityDestroyed, InvalidEntity, LimitCrossed, InternalError {
/* 393*/        checkObjectDestroyed();
/* 395*/        if (op == null) {
/* 396*/            throw new InvalidEntity("operation name can not be Null");
                }
/* 399*/        if (op.trim().length() == 0) {
/* 400*/            throw new InvalidEntity("operation name can not be blank or space");
                } else {
/* 402*/            return rdb.getUsersForOp(op);
                }
            }

            public Vector getUsersForRole(String role) throws NoEntity, EntityDestroyed, InvalidEntity, LimitCrossed, InternalError {
/* 426*/        checkObjectDestroyed();
/* 428*/        if (role == null) {
/* 429*/            throw new InvalidEntity("Role name can not be Null");
                }
/* 432*/        if (role.trim().length() == 0) {
/* 433*/            throw new InvalidEntity("Role name can not be blank or space");
                } else {
/* 436*/            return rdb.getUsersForRole(role);
                }
            }

            public Vector getRolesForUser(String user) throws NoEntity, EntityDestroyed, InvalidEntity, LimitCrossed, InternalError {
/* 459*/        checkObjectDestroyed();
/* 461*/        if (user == null) {
/* 462*/            throw new InvalidEntity("User name can not be Null");
                }
/* 465*/        if (user.trim().length() == 0) {
/* 466*/            throw new InvalidEntity("User name can not be blank or space");
                } else {
/* 469*/            return rdb.getRolesForUser(user);
                }
            }

            public Vector getOpsForRole(String role) throws NoEntity, EntityDestroyed, InvalidEntity, LimitCrossed, InternalError {
/* 492*/        checkObjectDestroyed();
/* 494*/        if (role == null) {
/* 495*/            throw new InvalidEntity("Role name can not be Null");
                }
/* 498*/        if (role.trim().length() == 0) {
/* 499*/            throw new InvalidEntity("Role name can not be blank or space");
                } else {
/* 502*/            return rdb.getOpsForRole(role);
                }
            }

            public Vector getAllRoles() throws LimitCrossed, InternalError, EntityDestroyed {
/* 518*/        checkObjectDestroyed();
/* 519*/        return rdb.getAllRoles();
            }

            public Vector getAllOps() throws EntityDestroyed, LimitCrossed, InternalError {
/* 536*/        checkObjectDestroyed();
/* 537*/        return rdb.getAllOps();
            }

            public Vector getAllowedOps(String user) throws NoEntity, EntityDestroyed, InvalidEntity, LimitCrossed, InternalError {
/* 563*/        checkObjectDestroyed();
/* 564*/        if (user == null) {
/* 565*/            throw new InvalidEntity("user name can not be Null");
                }
/* 568*/        if (user.trim().length() == 0) {
/* 569*/            throw new InvalidEntity("user name can not be blank or space");
                } else {
/* 571*/            return rdb.getAllowedOps(user);
                }
            }

            public Vector searchOp(String opPat) throws EntityDestroyed, InvalidEntity, LimitCrossed, InternalError {
/* 593*/        checkObjectDestroyed();
/* 594*/        if (opPat == null) {
/* 595*/            throw new InvalidEntity("operation search pattern can not be Null");
                }
/* 598*/        if (opPat.trim().length() == 0) {
/* 599*/            throw new InvalidEntity("operation search pattern can not be blank or space");
                } else {
/* 602*/            return rdb.searchOp(opPat);
                }
            }

            public Vector searchUsers(String opPat) throws EntityDestroyed, InvalidEntity, LimitCrossed, InternalError {
/* 624*/        checkObjectDestroyed();
/* 625*/        if (opPat == null) {
/* 626*/            throw new InvalidEntity("operation search pattern can not be Null");
                } else {
/* 633*/            return rdb.searchUsers(opPat);
                }
            }

            public Vector getSigForOps(Vector ops) throws InvalidEntity, EntityDestroyed, NoEntity, LimitCrossed, InternalError {
/* 657*/        checkObjectDestroyed();
/* 659*/        if (ops == null) {
/* 660*/            throw new InvalidEntity("operations name vector can not be Null");
                }
/* 663*/        if (ops.size() == 0) {
/* 664*/            throw new InvalidEntity("operations name vector can not be empty.");
                } else {
/* 666*/            return rdb.getSigForOps(ops);
                }
            }

            public Vector getSigForOp(String op) throws InvalidEntity, EntityDestroyed, NoEntity, LimitCrossed, InternalError {
/* 689*/        checkObjectDestroyed();
/* 691*/        if (op == null) {
/* 692*/            throw new InvalidEntity("operations name vector can not be Null");
                }
/* 695*/        if (op.trim().length() == 0) {
/* 696*/            throw new InvalidEntity("operation name / user name can not be blank or space");
                } else {
/* 699*/            return rdb.getSigForOp(op);
                }
            }

            public boolean checkOpForUser(String op, String user) throws NoEntity, EntityDestroyed, InvalidEntity, LimitCrossed, InternalError {
/* 725*/        checkObjectDestroyed();
/* 727*/        if (op == null || user == null) {
/* 728*/            throw new InvalidEntity("operation name / user name can not be Null");
                }
/* 732*/        if (op.trim().length() == 0 || user.trim().length() == 0) {
/* 733*/            throw new InvalidEntity("operation name / user name can not be blank or space");
                }
/* 737*/        Vector opSig = null;
/* 738*/        if (opSigs.containsKey(op)) {
/* 739*/            opSig = (Vector)opSigs.get(op);
                } else {
/* 742*/            try {
/* 742*/                Vector ops = new Vector();
/* 743*/                ops.addElement(op);
/* 744*/                opSig = (Vector)(Vector)getSigForOps(ops).elementAt(0);
                    }
/* 745*/            catch (NoEntity e) {
/* 746*/                if (allowAbsentOps == 0) {
/* 747*/                    throw e;
                        } else {
/* 749*/                    return true;
                        }
                    }
/* 752*/            opSigs.put(op, opSig);
                }
/* 755*/        Vector baseVector = null;
/* 756*/        if (userSigs.containsKey(user)) {
/* 757*/            baseVector = (Vector)userSigs.get(user);
                } else {
/* 759*/            baseVector = rdb.getUserSig(user);
/* 760*/            userSigs.put(user, baseVector);
                }
/* 763*/        boolean opAllowed = false;
/* 764*/        for (int i = 0; i < baseVector.size(); i++) {
/* 765*/            long lOpUserSig = ((Long)(Long)baseVector.elementAt(i)).longValue();
/* 766*/            long lOpSig = ((Long)(Long)opSig.elementAt(i)).longValue();
/* 767*/            if ((lOpUserSig & lOpSig) == 0L) {
/* 768*/                continue;
                    }
/* 768*/            opAllowed = true;
/* 769*/            break;
                }

/* 772*/        return opAllowed;
            }

            public void allowOpForUser(String op, String user) throws NoEntity, EntityDestroyed, InvalidEntity, LimitCrossed, InternalError {
/* 798*/        checkObjectDestroyed();
/* 800*/        if (op == null || user == null) {
/* 801*/            throw new InvalidEntity("operation name / user name can not be Null");
                }
/* 805*/        if (op.trim().length() == 0 || user.trim().length() == 0) {
/* 806*/            throw new InvalidEntity("operation name / user name can not be blank or space");
                }
/* 810*/        if (userSigs.containsKey(user)) {
/* 811*/            userSigs.remove(user);
                }
/* 813*/        rdb.allowOpForUser(op, user);
            }

            public void denyOpForUser(String op, String user) throws NoEntity, EntityDestroyed, InvalidEntity, LimitCrossed, InternalError {
/* 838*/        checkObjectDestroyed();
/* 840*/        if (op == null || user == null) {
/* 841*/            throw new InvalidEntity("operation name / user name can not be Null");
                }
/* 845*/        if (op.trim().length() == 0 || user.trim().length() == 0) {
/* 846*/            throw new InvalidEntity("operation name / user name can not be blank or space");
                }
/* 850*/        if (userSigs.containsKey(user)) {
/* 851*/            userSigs.remove(user);
                }
/* 853*/        rdb.denyOpForUser(op, user);
            }

            public void allowOpsForUser(Vector ops, String user) throws NoEntity, InternalError, EntityDestroyed, InvalidEntity, InternalError, LimitCrossed {
/* 884*/        checkObjectDestroyed();
/* 886*/        if (ops == null || user == null) {
/* 887*/            throw new InvalidEntity("operation vector / user name can not be Null");
                }
/* 891*/        if (ops.size() == 0 || user.trim().length() == 0) {
/* 892*/            throw new InvalidEntity("operation vector / user name can not be blank or space");
                }
/* 896*/        if (userSigs.containsKey(user)) {
/* 897*/            userSigs.remove(user);
                }
/* 899*/        rdb.allowOpsForUser(ops, user);
            }

            public void denyOpsForUser(Vector ops, String user) throws NoEntity, InternalError, EntityDestroyed, InvalidEntity, LimitCrossed, InternalError {
/* 930*/        checkObjectDestroyed();
/* 932*/        if (ops == null || user == null) {
/* 933*/            throw new InvalidEntity("operation vector / user name can not be Null");
                }
/* 937*/        if (ops.size() == 0 || user.trim().length() == 0) {
/* 938*/            throw new InvalidEntity("operation vector / user name can not be blank or space");
                }
/* 942*/        if (userSigs.containsKey(user)) {
/* 943*/            userSigs.remove(user);
                }
/* 945*/        rdb.denyOpsForUser(ops, user);
            }

            public void allowAllOpsForUser(String user) throws NoEntity, EntityDestroyed, InvalidEntity, LimitCrossed, InternalError {
/* 967*/        checkObjectDestroyed();
/* 969*/        if (user == null) {
/* 970*/            throw new InvalidEntity("user name can not be Null");
                }
/* 973*/        if (user.trim().length() == 0) {
/* 974*/            throw new InvalidEntity("user name can not be blank or space");
                }
/* 977*/        if (userSigs.containsKey(user)) {
/* 978*/            userSigs.remove(user);
                }
/* 980*/        rdb.allowAllOpsForUser(user);
            }

            public void denyAllOpsForUser(String user) throws NoEntity, EntityDestroyed, InvalidEntity, LimitCrossed, InternalError {
/*1002*/        checkObjectDestroyed();
/*1004*/        if (user == null) {
/*1005*/            throw new InvalidEntity("user name can not be Null");
                }
/*1008*/        if (user.trim().length() == 0) {
/*1009*/            throw new InvalidEntity("user name can not be blank or space");
                }
/*1012*/        if (userSigs.containsKey(user)) {
/*1013*/            userSigs.remove(user);
                }
/*1015*/        rdb.denyAllOpsForUser(user);
            }

            public void addRole(String role) throws EntityDestroyed, InvalidEntity, LimitCrossed, InternalError, DuplicateEntity, LimitReached {
/*1039*/        checkObjectDestroyed();
/*1041*/        if (role == null) {
/*1042*/            throw new InvalidEntity("role name can not be Null");
                }
/*1045*/        if (role.trim().length() == 0) {
/*1046*/            throw new InvalidEntity("role name can not be blank or space");
                }
/*1049*/        if (!Pattern.matches(rolePattern, role)) {
/*1050*/            throw new InvalidEntity("Role name should contain ._a-zA-Z0-9 only.");
                } else {
/*1054*/            rdb.addRole(role);
/*1055*/            return;
                }
            }

            public void removeRole(String role) throws EntityDestroyed, NoEntity, InvalidEntity, LimitCrossed, InternalError {
/*1075*/        checkObjectDestroyed();
/*1077*/        if (role == null) {
/*1078*/            throw new InvalidEntity("role name can not be Null");
                }
/*1081*/        if (role.trim().length() == 0) {
/*1082*/            throw new InvalidEntity("role name can not be blank or space");
                }
/*1085*/        Vector lvUsersName = getUsersForRole(role);
/*1086*/        for (int i = 0; i < lvUsersName.size(); i++) {
/*1087*/            String user = (String)(String)lvUsersName.elementAt(i);
/*1088*/            if (userSigs.containsKey(user)) {
/*1089*/                userSigs.remove(user);
                    }
                }

/*1092*/        rdb.removeRole(role);
            }

            public void addOpToRole(String op, String role) throws NoEntity, EntityDestroyed, InvalidEntity, LimitCrossed, InternalError {
/*1118*/        checkObjectDestroyed();
/*1120*/        if (op == null || role == null) {
/*1121*/            throw new InvalidEntity("operation name / role name can not be Null");
                }
/*1125*/        if (op.trim().length() == 0 || role.trim().length() == 0) {
/*1126*/            throw new InvalidEntity("operation name / role name can not be blank or space");
                }
/*1130*/        Vector lvUsersName = getUsersForRole(role);
/*1131*/        for (int i = 0; i < lvUsersName.size(); i++) {
/*1132*/            String user = (String)(String)lvUsersName.elementAt(i);
/*1133*/            if (userSigs.containsKey(user)) {
/*1134*/                userSigs.remove(user);
                    }
                }

/*1137*/        rdb.addOpToRole(op, role);
            }

            public void removeOpFromRole(String op, String role) throws NoEntity, EntityDestroyed, InvalidEntity, LimitCrossed, InternalError {
/*1163*/        checkObjectDestroyed();
/*1165*/        if (op == null || role == null) {
/*1166*/            throw new InvalidEntity("operation name / role name can not be Null");
                }
/*1170*/        if (op.trim().length() == 0 || role.trim().length() == 0) {
/*1171*/            throw new InvalidEntity("operation name / role name can not be blank or space");
                }
/*1175*/        Vector lvUsersName = getUsersForRole(role);
/*1176*/        for (int i = 0; i < lvUsersName.size(); i++) {
/*1177*/            String user = (String)(String)lvUsersName.elementAt(i);
/*1178*/            if (userSigs.containsKey(user)) {
/*1179*/                userSigs.remove(user);
                    }
                }

/*1182*/        rdb.removeOpFromRole(op, role);
            }

            public void addOpsToRole(Vector ops, String role) throws NoEntity, InternalError, EntityDestroyed, InvalidEntity, LimitCrossed {
/*1211*/        checkObjectDestroyed();
/*1213*/        if (ops == null || role == null) {
/*1214*/            throw new InvalidEntity("operation vector / role name can not be Null");
                }
/*1218*/        if (ops.size() == 0 || role.trim().length() == 0) {
/*1219*/            throw new InvalidEntity("operation vector / role name can not be blank or space");
                }
/*1223*/        Vector lvUsersName = getUsersForRole(role);
/*1224*/        for (int i = 0; i < lvUsersName.size(); i++) {
/*1225*/            String user = (String)(String)lvUsersName.elementAt(i);
/*1226*/            if (userSigs.containsKey(user)) {
/*1227*/                userSigs.remove(user);
                    }
                }

/*1230*/        rdb.addOpsToRole(ops, role);
            }

            public void removeOpsFromRole(Vector ops, String role) throws NoEntity, InternalError, EntityDestroyed, InvalidEntity, LimitCrossed, InternalError {
/*1260*/        checkObjectDestroyed();
/*1262*/        if (ops == null || role == null) {
/*1263*/            throw new InvalidEntity("operation vector / role name can not be Null");
                }
/*1267*/        if (ops.size() == 0 || role.trim().length() == 0) {
/*1268*/            throw new InvalidEntity("operation vector / role name can not be blank or space");
                }
/*1272*/        Vector lvUsersName = getUsersForRole(role);
/*1273*/        for (int i = 0; i < lvUsersName.size(); i++) {
/*1274*/            String user = (String)(String)lvUsersName.elementAt(i);
/*1275*/            if (userSigs.containsKey(user)) {
/*1276*/                userSigs.remove(user);
                    }
                }

/*1279*/        rdb.removeOpsFromRole(ops, role);
            }

            public void mapUserToRole(String user, String role) throws LimitCrossed, InternalError, NoEntity, EntityDestroyed, InvalidEntity {
/*1300*/        checkObjectDestroyed();
/*1302*/        if (user == null || role == null) {
/*1303*/            throw new InvalidEntity("Username or roles not valid.");
                }
/*1306*/        if (userSigs.containsKey(user)) {
/*1307*/            userSigs.remove(user);
                }
/*1309*/        rdb.mapUserToRole(user, role);
            }

            public void mapUsersToRole(String role, Vector users) throws LimitCrossed, InternalError, NoEntity, EntityDestroyed, InvalidEntity {
/*1331*/        checkObjectDestroyed();
/*1333*/        if (role == null || users == null || users.size() == 0) {
/*1334*/            throw new InvalidEntity("Username or roles not valid.");
                }
/*1337*/        if (userSigs.containsKey(role)) {
/*1338*/            userSigs.remove(role);
                }
/*1341*/        rdb.mapUsersToRole(role, users);
            }

            public void unmapUserFromRole(String user, String role) throws LimitCrossed, InternalError, EntityDestroyed, InvalidEntity {
/*1364*/        checkObjectDestroyed();
/*1366*/        if (user == null || role == null) {
/*1367*/            throw new InvalidEntity("Username or roles not valid.");
                }
/*1370*/        if (userSigs.containsKey(user)) {
/*1371*/            userSigs.remove(user);
                }
/*1373*/        rdb.unmapUserFromRole(user, role);
            }

            public void unmapUsersFromRole(String role, Vector users) throws LimitCrossed, InternalError, EntityDestroyed, InvalidEntity {
/*1396*/        checkObjectDestroyed();
/*1398*/        if (users == null || role == null || users.size() == 0) {
/*1399*/            throw new InvalidEntity("Username or roles not valid.");
                }
/*1402*/        for (Iterator iterator = users.iterator(); iterator.hasNext();) {
/*1402*/            String user = (String)iterator.next();
/*1403*/            if (userSigs.containsKey(user)) {
/*1404*/                userSigs.remove(user);
                    }
                }

/*1408*/        rdb.unmapUsersFromRole(role, users);
            }

            public void addUser(String user) throws EntityDestroyed, InvalidEntity, LimitCrossed, InternalError {
/*1428*/        checkObjectDestroyed();
/*1430*/        if (user == null) {
/*1431*/            throw new InvalidEntity("user name can not be Null");
                }
/*1434*/        if (user.trim().length() == 0) {
/*1435*/            throw new InvalidEntity("user name can not be blank or space");
                }
/*1438*/        if (!Pattern.matches(userPattern, user)) {
/*1439*/            throw new InvalidEntity("User name should contain any ._a-zA-Z0-9 characters only.");
                } else {
/*1442*/            rdb.addUser(user);
/*1443*/            return;
                }
            }

            public void removeUser(String user) throws NoEntity, EntityDestroyed, InvalidEntity, LimitCrossed, InternalError {
/*1464*/        checkObjectDestroyed();
/*1466*/        if (user == null) {
/*1467*/            throw new InvalidEntity("user name can not be Null");
                }
/*1470*/        if (user.trim().length() == 0) {
/*1471*/            throw new InvalidEntity("user name can not be blank or space");
                }
/*1474*/        if (userSigs.containsKey(user)) {
/*1475*/            userSigs.remove(user);
                }
/*1477*/        rdb.removeUser(user);
            }

            static  {
/* 172*/        instanceLock = new int[1];
            }
}
