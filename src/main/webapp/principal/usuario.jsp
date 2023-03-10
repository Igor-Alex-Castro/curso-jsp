<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@page import="model.ModelLogin"%>



<!DOCTYPE html>
<html lang="en">

<jsp:include page="head-main.jsp"></jsp:include>
<body>
	<!-- Pre-loader start -->
	<jsp:include page="theme-loader.jsp"></jsp:include>
	<!-- Pre-loader end -->
	<div id="pcoded" class="pcoded">
		<div class="pcoded-overlay-box"></div>
		<div class="pcoded-container navbar-wrapper">

			<jsp:include page="navbar.jsp"></jsp:include>
			<div class="pcoded-main-container">
				<div class="pcoded-wrapper">

					<jsp:include page="navbar-main-menu.jsp"></jsp:include>
					<div class="pcoded-content">
						<!-- Page-header start -->
						<jsp:include page="page-header.jsp"></jsp:include>
						<!-- Page-header end -->
						<div class="pcoded-inner-content">
							<!-- Main-body start -->
							<div class="main-body">
								<div class="page-wrapper">
									<div class="row">

										<div class="col-sm-12">
											<!-- Basic Form Inputs card start -->
											<div class="card">
												<div class="card-block">
													<h4 class="sub-title">Cad. Usu?rio</h4>
													<div class="page-body">



														<form class="form-material" enctype="multipart/form-data"
															action="<%=request.getContextPath()%>/ServletUsuarioController"
															method="post" id="formUser" name="formUser">
															<input type="hidden" name="acao" id="acao" value="">

															<div class="form-group form-default form-static-label">
																<input type="text" name="id" id="id" readonly="readonly"
																	value="${modelLogin.id}" class="form-control">
																<span class="form-bar"></span> <label
																	class="float-label" style="color: black;">ID:</label>
															</div>
															<div class="form-group form-default input-group mb-4">
																<div class="input-group-prepend">
																	<c:if
																		test="${modelLogin.fotoUser != '' && modelLogin.fotoUser != null}">
																		<a
																			href="<%=request.getContextPath()%>/ServletUsuarioController?acao=dowmloadFoto&id=${modelLogin.id}">
																			<img alt="Imagem user" id="fotoembase64"
																			src="${modelLogin.fotoUser}" width="70px">
																		</a>
																	</c:if>
																	<c:if
																		test="${modelLogin.fotoUser == '' || modelLogin.fotoUser == null }">
																		<img alt="Imagem user" id="fotoembase64"
																			src="assets\images\avatar-user.jpg" width="70px">
																	</c:if>
																</div>
																<input type="file" id="fileFoto" name="fileFoto"
																	accept="image/*"
																	onchange="visualizarImg('fotoembase64', 'fileFoto');"
																	class="form-control-file"
																	style="margin-top: 15px; margin-left: 5px">
															</div>
															<div class="form-group form-default form-static-label">
																<input type="text" name="nome" id="nome"
																	required="required" class="form-control"
																	value="${modelLogin.nome}"> <span
																	class="form-bar"></span> <label class="float-label"
																	style="color: black;">Nome:</label>
															</div>

															<div class="form-group form-default form-static-label">
																<input type="email" name="email" id="email"
																	autocomplete="off" required="required"
																	class="form-control" value="${modelLogin.email}">
																<span class="form-bar"></span> <label
																	class="float-label" style="color: black;">Email:</label>
															</div>
															<div class="form-group form-default form-static-label">
																<select class="form-control"
																	aria-label="Default select example" name="perfil">
																	<option disabled="disabled">[Selecione o
																		perfil]</option>

																	<option value="ADMIN"<%ModelLogin modelLogin = (ModelLogin) request.getAttribute("modelLogin");
if (modelLogin != null && modelLogin.getPerfil().equals("ADMIN")) {
	out.print(" ");
	out.print("selected=\"selected\"");
	out.print(" ");
}%>">Admin</option>

																	<option value="SECRETARIO"
																		<%modelLogin = (ModelLogin) request.getAttribute("modelLogin");
if (modelLogin != null && modelLogin.getPerfil().equals("SECRETARIO")) {
	out.print(" ");
	out.print("selected=\"selected\"");
	out.print(" ");
}%>>Secret?rio</option>

																	<option value="AUXILIAR"
																		<%modelLogin = (ModelLogin) request.getAttribute("modelLogin");
