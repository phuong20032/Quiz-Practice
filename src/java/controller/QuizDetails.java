/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.QuestionDAO;
import dal.QuizDAO;
import dal.UserAttempQuizDAO;
import dal.UserQuizDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Question;
import model.Quiz;
import model.User;
import model.UserDoneQuiz;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "QuizDetails", urlPatterns = {"/quiz-detail"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class QuizDetails extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        if (user != null) {

            QuizDAO quizDAO = new QuizDAO();
            int quizId = Integer.parseInt(request.getParameter("id"));
            Quiz quiz = quizDAO.getById(quizId);
            request.setAttribute("s", quiz);

            // for question 
            QuestionDAO questionDAO = new QuestionDAO();
            List<Question> listQuestion = questionDAO.getAllQuestionByQuiz(quizId);
            request.setAttribute("questions", listQuestion);

            UserDoneQuiz userDoneQuiz = new UserQuizDAO().getByUserAndQuiz(user.getUser_id(), quizId);
            UserAttempQuizDAO uaqdao = new UserAttempQuizDAO();
            int timesLeft = uaqdao.getTimesLeft(user.getUser_id(), quizId, quiz.getAttemp_time());
            request.setAttribute("userDoneQuiz", userDoneQuiz);
            request.setAttribute("timesLeft", timesLeft);
            
            request.getRequestDispatcher("quiz-detail.jsp").forward(request, response);
        } else {
            response.sendRedirect("home");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
}
