<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.ArrayList"%>
<%
	String connectionURL = "jdbc:mysql://localhost:3306/internet_and_applications";
	Connection connection = null;
	Statement statement = null;	
	ResultSet rs = null;
%>
<html>
<head>
<meta charset="UTF-8">
<title>products</title>
<link rel="stylesheet" href="./css/products.css">
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
<div id="product-page">
		<%
		try{
			Class.forName("com.mysql.jdbc.Driver");
			connection = DriverManager.getConnection(connectionURL, "root","");
			statement = connection.createStatement();
			
			String sqlSelect = "SELECT * FROM products;";	
			rs = statement.executeQuery(sqlSelect);
			%>
			<table>
			<tr>
			    <th>Product Name</th>
			    <th>Price</th>
			    <th>add to cart</th>
			  </tr>
			<%
			while (rs.next())
		      {
				String product_id = rs.getString("product_id");
		        String product_name = rs.getString("product_name");
		        String product_price = rs.getString("product_price");
		        
		        String tax = (String)session.getAttribute("tax");
		        if(tax == null){
		        	tax = "0.24";
		        }
		        
		        pageContext.setAttribute("tax", tax);
				pageContext.setAttribute("product_id", product_id);
				pageContext.setAttribute("product_name", product_name);
				pageContext.setAttribute("product_price", product_price);
				%>
				<tr class="product-tr">
				    <td class="product-td">${product_name}</td>
				    <td class="product-td-price">
				    	<button class="product-button" name="${tax}" value="${product_price}">${product_price}$</button>
				    </td>
				    <td class="product-td">
					    <form method="post" action="/092020_Apathon_-_internet_and_applications/add_product">
					    	<input  type="hidden" name="product_id" value="${product_id}" size=12 />
					    	<input type="submit" name="add" value="add" />
					    </form>
				    </td>
				  </tr>
				<%
		      }
			  rs.close();
			  statement.close();
			  connection.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		%>
		</table>
		</div>
		<button type="button" id="Tocart" onclick="cart()">proceed to cart</button>
		<p></p>
		<button type="button" id="back" onclick="myProfile()">back to home</button>
		<script type="text/javascript">
		function myProfile(){
			window.location.href = '/092020_Apathon_-_internet_and_applications/myhomepage';
		}
		function cart(){
			window.location.href = '/092020_Apathon_-_internet_and_applications/cart';
		}
		function logout(){
			var xhr = new XMLHttpRequest();
		    xhr.onreadystatechange = function() {
		    	window.location.replace("/092020_Apathon_-_internet_and_applications/");
		    };
		    xhr.open('POST', '/092020_Apathon_-_internet_and_applications/logout', true);
		    xhr.send(null);
		}
	    var inputs = document.getElementsByClassName("product-button");
		for(i = 0; i < inputs.length; ++i){
			if(i % 2 === 0){
				inputs[i].style.backgroundColor="LightGray";
			}
			inputs[i].addEventListener('focus',function(e){
		    	var tax = (1 + parseFloat(e.target.name)).toFixed(2);
		    	var price = ((parseFloat(e.target.value).toFixed(2)) * tax).toFixed(2);
		    	e.target.innerHTML = e.target.value + '(' + price + ')$';
		    	
		    });
		    inputs[i].addEventListener('blur',function(e){
		    	e.target.innerHTML = e.target.value + '$';
		    });
		}
</script>
</body>
</html>
