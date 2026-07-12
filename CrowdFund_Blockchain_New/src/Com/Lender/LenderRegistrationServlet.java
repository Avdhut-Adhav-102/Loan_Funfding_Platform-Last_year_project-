package Com.Lender;

import Com.educhain.util.DBConnection;
import Com.educhain.util.HashUtil;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/LenderRegistrationServlet")
public class LenderRegistrationServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Capture Form Data
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String contact = request.getParameter("contact");
        String password = request.getParameter("password");
        String budget = request.getParameter("budget");
        String institution = request.getParameter("institution");

        // Hash the password for security (Blockchain standard)
        String hashedPassword = HashUtil.hashPassword(password);

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Start Transaction

            // 2. Insert into 'users' table
            String userQuery = "INSERT INTO users (full_name, email, contact, password, role) VALUES (?, ?, ?, ?, 'lender')";
            PreparedStatement psUser = conn.prepareStatement(userQuery, Statement.RETURN_GENERATED_KEYS);
            psUser.setString(1, fullName);
            psUser.setString(2, email);
            psUser.setString(3, contact);
            psUser.setString(4, hashedPassword);
            
            int affectedRows = psUser.executeUpdate();
            
            if (affectedRows > 0) {
                // Get the generated User ID
                ResultSet rs = psUser.getGeneratedKeys();
                if (rs.next()) {
                    int userId = rs.getInt(1);
                    
                    // 3. Insert into 'lender_profiles' table
                    // Note: We give them a default wallet balance of 5000.00 for simulation
                    String lenderQuery = "INSERT INTO lender_profiles (user_id, email, institution_name, investment_budget, wallet_balance) VALUES (?, ?, ?, ?, ?)";
                    PreparedStatement psLender = conn.prepareStatement(lenderQuery);
                    psLender.setInt(1, userId);
                    psLender.setString(2, email);
                    psLender.setString(3, institution);
                    psLender.setString(4, budget);
                    psLender.setDouble(5, 5000.00); // Initial simulated capital
                    
                    psLender.executeUpdate();
                    
                    // Commit the transaction
                    conn.commit();
                    response.sendRedirect("index.jsp?msg=Investor Account Created! Please Login.");
                }
            } else {
                conn.rollback();
                response.sendRedirect("RegisterLender.jsp?error=Registration Failed");
            }
            
        } catch (java.sql.SQLIntegrityConstraintViolationException e) {
            // Handle duplicate email error
            try { if(conn != null) conn.rollback(); } catch(Exception ex) {}
            response.sendRedirect("RegisterLender.jsp?error=Email already registered. Try another.");
        } catch (Exception e) {
            try { if(conn != null) conn.rollback(); } catch(Exception ex) {}
            e.printStackTrace();
            response.sendRedirect("RegisterLender.jsp?error=System Error: " + e.getMessage());
        } finally {
            try { if(conn != null) conn.close(); } catch(Exception ex) {}
        }
    }
}