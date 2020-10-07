package layout;

public class dbConnector {
	 private final String connectionString="jdbc:postgresql://localhost:5432/NewDatabase";
	 private final String dbname="postgres";
	 private final String dbpass="10d30f410d30f4";
	 private final String salt="KAJFI99020JF0209JC9020";
	 
	 public String getConnectionString() {
		 return connectionString;
	 }
	 public String getDbName() {
		 return dbname;
	 }
	 public String getDbPass() {
		 return dbpass;
	 }
	 public String getSalt() {
		 return salt;
	 }
	 
}