if (modelLogin != null && modelLogin.getPerfil().equals("AUXILIAR")) {
	out.print(" ");
	out.print("selected=\"selected\"");
	out.print(" ");
}%>>Auxiliar</option>
																</select> <span class="form-bar"></span> <label
																	class="float-label">Perfil:</label>
															</div>
															
															<div class="form-group form-default form-static-label">
																<input onblur="pesquisaCep();" type="text" name="cep" id="cep"
																	required="required" class="form-control"
																	value="${modelLogin.cep}"> <span
																	class="form-bar"></span> <label class="float-label"
																	style="color: black;">Cep:</label>
															</div>
															
															<div class="form-group form-default form-static-label">
																<input type="text" name="logradouro" id="logradouro"
																	required="required" class="form-control"
																	value="${modelLogin.logradouro}"> <span
																	class="form-bar"></span> <label class="float-label"
																	style="color: black;">Logradouro:</label>
															</div>
															
															<div class="form-group form-default form-static-label">
																<input type="text" name="bairro" id="bairro"
																	required="required" class="form-control"
																	value="${modelLogin.bairro}"> <span
																	class="form-bar"></span> <label class="float-label"
																	style="color: black;">Bairro:</label>
															</div>
															<div class="form-group form-default form-static-label">
																<input type="text" name="localidade" id="localidade"
																	required="required" class="form-control"
																	value="${modelLogin.localidade}"> <span
																	class="form-bar"></span> <label class="float-label"
																	style="color: black;">Localidade:</label>
															</div>
															
															<div class="form-group form-default form-static-label">
																<input type="text" name="uf" id="uf"
																	required="required" class="form-control"
																	value="${modelLogin.uf}"> <span
																	class="form-bar"></span> <label class="float-label"
																	style="color: black;">Estado:</label>
															</div>
																<div class="form-group form-default form-static-label">
																<input type="text" name="numero" id="numero"
																	required="required" class="form-control"
																	value="${modelLogin.numero}"> <span
																	class="form-bar"></span> <label class="float-label"
																	style="color: black;">Numero:</label>
															</div>
															
															<div class="form-group form-default form-static-label">
																<input type="text" name="login" id="login"
																	required="required" class="form-control"
																	value="${modelLogin.login}"> <span
																	class="form-bar"></span> <label class="float-label"
																	style="color: black;">Login:</label>
															</div>
															<div class="form-group form-default form-static-label">
																<input type="password" name="senha" id="senha"
																	autocomplete="off" required="required"
																	class="form-control" value="${modelLogin.senha}">
																<span class="form-bar"></span> <label
																	class="float-label" style="color: black;">Password:</label>
															</div>
															<div class="form-group form-default form-static-label">
																<input type="radio" name="sexo" checked="checked"
																	value="MASCULINO"
																	<%modelLogin = (ModelLogin) request.getAttribute("modelLogin");

if (modelLogin != null && modelLogin.getSexo().equals("MASCULINO")) {
	out.print("");
	out.print("checked=\"checked\"");
	out.print("");
}%>>Masculino</>

																<input type="radio" name="sexo" value="FEMININO"
																	<%modelLogin = (ModelLogin) request.getAttribute("modelLogin");

