package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import connection.SingleConnectionBanco;
import model.ModelLogin;

public class DAOUsuarioRepository {

	private Connection connection;

	public DAOUsuarioRepository() {
		connection = SingleConnectionBanco.getConnection();
	}

	public ModelLogin gravarUsuario(ModelLogin objeto,  Long userLogado) throws SQLException {

		if (objeto.isNovo()) {/*Grava um novo*/
			String sql = "INSERT INTO public.model_login (login, senha, nome, email, usuario_id) VALUES (?, ?, ?, ?, ?);";

			PreparedStatement preparedSql = connection.prepareStatement(sql);

			preparedSql.setString(1, objeto.getLogin());
			preparedSql.setString(2, objeto.getSenha());
			preparedSql.setString(3, objeto.getNome());
			preparedSql.setString(4, objeto.getEmail());
			preparedSql.setLong(5, userLogado);

			preparedSql.execute();

			connection.commit();
		}else {
			String sql = "UPDATE public.model_login SET login=?, senha=?, nome=?, email=? WHERE id = " + objeto.getId() + "";

			PreparedStatement preparedSql = connection.prepareStatement(sql);
			
			preparedSql.setString(1, objeto.getLogin());
			preparedSql.setString(2, objeto.getSenha());
			preparedSql.setString(3, objeto.getNome());
			preparedSql.setString(4, objeto.getEmail());
			
			preparedSql.executeUpdate();
			
			connection.commit();		
		}
		
		return this.consultarUsurio(objeto.getLogin(), userLogado);
	}
	
	public List<ModelLogin> consultaUsuarioList(Long userLogado) throws SQLException{
		
		List<ModelLogin> retorno = new ArrayList<ModelLogin>();
		
		String sql = "SELECT * FROM MODEL_LOGIN WHERE USERADMIN IS FALSE AND USUARIO_ID = " + userLogado;
		PreparedStatement statement = connection.prepareStatement(sql);
		
		ResultSet resultado =  statement.executeQuery();
		
		while(resultado.next()) {
			ModelLogin modelLogin = new ModelLogin();
			modelLogin.setEmail(resultado.getString("email"));
			modelLogin.setId(resultado.getLong("id"));
			modelLogin.setLogin(resultado.getString("login"));
			modelLogin.setNome(resultado.getString("nome"));
			
			retorno.add(modelLogin);
		}
		
		return retorno;
		
		
	}
	
	public List<ModelLogin> consultaUsuarioList(String nome, Long userLogado) throws SQLException {
		
		List<ModelLogin> retorno = new ArrayList<ModelLogin>();
		
		String sql = "SELECT * FROM MODEL_LOGIN WHERE UPPER(NOME) LIKE UPPER(?) AND USERADMIN IS FALSE AND USUARIO_ID = ?";		
		PreparedStatement statement =  connection.prepareStatement(sql);
		statement.setString(1, "%" + nome + "%");
		statement.setLong(2, userLogado);
		
		ResultSet resultado = statement.executeQuery();
		
		while(resultado.next()) {
			ModelLogin modelLogin = new ModelLogin();
			modelLogin.setEmail(resultado.getString("email"));
			modelLogin.setId(resultado.getLong("id"));
			modelLogin.setLogin(resultado.getString("login"));
			modelLogin.setNome(resultado.getString("nome"));
			//modelLogin.setSenha(resultado.getString("senha"));
			
			retorno.add(modelLogin);
		}
		
		
		
		return retorno;
		
	}

