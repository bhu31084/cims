// Decompiled by Jad v1.5.8e. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: packimports(5) braces fieldsfirst noctor nonlb space lnc 
// Source File Name:   MsSQLDb.java

package in.co.paramatrix.common.authz;

import in.co.paramatrix.common.Config;
import in.co.paramatrix.common.ConnectionPool;
import in.co.paramatrix.common.Logger;
import in.co.paramatrix.common.exceptions.*;
import in.co.paramatrix.common.exceptions.InternalError;

import java.io.PrintStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

// Referenced classes of package in.co.paramatrix.common.authz:
//            AuthzDB

public class MsSQLDb extends AuthzDB {

            private Config __config;
            private Logger __logger;
            private String version;

            public MsSQLDb() {
/*  34*/        __config = null;
/*  37*/        __logger = null;
/*  40*/        version = "1";
            }

            public void init(Config config) throws InitFailed {
/*  61*/        super.init(config);
/*  62*/        __config = config;
/*  65*/        try {
/*  65*/            __logger = Logger.getInstance();
                }
/*  66*/        catch (NoInit e) {
/*  67*/            System.out.println(e.getMessage());
                }
/*  70*/        Hashtable db_specs = null;
/*  72*/        try {
/*  72*/            db_specs = (Hashtable)config.getValue("authz.rdb");
                }
/*  73*/        catch (NoEntity e1) {
/*  74*/            __logger.error(e1.getMessage());
                }
/*  78*/        try {
/*  78*/            cp = new ConnectionPool(db_specs);
                }
/*  79*/        catch (InternalError e) {
/*  80*/            throw new InitFailed(e.getMessage());
                }
/*  81*/        catch (InitFailed e) {
/*  82*/            throw e;
                }
/*  84*/        __logger.info((new StringBuilder("[MsDb][Constructor] : Cache initialized at ")).append((new Date()).toString()).toString());
            }

            public void checkCache() throws InvalidData, LimitReached, InternalError {
/* 101*/        super.checkCache();
/* 104*/        try {
/* 104*/            checkVersion();
                }
/* 105*/        catch (InvalidVersion e) {
/* 106*/            __logger.error((new StringBuilder("[MsDb][checkCache] : ")).append(e.getMessage()).toString());
/* 107*/            throw new InvalidData(e.getMessage());
                }
/* 108*/        catch (InternalError e) {
/* 109*/            __logger.error((new StringBuilder("[MsDb][checkCache] : ")).append(e.getMessage()).toString());
/* 110*/            throw e;
                }
/* 111*/        catch (LimitCrossed e) {
/* 112*/            __logger.error((new StringBuilder("[MsDb][checkCache] : ")).append(e.getMessage()).toString());
/* 113*/            throw new InvalidData(e.getMessage());
                }
/* 117*/        try {
/* 117*/            checkTables();
                }
/* 118*/        catch (InternalError e) {
/* 119*/            __logger.error((new StringBuilder("[MsDb][checkCache] : ")).append(e.getMessage()).toString());
/* 120*/            throw new InvalidData(e.getMessage());
                }
/* 121*/        catch (LimitCrossed e) {
/* 122*/            __logger.error((new StringBuilder("[MsDb][checkCache] : ")).append(e.getMessage()).toString());
/* 123*/            throw new InvalidData(e.getMessage());
                }
/* 127*/        try {
/* 127*/            super.populateTables();
                }
/* 128*/        catch (LimitCrossed e) {
/* 129*/            __logger.error((new StringBuilder("[MsDb][checkCache] : ")).append(e.getMessage()).toString());
/* 130*/            throw new InvalidData(e.getMessage());
                }
            }

