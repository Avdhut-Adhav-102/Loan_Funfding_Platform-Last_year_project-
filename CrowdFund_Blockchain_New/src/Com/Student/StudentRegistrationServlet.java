package Com.Student;

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

@WebServlet("/StudentRegistrationServlet")
public class StudentRegistrationServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Capture Form Data
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String contact = request.getParameter("contact");
        String plainPassword = request.getParameter("password");
        //String university = request.getParameter("university");
        //String degree = request.getParameter("degree");
        //String year = request.getParameter("year");
        //String bio = request.getParameter("bio");
        
        // Hash password before storing
        String hashedPassword = HashUtil.hashPassword(plainPassword);
        
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Start Transaction

            // 2. Insert into 'users' table
            String userQuery = "INSERT INTO users (full_name, email, contact, password, role) VALUES (?, ?, ?, ?, 'student')";
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
                    
                    // 3. Insert into 'student_profiles' table
                    /*String profileQuery = "INSERT INTO student_profiles (user_id, university_name, degree_name, current_year, bio) VALUES (?, ?, ?, ?, ?)";
                    PreparedStatement psProfile = conn.prepareStatement(profileQuery);
                    psProfile.setInt(1, userId);
                    psProfile.setString(2, university);
                    psProfile.setString(3, degree);
                    psProfile.setString(4, year);
                    psProfile.setString(5, bio);
                    
                    psProfile.executeUpdate();*/
                    
                    // Commit the transaction
                    conn.commit();
                    response.sendRedirect("index.jsp?msg=Registration Success! Please Login");
                }
            } else {
                conn.rollback();
                response.sendRedirect("RegisterStudent.jsp?error=Registration Failed");
            }
            
        } catch (Exception e) {
            try { if(conn != null) conn.rollback(); } catch(Exception ex) {}
            e.printStackTrace();
            response.sendRedirect("RegisterStudent.jsp?error=Database Error: " + e.getMessage());
        } finally {
            try { if(conn != null) conn.close(); } catch(Exception ex) {}
        }
    }
}