if (modelLogin != null && modelLogin.getSexo().equals("FEMININO")) {
	out.print("");
	out.print("checked=\"checked\"");
	out.print("");
}%>>Feminino</>
															</div>

															<button type="button"
																class="btn btn-primary waves-effect waves-light"
																onclick="limparForm();">Novo</button>
															<button class="btn btn-success waves-effect waves-light">Salvar</button>
															<button type="button"
																class="btn btn-info waves-effect waves-light"
																onclick=" criarDeleteComAjax();">Excluir</button>
															<button type="button" class="btn btn-secondaey"
																data-toggle="modal" data-target="#exampleModalUsuario">
																Pesquisar</button>

														</form>


													</div>
												</div>
											</div>
										</div>
									</div>
									<span id="msg">${msg}</span>

									<div style="height: 300px; overflow: scroll;">
										<table class="table" id="tabelaresultadosview">
											<thead>
												<tr>
													<th scope="col">ID</th>
													<th scope="col">Nome</th>
													<th scope="col">Ver</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach items='${modelLogins}' var='ml'>
													<tr>
														<td><c:out value="${ml.id}"></c:out></td>
														<td><c:out value="${ml.nome}"></c:out></td>
														<td><a class="btn btn-success"
															href="<%= request.getContextPath() %>/ServletUsuarioController?acao=buscarEditar&id=${ml.id}">Ver</a></td>
													</tr>
												</c:forEach>
											</tbody>
										</table>

									</div>
									
									<nav aria-label="Page navigation example">
  						<ul class="pagination">
  							<%
  								int totalPagina = (int) request.getAttribute("totalPagina");
  								for(int p = 0; p < totalPagina; p++ ){
  									String  url = request.getContextPath() + "/ServletUsuarioController?acao=paginar&pagina="+ (p * 5);
  									out.print("<li class=\"page-item\"><a class=\"page-link\" href=\""+ url +"\">"+(p +1)+"</a></li>");
  								}
  							%>
   						 		
 						 </ul>
					</nav>

									<!-- Page-body end -->
								</div>
								<div id="styleSelector"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Required Jquery -->
	<jsp:include page="javascript-file.jsp"></jsp:include>


	<!-- Modal -->
	<div class="modal fade" id="exampleModalUsuario" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Pesquisa de
						usuario</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="input-group mb-3">
						<input type="text" class="form-control" id="nomeBusca"
							placeholder="Nome" aria-label="Nome"
							aria-describedby="basic-addon2">
						<div class="input-group-append">
							<button class="btn btn-success" type="button"
								onclick="buscarUsuario();">Buscar</button>
						</div>
					</div>
					<div style="height: 300px; overflow: scroll;">
						<table class="table" id="tabelaresultados">
							<thead>
								<tr>
									<th scope="col">ID</th>
									<th scope="col">Nome</th>
									<th scope="col">Ver</th>
								</tr>
							</thead>
							<tbody>

							</tbody>
						</table>

					</div>
			
					
					<span id="totalresultados"></span>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Fechar</button>

				</div>
			</div>
		</div>
	</div>


	<script type="text/javascript">
	
	function pesquisaCep() {
			var cep = $("#cep").val();

			$.getJSON("https://viacep.com.br/ws/" + cep + "/json/?callback=?",
					function(dados) {

						if (!("erro" in dados)) {
							//Atualiza os campos com os valores da consulta.
							$("#cep").val(dados.cep);
							$("#logradouro").val(dados.logradouro);
							$("#bairro").val(dados.bairro);
							$("#localidade").val(dados.localidade);
							$("#uf").val(dados.uf);

						}

					});

		}
	

		function buscarUsuario() {
			var nomeBusca = document.getElementById('nomeBusca').value;

			if (nomeBusca != null && nomeBusca != '' && nomeBusca.trim() != '') { /*Validando que tem que valor para buscar no banco*/
				var urlAction = document.getElementById('formUser').action;

				$
						.ajax(
								{

									metho : "get",
									url : urlAction,
									data : "nomeBusca=" + nomeBusca
											+ "&acao=buscarUserAjax",
									success : function(response) {

										var json = JSON.parse(response);

										$('tabelaresultados > tbody > tr')
												.remove();

										for (var p = 0; p < json.length; p++) {
											$('#tabelaresultados > tbody')
													.append(
															'<tr><td>'
																	+ json[p].id
																	+ '</td><td>'
																	+ json[p].nome
																	+ '</td><td><button type="button" onclick="verEditar('
																	+ json[p].id
																	+ ');" class="btn btn-info">Ver</button></td> </tr>');
										}

										document
												.getElementById('totalresultados').textContent = 'Resultados: '
												+ json.length;

									}

								}).fail(
								function(xhr, status, errorThrown) {
									alert('Erro ao buscar usu?rio por nome:'
											+ xhr.responseText);
								});
			}
		}

		function verEditar(id) {
			var urlAction = document.getElementById('formUser').action;

			window.location.href = urlAction + '?acao=buscarEditar&id=' + id;
		}

		function criarDeleteComAjax() {
			if (confirm('Deseja realmente excluir os dados?')) {
				var urlAction = document.getElementById('formUser').action;
				var idUser = document.getElementById('id').value;

				$.ajax({

					metho : "get",
					url : urlAction,
					data : "id=" + idUser + "&acao=deletarAjax",
					success : function(response) {
						limparForm();
						document.getElementById('msg').textContent = response;
					}

				}).fail(
						function(xhr, status, errorThrown) {
							alert('Erro ao deletar usu?rio por id:'
									+ xhr.responseText);
						});

			}
		}

		function limparForm() {

			//document.getElementById("formUser").reset;

			var elements = document.getElementById("formUser").elements; //retorna os elementos dentro do html

			for (p = 0; p < elements.length; p++) {
				elements[p].value = '';
			}
		}

		function criarDelete() {
			if (confirm('Deseja realmente excluir os dados?')) {
				document.getElementById("formUser").method = 'get';
				document.getElementById("acao").value = 'deletar';
				document.getElementById("formUser").submit();
			}

		}

		function visualizarImg(fotoembase64, fileFoto) {

			var preview = document.getElementById(fotoembase64);// campo IMG html
			var fileUser = document.getElementById(fileFoto).files[0];
			var reader = new FileReader();

			reader.onloadend = function() {
				preview.src = reader.result; // carrega a foto na tela
			}

			if (fileUser) {
				reader.readAsDataURL(fileUser);/*Preview da imagem*/
			} else {
				preview.src = '';
			}

		}
	</script>
</body>

</html>
