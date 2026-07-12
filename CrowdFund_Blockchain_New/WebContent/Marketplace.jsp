<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, Com.educhain.util.DBConnection" %>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) { response.sendRedirect("login.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/logo.png">
    <title>Market Insights | EduChain Platform</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    
    <style>
        body { background-color: #f9f9f9; font-family: 'Roboto', sans-serif; color: #333; }
        
        /* Header Styling like the Screenshot */
        .navbar { background: #fff; border-bottom: 2px solid #eee; padding: 15px 0; }
        .navbar-brand { font-weight: 700; color: #003366 !important; letter-spacing: -1px; }
        .nav-link { font-weight: 700; color: #555 !important; font-size: 0.9rem; margin: 0 10px; text-transform: uppercase; }
        
        /* Card UI like the Screenshot */
        .insight-card { border: none; border-radius: 0; background: #fff; box-shadow: 0 4px 15px rgba(0,0,0,0.05); margin-bottom: 30px; height: 100%; }
        .img-container { position: relative; overflow: hidden; }
        .img-container img { width: 100%; height: 220px; object-fit: cover; transition: 0.5s; }
        .insight-card:hover img { transform: scale(1.1); }
        
        /* Red Badge Overlay */
        .category-badge {
            position: absolute;
            top: 15px;
            left: 15px;
            background: #e74c3c;
            color: white;
            padding: 5px 15px;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            border-radius: 3px;
        }

        .card-body { padding: 25px; }
        .card-title { font-weight: 700; font-size: 1.3rem; line-height: 1.3; margin-bottom: 15px; height: 3.4rem; overflow: hidden; }
        .meta-info { color: #888; font-size: 0.85rem; margin-bottom: 15px; }
        .card-text { color: #666; font-size: 0.95rem; line-height: 1.6; height: 4.5rem; overflow: hidden; margin-bottom: 20px; }
        
        /* Button Style like the Screenshot */
        .btn-read-more {
            border: 1px solid #e74c3c;
            color: #e74c3c;
            border-radius: 25px;
            padding: 8px 25px;
            font-weight: 700;
            text-decoration: none;
            transition: 0.3s;
            display: inline-block;
        }
        .btn-read-more:hover { background: #e74c3c; color: #fff; }
        
        .chat-icon {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            background: #f1f1f1;
            border-radius: 50%;
            margin-left: 10px;
            color: #333;
        }
	
	    .card-title {
	        font-weight: 800;
	        font-size: 1.25rem;
	        margin-bottom: 10px;
	        color: #222;
	        letter-spacing: -0.5px;
	    }
	
	    .meta-info {
	        color: #777;
	        font-size: 0.85rem;
	        margin-bottom: 18px;
	        display: block;
	    }
	
	    .fw-bold {
	        text-transform: capitalize; /* Ensures name looks like "John Doe" */
	    }
	    
	    /* The New Hero Header Section */
	    .market-hero-block {
	        background: linear-gradient(135deg, #003366 0%, #001a33 100%);
	        color: white;
	        padding: 60px 50px;
	        border-radius: 24px; /* Pronounced rounded corners */
	        box-shadow: 0 15px 35px rgba(0, 51, 102, 0.2);
	        margin-bottom: 50px;
	        position: relative;
	        overflow: hidden;
	    }
	
	    /* Decorative element for the header */
	    .market-hero-block::before {
	        content: "";
	        position: absolute;
	        top: -50px;
	        right: -50px;
	        width: 200px;
	        height: 200px;
	        background: rgba(255, 255, 255, 0.05);
	        border-radius: 50%;
	    }
	
	    .market-hero-block h1 {
	        font-size: 2.8rem;
	        letter-spacing: -1px;
	        margin-bottom: 10px;
	    }
	
	    .market-hero-block h4 {
	        font-weight: 300;
	        font-size: 1.2rem;
	        max-width: 600px;
	    }
	
	    /* Keep Navbar clean */
	    .navbar {
	        background: #fff;
	        padding: 20px 0;
	        border: none;
	    }

        .section-banner { background: #fff; padding: 40px 0; border-bottom: 1px solid #eee; margin-bottom: 40px; }
    </style>
</head>
<body>

    <!-- Professional Navbar -->
	<!-- <nav class="navbar navbar-expand-lg sticky-top mb-0">
	    <div class="container">
	        <a class="navbar-brand" href="LenderDashboard.jsp">
	            <i class="fa-solid fa-link"></i> EDUCHAIN
	        </a>
	        <div class="collapse navbar-collapse" id="navbarNav">
	            <ul class="navbar-nav ms-auto">
	                <li class="nav-item"><a class="nav-link" href="LenderDashboard.jsp">Terminal</a></li>
	                <li class="nav-item"><a class="nav-link" href="Marketplace.jsp" style="color:#e74c3c !important;">Marketplace</a></li>
	                <li class="nav-item"><a class="nav-link" href="#">My Investments</a></li>
	            </ul>
	        </div>
	    </div>
	</nav> -->
	
	<div class="container mt-4">
	    <!-- NEW STYLED HEADER BLOCK -->
	    <div class="market-hero-block">
	        <div class="row align-items-center">
	            <div class="col-md-8">
	                <h1 class="display-5 fw-bold">Marketplace Insights</h1>
	                <h4 class="fw-light opacity-75">Explore verified academic opportunities and diversify your impact portfolio.</h4>
	            	<a href="LenderDashboard.jsp" class="text-secondary text-decoration-none">
                       <i class="fa fa-arrow-left me-1"></i> Back to Dashboard
                    </a>
	            </div>
	            <div class="col-md-4 text-md-end d-none d-md-block">
	                <i class="fa-solid fa-chart-line fa-4x opacity-25"></i>
	            </div>
	        </div>
	    </div>
	</div>

    <div class="container">
        <div class="row">
		    <%
		        try (Connection conn = DBConnection.getConnection()) {
		            // Updated Query to ensure we get the Student's Full Name
		            String sql = "SELECT l.*, p.university_name, u.full_name FROM loan_requests l " +
		                         "JOIN users u ON l.user_id = u.id " +
		                         "JOIN student_profiles p ON l.user_id = p.user_id " +
		                         "WHERE l.status = 'OPEN'";
		            
		            Statement st = conn.createStatement();
		            ResultSet rs = st.executeQuery(sql);
		
		            while (rs.next()) {
		                int loanId = rs.getInt("loan_id");
		                String title = rs.getString("loan_title");
		                String studentName = rs.getString("full_name"); // Fetching name
		                String university = rs.getString("university_name");
		                String description = rs.getString("description");
		                double goal = rs.getDouble("amount_required");
		                Date postDate = rs.getDate("created_at"); 
		    
                        double raised = rs.getDouble("amount_raised");
                        double progress = (raised / goal) * 100;
		    %>
		    <div class="col-md-12 mb-4">
		        <div class="card insight-card">
		            <div class="row g-0">
		                <div class="col-md-4 img-container">
		                    <img src="https://images.unsplash.com/photo-1523240795612-9a054b0db644?auto=format&fit=crop&w=800&q=80" alt="Education" style="width: 100%; height: 100%; min-height: 220px; object-fit: cover;">
		                    <div class="category-badge">Education Funding</div>
		                </div>
		                <div class="col-md-8">
		                    <div class="card-body">
		                        <!-- 1. Bold Uppercase Title -->
		                        <h5 class="card-title text-uppercase mb-2" style="height: auto; overflow: visible;"><%= title %></h5>
		
		                        <!-- 2. Student Name (Newly Added Above Meta) -->
		                        <div class="mb-2">
		                            <span class="fw-bold" style="color: #003366; font-size: 0.99rem;">
		                                <i class="fa-solid fa-circle-user me-1"></i> <%= studentName %>
		                            </span>
		                        </div>
		
		                        <!-- 3. Meta Info (Date & University) -->
		                        <div class="meta-info mb-3">
		                            <i class="fa fa-calendar-alt me-1"></i> <%= postDate %> | 
		                            <i class="fa fa-university ms-2 me-1"></i> <%= university %>
		                        </div>
		
		                        <!-- 4. Description Snippet -->
		                        <p class="card-text mb-4" style="height: auto; overflow: visible;">
		                            Seeking ₹<%= goal %> for academic excellence. <%= description %>
		                        </p>
		
		                        <!-- 5. Actions -->
		                        <div class="d-flex align-items-center">
		                            <a href="#" class="btn-read-more" data-bs-toggle="modal" data-bs-target="#fundModal<%= loanId %>">
		                                Invest Now &rarr;
		                            </a>
		                            <a href="#" class="chat-icon"><i class="fa-solid fa-comment-dots"></i></a>
		                        </div>
		                    </div>
		                </div>
		            </div>
		        </div>
		    </div>    
		        <!-- Funding Modal for this specific loan -->
            <div class="modal fade" id="fundModal<%= rs.getInt("loan_id") %>" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content border-0 shadow">
                        <div class="modal-header bg-primary text-white">
                            <h5 class="modal-title">Confirm Investment</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body p-4">
                            <form action="FundLoanServlet" method="post">
                                <input type="hidden" name="loan_id" value="<%= rs.getInt("loan_id") %>">
                                <p class="small text-muted">You are investing in <b><%= rs.getString("loan_title") %></b></p>
                                
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Amount to Invest (USD)</label>
                                    <input type="number" name="invest_amount" class="form-control" 
                                           max="<%= goal - raised %>" placeholder="Enter amount" required>
                                    <div class="form-text text-danger">Remaining gap: ₹<%= goal - raised %></div>
                                </div>
                                
                                <div class="alert alert-light border small">
                                    <i class="fa fa-info-circle text-primary"></i> This transaction will be hashed and appended to the EduChain Public Ledger.
                                </div>
                                
                                <div class="d-grid">
                                    <button type="submit" class="btn btn-primary btn-lg rounded-pill">Execute Blockchain Transaction</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <%
                    }
                } catch (Exception e) { e.printStackTrace(); }
            %>
        </div>
    </div>
		    <%-- </div>
		    <%
		            }
		        } catch (Exception e) { e.printStackTrace(); }
		    %>
		</div>
    </div> --%>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

