<%@page import="java.sql.*"%>

<%@ page import="java.time.LocalDate"%>

<%@ page import="java.text.ParseException"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@page import= "java.util.Date"%>

<%
String driver = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String database = "beula";
String userid = "root";
String password = "";

int status=0;
try {
Class.forName(driver);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}
Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
%>
<!DOCTYPE html>


<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>BEULA-Funcionarios</title>

	<link rel="stylesheet" href="meuStyle.css">
</head>

	<div class="navbar">
 		<div class="dropdown">
    		<button class="dropbtn">Tarefas</i></button>
	    	<div class="dropdown-content">
	      		<button class="btn" id="addTarefas">Inserir</button><br>
	      		<a class="btn" id="viewTarefas" href="AdminMain.jsp">Visualizar</a>
	    	</div>
  		</div> 

  		<div class="dropdown">
    		<button class="dropbtn">Valores</i></button>
	    	<div class="dropdown-content">
	      		<button class="btn">Inserir</button><br>
	      		<a class="btn" id="viewTarefas" href="valores.jsp">Visualizar</a>
	    	</div>
  		</div> 
  		<div class="dropdown">
    		<button class="dropbtn">Produtos</i></button>
	    	<div class="dropdown-content">
	      		<button class="btn">Inserir</button><br>
	      		<a class="btn" id="viewTarefas" href="produtos.jsp">Visualizar</a>
	    	</div>
  		</div>

  		<div class="dropdown">
    		<button class="dropbtn">Funcionarios</i></button>
	    	<div class="dropdown-content">
	      		<button class="btn">Inserir</button><br>
	      		<a class="btn" id="viewTarefas" href="funcionarios.jsp">Visualizar</a>
	    	</div>
  		</div>
  		<div class="dropdown"><a href="login.jsp">Sair</a></div> 
  	<img src="logobeula2.png"/>
</div>
	<body class="todo">

		<%
			LocalDate data=LocalDate.now();
			String antes=null;
			String depois=null;
			String agora=null;
			String dataFim;
			String important;
		%>
		
	<center>
		
		<div>
		
		<table class="tabela" id="tabela"> 	
	       	<tr bgcolor="green" style="text-transform: uppercase;">
	    		<th>Id</th>
	        	<th>Nome</th>
	        	<th>Apelido</th>
	        	<th>Morada</th>
	        	<th>Numero</th>
	        	<th>Cargo</th>
	        	<th>User</th>
	        </tr>
		  <%
		 
			try{
			connection = DriverManager.getConnection(connectionUrl+database, userid, password);
			statement=connection.createStatement();
			String sql ="select * from funcionarios";
			resultSet = statement.executeQuery(sql);
			int i=0;
			while(resultSet.next()){
			%>
			<tr> 
					<td><%=resultSet.getString("id")%></td>
				    <td><%=resultSet.getString("nome")%></td>
				    <td><%=resultSet.getString("apelido")%></td>
				    <td><%=resultSet.getString("morada")%></td>
				    <td><%=resultSet.getString("numero")%></td>
				    <td><%=resultSet.getString("cargo")%></td>
				    <td><%=resultSet.getString("user")%></td>
				    
				  

			</tr>
		<%
			i++;
			}
			connection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		%>
	</div>
	    </table>
	    
	</center>
	</body>
</html>