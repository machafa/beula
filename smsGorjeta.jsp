<html>
<%@ page import="java.net.*, java.util.Base64,java.io.*, java.io.*, java.util.*, java.sql.*"%>
	<body>
		<%   

		//CONECTOR DE BASE DE DADOS
		String driver="com.mysql.cj.jdbc.Driver";
        String urlBD="jdbc:mysql://localhost:3306/beula";
        String username="root";
        String password="";
        Class.forName(driver);
		Connection conn= DriverManager.getConnection(urlBD,username,password);
		Statement statement = null;
		String sql=null;
		ResultSet rs;
		int status;

        //RECUPERAR DADOS ENVIADOS POR TER TAREFA COMPLETA
		String dado=request.getParameter("infoEst");
		
      

        String num_Fun=null;
        String nome_Fun=null;
        String descricao=null;


	 // API PARA ENVIO DE MENSAGENS DE BULKSMS
		String myURI = "https://api.bulksms.com/v1/messages";

    	//DADOS PARA ENVIAR MENSGEM
	    String myUsername = "joji_uzumi";
	    String myPassword = "jojiUzumi12";
	    String numero=null;
	    String sms="";
		


		 //ENTRAR SE FUNCIONARIO ESQUECER SENHA
		if (dado!=null) {
		
			String[] sliced = dado.split(";");

			for (int i=0;i<sliced.length;i++) {
	        	out.println(sliced[i]);
        	}

        	String id_tarefa=sliced[0];
        	String id_funcionario=sliced[3];
       	 	String data=sliced[6];
			String funcionario=null;

			try{
            
            	statement=conn.createStatement();
				sql="SELECT funcionarios.id, funcionarios.nome, funcionarios.numero, tarefas.id_tarefa, tarefas.descricao from funcionarios as funcionarios join tarefas as tarefas ON funcionarios.id="+id_funcionario+" and tarefas.id_tarefa="+id_tarefa;
	            
	           rs=statement.executeQuery(sql);

	           while(rs.next()){

	           	nome_Fun=rs.getString("nome");
	           	numero=rs.getString("numero");
	           	descricao=rs.getString("descricao");


	           		//ENVIO DE MENSAGEM
		            sms="Ola "+nome_Fun+"! Parabens por completar a tarefa antes do tempo marcado. Recebera um bonus junto ao teu salario. Passe bem :)";
	                // the details of the message we want to send
		            String myData = "{to: \""+numero+"\", encoding: \"UNICODE\", body: \""+sms+"\"}";

		            // build the request based on the supplied settings
		            URL url = new URL(myURI);
		            HttpURLConnection requestConnection = (HttpURLConnection) url.openConnection();
		            requestConnection.setDoOutput(true);

		            // supply the credentials
		            String authStr = myUsername + ":" + myPassword;
		            String authEncoded = Base64.getEncoder().encodeToString(authStr.getBytes());
		            requestConnection.setRequestProperty("Authorization", "Basic " + authEncoded);

		            // we want to use HTTP POST
		            requestConnection.setRequestMethod("POST");
		            requestConnection.setRequestProperty( "Content-Type", "application/json");

		            // write the data to the request
		            OutputStreamWriter outputS = new OutputStreamWriter(requestConnection.getOutputStream());
		            outputS.write(myData);
		            outputS.close();

		            // try ... catch to handle errors nicely
		            try {
		              	// make the call to the API
		              	InputStream responseStream = requestConnection.getInputStream();
		              	BufferedReader in = new BufferedReader(new InputStreamReader(responseStream));
		              	String replyText;

		              	while ((replyText = in.readLine()) != null) {
		                	out.println("Recebera uma mensagem com sua nova palavra-passe");
		            	}
		            in.close();
		            
		            }catch (IOException ex) {

		              	out.println("An error occurred:" + ex.getMessage());
		              	BufferedReader in = new BufferedReader(new InputStreamReader(requestConnection.getErrorStream()));
		              	// print the detail that comes with the error
		              	String replyText;
		              	
		              	while ((replyText = in.readLine()) != null) {
		                	System.out.println(replyText);
		              	}
		              	in.close();
		            }
		            
		            requestConnection.disconnect();
	           	
	           }
           		conn.close();
	

            	}catch (Exception e){
        			out.println("You got an exception called "+e);    
        		}

	    	
		}	
 
    %>
	</body>
</html>