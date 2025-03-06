/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.UserDAO;
import dal.UserQuizDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.User;
import model.UserDoneQuiz;
@WebServlet(name = "QuizHistoryController", urlPatterns = {"/quiz-history"})
public class QuizHistoryController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO dao = new UserDAO();
        HttpSession session = request.getSession();
        User sessionUser = (User) session.getAttribute("account");

        if (sessionUser != null) {
            User user = dao.getAllInfoByEmail(sessionUser.getEmail());

            String searchParam = request.getParameter("searchParam");
            String filter = request.getParameter("filter");
            String sortBy = request.getParameter("sortBy");
            int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
            int pageSize = 6;  

            UserQuizDAO uqdao = new UserQuizDAO();
            List<UserDoneQuiz> allUsers = uqdao.getAllQuizDoneByUser(user.getUser_id(), searchParam, filter, sortBy);
            List<UserDoneQuiz> users = uqdao.Paging(allUsers, page, pageSize);
            for (UserDoneQuiz user1 : users) {
                System.out.println(user1.getTime_done());
            }
            request.setAttribute("userDoneQuiz", users);
            request.setAttribute("user", user);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", (int) Math.ceil(allUsers.size() / (double) pageSize));
            request.setAttribute("searchParam", searchParam);
            request.setAttribute("filter", filter);
            request.setAttribute("sortBy", sortBy);

            request.getRequestDispatcher("quiz-history.jsp").forward(request, response);
        } else {
            response.sendRedirect("login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
