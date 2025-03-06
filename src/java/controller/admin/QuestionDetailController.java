/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dal.QuestionDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Answer;
import model.Question;
import model.User;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "QuestionDetail", urlPatterns = {"/admin/question-detail"})
public class QuestionDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        if (user != null && user.getRole().getRole_id() != 1) {
            int questionId = Integer.parseInt(request.getParameter("id"));
            QuestionDAO questionDAO = new QuestionDAO();
            Question question = questionDAO.getAllQuestionByID(questionId);
            request.setAttribute("question", question);

            List<Answer> answers = questionDAO.getAllAnswerByQuestion(questionId);
            request.setAttribute("answers", answers);

            request.getRequestDispatcher("question-detail.jsp").forward(request, response);
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

        QuestionDAO questionDAO = new QuestionDAO();
        if (user != null && user.getRole().getRole_id() != 1) {

            if ("updateCorrectAnswer".equals(action)) {
                int questionId = Integer.parseInt(request.getParameter("questionId"));
                int correctAnswerId = Integer.parseInt(request.getParameter("correctAnswerId"));

                try {
                    questionDAO.updateCorrectAnswer(questionId, correctAnswerId);
                    session.setAttribute("notification", "Update correct answer successfully!");
                } catch (Exception e) {
                    session.setAttribute("notificationErr", "Update Failed: " + e.getMessage());
                }

                response.sendRedirect("../admin/question-detail?id=" + questionId);
            }
            if ("delete".equals(action)) {
                int questionId = Integer.parseInt(request.getParameter("questionId"));
                int answerId = Integer.parseInt(request.getParameter("answerId"));

                try {
                    questionDAO.deleteAnswerFromQuestion(questionId, answerId);
                    response.getWriter().write("success");
                } catch (Exception e) {
                    response.getWriter().write("error");
                }
            } else if ("edit".equals(action)) {
                int questionId = Integer.parseInt(request.getParameter("id"));
                String newQuestionName = request.getParameter("name");

                try {
                    Question currentQuestion = questionDAO.getAllQuestionByID(questionId);
                    String currentQuestionName = currentQuestion.getQuestion_name();

                    if (!newQuestionName.equals(currentQuestionName)) {
                        if (questionDAO.doesQuestionExist(newQuestionName)) {
                            session.setAttribute("notificationErr", "Question with this name already exists.");
                        } else {
                            questionDAO.updateQuestion(questionId, newQuestionName);
                            session.setAttribute("notification", "Update question successfully!");
                        }
                    } else {
                        session.setAttribute("notification", "No changes were made.");
                    }
                } catch (Exception e) {
                    session.setAttribute("notificationErr", "Update Failed: " + e.getMessage());
                }

                response.sendRedirect("../admin/question-detail?id=" + questionId);
            }
        } else {
            response.sendRedirect("../home");
        }
    }
}
