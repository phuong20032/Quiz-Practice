/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

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
@WebServlet(name = "LessonDetail", urlPatterns = {"/lesson-detail"})
public class LessonDetail extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        if (user != null) {
            LessonDAO lessonDAO = new LessonDAO();
            int lessonId = Integer.parseInt(request.getParameter("id"));
            Lesson lesson = lessonDAO.getLessonById(lessonId);

            request.setAttribute("s", lesson);
            System.out.println(lesson);
            // for quiz 
            QuizDAO quizDAO = new QuizDAO();
            List<Quiz> listQuizes = quizDAO.getAllQuizByLesson(lessonId);
            request.setAttribute("quiz", listQuizes);
            System.out.println(listQuizes.size());
            // get all lesson not in subject
            List<Quiz> list = quizDAO.getAllQuizNotInLesson(lessonId);
            request.setAttribute("listQ", list);
            request.getRequestDispatcher("lesson-detail.jsp").forward(request, response);
        } else {
            response.sendRedirect("home");
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
}
