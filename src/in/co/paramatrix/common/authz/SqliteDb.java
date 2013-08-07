// Decompiled by Jad v1.5.8e. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: packimports(5) braces fieldsfirst noctor nonlb space lnc 
// Source File Name:   SqliteDb.java

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

public class SqliteDb extends AuthzDB {

            private Config __config;
            private Logger __logger;
            private String version;

            public SqliteDb() {
/*  36*/        __config = null;
/*  39*/        __logger = null;
/*  42*/        version = "1";
            }

            public void init(Config config) throws InitFailed {
/*  60*/        super.init(config);
/*  61*/        __config = config;
/*  64*/        try {
/*  64*/            __logger = Logger.getInstance();
                }
/*  65*/        catch (NoInit e) {
/*  66*/            System.out.println(e.getMessage());
                }
/*  69*/        Hashtable db_specs = null;
/*  71*/        try {
/*  71*/            db_specs = (Hashtable)config.getValue("authz.rdb");
                }
/*  72*/        catch (NoEntity e1) {
/*  73*/            __logger.error(e1.getMessage());
                }
/*  77*/        try {
/*  77*/            cp = new ConnectionPool(db_specs);
                }
/*  78*/        catch (InternalError e) {
/*  79*/            throw new InitFailed(e.getMessage());
                }
/*  80*/        catch (InitFailed e) {
/*  81*/            throw e;
                }
/*  83*/        __logger.info((new StringBuilder("[SqliteDb][Constructor] : Cache initialized at ")).append((new Date()).toString()).toString());
            }

            public void checkCache() throws InvalidData, LimitReached, InternalError {
/* 100*/        super.checkCache();
/* 102*/        try {
/* 102*/            checkVersion();
                }
/* 103*/        catch (InvalidVersion e) {
/* 104*/            __logger.error((new StringBuilder("[SqliteDb][checkCache] : ")).append(e.getMessage()).toString());
/* 105*/            throw new InvalidData(e.getMessage());
                }
/* 106*/        catch (InternalError e) {
/* 107*/            __logger.error((new StringBuilder("[SqliteDb][checkCache] : ")).append(e.getMessage()).toString());
/* 108*/            throw e;
                }
/* 109*/        catch (LimitCrossed e) {
/* 110*/            __logger.error((new StringBuilder("[SqliteDb][checkCache] : ")).append(e.getMessage()).toString());
/* 111*/            throw new InvalidData(e.getMessage());
                }
/* 115*/        try {
/* 115*/            checkTables();
                }
/* 116*/        catch (InternalError e) {
/* 117*/            __logger.error((new StringBuilder("[SqliteDb][checkCache] : ")).append(e.getMessage()).toString());
/* 118*/            throw new InvalidData(e.getMessage());
                }
/* 119*/        catch (LimitCrossed e) {
/* 120*/            __logger.error((new StringBuilder("[SqliteDb][checkCache] : ")).append(e.getMessage()).toString());
/* 121*/            throw new InvalidData(e.getMessage());
                }
/* 125*/        try {
/* 125*/            super.populateTables();
                }
/* 126*/        catch (LimitCrossed e) {
/* 127*/            __logger.error((new StringBuilder("[SqliteDb][checkCache] : ")).append(e.getMessage()).toString());
/* 128*/            throw new InvalidData(e.getMessage());
                }
            }

            private void checkVersion() throws InvalidVersion, InternalError, LimitCrossed {
/* 146*/        PreparedStatement preparedStatement = null;
/* 147*/        Connection connection = cp.getConnection();
/* 149*/        try {
/* 149*/            String selectQuery = "select config_value from db_config where config_key = 'version_number'";
/* 151*/            preparedStatement = connection.prepareStatement(selectQuery);
/* 152*/            ResultSet resultSet = preparedStatement.executeQuery();
/* 154*/            String version_no = resultSet.getString(1);
/* 156*/            if (!version.equals(version_no)) {
/* 157*/                throw new InvalidVersion((new StringBuilder("InvalidVersion For Version : ")).append(version).toString());
                    }
/* 160*/            preparedStatement.close();
/* 161*/            resultSet.close();
                }
/* 162*/        catch (SQLException versionsqlException) {
/* 163*/            Vector lvAllTableSchema = buildDbSchema();
/* 164*/            __logger.debug("[SqliteDb][checkVersion] : Prepared the schema for the database.");
/* 166*/            Config conf = new Config(lvAllTableSchema);
/* 168*/            Hashtable lhAllTables = null;
/* 170*/            try {
/* 170*/                lhAllTables = (Hashtable)conf.getValue("authz.db.tables");
                    }
/* 171*/            catch (NoEntity NoEntity) {
/* 172*/                __logger.error((new StringBuilder("[SqliteDb][checkVersion] : ")).append(NoEntity.getMessage()).toString());
                    }
/* 177*/            try {
/* 177*/                createAllTables(lhAllTables);
                    }
/* 178*/            catch (InternalError e) {
/* 179*/                __logger.error((new StringBuilder("[SqliteDb][checkVersion] : ")).append(e.getMessage()).toString());
/* 180*/                throw e;
                    }
/* 182*/            __logger.debug("[SqliteDb][checkVersion] : All tables are created in database.");
/* 185*/            populateDbConfig();
/* 186*/            __logger.debug("[SqliteDb][checkVersion] : Inserted version in table db_version.");
/* 189*/            populateOpsMaster();
/* 190*/            __logger.debug("[SqliteDb][checkVersion] : Inserted Operation signatures in table ops_mst.");
                }
            }

