<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/logo.png">
    <title>Investor Registration | EduChain</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(rgba(0, 20, 50, 0.85), rgba(0, 20, 50, 0.85)), 
                        url('${pageContext.request.contextPath}/images/Bk2.png');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            min-height: 100vh;
            display: flex;
            align-items: center;
            font-family: 'Poppins', sans-serif;
        }
        .investor-card {
            border: none;
            border-radius: 20px;
            background: rgba(255, 255, 255, 0.98);
            box-shadow: 0 15px 40px rgba(0,0,0,0.5);
            overflow: hidden;
        }
        .side-info {
            background: #0d6efd;
            color: white;
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .form-section { padding: 40px; }
        .form-control { border-radius: 8px; padding: 12px; border: 1px solid #ddd; }
        .btn-investor { background: #0d6efd; color: white; padding: 12px; border-radius: 30px; font-weight: 600; }
    </style>
</head>
<body>

    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="card investor-card">
                    <div class="row g-0">
                        <!-- Left Sidebar for Brand trust -->
                        <div class="col-md-4 side-info d-none d-md-flex">
                            <h3 class="fw-bold"><i class="fa-solid fa-link"></i> EduChain</h3>
                            <p class="mt-4">Impact the world by funding the next generation of leaders in developing countries.</p>
                            <ul class="list-unstyled mt-4 small">
                                <li class="mb-3"><i class="fa fa-check-circle me-2"></i> Verified Student Profiles</li>
                                <li class="mb-3"><i class="fa fa-check-circle me-2"></i> Blockchain Traceability</li>
                                <li class="mb-3"><i class="fa fa-check-circle me-2"></i> Automated Repayments</li>
                            </ul>
                        </div>
                        
                        <!-- Right Registration Form -->
                        <div class="col-md-8 form-section">
                            <h3 class="fw-bold mb-4">Investor Onboarding</h3>
                            <form action="LenderRegistrationServlet" method="post">
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label small fw-bold">Full Name</label>
                                        <input type="text" name="fullName" class="form-control" placeholder="John Smith" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label small fw-bold">Email Address</label>
                                        <input type="email" name="email" class="form-control" placeholder="john@capital.com" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label small fw-bold">Password</label>
                                        <input type="password" name="password" class="form-control" placeholder="••••••••" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label small fw-bold">Investment Budget </label>
                                        <select name="budget" class="form-select form-control">
                                            <option value="500-2000">₹500 - ₹2,000</option>
                                            <option value="2000-10000">₹2,000 - ₹10,000</option>
                                            <option value="10000+">₹10,000+</option>
                                        </select>
                                    </div>
                                    <div class="col-md-12 mb-4">
                                        <label class="form-label small fw-bold">Occupation / Institution</label>
                                        <input type="text" name="institution" class="form-control" placeholder="e.g. Individual Investor / Venture Capital">
                                    </div>
                                </div>
                                
                                <div class="form-check mb-4">
                                    <input class="form-check-input" type="checkbox" required>
                                    <label class="form-check-label small text-muted">
                                        I understand that all investments are recorded on the public blockchain for transparency and cannot be reversed.
                                    </label>
                                </div>

                                <div class="d-grid">
                                    <button type="submit" class="btn btn-investor btn-lg">Complete Investor Profile</button>
                                </div>
                                <div class="text-center mt-3">
                                    <a href="index.jsp" class="text-muted small text-decoration-none">← Back to Homepage</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>

