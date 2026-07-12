package Com.Student;

import Com.educhain.util.DBConnection; 
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig; // REQUIRED
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/UploadProfileServlet")
@MultipartConfig // THIS IS THE FIX. Without this, all getParameter calls return NULL
public class UploadProfileServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null) {
            response.sendRedirect("login.jsp?error=Session Expired");
            return;
        }

        // 1. Capture Form Parameters 
        // These will now work correctly because of @MultipartConfig
        String email = request.getParameter("email");
        String adharNo = request.getParameter("adhar_no");
        String panNo = request.getParameter("pan_no");
        String universityName = request.getParameter("university_name");
        String degreeName = request.getParameter("degree_name");
        String currentYear = request.getParameter("current_year");
        String bio = request.getParameter("bio");

        try (Connection conn = DBConnection.getConnection()) {
            
            // 2. CHECK: Does a record exist for this UserID or Email?
            String checkSql = "SELECT user_id FROM student_profiles WHERE user_id = ? OR email = ?";
            PreparedStatement psCheck = conn.prepareStatement(checkSql);
            psCheck.setInt(1, userId);
            psCheck.setString(2, email);
            ResultSet rs = psCheck.executeQuery();

            if (rs.next()) {
                // 3. RECORD EXISTS -> USE UPDATE QUERY
                // This updates ONLY the text fields and leaves your Documents (Paths) alone
                String updateSql = "UPDATE student_profiles SET email=?, adhar_no=?, pan_no=?, "
                                 + "university_name=?, degree_name=?, current_year=?, bio=? "
                                 + "WHERE user_id = ?";
                
                PreparedStatement psUpdate = conn.prepareStatement(updateSql);
                psUpdate.setString(1, email);
                psUpdate.setString(2, adharNo);
                psUpdate.setString(3, panNo);
                psUpdate.setString(4, universityName);
                psUpdate.setString(5, degreeName);
                psUpdate.setString(6, currentYear);
                psUpdate.setString(7, bio);
                psUpdate.setInt(8, userId); 
                
                psUpdate.executeUpdate();
                response.sendRedirect("StudentDashboard.jsp?msg=Profile updated successfully in your existing record!");

            } else {
                // 4. NO RECORD EXISTS -> USE INSERT QUERY
                String insertSql = "INSERT INTO student_profiles (user_id, email, adhar_no, pan_no, university_name, "
                                 + "degree_name, current_year, bio) "
                                 + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                
                PreparedStatement psInsert = conn.prepareStatement(insertSql);
                psInsert.setInt(1, userId);
                psInsert.setString(2, email);
                psInsert.setString(3, adharNo);
                psInsert.setString(4, panNo);
                psInsert.setString(5, universityName);
                psInsert.setString(6, degreeName);
                psInsert.setString(7, currentYear);
                psInsert.setString(8, bio);
                
                psInsert.executeUpdate();
                response.sendRedirect("StudentDashboard.jsp?msg=New profile record created successfully!");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("CompleteProfile.jsp?error=Database Error: " + e.getMessage());
        }
    }
}