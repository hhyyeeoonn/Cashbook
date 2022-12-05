<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>insertLoginForm</title>

	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Custom fonts for this template-->
    <link href="./Resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
    <link href="./Resources/css/sb-admin-2.min.css" rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="./Resources/css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body class="bg-gradient-primary">

    <div class="container">

        <!-- Outer Row -->
        <div class="row justify-content-center">
        	
            <div class="col-xl-10 col-lg-12 col-md-9">

                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body -->
                        <div class="row">
                            <div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
                            <div class="col-lg-6">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-4">Hello, there!</h1>
                                    </div>
                                    <%
                                    	if(request.getParameter("msg") != null) {
                                    %>
                             				<div class="text-center">
                                    			<div class="alert alert-danger alert-dismissible">
  													<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
  													<small>빈칸에 내용을 입력하세요</small>
												</div>
											</div>
                                    <%
                                    	} else if(request.getParameter("idMsg") != null) {
                                    %>
                                    		<div class="text-center">
                                    			<div class="alert alert-danger alert-dismissible">
  													<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
  													<small>사용할 수 없는 아이디입니다</small>
												</div>
											</div>	
                                    <%
                                    	}
                                    %>
                                    
                                    <form class="user" action="<%=request.getContextPath()%>/insertLoginAction.jsp" method="post">
                                        <div class="form-group">
                                            <input type="text" class="form-control form-control-user"
                                                name="id" aria-describedby="IdHelp"
                                                placeholder="User ID">
                                        </div>  
                                         <div class="form-group">
                                            <input type="text" class="form-control form-control-user"
                                                name="name" 
                                                placeholder="User Name">
                                        </div>                                                                              
                                        <div class="form-group">
                                            <input type="password" class="form-control form-control-user"
                                                name="pw" placeholder="Password">
                                        </div>
                                       <!--  
                                        <div class="form-group">
                                            <div class="custom-control custom-checkbox small">
                                                <input type="checkbox" class="custom-control-input" id="customCheck">
                                                <label class="custom-control-label" for="customCheck">Remember
                                                    Me</label>
                                            </div>
                                        </div>
                                        -->
                                        <button type="submit" class="btn btn-primary btn-user btn-block">
                                            sign up
                                        </button>
                                    </form>
                                    <hr>
                                    <div class="text-center">
                                        <a class="small" href="<%=request.getContextPath()%>/loginForm.jsp">이미 회원이신가요?</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>

</body>
</html>