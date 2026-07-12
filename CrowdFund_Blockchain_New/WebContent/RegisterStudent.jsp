<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/logo.png">
    <title>Student Registration | EduChain</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background: #f4f7f6; font-family: 'Poppins', sans-serif; }
        .reg-card { border-radius: 20px; border: none; overflow: hidden; }
        .reg-header { background: #0d6efd; color: white; padding: 30px; }
        .form-control { border-radius: 10px; padding: 12px; }
        .step-icon { width: 40px; height: 40px; background: #e7f0ff; color: #0d6efd; display: inline-flex; align-items: center; justify-content: center; border-radius: 50%; margin-right: 10px; }

	    body { 
	        /* Education/Success themed image */
	        background-image: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), 
                  url('${pageContext.request.contextPath}/images/Bk1.png');
	        background-size: cover;
	        background-position: center;
	        background-attachment: fixed;
	        min-height: 100vh;
	        display: flex;
	        align-items: center;
	        font-family: 'Poppins', sans-serif;
	    }
	
	    .reg-card { 
	        background: rgba(255, 255, 255, 0.98); /* Near solid white to keep form readable */
	        border-radius: 15px;
	        box-shadow: 0 15px 35px rgba(0,0,0,0.5);
	    }
	</style>
</head>
<body>
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card reg-card shadow-lg">
                    <div class="reg-header text-center">
                        <h3>Create Student Profile</h3>
                        <p class="mb-0">Join EduChain to fund your dreams via the Blockchain</p>
                    </div>
                    <div class="card-body p-5">
                        <form action="StudentRegistrationServlet" method="post">
                            <h5 class="mb-4 text-primary"><span class="step-icon">1</span>Personal Account Details</h5>
                            <div class="row mb-4">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Full Name (As per ID)</label>
                                    <input type="text" name="fullName" class="form-control" placeholder="John Doe" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Email Address</label>
                                    <input type="email" name="email" class="form-control" placeholder="john@university.edu" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Contact Number</label>
                                    <input type="number" name="contact" class="form-control" placeholder="+ 0000000000" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Create Password</label>
                                    <input type="password" name="password" class="form-control" required>
                                </div>
                            </div>

                            <!-- <h5 class="mb-4 text-primary"><span class="step-icon">2</span>Academic Information</h5>
                            <div class="row mb-4">
                                <div class="col-md-12 mb-3">
                                    <label class="form-label">University / College Name</label>
                                    <input type="text" name="university" class="form-control" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Degree/Course</label>
                                    <input type="text" name="degree" class="form-control" placeholder="B.Sc. Computer Science" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Current Year of Study</label>
                                    <select name="year" class="form-select form-control">
                                        <option>1st Year</option>
                                        <option>2nd Year</option>
                                        <option>3rd Year</option>
                                        <option>Final Year</option>
                                    </select>
                                </div>
                            </div>

                            <div class="mb-4">
                                <label class="form-label">Brief Student Bio (Why do you need funding?)</label>
                                <textarea name="bio" class="form-control" rows="3" placeholder="Tell potential lenders about your goals..."></textarea>
                            </div>-->

                            <div class="form-check mb-4">
                                <input class="form-check-input" type="checkbox" required>
                                <label class="form-check-label text-muted">
                                    I agree that my academic records can be verified and stored on the EduChain Immutable Ledger.
                                </label>
                            </div>

                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary btn-lg rounded-pill">Complete Registration</button>
                            </div>
                        </form>
                        <p style="text-align: center; margin-top: 15px; font-size: 13px;">
		                    <a href="index.jsp" style="color: #64748b; text-decoration: none;">← Back to Dashboard</a>
		                </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

