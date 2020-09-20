<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.ArrayList"%>
<html>
<head>
<meta charset="UTF-8">
<title>pageupdate</title>  
<link rel="stylesheet" href="./css/pageupdate.css">    
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.css"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

</head>

<%
	String username = (String)session.getAttribute("username");
	if(username == null){
		response.sendRedirect("/092020_Apathon_-_internet_and_applications/");
	}

%>

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
<form method="post" id="form" action="/092020_Apathon_-_internet_and_applications/pageupdateservlet">
  <label for="fname">name:</label>
  <input type="text" id="fname" name="name"><br><br>
  <label for="date">birthday:</label>
  <input id="date" type="text"  name="rdate" autocomplete="off"><br><br>
  <input type="submit" value="Submit">
</form>
<button type="button" id="back" onclick="myProfile()">back</button>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
	    $("#date").datepicker();
	});
	function myProfile(){
		window.location.href = '/092020_Apathon_-_internet_and_applications/myhomepage';
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