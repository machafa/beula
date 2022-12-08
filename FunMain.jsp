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
	<title>BEULA-PRINCIPAL</title>

	<link rel="stylesheet" href="meuStyle.css">
</head>

	<div class="navbar">
 		<div class="dropdown">
    		<button class="dropbtn">Tarefas</i></button>
	    	<div class="dropdown-content">
	      		<button class="btn" id="addTarefas">Inserir</button><br>
	      		<a class="btn" id="viewTarefas" href="FunMain.jsp">Visualizar</a>
	    	</div>
  		</div> 

  		<div class="dropdown">
    		<button class="dropbtn">Produtos</i></button>
	    	<div class="dropdown-content">
	      		<button class="btn">Inserir</button><br>
	      		<a class="btn" id="viewTarefas" href="produtos.jsp">Visualizar</a>
	    	</div>
  		</div>

  		
  		<div class="dropdown"><button class="dropbtn"><a href="login.jsp">Sair</a></button></div> 
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
		<div class="desktop" style="display: none; width:1000px;" id="inserir">
			<fieldset>
				<input type="text" placeholder="Nome" id="nomeInsert"/>
				<input type="text" placeholder="Descricao" id="descricaoInsert"/>
				<input type="text" placeholder="ID do funcionario"id="id_funcionarioInsert"/><br>
				<input type="text" placeholder="Estado" id="estadoTarefasInsert" value="Incompleto"style="margin-bottom: 20px; background-color:orangered;" readonly/>
				<input type="text" placeholder="Inicio"id="inicioTarefaInsert" value="<%=data%>" readonly/>
				<input type="text" placeholder="Fim"id="fimTarefaInsert" name="fimTarefaInsert" /><br>
				<button type="submit" id="salvarInserir">Salvar</button>

			</fieldset>
		</div>
		<div>
		<input type="text" placeholder="Procurar tarefa" name="search" class="searchInput" id="search" onkeyup="funcaoProcura()"/>
		<table class="tabela" id="tabela"> 	
	       	<tr bgcolor="green" style="text-transform: uppercase;">
	    		<th>Id</th>
	        	<th>Nome</th>
	        	<th>Descricao</th>
	        	<th>Id do funcionario</th>
	        	<th>Estado</th>
	        	<th>Inicio</th>
	        	<th>Fim</th>
	        </tr>
		  <%
		 
			try{
			connection = DriverManager.getConnection(connectionUrl+database, userid, password);
			statement=connection.createStatement();
			String sql ="select * from tarefas";
			resultSet = statement.executeQuery(sql);
			int i=0;
			while(resultSet.next()){
			%>
			<tr> 
					<td><%=resultSet.getString("id_tarefa")%></td>
				    <td><%=resultSet.getString("nome")%></td>
				    <td><%=resultSet.getString("descricao")%></td>
				    <td><%=resultSet.getInt("id_fun")%></td>
				    <td><%=resultSet.getString("estado")%></td>
				    <td><%=resultSet.getString("inicio")%></td>
				    <td><%=resultSet.getString("fim")%></td>
				    
				    <td><a href="FunMain.jsp?id=<%=resultSet.getString("id_tarefa") %>"><button type="button" id="btn" class="delete">Delete</button></a></td>

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
	    
	    <script>
	    	var tabela=document.getElementById("tabela");
	    	var dataFim;
	    	var estado;
	    	
	    	for (var i =1;i<tabela.rows.length;i++) {
				estado=tabela.rows[i].cells[4].innerHTML;
				dataFim=tabela.rows[i].cells[6].innerHTML;

				//Data actual
				var dateobj = new Date();
    			var B = dateobj.toISOString();
    			let result = B.substring(0, 10);
    			var str = result;
    			var array = str.split("-");
    			var dataActual=array[0]+array[1]+array[2];

    			//Data da tarefa
    			var array1 = dataFim.split("-");
    			var dataTarefa=array1[0]+array1[1]+array1[2];
    			alert(pega1);

	  		}
	  		
	   		
		</script>
	    </table>
	    <div>
	    	<button  type="submit" id="editar" class="btnApagar">Editar</button>
	    	
		</div>

		<div class="grid" id="formulario">
			
			
			<input type="text" id="id" name="id" style="display: none; background-color: grey;" readonly/>
			
			Nome:<input type="text" id="nome" name="nome" />
			Descricao: <input type="text" id="descricao" name="descricao" />
			Responsavel: <input type="text" id="funcionario" name="funcionario" />
			Estado: <input type="text" id="estado" name="estado" />
			  <br>
			Inicio: <input type="text" id="inicio" name="inicio" />
			Termino: <input type="text" id="fim" name="fim" />

			

			<button  type="submit" id="botao" class="btnApagar">Salvar</button>
		</div>

	    <script>
	  		var table=document.getElementById("tabela"),rIndex;
			for (var i =0; i<table.rows.length; i++) {
				table.rows[i].onclick=function(){
					rIndex=this.rowIndex;
					document.getElementById("id").value=this.cells[0].innerHTML;
					document.getElementById("nome").value=this.cells[1].innerHTML;
					document.getElementById("descricao").value=this.cells[2].innerHTML;
					document.getElementById("funcionario").value=this.cells[3].innerHTML;
					document.getElementById("estado").value=this.cells[4].innerHTML;
					document.getElementById("inicio").value=this.cells[5].innerHTML;
					document.getElementById("fim").value=this.cells[6].innerHTML;
				};
			}
			
			document.getElementById("editar").onclick=function(){
				var elemento= document.getElementById("formulario");
				if (elemento.style.display == "none"){
					elemento.style.display = "block";
				} else {
					elemento.style.display = "none";
				}

			};

			document.getElementById("addTarefas").onclick=function() {
				var btnInserir= document.getElementById("inserir");
				if (btnInserir.style.display == "none"){
					btnInserir.style.display = "block";
				} else {
					btnInserir.style.display = "none";
				}
			};


			
			document.getElementById("estadoSelecionar").onclick=function() {
				var x = document.getElementById("estadoSelecionar").value;
  				document.getElementById("estado").innerHTML = x;
			};


			function funcaoProcura() {
  				var input, filter, table, tr, td1, i, txtValue;
			  	input = document.getElementById("search");
			  	filter = input.value.toUpperCase();
			  	table = document.getElementById("tabela");
			  	tr = table.getElementsByTagName("tr");
			  	for (i = 0; i < tr.length; i++) {
				    td1 = tr[i].getElementsByTagName("td")[1];
				    
				    if (td1) {
					      txtValue = td1.textContent || td1.innerText;
					      if (txtValue.indexOf(filter) > -1) {
					        tr[i].style.display = "";
					      } else {
					        tr[i].style.display = "none";
					      }
				    }
			  	}
			}
	    </script>
	    <p id="info"></p>
	    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.0/jquery.min.js"></script>
        
        <script src="jquery-3.2.1.js"></script>
        
        <script>

       
            $("#botao").ready(function() {
                $("#botao").click(function() {

                    var fn = $("#id").val()+";"+$("#nome").val()+";"+$("#descricao").val()+";"+$("#funcionario").val()+";"+$("#estado").val()+";"+$("#inicio").val()+";"+$("#fim").val();

                    $.post("index1.jsp", {
                        n3: fn

                    },function(data) {
                        $("#resposta").html(data);

                    });
                    if ($("#estado").val()=="Completo") {


                    	$.post("smsGorjeta.jsp",{
                    		infoEst: fn
                    	},function(info) {
                    	
                        $("#resposta").html(info);

                    });
                    	
                    }
                    
                    location.reload();
                });
            });
           
           $("#salvarInserir").ready(function() {
                $("#salvarInserir").click(function() {
                    var fn =$("#nomeInsert").val()+";"+$("#descricaoInsert").val()+";"+$("#id_funcionarioInsert").val()+";"+$("#estadoTarefasInsert").val()+";"+$("#inicioTarefaInsert").val()+";"+$("#fimTarefaInsert").val();
                    document.getElementById("nomeInsert").value="";
                    document.getElementById("descricaoInsert").value="";
                    document.getElementById("id_funcionarioInsert").value="";
                    document.getElementById("estadoTarefasInsert").value="";
                    document.getElementById("inicioTarefaInsert").value="";
                    document.getElementById("fimTarefaInsert").value="";

                    $.post("index1.jsp", {
                        n2: fn

                    },function(data) {
                        $("#insertResposta").html(data);

                    });
                    location.reload();
         			
                });
            });
        </script>


        <%
		String id=request.getParameter("id");
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/beula", "root","");
			Statement st=conn.createStatement();
			int i=st.executeUpdate("DELETE FROM tarefas WHERE id_tarefa="+id);
			
			if(i>0){
				
			}
		}catch(Exception e){
			System.out.print(e);
			e.printStackTrace();
		}


		
		%>
	</center>
	</body>
</html>