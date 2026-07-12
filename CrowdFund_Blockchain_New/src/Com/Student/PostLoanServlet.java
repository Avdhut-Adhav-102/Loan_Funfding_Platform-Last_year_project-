package Com.Student;

import Com.educhain.util.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/PostLoanServlet")
public class PostLoanServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String email = session.getAttribute("studentEmail").toString();
        // 1. Get Parameters
        String title = request.getParameter("loan_title");
        String amount = request.getParameter("amount");
        String tenure = request.getParameter("tenure");
        String description = request.getParameter("description");

        // 2. Blockchain Simulation (Generating a unique hash for this request)
        // Later, we will use actual SHA-256 with previous block links
        String blockHash = UUID.randomUUID().toString().replace("-", "").substring(0, 20);

        try (Connection conn = DBConnection.getConnection()) {
            
            String sql = "INSERT INTO loan_requests (user_id, email, loan_title, amount_required, tenure_months, description, block_hash) "
                       + "VALUES (?, ?, ?, ?, ?, ?, ?)";
            
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setString(2, email);
            ps.setString(3, title);
            ps.setDouble(4, Double.parseDouble(amount));
            ps.setInt(5, Integer.parseInt(tenure));
            ps.setString(6, description);
            ps.setString(7, "0x" + blockHash); // Simulating a hex hash

            int result = ps.executeUpdate();

            if (result > 0) {
                // Success: Redirect back to StudentDashboard with success message
                response.sendRedirect("StudentDashboard.jsp?msg=Loan Campaign Launched Successfully!");
            } else {
                response.sendRedirect("PostLoan.jsp?error=Could not save campaign.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("PostLoan.jsp?error=System Error: " + e.getMessage());
        }
    }
}