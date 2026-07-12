package Com.Admin;

import Com.educhain.util.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/VerifyStudentServlet")
public class VerifyStudentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String userId = request.getParameter("user_id");
        String status = request.getParameter("status"); // 1 for verify, 0 for reject

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE student_profiles SET is_verified = ? WHERE user_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(status));
            ps.setInt(2, Integer.parseInt(userId));
            
            ps.executeUpdate();
            
            String msg = (status.equals("1")) ? "Student Verified!" : "Student Rejected!";
            response.sendRedirect("AdminDashboard.jsp?msg=" + msg);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("AdminDashboard.jsp?error=Operation Failed");
        }
    }
}