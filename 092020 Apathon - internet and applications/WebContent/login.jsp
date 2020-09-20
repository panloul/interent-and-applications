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
<title>Login</title>
<link rel="stylesheet" href="./css/login.css">
<title>Login</title>
</head>

<body>
<h1 id="title"> Internet and applications Appathon 09-2020</h1>

<%
	if(request.getParameter("username") == null
	   || request.getParameter("password") == null
	   || request.getParameter("username").trim().equals("")
	   || request.getParameter("password").trim().equals(""))
	{
	
%>
<div id="login">
	<h3 class="login-h" >please login</h3>
	<br />  
	<form method="get" action="/092020_Apathon_-_internet_and_applications/">
		<table>
			<tr class="field">
				<td >User Name:</td>
				<td> <input  type="text" name="username" size=12 /></td>
			</tr>
			<tr class="field">
				<td>Password:</td>
				<td><input type="password" name="password" size=12 /></td>
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
		try 
			{

//     			System.out.println(application.getRealPath(""));
				session.setAttribute("username",username);
				session.setAttribute("password",password);

				Class.forName("com.mysql.jdbc.Driver");
				connection = DriverManager.getConnection(connectionURL, "root","");
				statement = connection.createStatement();
				String sqlSelect = "SELECT * FROM users WHERE username =\"" + username  + "\" ;";	
				rs = statement.executeQuery(sqlSelect);
			
				String redirectURL = null;
				if(rs == null || !rs.next()) {	
					response.sendRedirect( "/092020_Apathon_-_internet_and_applications/newUser");
				}else {
					
					if (rs.getString("password").equals(password)){
				    	response.sendRedirect("/092020_Apathon_-_internet_and_applications/myhomepage");
					}
					else{
						
						%>
						<div id="login">
							<h3 class="login-h" >wrong password!</h3>
							<h3 class="login-h"> please try again </h3>
							<br />  
							<form method="get" action="/092020_Apathon_-_internet_and_applications/">
								<table>
									<tr class="field">
										<td >User Name:</td>
										<td> <input  type="text" name="username" size=12 /></td>
									</tr>
									<tr class="field">
										<td>Password:</td>
										<td><input type="password" name="password" size=12 /></td>
									</tr>
									<tr id="submit-tr">
										<td colspan=2><input type=submit id="submit-td"/></td>
									</tr>
								</table>
							</form>
						</div>										
						<%
					}
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