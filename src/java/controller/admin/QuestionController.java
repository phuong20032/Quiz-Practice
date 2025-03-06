/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import Utils.ExcelUtils;
import dal.QuestionDAO;
import dal.QuizDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Question;
import model.Quiz;
import model.User;

/**
 *
 * @author ADMIN
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
@WebServlet(name = "QuestionController", urlPatterns = {"/admin/question-list"})
public class QuestionController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        if (user != null && user.getRole().getRole_id() != 1) {
            QuestionDAO questionDAO = new QuestionDAO();
            QuizDAO lessonDAO = new QuizDAO();
            List<Quiz> listQuiz = lessonDAO.getAllQuizWithParam(null, 1, null);

            String pageParam = request.getParameter("page");
            String searchParam = request.getParameter("search");
            String quizParam = request.getParameter("quiz");
            String statusParam = request.getParameter("status");
            Integer quizId = (quizParam != null && !quizParam.isEmpty()) ? Integer.valueOf(quizParam) : null;
            Integer status = (statusParam != null && !statusParam.isEmpty()) ? Integer.valueOf(statusParam) : null;

            int page = 1; // Default to the first page
            int pageSize = 6; // Set the desired page size
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
            }

            List<Question> questions = questionDAO.getAllQuestionWithParam(searchParam, status, quizId);
            List<Question> pagingQuestion = questionDAO.Paging(questions, page, pageSize);

            request.setAttribute("question", pagingQuestion);
            request.setAttribute("totalPages", questions.size() % pageSize == 0 ? (questions.size() / pageSize) : (questions.size() / pageSize + 1));
            request.setAttribute("currentPage", page);
            request.setAttribute("searchParam", searchParam);
            request.setAttribute("subjectParam", quizParam);
            request.setAttribute("statusParam", statusParam);
            request.setAttribute("listQuiz", listQuiz);
            request.getRequestDispatcher("question-list.jsp").forward(request, response);
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

        if (user != null && user.getRole().getRole_id() != 1 && "add".equals(action)) {
            Part filePart = request.getPart("file"); // Retrieves <input type="file" name="file">

            if (filePart.getSize() > 0) {
                try (InputStream fileContent = filePart.getInputStream()) {
                    List<String> errors = new ArrayList<>();
                    List<Question> questions = ExcelUtils.readQuestionsFromExcel(fileContent, session);

                    QuestionDAO questionDAO = new QuestionDAO();
                    
                    for (Question question : questions) {

                        try {
                            boolean isAdded = questionDAO.addQuestion(question); // Implement this method to save question to the database
                            if (!isAdded) {
                                errors.add("Question \"" + question.getQuestion_name() + "\" already exists.");
                            }
                        } catch (SQLException ex) {
                            Logger.getLogger(QuestionController.class.getName()).log(Level.SEVERE, null, ex);
                            errors.add("Error adding question \"" + question.getQuestion_name() + "\": " + ex.getMessage());
                        }
                    }

                    if (!errors.isEmpty()) {
                        session.setAttribute("notificationErr", errors);
                    } else {
                        session.setAttribute("notification", "Successfully import " + questions.size() + " question");

                    }
                    response.sendRedirect(request.getContextPath() + "/admin/question-list");
                } catch (IOException e) {
                    e.printStackTrace();
                    throw new ServletException("File processing failed", e);
                }
            } else {
                throw new ServletException("Invalid file upload");

            }
        } else if (user != null && user.getRole().getRole_id() != 1 && "change-status".equals(action)) {
            int id = Integer.parseInt(request.getParameter("question_id"));
            int status = Integer.parseInt(request.getParameter("status"));
            QuestionDAO questionDAO = new QuestionDAO();
            if (status == 1) {
                try {
                    questionDAO.updateQuestionStatus(id, 0);
                    session.setAttribute("notification", "Un Publish sucessfully!  ");
                    response.sendRedirect("question-list");

                } catch (Exception e) {
                    session.setAttribute("notificationErr", "Failed!  " + e.getMessage());
                }
            }
            if (status == 0) {
                try {
                    questionDAO.updateQuestionStatus(id, 1);
                    session.setAttribute("notification", "Publish sucessfully!  ");
                    response.sendRedirect("question-list");

                } catch (Exception e) {
                    session.setAttribute("notificationErr", "Failed!  " + e.getMessage());
                    response.sendRedirect("question-list");

                }
            }

        } else if (user != null && user.getRole().getRole_id() != 1 && "delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("question_id"));
            QuestionDAO questionDAO = new QuestionDAO();

            try {
                questionDAO.deleteQuestion(id);
                session.setAttribute("notification", "Delete sucessfully!  ");
                response.sendRedirect("question-list");

            } catch (Exception e) {
                session.setAttribute("notificationErr", "Failed!  " + e.getMessage());
                response.sendRedirect("question-list");

            }
        } else {
            response.sendRedirect("../home");

        }
    }
}
