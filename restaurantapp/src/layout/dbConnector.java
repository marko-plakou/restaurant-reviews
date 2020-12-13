package layout;

public class dbConnector {
	 private final String connectionString="jdbc:postgresql://localhost:5432/?";
	 private final String dbname="?";
	 private final String dbpass="?";
	 private final String salt="?";
	 
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
