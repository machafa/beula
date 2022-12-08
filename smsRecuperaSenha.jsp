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
		PreparedStatement preparedStatement;
		ResultSet rs;
		int status;


        //DADOS DO FUNCIONARIO PARA PEGAR SENHA
		String idRecuperar=request.getParameter("id");
		String userRecuperar=request.getParameter("user");
		String novaSenha=null;
		String nome=null;

		//DADOS PARA LEMBRAR FUNCIONARIO SOBRE TAREFA E PARA INFORMAR AO FUNCIONARIO QUE RECEBERA GORJETA COM SEU SALARIO
		String tarefasFun=request.getParameter("tarefa");
		String gorjeta=request.getParameter("gorjeta");

	 // API PARA ENVIO DE MENSAGENS DE BULKSMS
		String myURI = "https://api.bulksms.com/v1/messages";

    	//DADOS PARA ENVIAR MENSGEM
	    String myUsername = "joji_uzumi";
	    String myPassword = "jojiUzumi12";
	    String numero=null;
	    String sms="Testando com codigo java";


	    //DADOS DE GERAR SENHA NOVA 
	    String Capital_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        String Small_chars = "abcdefghijklmnopqrstuvwxyz";
        String numbers = "0123456789";
        String symbols = "!@#$%^&*_=+-/.?<>)";
        String values = Capital_chars + Small_chars +numbers + symbols;
        // Using random method
        Random rndm_method = new Random();
        char[] password2 = new char[10];


        //ENTRAR SE FUNCIONARIO ESQUECER SENHA
		if (idRecuperar!=null && userRecuperar!=null) {
		
			String funcionario=null;
			try{
            
	            
	            preparedStatement=conn.prepareStatement("SELECT id,user,nome,numero FROM funcionarios where id=? and user=?");
	            preparedStatement.setString(1, idRecuperar);
	            preparedStatement.setString(2, userRecuperar);
	            rs=preparedStatement.executeQuery();

	            while (rs.next()) {
	            	nome=rs.getString(3);
	            	numero=rs.getString(4);
	           

	           		//GERAR NOVA SENHA
			        for (int i = 0; i <10; i++){
			            // Use of charAt() method : to get character value
			            // Use of nextInt() as it is scanning the value as int
			            password2[i] =values.charAt(rndm_method.nextInt(values.length()));
			  
			        }

					//COLOCAR SENHA NA BASE DE DADOS
					preparedStatement=conn.prepareStatement("UPDATE funcionarios SET pass=? WHERE id=?");

					novaSenha=String.valueOf(password2);
		            preparedStatement.setString(1, novaSenha);
		            preparedStatement.setString(2, idRecuperar);
		            status=preparedStatement.executeUpdate();


		            //ENVIO DE MENSAGEM
		            sms="Ola "+nome+" essa eh tua nova senha: "+novaSenha+". Passe bem :)";
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
		                	System.out.println("Sent");
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