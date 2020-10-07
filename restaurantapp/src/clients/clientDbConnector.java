package clients;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

import admins.adminDbConnector;
import layout.dbConnector;
import reviews.Reviews;

public class clientDbConnector extends dbConnector{
	dbConnector connector=new dbConnector();
	 
	 public String connectionString() {
		 String con_str=connector.getConnectionString();
		 return con_str;
	 }
	 public String dbname() {
		 String db_name=connector.getDbName();
		 return db_name;
	 }
	
	 public String dbpass() {
		 String db_pass=connector.getDbPass();
		 return db_pass;
	 }
	 public String salt() {
		 String salt=connector.getSalt();
		 return salt;
	 }
	
	
    public boolean clients_login(Clients client) {
    	String query="";
		Connection c=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		try {
        c = DriverManager
                .getConnection(connectionString(),
                        dbname(), dbpass());
        
        System.out.println("Connected to database successfully!!");
		 query="Select * From clients where username=? and password=?;";
		 
					stmt = c.prepareStatement(query);
					stmt.setString(1,client.getUsername());
					stmt.setString(2, getHashMD5(client.getPassword(),salt()));
					
					rs = stmt.executeQuery();
					
					if(rs.next()) {
						
						
						return true;
					}else {return false;}
		}  catch (SQLException ex) {
            Logger.getLogger(clientDbConnector.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("www");
        } 
    finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (c != null) {
                    c.close();
                }
            }
            catch (SQLException ex) {
            	Logger.getLogger(clientDbConnector.class.getName()).log(Level.SEVERE, null, ex);
                System.out.println("error");
            } 
            
    } return false;}
    
  
  
    public static String getHashMD5(String unhashed, String salt) {
       
        final String toHash = salt + unhashed + salt;
        MessageDigest messageDigest = null;
        try {
            messageDigest = MessageDigest.getInstance("MD5");
        } catch (NoSuchAlgorithmException ex) {
            return "false";
        }
        messageDigest.update(toHash.getBytes(), 0, toHash.length());
        String hashed = new BigInteger(1, messageDigest.digest()).toString(16);
        if (hashed.length() < 32) {
            hashed = "0" + hashed;
        }
        return hashed.toUpperCase();
    }
    
    public boolean client_deletes_reviews(String restaurant_name,String username) {
    	String query="";
    	Connection con=null;
    	PreparedStatement stmt=null;
    	try {
    		con=DriverManager.getConnection(connectionString(), dbname(), dbpass());
    		query="delete from user_reviews where username=? and restaurant_name=?";
    		stmt=con.prepareStatement(query);
    		stmt.setString(1,username);
    		stmt.setString(2,restaurant_name);
    		stmt.executeUpdate();
    		return true;
    	}
    	catch (SQLException ex) {
    		 Logger.getLogger(clientDbConnector.class.getName()).log(Level.SEVERE, null, ex);
  		     return false;
    	}
    	finally {
    		try {
    			if (con!=null) con.close();
    		}
    		catch (SQLException ex) {
    			 Logger.getLogger(clientDbConnector.class.getName()).log(Level.SEVERE, null, ex);
    			 return false;
    		}
    	}
    }
    
    public boolean userIfExists(String username){
    	String query="";
		Connection c=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		
    	try {
            c = DriverManager
                    .getConnection(connectionString(),
                            dbname(), dbpass());
            
            System.out.println("Connected to database successfully for checking if user exists!!");
            query="select * from clients where username=?";
            System.out.println(query);
            
            stmt=c.prepareStatement(query);
			stmt.setString(1, username);
			
			rs=stmt.executeQuery();			
            
    					if(rs.next()) {
    					
    						
    						
    						return true;}else {return false;}
    					
    		}  catch (SQLException ex) {
    			Logger.getLogger(clientDbConnector.class.getName()).log(Level.SEVERE, null, ex);
                return false;
            } 
        finally {
                try {
                    if (c != null) {
                        c.close();
                    }
                }
                catch (SQLException ex) {
                	Logger.getLogger(clientDbConnector.class.getName()).log(Level.SEVERE, null, ex);
                    return false;
                } 
                
        } }
    
    
    
    	
    public boolean client_register(Clients new_client){
    	
    	String query="";
    	
		Connection c=null;
		PreparedStatement stmt=null;
		
		
    	try {
    	 if(userIfExists(new_client.getUsername())==false) {
            c = DriverManager
                    .getConnection(connectionString(),
                            dbname(), dbpass());
             System.out.println("Connected to database successfully for register!!");
             query="insert into clients values("+"'"+new_client.getUsername()+"'"+","+"'"+getHashMD5(new_client.getPassword(),salt())+"');";
             System.out.println("query"+query);				
    		 stmt=c.prepareStatement(query);
    		 stmt.executeUpdate();
    		 return true;
    		 }
    		  else {
    			  return false;
    			  }
    		}  
            catch (SQLException ex) {
            	Logger.getLogger(clientDbConnector.class.getName()).log(Level.SEVERE, null, ex);
                return false;
            } 
        finally {
                try {
                    if (c != null) {
                        c.close();
                    }
                }
                catch (SQLException ex) {
                	Logger.getLogger(clientDbConnector.class.getName()).log(Level.SEVERE, null, ex);
                    return false;
                } 
                
        } }
    
    
       public boolean client_makes_review(Reviews new_review) {
    	   String query="";
			Connection c=null;
			PreparedStatement stmt=null;
			ResultSet rs=null;
			try {
	        c = DriverManager
	                .getConnection(connectionString(),
	                        dbname(), dbpass());
	        
			 query="insert into user_reviews values("+"'"+new_review.getUser()+"'"+","+"'"+new_review.getRestaurant()+"',"+new_review.getStars()+","+"'"+new_review.getComment()+"');";
			 System.out.println(query);
			 stmt = c.prepareStatement(query);
			 stmt.executeUpdate();
			 return true;
						
						
			}  catch (SQLException ex) {
	            Logger.getLogger(clientDbConnector.class.getName()).log(Level.SEVERE, null, ex);
	            return false;
	        } 
	    finally {
	            try {
	                if (rs != null) {
	                    rs.close();
	                }
	                if (stmt != null) {
	                    stmt.close();
	                }
	                if (c != null) {
	                    c.close();
	                }
	            }
	            catch (SQLException ex) {
	            	Logger.getLogger(clientDbConnector.class.getName()).log(Level.SEVERE, null, ex);
	                return false;
	            } 
	            
	    }
	 }
  }
    
    
               
	  
