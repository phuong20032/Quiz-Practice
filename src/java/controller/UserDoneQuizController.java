package controller;

///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
// */
//package controller;
//
//import dal.UserQuizDAO;
//import java.io.IOException;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import java.util.List;
//import model.User;
//import model.UserDoneQuiz;
//
///**
// *
// * @author ADMIN
// */
//@WebServlet(name = "UserDoneQuizController", urlPatterns = {"/quiz-done"})
//public class UserDoneQuizController extends HttpServlet {
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        HttpSession session = request.getSession();
//        User user = (User) session.getAttribute("account");
//        if (user != null) {
//            UserQuizDAO uqdao = new UserQuizDAO();
//            List<UserDoneQuiz> users = uqdao.getAllQuizDoneByUser(user.getUser_id());
//            request.setAttribute("userDoneQuiz", users);
//            System.out.println(users.size());
//            request.getRequestDispatcher("Profile.jsp").forward(request, response);
//        } else {
//            response.sendRedirect("login");
//        }
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//    }
//}
