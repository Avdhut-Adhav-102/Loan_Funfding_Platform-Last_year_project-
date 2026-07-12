<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, Com.educhain.util.DBConnection" %>
<%
    // Session Security Check: Redirect to login if user is not logged in
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp?error=Please login first");
    }
%>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    
    // Variables to hold dynamic data
    String loanTitle = "No Active Campaign";
    int loanId = 0;
    double required = 0, raised = 0, percent = 0;
    int lenderCount = 0;
    int isVerified = 0; // 0 = Pending, 1 = Verified

    try (Connection conn = DBConnection.getConnection()) {
        
        // 1. Fetch Verification Status
        String vSql = "SELECT is_verified FROM student_profiles WHERE user_id = ?";
        PreparedStatement psV = conn.prepareStatement(vSql);
        psV.setInt(1, userId);
        ResultSet rsV = psV.executeQuery();
        if(rsV.next()){
            isVerified = rsV.getInt("is_verified");
        }

        // 2. Fetch Loan Details
        String lSql = "SELECT * FROM loan_requests WHERE user_id = ? AND status != 'COMPLETED' LIMIT 1";
        PreparedStatement psL = conn.prepareStatement(lSql);
        psL.setInt(1, userId);
        ResultSet rsL = psL.executeQuery();
        
        if (rsL.next()) {
            loanId = rsL.getInt("loan_id");
            loanTitle = rsL.getString("loan_title");
            required = rsL.getDouble("amount_required");
            raised = rsL.getDouble("amount_raised");
            if(required > 0) percent = (raised / required) * 100;
            
            // 3. Count Unique Lenders for this loan
            String cSql = "SELECT COUNT(DISTINCT lender_id) as total FROM investments WHERE loan_id = ?";
            PreparedStatement psC = conn.prepareStatement(cSql);
            psC.setInt(1, loanId);
            ResultSet rsC = psC.executeQuery();
            if(rsC.next()) lenderCount = rsC.getInt("total");
        }
    } catch (Exception e) { e.printStackTrace(); }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/logo.png">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Workspace | EduChain</title>
    
    <!-- Bootstrap 5 & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    
    <style>
        body { background-color: #f8f9fa; font-family: 'Poppins', sans-serif; }
        .navbar { background: #fff; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        
        /* Dashboard Hero */
        .dash-hero {
            background: linear-gradient(45deg, #0d6efd, #002b5c);
            color: white;
            padding: 40px 0;
            margin-bottom: 30px;
        }

        /* Action Cards */
        .card-task {
            border: none;
            border-radius: 15px;
            transition: all 0.3s ease;
            cursor: pointer;
            height: 100%;
        }
        .card-task:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        .icon-circle {
            width: 60px;
            height: 60px;
            background: #e7f0ff;
            color: #0d6efd;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            margin-bottom: 15px;
        }

        /* Progress Bar for Loan */
        .progress { height: 10px; border-radius: 10px; }
        
        /* Status Badges */
        .status-badge {
            font-size: 0.8rem;
            padding: 5px 12px;
            border-radius: 20px;
        }
    </style>
</head>
<body>

    <!-- Navigation (Same as index but with Logout) -->
    <nav class="navbar navbar-expand-lg sticky-top">
        <div class="container">
            <a class="navbar-brand fw-bold text-primary" href="index.jsp">
                <i class="fa-solid fa-link"></i> EduChain
            </a>
            <div class="ms-auto d-flex align-items-center">
                <span class="me-3 d-none d-md-inline">Welcome, <b><%= session.getAttribute("userName") %></b></span>
                <a href="index.jsp?logout" class="btn btn-outline-danger btn-sm rounded-pill px-3">Logout</a>
            </div>
        </div>
    </nav>

    <!-- Header Section -->
    <header class="dash-hero text-center">
        <div class="container">
            <h2 class="fw-bold">Student Dashboard</h2>
            <p class="opacity-75">Manage your academic profile and crowdsourcing campaigns</p>
            <div class="mt-3">
                <span class="badge bg-light text-primary border status-badge">
                    <i class="fa-solid fa-shield-check"></i> Blockchain Verified ID: 0x71C...842
                </span>
            </div>
        </div>
    </header>

    <div class="container mb-5">
        
        <!-- Main Action Hub -->
        <div class="row g-4">
            
            <!-- Step 1: Profile Section -->
			<div class="col-md-3">
			    <div class="card card-task shadow-sm p-4 text-center" 
			         onclick="window.location.href='CompleteProfile.jsp';" 
			         style="cursor: pointer;">			        
			        <div class="icon-circle mx-auto">
			            <i class="fa-solid fa-user-graduate"></i>
			        </div>
			        <h5>Academic Profile</h5>
			        <p class="small text-muted">Update your university and degree details.</p>
			        <span class="status-badge bg-success text-white">Update Profile</span>
			    </div>
			</div>

            <!-- Step 2: Verification Section -->
            <div class="col-md-3">
                <div class="card card-task shadow-sm p-4 text-center" 
			         onclick="window.location.href='Documents.jsp';" 
			         style="cursor: pointer;">			        
			        <div class="icon-circle mx-auto">
			            <i class="fa-solid fa-file-shield"></i>
			        </div>
                    <h5>Documents</h5>
                    <p class="small text-muted">Upload ID and Admission Letter for verification.</p>
                    <span class="status-badge bg-warning text-dark">Pending Review</span>
                </div>
            </div>

            <!-- Step 3: Loan Request Section -->
            <div class="col-md-3">
                <div class="card card-task shadow-sm p-4 text-center" 
			         onclick="window.location.href='PostLoan.jsp';" 
			         style="cursor: pointer;">			        
			        <div class="icon-circle mx-auto">
			            <i class="fa-solid fa-hand-holding-dollar"></i>
			        </div>
                    <h5>Request Funding</h5>
                    <p class="small text-muted">Create a new loan campaign for your fees.</p>
                    <span class="status-badge bg-primary text-white">Create New</span>
                </div>
            </div>

            <!-- Step 4: Repayment Section -->
            <div class="col-md-3">
            	<div class="card card-task shadow-sm p-4 text-center" 
			         onclick="window.location.href='RepayLoan.jsp';" 
			         style="cursor: pointer;">			        
			        <div class="icon-circle mx-auto">
			            <i class="fa-solid fa-clock-rotate-left"></i>
			        </div>
                    <h5>Repayments</h5>
                    <p class="small text-muted">View installments and pay via blockchain.</p>
                    <span class="status-badge bg-secondary text-white">No Active Loan</span>
                </div>
            </div>
        </div>

        <!-- Active Loan Tracking Section (Visible if user has a loan) -->
        <div class="container mt-5">
	    <!-- 1. Document Verification Status (Admin Controlled) -->
		<div class="row mb-4">
		    <div class="col-12">
		        <div class="card border-0 shadow-sm p-3" style="border-left: 5px solid <%= (isVerified == 1 ? "#27ae60" : "#f1c40f") %> !important;">
		            <div class="d-flex justify-content-between align-items-center">
		                
		                <!-- Left: Text Content -->
		                <div>
		                    <h6 class="mb-0 fw-bold">KYC & Document Verification Status</h6>
		                    <small class="text-muted">Verified documents are required for investors to fund your account.</small>
		                </div>
		
		                <!-- Middle: THE OVAL AREA (Blockchain Link) -->
		                <div class="text-center">
		                    <a href="BlockchainExplorer.jsp" class="text-primary text-decoration-none" style="font-size: 12px; font-weight: 600; border: 1px solid #e0e0e0; padding: 5px 15px; border-radius: 20px; background: #fafafa;">
		                        <i class="fa fa-search"></i> View on Public Ledger
		                    </a>
		                </div>
		
		                <!-- Right: Status Badge -->
		                <div>
		                    <% if(isVerified == 1) { %>
		                        <span class="badge bg-success px-4 py-2 rounded-pill shadow-sm">
		                            <i class="fa fa-check-circle me-1"></i> VERIFIED BY ADMIN
		                        </span>
		                    <% } else { %>
		                        <span class="badge bg-warning text-dark px-4 py-2 rounded-pill shadow-sm">
		                            <i class="fa fa-clock me-1"></i> VERIFICATION PENDING
		                        </span>
		                    <% } %>
		                </div>
		
		            </div>
		        </div>
		    </div>
		</div>
	    </div>
	
	    <!-- 2. Dynamic Campaign Status -->
	    <h4 class="fw-bold mb-4">My Current Campaign Status</h4>
	    
	    <% if(loanId > 0) { %>
	        <div class="card border-0 shadow-sm p-4">
	            <div class="row align-items-center">
	                <div class="col-md-8">
	                    <h5 class="text-primary fw-bold mb-1"><%= loanTitle %></h5>
	                    <p class="text-muted small mb-0">Campaign ID: <span class="badge bg-light text-dark fw-normal">#BC-992<%= loanId %></span></p>
	                </div>
	                <div class="col-md-4 text-md-end">
	                    <h4 class="fw-bold mb-0">₹<%= String.format("%.0f", raised) %> <small class="text-muted fw-light" style="font-size: 1rem;">raised of ₹<%= String.format("%.0f", required) %></small></h4>
	                </div>
	                
	                <div class="col-12 mt-4">
	                    <div class="progress" style="height: 12px; background-color: #eee;">
	                        <div class="progress-bar progress-bar-striped progress-bar-animated" 
	                             role="progressbar" 
	                             style="width: <%= percent %>%; background-color: #0d6efd;">
	                        </div>
	                    </div>
	                    <div class="d-flex justify-content-between mt-3">
	                        <span class="small fw-bold text-secondary"><%= (int)percent %>% Funded</span>
	                        <span class="small text-muted"><i class="fa fa-users me-1"></i> <%= lenderCount %> Lenders contributed</span>
	                    </div>
	                </div>
	            </div>
	        </div>
	    <% } else { %>
	        <div class="card border-0 shadow-sm p-5 text-center">
	            <i class="fa fa-folder-open fa-3x text-light mb-3"></i>
	            <h5 class="text-muted">No active loan campaign found.</h5>
	            <p class="small text-muted">Complete your profile and documents to launch your first request.</p>
	            <div class="mt-2">
	                <a href="PostLoan.jsp" class="btn btn-outline-primary btn-sm rounded-pill">Create Campaign</a>
	            </div>
	        </div>
	    <% } %>
		</div>
   	</div>


    <!-- MODAL FOR LOAN REQUEST (Step 3 Example) -->
    <div class="modal fade" id="loanModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content border-0 shadow">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title">Create Loan Campaign</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-4">
                    <form action="LoanRequestServlet" method="post">
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Funding Goal (USD)</label>
                                <input type="number" name="amount" class="form-control" placeholder="3000" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Repayment Period (Months)</label>
                                <select class="form-select" name="tenure">
                                    <option>12 Months</option>
                                    <option>24 Months</option>
                                    <option>36 Months</option>
                                </select>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Campaign Title</label>
                            <input type="text" name="title" class="form-control" placeholder="Final Year Tuition Fee" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Detailed Explanation</label>
                            <textarea name="description" class="form-control" rows="4" placeholder="Explain why you need this loan and how it will help your education..."></textarea>
                        </div>
                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary">Submit to Blockchain Ledger</button>
                        </div>
                    </form>
                </div>
            </div>
            
            <!-- Step 4: Repayment Section -->
			<div class="col-md-3">
			    <% if(loanId > 0) { %>
			        <!-- If loan exists, link to the repayment page -->
			        <a href="RepayLoan.jsp" class="text-decoration-none text-dark">
			            <div class="card card-task shadow-sm p-4 text-center">
			                <div class="icon-circle mx-auto" style="background: #e6fffa; color: #27ae60;">
			                    <i class="fa-solid fa-clock-rotate-left"></i>
			                </div>
			                <h5>Repayments</h5>
			                <p class="small text-muted">View installments and pay via blockchain.</p>
			                <span class="status-badge bg-success text-white">Pay Installment</span>
			            </div>
			        </a>
			    <% } else { %>
			        <!-- If no loan exists, card is "Locked" -->
			        <div class="card card-task shadow-sm p-4 text-center opacity-75" style="cursor: not-allowed;">
			            <div class="icon-circle mx-auto" style="background: #f8f9fa; color: #ccc;">
			                <i class="fa-solid fa-lock"></i>
			            </div>
			            <h5>Repayments</h5>
			            <p class="small text-muted">Repayment is locked until a loan is funded.</p>
			            <span class="status-badge bg-secondary text-white">No Active Loan</span>
			        </div>
			    <% } %>
			</div>
        </div>
    </div>

    <!-- Footer (Same as index) -->
    <footer class="bg-dark text-white pt-5 pb-3 mt-5">
        <div class="container text-center">
            <p class="small opacity-50">&copy; 2026 EduChain | Decentralized Student Lending</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

