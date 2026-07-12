<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, Com.educhain.util.DBConnection" %>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) { response.sendRedirect("login.jsp"); return; }

    // Fetch Active Loan Details to show the student how much they owe
    double totalNeeded = 0, raised = 0;
    int loanId = 0;
    String loanTitle = "No Active Loan";

    try (Connection conn = DBConnection.getConnection()) {
        String sql = "SELECT * FROM loan_requests WHERE user_id = ? AND status != 'COMPLETED' LIMIT 1";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            loanId = rs.getInt("loan_id");
            loanTitle = rs.getString("loan_title");
            totalNeeded = rs.getDouble("amount_required");
            raised = rs.getDouble("amount_raised");
        }
    } catch (Exception e) { e.printStackTrace(); }
%>
<!DOCTYPE html>
<html>
<head>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/logo.png">
    <title>Repay Installments | EduChain</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background-color: #f0f2f5; font-family: 'Poppins', sans-serif; }
        .hero-section { background: #198754; color: white; padding: 40px 0; } /* Green theme for repayment/success */
        .repay-card { border: none; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); }
        .stats-box { background: #fff; border-top: 5px solid #198754; padding: 20px; border-radius: 10px; }
        .blockchain-table { font-size: 0.85rem; background: #fff; border-radius: 10px; overflow: hidden; }
        .blockchain-table thead { background: #f8f9fa; }
        .hash-text { font-family: 'Courier New', monospace; color: #6c757d; font-size: 0.75rem; }
    </style>
</head>
<body>

    <!-- Hero Section -->
    <div class="hero-section text-center">
        <div class="container">
            <h2><i class="fa-solid fa-hand-holding-hand me-2"></i> Repayment Center</h2>
            <p>Your path to financial freedom. Every repayment is verified on the EduChain Ledger.</p>
        </div>
    </div>

    <div class="container my-5">
        <div class="row">
            
            <!-- Left: Repayment Form -->
            <div class="col-lg-7">
                <div class="card repay-card p-4 mb-4">
                    <h4 class="mb-4">Submit Installment</h4>
                    
                    <% if(loanId == 0) { %>
                        <div class="alert alert-warning">
                            <i class="fa fa-info-circle"></i> You do not have any active loans to repay.
                        </div>
                    <% } else { %>
                        <form action="RepayLoanServlet" method="post">
                            <input type="hidden" name="loan_id" value="<%= loanId %>">
                            
                            <div class="mb-3">
                                <label class="form-label">Selected Loan Campaign</label>
                                <input type="text" class="form-control bg-light" value="<%= loanTitle %>" readonly>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Installment Amount (USD)</label>
                                <div class="input-group">
                                    <span class="input-group-text">₹</span>
                                    <input type="number" name="amount" class="form-control" placeholder="Enter amount to pay" required>
                                </div>
                                <small class="text-muted">Remaining Balance: ₹<%= (totalNeeded - raised) %></small>
                            </div>

                            <div class="alert alert-success small">
                                <i class="fa-solid fa-shield-halved"></i> <b>Blockchain Protocol:</b> Upon payment, a new block will be generated linking to the previous transaction hash.
                            </div>

                            <div class="d-grid">
                                <button type="submit" class="btn btn-success btn-lg rounded-pill">Pay Installment Now</button>
                            </div>
                        </form>
                    <% } %>
                </div>
            </div>

            <!-- Right: Loan Status Summary -->
            <div class="col-lg-5">
                <div class="stats-box shadow-sm mb-4">
                    <h5 class="fw-bold"><i class="fa fa-chart-line text-success me-2"></i> Loan Progress</h5>
                    <div class="mt-3">
                        <div class="d-flex justify-content-between mb-1 small">
                            <span>Repayment Progress</span>
                            <span><%= Math.round((raised/totalNeeded)*100) %>%</span>
                        </div>
                        <div class="progress mb-3" style="height: 10px;">
                            <div class="progress-bar bg-success" style="width: <%= (raised/totalNeeded)*100 %>%"></div>
                        </div>
                        <ul class="list-unstyled small text-muted">
                            <li class="mb-2">Total Debt: <b>₹<%= totalNeeded %></b></li>
                            <li class="mb-2">Total Paid: <b>₹<%= raised %></b></li>
                            <li>Pending: <b class="text-danger">₹<%= (totalNeeded - raised) %></b></li>
                        </ul>
                    </div>
                </div>

                <div class="card border-0 shadow-sm p-4 text-center bg-white">
                    <i class="fa-solid fa-building-columns fa-3x text-success mb-3"></i>
                    <h6>Build Your Credit Score</h6>
                    <p class="small text-muted">Timely repayments are recorded on the blockchain and help you qualify for future higher education loans.</p>
                </div>
            </div>
        </div>

        <!-- Bottom: Blockchain Transaction History -->
        <div class="row mt-4">
            <div class="col-12">
                <h4 class="mb-3"><i class="fa-solid fa-link me-2"></i> Immutable Repayment Ledger</h4>
                <div class="table-responsive shadow-sm blockchain-table">
                    <table class="table table-hover mb-0">
                        <thead>
                            <tr>
                                <th>Block ID</th>
                                <th>Date</th>
                                <th>Amount</th>
                                <th>Previous Hash</th>
                                <th>Transaction Hash</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                try (Connection conn = DBConnection.getConnection()) {
                                    String histSql = "SELECT * FROM repayments WHERE loan_id = ? ORDER BY repay_id DESC";
                                    PreparedStatement psHist = conn.prepareStatement(histSql);
                                    psHist.setInt(1, loanId);
                                    ResultSet rsHist = psHist.executeQuery();
                                    
                                    boolean hasRecords = false;
                                    while (rsHist.next()) {
                                        hasRecords = true;
                            %>
                            <tr>
                                <td>#<%= rsHist.getInt("repay_id") %></td>
                                <td><%= rsHist.getTimestamp("payment_date") %></td>
                                <td class="fw-bold text-success">₹<%= rsHist.getDouble("amount_paid") %></td>
                                <td class="hash-text"><%= rsHist.getString("previous_hash") %></td>
                                <td class="hash-text text-primary"><%= rsHist.getString("current_hash") %></td>
                                <td><span class="badge bg-light text-success border border-success">Verified</span></td>
                            </tr>
                            <% 
                                    }
                                    if(!hasRecords) {
                                        out.println("<tr><td colspan='6' class='text-center py-4 text-muted'>No transactions found on the ledger.</td></tr>");
                                    }
                                } catch (Exception e) {}
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
    <p class="text-center mt-4">
        <a href="StudentDashboard.jsp" class="text-secondary text-decoration-none">
            <i class="fa fa-arrow-left me-1"></i> Back to Dashboard
        </a>
    </p>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

