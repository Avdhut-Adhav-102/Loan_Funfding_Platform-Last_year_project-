package Com.Admin;

import Com.educhain.util.DBConnection;
import Com.educhain.util.HashUtil;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        HttpSession session = request.getSession();

        // 1. STATIC ADMIN CHECK
        if ("admin@gmail.com".equals(email) && "admin".equals(password)) {
            session.setAttribute("userId", 0); // Assign 0 for System Admin
            session.setAttribute("userName", "System Administrator");
            session.setAttribute("userRole", "admin");
            
            response.sendRedirect("AdminDashboard.jsp");
            return; // Stop further execution
        }

        // 2. DATABASE CHECK FOR STUDENT / LENDER
        String hashedPassword = HashUtil.hashPassword(password);
        
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, hashedPassword);
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                String role = rs.getString("role");
                session.setAttribute("userId", rs.getInt("id"));
                session.setAttribute("userName", rs.getString("full_name"));
                session.setAttribute("userRole", role);

                if ("student".equals(role)) {
                    response.sendRedirect("StudentDashboard.jsp");
                } else if ("lender".equals(role)) {
                    response.sendRedirect("LenderDashboard.jsp");
                }
            } else {
                response.sendRedirect("index.jsp?error=Invalid Credentials");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?error=Server Error");
        }
    }
}