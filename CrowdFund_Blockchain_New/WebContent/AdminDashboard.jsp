<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, Com.educhain.util.DBConnection" %>

<%
    // 1. Retrieve attributes from the session
    Integer userId = (Integer) session.getAttribute("userId");
    String userRole = (String) session.getAttribute("userRole");

    // 2. STRICT SECURITY CHECK:
    // Check if the user is NOT logged in (userId is null)
    // OR if the user is NOT an admin
    if (userId == null || userRole == null || !"admin".equals(userRole)) {
        
        // 3. Redirect to the homepage with a specific error message
        response.sendRedirect("index.jsp?error=Security Violation: Administrator Login Required!");
        return; 
    }
%>
<!DOCTYPE html>
<html>
<head>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/logo.png">
    <title>Admin Control Center | EduChain</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background-color: #f8f9fa; font-family: 'Poppins', sans-serif; }
        
        .admin-hero {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            color: white;
            padding: 50px;
            border-radius: 24px;
            margin-bottom: 40px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }

        .stat-card {
            border: none;
            border-radius: 15px;
            padding: 20px;
            background: #fff;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }

        .verify-table {
            background: #fff;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
        }
        
        .btn-verify { background: #27ae60; color: white; border-radius: 20px; font-size: 0.8rem; border:none; padding: 5px 15px;}
        .btn-reject { background: #e74c3c; color: white; border-radius: 20px; font-size: 0.8rem; border:none; padding: 5px 15px;}
        .doc-link { color: #0d6efd; text-decoration: none; font-weight: 600; }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg bg-white border-bottom py-3">
        <div class="container">
            <a class="navbar-brand fw-bold text-dark" href="AdminDashboard.jsp"><i class="fa-solid fa-user-shield"></i> ADMIN TERMINAL</a>
            <a href="index.jsp?logout" class="btn btn-outline-danger btn-sm rounded-pill">Logout</a>
        </div>
    </nav>

    <div class="container mt-4">
        <!-- Styled Header -->
        <div class="admin-hero">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1 class="fw-bold">Verification Command Center</h1>
                    <h4 class="fw-light opacity-75">Review student credentials and maintain the integrity of the EduChain Network.</h4>
                </div>
                <div class="col-md-4">
		    <a href="BlockchainExplorer.jsp" class="text-decoration-none">
		        <div class="stat-card text-center" style="border-bottom: 5px solid #1a1a2e;">
		            <i class="fa-solid fa-magnifying-glass-chart fa-2x mb-2 text-primary"></i>
		            <h6 class="text-dark">Blockchain Audit</h6>
		            <small class="text-muted">Verify Chaining Integrity</small>
		        </div>
		    </a>
		</div>
                <!-- <div class="col-md-4 text-end d-none d-md-block">
                    <i class="fa-solid fa-fingerprint fa-5x opacity-25"></i>
                </div> -->
            </div>
        </div>
        
        

        <!-- Verification Table -->
        <h4 class="fw-bold mb-4"><span style="border-bottom: 3px solid #1a1a2e;">Pending</span> Verifications</h4>
        
        <div class="verify-table">
            <table class="table table-hover align-middle mb-0">
                <thead class="bg-light">
                    <tr>
                        <th class="ps-4">Student Name</th>
                        <th>University</th>
                        <th>Identity (Adhar/PAN)</th>
                        <th>Documents</th>
                        <th class="text-center">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try (Connection conn = DBConnection.getConnection()) {
                            // Fetch profiles that are NOT verified yet
                            String sql = "SELECT p.*, u.full_name FROM student_profiles p " +
                                         "JOIN users u ON p.user_id = u.id " +
                                         "WHERE p.is_verified = 0";
                            Statement st = conn.createStatement();
                            ResultSet rs = st.executeQuery(sql);

                            while (rs.next()) {
                    %>
                    <tr>
                        <td class="ps-4">
                            <div class="fw-bold"><%= rs.getString("full_name") %></div>
                            <small class="text-muted"><%= rs.getString("email") %></small>
                        </td>
                        <td><%= rs.getString("university_name") %></td>
                        <td>
                            <div class="small"><b>Adhar:</b> <%= rs.getString("adhar_no") %></div>
                            <div class="small"><b>PAN:</b> <%= rs.getString("pan_no") %></div>
                        </td>
                        <td>
                            <a href="DisplayFile?fileName=<%= rs.getString("id_proof_path") %>" target="_blank" class="doc-link small d-block">
                                <i class="fa fa-file-pdf"></i> View ID Proof
                            </a>
                            <a href="DisplayFile?fileName=<%= rs.getString("admission_letter_path") %>" target="_blank" class="doc-link small d-block">
                                <i class="fa fa-file-pdf"></i> View Admission Letter
                            </a>
                        </td>
                        <td class="text-center">
                            <form action="VerifyStudentServlet" method="post" class="d-inline">
                                <input type="hidden" name="user_id" value="<%= rs.getInt("user_id") %>">
                                <input type="hidden" name="status" value="1">
                                <button type="submit" class="btn-verify me-2"><i class="fa fa-check"></i> Approve</button>
                            </form>
                            <form action="VerifyStudentServlet" method="post" class="d-inline">
                                <input type="hidden" name="user_id" value="<%= rs.getInt("user_id") %>">
                                <input type="hidden" name="status" value="0">
                                <button type="submit" class="btn-reject"><i class="fa fa-times"></i> Reject</button>
                            </form>
                        </td>
                    </tr>
                    <% 
                            }
                        } catch (Exception e) { e.printStackTrace(); } 
                    %>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>

