/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dal.LessonDAO;
import dal.QuizDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Lesson;
import model.Quiz;
import model.User;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "LessonDetailController", urlPatterns = {"/admin/lesson-detail"})
public class LessonDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        if (user != null && user.getRole().getRole_id() != 1) {

            LessonDAO lessonDAO = new LessonDAO();
            int lessonId = Integer.parseInt(request.getParameter("id"));
            Lesson lesson = lessonDAO.getLessonById(lessonId);

            request.setAttribute("s", lesson);

            // for quiz 
            QuizDAO quizDAO = new QuizDAO();
            List<Quiz> listQuizes = quizDAO.getAllQuizByLesson(lessonId);
            request.setAttribute("quiz", listQuizes);

            // get all lesson not in subject
            List<Quiz> list = quizDAO.getAllQuizNotInLesson(lessonId);
            request.setAttribute("listQ", list);
            request.getRequestDispatcher("lesson-detail.jsp").forward(request, response);
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
        QuizDAO quizDAO = new QuizDAO();
        if (user != null && user.getRole().getRole_id() != 1) {

            if (action.equals("edit")) {
                int id = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("name");
                String description = request.getParameter("description");

                // Check if lesson name already exists
                if (lessonDAO.isLessonNameExist(name, id)) {
                    session.setAttribute("notificationErr", "Lesson name already exists!");
                    response.sendRedirect("lesson-detail?id=" + id);
                    return;
                }

                try {
                    lessonDAO.updateLesson(name, description, id);
                    session.setAttribute("notification", "Lesson updated successfully!");
                } catch (Exception e) {
                    session.setAttribute("notificationErr", "Update failed: " + e.toString());
                }
                response.sendRedirect("lesson-detail?id=" + id);
            }
            if (action.equals("remove")) {
                int lessonId = Integer.parseInt(request.getParameter("lessonId"));
                int quizId = Integer.parseInt(request.getParameter("quizId"));

                try {
                    boolean isDelete = quizDAO.removeQuizFromLesson(lessonId, quizId);
                    if (isDelete) {
                        session.setAttribute("notification", "Quiz remove successfully!");
                    } else {
                        session.setAttribute("notificationErr", "Quizs remove Fail!");
                    }
                } catch (Exception e) {
                    session.setAttribute("notificationErr", e.toString());
                }
//                System.out.println(subject);
                response.sendRedirect("lesson-detail?id=" + lessonId);
            }
            if (action.equals("add")) {
                int lessonId = Integer.parseInt(request.getParameter("lessonId"));
                String[] lessonIds = request.getParameterValues("quizIds[]");
                try {
                    quizDAO.addQuizToLesson(lessonId, lessonIds);
                    session.setAttribute("notification", "Quiz add successfully!");
                } catch (Exception e) {
                    session.setAttribute("notificationErr", e.toString());
                }
//                System.out.println(subject);
                response.sendRedirect("lesson-detail?id=" + lessonId);
            }
        } else {
            response.sendRedirect("../home");
        }
    }
}
