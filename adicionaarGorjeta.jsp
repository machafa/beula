<%@ page import="java.net.*, java.util.Base64,java.io.*, java.io.*, java.util.*, java.sql.*"%>

<%


if (rs.next()) {
	            	nome=rs.getString(3);
	            	numero=rs.getString(4);

		            //ENVIO DE MENSAGEM
		            sms="Ola "+nome+"! Parabens por completar a tarefa antes do tempo marcado. Recebera um bonus junto ao teu salario. Passe bem :)";
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
            
          		}else{
            	out.println("Funcionario nao existe");
           		}
           		conn.close();
	

            	}catch (Exception e){
        			out.println("You got an exception called "+e);    
        		}
try {

	String driver="com.mysql.cj.jdbc.Driver";
        String urlBD="jdbc:mysql://localhost:3306/beula";
        String username="root";
        String password="";
        Class.forName(driver);
		Connection conn= DriverManager.getConnection(urlBD,username,password);
		PreparedStatement preparedStatement;
		ResultSet rs;
		int status;
        	
        
    String dado=request.getParameter("infoEst");	
    String[] sliced = dado.split(";");

		for (int i=0;i<sliced.length;i++) {
        	out.println(sliced[i]);
    }



	preparedStatement=conn.prepareStatement("insert into completo(id_tarefa,id_funcionario,data_fim) values (?,?,?)");
	preparedStatement.setString(1,sliced[0]);
	preparedStatement.setString(2,sliced[3]);
	preparedStatement.setString(3,sliced[6]);
	           
	status=preparedStatement.executeUpdate();

	conn.close();
    }catch (Exception e){
        out.println("O programa teve o erro "+e);
    }
%>