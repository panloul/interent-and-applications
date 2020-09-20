<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%
	String connectionURL = "jdbc:mysql://localhost:3306/internet_and_applications";
	Connection connection = null;
	Statement statement = null;	
	ResultSet rs = null;
%>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./css/newUser.css">
<title>newUser</title>
</head>

<body>
<h1 id="title"> Internet and applications Appathon 09-2020</h1>
<%
	if(request.getParameter("username") == null
	   || request.getParameter("password") == null
	   || request.getParameter("name") == null
	   || request.getParameter("rdate") == null
	   || request.getParameter("username").trim().equals("")
	   || request.getParameter("password").trim().equals("")
	   || request.getParameter("name").trim().equals("")
	   || request.getParameter("rdate").trim().equals(""))
	{
		%>
		<div id="register">
			<h3 class="register-h">Please Register</h3>
			<br /> 
			<form method="get" action="/092020_Apathon_-_internet_and_applications/newUser">
				<table>
					<tr>
						<td>User Name:</td>
						<td> <input type="text" name="username" size=12 /></td>
					</tr>
					<tr>
						<td>Password:</td>
						<td><input type="password" name="password" size=12 /></td>
					</tr>
					<tr>
						<td>Name:</td>
						<td><input type="text" name="name" size=15 /></td>
					</tr>
					<tr>
						<td>Birthday:</td>
						<td><input type="date" name="rdate" size=10/></td>
					</tr>
					<tr id="submit-tr">
						<td colspan=2><input type=submit id="submit-td"/></td>
					</tr>
				</table>			
			</form>
		</div>				
		<%
	}
	else
	{
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String name = request.getParameter("name");
		String date = request.getParameter("rdate");
		try 
			{
//     			System.out.println(application.getRealPath(""));
				Class.forName("com.mysql.jdbc.Driver");
				
				connection = DriverManager.getConnection(connectionURL, "root","");
				statement = connection.createStatement();
				String sqlSelect = "SELECT * FROM users WHERE username =\"" + username  + "\" ;";	
				rs = statement.executeQuery(sqlSelect);
			
				String redirectURL = "/092020_Apathon_-_internet_and_applications/myhomepage";
				if(rs == null || !rs.next()) {	
					statement = connection.createStatement();
					String sqlInsert = "INSERT INTO users (username,password,name,date) VALUES (\"" + username  + "\",\"" +
							password + "\",\"" + name + "\",\"" + date  + "\");";	
					statement.executeUpdate(sqlInsert);					
					session.setAttribute("username",username);
					session.setAttribute("password",password);
					statement.close();
				    response.sendRedirect(redirectURL);
				}else {
					%>
					<div id="register">
						<h3 class="register-h"> User name Taken.</h3>
						<h3 class="register-h"> Please try again! </h3>
						<br /> 
						<form method="get" action="/092020_Apathon_-_internet_and_applications/newUser">
							<table>
								<tr>
									<td>User Name:</td>
									<td> <input type="text" name="username" size=12 /></td>
								</tr>
								<tr>
									<td>Password:</td>
									<td><input type="password" name="password" size=12 /></td>
								</tr>
								<tr>
									<td>Name:</td>
									<td><input type="text" name="name" size=15 /></td>
								</tr>
								<tr>
									<td>Birthday:</td>
									<td><input type="date" name="rdate" size=10/></td>
								</tr>
								<tr id="submit-tr">
									<td colspan=2><input type=submit id="submit-td"/></td>
								</tr>
							</table>			
						</form>
					</div>				
					<%
				}
				rs.close();
				statement.close();
				connection.close();

				
			}
		   
		catch (Exception e) {
			e.printStackTrace();

		}

	}
%>			
</body>
</html>