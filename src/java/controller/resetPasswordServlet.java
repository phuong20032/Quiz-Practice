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

/**
 *
 * @author ADMIN
 */
public class resetPasswordServlet extends HttpServlet {

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
            out.println("<title>Servlet resetPasswordServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet resetPasswordServlet at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
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
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Check if password is at least 8 characters long
        if (password.length() < 8) {
            String msg = "The password must be at least 8 characters long.";
            request.setAttribute("error_msg", msg);
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
            return; // Stop further execution if validation fails
        }

        // Check if the password contains at least one special character
        boolean hasSpecialChar = false;
        for (char c : password.toCharArray()) {
            if (!Character.isLetterOrDigit(c)) {
                hasSpecialChar = true;
                break;
            }
        }
        if (!hasSpecialChar) {
            String msg = "The password must contain at least one special character.";
            request.setAttribute("error_msg", msg);
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
            return; // Stop further execution if validation fails
        }

        // Check if passwords match
        if (!password.equals(confirmPassword)) {
            String msg = "The passwords you entered do not match.";
            request.setAttribute("error_msg", msg);
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
            return; // Stop further execution if validation fails
        } else {
            password = EncodePassword.toSHAI(password);
            forgetPasswordDao fpd = new forgetPasswordDao();
            fpd.updatePassword(email, password);
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
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
