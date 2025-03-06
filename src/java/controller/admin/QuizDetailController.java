/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import Utils.ExcelUtils;
import dal.LessonDAO;
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
import java.util.ArrayList;
import java.util.List;
import model.Question;
import model.Quiz;
import model.User;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "QuizDetail", urlPatterns = {"/admin/quiz-detail"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class QuizDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        if (user != null && user.getRole().getRole_id() != 1) {

            QuizDAO quizDAO = new QuizDAO();
            int quizId = Integer.parseInt(request.getParameter("id"));
            Quiz quiz = quizDAO.getById(quizId);
            request.setAttribute("s", quiz);

            // for question 
            QuestionDAO questionDAO = new QuestionDAO();
            List<Question> listQuestion = questionDAO.getAllQuestionByQuiz(quizId);
            request.setAttribute("questions", listQuestion);

            request.getRequestDispatcher("quiz-detail.jsp").forward(request, response);
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
        QuestionDAO questionDAO = new QuestionDAO();

        if (user != null && user.getRole().getRole_id() != 1) {
            if (action.equals("edit")) {
                int id = Integer.parseInt(request.getParameter("id"));
                int count_down = Integer.parseInt(request.getParameter("count_down"));
                int min_to_pass = Integer.parseInt(request.getParameter("min_to_pass"));
                String name = request.getParameter("quiz_name");
                int time_attempt = Integer.parseInt(request.getParameter("time_attemp"));

                // Check if quiz name already exists
                if (quizDAO.isQuizNameExist(name, id)) {
                    session.setAttribute("notificationErr", "Quiz name already exists!");
                    response.sendRedirect("quiz-detail?id=" + id);
                    return;
                }

                try {
                    quizDAO.updateQuiz(id, name, count_down, min_to_pass, time_attempt);
                    session.setAttribute("notification", "Quiz updated successfully!");
                } catch (Exception e) {
                    session.setAttribute("notificationErr", "Update failed: " + e.toString());
                }
                response.sendRedirect("quiz-detail?id=" + id);
            }
            if (action.equals("remove")) {
                int lessonId = Integer.parseInt(request.getParameter("quizId"));
                int quizId = Integer.parseInt(request.getParameter("questionId"));
                System.out.println(quizId + " " + lessonId);
                try {
                    boolean isDelete = questionDAO.removeQuestionFromQuiz(lessonId, quizId);
                    if (isDelete) {
                        session.setAttribute("notification", "Quiz remove successfully!");
                    } else {
                        session.setAttribute("notificationErr", "Quiz remove failed!");
                    }
                } catch (Exception e) {
                    session.setAttribute("notificationErr", e.toString());
                }
                response.sendRedirect("quiz-detail?id=" + lessonId);
            }
            if (action.equals("importQuestions")) {
                int quizId = Integer.parseInt(request.getParameter("quizId"));
                Part filePart = request.getPart("file");

                if (filePart.getSize() > 0) {
                    try (InputStream fileContent = filePart.getInputStream()) {
                        List<String> errors = new ArrayList<>();
                        List<Question> questions = ExcelUtils.readQuestionsFromExcel(fileContent, session);
                        
                            
                        for (Question question : questions) {
                            try {
                                
                                int questionId = questionDAO.getQuestionIdByName(question.getQuestion_name());
                                if (questionId > 0) {
                                    if (!questionDAO.isQuestionInQuiz(quizId, questionId)) {
                                        questionDAO.addQuestionToQuiz(quizId, questionId);
                                    }
                                } else {
                                    boolean isAdded = questionDAO.addQuestion(question);
                                    if (isAdded) {
                                        questionDAO.addQuestionToQuiz(quizId, question.getQuestion_id());
                                    } else {
                                        errors.add("Question \"" + question.getQuestion_name() + "\" already exists.");
                                    }
                                }
                            } catch (Exception ex) {
                                Logger.getLogger(QuizDetailController.class.getName()).log(Level.SEVERE, null, ex);
                                errors.add("Error adding question \"" + question.getQuestion_name() + "\": " + ex.getMessage());
                            }
                        }

                        if (session.getAttribute("notificationErr") != null) {
                            // There was an error in the ExcelUtils class, handle the error.
                            session.setAttribute("notificationErr", session.getAttribute("notificationErr"));
                        } else {
                            // If no error in ExcelUtils, check if there are any errors in the errors list
                            if (!errors.isEmpty()) {
                                session.setAttribute("notificationErr", errors);
                            } else {
                                // If there are no errors, show success message
                                session.setAttribute("notification", "Successfully imported " + questions.size() + " questions.");
                            }
    }
                        response.sendRedirect("quiz-detail?id=" + quizId);
                            }catch (IOException e) {
                                e.printStackTrace();
                                session.setAttribute("notificationErr", List.of("File processing failed: " + e.getMessage()));
                                response.sendRedirect("quiz-detail?id=" + quizId);
                            }
                        } else {
                            session.setAttribute("notificationErr", List.of("Invalid file upload. Please upload a valid file."));
                            response.sendRedirect("quiz-detail?id=" + quizId);
                        }
                        }
        } else {
            response.sendRedirect("../home");
        }
    }

}