	public ModelLogin consultarUsurio(String login, Long userLogado) throws SQLException {
		ModelLogin modelLogin = new ModelLogin();

		String sql = "SELECT * FROM model_login where UPPER(LOGIN) =  UPPER('" + login + "') AND USERADMIN IS FALSE AND USUARIO_ID = " + userLogado;
		PreparedStatement statement = connection.prepareStatement(sql);

		ResultSet resultSet = statement.executeQuery();

		while (resultSet.next()) {/* Se tem resultado */

			modelLogin.setId(resultSet.getLong("id"));
			modelLogin.setEmail(resultSet.getString("email"));
			modelLogin.setLogin(resultSet.getString("login"));
			modelLogin.setSenha(resultSet.getString("senha"));
			modelLogin.setNome(resultSet.getString("nome"));
		}

		return modelLogin;

	}
	
	public ModelLogin consultarUsurioLogado(String login) throws SQLException {
		ModelLogin modelLogin = new ModelLogin();

		String sql = "SELECT * FROM model_login where UPPER(LOGIN) =  UPPER('" + login + "')";
		PreparedStatement statement = connection.prepareStatement(sql);

		ResultSet resultSet = statement.executeQuery();

		while (resultSet.next()) {/* Se tem resultado */

			modelLogin.setId(resultSet.getLong("id"));
			modelLogin.setEmail(resultSet.getString("email"));
			modelLogin.setLogin(resultSet.getString("login"));
			modelLogin.setSenha(resultSet.getString("senha"));
			modelLogin.setNome(resultSet.getString("nome"));
			modelLogin.setUseradmin(resultSet.getBoolean("useradmin") );
		
		}

		return modelLogin;

	}
	
	public ModelLogin consultarUsuario(String login) throws SQLException {
		ModelLogin modelLogin = new ModelLogin();
		
		String sql = "SELECT * FROM model_login where UPPER(LOGIN) = UPPER('" + login + "') AND USERADMIN IS FALSE";
		PreparedStatement statement = connection.prepareStatement(sql);
		
		ResultSet resultSet = statement.executeQuery();
		
		while (resultSet.next()) {
			modelLogin.setId(resultSet.getLong("id"));
			modelLogin.setEmail(resultSet.getString("email"));
			modelLogin.setLogin(resultSet.getString("login"));
			modelLogin.setSenha(resultSet.getString("senha"));
			modelLogin.setNome(resultSet.getString("nome"));
			modelLogin.setUseradmin(resultSet.getBoolean("useradmin"));
			
		}
		
		return modelLogin;
	}
	
	
	public ModelLogin consultarUsuarioId(String id, Long userLogado) throws SQLException {
		ModelLogin modelLogin = new ModelLogin();
		
		String sql = "SELECT * FROM model_login where id = ? AND USERADMIN IS FALSE AND USUARIO_ID = ? ";
		PreparedStatement statement = connection.prepareStatement(sql);
		statement.setLong(1, Long.parseLong( id));
		statement.setLong(2,  userLogado);
		
		ResultSet resultSet =  statement.executeQuery();
		
		while(resultSet.next()) {
			modelLogin.setId(resultSet.getLong("id"));
			modelLogin.setEmail(resultSet.getString("email"));
			modelLogin.setLogin(resultSet.getString("login"));
			modelLogin.setSenha(resultSet.getString("senha"));
			modelLogin.setNome(resultSet.getString("nome"));
		}
		
		return modelLogin;
		
	}

	public boolean validaLogin(String login) throws Exception {
		String sql = "SELECT COUNT(1) > 0 AS EXISTE FROM model_login where UPPER(login) = UPPER('" + login + "')";

		PreparedStatement statement = connection.prepareStatement(sql);

		ResultSet resultado = statement.executeQuery();

		resultado.next(); /* Pra ele entrar nos resultados do sql */
		return resultado.getBoolean("EXISTE");

	}
	
	public void deletarUser(String idUser) throws SQLException {
		
		String sql = "DELETE FROM public.model_login WHERE id = ? AND USERADMIN IS FALSE";
		
		PreparedStatement prepareSql = connection.prepareStatement(sql);
		
		prepareSql.setLong(1, Long.parseLong(idUser));
		
		prepareSql.executeUpdate();
		
		connection.commit();
		
	}

}
