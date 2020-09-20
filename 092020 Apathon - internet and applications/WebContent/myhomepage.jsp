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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>myhomepage</title>
<link rel="stylesheet" href="./css/myhomepage.css">  
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>

<body>
<div  id="cart">
	<a id="logout" href="javascript:;" onclick="logout()">
		logout
	 </a>
	<a href="/092020_Apathon_-_internet_and_applications/cart">my cart
	<i class="fa fa-shopping-cart" style="font-size:38px"></i>
	</a>
</div>

<h1 id="title"> Internet and applications Appathon 09-2020</h1>			
<%

	
	try{
		String username = (String)session.getAttribute("username");
		String password = (String)session.getAttribute("password");;
		
		if(username == null){
			response.sendRedirect("/092020_Apathon_-_internet_and_applications/");
		}
		else{
			
			Class.forName("com.mysql.jdbc.Driver");
			connection = DriverManager.getConnection(connectionURL, "root","");
			statement = connection.createStatement();
			String sqlSelect = "SELECT name,date FROM users WHERE username =\"" + username  + "\" ;";	
			rs = statement.executeQuery(sqlSelect);
			rs.next();
			String name = rs.getString("name");
			String date = rs.getString("date");
			pageContext.setAttribute("username", username);
			pageContext.setAttribute("name", name);
			pageContext.setAttribute("date", date);
			rs.close();
			%>
			<div id="myProfile">
				<div  id="uname">
					Welcome Back ${username}
				</div>
				<div  id="name">
					 your name is: ${name}
				</div>
				<div  id="bday">
					your birthday is: ${date}
				</div>
				<div id="settings-button-div">
					<button type="button" id="settings-button" name="change profile settings" onclick="changeSettings()"> change profile settings </button>
				</div>
			</div>
			
			<%
			//SELECT * FROM products as pr WHERE EXISTS (SELECT * from purchases as pu WHERE pu.product_id = pr.product_id);
			sqlSelect = "SELECT product_name FROM products AS P , (SELECT product_id from purchases WHERE username = \"" + username +
					"\" ) AS PU WHERE PU.product_id = P.product_id; ";
			rs = statement.executeQuery(sqlSelect);
			
			if(rs == null || !rs.next()) {	
				%>
				<div id="no-products">
					<div class="no-products-text">
					you haven't made any previous purchases.
					</div>
					<div class="no-products-text">
					find new deals!! 
					</div>
				</div>
				
				<%
			}
			else{
				%>
				<div class="products-text">
				your previous purchases
				</div>
				<table>
				<%
				do{
			        String product_name = rs.getString("product_name");
					pageContext.setAttribute("product_name", product_name);
					%>
					<tr class="product-tr">
					    <td class="product-td">${product_name}</td>
					</tr>					
					<%

				}while(rs.next());
				%>
				</table>
				<div class="products-text">
				find new deals!!				
				</div>
				<%
			}
					
					
			rs.close();
			statement.close();
			connection.close();

		}
	}catch(Exception ex){
		ex.printStackTrace();
	}


%>	
<button type="button" id="browse" onclick="Products()">start browsing</button>

<script type="text/javascript">
	function changeSettings(){
		window.location.href = '/092020_Apathon_-_internet_and_applications/pageupdate';
	}
	function Products(){
		window.location.href = '/092020_Apathon_-_internet_and_applications/products';
	}
	function logout(){
		var xhr = new XMLHttpRequest();
	    xhr.onreadystatechange = function() {
	    	window.location.replace("/092020_Apathon_-_internet_and_applications/");
	    };
	    xhr.open('POST', '/092020_Apathon_-_internet_and_applications/logout', true);
	    xhr.send(null);
	}
</script>		
</body>
</html>