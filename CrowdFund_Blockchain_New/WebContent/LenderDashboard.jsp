<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, Com.educhain.util.DBConnection" %>
<%
    // Session & Role Security
    Integer userId = (Integer) session.getAttribute("userId");
    String userRole = (String) session.getAttribute("userRole");
    
    if (userId == null || !"lender".equals(userRole)) {
        response.sendRedirect("login.jsp?error=Unauthorized Access");
        return;
    }

    // Fetch Lender Profile Data
    double walletBalance = 0;
    double totalInvested = 0;
    String institution = "";
    
    try (Connection conn = DBConnection.getConnection()) {
        String sql = "SELECT * FROM lender_profiles WHERE user_id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            walletBalance = rs.getDouble("wallet_balance");
            totalInvested = rs.getDouble("total_invested");
            institution = rs.getString("institution_name");
        }
    } catch (Exception e) { e.printStackTrace(); }
%>
<!DOCTYPE html>
<html>
<head>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/logo.png">
    <title>Investor Terminal | EduChain</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root { --dark-blue: #001529; --accent-blue: #1890ff; }
        body { background-color: #f4f7fc; font-family: 'Poppins', sans-serif; }
        
        /* Sidebar/Menu Styling */
        .sidebar { background: var(--dark-blue); min-height: 100vh; color: white; padding-top: 20px; }
        .nav-link { color: rgba(255,255,255,0.7); margin: 5px 15px; border-radius: 8px; transition: 0.3s; }
        .nav-link:hover, .nav-link.active { background: var(--accent-blue); color: white; }
        
        /* Top Header */
        .top-header { background: white; padding: 15px 30px; border-bottom: 1px solid #e8e8e8; }

        /* Investment Cards */
        .stat-card { border: none; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); transition: 0.3s; }
        .stat-card:hover { transform: translateY(-5px); }
        .icon-box { width: 50px; height: 50px; border-radius: 10px; display: flex; align-items: center; justify-content: center; font-size: 20px; }

        /* Blockchain Pulse Section */
        .blockchain-pulse {
            background: linear-gradient(135deg, #001529 0%, #003a8c 100%);
            color: white;
            border-radius: 15px;
            padding: 30px;
            position: relative;
            overflow: hidden;
        }
        .pulse-gif {
            position: absolute;
            right: -20px;
            top: -20px;
            width: 250px;
            opacity: 0.2;
            pointer-events: none;
        }

        /* Student Card Hover */
        .student-preview-card { border: 1px solid #eee; border-radius: 10px; transition: 0.3s; }
        .student-preview-card:hover { border-color: var(--accent-blue); background: #f0f7ff; }
        
        /* Professional Blockchain Pulse Animation (No Image Required) */
		.pulse-circle {
		  width: 20px;
		  height: 20px;
		  background-color: #1890ff;
		  border-radius: 50%;
		  position: relative;
		  margin: 0 auto;
		}
		
		.pulse-circle::after {
		  content: "";
		  position: absolute;
		  top: 0; left: 0;
		  width: 100%; height: 100%;
		  background-color: #1890ff;
		  border-radius: 50%;
		  z-index: -1;
		  animation: pulse 1.5s infinite ease-out;
		}
		
		@keyframes pulse {
		  0% { transform: scale(1); opacity: 1; }
		  100% { transform: scale(3); opacity: 0; }
		}
        
    </style>
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar Menu -->
        <div class="col-md-2 sidebar d-none d-md-block position-fixed">
            <h4 class="text-center fw-bold mb-5"><i class="fa-solid fa-link text-info"></i> EduChain</h4>
            <nav class="nav flex-column">
                <a class="nav-link active" href="LenderDashboard.jsp"><i class="fa fa-home me-2"></i> Terminal</a>
                <a class="nav-link" href="Marketplace.jsp"><i class="fa fa-search me-2"></i> Browse Loans</a>
                <a class="nav-link" href="BlockchainExplorer.jsp"><i class="fa-solid fa-link text-primary"></i> Public Ledger</a>
                <a class="nav-link" href="#"><i class="fa fa-chart-pie me-2"></i> Portfolio</a>
                <a class="nav-link" href="#"><i class="fa fa-wallet me-2"></i> Wallet</a>
                <hr class="mx-3 border-secondary">
                <a class="nav-link text-danger" href="index.jsp?logout"><i class="fa fa-sign-out-alt me-2"></i> Logout</a>
            </nav>
        </div>

        <!-- Main Content Area -->
        <div class="col-md-10 offset-md-2 p-0">
            
            <!-- Top Nav -->
            <div class="top-header d-flex justify-content-between align-items-center">
                <h5 class="mb-0 fw-bold text-muted"><b>Investor Terminal</b> <small class="fw-normal text-primary">/ Overview</small></h5>
                <div class="d-flex align-items-center">
                    <div class="me-4 text-end">
                        <small class="text-muted d-block">Available Wallet</small>
                        <span class="fw-bold text-success">₹<%= String.format("%.2f", walletBalance) %></span>
                    </div>
                    <img src="https://ui-avatars.com/api/?name=<%= session.getAttribute("userName") %>&background=1890ff&color=fff" class="rounded-circle" width="40">
                </div>
            </div>

            <!-- Dashboard Body -->
            <div class="p-4">
                
                <!-- Blockchain Hero Banner -->
                <div class="blockchain-pulse mb-4">
                    <img src="https://i.pinimg.com/originals/48/4e/82/484e82ee3e40e67bc40427d53063f1db.gif" class="pulse-gif">
                    <div class="row align-items-center">
                        <div class="col-md-8">
                            <h2 class="fw-bold">Welcome, <%= session.getAttribute("userName") %></h2>
                            <p class="opacity-75">Your capital is currently supporting global education. All transactions are secured by 256-bit encryption on the immutable ledger.</p>
                            <a href="Marketplace.jsp" class="btn btn-info px-4 rounded-pill fw-bold">Explore New Opportunities</a>
                        </div>
                    </div>
                </div>

                <!-- Stats Row -->
                <div class="row g-4 mb-4">
                    <div class="col-md-3">
                        <div class="card stat-card p-3">
                            <div class="d-flex align-items-center">
                                <div class="icon-box bg-primary-subtle text-primary me-3"><i class="fa fa-briefcase"></i></div>
                                <div>
                                    <small class="text-muted">Total Invested</small>
                                    <h4 class="fw-bold mb-0">₹<%= totalInvested %></h4>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card stat-card p-3">
                            <div class="d-flex align-items-center">
                                <div class="icon-box bg-success-subtle text-success me-3"><i class="fa fa-hand-holding-dollar"></i></div>
                                <div>
                                    <small class="text-muted">Active Loans</small>
                                    <h4 class="fw-bold mb-0">12</h4>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card stat-card p-3">
                            <div class="d-flex align-items-center">
                                <div class="icon-box bg-warning-subtle text-warning me-3"><i class="fa fa-users"></i></div>
                                <div>
                                    <small class="text-muted">Students Supported</small>
                                    <h4 class="fw-bold mb-0">08</h4>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card stat-card p-3">
                            <div class="d-flex align-items-center">
                                <div class="icon-box bg-info-subtle text-info me-3"><i class="fa fa-line-chart"></i></div>
                                <div>
                                    <small class="text-muted">Expected ROI</small>
                                    <h4 class="fw-bold mb-0">5.4%</h4>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Marketplace Snapshot -->
                <div class="row">
                    <div class="col-md-8">
                        <div class="card border-0 shadow-sm p-4 h-100">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h5 class="fw-bold mb-0">Trending Loan Campaigns</h5>
                                <a href="Marketplace.jsp" class="text-primary text-decoration-none small">View All <i class="fa fa-arrow-right"></i></a>
                            </div>
                            
                            <!-- Placeholder for Student Loop -->
                            <div class="student-preview-card p-3 mb-3 d-flex align-items-center justify-content-between">
                                <div class="d-flex align-items-center">
                                    <div class="rounded-circle bg-light p-3 me-3"><i class="fa fa-university text-muted"></i></div>
                                    <div>
                                        <h6 class="mb-0 fw-bold">IT Degree Specialization</h6>
                                        <small class="text-muted">Target: ₹2,500 | 12 Months Tenure</small>
                                    </div>
                                </div>
                                <button class="btn btn-outline-primary btn-sm px-3 rounded-pill">View Details</button>
                            </div>

                            <div class="student-preview-card p-3 mb-3 d-flex align-items-center justify-content-between">
                                <div class="d-flex align-items-center">
                                    <div class="rounded-circle bg-light p-3 me-3"><i class="fa fa-microscope text-muted"></i></div>
                                    <div>
                                        <h6 class="mb-0 fw-bold">Medical Research Funding</h6>
                                        <small class="text-muted">Target: ₹5,000 | 24 Months Tenure</small>
                                    </div>
                                </div>
                                <button class="btn btn-outline-primary btn-sm px-3 rounded-pill">View Details</button>
                            </div>

                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="card border-0 shadow-sm p-4 h-100 bg-white">
                          <div class="d-flex justify-content-between">
                            <h5 class="fw-bold mb-3">Live Ledger Feed</h5>
                            <a href="BlockchainExplorer.jsp" class="text-decoration-none small text-primary">Explore All</a>
                          </div>
                            <div class="small">
                                <div class="mb-3 border-start border-primary border-3 ps-3">
                                    <span class="text-primary fw-bold">#Block 8421 Verified</span><br>
                                    <small class="text-muted">Repayment of ₹200 from Student #22</small>
                                </div>
                                <div class="mb-3 border-start border-info border-3 ps-3">
                                    <span class="text-info fw-bold">#Block 8420 Verified</span><br>
                                    <small class="text-muted">Loan Request for ₹1,200 Hashed</small>
                                </div>
                                <div class="mb-3 border-start border-success border-3 ps-3">
                                    <span class="text-success fw-bold">#Block 8419 Verified</span><br>
                                    <small class="text-muted">New Investor Account Registered</small>
                                </div>
                            </div>
                            <div class="text-center mt-auto">
                                <img src="images/ok.png" width="120">
                            </div>
                            
                            <!-- <div class="text-center mt-auto">
							    <div class="pulse-circle mb-3"></div>
							    <small class="text-primary fw-bold">Live Network Feed Active</small>
							</div> -->
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

