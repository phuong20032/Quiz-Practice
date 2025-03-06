/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import Utils.EncodePassword;
import Utils.SendEmail;
import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Role;
import model.User;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "UserListController", urlPatterns = {"/admin/user-list"})
public class UserListController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        UserDAO userDAO = new UserDAO();
        if (user != null && user.getRole().getRole_id() == 4) {

            String pageParam = request.getParameter("page");
            String searchParam = request.getParameter("search");
            String roleParam = request.getParameter("role");
            String statusParam = request.getParameter("status");
            String genderParam = request.getParameter("gender");
            Integer roleId = (roleParam != null && !roleParam.isEmpty()) ? Integer.valueOf(roleParam) : null;
            Integer status = (statusParam != null && !statusParam.isEmpty()) ? Integer.valueOf(statusParam) : null;

            int page = 1; // Default to the first page
            int pageSize = 6; // Set the desired page size
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
            }

            List<User> users = userDAO.getAllUserWithParams(user.getUser_id(), searchParam, roleId, status, genderParam);
            List<User> pagingUser = userDAO.Paging(users, page, pageSize);
            List<Role> roles = userDAO.getAllRoles();

            request.setAttribute("user", pagingUser);
            request.setAttribute("roles", roles);
            request.setAttribute("totalPages", users.size() % pageSize == 0 ? (users.size() / pageSize) : (users.size() / pageSize + 1));
            request.setAttribute("currentPage", page);
            request.getRequestDispatcher("user-list.jsp").forward(request, response);
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
        UserDAO userDAO = new UserDAO();
        SendEmail sm = new SendEmail();
        if (user != null && user.getRole().getRole_id() == 4) {
            if (action.equals("add")) {

                String fullName = request.getParameter("full_name");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                int role_id = Integer.parseInt(request.getParameter("role"));
                int gender = Integer.parseInt(request.getParameter("gender"));
                int status = 0;
                String username = email.split("@")[0];
                boolean existed = userDAO.checkExistedEmail(email);
                String password = newPassword();
                String hashPass = EncodePassword.toSHAI(password);
                if (!existed) {
                    userDAO.addUser(username, email, hashPass, phone, gender, fullName, role_id, status);
                    sm.sendMailCreateNewUser(email, password);
                    session.setAttribute("notification", "User add successfully!");
                } else {
                    session.setAttribute("notificationErr", "Email already existed!");

                }
                response.sendRedirect("user-list");
            }
            if (action.equals("change-status")) {
                int status = Integer.parseInt(request.getParameter("status"));
                int id = Integer.parseInt(request.getParameter("id"));
                if (status == 1) {
                    userDAO.changeStatus(0, id);
                    session.setAttribute("notification", "Un-block user successfully!");
                }
                if (status == 0) {
                    userDAO.changeStatus(1, id);
                    session.setAttribute("notification", "Block user successfully!");
                }
                response.sendRedirect("user-list");
            }
        } else {
            response.sendRedirect("../home");
        }
    }

    private String newPassword() {
        return "Password123@";
    }
}