            private void checkVersion() throws InvalidVersion, InternalError, LimitCrossed {
/* 148*/        PreparedStatement preparedStatement = null;
/* 149*/        ResultSet resultSet = null;
/* 150*/        Connection connection = cp.getConnection();
/* 152*/        try {
/* 152*/            String selectQuery = "select config_value from authz_db_config where config_key = 'version_number'";
/* 154*/            preparedStatement = connection.prepareStatement(selectQuery);
/* 155*/            resultSet = preparedStatement.executeQuery();
/* 157*/            resultSet.next();
/* 158*/            String version_no = resultSet.getString(1);
/* 159*/            if (!version.equals(version_no)) {
/* 160*/                throw new InvalidVersion((new StringBuilder("InvalidVersion For Version : ")).append(version).toString());
                    }
                }
/* 163*/        catch (SQLException versionsqlException) {
/* 164*/            __logger.error(versionsqlException.getMessage());
/* 166*/            Vector lvAllTableSchema = buildDbSchema();
/* 167*/            __logger.debug("[SqliteDb][checkVersion] : Prepared the schema for the database.");
/* 169*/            Config conf = new Config(lvAllTableSchema);
/* 171*/            Hashtable lhAllTables = null;
/* 173*/            try {
/* 173*/                lhAllTables = (Hashtable)conf.getValue("authz.db.tables");
                    }
/* 174*/            catch (NoEntity NoEntity) {
/* 175*/                __logger.error((new StringBuilder("[SqliteDb][checkVersion] : ")).append(NoEntity.getMessage()).toString());
                    }
/* 180*/            try {
/* 180*/                createAllTables(lhAllTables);
                    }
/* 181*/            catch (InternalError e) {
/* 182*/                __logger.error((new StringBuilder("[SqliteDb][checkVersion] : ")).append(e.getMessage()).toString());
/* 183*/                throw e;
                    }
/* 185*/            __logger.debug("[SqliteDb][checkVersion] : All tables are created in database.");
/* 188*/            populateDbConfig();
/* 189*/            __logger.debug("[SqliteDb][checkVersion] : Inserted version in table db_version.");
/* 192*/            populateOpsMaster();
/* 193*/            __logger.debug("[SqliteDb][checkVersion] : Inserted Operation signatures in table ops_mst.");
                }
/* 198*/        try {
/* 198*/            String selectQuery = "select config_value from authz_db_config where config_key = 'num_sigs'";
/* 200*/            preparedStatement = connection.prepareStatement(selectQuery);
/* 201*/            resultSet = preparedStatement.executeQuery();
/* 203*/            resultSet.next();
/* 204*/            String num_sigs = resultSet.getString(1);
/* 205*/            if (!num_sigs.equals(String.valueOf(numSigs))) {
/* 206*/                __logger.debug("[MsDb][checkVersion] : Inserted Operation signatures in table ops_mst.");
/* 208*/                populateOpsMaster();
                    }
/* 211*/            preparedStatement.close();
/* 212*/            resultSet.close();
                }
/* 213*/        catch (SQLException versionsqlException) {
/* 214*/            __logger.error(versionsqlException.getMessage());
                }
/* 216*/        cp.returnConnection();
            }

            private void populateDbConfig() throws LimitCrossed, InternalError {
/* 228*/        __logger.debug("[SqliteDb][populateDbConfig] : Inserting Version no and numSigs in database table db_config.");
/* 230*/        PreparedStatement preparedStatement = null;
/* 231*/        Connection connection = cp.getConnection();
/* 233*/        try {
/* 233*/            String insertString = "insert into authz_db_config values(?, ?)";
/* 234*/            preparedStatement = connection.prepareStatement(insertString);
/* 235*/            preparedStatement.setString(1, "version_number");
/* 236*/            preparedStatement.setString(2, version);
/* 237*/            preparedStatement.executeUpdate();
/* 238*/            preparedStatement.close();
                }
/* 239*/        catch (SQLException sqlException) {
/* 240*/            __logger.error((new StringBuilder("[SqliteDb][populateDbConfig] : ")).append(sqlException.getMessage()).toString());
                }
/* 245*/        try {
/* 245*/            String insertString = "insert into authz_db_config values(?, ?)";
/* 246*/            preparedStatement = connection.prepareStatement(insertString);
/* 247*/            preparedStatement.setString(1, "num_sigs");
/* 248*/            preparedStatement.setString(2, String.valueOf(numSigs));
/* 249*/            preparedStatement.executeUpdate();
/* 250*/            preparedStatement.close();
                }
/* 251*/        catch (SQLException sqlException) {
/* 252*/            __logger.error((new StringBuilder("[SqliteDb][populateDbConfig] : ")).append(sqlException.getMessage()).toString());
                }
            }

