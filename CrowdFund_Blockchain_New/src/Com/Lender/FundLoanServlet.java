package Com.Lender;

import Com.Blockchain.BlockchainUtils; // Using the SHA-256 class we created earlier
import Com.educhain.util.DBConnection;
import java.io.IOException;
import java.sql.*;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/FundLoanServlet")
public class FundLoanServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer lenderUserId = (Integer) session.getAttribute("userId");
        String loanId = request.getParameter("loan_id");
        double investAmount = Double.parseDouble(request.getParameter("invest_amount"));

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Enable Transaction Management

            // 1. Check Lender's Wallet Balance
            String walletSql = "SELECT wallet_balance FROM lender_profiles WHERE user_id = ?";
            PreparedStatement psWallet = conn.prepareStatement(walletSql);
            psWallet.setInt(1, lenderUserId);
            ResultSet rsW = psWallet.executeQuery();
            
            if (rsW.next() && rsW.getDouble("wallet_balance") >= investAmount) {
                
                // 2. Generate Blockchain Hash for this Investment
                String txData = lenderUserId + loanId + investAmount + System.currentTimeMillis();
                String txHash = "0x" + BlockchainUtils.calculateHash(txData).substring(0, 30);

                // 3. Update Lender Profile (Subtract Balance, Add to Invested)
                String upLender = "UPDATE lender_profiles SET wallet_balance = wallet_balance - ?, "
                                + "total_invested = total_invested + ? WHERE user_id = ?";
                PreparedStatement psUpL = conn.prepareStatement(upLender);
                psUpL.setDouble(1, investAmount);
                psUpL.setDouble(2, investAmount);
                psUpL.setInt(3, lenderUserId);
                psUpL.executeUpdate();

                // 4. Update Loan Request (Add Raised Amount)
                String upLoan = "UPDATE loan_requests SET amount_raised = amount_raised + ? WHERE loan_id = ?";
                PreparedStatement psUpLoan = conn.prepareStatement(upLoan);
                psUpLoan.setDouble(1, investAmount);
                psUpLoan.setInt(2, Integer.parseInt(loanId));
                psUpLoan.executeUpdate();

                // 5. Check if Loan is 100% funded, if so, update status
                String checkFunded = "UPDATE loan_requests SET status = 'FUNDED' WHERE loan_id = ? AND amount_raised >= amount_required";
                PreparedStatement psCheck = conn.prepareStatement(checkFunded);
                psCheck.setInt(1, Integer.parseInt(loanId));
                psCheck.executeUpdate();

                // 6. Log the Investment with Hash
                String logInv = "INSERT INTO investments (lender_id, loan_id, investment_amount, transaction_hash) VALUES (?, ?, ?, ?)";
                PreparedStatement psLog = conn.prepareStatement(logInv);
                psLog.setInt(1, lenderUserId);
                psLog.setInt(2, Integer.parseInt(loanId));
                psLog.setDouble(3, investAmount);
                psLog.setString(4, txHash);
                psLog.executeUpdate();

                conn.commit();
                response.sendRedirect("LenderDashboard.jsp?msg=Investment Successful! Hash: " + txHash);
            } else {
                response.sendRedirect("LenderDashboard.jsp?error=Insufficient Wallet Balance.");
            }

        } catch (Exception e) {
            try { if(conn != null) conn.rollback(); } catch(Exception ex) {}
            e.printStackTrace();
            response.sendRedirect("Marketplace.jsp?error=Transaction Failed.");
        }
    }
}