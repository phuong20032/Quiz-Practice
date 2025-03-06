/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import Utils.EncodePassword;
import Utils.SendEmail;
import dal.UserDAO;
import dal.UserHasSubjectDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.security.SecureRandom;
import model.User;

/**
 *
 * @author ADMIN
 */
public class SubjectRegisterController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserHasSubjectDAO dao = new UserHasSubjectDAO();
        User u = (User) session.getAttribute("account");
        UserDAO userDAO = new UserDAO();
        String action = request.getParameter("action");
        if (action.equals("errol-now")) {
            int subjectid = Integer.parseInt(request.getParameter("subjectId"));
            dao.addUserHasSubject(subjectid, u.getUser_id());
            session.setAttribute("notification", "Enroll successfully!");
            response.sendRedirect("subjectlist");
        }

        if (action.equals("un-errol")) {
            int subjectid = Integer.parseInt(request.getParameter("subjectId"));
            dao.removeUserFromSubject(subjectid, u.getUser_id());
            session.setAttribute("notification", "Un-enroll successfully!");
            response.sendRedirect("subjectlist");
        }
        if (action.equals("join")) {
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            int gender = Integer.parseInt(request.getParameter("gender"));
            int subjectId = Integer.parseInt(request.getParameter("subjectId"));

            // Generate random password
            String randomPassword = generateRandomPassword();
            String password = EncodePassword.toSHAI(randomPassword);
            String[] usernameArr = email.split("@");
            String username = usernameArr[0];
            // Create a new user
            User newUser = new User();
            newUser.setFullName(fullName);
            newUser.setUserName(username);
            newUser.setEmail(email);
            newUser.setPhone(phone);
            newUser.setGender(gender);
            newUser.setPassword(password);

            // Check if the email is already registered
            if (userDAO.checkExistedEmail(newUser.getEmail())) {
                session.setAttribute("notificationErr", "Email already exists!");
                response.sendRedirect("subjectlist");
                return;
            }

            // Insert the new user into the database
            boolean isRegister = userDAO.insertAccount(newUser);
            SendEmail sm = new SendEmail();
            // Send email to the new user
            if (isRegister) {
                boolean emailSent = sm.sendMailEnroll(newUser.getEmail(), randomPassword);

                if (!emailSent) {
                    session.setAttribute("notificationErr", "Failed to send email!");
                    response.sendRedirect("subjectlist");
                    return;
                }

                // Add the new user to the subject
                System.out.println(newUser.getUser_id());
                dao.addUserHasSubject(subjectId, userDAO.getLastId());
                session.setAttribute("notification", "Joined successfully! Please check your email");
            } else {

                session.setAttribute("notificationErr", "Joined Faild! Can not create new account with your email!");
            }
            response.sendRedirect("subjectlist");
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

    // Generate a random password
    private String generateRandomPassword() {
        String upperCaseChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        String lowerCaseChars = "abcdefghijklmnopqrstuvwxyz";
        String numbers = "0123456789";
        String specialChars = "!@#$%^&*()_+-=[]{}|;:,.<>?";

        String allChars = upperCaseChars + lowerCaseChars + numbers + specialChars;
        SecureRandom random = new SecureRandom();
        StringBuilder password = new StringBuilder();

        for (int i = 0; i < 8; i++) {
            password.append(allChars.charAt(random.nextInt(allChars.length())));
        }

        return password.toString();
    }
}