            private Vector buildDbSchema() {
/* 263*/        Vector lvTableDetails = new Vector();
/* 266*/        lvTableDetails.addElement("authz.db.tables.authz_db_config.config_key = varchar(128) DEFAULT Null");
/* 268*/        lvTableDetails.addElement("authz.db.tables.authz_db_config.config_value = varchar(128), Unique(config_key)");
/* 272*/        lvTableDetails.addElement("authz.db.tables.authz_users_mst.id = integer identity(1,1) Not Null primary key, Unique(nickname)");
/* 274*/        lvTableDetails.addElement("authz.db.tables.authz_users_mst.nickname = varchar(64) Not Null ");
/* 276*/        lvTableDetails.addElement("authz.db.tables.authz_users_mst.active = varchar(1) Not Null DEFAULT('Y')");
/* 280*/        lvTableDetails.addElement("authz.db.tables.authz_ops_mst.id = integer identity(1,1) Not Null primary key");
/* 282*/        lvTableDetails.addElement("authz.db.tables.authz_ops_mst.name = varchar(128) DEFAULT Null ");
/* 284*/        for (int i = 0; (long)i < numSigs; i++) {
/* 285*/            lvTableDetails.addElement((new StringBuilder("authz.db.tables.authz_ops_mst.sig")).append(i + 1).append(" = bigint Not Null DEFAULT(0)").toString());
                }

/* 290*/        lvTableDetails.addElement("authz.db.tables.authz_roles_mst.id = integer identity(1,1) Not Null primary key, Unique(name)");
/* 292*/        lvTableDetails.addElement("authz.db.tables.authz_roles_mst.name = varchar(64) Not Null ");
/* 296*/        lvTableDetails.addElement("authz.db.tables.authz_user_op_map.user_id = integer Not Null");
/* 298*/        lvTableDetails.addElement("authz.db.tables.authz_user_op_map.role_id = integer DEFAULT(0)");
/* 300*/        lvTableDetails.addElement("authz.db.tables.authz_user_op_map.op_id = integer Not Null, constraint user_op_id_unique Unique (user_id, op_id, role_id)");
/* 304*/        lvTableDetails.addElement("authz.db.tables.authz_role_op_map.role_id = integer Not Null");
/* 306*/        lvTableDetails.addElement("authz.db.tables.authz_role_op_map.op_id = integer Not Null, constraint role_op_id_unique Unique (role_id, op_id)");
/* 309*/        return lvTableDetails;
            }

            private void populateOpsMaster() throws InternalError, LimitCrossed {
/* 322*/        __logger.debug("[MsDb][populateOpsMaster] : Inserting Operations signatures in database table authz_ops_mst");
/* 324*/        PreparedStatement preparedStatement = null;
/* 326*/        Connection connection = cp.getConnection();
/* 327*/        for (int i = 0; (long)i < numSigs; i++) {
/* 328*/            for (int j = 0; j < 64; j++) {
/* 329*/                long op_sig = 1L << j;
/* 330*/                String insertQuery = (new StringBuilder("insert into authz_ops_mst (sig")).append(i + 1).append(") values (?)").toString();
/* 333*/                try {
/* 333*/                    preparedStatement = connection.prepareStatement(insertQuery);
/* 335*/                    preparedStatement.setLong(1, op_sig);
/* 336*/                    preparedStatement.executeUpdate();
/* 337*/                    preparedStatement.close();
                        }
/* 338*/                catch (SQLException e) {
/* 339*/                    __logger.error((new StringBuilder("[MsDb][populateOpsMaster] : ")).append(e.getMessage()).toString());
                        }
                    }

                }

/* 344*/        cp.returnConnection();
            }

