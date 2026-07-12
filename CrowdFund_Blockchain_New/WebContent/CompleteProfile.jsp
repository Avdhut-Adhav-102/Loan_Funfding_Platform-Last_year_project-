<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, Com.educhain.util.DBConnection" %>
<%
    // Fetch existing user data from Session
    Integer userId = (Integer) session.getAttribute("userId");
    String userName = (String) session.getAttribute("userName");
    String studentEmail = (String) session.getAttribute("studentEmail");
    if (userId == null) { response.sendRedirect("index.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/logo.png">
    <meta charset="UTF-8">
    <title>Complete Profile | EduChain Verification</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    
    <style>
        body { background-color: #f4f7f6; font-family: 'Poppins', sans-serif; }
        .setup-header { background: linear-gradient(45deg, #0d6efd, #003d99); color: white; padding: 60px 0; margin-bottom: -50px; }
        .card-profile { border: none; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); background: #ffffff; }
        .upload-box { border: 2px dashed #dee2e6; padding: 20px; border-radius: 10px; text-align: center; background: #fafafa; transition: 0.3s; }
        .upload-box:hover { border-color: #0d6efd; background: #f0f7ff; }
        .form-label { font-weight: 500; color: #444; }
        .section-title { border-left: 4px solid #0d6efd; padding-left: 15px; margin-bottom: 25px; color: #0d6efd; font-weight: 600; }
    </style>
</head>
<body>

    <div class="setup-header text-center">
        <div class="container">
            <h1><b><i class="fa-solid fa-shield-halved"></i> Verification Center</b></h1>
            <p>Complete your identity and academic profile for blockchain verification</p>
        </div>
    </div>

    <div class="container pb-5">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="card card-profile p-4 p-md-5">
                    
                    <form action="UploadProfileServlet" method="post" enctype="multipart/form-data">
                        
                        <!-- Section 1: Identity Details (New Fields based on your DB) -->
                        <h4 class="section-title">Personal & Identity Details</h4>
                        <div class="row mb-4">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Full Name (Registered)</label>
                                <input type="text" class="form-control bg-light" value="<%= userName %>" readonly>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Email Address</label>
                                <input type="email" name="email" class="form-control" value="<%= studentEmail %>" placeholder="Enter contact email" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Adhar Number (UIDAI)</label>
                                <input type="text" name="adhar_no" class="form-control" maxlength="12" placeholder="12-digit Adhar Number" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">PAN Number</label>
                                <input type="text" name="pan_no" class="form-control" maxlength="10" placeholder="Enter PAN Card No." required>
                            </div>
                        </div>

                        <!-- Section 2: Academic Details -->
                        <h4 class="section-title">Academic Details</h4>
                        <div class="row mb-4">
                            <div class="col-md-12 mb-3">
                                <label class="form-label">University Name</label>
                                <input type="text" name="university_name" class="form-control" placeholder="Enter your University/College Name" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Degree / Course</label>
                                <input type="text" name="degree_name" class="form-control" placeholder="e.g. B.Tech Computer Science" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Current Year of Study</label>
                                <select name="current_year" class="form-select">
                                    <option value="1st Year">1st Year</option>
                                    <option value="2nd Year">2nd Year</option>
                                    <option value="3rd Year">3rd Year</option>
                                    <option value="Final Year">Final Year</option>
                                    <option value="Masters">Masters</option>
                                </select>
                            </div>
                        </div>

                        <hr class="my-4">

                        <!-- Section 3: Document Upload -->
                        <!-- <h4 class="section-title">Document Verification (KYC)</h4>
                        <div class="row mb-4">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">ID Proof (Adhar/PAN Copy)</label>
                                <div class="upload-box">
                                    <i class="fa fa-id-card fa-2x text-muted mb-2"></i>
                                    <input type="file" name="id_proof" class="form-control" required>
                                    <small class="text-muted">Max size 2MB (JPG/PDF)</small>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Admission Letter / Fee Receipt</label>
                                <div class="upload-box">
                                    <i class="fa fa-university fa-2x text-muted mb-2"></i>
                                    <input type="file" name="admission_letter" class="form-control" required>
                                    <small class="text-muted">Max size 2MB (JPG/PDF)</small>
                                </div>
                            </div>
                        </div> -->

                        <!-- Section 4: Bio -->
                        <div class="mb-4">
                            <h4 class="section-title">Student Biography</h4>
                            <textarea name="bio" class="form-control" rows="4" placeholder="Briefly describe your academic background and why you need funding..."></textarea>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary btn-lg rounded-pill shadow-sm">
                                <i class="fa-solid fa-cloud-arrow-up me-2"></i> Submit Profile for Blockchain Verification
                            </button>
                        </div>
                    </form>

                    <p class="text-center mt-4">
                        <a href="StudentDashboard.jsp" class="text-secondary text-decoration-none">
                            <i class="fa fa-arrow-left me-1"></i> Back to Dashboard
                        </a>
                    </p>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

