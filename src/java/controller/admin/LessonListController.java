/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dal.LessonDAO;
import dal.SubjectDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;
import model.Lesson;
import model.Subject;
import model.User;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "LessonListController", urlPatterns = {"/admin/lesson-list"})
public class LessonListController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        if (user != null && user.getRole().getRole_id() != 1) {
            SubjectDAO subjectDAO = new SubjectDAO();
            LessonDAO lessonDAO = new LessonDAO();
            List<Subject> listSubject = subjectDAO.getAll();
            String paramSubject = request.getParameter("subject");
            if (paramSubject != null && !paramSubject.isEmpty()) {
                int subjectId = Integer.parseInt(paramSubject);
                Subject subject = subjectDAO.getSubjectById(subjectId);
                request.setAttribute("subject", subject);
            }
            String pageParam = request.getParameter("page");
            String searchParam = request.getParameter("search");
            String subjectParam = request.getParameter("subject");
            String statusParam = request.getParameter("status");
            Integer subjectId = (subjectParam != null && !subjectParam.isEmpty()) ? Integer.valueOf(subjectParam) : null;
            Integer status = (statusParam != null && !statusParam.isEmpty()) ? Integer.valueOf(statusParam) : null;

            int page = 1; // Default to the first page
            int pageSize = 6; // Set the desired page size
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
            }

            List<Lesson> lessons = lessonDAO.getAllLessonWithParam(searchParam, status, subjectId);
            List<Lesson> pagingLesson = lessonDAO.Paging(lessons, page, pageSize);

            request.setAttribute("lesson", pagingLesson);
            request.setAttribute("totalPages", lessons.size() % pageSize == 0 ? (lessons.size() / pageSize) : (lessons.size() / pageSize + 1));
            request.setAttribute("currentPage", page);
            request.setAttribute("searchParam", searchParam);
            request.setAttribute("subjectParam", subjectParam);
            request.setAttribute("statusParam", statusParam);
            request.setAttribute("listS", listSubject);
            request.getRequestDispatcher("lesson-list.jsp").forward(request, response);
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
        LessonDAO lessonDAO = new LessonDAO();
        if (user != null && user.getRole().getRole_id() != 1) {
            if (action.equals("add")) {
                try {
                    String name = request.getParameter("lesson_name");
                    String description = request.getParameter("description");

                    // Check if lesson name already exists
                    if (lessonDAO.isLessonNameExist(name)) {
                        session.setAttribute("notificationErr", "Lesson name already exists!");
                        response.sendRedirect("lesson-list");
                        return;
                    }

                    lessonDAO.addLesson(name, user.getUser_id(), 1, description);
                    session.setAttribute("notification", "Lesson added successfully!");
                } catch (SQLException ex) {
                    session.setAttribute("notificationErr", ex.toString());
                }
                response.sendRedirect("lesson-list");
            }
            if (action.equals("change-status")) {
                try {
                    int status = Integer.parseInt(request.getParameter("status"));
                    int id = Integer.parseInt(request.getParameter("lesson_id"));
                    System.out.println(status + "  " + id);
                    if (status == 1) {
                        lessonDAO.updateLessonStatus(id, 0);
                        session.setAttribute("notification", "Un publish successfully!");
                    }
                    if (status == 0) {
                        lessonDAO.updateLessonStatus(id, 1);
                        session.setAttribute("notification", "Publish successfully!");
                    }

                } catch (SQLException ex) {
                    session.setAttribute("notificationErr", ex.toString());
                }
                response.sendRedirect("lesson-list");
            }
        } else {
            response.sendRedirect("../home");
        }
    }
}
