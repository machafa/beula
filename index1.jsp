<html>
<%@ page import="java.util.*, java.sql.*,java.io.*, java.time.LocalDate"%>
<body>
	<center>
		<%	
		String driver="com.mysql.cj.jdbc.Driver";
	    String url="jdbc:mysql://localhost:3306/beula";
	    String username="root";
	    String password="";
	    String cargo=null;
		String papel=null;
		int status=0;
		int status1=0;	


		String str = request.getParameter("n3");
		String receberDados=request.getParameter("n2");
		String receberID=request.getParameter("n1");

		//PARA EDITAR
		if (str!=null) {

			String[] sliced = str.split(";");

			for (int i=0;i<sliced.length;i++) {
        		out.println(sliced[i]);
        	}
			try {
        	
        	

		       	Class.forName(driver);

			    Connection conn= DriverManager.getConnection(url,username,password);
		        PreparedStatement preparedStatement=conn.prepareStatement("update tarefas set nome=?,descricao=?,id_fun=?,estado=?, inicio=?,fim=? where id_tarefa=?");

	            preparedStatement.setString(1,sliced[1]);
	            preparedStatement.setString(2,sliced[2]);
	            preparedStatement.setString(3,sliced[3]);
	            preparedStatement.setString(4,sliced[4]);
	            preparedStatement.setString(5,sliced[5]);
	            preparedStatement.setString(6,sliced[6]);
	            preparedStatement.setString(7,sliced[0]);
	            status=preparedStatement.executeUpdate();
	            conn.close();
        	}catch (Exception e){
            	out.println("O programa teve o erro "+e);
        	}

        if(status>0){
            
            out.println("Sucesso");
        }else{
            
        	out.println("nao entrou "+receberDados);
		
        }

        if (sliced[5].equalsIgnoreCase("Incompleto")) {
        	
        	try {
        	
				Class.forName(driver);

			    Connection conn= DriverManager.getConnection(url,username,password);
		        PreparedStatement preparedStatement=conn.prepareStatement("insert into incompleto(id_tarefa,id_funcionario,data_fim) values (?,?,?)");
		        preparedStatement.setString(1,sliced[0]);
	            preparedStatement.setString(2,sliced[3]);
	            preparedStatement.setString(7,sliced[6]);
	           
	             status=preparedStatement.executeUpdate();

	            conn.close();
        	}catch (Exception e){
            	out.println("O programa teve o erro "+e);
        	}
        }

		}

		if(receberDados!=null){

			String[] sliced = receberDados.split(";");
  
        	//String id,nome,descricao,funcionario,estado,inicio,fim;
        	for (int i=0;i<sliced.length;i++) {
        		out.println(sliced[i]);
        	}

			try{

				Class.forName(driver);

			    Connection conn= DriverManager.getConnection(url,username,password);
		        PreparedStatement preparedStatement=conn.prepareStatement("insert into tarefas(id_tarefa,nome,descricao,id_fun,estado,inicio,fim) values (?,?,?,?,?,?,?)");
		        preparedStatement.setString(1,sliced[0]);
	            preparedStatement.setString(2,sliced[1]);
	            preparedStatement.setString(3,sliced[2]);
	            preparedStatement.setString(4,sliced[3]);
	            preparedStatement.setString(5,sliced[4]);
	            preparedStatement.setString(6,sliced[5]);
	            preparedStatement.setString(7,sliced[6]);
	             status=preparedStatement.executeUpdate();

	            conn.close();            
        }catch(Exception ex){
            System.out.println("O programa teve o erro "+ex);
        }
        
	}if (receberID!=null) {
		try {
			Class.forName(driver);
            Connection conn= DriverManager.getConnection(url,username,password);
            PreparedStatement preparedStatement=conn.prepareStatement("delete from tarefas where id=?");
            preparedStatement.setString(1, receberID);
            status=preparedStatement.executeUpdate();
            conn.close();
        }catch (Exception e){
            System.out.println("O programa teve o erro "+e);
        }
        
	}

		%>
	</center>
</body>

</html>