            private void checkTables() throws InternalError, LimitCrossed {
/* 358*/        String allTables = null;
/* 360*/        try {
/* 360*/            allTables = (String)__config.getValue("authz.db.schema.tablelist");
                }
/* 361*/        catch (NoEntity e) {
/* 362*/            __logger.error((new StringBuilder("[MsDb][checkTables] : ")).append(e.getMessage()).toString());
/* 363*/            throw new InternalError(e.getMessage());
                }
/* 366*/        if (allTables != null) {
/* 367*/            for (StringTokenizer st = new StringTokenizer(allTables, ","); st.hasMoreTokens();) {
/* 369*/                String singleTableName = st.nextToken().trim();
/* 370*/                if (!tableExists(singleTableName)) {
/* 371*/                    throw new InternalError((new StringBuilder(String.valueOf(singleTableName))).append(" table is not present in the database.").toString());
                        }
                    }

                }
            }

            private boolean tableExists(String tableName) throws InternalError, LimitCrossed {
/* 392*/        PreparedStatement preparedStatement = null;
/* 393*/        boolean tableExists = false;
/* 395*/        Connection connection = cp.getConnection();
/* 397*/        try {
/* 397*/            String selectQuery = (new StringBuilder("select * from ")).append(tableName).toString();
/* 398*/            System.out.println(selectQuery);
/* 399*/            preparedStatement = connection.prepareStatement(selectQuery);
/* 400*/            tableExists = preparedStatement.execute();
/* 401*/            preparedStatement.close();
                }
/* 402*/        catch (SQLException versionsqlException) {
/* 403*/            tableExists = false;
                }
/* 405*/        cp.returnConnection();
/* 406*/        return tableExists;
            }

            private void createAllTables(Hashtable lhAllTables) throws InternalError, LimitCrossed {
/* 421*/        PreparedStatement preparedStatement = null;
/* 422*/        Connection connection = cp.getConnection();
/* 424*/        for (Enumeration tableNames = lhAllTables.keys(); tableNames.hasMoreElements();) {
/* 426*/            String singleTable = (String)(String)tableNames.nextElement();
/* 428*/            StringBuffer sb = new StringBuffer();
/* 429*/            sb.append("create table ");
/* 430*/            sb.append(singleTable);
/* 431*/            sb.append("(");
/* 433*/            Hashtable subhashtable = (Hashtable)(Hashtable)lhAllTables.get(singleTable);
/* 434*/            for (Enumeration columnNames = subhashtable.keys(); columnNames.hasMoreElements(); sb.append(",")) {
/* 436*/                String column = (String)(String)columnNames.nextElement();
/* 437*/                String datatype = (String)(String)subhashtable.get(column);
/* 438*/                sb.append(column);
/* 439*/                sb.append(" ");
/* 440*/                sb.append(datatype);
                    }

/* 444*/            sb.deleteCharAt(sb.length() - 1);
/* 445*/            sb.append(")");
/* 446*/            sb.append(";");
/* 448*/            System.out.println(sb.toString());
/* 451*/            try {
/* 451*/                preparedStatement = connection.prepareStatement(sb.toString());
/* 452*/                preparedStatement.executeUpdate();
/* 453*/                sb = null;
/* 454*/                preparedStatement.close();
                    }
/* 455*/            catch (SQLException sqlException) {
/* 456*/                __logger.error((new StringBuilder("[MsDb][createAllTables] : ")).append(sqlException.getMessage()).toString());
/* 458*/                throw new InternalError(sqlException.getMessage());
                    }
                }

            }
}
