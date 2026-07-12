<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("userId") == null) { response.sendRedirect("login.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/logo.png">
    <title>Post Loan Request | EduChain</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background-color: #f0f2f5; font-family: 'Poppins', sans-serif; }
        .hero-section { background: #0d6efd; color: white; padding: 40px 0; }
        .loan-card { border: none; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); }
        .input-group-text { background-color: #e9ecef; border: none; }
        .preview-box { background: #fff; border-left: 5px solid #0d6efd; padding: 20px; border-radius: 10px; }
    </style>
</head>
<body>

    <div class="hero-section text-center">
        <div class="container">
            <h2><i class="fa-solid fa-bullhorn me-2"></i> Launch Your Campaign</h2>
            <p>Tell the world your story and get the funding you need for your education.</p>
        </div>
    </div>

    <div class="container my-5">
        <div class="row">
            <!-- Form Section -->
            <div class="col-lg-7">
                <div class="card loan-card p-4">
                    <h4 class="mb-4">Loan Details</h4>
                    <form action="PostLoanServlet" method="post">
                        
                        <div class="mb-3">
                            <label class="form-label">Campaign Title</label>
                            <input type="text" name="loan_title" class="form-control" placeholder="e.g. Final Semester Tuition Fee for IT Degree" required>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Amount Needed (USD)</label>
                                <div class="input-group">
                                    <span class="input-group-text">₹</span>
                                    <input type="number" name="amount" class="form-control" placeholder="2000" required>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Repayment Tenure</label>
                                <select name="tenure" class="form-select">
                                    <option value="6">6 Months</option>
                                    <option value="12">12 Months</option>
                                    <option value="24">24 Months</option>
                                    <option value="36">36 Months</option>
                                </select>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Describe your Goal</label>
                            <textarea name="description" class="form-control" rows="5" placeholder="Explain how this loan will help your studies..." required></textarea>
                        </div>

                        <div class="alert alert-info small">
                            <i class="fa-solid fa-circle-info"></i> Your request will be hashed and added to the <b>EduChain Ledger</b> once submitted. This ensures lenders can trust your data.
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary btn-lg rounded-pill">Launch Campaign</button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Side Tips / Preview Info -->
            <div class="col-lg-5">
                <div class="preview-box shadow-sm mb-4">
                    <h5><i class="fa-solid fa-lightbulb text-warning me-2"></i> Quick Tips</h5>
                    <ul class="small text-muted mt-3">
                        <li>Be specific about what the funds are for.</li>
                        <li>Honesty increases your chances of getting funded.</li>
                        <li>Lenders prefer students with clear repayment plans.</li>
                    </ul>
                </div>
                
                <div class="card border-0 shadow-sm p-4 text-center bg-white">
                    <img src="https://img.freepik.com/free-vector/growth-concept-illustration_114360-5021.jpg" class="img-fluid mb-3" style="max-height: 200px;">
                    <h6>Join 500+ Students</h6>
                    <p class="small text-muted">Students in developing countries have raised over ₹1M for higher education through EduChain.</p>
                </div>
                
                	<p class="text-center mt-4">
                        <a href="StudentDashboard.jsp" class="text-secondary text-decoration-none">
                            <i class="fa fa-arrow-left me-1"></i> Back to Dashboard
                        </a>
                    </p>
            </div>
        </div>
    </div>

</body>
</html>

