package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;

@WebServlet("/pageupdateservlet")
public class PageUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public PageUpdateServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String name = request.getParameter("name");
		String date = request.getParameter("rdate");
		String username = (String)session.getAttribute("username");
		
		if ( (name == null|| name.trim().equals("")) && (date == null|| date.trim().equals(""))) {}
		else {
			try {				
				String connectionURL = "jdbc:mysql://localhost:3306/internet_and_applications";
				Connection connection = null;
				Class.forName("com.mysql.jdbc.Driver");
				connection = DriverManager.getConnection(connectionURL, "root","");
				String sql = "UPDATE users SET ";
				if( !(name == null|| name.trim().equals("")))  {
					sql += "name = \"" + name + "\"," ;
				}
				if( !(date == null|| date.trim().equals("")))  {
					String dates[] = date.split("/");
					date = "'" + dates[2] + '-' + dates[0] + '-' + dates[1] + "'";
					sql += "date = " + date.replaceAll("/", "-") + "," ;
				}
				sql = sql.substring(0, sql.length() - 1);
				sql = sql + " WHERE username = \"" + username + "\";";	
				PreparedStatement ps = connection.prepareStatement(sql);
				ps.executeUpdate();
				ps.close();
				connection.close();
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
		response.sendRedirect("/092020_Apathon_-_internet_and_applications/pageupdate");
	
	}

}
