/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import Utils.EncodePassword;
import dal.forgetPasswordDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

/**
 *
 * @author ADMIN
 */
public class changePasswordServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet changePasswordServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet changePasswordServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String oldPassword = request.getParameter("oldPass");
        String newPassword = request.getParameter("newPass");
        String confirmPassword = request.getParameter("confirmPass");

        String mess = "Change password successfully.";

        HttpSession session = request.getSession();

        User sessionUser = (User) session.getAttribute("account");

        if (!oldPassword.equals(EncodePassword.decode(sessionUser.getPassword()))) {
            mess = "The password doesn't correct. Please try again.";
        }
        if (oldPassword.equals(newPassword)) {
            mess = "The new password must not match with old password.";
        }
        if (!newPassword.equals(confirmPassword)) {
            mess = "Confirm password is not match with new password";
        }

        // Check if password is at least 8 characters long
        if (newPassword.length() < 8) {
            String msg = "The password must be at least 8 characters long.";
            request.setAttribute("error_msg", msg);
            request.getRequestDispatcher("Profile.jsp").forward(request, response);
            return; // Stop further execution if validation fails
        }

        // Check if the password contains at least one special character
        boolean hasSpecialChar = false;
        for (char c : newPassword.toCharArray()) {
            if (!Character.isLetterOrDigit(c)) {
                hasSpecialChar = true;
                break;
            }
        }
        if (!hasSpecialChar) {
            String msg = "The password must contain at least one special character.";
            request.setAttribute("error_msg", msg);
            request.getRequestDispatcher("Profile.jsp").forward(request, response);
            return; // Stop further execution if validation fails
        }

        // Check if passwords match
        if (!newPassword.equals(confirmPassword)) {
            String msg = "The passwords you entered do not match.";
            request.setAttribute("error_msg", msg);
            request.getRequestDispatcher("Profile.jsp").forward(request, response);
            return; // Stop further execution if validation fails
        } else {
            newPassword = EncodePassword.toSHAI(newPassword);
            forgetPasswordDao fpd = new forgetPasswordDao();
            fpd.updatePassword(sessionUser.getEmail(), newPassword);
        }

        request.setAttribute("error_msg", mess);
        request.getRequestDispatcher("login").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
