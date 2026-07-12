<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, Com.educhain.util.DBConnection, Com.Blockchain.BlockchainUtils" %>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) { response.sendRedirect("login.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/logo.png">
    <title>Blockchain Ledger | EduChain Integrity</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background-color: #f0f4f8; font-family: 'Poppins', sans-serif; }
        .ledger-header {
            background: linear-gradient(135deg, #0f2027 0%, #203a43 50%, #2c5364 100%);
            color: white; padding: 60px; border-radius: 25px; margin-top: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        .block-card { border: none; border-radius: 15px; background: #fff; margin-bottom: 20px; border-left: 5px solid #00d2ff; transition: 0.3s; }
        .hash-box { background: #f8f9fa; padding: 10px; border-radius: 8px; font-family: 'Courier New', monospace; font-size: 0.85rem; word-break: break-all; }
        .status-secure { color: #27ae60; font-weight: bold; }
        .status-broken { color: #e74c3c; font-weight: bold; }
        .chain-link { text-align: center; color: #bdc3c7; font-size: 20px; margin: -10px 0; }
    </style>
</head>
<body>

    <div class="container">
        <!-- Rounded Professional Header -->
        <div class="ledger-header mb-5">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1 class="display-5 fw-bold"><i class="fa-solid fa-cubes-stacked"></i> Public Ledger</h1>
                    <p class="lead opacity-75">Real-time integrity report of the EduChain transaction network.</p>
                </div>
                <div class="col-md-4 text-center">
                    <div class="bg-white text-dark p-3 rounded-4 shadow-sm">
                        <small class="text-muted d-block uppercase">NETWORK STATUS</small>
                        <span class="status-secure"><i class="fa fa-shield-check"></i> 256-BIT SECURE</span>
                    </div>
                </div>
            </div>
        </div>

        <h4 class="fw-bold mb-4">Transaction Chaining History</h4>

        <%
            String lastCalculatedHash = "0"; // To compare with next block
            try (Connection conn = DBConnection.getConnection()) {
                // Fetching all repayments as blocks
                String sql = "SELECT * FROM repayments ORDER BY repay_id ASC";
                Statement st = conn.createStatement();
                ResultSet rs = st.executeQuery(sql);

                while (rs.next()) {
                    String currentHash = rs.getString("current_hash");
                    String prevHash = rs.getString("previous_hash");
                    boolean isValid = lastCalculatedHash.equals(prevHash) || rs.getRow() == 1;
                    lastCalculatedHash = currentHash; // Update for next iteration
        %>
            <!-- Chain Link Icon -->
            <div class="chain-link"><i class="fa fa-link"></i></div>

            <!-- Block Card -->
            <div class="card block-card shadow-sm">
                <div class="card-body p-4">
                    <div class="row">
                        <div class="col-md-2 text-center border-end">
                            <small class="text-muted d-block">BLOCK ID</small>
                            <h3 class="fw-bold">#<%= rs.getInt("repay_id") %></h3>
                            <% if(isValid) { %>
                                <span class="badge bg-success-subtle text-success rounded-pill"><i class="fa fa-check"></i> VALID</span>
                            <% } else { %>
                                <span class="badge bg-danger-subtle text-danger rounded-pill"><i class="fa fa-warning"></i> TAMPERED</span>
                            <% } %>
                        </div>
                        <div class="col-md-10 ps-4">
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <small class="text-muted">TRANSACTION DATA</small>
                                    <div class="fw-bold">Repayment of ₹<%= rs.getDouble("amount_paid") %> for Loan #<%= rs.getInt("loan_id") %></div>
                                    <small class="text-secondary">Timestamp: <%= rs.getTimestamp("payment_date") %></small>
                                </div>
                                <div class="col-md-6 text-md-end">
                                    <small class="text-muted">PREVIOUS HASH</small>
                                    <div class="hash-box text-muted"><%= prevHash %></div>
                                </div>
                            </div>
                            <div>
                                <small class="text-muted">CURRENT BLOCK HASH (SHA-256)</small>
                                <div class="hash-box text-primary fw-bold"><%= currentHash %></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        <%
                }
            } catch (Exception e) { e.printStackTrace(); }
        %>
        
        <div class="text-center my-5">
            <a href="index.jsp" class="btn btn-secondary rounded-pill px-4">Back to Dashboard</a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

