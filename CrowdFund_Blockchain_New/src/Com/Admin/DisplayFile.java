package Com.Admin;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DisplayFile")
public class DisplayFile extends HttpServlet {
    private final String UPLOAD_DIRECTORY = "B:\\OxygenWorkspace\\CrowdFund_Blockchain\\WebContent\\uploads\\";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fileName = request.getParameter("fileName");
        File file = new File(UPLOAD_DIRECTORY + fileName);

        if (file.exists()) {
            response.setContentType(getServletContext().getMimeType(fileName));
            response.setContentLength((int) file.length());
            FileInputStream in = new FileInputStream(file);
            OutputStream out = response.getOutputStream();

            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = in.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
            in.close();
            out.close();
        }
    }
}