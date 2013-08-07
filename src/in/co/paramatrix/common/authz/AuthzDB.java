// Decompiled by Jad v1.5.8e. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: packimports(5) braces fieldsfirst noctor nonlb space lnc 
// Source File Name:   AuthzDB.java

package in.co.paramatrix.common.authz;

import in.co.paramatrix.common.Config;
import in.co.paramatrix.common.ConnectionPool;
import in.co.paramatrix.common.Logger;
import in.co.paramatrix.common.RandomGenerator;
import in.co.paramatrix.common.exceptions.*;
import in.co.paramatrix.common.exceptions.InternalError;

import java.io.PrintStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public class AuthzDB {

            protected ConnectionPool cp;
            private Config __config;
            private Logger __logger;
            private final String noOp = "__no_op__";
            protected long numSigs;

            public AuthzDB() {
/*  33*/        cp = null;
/*  36*/        __config = null;
/*  39*/        __logger = null;
/*  51*/        numSigs = 0L;
            }

            public void init(Config config) throws InitFailed {
/*  62*/        __config = config;
/*  64*/        try {
/*  64*/            __logger = Logger.getInstance();
                }
/*  65*/        catch (NoInit e) {
/*  66*/            System.out.println(e.getMessage());
                }
/*  69*/        int numOps = 0;
/*  71*/        try {
/*  71*/            numOps = Integer.parseInt((String)__config.getValue("authz.max_ops"));
                }
/*  73*/        catch (NoEntity e) {
/*  74*/            __logger.error((new StringBuilder("[AuthzDB][Constructor] : ")).append(e.getMessage()).toString());
/*  75*/            throw new InitFailed(e.getMessage());
                }
/*  78*/        int rem = numOps % 64;
/*  79*/        int div = numOps / 64;
/*  80*/        if (rem != 0) {
/*  81*/            numSigs = div + 1;
                } else {
/*  83*/            numSigs = div;
                }
            }

            public void checkCache() throws InvalidData, LimitReached, InternalError {
            }

            public void populateTables() throws LimitReached, LimitCrossed, InternalError {
/* 119*/        populateOpsUserMap();
/* 120*/        populateRolesUserMap();
            }

            private void populateRolesUserMap() throws LimitReached, LimitCrossed, InternalError {
/* 136*/        Hashtable rolesMap = null;
/* 138*/        try {
/* 138*/            rolesMap = (Hashtable)__config.getValue("authz.roles");
                }
/* 139*/        catch (NoEntity e) {
/* 140*/            return;
                }
/* 143*/        for (Enumeration enumeration1 = rolesMap.keys(); enumeration1.hasMoreElements();) {
/* 145*/            String roleName = (String)(String)enumeration1.nextElement();
/* 147*/            try {
/* 147*/                addRole(roleName);
                    }
/* 148*/            catch (DuplicateEntity e) {
/* 149*/                __logger.error((new StringBuilder("[SqliteDb][populateRolesUserMap] : ")).append(e.getMessage()).toString());
                    }
/* 153*/            Hashtable roleDetailMap = (Hashtable)(Hashtable)rolesMap.get(roleName);
/* 154*/            if (roleDetailMap.containsKey("ops")) {
/* 155*/                String opsList = (String)(String)roleDetailMap.get("ops");
/* 157*/                for (StringTokenizer st = new StringTokenizer(opsList, ","); st.hasMoreTokens();) {
/* 159*/                    String singleOPName = st.nextToken().trim();
/* 161*/                    try {
/* 161*/                        addOp(singleOPName);
                            }
/* 162*/                    catch (LimitReached e) {
/* 163*/                        throw e;
                            }
/* 167*/                    try {
/* 167*/                        addOpToRole(singleOPName, roleName);
                            }
/* 168*/                    catch (NoEntity e) {
/* 169*/                        __logger.error((new StringBuilder("[SqliteDb][populateRolesUserMap] : ")).append(e.getMessage()).toString());
                            }
/* 173*/                    if (roleDetailMap.containsKey("users")) {
/* 174*/                        String userList = (String)(String)roleDetailMap.get("users");
/* 176*/                        for (StringTokenizer st1 = new StringTokenizer(userList, ","); st1.hasMoreTokens();) {
/* 178*/                            String singleUserName = st1.nextToken().trim();
/* 180*/                            addUser(singleUserName);
/* 182*/                            try {
/* 182*/                                allowOpForUser(singleOPName, singleUserName);
                                    }
/* 183*/                            catch (NoEntity e) {
/* 184*/                                __logger.error((new StringBuilder("[SqliteDb][populateRolesUserMap] : ")).append(e.getMessage()).toString());
                                    }
                                }

                            }
                        }

                    }
                }

            }

            private void populateOpsUserMap() throws LimitReached, LimitCrossed, InternalError {
/* 208*/        Hashtable opsMap = null;
/* 210*/        try {
/* 210*/            opsMap = (Hashtable)__config.getValue("authz.ops");
                }
/* 211*/        catch (NoEntity e) {
/* 212*/            return;
                }
/* 215*/        for (Enumeration enumeration1 = opsMap.keys(); enumeration1.hasMoreElements();) {
/* 217*/            String opName = (String)(String)enumeration1.nextElement();
/* 219*/            try {
/* 219*/                addOp(opName);
                    }
/* 220*/            catch (LimitReached e) {
/* 221*/                throw e;
                    }
/* 224*/            Hashtable usersMap = (Hashtable)opsMap.get(opName);
/* 225*/            String userList = (String)(String)usersMap.get("users");
/* 227*/            for (StringTokenizer st = new StringTokenizer(userList, ","); st.hasMoreTokens();) {
/* 229*/                String singleUserName = st.nextToken().trim();
/* 230*/                addUser(singleUserName);
/* 232*/                try {
/* 232*/                    allowOpForUser(opName, singleUserName);
                        }
/* 233*/                catch (NoEntity e) {
/* 234*/                    __logger.error((new StringBuilder("[SqliteDb][populateOpsUserMap] : ")).append(e.getMessage()).toString());
                        }
                    }

                }

            }

            public void addOp(String op) throws LimitReached, LimitCrossed, InternalError {
/* 259*/        Connection connection = cp.getConnection();
/* 260*/        PreparedStatement preparedStatement = null;
/* 261*/        ResultSet resultSet = null;
/* 264*/        try {
/* 264*/            String selectQuery = "select id from data.authz_ops_mst where name = ?";
/* 266*/            preparedStatement = connection.prepareStatement(selectQuery);
/* 267*/            preparedStatement.setString(1, op);
/* 268*/            resultSet = preparedStatement.executeQuery();
/* 270*/            if (resultSet.next()) {
/* 271*/                return;
                    }
                }
/* 273*/        catch (SQLException sqlException) {
/* 274*/            __logger.error((new StringBuilder("[AuthzDB][addOp] : ")).append(sqlException.getMessage()).toString());
                }
/* 277*/        int op_id = 0;
/* 279*/        try {
/* 279*/            String selectQuery = "select min(id) from data.authz_ops_mst where name is null";
/* 281*/            preparedStatement = connection.prepareStatement(selectQuery);
/* 282*/            resultSet = preparedStatement.executeQuery();
/* 284*/            if (resultSet.next()) {
/* 285*/                op_id = resultSet.getInt(1);
/* 286*/                preparedStatement.close();
                    } else {
/* 288*/                resultSet.close();
/* 289*/                preparedStatement.close();
/* 290*/                cp.returnConnection();
/* 291*/                throw new LimitReached("No of methods in cache has already reached its maximum.");
                    }
                }
/* 294*/        catch (SQLException sqlException) {
/* 295*/            __logger.error((new StringBuilder("[AuthzDB][addOp] : ")).append(sqlException.getMessage()).toString());
                }
/* 299*/        try {
/* 299*/            if (op_id != 0) {
/* 300*/                String updateQuery = "update data.authz_ops_mst set name = ? where id = ?";
/* 301*/                preparedStatement = connection.prepareStatement(updateQuery);
/* 302*/                preparedStatement.setString(1, op);
/* 303*/                preparedStatement.setInt(2, op_id);
/* 305*/                int rowInserted = preparedStatement.executeUpdate();
/* 306*/                if (rowInserted != 0) {
/* 307*/                    __logger.debug((new StringBuilder("[AuthzDB][addOp] : ")).append(op).append(" Operation is added in database table authz_ops_mst.").toString());
                        } else {
/* 312*/                    __logger.debug((new StringBuilder("[AuthzDB][addOp] : ")).append(op).append(" Operation is already present in database table authz_ops_mst.").toString());
                        }
/* 317*/                resultSet.close();
/* 318*/                preparedStatement.close();
                    }
                }
/* 320*/        catch (SQLException sqlException) {
/* 321*/            __logger.error((new StringBuilder("[AuthzDB][addOp] : ")).append(sqlException.getMessage()).toString());
                }
/* 323*/        cp.returnConnection();
            }

            public void removeOp(String op) throws NoEntity, LimitCrossed, InternalError {
/* 342*/        Connection connection = cp.getConnection();
/* 343*/        PreparedStatement preparedStatement = null;
/* 344*/        ResultSet resultSet = null;
/* 345*/        int op_id = 0;
/* 348*/        try {
/* 348*/            String selectQuery = "select id from data.authz_ops_mst where name = ?";
/* 349*/            preparedStatement = connection.prepareStatement(selectQuery);
/* 350*/            preparedStatement.setString(1, op);
/* 351*/            resultSet = preparedStatement.executeQuery();
/* 353*/            if (resultSet.next()) {
/* 354*/                op_id = resultSet.getInt(1);
/* 355*/                preparedStatement.close();
                    } else {
/* 357*/                resultSet.close();
/* 358*/                preparedStatement.close();
/* 359*/                cp.returnConnection();
/* 360*/                throw new NoEntity((new StringBuilder("Invalid Operation name : ")).append(op).toString());
                    }
                }
/* 362*/        catch (SQLException sqlException) {
/* 363*/            __logger.error((new StringBuilder("[AuthzDB][removeOp] : ")).append(sqlException.getMessage()).toString());
                }
/* 368*/        try {
/* 368*/            String updateQuery = "update data.authz_ops_mst set name = null where id = ?";
/* 369*/            preparedStatement = connection.prepareStatement(updateQuery);
/* 370*/            preparedStatement.setInt(1, op_id);
/* 371*/            preparedStatement.executeUpdate();
/* 372*/            preparedStatement.close();
/* 373*/            __logger.debug((new StringBuilder("[AuthzDB][removeOp] : ")).append(op).append(" Operation is removed from database table authz_ops_mst.").toString());
                }
/* 377*/        catch (SQLException sqlException) {
/* 378*/            __logger.error((new StringBuilder("[AuthzDB][removeOp] : ")).append(sqlException.getMessage()).toString());
                }
/* 383*/        try {
/* 383*/            String deleteQuery = "delete from data.authz_role_op_map where op_id = ?";
/* 384*/            preparedStatement = connection.prepareStatement(deleteQuery);
/* 385*/            preparedStatement.setInt(1, op_id);
/* 387*/            int rowDeleted = preparedStatement.executeUpdate();
/* 388*/            if (rowDeleted != 0) {
/* 389*/                __logger.debug((new StringBuilder("[AuthzDB][removeOp] : ")).append(op).append(" operation is removed from database table authz_role_op_map. ").append(rowDeleted).append(" rows are removed from table authz_role_op_map.").toString());
                    }
/* 396*/            preparedStatement.close();
                }
/* 397*/        catch (SQLException sqlException) {
/* 398*/            __logger.error((new StringBuilder("[AuthzDB][removeOp] : ")).append(sqlException.getMessage()).toString());
                }
/* 403*/        try {
/* 403*/            String deleteQuery = "delete from data.authz_user_op_map where role_id = 0 and op_id = ?";
/* 404*/            preparedStatement = connection.prepareStatement(deleteQuery);
/* 405*/            preparedStatement.setInt(1, op_id);
/* 406*/            int rowDeleted = preparedStatement.executeUpdate();
/* 407*/            if (rowDeleted != 0) {
/* 408*/                __logger.debug((new StringBuilder("[AuthzDB][removeOp] : ")).append(op).append(" operation is removed from database table authz_user_op_map. ").append(rowDeleted).append(" rows are removed from table authz_user_op_map.").toString());
                    }
/* 415*/            resultSet.close();
/* 416*/            preparedStatement.close();
                }
/* 417*/        catch (SQLException sqlException) {
/* 418*/            __logger.error((new StringBuilder("[AuthzDB][removeOp] : ")).append(sqlException.getMessage()).toString());
                }
/* 421*/        cp.returnConnection();
            }

            public Vector getUsersForOp(String op) throws NoEntity, LimitCrossed, InternalError {
/* 442*/        Connection connection = cp.getConnection();
/* 443*/        PreparedStatement preparedStatement = null;
/* 444*/        ResultSet resultSet = null;
/* 446*/        Vector lvUsersName = new Vector();
/* 448*/        try {
/* 448*/            String selectQuery = "select id from data.authz_ops_mst where name = ?";
/* 449*/            preparedStatement = connection.prepareStatement(selectQuery);
/* 450*/            preparedStatement.setString(1, op);
/* 451*/            resultSet = preparedStatement.executeQuery();
/* 453*/            if (!resultSet.next()) {
/* 454*/                resultSet.close();
/* 455*/                preparedStatement.close();
/* 456*/                cp.returnConnection();
/* 457*/                throw new NoEntity((new StringBuilder("Invalid Operation name : ")).append(op).toString());
                    }
/* 459*/            resultSet.close();
/* 460*/            preparedStatement.close();
                }
/* 461*/        catch (SQLException sqlException) {
/* 462*/            __logger.error((new StringBuilder("[AuthzDB][getUsersForOp] : ")).append(sqlException.getMessage()).toString());
                }
/* 467*/        try {
/* 467*/            String selectQuery = "select u.nickname from data.authz_ops_mst o, data.authz_users_mst u, data.authz_user_op_map op where o.name = ? and o.id = op.op_id and u.id = op.user_id and op.role_id = 0";
/* 468*/            preparedStatement = connection.prepareStatement(selectQuery);
/* 469*/            preparedStatement.setString(1, op);
/* 470*/            for (resultSet = preparedStatement.executeQuery(); resultSet.next(); lvUsersName.addElement(resultSet.getString(1))) { }
/* 475*/            resultSet.close();
/* 476*/            preparedStatement.close();
                }
/* 477*/        catch (SQLException sqlException) {
/* 478*/            __logger.error((new StringBuilder("[AuthzDB][getUsersForOp] : ")).append(sqlException.getMessage()).toString());
                }
/* 481*/        __logger.debug((new StringBuilder("[AuthzDB][getUsersForOp] : Users ")).append(lvUsersName).append(" are mapped with operation ").append(op).toString());
/* 483*/        cp.returnConnection();
/* 484*/        return lvUsersName;
            }

            public Vector getUsersForRole(String role) throws NoEntity, LimitCrossed, InternalError {
                Connection connection;
                PreparedStatement preparedStatement;
                ResultSet resultSet;
                Vector lvUsersName;
/* 504*/        connection = cp.getConnection();
/* 505*/        preparedStatement = null;
/* 506*/        resultSet = null;
/* 508*/        lvUsersName = new Vector();
/* 510*/        try {
/* 510*/            String selectQuery = "select id from data.authz_roles_mst where name = ?";
/* 511*/            preparedStatement = connection.prepareStatement(selectQuery);
/* 512*/            preparedStatement.setString(1, role);
/* 513*/            resultSet = preparedStatement.executeQuery();
/* 515*/            if (!resultSet.next()) {
/* 516*/                resultSet.close();
/* 517*/                preparedStatement.close();
/* 518*/                cp.returnConnection();
/* 519*/                throw new NoEntity((new StringBuilder("Invalid Role name : ")).append(role).toString());
                    }
                }
/* 521*/        catch (SQLException sqlException) {
/* 522*/            __logger.error((new StringBuilder("[AuthzDB][getUsersForRole] : ")).append(sqlException.getMessage()).toString());
                }
/* 526*/        try {
/* 526*/            resultSet.close();
                }
/* 527*/        catch (SQLException e) {
/* 528*/            __logger.error((new StringBuilder("[AuthzDB][getUsersForRole] : ")).append(e.getMessage()).toString());
                }
/* 532*/        try {
/* 532*/            preparedStatement.close();
                }
/* 533*/        catch (SQLException e) {
/* 534*/            __logger.error((new StringBuilder("[AuthzDB][getUsersForRole] : ")).append(e.getMessage()).toString());
                }
/* 526*/        try {
/* 526*/            resultSet.close();
                }
/* 527*/        catch (SQLException e) {
/* 528*/            __logger.error((new StringBuilder("[AuthzDB][getUsersForRole] : ")).append(e.getMessage()).toString());
                }
/* 532*/        try {
/* 532*/            preparedStatement.close();
                }
/* 533*/        catch (SQLException e) {
/* 534*/            __logger.error((new StringBuilder("[AuthzDB][getUsersForRole] : ")).append(e.getMessage()).toString());
                }
/* 540*/        try {
/* 540*/            String selectQuery = "select distinct nickname from data.authz_users_mst, data.authz_roles_mst, data.authz_user_op_map where authz_users_mst.id = authz_user_op_map.user_id and authz_user_op_map.role_id = authz_roles_mst.id and authz_roles_mst.name = ? order by nickname";
/* 544*/            preparedStatement = connection.prepareStatement(selectQuery);
/* 545*/            preparedStatement.setString(1, role);
/* 546*/            for (resultSet = preparedStatement.executeQuery(); resultSet.next(); lvUsersName.add(resultSet.getString("nickname"))) { }
                }
/* 552*/        catch (SQLException sqlException) {
/* 553*/            __logger.error((new StringBuilder("[AuthzDB][getUsersForRole] : ")).append(sqlException.getMessage()).toString());
                }
/* 557*/        try {
/* 557*/            resultSet.close();
                }
/* 558*/        catch (SQLException e) {
/* 559*/            __logger.error((new StringBuilder("[AuthzDB][getUsersForRole] : ")).append(e.getMessage()).toString());
                }
/* 563*/        try {
/* 563*/            preparedStatement.close();
                }
/* 564*/        catch (SQLException e) {
/* 565*/            __logger.error((new StringBuilder("[AuthzDB][getUsersForRole] : ")).append(e.getMessage()).toString());
                }
/* 568*/        cp.returnConnection();
/* 557*/        try {
/* 557*/            resultSet.close();
                }
/* 558*/        catch (SQLException e) {
/* 559*/            __logger.error((new StringBuilder("[AuthzDB][getUsersForRole] : ")).append(e.getMessage()).toString());
                }
/* 563*/        try {
/* 563*/            preparedStatement.close();
                }
/* 564*/        catch (SQLException e) {
/* 565*/            __logger.error((new StringBuilder("[AuthzDB][getUsersForRole] : ")).append(e.getMessage()).toString());
                }
/* 568*/        cp.returnConnection();
/* 570*/        return lvUsersName;
            }

            public Vector getRolesForUser(String user) throws NoEntity, LimitCrossed, InternalError {
                Connection connection;
                PreparedStatement preparedStatement;
                ResultSet resultSet;
                Vector lvUsersName;
/* 589*/        connection = cp.getConnection();
/* 590*/        preparedStatement = null;
/* 591*/        resultSet = null;
/* 593*/        lvUsersName = new Vector();
/* 595*/        try {
/* 595*/            String selectQuery = "select id from data.authz_users_mst where name = ?";
/* 596*/            preparedStatement = connection.prepareStatement(selectQuery);
/* 597*/            preparedStatement.setString(1, user);
/* 598*/            resultSet = preparedStatement.executeQuery();
/* 600*/            if (!resultSet.next()) {
/* 601*/                resultSet.close();
/* 602*/                preparedStatement.close();
/* 603*/                cp.returnConnection();
/* 604*/                throw new NoEntity((new StringBuilder("Invalid Role name : ")).append(user).toString());
                    }
                }
/* 606*/        catch (SQLException sqlException) {
/* 607*/            __logger.error((new StringBuilder("[AuthzDB][getRolesForUser] : ")).append(sqlException.getMessage()).toString());
                }
/* 611*/        try {
/* 611*/            resultSet.close();
                }
/* 612*/        catch (SQLException e) {
/* 613*/            __logger.error((new StringBuilder("[AuthzDB][getRolesForUser] : ")).append(e.getMessage()).toString());
                }
/* 617*/        try {
/* 617*/            preparedStatement.close();
                }
/* 618*/        catch (SQLException e) {
/* 619*/            __logger.error((new StringBuilder("[AuthzDB][getRolesForUser] : ")).append(e.getMessage()).toString());
                }
/* 611*/        try {
/* 611*/            resultSet.close();
                }
/* 612*/        catch (SQLException e) {
/* 613*/            __logger.error((new StringBuilder("[AuthzDB][getRolesForUser] : ")).append(e.getMessage()).toString());
                }
/* 617*/        try {
/* 617*/            preparedStatement.close();
                }
/* 618*/        catch (SQLException e) {
/* 619*/            __logger.error((new StringBuilder("[AuthzDB][getRolesForUser] : ")).append(e.getMessage()).toString());
                }
/* 625*/        try {
/* 625*/            String selectQuery = "select distinct u.nickname from data.authz_user_op_map uo, data.authz_roles_mst r, data.authz_users_mst u where uo.role_id = r.id and u.id = uo.user_id and r.name = ? order by u.nickname";
/* 628*/            preparedStatement = connection.prepareStatement(selectQuery);
/* 629*/            preparedStatement.setString(1, user);
/* 630*/            for (resultSet = preparedStatement.executeQuery(); resultSet.next(); lvUsersName.addElement(resultSet.getString(1))) { }
                }
/* 635*/        catch (SQLException sqlException) {
/* 636*/            __logger.error((new StringBuilder("[AuthzDB][getRolesForUser] : ")).append(sqlException.getMessage()).toString());
                }
/* 640*/        try {
/* 640*/            resultSet.close();
                }
/* 641*/        catch (SQLException e) {
/* 642*/            __logger.error((new StringBuilder("[AuthzDB][getRolesForUser] : ")).append(e.getMessage()).toString());
                }
/* 646*/        try {
/* 646*/            preparedStatement.close();
                }
/* 647*/        catch (SQLException e) {
/* 648*/            __logger.error((new StringBuilder("[AuthzDB][getRolesForUser] : ")).append(e.getMessage()).toString());
                }
/* 651*/        cp.returnConnection();
/* 640*/        try {
/* 640*/            resultSet.close();
                }
/* 641*/        catch (SQLException e) {
/* 642*/            __logger.error((new StringBuilder("[AuthzDB][getRolesForUser] : ")).append(e.getMessage()).toString());
                }
/* 646*/        try {
/* 646*/            preparedStatement.close();
                }
/* 647*/        catch (SQLException e) {
/* 648*/            __logger.error((new StringBuilder("[AuthzDB][getRolesForUser] : ")).append(e.getMessage()).toString());
                }
/* 651*/        cp.returnConnection();
/* 653*/        __logger.debug((new StringBuilder("[AuthzDB][getRolesForUser] : Users ")).append(lvUsersName).append(" are mapped with role ").append(user).toString());
/* 655*/        cp.returnConnection();
/* 656*/        return lvUsersName;
            }

            public Vector getOpsForRole(String role) throws LimitCrossed, InternalError, NoEntity {
                Connection connection;
                PreparedStatement preparedStatement;
                ResultSet resultSet;
                Vector lvUsersName;
/* 676*/        connection = cp.getConnection();
/* 677*/        preparedStatement = null;
/* 678*/        resultSet = null;
/* 680*/        lvUsersName = new Vector();
/* 682*/        try {
/* 682*/            String selectQuery = "select * from data.authz_roles_mst where name = ?";
/* 683*/            preparedStatement = connection.prepareStatement(selectQuery);
/* 684*/            preparedStatement.setString(1, role);
/* 685*/            resultSet = preparedStatement.executeQuery();
/* 687*/            if (!resultSet.next()) {
/* 688*/                resultSet.close();
/* 689*/                preparedStatement.close();
/* 690*/                cp.returnConnection();
/* 691*/                throw new NoEntity((new StringBuilder("Invalid Role name : ")).append(role).toString());
                    }
                }
/* 693*/        catch (SQLException e) {
/* 694*/            __logger.error((new StringBuilder("[AuthzDB][getOpsForRole] : ")).append(e.getMessage()).toString());
                }
/* 697*/        try {
/* 697*/            resultSet.close();
                }
/* 698*/        catch (SQLException e) {
/* 699*/            __logger.error((new StringBuilder("[AuthzDB][getOpsForRole] : ")).append(e.getMessage()).toString());
                }
/* 702*/        try {
/* 702*/            preparedStatement.close();
                }
/* 703*/        catch (SQLException e) {
/* 704*/            __logger.error((new StringBuilder("[AuthzDB][getOpsForRole] : ")).append(e.getMessage()).toString());
                }
/* 697*/        try {
/* 697*/            resultSet.close();
                }
/* 698*/        catch (SQLException e) {
/* 699*/            __logger.error((new StringBuilder("[AuthzDB][getOpsForRole] : ")).append(e.getMessage()).toString());
                }
/* 702*/        try {
/* 702*/            preparedStatement.close();
                }
/* 703*/        catch (SQLException e) {
/* 704*/            __logger.error((new StringBuilder("[AuthzDB][getOpsForRole] : ")).append(e.getMessage()).toString());
                }
/* 709*/        try {
/* 709*/            String selectQuery = "select authz_ops_mst.name from data.authz_role_op_map, data.authz_roles_mst,data.authz_ops_mst where authz_ops_mst.id = authz_role_op_map.op_id and authz_role_op_map.role_id = authz_roles_mst.id and authz_roles_mst.name = ?";
/* 712*/            preparedStatement = connection.prepareStatement(selectQuery);
/* 713*/            preparedStatement.setString(1, role);
/* 714*/            for (resultSet = preparedStatement.executeQuery(); resultSet.next(); lvUsersName.add(resultSet.getString("name"))) { }
                }
/* 719*/        catch (SQLException e) {
/* 720*/            __logger.error((new StringBuilder("[AuthzDB][getOpsForRole] : ")).append(e.getMessage()).toString());
                }
/* 723*/        try {
/* 723*/            resultSet.close();
                }
/* 724*/        catch (SQLException e) {
/* 725*/            __logger.error((new StringBuilder("[AuthzDB][getOpsForRole] : ")).append(e.getMessage()).toString());
                }
/* 728*/        try {
/* 728*/            preparedStatement.close();
                }
/* 729*/        catch (SQLException e) {
/* 730*/            __logger.error((new StringBuilder("[AuthzDB][getOpsForRole] : ")).append(e.getMessage()).toString());
                }
/* 732*/        cp.returnConnection();
/* 723*/        try {
/* 723*/            resultSet.close();
                }
/* 724*/        catch (SQLException e) {
/* 725*/            __logger.error((new StringBuilder("[AuthzDB][getOpsForRole] : ")).append(e.getMessage()).toString());
                }
/* 728*/        try {
/* 728*/            preparedStatement.close();
                }
/* 729*/        catch (SQLException e) {
/* 730*/            __logger.error((new StringBuilder("[AuthzDB][getOpsForRole] : ")).append(e.getMessage()).toString());
                }
/* 732*/        cp.returnConnection();
/* 734*/        __logger.debug((new StringBuilder("[AuthzDB][getOpsForRole] : Operations ")).append(lvUsersName).append(" are mapped with role ").append(role).toString());
/* 736*/        return lvUsersName;
            }

            public Vector getAllRoles() throws LimitCrossed, InternalError {
                Connection connection;
                PreparedStatement preparedStatement;
                Vector lvAllRoles;
                ResultSet resultSet;
/* 749*/        connection = cp.getConnection();
/* 750*/        preparedStatement = null;
/* 751*/        lvAllRoles = new Vector();
/* 752*/        resultSet = null;
/* 754*/        try {
/* 754*/            String selectQuery = "select name from data.authz_roles_mst where name is not null  order by name";
/* 756*/            preparedStatement = connection.prepareStatement(selectQuery);
/* 757*/            for (resultSet = preparedStatement.executeQuery(); resultSet.next(); lvAllRoles.add(resultSet.getString("name"))) { }
                }
/* 762*/        catch (SQLException sqlException) {
/* 763*/            __logger.error((new StringBuilder("[AuthzDB][getAllRoles] : ")).append(sqlException.getMessage()).toString());
                }
/* 767*/        try {
/* 767*/            resultSet.close();
                }
/* 768*/        catch (SQLException e) {
/* 769*/            __logger.error((new StringBuilder("[AuthzDB][getAllRoles] : ")).append(e.getMessage()).toString());
                }
/* 772*/        try {
/* 772*/            preparedStatement.close();
                }
/* 773*/        catch (SQLException e) {
/* 774*/            __logger.error((new StringBuilder("[AuthzDB][getAllRoles] : ")).append(e.getMessage()).toString());
                }
/* 776*/        cp.returnConnection();
/* 767*/        try {
/* 767*/            resultSet.close();
                }
/* 768*/        catch (SQLException e) {
/* 769*/            __logger.error((new StringBuilder("[AuthzDB][getAllRoles] : ")).append(e.getMessage()).toString());
                }
/* 772*/        try {
/* 772*/            preparedStatement.close();
                }
/* 773*/        catch (SQLException e) {
/* 774*/            __logger.error((new StringBuilder("[AuthzDB][getAllRoles] : ")).append(e.getMessage()).toString());
                }
/* 776*/        cp.returnConnection();
/* 778*/        return lvAllRoles;
            }

            public Vector getAllOps() throws LimitCrossed, InternalError {
/* 792*/        Connection connection = cp.getConnection();
/* 793*/        PreparedStatement preparedStatement = null;
/* 794*/        Vector lvAllOperations = new Vector();
/* 796*/        try {
/* 796*/            String selectQuery = "select name from data.authz_ops_mst where name is not null and name <> '__no_op__' order by name";
/* 798*/            preparedStatement = connection.prepareStatement(selectQuery);
                    ResultSet resultSet;
/* 799*/            for (resultSet = preparedStatement.executeQuery(); resultSet.next(); lvAllOperations.addElement(resultSet.getString(1))) { }
/* 804*/            resultSet.close();
/* 805*/            preparedStatement.close();
                }
/* 806*/        catch (SQLException sqlException) {
/* 807*/            __logger.error((new StringBuilder("[AuthzDB][getAllOps] : ")).append(sqlException.getMessage()).toString());
                }
/* 810*/        __logger.debug((new StringBuilder("[AuthzDB][getAllOps] : ")).append(lvAllOperations).append(" operations present in database table op_mst.").toString());
/* 812*/        cp.returnConnection();
/* 813*/        return lvAllOperations;
            }

            public Vector getSigForOp(String op) throws NoEntity, LimitCrossed, InternalError {
/* 832*/        Connection connection = cp.getConnection();
/* 833*/        PreparedStatement preparedStatement = null;
/* 834*/        ResultSet resultSet = null;
/* 835*/        Vector opSig = new Vector();
/* 837*/        try {
/* 837*/            StringBuffer sb = new StringBuffer();
/* 838*/            sb.append("select ");
/* 839*/            for (int i = 0; (long)i < numSigs; i++) {
/* 840*/                sb.append("sig");
/* 841*/                sb.append(i + 1);
/* 842*/                sb.append(",");
                    }

/* 844*/            sb.deleteCharAt(sb.length() - 1);
/* 845*/            sb.append(" from authz_ops_mst where name = ?");
/* 847*/            preparedStatement = connection.prepareStatement(sb.toString());
/* 848*/            preparedStatement.setString(1, op);
/* 849*/            resultSet = preparedStatement.executeQuery();
/* 851*/            if (resultSet.next()) {
/* 852*/                for (int i = 0; (long)i < numSigs; i++) {
/* 853*/                    opSig.addElement(new Long(resultSet.getLong(i + 1)));
                        }

/* 855*/                resultSet.close();
/* 856*/                preparedStatement.close();
                    } else {
/* 858*/                resultSet.close();
/* 859*/                preparedStatement.close();
/* 860*/                cp.returnConnection();
/* 861*/                throw new NoEntity((new StringBuilder(String.valueOf(op))).append(" operation is not present in the database table authz_ops_mst").toString());
                    }
/* 865*/            __logger.debug((new StringBuilder("[AuthzDB][getSigForOp] : ")).append(op).append(" operation signature is ").append(opSig).toString());
                }
/* 867*/        catch (SQLException sqlException) {
/* 868*/            __logger.error((new StringBuilder("[AuthzDB][getSigForOp] : ")).append(sqlException.getMessage()).toString());
                }
/* 871*/        cp.returnConnection();
/* 872*/        return opSig;
            }

            public Vector getSigForOps(Vector ops) throws NoEntity, LimitCrossed, InternalError {
/* 891*/        Connection connection = cp.getConnection();
/* 892*/        PreparedStatement preparedStatement = null;
/* 893*/        ResultSet resultSet = null;
/* 894*/        Vector lvOpsSig = new Vector();
/* 896*/        for (int j = 0; j < ops.size(); j++) {
/* 897*/            String op = (String)ops.elementAt(j);
/* 899*/            Vector opSig = new Vector();
/* 901*/            try {
/* 901*/                StringBuffer sb = new StringBuffer();
/* 902*/                sb.append("select ");
/* 903*/                for (int i = 0; (long)i < numSigs; i++) {
/* 904*/                    sb.append("sig");
/* 905*/                    sb.append(i + 1);
/* 906*/                    sb.append(",");
                        }

/* 908*/                sb.deleteCharAt(sb.length() - 1);
/* 909*/                sb.append(" from data.authz_ops_mst where name = ?");
/* 911*/                preparedStatement = connection.prepareStatement(sb.toString());
/* 912*/                preparedStatement.setString(1, op);
/* 913*/                resultSet = preparedStatement.executeQuery();
/* 915*/                if (resultSet.next()) {
/* 916*/                    for (int i = 0; (long)i < numSigs; i++) {
/* 917*/                        opSig.addElement(new Long(resultSet.getLong(i + 1)));
                            }

                        } else {
/* 920*/                    cp.returnConnection();
/* 921*/                    throw new NoEntity((new StringBuilder(String.valueOf(op))).append(" operation is not present in the database table authz_ops_mst").toString());
                        }
/* 925*/                lvOpsSig.addElement(opSig);
/* 926*/                resultSet.close();
/* 927*/                preparedStatement.close();
/* 928*/                __logger.debug((new StringBuilder("[AuthzDB][getSigForOp] : ")).append(op).append(" operation signature is ").append(opSig).toString());
                    }
/* 930*/            catch (SQLException sqlException) {
/* 931*/                __logger.error((new StringBuilder("[AuthzDB][getSigForOp] : ")).append(sqlException.getMessage()).toString());
                    }
                }

/* 935*/        cp.returnConnection();
/* 936*/        return lvOpsSig;
            }

            public Vector getUserSig(String user) throws NoEntity, LimitCrossed, InternalError {
/* 955*/        Connection connection = cp.getConnection();
/* 956*/        Vector lvUserSig = new Vector();
/* 958*/        PreparedStatement preparedStatement = null;
/* 959*/        ResultSet resultSet = null;
/* 962*/        try {
/* 962*/            String selectQuery = "select id from data.authz_users_mst where nickname = ?";
/* 963*/            preparedStatement = connection.prepareStatement(selectQuery);
/* 964*/            preparedStatement.setString(1, user);
/* 965*/            resultSet = preparedStatement.executeQuery();
/* 967*/            if (!resultSet.next()) {
/* 968*/                cp.returnConnection();
/* 969*/                throw new NoEntity((new StringBuilder("[AuthzDB][getUserSig] : ")).append(user).append(" is not found as user in the database table authz_users_mst.").toString());
                    }
/* 974*/            resultSet.close();
/* 975*/            preparedStatement.close();
                }
/* 976*/        catch (SQLException sqlException) {
/* 977*/            __logger.error((new StringBuilder("[AuthzDB][getUserSig] : ")).append(sqlException.getMessage()).toString());
                }
/* 982*/        try {
/* 982*/            StringBuffer sb = new StringBuffer();
/* 983*/            sb.append("select ");
/* 984*/            for (int i = 0; (long)i < numSigs; i++) {
/* 985*/                sb.append("sig");
/* 986*/                sb.append(i + 1);
/* 987*/                sb.append(",");
                    }

/* 990*/            sb.deleteCharAt(sb.length() - 1);
/* 991*/            sb.append(" from data.authz_ops_mst o, data.authz_users_mst u, data.authz_user_op_map uo ");
/* 993*/            sb.append(" where u.nickname = ? and u.id = uo.user_id and uo.op_id = o.id order by o.name");
/* 996*/            preparedStatement = connection.prepareStatement(sb.toString());
/* 997*/            preparedStatement.setString(1, user);
/* 998*/            resultSet = preparedStatement.executeQuery();
/*1000*/            for (int i = 0; (long)i < numSigs; i++) {
/*1001*/                lvUserSig.addElement(new Long(0L));
                    }

/*1005*/            while (resultSet.next())  {
/*1005*/                for (int j = 0; j < lvUserSig.size(); j++) {
/*1006*/                    long baseSigVal = ((Long)lvUserSig.elementAt(j)).longValue();
/*1008*/                    long opSigVal = Long.valueOf(resultSet.getLong(j + 1)).longValue();
/*1011*/                    baseSigVal |= opSigVal;
/*1012*/                    lvUserSig.setElementAt(new Long(baseSigVal), j);
                        }

                    }
/*1015*/            resultSet.close();
/*1016*/            preparedStatement.close();
                }
/*1017*/        catch (SQLException sqlException) {
/*1018*/            __logger.error((new StringBuilder("[AuthzDB][getUserSig] : ")).append(sqlException.getMessage()).toString());
                }
/*1021*/        __logger.debug((new StringBuilder("[AuthzDB][getUserSig] : ")).append(lvUserSig).append(" is authz signature for user ").append(user).toString());
/*1023*/        cp.returnConnection();
/*1024*/        return lvUserSig;
            }

            public Vector getAllowedOps(String user) throws NoEntity, LimitCrossed, InternalError {
/*1046*/        Connection connection = cp.getConnection();
/*1047*/        Vector lvAllowedOperations = new Vector();
/*1048*/        PreparedStatement preparedStatement = null;
/*1049*/        ResultSet resultSet = null;
/*1052*/        try {
/*1052*/            String selectQuery = "select id from data.authz_users_mst where nickname = ?";
/*1053*/            preparedStatement = connection.prepareStatement(selectQuery);
/*1054*/            preparedStatement.setString(1, user);
/*1055*/            resultSet = preparedStatement.executeQuery();
/*1057*/            if (!resultSet.next()) {
/*1058*/                cp.returnConnection();
/*1059*/                throw new NoEntity((new StringBuilder("[AuthzDB][getAllowedOps] : ")).append(user).append(" is not found as user in the database table authz_users_mst.").toString());
                    }
/*1064*/            resultSet.close();
/*1065*/            preparedStatement.close();
                }
/*1066*/        catch (SQLException sqlException) {
/*1067*/            __logger.error((new StringBuilder("[AuthzDB][getAllowedOps] : ")).append(sqlException.getMessage()).toString());
                }
/*1072*/        try {
/*1072*/            String selectQuery = "select o.name from data.authz_ops_mst o, data.authz_users_mst u, data.authz_user_op_map uo where u.nickname = ? and u.id = uo.user_id and uo.op_id = o.id order by o.name";
/*1073*/            preparedStatement = connection.prepareStatement(selectQuery);
/*1074*/            preparedStatement.setString(1, user);
/*1075*/            for (resultSet = preparedStatement.executeQuery(); resultSet.next(); lvAllowedOperations.addElement(resultSet.getString(1))) { }
/*1080*/            resultSet.close();
/*1081*/            preparedStatement.close();
                }
/*1082*/        catch (SQLException sqlException) {
/*1083*/            __logger.error((new StringBuilder("[AuthzDB][getAllowedOps] : ")).append(sqlException.getMessage()).toString());
                }
/*1086*/        __logger.debug((new StringBuilder("[AuthzDB][getAllowedOps] : ")).append(lvAllowedOperations).append(" operations are allowed for user ").append(user).toString());
/*1088*/        cp.returnConnection();
/*1089*/        return lvAllowedOperations;
            }

            public Vector searchOp(String opPat) throws LimitCrossed, InternalError {
/*1107*/        Connection connection = cp.getConnection();
/*1108*/        Vector lvSerachOpResult = new Vector();
/*1109*/        PreparedStatement preparedStatement = null;
/*1110*/        ResultSet resultSet = null;
/*1113*/        try {
/*1113*/            String selectQuery = "select name from data.authz_ops_mst where name like ? order by name";
/*1114*/            preparedStatement = connection.prepareStatement(selectQuery);
/*1115*/            preparedStatement.setString(1, (new StringBuilder(String.valueOf(opPat))).append("%").toString());
/*1116*/            for (resultSet = preparedStatement.executeQuery(); resultSet.next(); lvSerachOpResult.addElement(resultSet.getString("name"))) { }
/*1121*/            resultSet.close();
/*1122*/            preparedStatement.close();
                }
/*1123*/        catch (SQLException sqlException) {
/*1124*/            __logger.error((new StringBuilder("[AuthzDB][searchOp] : ")).append(sqlException.getMessage()).toString());
                }
/*1127*/        __logger.debug((new StringBuilder("[AuthzDB][searchOp] : Operations matching with pattern ")).append(opPat).append(" are ").append(lvSerachOpResult).toString());
/*1130*/        cp.returnConnection();
/*1131*/        return lvSerachOpResult;
            }

            public Vector searchUsers(String opPat) throws LimitCrossed, InternalError {
/*1149*/        Connection connection = cp.getConnection();
/*1150*/        Vector lvSerachOpResult = new Vector();
/*1151*/        PreparedStatement preparedStatement = null;
/*1152*/        ResultSet resultSet = null;
/*1155*/        try {
/*1155*/            String selectQuery = "select nickname from data.authz_users_mst where nickname like ? order by nickname";
/*1156*/            preparedStatement = connection.prepareStatement(selectQuery);
/*1157*/            preparedStatement.setString(1, (new StringBuilder(String.valueOf(opPat))).append("%").toString());
/*1158*/            for (resultSet = preparedStatement.executeQuery(); resultSet.next(); lvSerachOpResult.addElement(resultSet.getString("nickname"))) { }
/*1163*/            resultSet.close();
/*1164*/            preparedStatement.close();
                }
/*1165*/        catch (SQLException sqlException) {
/*1166*/            __logger.error((new StringBuilder("[AuthzDB][searchUsers] : ")).append(sqlException.getMessage()).toString());
                }
/*1169*/        __logger.debug((new StringBuilder("[AuthzDB][searchUsers] : Operations matching with pattern ")).append(opPat).append(" are ").append(lvSerachOpResult).toString());
/*1172*/        cp.returnConnection();
/*1173*/        return lvSerachOpResult;
            }

            public void allowOpForUser(String op, String user) throws NoEntity, LimitCrossed, InternalError {
/*1195*/        Connection connection = cp.getConnection();
/*1196*/        PreparedStatement preparedStatement = null;
/*1197*/        ResultSet resultSet = null;
/*1199*/        int op_id = 0;
/*1200*/        int user_id = 0;
/*1202*/        try {
/*1202*/            String selectQuery = "select id from data.authz_ops_mst where name = ?";
/*1203*/            preparedStatement = connection.prepareStatement(selectQuery);
/*1204*/            preparedStatement.setString(1, op);
/*1205*/            resultSet = preparedStatement.executeQuery();
/*1207*/            if (resultSet.next()) {
/*1208*/                op_id = resultSet.getInt(1);
/*1209*/                preparedStatement.close();
                    } else {
/*1211*/                resultSet.close();
/*1212*/                preparedStatement.close();
/*1213*/                cp.returnConnection();
/*1214*/                throw new NoEntity((new StringBuilder("Invalid operation name ")).append(op).toString());
                    }
                }
/*1216*/        catch (SQLException sqlException) {
/*1217*/            __logger.error((new StringBuilder("[AuthzDB][allowOpForUser] : ")).append(sqlException.getMessage()).toString());
                }
/*1222*/        try {
/*1222*/            String selectQuery = "select id from data.authz_users_mst where nickname = ?";
/*1223*/            preparedStatement = connection.prepareStatement(selectQuery);
/*1224*/            preparedStatement.setString(1, user);
/*1225*/            resultSet = preparedStatement.executeQuery();
/*1227*/            if (resultSet.next()) {
/*1228*/                user_id = resultSet.getInt(1);
/*1229*/                preparedStatement.close();
                    } else {
/*1231*/                resultSet.close();
/*1232*/                preparedStatement.close();
/*1233*/                cp.returnConnection();
/*1234*/                throw new NoEntity((new StringBuilder("Invalid user name ")).append(user).toString());
                    }
                }
/*1236*/        catch (SQLException sqlException) {
/*1237*/            __logger.error((new StringBuilder("[AuthzDB][allowOpForUser] : ")).append(sqlException.getMessage()).toString());
                }
/*1242*/        try {
/*1242*/            String insertQuery = "insert into data.authz_user_op_map (user_id, op_id) values (?, ?)";
/*1243*/            preparedStatement = connection.prepareStatement(insertQuery);
/*1244*/            preparedStatement.setInt(1, user_id);
/*1245*/            preparedStatement.setInt(2, op_id);
/*1246*/            int rowInserted = preparedStatement.executeUpdate();
/*1247*/            if (rowInserted != 0) {
/*1248*/                __logger.debug((new StringBuilder("[AuthzDB][allowOpForUser] : ")).append(user).append(" user is mapped with the operartion ").append(op).append(" in database table authz_user_op_map.").toString());
                    } else {
/*1252*/                __logger.debug((new StringBuilder("[AuthzDB][allowOpForUser] : ")).append(user).append(" user is not mapped with the operartion ").append(op).append(" in database table authz_user_op_map.").toString());
                    }
/*1256*/            resultSet.close();
/*1257*/            preparedStatement.close();
                }
/*1258*/        catch (SQLException sqlException) {
/*1259*/            __logger.error((new StringBuilder("[AuthzDB][allowOpForUser] : ")).append(sqlException.getMessage()).toString());
                }
/*1262*/        cp.returnConnection();
            }

            public void denyOpForUser(String op, String user) throws NoEntity, LimitCrossed, InternalError {
/*1283*/        Connection connection = cp.getConnection();
/*1284*/        PreparedStatement preparedStatement = null;
/*1285*/        ResultSet resultSet = null;
/*1287*/        int op_id = 0;
/*1288*/        int user_id = 0;
/*1290*/        try {
/*1290*/            String selectQuery = "select id from data.authz_ops_mst where name = ?";
/*1291*/            preparedStatement = connection.prepareStatement(selectQuery);
/*1292*/            preparedStatement.setString(1, op);
/*1293*/            resultSet = preparedStatement.executeQuery();
/*1295*/            if (resultSet.next()) {
/*1296*/                op_id = resultSet.getInt(1);
/*1297*/                preparedStatement.close();
                    } else {
/*1299*/                resultSet.close();
/*1300*/                preparedStatement.close();
/*1301*/                cp.returnConnection();
/*1302*/                throw new NoEntity((new StringBuilder("Invalid operation name ")).append(op).toString());
                    }
                }
/*1304*/        catch (SQLException sqlException) {
/*1305*/            __logger.error((new StringBuilder("[AuthzDB][denyOpForUser] : ")).append(sqlException.getMessage()).toString());
                }
/*1310*/        try {
/*1310*/            String selectQuery = "select id from data.authz_users_mst where nickname = ?";
/*1311*/            preparedStatement = connection.prepareStatement(selectQuery);
/*1312*/            preparedStatement.setString(1, user);
/*1313*/            resultSet = preparedStatement.executeQuery();
/*1315*/            if (resultSet.next()) {
/*1316*/                user_id = resultSet.getInt(1);
/*1317*/                preparedStatement.close();
                    } else {
/*1319*/                preparedStatement.close();
/*1320*/                resultSet.close();
/*1321*/                cp.returnConnection();
/*1322*/                throw new NoEntity((new StringBuilder("Invalid user name ")).append(user).toString());
                    }
                }
/*1324*/        catch (SQLException sqlException) {
/*1325*/            __logger.error((new StringBuilder("[AuthzDB][denyOpForUser] : ")).append(sqlException.getMessage()).toString());
                }
/*1330*/        try {
/*1330*/            String deleteQuery = "delete from data.authz_user_op_map where role_id = 0 and user_id = ? and op_id = ?";
/*1331*/            preparedStatement = connection.prepareStatement(deleteQuery);
/*1332*/            preparedStatement.setInt(1, user_id);
/*1333*/            preparedStatement.setInt(2, op_id);
/*1334*/            int rowDeleted = preparedStatement.executeUpdate();
/*1335*/            if (rowDeleted != 0) {
/*1336*/                __logger.debug((new StringBuilder("[AuthzDB][denyOpForUser] : ")).append(user).append(" user is unmapped with the operartion ").append(op).append(" in database table authz_user_op_map.").toString());
                    } else {
/*1340*/                __logger.debug((new StringBuilder("[AuthzDB][denyOpForUser] : ")).append(user).append(" user is not unmapped with the operartion ").append(op).append(" in database table authz_user_op_map.").toString());
                    }
/*1344*/            resultSet.close();
/*1345*/            preparedStatement.close();
                }
/*1346*/        catch (SQLException sqlException) {
/*1347*/            __logger.error((new StringBuilder("[AuthzDB][denyOpForUser] : ")).append(sqlException.getMessage()).toString());
                }
/*1350*/        cp.returnConnection();
            }

            public void allowOpsForUser(Vector ops, String user) throws NoEntity, LimitCrossed, InternalError {
/*1374*/        Connection connection = cp.getConnection();
/*1375*/        PreparedStatement preparedStatement = null;
/*1376*/        ResultSet resultSet = null;
/*1378*/        int user_id = 0;
/*1380*/        try {
/*1380*/            String selectQuery = "select id from data.authz_users_mst where nickname = ?";
/*1381*/            preparedStatement = connection.prepareStatement(selectQuery);
/*1382*/            preparedStatement.setString(1, user);
/*1383*/            resultSet = preparedStatement.executeQuery();
/*1385*/            if (resultSet.next()) {
/*1386*/                user_id = resultSet.getInt(1);
/*1387*/                preparedStatement.close();
                    } else {
/*1389*/                preparedStatement.close();
/*1390*/                resultSet.close();
/*1391*/                cp.returnConnection();
/*1392*/                throw new NoEntity((new StringBuilder("Invalid user name ")).append(user).toString());
                    }
                }
/*1394*/        catch (SQLException sqlException) {
/*1395*/            __logger.error((new StringBuilder("[AuthzDB][allowOpsForUser] : ")).append(sqlException.getMessage()).toString());
                }
/*1399*/        Hashtable opNameToIdMap = new Hashtable();
/*1401*/        try {
/*1401*/            StringBuffer sb = new StringBuffer();
/*1402*/            sb.append("select id, name from data.authz_ops_mst where ");
/*1403*/            for (int i = 0; i < ops.size(); i++) {
/*1404*/                sb.append("name = ? or ");
                    }

/*1406*/            sb.delete(sb.length() - 3, sb.length() - 1);
/*1407*/            preparedStatement = connection.prepareStatement(sb.toString());
/*1409*/            Hashtable tempOpNameMap = new Hashtable();
/*1410*/            for (int i = 0; i < ops.size(); i++) {
/*1411*/                String opName = (String)ops.elementAt(i);
/*1412*/                preparedStatement.setString(i + 1, opName);
/*1413*/                tempOpNameMap.put(opName, "");
                    }

/*1416*/            resultSet = preparedStatement.executeQuery();
/*1418*/            int rowCount = 0;
/*1420*/            for (; resultSet.next(); opNameToIdMap.put(resultSet.getString("name"), new Integer(resultSet.getInt("id")))) {
/*1420*/                rowCount++;
                    }

/*1425*/            if (rowCount != ops.size() && rowCount != tempOpNameMap.size()) {
/*1427*/                StringBuffer sb1 = new StringBuffer();
/*1428*/                for (int i = 0; i < ops.size(); i++) {
/*1429*/                    String opName = (String)ops.elementAt(i);
/*1430*/                    if (!opNameToIdMap.containsKey(opName)) {
/*1431*/                        sb1.append(opName);
/*1432*/                        sb1.append(",");
                            }
                        }

/*1435*/                sb1.deleteCharAt(sb1.length() - 1);
/*1436*/                cp.returnConnection();
/*1437*/                throw new NoEntity((new StringBuilder(String.valueOf(sb1.toString()))).append(" operations are not present in the database.").toString());
                    }
                }
/*1441*/        catch (SQLException sqlException) {
/*1442*/            __logger.error((new StringBuilder("[AuthzDB][allowOpsForUser] : ")).append(sqlException.getMessage()).toString());
                }
/*1446*/        for (Enumeration e = opNameToIdMap.keys(); e.hasMoreElements();) {
/*1448*/            String opName = (String)(String)e.nextElement();
/*1449*/            int op_id = ((Integer)(Integer)opNameToIdMap.get(opName)).intValue();
/*1450*/            String insertQuery = "insert into data.authz_user_op_map (user_id, op_id) values (?, ?)";
/*1452*/            try {
/*1452*/                preparedStatement = connection.prepareStatement(insertQuery);
/*1453*/                preparedStatement.setInt(1, user_id);
/*1454*/                preparedStatement.setInt(2, op_id);
/*1455*/                int rowInserted = preparedStatement.executeUpdate();
/*1456*/                if (rowInserted != 0) {
/*1457*/                    __logger.debug((new StringBuilder("[AuthzDB][allowOpsForUser] : ")).append(user).append(" user is mapped with the operartion ").append(opName).append(" in database table authz_user_op_map.").toString());
                        } else {
/*1461*/                    __logger.debug((new StringBuilder("[AuthzDB][allowOpsForUser] : ")).append(user).append(" user is not mapped with the operartion ").append(opName).append(" in database table authz_user_op_map.").toString());
                        }
/*1465*/                resultSet.close();
/*1466*/                preparedStatement.close();
                    }
/*1467*/            catch (SQLException sqlException) {
/*1468*/                __logger.error((new StringBuilder("[AuthzDB][allowOpsForUser] : ")).append(sqlException.getMessage()).toString());
                    }
                }

/*1472*/        cp.returnConnection();
            }

            public void denyOpsForUser(Vector ops, String user) throws NoEntity, LimitCrossed, InternalError {
/*1496*/        Connection connection = cp.getConnection();
/*1497*/        PreparedStatement preparedStatement = null;
/*1498*/        ResultSet resultSet = null;
/*1499*/        int user_id = 0;
/*1502*/        try {
/*1502*/            String selectQuery = "select id from data.authz_users_mst where nickname = ?";
/*1503*/            preparedStatement = connection.prepareStatement(selectQuery);
/*1504*/            preparedStatement.setString(1, user);
/*1505*/            resultSet = preparedStatement.executeQuery();
/*1507*/            if (resultSet.next()) {
/*1508*/                user_id = resultSet.getInt(1);
/*1509*/                preparedStatement.close();
                    } else {
/*1511*/                resultSet.close();
/*1512*/                preparedStatement.close();
/*1513*/                cp.returnConnection();
/*1514*/                throw new NoEntity((new StringBuilder("Invalid user name ")).append(user).toString());
                    }
                }
/*1516*/        catch (SQLException sqlException) {
/*1517*/            __logger.error((new StringBuilder("[AuthzDB][denyOpsForUser] : ")).append(sqlException.getMessage()).toString());
                }
/*1521*/        Hashtable opNameToIdMap = new Hashtable();
/*1523*/        try {
/*1523*/            StringBuffer sb = new StringBuffer();
/*1524*/            sb.append("select id, name from authz_ops_mst where ");
/*1525*/            for (int i = 0; i < ops.size(); i++) {
/*1526*/                sb.append("name = ? or ");
                    }

/*1528*/            sb.delete(sb.length() - 3, sb.length() - 1);
/*1529*/            preparedStatement = connection.prepareStatement(sb.toString());
/*1531*/            Hashtable tempOpNameMap = new Hashtable();
/*1532*/            for (int i = 0; i < ops.size(); i++) {
/*1533*/                String opName = (String)(String)ops.elementAt(i);
/*1534*/                preparedStatement.setString(i + 1, opName);
/*1535*/                tempOpNameMap.put(opName, "");
                    }

/*1538*/            resultSet = preparedStatement.executeQuery();
/*1540*/            int rowCount = 0;
/*1542*/            for (; resultSet.next(); opNameToIdMap.put(resultSet.getString("name"), new Integer(resultSet.getInt("id")))) {
/*1542*/                rowCount++;
                    }

/*1547*/            if (rowCount != ops.size() && rowCount != tempOpNameMap.size()) {
/*1549*/                StringBuffer sb1 = new StringBuffer();
/*1550*/                for (int i = 0; i < ops.size(); i++) {
/*1551*/                    String opName = (String)(String)ops.elementAt(i);
/*1552*/                    if (!opNameToIdMap.containsKey(opName)) {
/*1553*/                        sb1.append(opName);
/*1554*/                        sb1.append(",");
                            }
                        }

/*1557*/                sb1.deleteCharAt(sb1.length() - 1);
/*1558*/                cp.returnConnection();
/*1559*/                throw new NoEntity((new StringBuilder(String.valueOf(sb1.toString()))).append(" operations are not present in the database.").toString());
                    }
                }
/*1563*/        catch (SQLException sqlException) {
/*1564*/            __logger.error((new StringBuilder("[AuthzDB][denyOpsForUser] : ")).append(sqlException.getMessage()).toString());
                }
/*1568*/        for (Enumeration e = opNameToIdMap.keys(); e.hasMoreElements();) {
/*1570*/            String opName = (String)(String)e.nextElement();
/*1571*/            int op_id = ((Integer)(Integer)opNameToIdMap.get(opName)).intValue();
/*1573*/            try {
/*1573*/                String deleteQuery = "delete from data.authz_user_op_map where role_id = 0 and user_id = ? and op_id = ?";
/*1574*/                preparedStatement = connection.prepareStatement(deleteQuery);
/*1575*/                preparedStatement.setInt(1, user_id);
/*1576*/                preparedStatement.setInt(2, op_id);
/*1577*/                int rowDeleted = preparedStatement.executeUpdate();
/*1578*/                if (rowDeleted != 0) {
/*1579*/                    __logger.debug((new StringBuilder("[AuthzDB][denyOpsForUser] : ")).append(user).append(" user is unmapped with the operartion ").append(opName).append(" in database table authz_user_op_map.").toString());
                        } else {
/*1583*/                    __logger.debug((new StringBuilder("[AuthzDB][denyOpsForUser] : ")).append(user).append(" user is not unmapped with the operartion ").append(opName).append(" in database table authz_user_op_map.").toString());
                        }
/*1587*/                resultSet.close();
/*1588*/                preparedStatement.close();
                    }
/*1590*/            catch (SQLException sqlException) {
/*1591*/                cp.returnConnection();
/*1592*/                throw new InternalError((new StringBuilder("[AuthzDB][denyOpsForUser] : ")).append(sqlException.getMessage()).toString());
                    }
                }

/*1596*/        cp.returnConnection();
            }

            public void allowAllOpsForUser(String user) throws NoEntity, LimitCrossed, InternalError {
/*1614*/        Connection connection = cp.getConnection();
/*1615*/        PreparedStatement preparedStatement = null;
/*1616*/        ResultSet resultSet = null;
/*1617*/        int user_id = 0;
/*1619*/        try {
/*1619*/            String selectQuery = "select id from data.authz_users_mst where nickname = ?";
/*1620*/            preparedStatement = connection.prepareStatement(selectQuery);
/*1621*/            preparedStatement.setString(1, user);
/*1622*/            resultSet = preparedStatement.executeQuery();
/*1624*/            if (resultSet.next()) {
/*1625*/                user_id = resultSet.getInt(1);
/*1626*/                preparedStatement.close();
                    } else {
/*1628*/                resultSet.close();
/*1629*/                preparedStatement.close();
/*1630*/                cp.returnConnection();
/*1631*/                throw new NoEntity((new StringBuilder("Invalid user name ")).append(user).toString());
                    }
                }
/*1633*/        catch (SQLException sqlException) {
/*1634*/            __logger.error((new StringBuilder("[AuthzDB][allowAllOpsForUser] : ")).append(sqlException.getMessage()).toString());
                }
/*1639*/        try {
/*1639*/            String selectQuery = "select id from data.authz_ops_mst where name is not null";
/*1640*/            preparedStatement = connection.prepareStatement(selectQuery);
/*1641*/            for (resultSet = preparedStatement.executeQuery(); resultSet.next();) {
/*1643*/                int op_id = resultSet.getInt(1);
/*1644*/                String insertQurey = "insert into data.authz_user_op_map (user_id, op_id) values (?, ?)";
/*1645*/                preparedStatement = connection.prepareStatement(insertQurey);
/*1646*/                preparedStatement.setInt(1, user_id);
/*1647*/                preparedStatement.setInt(2, op_id);
/*1650*/                try {
/*1650*/                    preparedStatement.executeUpdate();
                        }
/*1651*/                catch (SQLException sqlException) {
/*1652*/                    __logger.error((new StringBuilder("[AuthzDB][allowAllOpsForUser] : ")).append(sqlException.getMessage()).toString());
                        }
                    }

/*1657*/            resultSet.close();
/*1658*/            preparedStatement.close();
/*1659*/            __logger.debug((new StringBuilder("[AuthzDB][allowAllOpsForUser] : ")).append(user).append(" user is mapped with all the operations in the database table authz_user_op_map.").toString());
                }
/*1663*/        catch (SQLException sqlException) {
/*1664*/            __logger.error((new StringBuilder("[AuthzDB][allowAllOpsForUser] : ")).append(sqlException.getMessage()).toString());
                }
/*1667*/        cp.returnConnection();
            }

            public void denyAllOpsForUser(String user) throws NoEntity, LimitCrossed, InternalError {
/*1685*/        Connection connection = cp.getConnection();
/*1686*/        PreparedStatement preparedStatement = null;
/*1687*/        ResultSet resultSet = null;
/*1688*/        int user_id = 0;
/*1690*/        try {
/*1690*/            String selectQuery = "select id from data.authz_users_mst where nickname = ?";
/*1691*/            preparedStatement = connection.prepareStatement(selectQuery);
/*1692*/            preparedStatement.setString(1, user);
/*1693*/            resultSet = preparedStatement.executeQuery();
/*1695*/            if (resultSet.next()) {
/*1696*/                user_id = resultSet.getInt(1);
/*1697*/                preparedStatement.close();
                    } else {
/*1699*/                resultSet.close();
/*1700*/                preparedStatement.close();
/*1701*/                cp.returnConnection();
/*1702*/                throw new NoEntity((new StringBuilder("Invalid user name ")).append(user).toString());
                    }
                }
/*1704*/        catch (SQLException sqlException) {
/*1705*/            __logger.error((new StringBuilder("[AuthzDB][denyAllOpsForUser] : ")).append(sqlException.getMessage()).toString());
                }
/*1710*/        try {
/*1710*/            String deleteQurey = "delete from data.authz_user_op_map where user_id = ?";
/*1711*/            preparedStatement = connection.prepareStatement(deleteQurey);
/*1712*/            preparedStatement.setInt(1, user_id);
/*1713*/            preparedStatement.executeUpdate();
/*1714*/            preparedStatement.close();
/*1715*/            __logger.debug((new StringBuilder("[AuthzDB][denyAllOpsForUser] : ")).append(user).append(" user is unmapped with all the operartion in database table authz_user_op_map.").toString());
                }
/*1719*/        catch (SQLException sqlException) {
/*1720*/            __logger.error((new StringBuilder("[AuthzDB][denyAllOpsForUser] : ")).append(sqlException.getMessage()).toString());
                }
/*1723*/        cp.returnConnection();
            }

            public void addRole(String role) throws LimitCrossed, InternalError, DuplicateEntity, LimitReached {
/*1743*/        Connection connection = cp.getConnection();
/*1744*/        PreparedStatement preparedStatement = null;
/*1746*/        try {
/*1746*/            String insertQuery = "insert into data.authz_roles_mst (name) values (?)";
/*1747*/            preparedStatement = connection.prepareStatement(insertQuery);
/*1748*/            preparedStatement.setString(1, role);
/*1750*/            int rowInserted = preparedStatement.executeUpdate();
/*1751*/            if (rowInserted != 0) {
/*1752*/                __logger.debug((new StringBuilder("[AuthzDB][addRole] : ")).append(role).append(" Role is added in database table authz_roles_mst.").toString());
/*1756*/                try {
/*1756*/                    addOpToRole("__no_op__", role);
                        }
/*1757*/                catch (NoEntity e) {
/*1758*/                    addOp("__no_op__");
/*1760*/                    try {
/*1760*/                        addOpToRole("__no_op__", role);
                            }
/*1761*/                    catch (NoEntity e1) {
/*1762*/                        __logger.error((new StringBuilder("[AuthzDB][addRole] : Unable to map __no_op__ operation with role")).append(role).toString());
                            }
                        }
                    } else {
/*1768*/                __logger.debug((new StringBuilder("[AuthzDB][addRole] : ")).append(role).append(" Role is not added in database table authz_roles_mst.").toString());
/*1772*/                throw new DuplicateEntity((new StringBuilder("Role already present : ")).append(role).toString());
                    }
/*1774*/            preparedStatement.close();
                }
/*1775*/        catch (SQLException e) {
/*1776*/            __logger.error((new StringBuilder("[AuthzDB][addRole] : ")).append(e.getMessage()).toString());
/*1777*/            throw new DuplicateEntity((new StringBuilder("Role already present : ")).append(role).toString());
                }
/*1780*/        cp.returnConnection();
            }

            public void removeRole(String role) throws NoEntity, LimitCrossed, InternalError {
/*1797*/        Connection connection = cp.getConnection();
/*1798*/        PreparedStatement preparedStatement = null;
/*1799*/        ResultSet resultSet = null;
/*1800*/        int role_id = 0;
/*1802*/        try {
/*1802*/            String selectQuery = "select id from data.authz_roles_mst where name = ?";
/*1803*/            preparedStatement = connection.prepareStatement(selectQuery);
/*1804*/            preparedStatement.setString(1, role);
/*1805*/            resultSet = preparedStatement.executeQuery();
/*1807*/            if (resultSet.next()) {
/*1808*/                role_id = resultSet.getInt(1);
/*1809*/                preparedStatement.close();
                    } else {
/*1811*/                resultSet.close();
/*1812*/                preparedStatement.close();
/*1813*/                cp.returnConnection();
/*1814*/                throw new NoEntity((new StringBuilder("Invalid role name ")).append(role).toString());
                    }
                }
/*1816*/        catch (SQLException sqlException) {
/*1817*/            __logger.error((new StringBuilder("[AuthzDB][removeRole] : ")).append(sqlException.getMessage()).toString());
                }
/*1822*/        try {
/*1822*/            String deleteQuery = "delete from data.authz_role_op_map where role_id = ?";
/*1823*/            preparedStatement = connection.prepareStatement(deleteQuery);
/*1824*/            preparedStatement.setInt(1, role_id);
/*1825*/            int rowDeleted = preparedStatement.executeUpdate();
/*1827*/            if (rowDeleted != 0) {
/*1828*/                __logger.debug((new StringBuilder("[AuthzDB][removeRole] : ")).append(role).append(" Role is unmapped in database table authz_role_op_map. ").append(rowDeleted).append(" rows are removed from database table authz_role_op_map").toString());
/*1834*/                preparedStatement.close();
                    } else {
/*1836*/                __logger.debug((new StringBuilder("[AuthzDB][removeRole] : ")).append(role).append(" Role is not unmapped in database table authz_role_op_map. ").append(rowDeleted).append(" rows are removed from database table authz_role_op_map").toString());
/*1842*/                preparedStatement.close();
                    }
                }
/*1844*/        catch (SQLException sqlException) {
/*1845*/            __logger.error((new StringBuilder("[AuthzDB][removeRole] : ")).append(sqlException.getMessage()).toString());
                }
/*1850*/        try {
/*1850*/            String deleteQuery = "delete from data.authz_user_op_map where role_id = ?";
/*1851*/            preparedStatement = connection.prepareStatement(deleteQuery);
/*1852*/            preparedStatement.setInt(1, role_id);
/*1853*/            int rowDeleted = preparedStatement.executeUpdate();
/*1855*/            if (rowDeleted != 0) {
/*1856*/                __logger.debug((new StringBuilder("[AuthzDB][removeRole] : ")).append(role).append(" Role is unmapped in database table authz_user_op_map. ").append(rowDeleted).append(" rows are removed from database table authz_user_op_map").toString());
/*1862*/                preparedStatement.close();
                    } else {
/*1864*/                __logger.debug((new StringBuilder("[AuthzDB][removeRole] : ")).append(role).append(" Role is not unmapped in database table authz_user_op_map. ").append(rowDeleted).append(" rows are removed from database table authz_user_op_map").toString());
/*1870*/                preparedStatement.close();
                    }
                }
/*1872*/        catch (SQLException sqlException) {
/*1873*/            __logger.error((new StringBuilder("[AuthzDB][removeRole] : ")).append(sqlException.getMessage()).toString());
                }
/*1878*/        try {
/*1878*/            String deleteQuery = "delete from data.authz_roles_mst where id = ?";
/*1879*/            preparedStatement = connection.prepareStatement(deleteQuery);
/*1880*/            preparedStatement.setInt(1, role_id);
/*1881*/            int rowDeleted = preparedStatement.executeUpdate();
/*1882*/            if (rowDeleted != 0) {
/*1883*/                __logger.debug((new StringBuilder("[AuthzDB][removeRole] : ")).append(role).append(" role is removed from database table authz_roles_mst.").toString());
/*1887*/                preparedStatement.close();
                    } else {
/*1889*/                preparedStatement.close();
/*1890*/                __logger.debug((new StringBuilder("[AuthzDB][removeRole] : ")).append(role).append(" role is not removed from database table authz_roles_mst.").toString());
                    }
                }
/*1895*/        catch (SQLException sqlException) {
/*1896*/            __logger.error((new StringBuilder("[AuthzDB][removeRole] : ")).append(sqlException.getMessage()).toString());
                }
/*1899*/        cp.returnConnection();
            }

            public void addOpToRole(String op, String role) throws NoEntity, LimitCrossed, InternalError {
/*1921*/        Connection connection = cp.getConnection();
/*1922*/        PreparedStatement preparedStatement = null;
/*1923*/        ResultSet resultSet = null;
                int role_id;
/*1926*/        try {
/*1926*/            role_id = getRoleId(role);
                }
/*1927*/        catch (SQLException e) {
/*1928*/            throw new InternalError((new StringBuilder("[AuthzDB][addOpToRole] : Error in fetching role id, ")).append(e).toString());
                }
/*1931*/        if (role_id == 0) {
/*1932*/            throw new NoEntity("Invalid Role name.");
                }
/*1935*/        int op_id = 0;
/*1938*/        try {
/*1938*/            String selectQuery = "select id from data.authz_ops_mst where name = ?";
/*1939*/            preparedStatement = connection.prepareStatement(selectQuery);
/*1940*/            preparedStatement.setString(1, op);
/*1941*/            resultSet = preparedStatement.executeQuery();
/*1943*/            if (resultSet.next()) {
/*1944*/                op_id = resultSet.getInt("id");
/*1945*/                preparedStatement.close();
                    } else {
/*1947*/                resultSet.close();
/*1948*/                preparedStatement.close();
/*1949*/                cp.returnConnection();
/*1950*/                throw new NoEntity("Invalid operation name.");
                    }
                }
/*1952*/        catch (SQLException e) {
/*1953*/            __logger.error((new StringBuilder("[AuthzDB][addOpToRole] : ")).append(e.getMessage()).toString());
                }
/*1957*/        try {
/*1957*/            String insertQuery = "insert into data.authz_role_op_map (role_id, op_id) values (?, ?) ";
/*1958*/            preparedStatement = connection.prepareStatement(insertQuery);
/*1959*/            preparedStatement.setInt(1, role_id);
/*1960*/            preparedStatement.setInt(2, op_id);
/*1961*/            int rowInserted = preparedStatement.executeUpdate();
/*1963*/            if (rowInserted != 0) {
/*1964*/                __logger.debug((new StringBuilder("[AuthzDB][addOpToRole] : ")).append(role).append(" role is mapped with operation ").append(op).append(" in database table authz_role_op_map.").toString());
                    } else {
/*1968*/                __logger.debug((new StringBuilder("[AuthzDB][addOpToRole] : ")).append(role).append(" role is not mapped with operation ").append(op).append(" in database table authz_role_op_map.").toString());
                    }
/*1972*/            preparedStatement.close();
                }
/*1973*/        catch (SQLException e) {
/*1974*/            __logger.error((new StringBuilder("[AuthzDB][addOpToRole] : ")).append(e.getMessage()).toString());
                }
/*1977*/        Vector lvUsersName = getUsersForRole(role);
/*1978*/        for (int i = 0; i < lvUsersName.size(); i++) {
/*1980*/            try {
/*1980*/                int user_id = 0;
/*1981*/                String userName = (String)(String)lvUsersName.elementAt(i);
/*1982*/                String selectQuery = "select id from data.authz_users_mst where nickname = ?";
/*1983*/                preparedStatement = connection.prepareStatement(selectQuery);
/*1984*/                preparedStatement.setString(1, userName);
/*1985*/                resultSet = preparedStatement.executeQuery();
/*1987*/                if (resultSet.next()) {
/*1988*/                    user_id = resultSet.getInt("id");
/*1989*/                    preparedStatement.close();
                        } else {
/*1991*/                    resultSet.close();
/*1992*/                    preparedStatement.close();
/*1993*/                    cp.returnConnection();
/*1994*/                    throw new NoEntity("Invalid user name.");
                        }
/*1997*/                String insertQuery = "insert into data.authz_user_op_map (role_id, op_id, user_id) values (?, ?, ?) ";
/*1998*/                preparedStatement = connection.prepareStatement(insertQuery);
/*1999*/                preparedStatement.setInt(1, role_id);
/*2000*/                preparedStatement.setInt(2, op_id);
/*2001*/                preparedStatement.setInt(3, user_id);
/*2002*/                int rowInserted = preparedStatement.executeUpdate();
/*2004*/                if (rowInserted != 0) {
/*2005*/                    __logger.debug((new StringBuilder("[AuthzDB][addOpToRole] : ")).append(role).append(" role is mapped with operation ").append(op).append(" and user ").append(userName).append(" in database table authz_user_op_map.").toString());
                        } else {
/*2010*/                    __logger.debug((new StringBuilder("[AuthzDB][addOpToRole] : ")).append(role).append(" role is not mapped with operation ").append(op).append(" and user ").append(userName).append(" in database table authz_user_op_map.").toString());
                        }
/*2015*/                resultSet.close();
/*2016*/                preparedStatement.close();
                    }
/*2017*/            catch (SQLException e) {
/*2018*/                __logger.error((new StringBuilder("[AuthzDB][addOpToRole] : ")).append(e.getMessage()).toString());
                    }
                }

            }

            public void removeOpFromRole(String op, String role) throws NoEntity, LimitCrossed, InternalError {
/*2042*/        Connection connection = cp.getConnection();
/*2043*/        PreparedStatement preparedStatement = null;
/*2044*/        ResultSet resultSet = null;
/*2046*/        int role_id = 0;
/*2047*/        int op_id = 0;
/*2049*/        try {
/*2049*/            String selectQuery = "select id from data.authz_roles_mst where name = ?";
/*2050*/            preparedStatement = connection.prepareStatement(selectQuery);
/*2051*/            preparedStatement.setString(1, role);
/*2052*/            resultSet = preparedStatement.executeQuery();
/*2054*/            if (resultSet.next()) {
/*2055*/                role_id = resultSet.getInt("id");
/*2056*/                preparedStatement.close();
                    } else {
/*2058*/                preparedStatement.close();
/*2059*/                cp.returnConnection();
/*2060*/                throw new NoEntity("Invalid Role name.");
                    }
                }
/*2062*/        catch (SQLException e) {
/*2063*/            __logger.error((new StringBuilder("[AuthzDB][removeOpFromRole] : ")).append(e.getMessage()).toString());
                }
/*2067*/        try {
/*2067*/            String selectQuery = "select id from authz_ops_mst where name = ?";
/*2068*/            preparedStatement = connection.prepareStatement(selectQuery);
/*2069*/            preparedStatement.setString(1, op);
/*2070*/            resultSet = preparedStatement.executeQuery();
/*2072*/            if (resultSet.next()) {
/*2073*/                op_id = resultSet.getInt("id");
/*2074*/                preparedStatement.close();
                    } else {
/*2076*/                preparedStatement.close();
/*2077*/                cp.returnConnection();
/*2078*/                throw new NoEntity("Invalid operation name.");
                    }
                }
/*2080*/        catch (SQLException e) {
/*2081*/            __logger.error((new StringBuilder("[AuthzDB][removeOpFromRole] : ")).append(e.getMessage()).toString());
                }
/*2085*/        try {
/*2085*/            String deleteQuery = "delete from data.authz_role_op_map where role_id = ? and op_id = ?";
/*2086*/            preparedStatement = connection.prepareStatement(deleteQuery);
/*2087*/            preparedStatement.setInt(1, role_id);
/*2088*/            preparedStatement.setInt(2, op_id);
/*2089*/            int rowDeleted = preparedStatement.executeUpdate();
/*2090*/            if (rowDeleted != 0) {
/*2091*/                __logger.debug((new StringBuilder("[AuthzDB][removeOpFromRole] : ")).append(role).append(" role is unmapped with the operartion ").append(op).append(" in database table authz_role_op_map.").toString());
                    } else {
/*2095*/                __logger.debug((new StringBuilder("[AuthzDB][removeOpFromRole] : ")).append(role).append(" role is not unmapped with the operartion ").append(op).append(" in cache table authz_role_op_map.").toString());
                    }
/*2099*/            resultSet.close();
/*2100*/            preparedStatement.close();
                }
/*2101*/        catch (SQLException sqlException) {
/*2102*/            __logger.error((new StringBuilder("[AuthzDB][removeOpFromRole] : ")).append(sqlException.getMessage()).toString());
                }
/*2106*/        Vector lvUsersName = getUsersForRole(role);
/*2107*/        for (int i = 0; i < lvUsersName.size(); i++) {
/*2109*/            try {
/*2109*/                int user_id = 0;
/*2110*/                String userName = (String)(String)lvUsersName.elementAt(i);
/*2111*/                String selectQuery = "select id from data.authz_users_mst where nickname = ?";
/*2112*/                preparedStatement = connection.prepareStatement(selectQuery);
/*2113*/                preparedStatement.setString(1, userName);
/*2114*/                resultSet = preparedStatement.executeQuery();
/*2116*/                if (resultSet.next()) {
/*2117*/                    user_id = resultSet.getInt("id");
/*2118*/                    preparedStatement.close();
                        } else {
/*2120*/                    resultSet.close();
/*2121*/                    preparedStatement.close();
/*2122*/                    cp.returnConnection();
/*2123*/                    throw new NoEntity("Invalid user name.");
                        }
/*2126*/                String deleteQuery = "delete from data.authz_user_op_map where role_id = ? and op_id = ? and user_id = ?";
/*2127*/                preparedStatement = connection.prepareStatement(deleteQuery);
/*2128*/                preparedStatement.setInt(1, role_id);
/*2129*/                preparedStatement.setInt(2, op_id);
/*2130*/                preparedStatement.setInt(3, user_id);
/*2131*/                int rowInserted = preparedStatement.executeUpdate();
/*2133*/                if (rowInserted != 0) {
/*2134*/                    __logger.debug((new StringBuilder("[AuthzDB][removeOpFromRole] : ")).append(role).append(" role is unmapped with operation ").append(op).append(" and user ").append(userName).append(" in database table authz_user_op_map.").toString());
                        } else {
/*2139*/                    __logger.debug((new StringBuilder("[AuthzDB][removeOpFromRole] : ")).append(role).append(" role is not unmapped with operation ").append(op).append(" and user ").append(userName).append(" in database table authz_user_op_map.").toString());
                        }
/*2144*/                resultSet.close();
/*2145*/                preparedStatement.close();
                    }
/*2146*/            catch (SQLException e) {
/*2147*/                __logger.error((new StringBuilder("[AuthzDB][removeOpFromRole] : ")).append(e.getMessage()).toString());
                    }
                }

/*2151*/        cp.returnConnection();
            }

            public void addOpsToRole(Vector ops, String role) throws NoEntity, LimitCrossed, InternalError {
/*2174*/        Connection connection = cp.getConnection();
/*2175*/        PreparedStatement preparedStatement = null;
/*2176*/        ResultSet resultSet = null;
                int role_id;
/*2180*/        try {
/*2180*/            role_id = getRoleId(role);
                }
/*2181*/        catch (SQLException e) {
/*2182*/            throw new InternalError((new StringBuilder("[AuthzDB][addOpsToRole] : Error in fetching role id, ")).append(e).toString());
                }
/*2186*/        if (role_id == 0) {
/*2187*/            __logger.error((new StringBuilder("[AuthzDB][addOpsToRole] : Invalid role name ")).append(role).toString());
/*2189*/            throw new NoEntity((new StringBuilder("Invalid role name ")).append(role).toString());
                }
/*2192*/        Hashtable opNameToIdMap = new Hashtable();
/*2194*/        try {
/*2194*/            StringBuffer sb = new StringBuffer();
/*2195*/            sb.append("select id, name from data.authz_ops_mst where ");
/*2196*/            for (int i = 0; i < ops.size(); i++) {
/*2197*/                sb.append("name = ? or ");
                    }

/*2199*/            sb.delete(sb.lastIndexOf("or "), sb.length() - 1);
/*2201*/            preparedStatement = connection.prepareStatement(sb.toString());
/*2203*/            Hashtable tempOpNameMap = new Hashtable();
/*2204*/            for (int i = 0; i < ops.size(); i++) {
/*2205*/                String opName = (String)(String)ops.elementAt(i);
/*2206*/                preparedStatement.setString(i + 1, opName);
/*2207*/                tempOpNameMap.put(opName, "");
                    }

/*2210*/            resultSet = preparedStatement.executeQuery();
/*2212*/            int rowCount = 0;
/*2214*/            for (; resultSet.next(); opNameToIdMap.put(resultSet.getString("name"), new Integer(resultSet.getInt("id")))) {
/*2214*/                rowCount++;
                    }

/*2219*/            if (rowCount != ops.size() && rowCount != tempOpNameMap.size()) {
/*2221*/                StringBuffer sb1 = new StringBuffer();
/*2222*/                for (int i = 0; i < ops.size(); i++) {
/*2223*/                    String opName = (String)(String)ops.elementAt(i);
/*2224*/                    if (!opNameToIdMap.containsKey(opName)) {
/*2225*/                        sb1.append(opName);
/*2226*/                        sb1.append(",");
                            }
                        }

/*2229*/                sb1.deleteCharAt(sb1.length() - 1);
/*2230*/                cp.returnConnection();
/*2231*/                throw new NoEntity((new StringBuilder(String.valueOf(sb1.toString()))).append(" operations are not present in the database.").toString());
                    }
                }
/*2235*/        catch (SQLException sqlException) {
/*2236*/            __logger.error((new StringBuilder("[AuthzDB][addOpsToRole] : ")).append(sqlException.getMessage()).toString());
                }
/*2240*/        for (Enumeration e = opNameToIdMap.keys(); e.hasMoreElements();) {
/*2242*/            String opName = (String)(String)e.nextElement();
/*2243*/            int op_id = ((Integer)opNameToIdMap.get(opName)).intValue();
/*2246*/            try {
/*2246*/                String insertQuery = "insert into data.authz_role_op_map (role_id, op_id) values (?, ?)";
/*2247*/                preparedStatement = connection.prepareStatement(insertQuery);
/*2248*/                preparedStatement.setInt(1, role_id);
/*2249*/                preparedStatement.setInt(2, op_id);
/*2250*/                int rowInserted = preparedStatement.executeUpdate();
/*2251*/                if (rowInserted != 0) {
/*2252*/                    __logger.debug((new StringBuilder("[AuthzDB][addOpsToRole] : ")).append(role).append(" role is mapped with the operartion ").append(opName).append(" in database table authz_role_op_map.").toString());
                        } else {
/*2256*/                    __logger.debug((new StringBuilder("[AuthzDB][addOpsToRole] : ")).append(role).append(" role is not mapped with the operartion ").append(opName).append(" in database table authz_role_op_map.").toString());
                        }
/*2260*/                preparedStatement.close();
                    }
/*2261*/            catch (SQLException sqlException) {
/*2262*/                cp.returnConnection();
/*2263*/                throw new InternalError((new StringBuilder("[AuthzDB][addOpsToRole] : ")).append(sqlException.getMessage()).toString());
                    }
/*2267*/            Vector lvUserName = getUsersForRole(role);
/*2269*/            for (Iterator iterator = lvUserName.iterator(); iterator.hasNext();) {
/*2269*/                String userName = (String)iterator.next();
                        int user_id;
/*2273*/                try {
/*2273*/                    user_id = getUserId(userName);
                        }
/*2274*/                catch (SQLException e1) {
/*2275*/                    throw new InternalError((new StringBuilder("[AuthzDB][addOpsToRole] : Error in fetching user id, ")).append(e1).toString());
                        }
/*2281*/                try {
/*2281*/                    String insertQuery = "insert into data.authz_user_op_map (role_id, op_id, user_id) values (?, ?, ?)";
/*2282*/                    preparedStatement = connection.prepareStatement(insertQuery);
/*2284*/                    preparedStatement.setInt(1, role_id);
/*2285*/                    preparedStatement.setInt(2, op_id);
/*2286*/                    preparedStatement.setInt(3, user_id);
/*2287*/                    int rowInserted = preparedStatement.executeUpdate();
/*2288*/                    if (rowInserted != 0) {
/*2289*/                        __logger.debug((new StringBuilder("[AuthzDB][addOpsToRole] : ")).append(role).append(" role is mapped with the operartion ").append(opName).append(" and user ").append(userName).append(" in database table authz_user_op_map.").toString());
                            } else {
/*2294*/                        __logger.debug((new StringBuilder("[AuthzDB][addOpsToRole] : ")).append(role).append(" role is not mapped with the operartion ").append(opName).append(" and user ").append(userName).append(" in database table authz_user_op_map.").toString());
                            }
/*2299*/                    resultSet.close();
/*2300*/                    preparedStatement.close();
                        }
/*2301*/                catch (SQLException sqlException) {
/*2302*/                    cp.returnConnection();
/*2303*/                    throw new InternalError((new StringBuilder("[AuthzDB][addOpsToRole] : ")).append(sqlException.getMessage()).toString());
                        }
                    }

                }

            }

            public void removeOpsFromRole(Vector ops, String role) throws NoEntity, LimitCrossed, InternalError {
/*2330*/        Connection connection = cp.getConnection();
/*2331*/        PreparedStatement preparedStatement = null;
/*2332*/        ResultSet resultSet = null;
                int role_id;
/*2336*/        try {
/*2336*/            role_id = getRoleId(role);
                }
/*2337*/        catch (SQLException e) {
/*2338*/            throw new InternalError((new StringBuilder("[AuthzDB][removeOpsFromRole] : Error in fetching role id, ")).append(e).toString());
                }
/*2343*/        if (role_id == 0) {
/*2344*/            __logger.error((new StringBuilder("[AuthzDB][removeOpsFromRole] : Invalid role name ")).append(role).toString());
/*2346*/            throw new NoEntity((new StringBuilder("Invalid role name ")).append(role).toString());
                }
/*2349*/        Hashtable opNameToIdMap = new Hashtable();
/*2351*/        try {
/*2351*/            StringBuffer sb = new StringBuffer();
/*2352*/            sb.append("select id, name from data.authz_ops_mst where ");
/*2353*/            for (int i = 0; i < ops.size(); i++) {
/*2354*/                sb.append("name = ? or ");
                    }

/*2357*/            sb.delete(sb.lastIndexOf("or "), sb.length() - 1);
/*2358*/            preparedStatement = connection.prepareStatement(sb.toString());
/*2360*/            Hashtable tempOpNameMap = new Hashtable();
/*2361*/            for (int i = 0; i < ops.size(); i++) {
/*2362*/                String opName = (String)(String)ops.elementAt(i);
/*2363*/                preparedStatement.setString(i + 1, opName);
/*2364*/                tempOpNameMap.put(opName, "");
                    }

/*2367*/            resultSet = preparedStatement.executeQuery();
/*2369*/            int rowCount = 0;
/*2371*/            for (; resultSet.next(); opNameToIdMap.put(resultSet.getString("name"), new Integer(resultSet.getInt("id")))) {
/*2371*/                rowCount++;
                    }

/*2376*/            if (rowCount != ops.size() && rowCount != tempOpNameMap.size()) {
/*2378*/                StringBuffer sb1 = new StringBuffer();
/*2379*/                for (int i = 0; i < ops.size(); i++) {
/*2380*/                    String opName = (String)(String)ops.elementAt(i);
/*2381*/                    if (!opNameToIdMap.containsKey(opName)) {
/*2382*/                        sb1.append(opName);
/*2383*/                        sb1.append(",");
                            }
                        }

/*2386*/                sb1.deleteCharAt(sb1.length() - 1);
/*2387*/                cp.returnConnection();
/*2388*/                throw new NoEntity((new StringBuilder(String.valueOf(sb1.toString()))).append(" operations are not present in the database.").toString());
                    }
                }
/*2392*/        catch (SQLException sqlException) {
/*2393*/            __logger.error((new StringBuilder("[AuthzDB][removeOpsFromRole] : ")).append(sqlException.getMessage()).toString());
                }
/*2397*/        for (Enumeration e = opNameToIdMap.keys(); e.hasMoreElements();) {
/*2399*/            String opName = (String)(String)e.nextElement();
/*2400*/            int op_id = ((Integer)opNameToIdMap.get(opName)).intValue();
/*2403*/            try {
/*2403*/                String deleteQuery = "delete from data.authz_role_op_map where role_id = ? and op_id = ?";
/*2404*/                preparedStatement = connection.prepareStatement(deleteQuery);
/*2405*/                preparedStatement.setInt(1, role_id);
/*2406*/                preparedStatement.setInt(2, op_id);
/*2407*/                int rowdeleted = preparedStatement.executeUpdate();
/*2408*/                if (rowdeleted != 0) {
/*2409*/                    __logger.debug((new StringBuilder("[AuthzDB][removeOpsFromRole] : ")).append(role).append(" role is unmapped with the operartion ").append(opName).append(" in database table authz_role_op_map.").toString());
                        } else {
/*2413*/                    __logger.debug((new StringBuilder("[AuthzDB][removeOpsFromRole] : ")).append(role).append(" role is not unmapped with the operartion ").append(opName).append(" in database table authz_role_op_map.").toString());
                        }
/*2417*/                preparedStatement.close();
                    }
/*2418*/            catch (SQLException sqlException) {
/*2419*/                cp.returnConnection();
/*2420*/                throw new InternalError((new StringBuilder("[AuthzDB][removeOpsFromRole] : ")).append(sqlException.getMessage()).toString());
                    }
/*2424*/            Vector lvUserName = getUsersForRole(role);
/*2425*/            for (Iterator iterator = lvUserName.iterator(); iterator.hasNext();) {
/*2425*/                String userName = (String)iterator.next();
                        int user_id;
/*2429*/                try {
/*2429*/                    user_id = getUserId(userName);
                        }
/*2430*/                catch (SQLException e1) {
/*2431*/                    throw new InternalError((new StringBuilder("[AuthzDB][removeOpsFromRole] : Error in fetching user id, ")).append(e1).toString());
                        }
/*2435*/                if (user_id == 0) {
/*2436*/                    __logger.error((new StringBuilder("[AuthzDB][removeOpsFromRole] : Invalid user name ")).append(userName).toString());
/*2439*/                    throw new NoEntity((new StringBuilder("Invalid user name ")).append(userName).toString());
                        }
/*2443*/                try {
/*2443*/                    String deleteQuery = "delete from data.authz_user_op_map where role_id = ? and op_id = ? and user_id = ?";
/*2444*/                    preparedStatement = connection.prepareStatement(deleteQuery);
/*2446*/                    preparedStatement.setInt(1, role_id);
/*2447*/                    preparedStatement.setInt(2, op_id);
/*2448*/                    preparedStatement.setInt(3, user_id);
/*2449*/                    int rowdeleted = preparedStatement.executeUpdate();
/*2450*/                    if (rowdeleted != 0) {
/*2451*/                        __logger.debug((new StringBuilder("[AuthzDB][removeOpsFromRole] : ")).append(role).append(" role is unmapped with the operartion ").append(opName).append(" and user ").append(userName).append(" in database table authz_user_op_map.").toString());
                            } else {
/*2456*/                        __logger.debug((new StringBuilder("[AuthzDB][removeOpsFromRole] : ")).append(role).append(" role is not unmapped with the operartion ").append(opName).append(" and user ").append(userName).append(" in database table authz_user_op_map.").toString());
                            }
/*2461*/                    resultSet.close();
/*2462*/                    preparedStatement.close();
                        }
/*2463*/                catch (SQLException sqlException) {
/*2464*/                    throw new InternalError((new StringBuilder("[AuthzDB][removeOpsFromRole] : ")).append(sqlException.getMessage()).toString());
                        }
                    }

                }

/*2469*/        cp.returnConnection();
            }

            public void mapUserToRole(String user, String role) throws LimitCrossed, InternalError, NoEntity {
                Connection connection;
                PreparedStatement preparedStatement;
                ResultSet resultSet;
                int user_id;
                int role_id;
                String selectQuery;
                String insertQuery;
/*2488*/        connection = cp.getConnection();
/*2489*/        preparedStatement = null;
/*2490*/        resultSet = null;
/*2494*/        try {
/*2494*/            user_id = getUserId(user);
                }
/*2495*/        catch (SQLException e) {
/*2496*/            throw new InternalError((new StringBuilder("[AuthzDB][mapUserToRole] : Error in fetching user id, ")).append(e).toString());
                }
/*2502*/        try {
/*2502*/            role_id = getRoleId(role);
                }
/*2503*/        catch (SQLException e) {
/*2504*/            throw new InternalError((new StringBuilder("[AuthzDB][mapUserToRole] : Error in fetching role id, ")).append(e).toString());
                }
/*2510*/        selectQuery = "select authz_role_op_map.role_id, authz_role_op_map.op_id, authz_ops_mst.name op_name from data.authz_role_op_map join data.authz_roles_mst on authz_roles_mst.id = authz_role_op_map.role_id join authz_ops_mst on authz_ops_mst.id = authz_role_op_map.op_id where authz_roles_mst.name = ?";
/*2516*/        insertQuery = "insert into data.authz_user_op_map(role_id, user_id, op_id) values(?, ?, ?)";
/*2519*/        try {
/*2519*/            preparedStatement = connection.prepareStatement(selectQuery);
/*2520*/            preparedStatement.setString(1, role);
/*2521*/            resultSet = preparedStatement.executeQuery();
/*2523*/            if (resultSet.next()) {
/*2525*/                do {
/*2525*/                    preparedStatement = connection.prepareStatement(insertQuery);
/*2527*/                    preparedStatement.setInt(1, role_id);
/*2528*/                    preparedStatement.setInt(2, user_id);
/*2529*/                    preparedStatement.setInt(3, resultSet.getInt("op_id"));
/*2530*/                    int affectedrows = preparedStatement.executeUpdate();
/*2531*/                    if (affectedrows == 0) {
/*2532*/                        __logger.debug((new StringBuilder("[AuthzDB][mapUserToRole] : Not mapped - User '")).append(user).append("' Operation '").append(resultSet.getString("op_name")).append("', Role '").append(role).append("'").toString());
                            } else {
/*2538*/                        __logger.debug((new StringBuilder("[AuthzDB][mapUserToRole] : Mapped - User '")).append(user).append("' Operation '").append(resultSet.getString("op_name")).append("', Role '").append(role).append("'").toString());
                            }
                        } while (resultSet.next());
                    } else {
/*2546*/                addOpToRole("__no_op__", role);
/*2547*/                int op_id = getOpId("__no_op__");
/*2548*/                preparedStatement = connection.prepareStatement(insertQuery);
/*2549*/                preparedStatement.setInt(1, role_id);
/*2550*/                preparedStatement.setInt(2, user_id);
/*2551*/                preparedStatement.setInt(3, op_id);
/*2552*/                int affectedrows = preparedStatement.executeUpdate();
/*2553*/                if (affectedrows == 0) {
/*2554*/                    __logger.debug((new StringBuilder("[AuthzDB][mapUserToRole] : Not mapped - User '")).append(user).append("' Operation '").append("__no_op__").append("', Role '").append(role).append("'").toString());
                        } else {
/*2558*/                    __logger.debug((new StringBuilder("[AuthzDB][mapUserToRole] : Mapped - User '")).append(user).append("' Operation '").append("__no_op__").append("', Role '").append(role).append("'").toString());
                        }
                    }
                }
/*2563*/        catch (SQLException sqlException) {
/*2564*/            __logger.error((new StringBuilder("[AuthzDB][mapUserToRole] : ")).append(sqlException.getMessage()).toString());
                }
/*2567*/        cp.returnConnection();
/*2569*/        try {
/*2569*/            resultSet.close();
                }
/*2570*/        catch (SQLException e) {
/*2571*/            __logger.error((new StringBuilder("[AuthzDB][mapUserToRole] : ")).append(e.getMessage()).toString());
                }
/*2574*/        try {
/*2574*/            preparedStatement.close();
                }
/*2575*/        catch (SQLException e) {
/*2576*/            __logger.error((new StringBuilder("[AuthzDB][mapUserToRole] : ")).append(e.getMessage()).toString());
                }
/*2567*/        cp.returnConnection();
/*2569*/        try {
/*2569*/            resultSet.close();
                }
/*2570*/        catch (SQLException e) {
/*2571*/            __logger.error((new StringBuilder("[AuthzDB][mapUserToRole] : ")).append(e.getMessage()).toString());
                }
/*2574*/        try {
/*2574*/            preparedStatement.close();
                }
/*2575*/        catch (SQLException e) {
/*2576*/            __logger.error((new StringBuilder("[AuthzDB][mapUserToRole] : ")).append(e.getMessage()).toString());
                }
/*2579*/        return;
            }

            public void mapUsersToRole(String role, Vector users) throws LimitCrossed, InternalError, NoEntity {
                Connection connection;
                PreparedStatement preparedStatement;
                ResultSet resultSet;
                int role_id;
                String selectQuery;
                String insertQuery;
/*2597*/        connection = cp.getConnection();
/*2598*/        preparedStatement = null;
/*2599*/        resultSet = null;
/*2603*/        try {
/*2603*/            role_id = getRoleId(role);
                }
/*2604*/        catch (SQLException e) {
/*2605*/            throw new InternalError((new StringBuilder("[AuthzDB][mapUsersToRole] : Error in fetching role id, ")).append(e).toString());
                }
/*2610*/        if (role_id == 0) {
/*2611*/            throw new NoEntity("[AuthzDB][mapUsersToRole] : Role name is invalid");
                }
/*2616*/        selectQuery = "select authz_role_op_map.role_id, authz_role_op_map.op_id, authz_ops_mst.name op_name from data.authz_role_op_map join data.authz_roles_mst on authz_roles_mst.id = authz_role_op_map.role_id join authz_ops_mst on authz_ops_mst.id = authz_role_op_map.op_id where authz_roles_mst.name = ?";
/*2622*/        insertQuery = "insert into authz_user_op_map(role_id, user_id, op_id) values(?, ?, ?)";
/*2625*/        try {
/*2625*/            preparedStatement = connection.prepareStatement(selectQuery);
/*2626*/            preparedStatement.setString(1, role);
/*2627*/            resultSet = preparedStatement.executeQuery();
/*2629*/            if (resultSet.next()) {
/*2631*/                do {
/*2631*/                    int op_id = resultSet.getInt("op_id");
/*2632*/                    for (Iterator iterator = users.iterator(); iterator.hasNext();) {
/*2632*/                        String user = (String)iterator.next();
/*2633*/                        int user_id = getUserId(user);
/*2634*/                        preparedStatement = connection.prepareStatement(insertQuery);
/*2636*/                        preparedStatement.setInt(1, role_id);
/*2637*/                        preparedStatement.setInt(2, user_id);
/*2638*/                        preparedStatement.setInt(3, op_id);
/*2640*/                        int affectedrows = preparedStatement.executeUpdate();
/*2641*/                        if (affectedrows == 0) {
/*2642*/                            __logger.debug((new StringBuilder("[AuthzDB][mapUserToRole] : Not mapped - User '")).append(user).append("' Operation '").append(resultSet.getString("op_name")).append("', Role '").append(role).append("'").toString());
                                } else {
/*2648*/                            __logger.debug((new StringBuilder("[AuthzDB][mapUserToRole] : Mapped - User '")).append(user).append("' Operation '").append(resultSet.getString("op_name")).append("', Role '").append(role).append("'").toString());
                                }
                            }

                        } while (resultSet.next());
                    } else {
/*2659*/                addOpToRole("__no_op__", role);
/*2660*/                int op_id = getOpId("__no_op__");
/*2662*/                for (Iterator iterator1 = users.iterator(); iterator1.hasNext();) {
/*2662*/                    String user = (String)iterator1.next();
/*2663*/                    int user_id = getUserId(user);
/*2664*/                    preparedStatement = connection.prepareStatement(insertQuery);
/*2666*/                    preparedStatement.setInt(1, role_id);
/*2667*/                    preparedStatement.setInt(2, user_id);
/*2668*/                    preparedStatement.setInt(3, op_id);
/*2670*/                    int affectedrows = preparedStatement.executeUpdate();
/*2671*/                    if (affectedrows == 0) {
/*2672*/                        __logger.debug((new StringBuilder("[AuthzDB][mapUserToRole] : Not mapped - User '")).append(user).append("' Operation '").append("__no_op__").append("', Role '").append(role).append("'").toString());
                            } else {
/*2677*/                        __logger.debug((new StringBuilder("[AuthzDB][mapUserToRole] : Mapped - User '")).append(user).append("' Operation '").append("__no_op__").append("', Role '").append(role).append("'").toString());
                            }
                        }

                    }
                }
/*2683*/        catch (SQLException sqlException) {
/*2684*/            __logger.error((new StringBuilder("[AuthzDB][mapUserToRole] : ")).append(sqlException.getMessage()).toString());
                }
/*2687*/        cp.returnConnection();
/*2689*/        try {
/*2689*/            resultSet.close();
                }
/*2690*/        catch (SQLException e) {
/*2691*/            __logger.error((new StringBuilder("[AuthzDB][mapUsersToRole] : ")).append(e.getMessage()).toString());
                }
/*2694*/        try {
/*2694*/            preparedStatement.close();
                }
/*2695*/        catch (SQLException e) {
/*2696*/            __logger.error((new StringBuilder("[AuthzDB][mapUsersToRole] : ")).append(e.getMessage()).toString());
                }
/*2687*/        cp.returnConnection();
/*2689*/        try {
/*2689*/            resultSet.close();
                }
/*2690*/        catch (SQLException e) {
/*2691*/            __logger.error((new StringBuilder("[AuthzDB][mapUsersToRole] : ")).append(e.getMessage()).toString());
                }
/*2694*/        try {
/*2694*/            preparedStatement.close();
                }
/*2695*/        catch (SQLException e) {
/*2696*/            __logger.error((new StringBuilder("[AuthzDB][mapUsersToRole] : ")).append(e.getMessage()).toString());
                }
/*2699*/        return;
            }

            public void unmapUserFromRole(String user, String role) throws LimitCrossed, InternalError {
                Connection connection;
                PreparedStatement preparedStatement;
                ResultSet resultSet;
                String deleteQuery;
                int user_id;
/*2714*/        connection = cp.getConnection();
/*2715*/        preparedStatement = null;
/*2716*/        resultSet = null;
/*2718*/        deleteQuery = "delete from data.authz_user_op_map where role_id = ? and user_id = ?";
/*2722*/        try {
/*2722*/            user_id = getUserId(user);
                }
/*2723*/        catch (SQLException e) {
/*2724*/            throw new InternalError((new StringBuilder("[AuthzDB][unmapUserForRole] : Error in fetching user id, ")).append(e).toString());
                }
/*2729*/        try {
/*2729*/            preparedStatement = connection.prepareStatement(deleteQuery);
/*2730*/            preparedStatement.setString(1, role);
/*2731*/            preparedStatement.setInt(2, user_id);
/*2732*/            preparedStatement.execute();
                }
/*2733*/        catch (SQLException e) {
/*2734*/            __logger.error((new StringBuilder("[AuthzDB][unmapUserForRole] : ")).append(e.getMessage()).toString());
                }
/*2738*/        try {
/*2738*/            resultSet.close();
                }
/*2739*/        catch (SQLException e) {
/*2740*/            __logger.error((new StringBuilder("[AuthzDB][unmapUserFromRole] : ")).append(e.getMessage()).toString());
                }
/*2744*/        try {
/*2744*/            preparedStatement.close();
                }
/*2745*/        catch (SQLException e) {
/*2746*/            __logger.error((new StringBuilder("[AuthzDB][unmapUserFromRole] : ")).append(e.getMessage()).toString());
                }
/*2738*/        try {
/*2738*/            resultSet.close();
                }
/*2739*/        catch (SQLException e) {
/*2740*/            __logger.error((new StringBuilder("[AuthzDB][unmapUserFromRole] : ")).append(e.getMessage()).toString());
                }
/*2744*/        try {
/*2744*/            preparedStatement.close();
                }
/*2745*/        catch (SQLException e) {
/*2746*/            __logger.error((new StringBuilder("[AuthzDB][unmapUserFromRole] : ")).append(e.getMessage()).toString());
                }
/*2750*/        cp.returnConnection();
/*2751*/        return;
            }

            public void unmapUsersFromRole(String role, Vector users) throws LimitCrossed, InternalError {
/*2766*/        Connection connection = cp.getConnection();
/*2767*/        PreparedStatement preparedStatement = null;
/*2769*/        String deleteQuery = "delete from data.authz_user_op_map where role_id = ? and user_id = ?";
                int role_id;
/*2773*/        try {
/*2773*/            role_id = getRoleId(role);
                }
/*2774*/        catch (SQLException e) {
/*2775*/            throw new InternalError((new StringBuilder("[AuthzDB][unmapUserForRole] : Error in fetching role id, ")).append(e).toString());
                }
/*2780*/        for (Iterator iterator = users.iterator(); iterator.hasNext();) {
/*2780*/            String user = (String)iterator.next();
                    int user_id;
/*2784*/            try {
/*2784*/                user_id = getUserId(user);
                    }
/*2785*/            catch (SQLException e) {
/*2786*/                throw new InternalError((new StringBuilder("[AuthzDB][unmapUserForRole] : Error in fetching user id, ")).append(e).toString());
                    }
/*2791*/            try {
/*2791*/                preparedStatement = connection.prepareStatement(deleteQuery);
/*2792*/                preparedStatement.setInt(1, role_id);
/*2793*/                preparedStatement.setInt(2, user_id);
/*2794*/                preparedStatement.execute();
                    }
/*2795*/            catch (SQLException e) {
/*2796*/                __logger.error((new StringBuilder("[AuthzDB][unmapUserForRole] : ")).append(e.getMessage()).toString());
                    }
                }

/*2803*/        try {
/*2803*/            preparedStatement.close();
                }
/*2804*/        catch (SQLException e) {
/*2805*/            __logger.error((new StringBuilder("[AuthzDB][unmapUsersFromRole] : ")).append(e.getMessage()).toString());
                }
/*2807*/        cp.returnConnection();
            }

            private int getRoleId(String role) throws LimitCrossed, InternalError, SQLException {
                Connection connection;
                PreparedStatement preparedStatement;
                ResultSet resultSet;
                int role_id;
                String query;
/*2819*/        connection = cp.getConnection();
/*2820*/        preparedStatement = null;
/*2821*/        resultSet = null;
/*2823*/        role_id = 0;
/*2824*/        query = "select id from data.authz_roles_mst where name = ?";
/*2827*/        try {
/*2827*/            preparedStatement = connection.prepareStatement(query);
/*2828*/            preparedStatement.setString(1, role);
/*2829*/            resultSet = preparedStatement.executeQuery();
/*2830*/            if (resultSet.next()) {
/*2831*/                role_id = resultSet.getInt("id");
                    }
                }
/*2834*/        catch (SQLException e) {
/*2835*/            __logger.error((new StringBuilder("[AuthzDB][getRoleId] : ")).append(e.getMessage()).toString());
/*2836*/            throw e;
                }
/*2838*/        cp.returnConnection();
/*2840*/        try {
/*2840*/            resultSet.close();
                }
/*2841*/        catch (SQLException e) {
/*2842*/            __logger.error((new StringBuilder("[AuthzDB][getRoleId] : ")).append(e.getMessage()).toString());
                }
/*2845*/        try {
/*2845*/            preparedStatement.close();
                }
/*2846*/        catch (SQLException e) {
/*2847*/            __logger.error((new StringBuilder("[AuthzDB][getRoleId] : ")).append(e.getMessage()).toString());
                }
/*2838*/        cp.returnConnection();
/*2840*/        try {
/*2840*/            resultSet.close();
                }
/*2841*/        catch (SQLException e) {
/*2842*/            __logger.error((new StringBuilder("[AuthzDB][getRoleId] : ")).append(e.getMessage()).toString());
                }
/*2845*/        try {
/*2845*/            preparedStatement.close();
                }
/*2846*/        catch (SQLException e) {
/*2847*/            __logger.error((new StringBuilder("[AuthzDB][getRoleId] : ")).append(e.getMessage()).toString());
                }
/*2850*/        return role_id;
            }

            private int getUserId(String name) throws SQLException, LimitCrossed, InternalError {
                Connection connection;
                PreparedStatement preparedStatement;
                ResultSet resultSet;
                int user_id;
                String query;
/*2861*/        connection = cp.getConnection();
/*2862*/        preparedStatement = null;
/*2863*/        resultSet = null;
/*2865*/        user_id = 0;
/*2866*/        query = "select id from data.authz_users_mst where nickname = ?";
/*2869*/        try {
/*2869*/            preparedStatement = connection.prepareStatement(query);
/*2870*/            preparedStatement.setString(1, name);
/*2871*/            resultSet = preparedStatement.executeQuery();
/*2872*/            if (resultSet.next()) {
/*2873*/                user_id = resultSet.getInt("id");
                    }
                }
/*2876*/        catch (SQLException e) {
/*2877*/            __logger.error((new StringBuilder("[AuthzDB][getUserId] : ")).append(e.getMessage()).toString());
/*2878*/            throw e;
                }
/*2879*/      
/*2880*/        cp.returnConnection();
/*2882*/        try {
/*2882*/            resultSet.close();
                }
/*2883*/        catch (SQLException e) {
/*2884*/            __logger.error((new StringBuilder("[AuthzDB][getUserId] : ")).append(e.getMessage()).toString());
                }
/*2887*/        try {
/*2887*/            preparedStatement.close();
                }
/*2888*/        catch (SQLException e) {
/*2889*/            __logger.error((new StringBuilder("[AuthzDB][getUserId] : ")).append(e.getMessage()).toString());
                }
/*2880*/        cp.returnConnection();
/*2882*/        try {
/*2882*/            resultSet.close();
                }
/*2883*/        catch (SQLException e) {
/*2884*/            __logger.error((new StringBuilder("[AuthzDB][getUserId] : ")).append(e.getMessage()).toString());
                }
/*2887*/        try {
/*2887*/            preparedStatement.close();
                }
/*2888*/        catch (SQLException e) {
/*2889*/            __logger.error((new StringBuilder("[AuthzDB][getUserId] : ")).append(e.getMessage()).toString());
                }
/*2892*/        return user_id;
            }

            private int getOpId(String name) throws SQLException, LimitCrossed, InternalError, NoEntity {
                Connection connection;
                PreparedStatement preparedStatement;
                ResultSet resultSet;
                int op_id;
                String query;
/*2903*/        connection = cp.getConnection();
/*2904*/        preparedStatement = null;
/*2905*/        resultSet = null;
/*2907*/        op_id = 0;
/*2909*/        query = "select id from data.authz_ops_mst where name = ?";
/*2912*/        try {
/*2912*/            preparedStatement = connection.prepareStatement(query);
/*2913*/            preparedStatement.setString(1, name);
/*2914*/            resultSet = preparedStatement.executeQuery();
/*2915*/            if (resultSet.next()) {
/*2916*/                op_id = resultSet.getInt("id");
                    }
                }
/*2919*/        catch (SQLException e) {
/*2920*/            __logger.error((new StringBuilder("[AuthzDB][getOpId] : ")).append(e.getMessage()).toString());
/*2921*/            throw e;
                }
/*2923*/        cp.returnConnection();
/*2925*/        try {
/*2925*/            resultSet.close();
                }
/*2926*/        catch (SQLException e) {
/*2927*/            __logger.error((new StringBuilder("[AuthzDB][getOpId] : ")).append(e.getMessage()).toString());
                }
/*2930*/        try {
/*2930*/            preparedStatement.close();
                }
/*2931*/        catch (SQLException e) {
/*2932*/            __logger.error((new StringBuilder("[AuthzDB][getOpId] : ")).append(e.getMessage()).toString());
                }
/*2923*/        cp.returnConnection();
/*2925*/        try {
/*2925*/            resultSet.close();
                }
/*2926*/        catch (SQLException e) {
/*2927*/            __logger.error((new StringBuilder("[AuthzDB][getOpId] : ")).append(e.getMessage()).toString());
                }
/*2930*/        try {
/*2930*/            preparedStatement.close();
                }
/*2931*/        catch (SQLException e) {
/*2932*/            __logger.error((new StringBuilder("[AuthzDB][getOpId] : ")).append(e.getMessage()).toString());
                }
/*2935*/        return op_id;
            }

            public void addUser(String user) throws LimitCrossed, InternalError {
/*2951*/        Connection connection = cp.getConnection();
/*2953*/        Hashtable mandatoryCol = null;
/*2955*/        try {
/*2955*/            mandatoryCol = (Hashtable)__config.getValue("authz.db.tables.users_mst.mandatory_columns");
                }
/*2957*/        catch (NoEntity e) {
/*2958*/            __logger.error((new StringBuilder("[AuthzDB][addUser] : ")).append(e.getMessage()).toString());
                }
/*2961*/        StringBuffer sb1 = new StringBuffer();
/*2962*/        sb1.append("insert into authz_users_mst (nickname");
/*2964*/        StringBuffer sb2 = new StringBuffer();
/*2965*/        sb2.append(" values (?");
/*2967*/        if (mandatoryCol != null) {
/*2968*/            if (mandatoryCol.containsKey("password")) {
/*2969*/                sb1.append(", password");
/*2970*/                sb2.append(", ?");
                    }
/*2973*/            if (mandatoryCol.containsKey("first_name")) {
/*2974*/                sb1.append(", first_name");
/*2975*/                sb2.append(", ?");
                    }
                }
/*2978*/        sb1.append(")");
/*2979*/        sb2.append(")");
/*2981*/        sb1.append(sb2);
/*2983*/        PreparedStatement preparedStatement = null;
/*2985*/        try {
/*2985*/            preparedStatement = connection.prepareStatement(sb1.toString());
/*2986*/            int counter = 1;
/*2987*/            preparedStatement.setString(counter, user);
/*2989*/            if (mandatoryCol != null) {
/*2990*/                if (mandatoryCol.containsKey("password")) {
/*2991*/                    counter++;
/*2992*/                    String password = (String)(String)mandatoryCol.get("password");
/*2993*/                    if (password.equals("#RANDOM#")) {
/*2995*/                        try {
/*2995*/                            password = RandomGenerator.getRandomString(32, 32);
                                }
/*2996*/                        catch (InvalidData e) {
/*2997*/                            __logger.error((new StringBuilder("[AuthzDB][addUser] : ")).append(e.getMessage()).toString());
                                }
                            }
/*3001*/                    preparedStatement.setString(counter, password);
                        }
/*3004*/                if (mandatoryCol.containsKey("first_name")) {
/*3005*/                    counter++;
/*3006*/                    preparedStatement.setString(counter, (String)(String)mandatoryCol.get("first_name"));
                        }
                    }
/*3011*/            int rowInserted = preparedStatement.executeUpdate();
/*3012*/            if (rowInserted != 0) {
/*3013*/                __logger.debug((new StringBuilder("[AuthzDB][addUser] : ")).append(user).append(" user is added in database table authz_users_mst.").toString());
                    } else {
/*3016*/                __logger.debug((new StringBuilder("[AuthzDB][addUser] : ")).append(user).append(" user is not added in database table authz_users_mst.").toString());
                    }
/*3021*/            preparedStatement.close();
                }
/*3022*/        catch (SQLException sqlException) {
/*3023*/            __logger.error((new StringBuilder("[AuthzDB][addUser] : ")).append(sqlException.getMessage()).toString());
                }
/*3025*/        cp.returnConnection();
            }

            public void removeUser(String user) throws NoEntity, LimitCrossed, InternalError {
/*3043*/        Connection connection = cp.getConnection();
/*3044*/        PreparedStatement preparedStatement = null;
/*3045*/        ResultSet resultSet = null;
/*3047*/        int user_id = 0;
/*3049*/        try {
/*3049*/            String selectQuery = "select id from authz_users_mst where nickname = ?";
/*3050*/            preparedStatement = connection.prepareStatement(selectQuery);
/*3051*/            preparedStatement.setString(1, user);
/*3052*/            resultSet = preparedStatement.executeQuery();
/*3054*/            if (resultSet.next()) {
/*3055*/                user_id = resultSet.getInt(1);
/*3056*/                preparedStatement.close();
                    } else {
/*3058*/                resultSet.close();
/*3059*/                preparedStatement.close();
/*3060*/                cp.returnConnection();
/*3061*/                throw new NoEntity((new StringBuilder("Invalid user name ")).append(user).toString());
                    }
                }
/*3063*/        catch (SQLException sqlException) {
/*3064*/            __logger.error((new StringBuilder("[AuthzDB][removeUser] : ")).append(sqlException.getMessage()).toString());
                }
/*3069*/        try {
/*3069*/            String deleteQuery = "delete from data.authz_user_op_map where user_id = ?";
/*3070*/            preparedStatement = connection.prepareStatement(deleteQuery);
/*3071*/            preparedStatement.setInt(1, user_id);
/*3073*/            int rowDeleted = preparedStatement.executeUpdate();
/*3074*/            if (rowDeleted != 0) {
/*3075*/                __logger.debug((new StringBuilder("[AuthzDB][removeUser] : ")).append(user).append(" user is unmapped with operations in database table authz_user_op_map. ").append(rowDeleted).append(" rows are deleted from table authz_user_op_map.").toString());
/*3081*/                resultSet.close();
/*3082*/                preparedStatement.close();
                    } else {
/*3084*/                resultSet.close();
/*3085*/                preparedStatement.close();
/*3086*/                __logger.debug((new StringBuilder("[AuthzDB][removeUser] : ")).append(user).append(" user is not unmapped with operations in database table authz_user_op_map. ").append(rowDeleted).append(" rows are deleted from table authz_user_op_map.").toString());
                    }
                }
/*3093*/        catch (SQLException sqlException) {
/*3094*/            __logger.error((new StringBuilder("[AuthzDB][removeUser] : ")).append(sqlException.getMessage()).toString());
                }
/*3099*/        try {
/*3099*/            String deleteQuery = "delete from data.authz_users_mst where nickname = ?";
/*3100*/            preparedStatement = connection.prepareStatement(deleteQuery);
/*3101*/            preparedStatement.setString(1, user);
/*3102*/            int rowDeleted = preparedStatement.executeUpdate();
/*3104*/            if (rowDeleted != 0) {
/*3105*/                __logger.debug((new StringBuilder("[AuthzDB][removeUser] : ")).append(user).append(" user is removed from database table authz_users_mst.").toString());
/*3109*/                preparedStatement.close();
                    } else {
/*3111*/                preparedStatement.close();
/*3112*/                __logger.debug((new StringBuilder("[AuthzDB][removeUser] : ")).append(user).append(" user is not removed from database table authz_users_mst.").toString());
                    }
                }
/*3117*/        catch (SQLException sqlException) {
/*3118*/            __logger.error((new StringBuilder("[AuthzDB][removeUser] : ")).append(sqlException.getMessage()).toString());
                }
/*3121*/        cp.returnConnection();
            }
}
