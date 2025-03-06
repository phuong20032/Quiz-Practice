/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dal.LessonDAO;
import dal.MajorDAO;
import dal.SubjectDAO;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Calendar;
import java.sql.Date;
import java.util.List;
import model.Lesson;
import model.Major;
import model.Subject;
import model.User;

/**
 *
 * @author ADMIN
 */
@MultipartConfig
@WebServlet(name = "AdminSubjectDetailController", urlPatterns = {"/admin/subject-detail"})
public class SubjectDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        if (user != null && user.getRole().getRole_id() != 1) {
            MajorDAO majorDAO = new MajorDAO();
            SubjectDAO subjectDAO = new SubjectDAO();
            List<Major> listMajors = majorDAO.getAll();
            int subjectId = Integer.parseInt(request.getParameter("subjectId"));
            Subject subject = subjectDAO.getSubjectById(subjectId);
            UserDAO userDAO = new UserDAO();
            List<User> userList = userDAO.getAllUserByROle(2);

            request.setAttribute("users", userList);
            request.setAttribute("listM", listMajors);
            request.setAttribute("s", subject);

            // for lesson 
            LessonDAO lessonDAO = new LessonDAO();
            List<Lesson> listLesson = lessonDAO.getAllLessonBySubject(subjectId);
            request.setAttribute("lesson", listLesson);

            // get all lesson not in subject
            List<Lesson> list = lessonDAO.getAllLessonByNotInSubject(subjectId);
            request.setAttribute("listL", list);
            request.getRequestDispatcher("subject-detail.jsp").forward(request, response);
        } else {
            response.sendRedirect("../home");
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        String action = request.getParameter("action");
        SubjectDAO subjectDAO = new SubjectDAO();
        LessonDAO lessonDAO = new LessonDAO();
        if (user != null && user.getRole().getRole_id() == 3) {
            if (action.equals("edit")) {
                int subjectId = Integer.parseInt(request.getParameter("id"));
                Subject currentSubject = subjectDAO.getSubjectById(subjectId);
                int major_id = Integer.parseInt(request.getParameter("major_id"));
                String subject_name = request.getParameter("subject_name");
                String title = request.getParameter("title");
                String content = request.getParameter("content");
                int status = Integer.parseInt(request.getParameter("status"));
                int userId = Integer.parseInt(request.getParameter("userId"));
                int flag = 0;
                UserDAO userDAO = new UserDAO();
                User owner = userDAO.getById(userId);

                // Check if subject name already exists
                if (subjectDAO.isSubjectNameExist(subject_name, subjectId)) {
                    session.setAttribute("notificationErr", "Subject name already exists!");
                    response.sendRedirect("subject-detail?subjectId=" + subjectId);
                    return;
                }

                // Handle file upload
                Part filePart = request.getPart("image");
                String relativePath = currentSubject.getSubject_img(); // Keep current image if no new image is uploaded
                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    String uploadDir = getServletContext().getRealPath("/static/upload/");
                    File uploadDirFile = new File(uploadDir);
                    if (!uploadDirFile.exists()) {
                        uploadDirFile.mkdirs();
                    }
                    relativePath = "static/upload/" + fileName;
                    String fullPath = uploadDir + File.separator + fileName;
                    filePart.write(fullPath);
                }

                Subject subject = new Subject(
                        subjectId,
                        subject_name,
                        currentSubject.getCreator_id(),
                        currentSubject.getCreated_at(),
                        new Date(Calendar.getInstance().getTimeInMillis()),
                        status,
                        relativePath,
                        major_id,
                        content,
                        title,
                        owner,
                        flag
                );

                try {
                    boolean isUpdated = subjectDAO.editSubject(subject);
                    if (isUpdated) {
                        session.setAttribute("notification", "Subject updated successfully!");
                    } else {
                        session.setAttribute("notificationErr", "Update failed");
                    }
                } catch (Exception e) {
                    session.setAttribute("notificationErr", "Update failed: " + e.toString());
                }
                response.sendRedirect("subject-detail?subjectId=" + subjectId);
            }

            if (action.equals("remove")) {
                int subject_id = Integer.parseInt(request.getParameter("subjectId"));
                int lesson_id = Integer.parseInt(request.getParameter("lessonId"));
                try {
                    boolean isDelete = subjectDAO.removeLessonFromSubject(subject_id, lesson_id);
                    if (isDelete) {
                        session.setAttribute("notification", "Lesson remove successfully!");
                    }
                } catch (Exception e) {
                    session.setAttribute("notificationErr", e.toString());
                }
//                System.out.println(subject);
                response.sendRedirect("subject-detail?subjectId=" + subject_id);
            }
            if (action.equals("add")) {
                int subject_id = Integer.parseInt(request.getParameter("subjectId"));
                String[] lessonIds = request.getParameterValues("lessonIds[]");
                try {
                    lessonDAO.addLessonsToSubject(subject_id, lessonIds);
                    session.setAttribute("notification", "Lesson add successfully!");
                } catch (Exception e) {
                    session.setAttribute("notificationErr", e.toString());
                }
//                System.out.println(subject);
                response.sendRedirect("subject-detail?subjectId=" + subject_id);
            }
        } else {
            response.sendRedirect("../home");
        }
    }
}
