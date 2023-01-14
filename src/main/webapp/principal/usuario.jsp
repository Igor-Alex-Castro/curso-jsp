<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
													<h4 class="sub-title">Cad. Usuário</h4>
													<div class="page-body">



														<form class="form-material"
															action="<%=request.getContextPath()%>/ServletUsuarioController"
															method="post" id="formUser">
															<input type="hidden" name="acao" id="acao" value="">

															<div class="form-group form-default form-static-label">
																<input type="text" name="id" id="id" readonly="readonly"
																	value="${modelLogin.id}" class="form-control">
																<span class="form-bar"></span> <label
																	class="float-label" style="color: black;">ID:</label>
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
															<button type="button"
																class="btn btn-primary waves-effect waves-light"
																onclick="limparForm();">Novo</button>
															<button class="btn btn-success waves-effect waves-light">Salvar</button>
															<button type="button"
																class="btn btn-info waves-effect waves-light"
																onclick="criarDelete();">Excluir</button>

														</form>


													</div>
												</div>
											</div>
										</div>
									</div>
									<span>${msg}</span>


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

	<script type="text/javascript">
	
		function limparForm() {

			//document.getElementById("formUser").reset;

			var elements = document.getElementById("formUser").elements; //retorna os elementos dentro do html

			for (p = 0; p < elements.length; p++) {
				elements[p].value = '';
			}
		}
		
		function criarDelete() {
			document.getElementById("formUser").method = 'get';

			document.getElementBydId("acao").value = 'deletar';
			document.getElementById("formUser").submit();
		}

	</script>
</body>

</html>
