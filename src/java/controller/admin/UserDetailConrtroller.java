/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
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
@MultipartConfig
@WebServlet(name = "UserDetailConrtroller", urlPatterns = {"/admin/user-detail"})
public class UserDetailConrtroller extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        if (user != null && user.getRole().getRole_id() == 4) {
            int userId = Integer.parseInt(request.getParameter("id"));
            System.out.println(userId);
            UserDAO userDAO = new UserDAO();
            User u = userDAO.getAllInfoByID(userId);
            List<Role> roles = userDAO.getAllRoles();
            request.setAttribute("roles", roles);
            request.setAttribute("user", u);
            request.getRequestDispatcher("user-detail.jsp").forward(request, response);
        } else {
            response.sendRedirect("../home");
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        UserDAO userDAO = new UserDAO();
        if (user != null && user.getRole().getRole_id() == 4) {
            int id = Integer.parseInt(request.getParameter("id"));
            int role = Integer.parseInt(request.getParameter("role"));

            int status = Integer.parseInt(request.getParameter("status"));
            userDAO.updateRoleAndStatus(id, role, status);
            session.setAttribute("notification", "Update successfully! ");
            response.sendRedirect("user-detail?id="+id);
        } else {
            response.sendRedirect("../home");
        }
    }
}
