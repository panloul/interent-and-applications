<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<%
	String connectionURL = "jdbc:mysql://localhost:3306/internet_and_applications";
	Connection connection = null;
	Statement statement = null;	
	ResultSet rs = null;
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>cart</title>
<link rel="stylesheet" href="./css/cart.css">  
</head>

<body>
<div  id="cart">
	<a id="logout" href="javascript:;" onclick="logout()">
		logout
	 </a>
 	<a id="home" href="/092020_Apathon_-_internet_and_applications/myhomepage">back to home
	</a>
</div>

<h1 id="title"> Internet and applications Appathon 09-2020</h1>			
<%
	String username = (String)session.getAttribute("username");
	if(username == null){
		response.sendRedirect("/092020_Apathon_-_internet_and_applications/");
	}
	else{
		
		pageContext.setAttribute("username", username);
		ArrayList<String> added_products = (ArrayList<String>)session.getAttribute("products");
		
		if(added_products == null || added_products.isEmpty()){
			%>
			<div id="no-products">
				you haven't added any products to your cart
				<p></p>
				find new products!
				<button id="browse" onclick="window.location.href='/092020_Apathon_-_internet_and_applications/products'">browse</button>
				go back home
				<button id="my-home-page" onclick="window.location.href='/092020_Apathon_-_internet_and_applications/myhomepage'">home</button>
				
			</div>
			<%
		}
		else{
			try{
				
			    String[][] countryTaxes = 
			 	    { 
			 	    	{"Greece","0.24"},
			 	    	{"Denmark","0.22"},
			 	    	{"Germany","0.29"},
			 	    	{"USA","0.21"},
			 	    	{"France","0.31"}
				    	
				    };
			    
			    String Country = request.getParameter("country");
			    if (Country != null){
			    	for(int i = 0; i < 5; i++){
			    		if(countryTaxes[i][0].equals(Country)){
			    			session.setAttribute("tax", countryTaxes[i][1]);
			    			break;
			    		}
			    	}

			    }

				
				float sum = 0;
				Class.forName("com.mysql.jdbc.Driver");
				connection = DriverManager.getConnection(connectionURL, "root","");
				statement = connection.createStatement();
				
				String sqlSelect = "SELECT * FROM products;";	
				rs = statement.executeQuery(sqlSelect);
		        HashMap<String,String> product_names = new HashMap<>();
		        HashMap<String,String> product_prices = new HashMap<>();

				while (rs.next())
			      {
			        String product_id = rs.getString("product_id");
			        String product_name = rs.getString("product_name");
			        String product_price = rs.getString("product_price");
			        product_names.put(product_id,product_name);
			        product_prices.put(product_id,product_price);
			      }
				rs.close();
				statement.close();
				connection.close();
				%>
				<table id="products">
					<tr>
					    <th>remove</th>
					    <th>Product Name</th>
					    <th>Price</th>
					</tr>
				<%
				for(String product_id: added_products){
					String product_name = product_names.get(product_id);
					String product_price = product_prices.get(product_id);

					pageContext.setAttribute("product_id", product_id);
					pageContext.setAttribute("product_price", product_price);
					pageContext.setAttribute("product_name", product_name);
					pageContext.setAttribute("product_price", product_price);
			        sum += Float.parseFloat(product_price);
	
					%>
					<tr>
					    <td class="product-td">
						    <form method="post" action="/092020_Apathon_-_internet_and_applications/remove_product">
						    	<input  type="hidden" name="product_id" value="${product_id}" size=12 />
						    	<input type="submit" name="remove" value="remove" />
						    </form>
					    </td>
					    <td class="product-name">${product_name}</td>
					    <td class="product-td-price">${product_price}$
					    </td>
	
					  </tr>
					<%
				}
				String taxString = (String)session.getAttribute("tax");
				if (taxString == null) taxString = "0.24";
				float taxpercent =  Float.parseFloat(taxString);
				float tax = sum * taxpercent;
				
				String DiscountString = (String)session.getAttribute("discount");
				if (DiscountString == null) DiscountString = "0.00";
				float DiscountPercent =  Float.parseFloat(DiscountString);
				float Discount = (sum  + tax) * DiscountPercent;
				
				float total = sum + tax - Discount;
				
				pageContext.setAttribute("sum", String.format("%.02f",sum));
				pageContext.setAttribute("tax", String.format("%.02f",tax));
				pageContext.setAttribute("discount", String.format("%.02f",Discount));
				pageContext.setAttribute("total", String.format("%.02f",total));

				
				%>
				</table>
				<div id="price">
				    <a class="sum" id="label">total cost:
				    <br/> Tax:
				    <br/> Discount:
				    <br/> Total:
				    </a>
				    <a class="sum sum-price" id="value">${sum}$ 
				    <br/> ${tax}$
				    <br/> ${discount}$
				    <%
				    if(Discount==0){
					    %>
					    <br/> ${total}$
					    <%
				    }
				    else{
					    %>
					    <br/>
					    <div style="color:red;"> ${total}$</div> 
					    <%
				    }
		    		%>
				    </a>
				</div>  
				<div id="voucher-div">
					<label for="voucher">enter voucher code</label>
					<input id="voucher" type="text" name="voucher" onchange="voucher(this)" size=12 />
				</div>
				<form id="country-form" action="/092020_Apathon_-_internet_and_applications/cart">
				  <label for="country">Select country:</label>
				  <select name="country" id="country" onchange="this.form.submit()">
				    <%
				    for(int i = 0; i < 5; i++){
				    	pageContext.setAttribute("country", countryTaxes[i][0]);
				    	if (Country != null && Country.equals(countryTaxes[i][0])){
						  	%>
						    <option value="${country}" selected>${country}</option>
					    	<%
				    	}
				    	else{
						  	%>
						    <option value="${country}">${country}</option>
					    	<%
				    	}

				    }
				  	%>
				  </select>
				</form>
				<div id="purchase-div">
				<button id="purchase" onclick="purchase('${username}')">purchase</button>
				</div>
				<%
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
	}
	
	%>	
	
	<script type="text/javascript">
	function logout(){
		var xhr = new XMLHttpRequest();
	    xhr.onreadystatechange = function() {
	    	window.location.replace("/092020_Apathon_-_internet_and_applications/");
	    };
	    xhr.open('POST', '/092020_Apathon_-_internet_and_applications/logout', true);
	    xhr.send(null);
	}
	var width = document.getElementById("products").offsetWidth;
	document.getElementById("price").setAttribute("style","width:" + width + "px");
	document.getElementById("price").style.width = width
	
	var offset1 = document.getElementsByClassName("product-td")[0].offsetWidth;
	document.getElementById("label").setAttribute("style","margin-left:" + offset1 + "px");
	document.getElementById("label").style.marginLeft = offset1
	var offset2 = document.getElementsByClassName("product-name")[0].offsetWidth - document.getElementById("label").offsetWidth;

	document.getElementById("value").setAttribute("style","margin-left:" + (offset2) + "px");
	document.getElementById("value").style.marginLeft = offset2
	
	function voucher(input){
		var xhr = new XMLHttpRequest();
	    xhr.onreadystatechange = function() {
	    	location.reload();
	    };
	    xhr.open('POST', '/092020_Apathon_-_internet_and_applications/voucher?voucherCode=' + input.value, true);
	    xhr.send(null);
		input.value = "";
	}
	function purchase(username){
		if(username == '') alert("cannot process purchase. you are not Logged in!");
		else{
			var xhr = new XMLHttpRequest();
		    xhr.onreadystatechange = function() {
		    	window.location.replace("/092020_Apathon_-_internet_and_applications/thankyou");
		    };
		    xhr.open('POST', '/092020_Apathon_-_internet_and_applications/purchase', true);
		    xhr.send(null);
		}
	}
	</script>		
</body>
</html>