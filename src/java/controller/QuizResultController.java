/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.google.gson.Gson;
import dal.QuestionDAO;
import dal.QuizDAO;
import dal.UserAttempQuizDAO;
import dal.UserQuizDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.*;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "QuizResultController", urlPatterns = {"/quiz-result"})
public class QuizResultController extends HttpServlet {
@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setDateHeader("Expires", 0); // Proxies.
    HttpSession session = request.getSession();
    User user = (User) session.getAttribute("account");

    if (user != null) {
        int quizId = Integer.parseInt(request.getParameter("quiz_id"));
        UserQuizDAO userQuizDAO = new UserQuizDAO();
        QuestionDAO questionDAO = new QuestionDAO();
        QuizDAO quizDAO = new QuizDAO();

        Quiz quiz = quizDAO.getById(quizId);
        List<Question> questions = questionDAO.getAllQuestionByQuiz(quizId);
        List<QuestionResult> questionResults = new ArrayList<>();
        UserAttempQuizDAO uaqdao = new UserAttempQuizDAO();
        for (Question q : questions) {
            QuestionResult qr = new QuestionResult();
            qr.setQuestion(q);
            qr.setAnswers(questionDAO.getAllAnswerByQuestion(q.getQuestion_id()));
            qr.setUserAnswer(userQuizDAO.getUserAnswer(user.getUser_id(), quizId, q.getQuestion_id()));
            qr.setCorrectAnswer(userQuizDAO.getCorrectAnswer(q.getQuestion_id()));
            questionResults.add(qr);
        }
         // Cập nhật số lần làm bài còn lại
        int timesLeft = uaqdao.getTimesLeft(user.getUser_id(), quizId, quiz.getAttemp_time());
        UserDoneQuiz userDoneQuiz = userQuizDAO.getByUserAndQuiz(user.getUser_id(), quizId);
        request.setAttribute("quiz", quiz);
        request.setAttribute("userDoneQuiz", userDoneQuiz);
        request.setAttribute("timesLeft", timesLeft);
        System.out.println(userDoneQuiz);
        questionResults.forEach(System.out::println);
        request.setAttribute("questionResults", questionResults);
       session.setAttribute("quizCompleted", true);
        request.getRequestDispatcher("quiz-result.jsp").forward(request, response);
    } else {
        response.sendRedirect("home");
    }
}


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
