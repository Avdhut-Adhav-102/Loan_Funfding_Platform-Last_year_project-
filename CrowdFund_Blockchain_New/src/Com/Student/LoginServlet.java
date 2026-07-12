package Com.Student;

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

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        HttpSession session = request.getSession();

        // 1. STATIC ADMIN AUTHENTICATION (Merged as requested)
        if ("admin@gmail.com".equals(email) && "admin".equals(password)) {
            session.setAttribute("userId", 0); // Assign 0 for System Admin
            session.setAttribute("userName", "System Administrator");
            session.setAttribute("userRole", "admin");
            
            response.sendRedirect("AdminDashboard.jsp");
            return; // Exit method here for Admin
        }

        // 2. DATABASE AUTHENTICATION (For Students and Lenders)
        
        // Hash the input password to compare with the hashed password in DB
        String hashedPassword = HashUtil.hashPassword(password);
        
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, hashedPassword);
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                // Login Success
                String role = rs.getString("role");
                String fullName = rs.getString("full_name");
                int userId = rs.getInt("id");

                // Store user details in session
                session.setAttribute("userId", userId);
                session.setAttribute("userName", fullName);
                session.setAttribute("studentEmail", email); // Storing email in session
                session.setAttribute("userRole", role);

                // REDIRECT based on Role stored in Database
                if ("student".equals(role)) {
                    response.sendRedirect("StudentDashboard.jsp");
                } else if ("lender".equals(role)) {
                    response.sendRedirect("LenderDashboard.jsp");
                } else if ("admin".equals(role)) {
                    // This handles if you ever create dynamic admins in the DB
                    response.sendRedirect("AdminDashboard.jsp");
                }
            } else {
                // Login Failed
                response.sendRedirect("index.jsp?error=Invalid Credentials");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?error=Database Error");
        }
    }
}

/*package Com.Student;

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

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // Hash the input password to compare with the hashed password in DB
        String hashedPassword = HashUtil.hashPassword(password);
        
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, hashedPassword);
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                // Login Success
                String role = rs.getString("role");
                String fullName = rs.getString("full_name");
                int userId = rs.getInt("id");

                // Create a Session to keep the user logged in
                HttpSession session = request.getSession();
                session.setAttribute("userId", userId);
                session.setAttribute("userName", fullName);
                session.setAttribute("studentEmail", request.getParameter("email"));
                session.setAttribute("userRole", role);

                // REDIRECT based on Role
                if ("student".equals(role)) {
                    response.sendRedirect("StudentDashboard.jsp");
                } else if ("lender".equals(role)) {
                    response.sendRedirect("LenderDashboard.jsp");
                } else if ("admin".equals(role)) {
                    response.sendRedirect("AdminDashboard.jsp");
                }
            } else {
                // Login Failed
                response.sendRedirect("index.jsp?error=Invalid Credentials");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?error=Database Error");
        }
    }
}*/