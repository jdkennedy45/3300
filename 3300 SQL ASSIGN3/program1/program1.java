import java.sql.*;
import java.util.Locale;
import java.lang.String;

public class program1 {
	public static void main(String args[]){
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://" + args[0] + ":3306";
			Connection con = DriverManager.getConnection(url, args[2], args[3]);
			Statement stmt = con.createStatement();
			stmt.execute("DROP DATABASE IF EXISTS " + args[1]);
			stmt.execute("CREATE DATABASE " + args[1]);
			con.close();
		
			con = DriverManager.getConnection(url + "/" + args[1], args[2], args[3]);
			stmt = con.createStatement();
			stmt.execute("create table students(" +
			"tnumber char(8) PRIMARY KEY, " +
			"firstname varchar(20) not null, " +
			"lastname varchar(20) not null, " +
			"dateofbirth date, " +
			"index(lastname)) " +
			"ENGINE=INNODB");
	
			stmt.execute("INSERT INTO students(tnumber, firstname, " +
			"lastname, dateofbirth) " +
			"VALUES ('00001234', 'Joe', 'Smith', '1950-08-12')");

			System.out.println("---------------------------------------------------------------");
			System.out.println("TNUmber	    FirstName	    LastName	    DateOfBIrth  ");
			System.out.println("---------------------------------------------------------------");

			ResultSet rs = stmt.executeQuery("select * from students");
			while(rs.next()){
				String tnumber = rs.getString("students.tnumber");
				String firstname = rs.getString("students.firstname");
				String lastname = rs.getString("students.lastname");
				String dateofbirth = rs.getString("students.dateofbirth");
				System.out.format("%-15s%-15s%-15s%-15s%n", tnumber, firstname, lastname, dateofbirth);
			}
			System.out.println("\n");
			con.close();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
}
