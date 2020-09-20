import java.sql.*;
import java.io.*;  

//run with: java -cp .;mysql-connector-java-5.1.18-bin.jar Create_database
public class Create_database {
    // JDBC driver name and database URL
	static String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
    static String DB_URL = "jdbc:mysql://localhost/";
	static String DB_Name = "internet_and_applications";

    //  Database credentials
    static String USER = "root";
    static String PASS = "";
	
	public static void insertProduct(String name, String price){
		try{
			Connection conn = null;
			Class.forName("com.mysql.jdbc.Driver");

			conn = DriverManager.getConnection(DB_URL + DB_Name, USER, PASS);


			Statement stmt = conn.createStatement();	
			String sql = "INSERT INTO products (product_name, product_price) VALUES (\"" + name + "\","  + price + ")";
			System.out.println(sql);
			stmt.executeUpdate(sql);
			
		}
		catch(Exception e){	
			e.printStackTrace();
		}
	}
	
	public static void init_database(){
		try{
			Connection conn = null;
			Class.forName("com.mysql.jdbc.Driver");

			System.out.println("Connecting to mysql");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);

			System.out.println("Dropping database " + DB_Name);
			Statement stmt = conn.createStatement();	
			String sql = "DROP DATABASE IF EXISTS " + DB_Name;
			stmt.executeUpdate(sql);
			System.out.println("Database " + DB_Name + " dropped");

			System.out.println("Creating database " + DB_Name);
			stmt = conn.createStatement();	
			sql = "CREATE DATABASE " + DB_Name;
			stmt.executeUpdate(sql);
			System.out.println("Database " + DB_Name + " created");
			
			System.out.println("Connecting to Database");
			conn = DriverManager.getConnection(DB_URL + DB_Name, USER, PASS);

			System.out.println("Creating Table users");
			stmt = conn.createStatement();	
			sql = "CREATE TABLE users ("
						+ "user_id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,"
						+ "username VARCHAR(30) NOT NULL,"
						+ "password VARCHAR(50) NOT NULL,"
						+ "name VARCHAR(50) NOT NULL,"
						+ "date DATE NOT NULL"
					+ ")";
			stmt.executeUpdate(sql);
			System.out.println("Table users created");
			
			System.out.println("Creating Table products");
			stmt = conn.createStatement();	
			sql = "CREATE TABLE products ("
						+ "product_id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,"
						+ "product_name VARCHAR(100) NOT NULL,"
						+ "product_price DECIMAL(8, 2) NOT NULL"
					+ ")";
			stmt.executeUpdate(sql);
			System.out.println("Table products created");
			
			System.out.println("Creating Table purchases");
			stmt = conn.createStatement();	
			sql = "CREATE TABLE purchases ("
						+ "id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,"
						+ "product_id INT(6) UNSIGNED NOT NULL,"
						+ "username VARCHAR(30) NOT NULL"
					+ ")";
			stmt.executeUpdate(sql);
			System.out.println("Table purchases created");


		} catch(Exception e){	
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args){
		init_database();
		insertProduct("Laptop Lenovo Ideapad 15.6 (A6-9225/4GB/256GB SSD/AMD R4)" , "359.00");
		insertProduct("Laptop HP 14 Stream (A4-9120E/4GB/64GB/Radeon R3) 14-ds0005nv" , "279.00");
		insertProduct("Laptop HP 15.6 (AMD Ryzen 3-3200U/4GB/256GB SSD/Radeon Vega 3) 15S-EQ0001NV" , "428.99");
		insertProduct("Laptop HUAWEI MATEBOOK D 14 R5-3500U/8/512GB SSD/VEGA 8" , "604.00");
		insertProduct("Laptop HUAWEI MateBook 13 AMD Ryzen 5-3500U / 8GB / 512GB SSD / Radeon Vega 8 / Fullview Quad HD" , "725.00");
		insertProduct("Laptop Lenovo IdeaPad 3 15.6 (AMD Ryzen 3 3250U/8GB/256GB SSD/AMD Radeon Graphics) 15ADA05" , "458.87");
		insertProduct("Laptop HP 15.6 ( i5-1035G1/8GB/512GB SSD/Intel UHD) 15s-fq1005nv" , "598.99");
		insertProduct("Laptop ASUS X509JA-WB301T I3-1005G1/4GB/256 SSD/UHD" , "449.00");
		

	}
	
}