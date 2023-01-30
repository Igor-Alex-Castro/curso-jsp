package servlets;

import java.io.IOException;

import java.util.List;

import org.apache.commons.compress.utils.IOUtils;

import com.fasterxml.jackson.databind.ObjectMapper;

import dao.DAOUsuarioRepository;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.ModelLogin;

@MultipartConfig
@WebServlet(urlPatterns = { "/ServletUsuarioController" })
public class ServletUsuarioController extends ServletGenericUtil {

	private static final long serialVersionUID = 1L;

	private DAOUsuarioRepository daoUsuarioRepository = new DAOUsuarioRepository();

	public ServletUsuarioController() {

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String acao = request.getParameter("acao");
			System.out.println("deletar");

			if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("deletar")) {
				String idUser = request.getParameter("id");
				daoUsuarioRepository.deletarUser(idUser);

				List<ModelLogin> modelLogins = daoUsuarioRepository.consultaUsuarioList(super.getUserLogado(request));
				request.setAttribute("modelLogins", modelLogins);

				request.setAttribute("msg", "Excluido com sucesso");

				request.getRequestDispatcher("/principal/usuario.jsp").forward(request, response);

			} else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("deletarAjax")) {
				String idUser = request.getParameter("id");

				daoUsuarioRepository.deletarUser(idUser);

				response.getWriter().write("Excluido com sucesso");

				System.out.println("delete com ajax");
			} else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("buscarUserAjax")) {
				String nomeBusca = request.getParameter("nomeBusca");

				System.out.println(nomeBusca);
				List<ModelLogin> dadosJsonUser = daoUsuarioRepository.consultaUsuarioList(nomeBusca,
						super.getUserLogado(request));

				ObjectMapper mapper = new ObjectMapper();

				String json = mapper.writeValueAsString(dadosJsonUser);

				System.out.println(json);
				response.getWriter().write(json);

			} else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("buscarEditar")) {

				String id = request.getParameter("id");
				ModelLogin modelLogin = daoUsuarioRepository.consultarUsuarioId(id, super.getUserLogado(request));

				List<ModelLogin> modelLogins = daoUsuarioRepository.consultaUsuarioList(super.getUserLogado(request));
				request.setAttribute("modelLogins", modelLogins);

				request.setAttribute("msg", "Usuário em edição");
				request.setAttribute("modelLogin", modelLogin);
				request.getRequestDispatcher("/principal/usuario.jsp").forward(request, response);

			} else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("listarUser")) {
				List<ModelLogin> modelLogins = daoUsuarioRepository.consultaUsuarioList(super.getUserLogado(request));

				request.setAttribute("msg", "Usuários carregados");
				request.setAttribute("modelLogins", modelLogins);
				request.getRequestDispatcher("/principal/usuario.jsp").forward(request, response);

			} else {

				List<ModelLogin> modelLogins = daoUsuarioRepository.consultaUsuarioList(super.getUserLogado(request));
				request.setAttribute("modelLogins", modelLogins);

				request.getRequestDispatcher("/principal/usuario.jsp").forward(request, response);
			}

		} catch (Exception e) {
			e.printStackTrace();
			RequestDispatcher redirecionar = request.getRequestDispatcher("erro.jsp");
			request.setAttribute("msg", e.getMessage());
			redirecionar.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {

			String msg = "Operação realizada com sucesso";

			String id = request.getParameter("id");
			String nome = request.getParameter("nome");
			String email = request.getParameter("email");
			String login = request.getParameter("login");
			String senha = request.getParameter("senha");
			String perfil = request.getParameter("perfil");
			String sexo = request.getParameter("sexo");
			// String fileFoto = request.getParameter("fileFoto");
			
			
			

			ModelLogin modelLogin = new ModelLogin();
			modelLogin.setId(id != null && !id.isEmpty() ? Long.parseLong(id) : null);
			modelLogin.setNome(nome);
			modelLogin.setEmail(email);
			modelLogin.setLogin(login);
			modelLogin.setSenha(senha);
			modelLogin.setPerfil(perfil);
			modelLogin.setSexo(sexo);
			
			
			String msgFoto = "";
			Part part = request.getPart("fileFoto");
			/*
			System.out.println(part.toString().isEmpty());
			System.out.println(part.getName());
			System.out.println(part.getSubmittedFileName());
			System.out.println(part.getSubmittedFileName().toString().isEmpty());
			*/
			
			if(part.getSubmittedFileName().toString().isEmpty()) {
				 msgFoto = "porem foto não enviada";
			}else {
				byte[] foto = IOUtils.toByteArray(part.getInputStream());
				new org.apache.commons.codec.binary.Base64();
				String imagemBase64 = "data:image/" + part.getContentType().split("\\/")[1] + ";base64;" + org.apache.commons.codec.binary.Base64.encodeBase64String(foto);
				System.out.println(imagemBase64);
				
				modelLogin.setFotoUser(imagemBase64);
				modelLogin.setEstensaoFotoUser(part.getContentType().split("\\/")[1]);
			}
			

			if (daoUsuarioRepository.validaLogin(modelLogin.getLogin()) && modelLogin.getId() == null) {
				msg = "Já existe usuário com o mesmo login, informe outro login";
			} else {
				if (modelLogin.isNovo()) {
					msg = "Gravado com sucesso!";
				} else {
					msg = "Atualizado com suceso!";
				}
				modelLogin = daoUsuarioRepository.gravarUsuario(modelLogin, super.getUserLogado(request));

			}

			List<ModelLogin> modelLogins = daoUsuarioRepository.consultaUsuarioList(super.getUserLogado(request));
			request.setAttribute("modelLogins", modelLogins);
			request.setAttribute("msgFoto", msgFoto);

			request.setAttribute("msg", msg);

			request.setAttribute("modelLogin", modelLogin);

			request.getRequestDispatcher("/principal/usuario.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			RequestDispatcher redirecionar = request.getRequestDispatcher("erro.jsp");
			request.setAttribute("msg", e.getMessage());
			redirecionar.forward(request, response);

		}

	}

}
