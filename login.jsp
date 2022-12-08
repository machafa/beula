<!DOCTYPE html>
<%@ page import="java.util.*, java.sql.*,java.io.*"%>
<html>
<head>
	<meta http-equiv="Content-Type" content=" text/html" charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>BEULA</title>

	<style>
		body.todo{
			font-style: !important;	
			font-family: Trebuchet MS, sans-serif;
			padding-top: 10%;
			padding-right: 50%;
			padding-left: 25%;
			background-color: green;
			background-image: url("beula.png");
		}

		div.important{
			background-color: white;
			border-top-left-radius: 20px; 
			border-bottom-right-radius:20px;
			padding-top: 7px; 
			width: 600px;
			height: 300px;
			line-height:20px;

		}

		p.parag{
			
			background-color:mediumvioletred;
			width:50%;
			text-transform: uppercase;
		}

		
	</style>
</head>
<body class="todo">
	<center>
		
		<div class="important">

			<div class="welcome">
				<h3>Bemvindo a Beula</h3>
			</div>
			<p id="validar" class="parag"></p>
			<fieldset style="background-color: ghostwhite;width: 500px;">

				<legend>Entrar na conta</legend>

			<form name="formulario" action="login.jsp" method="get">
				<input type="text" name="user" placeholder="Nome do usuario" maxlength="20" style="margin-top: 20px;" /><br>
				<input type="password" name="pass" placeholder="Senha" style="margin: 20px;" /><br>
				
				<select id="tipo_Login" name="tipo_Login" style="display: none;" >
					<option value="default" disabled>Selecione papel</option>
					<option value="funcionario">Funcionario</option>
					<option value="admin_tarefas">Administrador</option>
				</select>

				<input type="submit" value="Entrar" style="margin-bottom: 20px;"/>
				
			</form>
			<a href="senha.jsp" style="margin-left: 300px;">Esqueci senha</a>
			</fieldset><br><br>
			
		</div>
	</center>


		<%
	String user=request.getParameter("user");
    String pass=request.getParameter("pass");
    String completo=user+" "+pass;
    String cargo=null;
    List<String> lista=new ArrayList<String>();
	String funcionario=null;
	 
		if(completo!=null){

			try{
            String driver="com.mysql.cj.jdbc.Driver";
            String url="jdbc:mysql://localhost:3306/beula";
            String username="root";
            String password="";
            
            Class.forName(driver);

            Connection conn= DriverManager.getConnection(url,username,password);
             PreparedStatement preparedStatement=conn.prepareStatement("SELECT user,pass,cargo FROM funcionarios where user=? and pass=?");
            preparedStatement.setString(1, user);
            preparedStatement.setString(2, pass);
            ResultSet rs=preparedStatement.executeQuery();

            if (rs.next()) {
            	funcionario=rs.getString(3);

            	if (rs.getString(3).equalsIgnoreCase("funcionario")) {
            		%>
		        <script>	
		        	var win=window.open("FunMain.jsp","_self");
					win.focus();	
				</script>
        		<%
            	}if (rs.getString(3).equalsIgnoreCase("administrador")) {
            	%>
		        <script>
		        	
		        	var win=window.open("AdminMain.jsp","_self");
					win.focus();
		        	
				</script>
        		<%
            }
             }
            
            conn.close();
            
        }catch (Exception e){
        	out.println("You got an exception called "+e);
           

        }
		

		
	
	}

		
%>
</body>
</html>