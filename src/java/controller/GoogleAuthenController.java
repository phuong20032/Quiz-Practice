/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import controller.constant.CommonConst;
import dal.UserDAO;
import model.GoogleAccount;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.User;

public class GoogleAuthenController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        UserDAO userDao = new UserDAO();
        String code = request.getParameter("code");
        String accessToken = GoogleLogin.getToken(code);

        GoogleAccount googleAccount = GoogleLogin.getUserInfo(accessToken);

        // Check if the user exists in the database by their email
        User user = userDao.getAllInfoByEmail(googleAccount.getEmail());

        try {
            // If user does not exist in the database, display an error page
            if (user == null) {
                request.setAttribute("errorMessage", "Account not found. Please register first.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }

            // If user exists, proceed with session and login
            HttpSession session = request.getSession();
            session.setAttribute(CommonConst.SESSION_ACCOUNT, user);
            session.setMaxInactiveInterval(60 * 60 * 24); // 1 day session timeout

            // Create cookies for email (optional for auto-login)
            Cookie emailCookie = new Cookie("userC", user.getEmail());
            emailCookie.setMaxAge(60 * 60 * 24); // 1 day expiration

            response.addCookie(emailCookie);
            if (user.getRole().getRole_id() == 2 || user.getRole().getRole_id() == 3 ) {

                response.sendRedirect("admin/dashboard");
            }else if(user.getRole().getRole_id() == 1){

                response.sendRedirect("home");
            }else if(user.getRole().getRole_id() == 4){
                response.sendRedirect("admin/user-list");
            }
            

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.html"); // Redirect to a general error page if an exception occurs
        }
    }

}