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
import java.sql.SQLException;
import java.util.List;
import model.Lesson;
import model.Quiz;
import model.User;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "QuizListController", urlPatterns = {"/admin/quiz-list"})
public class QuizListController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        if (user != null && user.getRole().getRole_id() != 1) {
            LessonDAO lessonDAO = new LessonDAO();
            QuizDAO quizDAO = new QuizDAO();
            List<Lesson> listSubject = lessonDAO.getAll();

            String pageParam = request.getParameter("page");
            String searchParam = request.getParameter("search");
            String subjectParam = request.getParameter("lesson");
            String statusParam = request.getParameter("status");
            Integer lessonId = (subjectParam != null && !subjectParam.isEmpty()) ? Integer.valueOf(subjectParam) : null;
            Integer status = (statusParam != null && !statusParam.isEmpty()) ? Integer.valueOf(statusParam) : null;

            int page = 1; // Default to the first page
            int pageSize = 6; // Set the desired page size
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
            }

            List<Quiz> quizes = quizDAO.getAllQuizWithParam(searchParam, status, lessonId);
            List<Quiz> pagingQuiz = quizDAO.Paging(quizes, page, pageSize);

            request.setAttribute("quiz", pagingQuiz);
            request.setAttribute("totalPages", quizes.size() % pageSize == 0 ? (quizes.size() / pageSize) : (quizes.size() / pageSize + 1));
            request.setAttribute("currentPage", page);
            request.setAttribute("searchParam", searchParam);
            request.setAttribute("subjectParam", subjectParam);
            request.setAttribute("statusParam", statusParam);
            request.setAttribute("listS", listSubject);
            request.getRequestDispatcher("quiz-list.jsp").forward(request, response);
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
        QuizDAO quizDAO = new QuizDAO();
        if (user != null && user.getRole().getRole_id() != 1) {
            if (action.equals("add")) {
                try {
                    String name = request.getParameter("quiz_name");
                    int count_down = Integer.parseInt(request.getParameter("count_down"));
                    int min_to_pass = Integer.parseInt(request.getParameter("min_to_pass"));
                    int time_attempt = Integer.parseInt(request.getParameter("time_attempt"));

                    // Validate count_down, min_to_pass, and time_attempt to ensure no negative values
                    if (count_down < 0 || min_to_pass < 0 || time_attempt < 0) {
                        session.setAttribute("notificationErr", "Values for countdown, minimum pass, and time attempt must be non-negative!");
                        response.sendRedirect("quiz-list");
                        return;
                    }

                    // Check if quiz name already exists
                    if (quizDAO.isQuizNameExist(name)) {
                        session.setAttribute("notificationErr", "Quiz name already exists!");
                        response.sendRedirect("quiz-list");
                        return;
                    }

                    quizDAO.addQuiz(name, user.getUser_id(), 1, count_down, min_to_pass, time_attempt);
                    session.setAttribute("notification", "Quiz added successfully!");
                } catch (SQLException ex) {
                    session.setAttribute("notificationErr", ex.toString());
                }
                response.sendRedirect("quiz-list");
            }
            if (action.equals("change-status")) {
                try {
                    int status = Integer.parseInt(request.getParameter("status"));
                    int id = Integer.parseInt(request.getParameter("quiz_id"));
                    if (status == 1) {
                        quizDAO.updateQuizStatus(id, 0);
                        session.setAttribute("notification", "Un publish successfully!");
                    }
                    if (status == 0) {
                        quizDAO.updateQuizStatus(id, 1);
                        session.setAttribute("notification", "Publish successfully!");
                    }

                } catch (SQLException ex) {
                    session.setAttribute("notificationErr", ex.toString());
                }
                response.sendRedirect("quiz-list");
            }
        } else {
            response.sendRedirect("../home");
        }
    }
}
