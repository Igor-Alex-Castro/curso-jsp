package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import connection.SingleConnectionBanco;
import model.ModelLogin;

public class DAOUsuarioRepository {

	private Connection connection;

	public DAOUsuarioRepository() {
		connection = SingleConnectionBanco.getConnection();
	}

	public ModelLogin gravarUsuario(ModelLogin objeto) throws SQLException {

		if (objeto.isNovo()) {/*Grava um novo*/
			String sql = "INSERT INTO public.model_login (login, senha, nome, email) VALUES (?, ?, ?, ?);";

			PreparedStatement preparedSql = connection.prepareStatement(sql);

			preparedSql.setString(1, objeto.getLogin());
			preparedSql.setString(2, objeto.getSenha());
			preparedSql.setString(3, objeto.getNome());
			preparedSql.setString(4, objeto.getEmail());

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
		
		return this.consultarUsurio(objeto.getLogin());
	}

	public ModelLogin consultarUsurio(String login) throws SQLException {
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

}
