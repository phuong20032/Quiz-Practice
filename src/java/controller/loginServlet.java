/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import Utils.EncodePassword;
import dal.LoginDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

/**
 *
 * @author ADMIN
 */
public class loginServlet extends HttpServlet {

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
            out.println("<title>Servlet loginServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet loginServlet at " + request.getContextPath() + "</h1>");
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
        response.sendRedirect("Login.jsp");
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

        // Get email and password from login.jsp page:
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        //Encode the password: 
        //The password after encode when user register will be compared with
        // password when user login.
        password = EncodePassword.toSHAI(password);

        // Save data to Cookies.
        String remember = request.getParameter("remember");

        //Check Email and Password in database:
        LoginDao ld = new LoginDao();
        User checkLogin = ld.checkLogin(email, password);
        HttpSession session = request.getSession();

        // Get Infomation if user signed up:
        User getAllInfo = ld.getAllInfoByEmail(email);
        if (checkLogin == null) {

            // if Server cann't find the data from database:
            request.setAttribute("error_message", "The e-mail address and/or password you specified are not correct.");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        } else if (getAllInfo.getStatus() == 1) {
            request.setAttribute("error_message", "Sorry! You had been blocked! ");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        } else {

            // find out:
            //Generate 3 cookies to build remember me function:
            Cookie cuser = new Cookie("user", email);
            Cookie cpass = new Cookie("pass", password);
            Cookie cremember = new Cookie("remember", remember);
            if (remember != null) {

                // save account in cookie in 7 days.
                cuser.setMaxAge(60 * 60 * 24 * 7);
                cpass.setMaxAge(60 * 60 * 24 * 7);
                cremember.setMaxAge(60 * 60 * 24 * 7);
            } else {
                cuser.setMaxAge(0);
                cpass.setMaxAge(0);
                cremember.setMaxAge(0);
            }
            response.addCookie(cuser);
            response.addCookie(cpass);
            response.addCookie(cremember);

            session.setAttribute("account", getAllInfo);
            if (getAllInfo.getRole().getRole_id() == 2 || getAllInfo.getRole().getRole_id() == 3 ) {

                response.sendRedirect("admin/dashboard");
            }else if(getAllInfo.getRole().getRole_id() == 1){

                response.sendRedirect("home");
            }else if(getAllInfo.getRole().getRole_id() == 4){
                response.sendRedirect("admin/user-list");
            }
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
