<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EduChain | Blockchain Crowdsourcing Loan Platform</title>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/logo.png">
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            color: #333;
        }
        
        /* Navbar Styling */
        /* .navbar {
            background: rgba(255, 255, 255, 0.95);
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .navbar-brand {
            font-weight: 700;
            color: #0d6efd !important;
        } */
        
	    /* Navbar Container */
	    .navbar-custom {
	        background: rgba(255, 255, 255, 0.95);
	        backdrop-filter: blur(10px); /* Modern blur effect */
	        padding: 15px 0;
	        border-bottom: 1px solid rgba(0,0,0,0.05);
	        transition: all 0.3s ease;
	    }
	
	    /* Logo Styling */
	    .logo-icon {
	        background: #0d6efd;
	        color: white;
	        width: 35px;
	        height: 35px;
	        display: flex;
	        align-items: center;
	        justify-content: center;
	        border-radius: 8px;
	        font-size: 18px;
	    }
	    .brand-text {
	        font-size: 24px;
	        font-weight: 800;
	        letter-spacing: -1px;
	        color: #1a1a2e;
	    }
	
	    /* Nav Links */
	    .navbar-nav .nav-link {
	        font-weight: 600;
	        color: #4a5568 !important;
	        padding: 8px 20px !important;
	        font-size: 15px;
	        position: relative;
	    }
	    .navbar-nav .nav-link:hover, .navbar-nav .nav-link.active {
	        color: #0d6efd !important;
	    }
	    /* Simple underline hover effect */
	    .navbar-nav .nav-link::after {
	        content: '';
	        position: absolute;
	        width: 0;
	        height: 2px;
	        bottom: 0;
	        left: 20px;
	        background-color: #0d6efd;
	        transition: width 0.3s;
	    }
	    .navbar-nav .nav-link:hover::after {
	        width: calc(100% - 40px);
	    }
	
	    /* Auth Group Buttons */
	    .btn-login {
	        color: #4a5568;
	        font-weight: 700;
	        font-size: 15px;
	        padding: 10px 20px;
	        transition: 0.3s;
	    }
	    .btn-login:hover {
	        color: #0d6efd;
	    }
	
	    .btn-join {
	        background: linear-gradient(45deg, #0d6efd, #0056b3);
	        color: white !important;
	        font-weight: 700;
	        font-size: 14px;
	        padding: 10px 25px;
	        border-radius: 50px; /* Pill shape */
	        text-transform: uppercase;
	        letter-spacing: 0.5px;
	        transition: transform 0.2s, box-shadow 0.2s;
	    }
	    .btn-join:hover {
	        transform: translateY(-2px);
	        box-shadow: 0 5px 15px rgba(13, 110, 253, 0.3);
	    }
	
	    /* Mobile Responsive Tweak */
	    @media (max-width: 991px) {
	        .navbar-nav { margin: 20px 0; text-align: center; }
	        .auth-group { justify-content: center; flex-direction: column; gap: 10px; }
	        .btn-login { width: 100%; }
	        .btn-join { width: 100%; }
	    }
        
        /* Hero Section */
        .hero {
            background: linear-gradient(rgba(0, 40, 80, 0.8), rgba(0, 40, 80, 0.8)), 
                        url('https://images.unsplash.com/photo-1523240795612-9a054b0db644?ixlib=rb-4.0.3&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            height: 90vh;
            color: white;
            display: flex;
            align-items: center;
            text-align: center;
        }
        
        .hero h1 {
            font-size: 3.5rem;
            font-weight: 700;
            margin-bottom: 20px;
        }
        
        .hero p {
            font-size: 1.2rem;
            margin-bottom: 30px;
            opacity: 0.9;
        }

        /* Feature Cards */
        .feature-card {
            border: none;
            padding: 40px 20px;
            border-radius: 15px;
            transition: transform 0.3s;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            height: 100%;
        }
        .feature-card:hover {
            transform: translateY(-10px);
            background-color: #f8f9ff;
        }
        .icon-box {
            font-size: 3rem;
            color: #0d6efd;
            margin-bottom: 20px;
        }

        /* Blockchain Banner */
        .blockchain-status {
            background: #f0f7ff;
            padding: 20px 0;
            border-bottom: 2px solid #e1e9f5;
        }

        /* Footer */
        footer {
            background: #111;
            color: #fff;
            padding: 50px 0 20px;
        }
        
        .btn-primary {
            padding: 12px 30px;
            border-radius: 30px;
            font-weight: 600;
        }
        .btn-outline-light {
            padding: 12px 30px;
            border-radius: 30px;
            font-weight: 600;
        }
    </style>
</head>
<body>
	<%
	if(request.getParameter("logout")!=null){
		   out.println(" <script>alert(' Logout Successfully ...')</script>"); 
	}
  %>
	<%
	    String error = request.getParameter("error");
	    String msg = request.getParameter("msg");
	    if(error != null) {
	%>
	    <div class="alert alert-danger alert-dismissible fade show m-3" role="alert">
	        <i class="fa fa-exclamation-circle"></i> <%= error %>
	        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
	    </div>
	<% } 
	    if(msg != null) {
	%>
	    <div class="alert alert-success alert-dismissible fade show m-3" role="alert">
	        <i class="fa fa-check-circle"></i> <%= msg %>
	        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
	    </div>
	<% } %>
	
    <!-- Navigation Bar -->
    <!-- <nav class="navbar navbar-expand-lg sticky-top">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">
                <i class="fa-solid fa-link"></i> EduChain
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link active" href="index.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="RegisterLender.jsp">Crowdsourcer</a></li>
                    <li class="nav-item"><a class="nav-link" href="BlockchainExplorer.jsp"><i class="fa-solid fa-link text-primary"></i> Public Ledger</a></li>
                    <li class="nav-item"><a class="nav-link ms-lg-3 btn btn-outline-primary px-4" href="#" data-bs-toggle="modal" data-bs-target="#loginModal">Login</a></li>
                    <li class="nav-item"><a class="nav-link ms-lg-2 btn btn-primary px-4 text-white" href="RegisterStudent.jsp">Join Now</a></li>
                </ul>
            </div>
        </div>
    </nav> -->
    
    <!-- Main Navigation Bar -->
	<nav class="navbar navbar-expand-lg sticky-top navbar-custom">
	    <div class="container">
	        <!-- Logo Section -->
	        <a class="navbar-brand d-flex align-items-center" href="index.jsp">
	            <div class="logo-icon me-2">
	                <i class="fa-solid fa-link"></i>
	            </div>
	            <span class="brand-text">Edu<span class="text-primary">Chain</span></span>
	        </a>
	
	        <!-- Mobile Toggle Button -->
	        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav">
	            <span class="navbar-toggler-icon"></span>
	        </button>
	
	        <!-- Navigation Links -->
	        <div class="collapse navbar-collapse" id="mainNav">
	            <ul class="navbar-nav mx-auto">
	                <li class="nav-item">
	                    <a class="nav-link active" href="index.jsp">Home</a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link" href="RegisterStudent.jsp">Student</a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link" href="RegisterLender.jsp">Crowdsourcer</a>
	                </li>
	                <!-- <li class="nav-item">
	                    <a class="nav-link" href="#how-it-works">How it Works</a>
	                </li> -->
	                <li class="nav-item">
	                    <a class="nav-link" href="BlockchainExplorer.jsp">Public Ledger</a>
	                </li>
	            </ul>
	
	            <!-- Auth Buttons -->
	            <div class="d-flex align-items-center auth-group">
	                <a href="#" class="btn btn-login me-2" data-bs-toggle="modal" data-bs-target="#loginModal">
	                    <i class="fa-solid fa-right-to-bracket me-1"></i> Login
	                </a>
	                <a href="#" class="btn btn-join shadow-sm">
	                    Join Now
	                </a>
	            </div>
	        </div>
	    </div>
	</nav>

    <!-- Hero Section -->
    <header class="hero">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-10">
                    <h1 class="animate__animated animate__fadeInDown">Empowering Education via <span class="text-info">Blockchain</span></h1>
                    <p class="lead">The most transparent, secure, and decentralized crowdsourcing platform to fund higher education in developing nations.</p>
                    <div class="mt-4">
                        <a href="RegisterStudent.jsp?role=student" class="btn btn-primary btn-lg me-3">I Need Funding</a>
                        <a href="RegisterLender.jsp?role=lender" class="btn btn-outline-light btn-lg">I Want to Invest</a>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <!-- Blockchain Identity Bar -->
    <div class="blockchain-status text-center">
        <div class="container">
            <span class="badge bg-success me-2">LIVE</span> 
            <small class="text-muted"><i class="fa-solid fa-cube"></i> Current Block Height: <b>#8421</b> | <i class="fa-solid fa-shield-halved"></i> Consensus: Proof of Integrity</small>
        </div>
    </div>

    <!-- Features Section -->
    <section class="py-5">
        <div class="container text-center py-5">
            <h2 class="fw-bold mb-5">Why Choose EduChain?</h2>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="card feature-card">
                        <div class="icon-box"><i class="fa-solid fa-shield-virus"></i></div>
                        <h4>Immutable Records</h4>
                        <p class="text-muted">Every loan and repayment is recorded on a blockchain ledger, making it impossible to alter or delete data.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card feature-card">
                        <div class="icon-box"><i class="fa-solid fa-users-rays"></i></div>
                        <h4>Crowdsourced Funding</h4>
                        <p class="text-muted">Break the barriers of traditional banks. Borrow small amounts from many global investors at lower rates.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card feature-card">
                        <div class="icon-box"><i class="fa-solid fa-file-signature"></i></div>
                        <h4>Smart Contracts</h4>
                        <p class="text-muted">Automated loan agreements ensure that funds are released and repaid fairly without human bias.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Login Modal -->
	<!-- <div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
	    <div class="modal-dialog modal-dialog-centered">
	        <div class="modal-content border-0 shadow">
	            <div class="modal-header bg-primary text-white">
	                <div class="login-header">
                        <h3 class="fw-bold"><i class="fa-solid fa-link"></i> EduChain</h3>
                        <p class="mb-0">Secure Blockchain Login</p>
                    </div>
	                <button type="button" class="btn-close btn-close-white" data-bs-toggle="modal" aria-label="Close"></button>
	            </div>
	            <div class="modal-body p-4">
	                <form action="LoginServlet" method="post">
	                    <div class="mb-3">
	                        <label class="form-label">Email Address</label>
	                        <div class="input-group">
	                            <span class="input-group-text"><i class="fa fa-envelope text-primary"></i></span>
	                            <input type="email" name="email" class="form-control" placeholder="name@example.com" required>
	                        </div>
	                    </div>
	                    <div class="mb-3">
	                        <label class="form-label">Password</label>
	                        <div class="input-group">
	                            <span class="input-group-text"><i class="fa fa-lock text-primary"></i></span>
	                            <input type="password" name="password" class="form-control" placeholder="Enter password" required>
	                        </div>
	                    </div>
	                    <div class="d-grid">
	                        <button type="submit" class="btn btn-primary btn-lg">Login to EduChain</button>
	                    </div>
	                    <div class="text-center mt-3">
	                        <small>Don't have an account? <a href="RegisterStudent.jsp">Register here</a></small>
	                    </div>
	                </form>
	            </div>
	        </div>
	    </div>
	</div> -->
	
	<!-- Login Modal (Universal for Students & Investors) -->
	<div class="modal fade" id="loginModal" tabindex="-1" aria-hidden="true">
	    <div class="modal-dialog modal-dialog-centered">
	        <div class="modal-content border-0 shadow">
	            <div class="modal-header bg-primary text-white">
	                <div class="login-header">
                        <h3 class="fw-bold"><i class="fa-solid fa-link"></i> EduChain</h3>
                        <p class="mb-0">Secure Platform Login</p>
                    </div>
	                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
	            </div>
	            <div class="modal-body p-4">
	                <form action="LoginServlet" method="post">
	                    <div class="mb-3">
	                        <label class="form-label small fw-bold">Email Address</label>
	                        <div class="input-group">
	                            <span class="input-group-text bg-light border-end-0"><i class="fa fa-envelope text-muted"></i></span>
	                            <input type="email" name="email" class="form-control border-start-0 ps-0" placeholder="member@example.com" required>
	                        </div>
	                    </div>
	                    <div class="mb-4">
	                        <label class="form-label small fw-bold">Access Password</label>
	                        <div class="input-group">
	                            <span class="input-group-text bg-light border-end-0"><i class="fa fa-lock text-muted"></i></span>
	                            <input type="password" name="password" class="form-control border-start-0 ps-0" placeholder="••••••••" required>
	                        </div>
	                    </div>
	                    <div class="d-grid">
	                        <button type="submit" class="btn btn-primary btn-lg rounded-pill shadow-sm">Sign In to Dashboard</button>
	                    </div>
	                </form>
	            </div>
	            <div class="modal-footer border-0 justify-content-center bg-light">
	                <p class="mb-0 small">New to EduChain? <a href="RegisterLender.jsp" class="fw-bold text-decoration-none">Become an Investor</a></p>
	            </div>
	        </div>
	    </div>
	</div>

    <!-- Call to Action Section -->
    <section class="bg-light py-5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <img src="https://images.unsplash.com/photo-1557804506-669a67965ba0?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Student Success" class="img-fluid rounded-4 shadow">
                </div>
                <div class="col-lg-6 ps-lg-5">
                    <h2 class="fw-bold mb-4">Supporting Students in Developing Nations</h2>
                    <p class="text-muted mb-4">We focus on regions where banking access is limited. By using blockchain, we reduce high-interest rates and provide a pathway for talented students to complete their degrees.</p>
                    <ul class="list-unstyled">
                        <li class="mb-2"><i class="fa-solid fa-check text-success me-2"></i> Verified Academic Profiles</li>
                        <li class="mb-2"><i class="fa-solid fa-check text-success me-2"></i> Low Transaction Fees</li>
                        <li class="mb-2"><i class="fa-solid fa-check text-success me-2"></i> Transparent Fund Tracking</li>
                    </ul>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-md-4 mb-4">
                    <h5 class="fw-bold mb-3">EduChain</h5>
                    <p class="text-secondary">Building a decentralized future for global education finance.</p>
                    <div class="social-links">
                        <a href="#" class="text-white me-3"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="text-white me-3"><i class="fab fa-linkedin"></i></a>
                        <a href="#" class="text-white"><i class="fab fa-github"></i></a>
                    </div>
                </div>
                <div class="col-md-2 mb-4">
                    <h6 class="fw-bold">Platform</h6>
                    <ul class="list-unstyled text-secondary">
                        <li><a href="#" class="text-decoration-none text-secondary">Browse Loans</a></li>
                        <li><a href="#" class="text-decoration-none text-secondary">Student Stories</a></li>
                        <li><a href="#" class="text-decoration-none text-secondary">How it works</a></li>
                    </ul>
                </div>
                <div class="col-md-3 mb-4">
                    <h6 class="fw-bold">Resources</h6>
                    <ul class="list-unstyled text-secondary">
                        <li><a href="#" class="text-decoration-none text-secondary">Blockchain Ledger</a></li>
                        <li><a href="#" class="text-decoration-none text-secondary">Privacy Policy</a></li>
                        <li><a href="#" class="text-decoration-none text-secondary">Terms of Service</a></li>
                    </ul>
                </div>
                <div class="col-md-3 mb-4">
                    <h6 class="fw-bold">Contact</h6>
                    <p class="text-secondary">
                        <i class="fa-solid fa-envelope me-2"></i> support@educhain.com<br>
                        <i class="fa-solid fa-location-dot me-2"></i> Tech Park, Innovation Way
                    </p>
                </div>
            </div>
            <hr class="border-secondary">
            <div class="text-center text-secondary small">
                &copy; 2026 EduChain Project. All rights reserved. Developed for Academic Excellence.
            </div>
        </div>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

