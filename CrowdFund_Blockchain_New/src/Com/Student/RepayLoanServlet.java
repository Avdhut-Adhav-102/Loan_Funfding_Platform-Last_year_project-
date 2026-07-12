package Com.Student;

import Com.Blockchain.BlockchainUtils;
import Com.educhain.util.DBConnection;
import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/RepayLoanServlet")
public class RepayLoanServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    	HttpSession session = request.getSession();
        String email = session.getAttribute("studentEmail").toString();
        
    	String loanId = request.getParameter("loan_id");
        String amount = request.getParameter("amount");
        
        try (Connection conn = DBConnection.getConnection()) {
            // 1. GET THE HASH OF THE LAST REPAYMENT (The "Previous Hash")
            String lastHash = "0"; // Default for first repayment
            String getLastBlock = "SELECT current_hash FROM repayments ORDER BY repay_id DESC LIMIT 1";
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(getLastBlock);
            if (rs.next()) {
                lastHash = rs.getString("current_hash");
            }

            // 2. CREATE THE NEW HASH (The "Chaining" Algorithm)
            String dataToHash = lastHash + loanId + amount + System.currentTimeMillis();
            String currentHash = BlockchainUtils.calculateHash(dataToHash);

            // 3. STORE IN DATABASE
            String sql = "INSERT INTO repayments (loan_id, email, amount_paid, previous_hash, current_hash) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(loanId));
            ps.setString(2, email);
            ps.setDouble(3, Double.parseDouble(amount));
            ps.setString(4, lastHash);
            ps.setString(5, currentHash);
            ps.executeUpdate();

            // 4. Update the loan_requests table (amount_raised/status)
            String updateLoan = "UPDATE loan_requests SET amount_raised = amount_raised + ? WHERE loan_id = ?";
            PreparedStatement psUpdate = conn.prepareStatement(updateLoan);
            psUpdate.setDouble(1, Double.parseDouble(amount));
            psUpdate.setInt(2, Integer.parseInt(loanId));
            psUpdate.executeUpdate();

            response.sendRedirect("RepayLoan.jsp?msg=Repayment Successful! Block Added to Chain.");
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}