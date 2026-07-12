<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/logo.png">
    <title>Login | EduChain</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(rgba(0, 43, 92, 0.8), rgba(0, 43, 92, 0.8)), 
                        url('${pageContext.request.contextPath}/images/Bk1.png');
            background-size: cover;
            height: 100vh;
            display: flex;
            align-items: center;
        }
        .login-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            overflow: hidden;
        }
        .login-header {
            background: #0d6efd;
            color: white;
            padding: 30px;
            text-align: center;
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="card login-card">
                    <div class="login-header">
                        <h3 class="fw-bold"><i class="fa-solid fa-link"></i> EduChain</h3>
                        <p class="mb-0">Secure Blockchain Login</p>
                    </div>
                    <div class="card-body p-4">
                        
                        <!-- Show Error Message if Login Fails -->
                        <% if(request.getParameter("error") != null) { %>
                            <div class="alert alert-danger small p-2">
                                <i class="fa fa-times-circle"></i> <%= request.getParameter("error") %>
                            </div>
                        <% } %>

                        <form action="LoginServlet" method="post">
                            <div class="mb-3">
                                <label class="form-label">Email Address</label>
                                <input type="email" name="email" class="form-control" placeholder="enter your email" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Password</label>
                                <input type="password" name="password" class="form-control" placeholder="••••••••" required>
                            </div>
                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary btn-lg">Sign In</button>
                            </div>
                        </form>
                    </div>
                    <div class="card-footer bg-white border-0 text-center pb-4">
                        <p class="mb-0 small text-muted">New to the platform?</p>
                        <a href="RegisterStudent.jsp" class="text-decoration-none">Create a Student Account</a>
                    </div>
                </div>
                <div class="text-center mt-3">
                    <a href="index.jsp" class="text-white text-decoration-none small"><i class="fa fa-arrow-left"></i> Back to Home</a>
                </div>
            </div>
        </div>
    </div>

</body>
</html>

