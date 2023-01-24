package servlets;

import java.io.Serializable;
import java.sql.SQLException;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import dao.DAOUsuarioRepository;

public class ServletGenericUtil extends HttpServlet implements Serializable {

	private static final long serialVersionUID = 1L;

	
	private DAOUsuarioRepository daoUsuarioRepository = new DAOUsuarioRepository();
	
	
	public Long getUserLogado(HttpServletRequest request) throws SQLException {
		
		HttpSession session = request.getSession();
		
		String usuarioLogado = (String) session.getAttribute("usuario");
		
		return daoUsuarioRepository.consultarUsurioLogado(usuarioLogado).getId();
	}
	
	
}
