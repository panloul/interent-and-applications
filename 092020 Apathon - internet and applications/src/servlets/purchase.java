package servlets;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/purchase")
public class purchase extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public purchase() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String username = (String)session.getAttribute("username");
        ArrayList<String> products = (ArrayList<String>)session.getAttribute("products");
		try 
		{
			
			String connectionURL = "jdbc:mysql://localhost:3306/internet_and_applications";
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection = DriverManager.getConnection(connectionURL, "root","");
			
			FileWriter filewrt = new FileWriter("purchases.txt",true);
			BufferedWriter fileout = new BufferedWriter(filewrt);
			
			String fileoutput = username + " ";
			
			
			
			boolean first = true;
			for(String pruduct_id: products) {
				String sql = "INSERT INTO purchases (username,product_id) VALUES (\"" + username + "\"," + pruduct_id + ");";
				PreparedStatement preparedStmt = connection.prepareStatement(sql);
		        preparedStmt.execute();
		        preparedStmt.close();
				if(!first) fileoutput += ",";
				else first = false;
				fileoutput += pruduct_id;
				
			}
			fileout.write(fileoutput);
			fileout.newLine();
			fileout.close();
			
			connection.close();
			products.clear();
			session.removeAttribute("discount");
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}

}
