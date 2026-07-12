package Com.Student;

import Com.educhain.util.DBConnection; 
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet("/UploadDocument")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, 
                 maxFileSize = 1024 * 1024 * 10,      
                 maxRequestSize = 1024 * 1024 * 50)   
public class UploadDocument extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null) {
            response.sendRedirect("login.jsp?error=Session Expired");
            return;
        }

        // Dynamically resolve the absolute path to the WebContent/uploads directory
        String uploadDirectory = request.getServletContext().getRealPath("/uploads") + File.separator;

        Connection conn = null;
        String userEmail = null;

        try {
            conn = DBConnection.getConnection();

            // 1. FETCH THE ACTUAL EMAIL FROM THE USERS TABLE
            // This ensures we have the correct email for the WHERE clause
            String getEmailSql = "SELECT email FROM users WHERE id = ?";
            PreparedStatement psEmail = conn.prepareStatement(getEmailSql);
            psEmail.setInt(1, userId);
            ResultSet rsEmail = psEmail.executeQuery();
            
            if (rsEmail.next()) {
                userEmail = rsEmail.getString("email");
            }

            if (userEmail == null || userEmail.isEmpty()) {
                response.sendRedirect("CompleteProfile.jsp?error=User email not found");
                return;
            }

            // 2. PROCESS FILES
            File uploadDir = new File(uploadDirectory);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            Part idPart = request.getPart("id_proof");
            String idFileName = userId + "_ID_" + extractFileName(idPart);
            idPart.write(uploadDirectory + idFileName);

            Part letterPart = request.getPart("admission_letter");
            String letterFileName = userId + "_Letter_" + extractFileName(letterPart);
            letterPart.write(uploadDirectory + letterFileName);

            // 3. THE STRICT UPDATE QUERY
            // This query ONLY changes 2 columns. It is IMPOSSIBLE for this to nullify other columns.
            String updateSql = "UPDATE student_profiles SET id_proof_path = ?, admission_letter_path = ? WHERE email = ?";
            
            PreparedStatement psUpdate = conn.prepareStatement(updateSql);
            psUpdate.setString(1, idFileName);
            psUpdate.setString(2, letterFileName);
            psUpdate.setString(3, userEmail); // The key identifier
            
            int rowsAffected = psUpdate.executeUpdate();

            if (rowsAffected > 0) {
                // Success
                response.sendRedirect("StudentDashboard.jsp?msg=Documents Updated Successfully!");
            } else {
                // If this happens, it means there is no row in student_profiles with this email yet
                response.sendRedirect("CompleteProfile.jsp?error=Please fill your profile details first before uploading documents.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("CompleteProfile.jsp?error=System Error: " + e.getMessage());
        } finally {
            try { if(conn != null) conn.close(); } catch(Exception ex) {}
        }
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                String fileName = s.substring(s.indexOf("=") + 2, s.length() - 1);
                return new File(fileName).getName();
            }
        }
        return "file_" + System.currentTimeMillis();
    }
}