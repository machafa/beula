<!DOCTYPE html>
<%@ page import="java.net.*, java.util.Base64,java.io.*, java.io.*, java.util.*, java.sql.*"%>
<html>
<head>
	<meta http-equiv="Content-Type" content=" text/html" charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Recuperar senha</title>

	<style>
		body.todo{
			font-style: !important;	
			font-family: Trebuchet MS, sans-serif;
			padding-top: 10%;
			padding-right: 50%;
			padding-left: 25%;
			margin-top: 7%;
			background-color: green;
			background-image: url("beula.png");
			
		}
		div.important{
			background-color: white;
			padding-top: 7px;
			border-top-left-radius: 20px; 
			border-bottom-right-radius:20px; 
			width: 750px;
			line-height:20px;
		}

		.searchInput{
			
			width: 100px;
		  box-sizing: border-box;
		  border: 2px solid #ccc;
		  border-radius: 4px;
		  font-size: 16px;
		  background-color: white;
		  background-position: 10px 10px; 
		  background-repeat: no-repeat;
		  padding: 12px 20px 12px 40px;
		  transition: width 0.4s ease-in-out;
		  margin-bottom: 20px;
		   margin-left: 20px;
		   font-size: 14px;

		}
		.searchInput:focus{
			width: 150px;
		}
		.confirmarDados{
			margin-top:30px; 
			margin-left:45px;
		  	background-color:black; /* Green */
		  	
		  	color: white;
		 	padding: 16px 16px;
		  	text-decoration: none;
		  	display: inline-block;
		  	font-size: 14px;
		  	transition-duration: 0.4s;
		  	cursor: pointer;
		}
		.confirmarDados:hover {
			 box-shadow: 0 12px 16px 0 grey,0 17px 50px 0 floralwhite;
		}
	</style>
</head>
<body class="todo">
	<center>
		
		<div class="important">

			<div class="welcome">
				<h3>Bemvindo a Beula</h3>
			</div>

			<fieldset style="background-color: white;width: 500px;">

				<legend>Coloque aqui seus dados para requerer nova senha</legend>

			<form name="formulario" action="smsRecuperaSenha.jsp" method="post">
				
				<input type="text" id="id" name="id" placeholder="ID" class="searchInput" /> 
				<input type="text" id="user" name="user" placeholder="USER" class="searchInput" />
				<input type="submit" value="Requerer Senha" id="requererSenha"class="confirmarDados">
			</form>
			
			</fieldset><br><br>
			
		</div>
	</center>

	
</body>
</html>