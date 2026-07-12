<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/logo.png">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FutureFlow</title>
    <link rel="icon" href="assets1/images/favicon.png">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Nunito+Sans:wght@700;800;900&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
<%
    if(request.getParameter("logout")!=null)
    {
        session.invalidate();
        out.println("<script>alert('You have been successfully logged out.')</script>");
    }
%>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm fixed-top animate__animated animate__fadeInDown">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center" href="Index.jsp">
                <!-- Ensure logo-bright.png exists or use a text logo -->
                <img src="img/logo-bright.png" alt="FutureFlow Logo" width="180" height="auto" class="me-2 blockchain-glow">
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link active fw-medium" aria-current="page" href="Index.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link fw-medium" href="Signin.jsp">Students</a></li>
                    <li class="nav-item"><a class="nav-link fw-medium" href="owner_signin.jsp">Donors</a></li>
                    <li class="nav-item"><a class="nav-link fw-medium" href="admin_signin.jsp">Institutions</a></li>
                    <li class="nav-item">
                        <a class="nav-link btn btn-gradient-primary text-white rounded-pill px-4 py-2 ms-lg-3 fw-bold shadow-sm" href="#contact">
                            Contact Us
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <!-- End Navbar -->

    <!-- Hero Section -->
    <header class="hero-section bg-light-gradient text-dark-blue d-flex align-items-center">
        <div class="container">
            <div class="row align-items-center g-5">
                <div class="col-lg-7 text-center text-lg-start animate__animated animate__fadeInLeft">
                    <h1 class="display-3 fw-bolder mb-4 text-shadow-bright">
                        Smart Loans, Bright Futures: <br>Powered by <span class="text-gradient-primary">Blockchain</span>
                    </h1>
                    <p class="lead mb-5 fs-5 text-dark-gray">
                        Revolutionizing student funding with secure, transparent, and equitable access to educational loans.
                    </p>
                    <div class="d-grid gap-3 d-sm-flex justify-content-center justify-content-lg-start">
                        <a href="Signin.jsp" class="btn btn-gradient-primary btn-lg rounded-pill px-5 py-3 fw-bold shadow-lg animate__animated animate__zoomIn animate__delay-1s">
                            Apply for Loan <i class="fas fa-arrow-right ms-2"></i>
                        </a>
                        <a href="owner_signin.jsp" class="btn btn-outline-dark btn-lg rounded-pill px-5 py-3 ms-sm-3 fw-bold shadow-sm animate__animated animate__zoomIn animate__delay-1s">
                            Become a Donor <i class="fas fa-hand-holding-dollar ms-2"></i>
                        </a>
                    </div>
                </div>
                <div class="col-lg-5 d-none d-lg-block animate__animated animate__fadeInRight animate__delay-1s">
                    <!-- Ensure this image is high-res and visually appealing -->
                    <img src="img/Index.png" width="980px" height="auto" class="img-fluid floating-element rounded-4 shadow-lg" alt="Blockchain Student Loan Illustration">
                </div>
            </div>
        </div>
    </header>
    <!-- End Hero Section -->

    <!-- Features & Benefits Section -->
    <section id="features" class="py-5 bg-white">
        <div class="container">
            <h2 class="text-center display-5 fw-bolder mb-5 text-dark-blue animate__animated animate__fadeInUp">Why FutureFlow?</h2>
            <div class="row g-4 justify-content-center">
                <div class="col-md-6 col-lg-4 animate__animated animate__fadeInUp animate__delay-0.3s">
                    <div class="feature-card p-4 rounded-4 shadow-hover h-100 text-center">
                        <div class="icon-box bg-gradient-light-blue mb-3">
                            <i class="fas fa-shield-alt fa-2x text-primary-dark"></i>
                        </div>
                        <h4 class="fw-bold mb-3 text-dark-blue">Ultimate Security</h4>
                        <p class="text-dark-gray">Blockchain's robust encryption secures your financial data and identity against fraud.</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4 animate__animated animate__fadeInUp animate__delay-0.5s">
                    <div class="feature-card p-4 rounded-4 shadow-hover h-100 text-center">
                        <div class="icon-box bg-gradient-light-green mb-3">
                            <i class="fas fa-eye fa-2x text-success-dark"></i>
                        </div>
                        <h4 class="fw-bold mb-3 text-dark-blue">Full Transparency</h4>
                        <p class="text-dark-gray">Every transaction is recorded on an immutable ledger, ensuring clarity for students and donors.</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4 animate__animated animate__fadeInUp animate__delay-0.7s">
                    <div class="feature-card p-4 rounded-4 shadow-hover h-100 text-center">
                        <div class="icon-box bg-gradient-light-orange mb-3">
                            <i class="fas fa-lightbulb fa-2x text-warning-dark"></i>
                        </div>
                        <h4 class="fw-bold mb-3 text-dark-blue">Smart & Efficient</h4>
                        <p class="text-dark-gray">Streamlined processes and smart contracts mean faster approvals and lower administrative costs.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- End Features & Benefits Section -->

    <!-- How It Works Section -->
    <section id="how-it-works" class="py-5 bg-light-gradient-alt">
        <div class="container">
            <h2 class="text-center display-5 fw-bolder mb-5 text-dark-blue animate__animated animate__fadeInUp">How It Works: Simple Steps</h2>
            <div class="row align-items-center g-5">
                <div class="col-lg-6 animate__animated animate__fadeInLeft">
                    <!-- Ensure this image is high-res and visually appealing -->
                    <img src="img/about-us.jpg" class="img-fluid rounded-4 shadow-lg" alt="Student Application Process">
                </div>
                <div class="col-lg-6 animate__animated animate__fadeInRight">
                    <h3 class="fw-bold text-gradient-primary mb-3">For Students: Get Funded, Faster</h3>
                    <div class="timeline">
                        <div class="timeline-item animate__animated animate__fadeInUp animate__delay-0.2s">
                            <div class="timeline-icon bg-primary-dark"><i class="fas fa-user-plus text-white"></i></div>
                            <div class="timeline-content">
                                <h5 class="fw-bold text-dark-blue">1. Create Profile & Verify</h5>
                                <p class="text-dark-gray">Sign up securely and complete your identity verification on the blockchain.</p>
                            </div>
                        </div>
                        <div class="timeline-item animate__animated animate__fadeInUp animate__delay-0.4s">
                            <div class="timeline-icon bg-success-dark"><i class="fas fa-file-invoice text-white"></i></div>
                            <div class="timeline-content">
                                <h5 class="fw-bold text-dark-blue">2. Submit Loan Application</h5>
                                <p class="text-dark-gray">Fill out your application, detailing your academic goals and funding needs.</p>
                            </div>
                        </div>
                        <div class="timeline-item animate__animated animate__fadeInUp animate__delay-0.6s">
                            <div class="timeline-icon bg-warning-dark"><i class="fas fa-hand-holding-usd text-white"></i></div>
                            <div class="timeline-content">
                                <h5 class="fw-bold text-dark-blue">3. Receive Funds & Thrive</h5>
                                <p class="text-dark-gray">Get your funds directly via smart contracts, ensuring speed and transparency.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <hr class="my-5 border-primary opacity-25 animate__animated animate__fadeIn animate__delay-1s">

            <div class="row align-items-center flex-row-reverse g-5">
                <div class="col-lg-6 animate__animated animate__fadeInRight">
                    <!-- Ensure this image is high-res and visually appealing -->
                    <img src="img/hero-illustration.png" class="img-fluid rounded-4 shadow-lg" alt="Donor Contribution Process">
                </div>
                <div class="col-lg-6 animate__animated animate__fadeInLeft">
                    <h3 class="fw-bold text-gradient-success mb-3">For Donors: Make an Impact, Transparently</h3>
                    <div class="timeline">
                        <div class="timeline-item animate__animated animate__fadeInUp animate__delay-0.2s">
                            <div class="timeline-icon bg-primary-dark"><i class="fas fa-users text-white"></i></div>
                            <div class="timeline-content">
                                <h5 class="fw-bold text-dark-blue">1. Discover Students & Causes</h5>
                                <p class="text-dark-gray">Explore diverse student profiles and specific educational funding needs.</p>
                            </div>
                        </div>
                        <div class="timeline-item animate__animated animate__fadeInUp animate__delay-0.4s">
                            <div class="timeline-icon bg-success-dark"><i class="fas fa-donate text-white"></i></div>
                            <div class="timeline-content">
                                <h5 class="fw-bold text-dark-blue">2. Contribute Securely</h5>
                                <p class="text-dark-gray">Make direct, auditable contributions using blockchain technology.</p>
                            </div>
                        </div>
                        <div class="timeline-item animate__animated animate__fadeInUp animate__delay-0.6s">
                            <div class="timeline-icon bg-warning-dark"><i class="fas fa-chart-line text-white"></i></div>
                            <div class="timeline-content">
                                <h5 class="fw-bold text-dark-blue">3. Track Your Impact</h5>
                                <p class="text-dark-gray">See exactly where your funds go and the difference you're making in real-time.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- End How It Works Section -->

    <!-- Call to Action Section -->
    <section id="contact" class="call-to-action bg-gradient-primary text-white text-center py-5">
        <div class="container animate__animated animate__fadeInUp">
            <h2 class="display-4 fw-bolder mb-4">Ready to Innovate Education Funding?</h2>
            <p class="lead mb-5 fs-5 text-white-75">Join our platform today and be a part of the future of student loans.</p>
            <div class="d-grid gap-3 d-sm-flex justify-content-center">
                <a href="Signin.jsp" class="btn btn-light btn-lg rounded-pill px-5 py-3 fw-bold shadow-lg animate__animated animate__pulse animate__infinite animate__slow">
                    Get Started as a Student <i class="fas fa-graduation-cap ms-2"></i>
                </a>
                <a href="owner_signin.jsp" class="btn btn-outline-light btn-lg rounded-pill px-5 py-3 ms-sm-3 fw-bold shadow-lg animate__animated animate__pulse animate__infinite animate__slow animate__delay-1s">
                    Become a FutureFlow Donor <i class="fas fa-heart ms-2"></i>
                </a>
            </div>
        </div>
    </section>
    <!-- End Call to Action Section -->

    <!-- Footer -->
    <footer class="footer bg-dark-blue text-white-50 py-5">
        <div class="container">
            <div class="row g-4">
                <div class="col-md-4 text-center text-md-start">
                    <h5 class="text-white mb-3 fw-bold">FutureFlow</h5>
                    <p>Building a transparent and accessible future for student loan funding, one block at a time.</p>
                </div>
                <div class="col-md-4 text-center">
                    <h5 class="text-white mb-3 fw-bold">Quick Links</h5>
                    <ul class="list-unstyled">
                        <li><a href="Index.jsp" class="text-white-50 text-decoration-none">Home</a></li>
                        <li><a href="Signin.jsp" class="text-white-50 text-decoration-none">Students</a></li>
                        <li><a href="owner_signin.jsp" class="text-white-50 text-decoration-none">Donors</a></li>
                        <li><a href="admin_signin.jsp" class="text-white-50 text-decoration-none">Institutions</a></li>
                    </ul>
                </div>
                <div class="col-md-4 text-center text-md-end">
                    <h5 class="text-white mb-3 fw-bold">Connect With Us</h5>
                    <div class="social-icons">
                        <a href="#" class="text-white mx-2 fs-4"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="text-white mx-2 fs-4"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="text-white mx-2 fs-4"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#" class="fab fa-instagram mx-2 fs-4"></i></a>
                    </div>
                </div>
            </div>
            <hr class="my-4 border-light opacity-25">
            <div class="text-center">
                <p class="mb-0">&copy; 2025-26 FutureFlow. All rights reserved. <br> Powered by Decentralized Ledger Technology.</p>
            </div>
        </div>
    </footer>
    <!-- End Footer -->

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Custom JS (if any interactive elements like scroll animations) -->
    <script src="assets1/js/custom.js"></script>
</body>
</html>

