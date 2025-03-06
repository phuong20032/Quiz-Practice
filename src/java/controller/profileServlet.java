/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.SubjectDAO;
import dal.UserDAO;
import dal.UserHasSubjectDAO;
import dal.UserQuizDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Subject;
import model.User;

/**
 *
 * @author ADMIN
 */
public class profileServlet extends HttpServlet {

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
            out.println("<title>Servlet profileServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet profileServlet at " + request.getContextPath() + "</h1>");
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
        UserDAO dao = new UserDAO();
        HttpSession session = request.getSession();
        SubjectDAO subjectDAO = new SubjectDAO();
        User sessionUser = (User) session.getAttribute("account");
        if (sessionUser != null) {

            User user = dao.getAllInfoByEmail(sessionUser.getEmail());
            List<Subject> listSubject = subjectDAO.getAllUserSubject(user.getUser_id());
            UserQuizDAO uqdao = new UserQuizDAO();
//            List<UserDoneQuiz> users = uqdao.getAllQuizDoneByUser(user.getUser_id());
//            request.setAttribute("userDoneQuiz", users);

            request.setAttribute("listSubject", listSubject);
            request.setAttribute("user", user);
            request.getRequestDispatcher("Profile.jsp").forward(request, response);
        }
        else{
            response.sendRedirect("login");
        }
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
        //processRequest(request, response);
        String email = request.getParameter("email");
        String userName = request.getParameter("userName");
        String fullName = request.getParameter("fullName");
        String school = request.getParameter("school");
        String phone = request.getParameter("phone");
        String action = request.getParameter("action");
        UserDAO dao = new UserDAO();
        UserHasSubjectDAO uhsdao = new UserHasSubjectDAO();

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        if (action != null && !action.equals("")) {
            if (action.equals("un-errol")) {
                int subjectid = Integer.parseInt(request.getParameter("subjectId"));
                uhsdao.removeUserFromSubject(subjectid, user.getUser_id());
                session.setAttribute("notification", "Un-enroll successfully!");
                response.sendRedirect("profile");

            }
        } else {
            dao.updateProfile(email, userName, fullName, phone, school);
            User getAllInfo = dao.getAllInfoByEmail(email);
            session.setAttribute("account", getAllInfo);
            response.sendRedirect("profile");
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