            private void populateOpsMaster() throws LimitCrossed, InternalError {
/* 205*/        __logger.debug("[SqliteDb][populateOpsMaster] : Inserting Operations signatures in database table ops_mst");
/* 207*/        Connection connection = cp.getConnection();
/* 208*/        PreparedStatement preparedStatement = null;
/* 209*/        for (int i = 0; (long)i < numSigs; i++) {
/* 210*/            for (int j = 0; j < 64; j++) {
/* 211*/                long op_sig = 1L << j;
/* 212*/                String insertQuery = (new StringBuilder("insert into ops_mst (sig")).append(i + 1).append(") values (?)").toString();
/* 215*/                try {
/* 215*/                    preparedStatement = connection.prepareStatement(insertQuery);
/* 217*/                    preparedStatement.setLong(1, op_sig);
/* 218*/                    preparedStatement.executeUpdate();
/* 219*/                    preparedStatement.close();
                        }
/* 220*/                catch (SQLException e) {
/* 221*/                    __logger.error((new StringBuilder("[SqliteDb][populateOpsMaster] : ")).append(e.getMessage()).toString());
                        }
                    }

                }

/* 226*/        cp.returnConnection();
            }

            private void populateDbConfig() throws LimitCrossed, InternalError {
/* 238*/        __logger.debug("[SqliteDb][populateDbConfig] : Inserting Version no and numSigs in database table db_config.");
/* 240*/        PreparedStatement preparedStatement = null;
/* 241*/        Connection connection = cp.getConnection();
/* 243*/        try {
/* 243*/            String insertString = "insert into db_config values(?, ?)";
/* 244*/            preparedStatement = connection.prepareStatement(insertString);
/* 245*/            preparedStatement.setString(1, "version_number");
/* 246*/            preparedStatement.setString(2, version);
/* 247*/            preparedStatement.executeUpdate();
/* 248*/            preparedStatement.close();
                }
/* 249*/        catch (SQLException sqlException) {
/* 250*/            __logger.error((new StringBuilder("[SqliteDb][populateDbConfig] : ")).append(sqlException.getMessage()).toString());
                }
/* 255*/        try {
/* 255*/            String insertString = "insert into db_config values(?, ?)";
/* 256*/            preparedStatement = connection.prepareStatement(insertString);
/* 257*/            preparedStatement.setString(1, "num_sigs");
/* 258*/            preparedStatement.setString(2, String.valueOf(numSigs));
/* 259*/            preparedStatement.executeUpdate();
/* 260*/            preparedStatement.close();
                }
/* 261*/        catch (SQLException sqlException) {
/* 262*/            __logger.error((new StringBuilder("[SqliteDb][populateDbConfig] : ")).append(sqlException.getMessage()).toString());
                }
            }

