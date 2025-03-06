/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dal.MajorDAO;
import dal.SubjectDAO;
import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;

import java.util.Calendar;
import java.sql.Date;
import java.util.List;
import model.Major;
import model.Subject;
import model.User;

/**
 *
 * @author ADMIN
 */
@MultipartConfig

@WebServlet(name = "AddSubjectController", urlPatterns = {"/admin/add-subject"})
public class AddSubjectController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        if (user != null && user.getRole().getRole_id() == 3) {
            MajorDAO majorDAO = new MajorDAO();
            UserDAO userDAO = new UserDAO();
            List<User> userList = userDAO.getAllUserByROle(2);
            System.out.println(userList.size());
            List<Major> listMajors = majorDAO.getAll();
            request.setAttribute("major", listMajors);
            request.setAttribute("users", userList);
            request.getRequestDispatcher("add-subject.jsp").forward(request, response);
        } else {
            response.sendRedirect("../home");
        }

    }

   @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        SubjectDAO subjectDAO = new SubjectDAO();
        if (user != null && user.getRole().getRole_id() == 3) {
            int major_id = Integer.parseInt(request.getParameter("major_id"));
            String subject_name = request.getParameter("subject_name");

            
           if (subjectDAO.isSubjectNameExists(subject_name)) {
                session.setAttribute("notificationErr", "Subject name already exists.");
                request.setAttribute("subject_name", subject_name);
                request.setAttribute("title", request.getParameter("title"));
                request.setAttribute("content", request.getParameter("content"));
                
                // Retrieve major and user data for redisplay
                MajorDAO majorDAO = new MajorDAO();
                UserDAO userDAO = new UserDAO();
                List<User> userList = userDAO.getAllUserByROle(2);
                List<Major> listMajors = majorDAO.getAll();
                
                request.setAttribute("major", listMajors);
                request.setAttribute("users", userList);
                
                request.getRequestDispatcher("add-subject.jsp").forward(request, response);
                return;
            }
            
            // Handle file upload
            Part filePart = request.getPart("image");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadDir = getServletContext().getRealPath("/static/upload/");
            File uploadDirFile = new File(uploadDir);
            if (!uploadDirFile.exists()) {
                uploadDirFile.mkdirs();
            }
            String relativePath = "static/upload/" + fileName;
            String fullPath = uploadDir + File.separator + fileName;
            filePart.write(fullPath);

            String title = request.getParameter("title");
            String content = request.getParameter("content");
            int status = Integer.parseInt(request.getParameter("status"));
            int userId = Integer.parseInt(request.getParameter("userId"));
            int flag = 1;
            UserDAO userDAO = new UserDAO();
            User owner = userDAO.getById(userId);
            Subject subject = new Subject(
                    subject_name,
                    user.getUser_id(),
                    new Date(Calendar.getInstance().getTimeInMillis()),
                    new Date(Calendar.getInstance().getTimeInMillis()),
                    status,
                    relativePath,  // Save the relative path in the database
                    major_id,
                    content,
                    title,
                    owner,
                    flag
            );
            try {
                boolean isAdd = subjectDAO.addSubject(subject);
                if (isAdd) {
                    session.setAttribute("notification", "Add subject successfully!");
                    response.sendRedirect("subject-list");
                } else {
                    session.setAttribute("notificationErr", "Add failed");
                    request.setAttribute("subject_name", subject_name);
                    request.setAttribute("title", title);
                    request.setAttribute("content", content);
                    response.sendRedirect("add-subject");
                }
            } catch (Exception e) {
                session.setAttribute("notificationErr", "Add failed: " + e.toString());
                response.sendRedirect("add-subject");
            }
        } else {
            response.sendRedirect("../home");
        }
    }
}