            private Vector buildDbSchema() {
/* 273*/        Vector lvTableDetails = new Vector();
/* 276*/        lvTableDetails.addElement("authz.db.tables.db_config.config_key = text(128) DEFAULT Null");
/* 278*/        lvTableDetails.addElement("authz.db.tables.db_config.config_value = text(128), Unique(config_key)");
/* 282*/        lvTableDetails.addElement("authz.db.tables.users_mst.id = integer Not Null primary key, Unique(nickname)");
/* 284*/        lvTableDetails.addElement("authz.db.tables.users_mst.nickname = text(64) Not Null ");
/* 286*/        lvTableDetails.addElement("authz.db.tables.users_mst.active = text(1) Not Null DEFAULT('Y')");
/* 290*/        lvTableDetails.addElement("authz.db.tables.ops_mst.id = integer Not Null primary key, Unique(name)");
/* 292*/        lvTableDetails.addElement("authz.db.tables.ops_mst.name = text(128) DEFAULT Null ");
/* 294*/        for (int i = 0; (long)i < numSigs; i++) {
/* 295*/            lvTableDetails.addElement((new StringBuilder("authz.db.tables.ops_mst.sig")).append(i + 1).append(" = long int Not Null DEFAULT(0)").toString());
                }

/* 300*/        lvTableDetails.addElement("authz.db.tables.roles_mst.id = integer Not Null primary key, Unique(name)");
/* 302*/        lvTableDetails.addElement("authz.db.tables.roles_mst.name = text(64) Not Null ");
/* 306*/        lvTableDetails.addElement("authz.db.tables.user_op_map.user_id = integer Not Null");
/* 308*/        lvTableDetails.addElement("authz.db.tables.user_op_map.role_id = integer DEFAULT(0)");
/* 310*/        lvTableDetails.addElement("authz.db.tables.user_op_map.op_id = integer Not Null, constraint user_op_id_unique Unique (user_id, op_id, role_id)");
/* 314*/        lvTableDetails.addElement("authz.db.tables.role_op_map.role_id = integer Not Null");
/* 316*/        lvTableDetails.addElement("authz.db.tables.role_op_map.op_id = integer Not Null, constraint role_op_id_unique Unique (role_id, op_id)");
/* 319*/        return lvTableDetails;
            }

            private boolean tableExists(String tableName) throws LimitCrossed, InternalError {
/* 336*/        PreparedStatement preparedStatement = null;
/* 337*/        boolean tableExists = false;
/* 338*/        Connection connection = cp.getConnection();
/* 340*/        try {
/* 340*/            String selectQuery = (new StringBuilder("select * from ")).append(tableName).toString();
/* 341*/            preparedStatement = connection.prepareStatement(selectQuery);
/* 342*/            tableExists = preparedStatement.execute();
/* 343*/            preparedStatement.close();
                }
/* 344*/        catch (SQLException versionsqlException) {
/* 345*/            tableExists = false;
                }
/* 347*/        return tableExists;
            }

            private void checkTables() throws InternalError, LimitCrossed {
/* 359*/        String allTables = null;
/* 361*/        try {
/* 361*/            allTables = (String)__config.getValue("authz.db.schema.tablelist");
                }
/* 362*/        catch (NoEntity e) {
/* 363*/            __logger.error((new StringBuilder("[SqliteDb][checkTables] : ")).append(e.getMessage()).toString());
/* 364*/            throw new InternalError(e.getMessage());
                }
/* 367*/        if (allTables != null) {
/* 368*/            for (StringTokenizer st = new StringTokenizer(allTables, ","); st.hasMoreTokens();) {
/* 370*/                String singleTableName = st.nextToken().trim();
/* 371*/                if (!tableExists(singleTableName)) {
/* 372*/                    throw new InternalError((new StringBuilder(String.valueOf(singleTableName))).append(" table is not present in the database.").toString());
                        }
                    }

                }
            }

            private void createAllTables(Hashtable lhAllTables) throws InternalError, LimitCrossed {
/* 391*/        PreparedStatement preparedStatement = null;
/* 392*/        Connection connection = cp.getConnection();
/* 394*/        for (Enumeration tableNames = lhAllTables.keys(); tableNames.hasMoreElements();) {
/* 396*/            String singleTable = (String)(String)tableNames.nextElement();
/* 398*/            StringBuffer sb = new StringBuffer();
/* 399*/            sb.append("create table ");
/* 400*/            sb.append(singleTable);
/* 401*/            sb.append("(");
/* 403*/            Hashtable subhashtable = (Hashtable)(Hashtable)lhAllTables.get(singleTable);
/* 404*/            for (Enumeration columnNames = subhashtable.keys(); columnNames.hasMoreElements(); sb.append(",")) {
/* 406*/                String column = (String)(String)columnNames.nextElement();
/* 407*/                String datatype = (String)(String)subhashtable.get(column);
/* 408*/                sb.append(column);
/* 409*/                sb.append(" ");
/* 410*/                sb.append(datatype);
                    }

/* 414*/            sb.deleteCharAt(sb.length() - 1);
/* 415*/            sb.append(")");
/* 416*/            sb.append(";");
/* 419*/            try {
/* 419*/                preparedStatement = connection.prepareStatement(sb.toString());
/* 420*/                preparedStatement.executeUpdate();
/* 422*/                sb = null;
/* 423*/                preparedStatement.close();
                    }
/* 424*/            catch (SQLException sqlException) {
/* 425*/                __logger.error((new StringBuilder("[SqliteDb][createAllTables] : ")).append(sqlException.getMessage()).toString());
/* 427*/                throw new InternalError(sqlException.getMessage());
                    }
                }

            }
}
