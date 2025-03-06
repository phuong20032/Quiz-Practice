/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.MajorDAO;
import dal.SubjectDAO;
import dal.UserHasSubjectDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Major;
import model.Subject;
import model.User;

/**
 *
 * @author ADMIN
 */
public class subjectListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        UserHasSubjectDAO userHasSubjectDAO = new UserHasSubjectDAO();

        User user = (User) session.getAttribute("account");

        MajorDAO majorDAO = new MajorDAO();
        SubjectDAO subjectDAO = new SubjectDAO();
        List<Major> listMajors = majorDAO.getAll();

        String pageParam = request.getParameter("page");
        String searchParam = request.getParameter("search");
        String majorParam = request.getParameter("major");

        Integer majorId = (majorParam != null && !majorParam.isEmpty()) ? Integer.valueOf(majorParam) : null;

        int page = 1; // Default to the first page
        int pageSize = 5; // Set the desired page size
        if (pageParam != null && !pageParam.isEmpty()) {
            page = Integer.parseInt(pageParam);
        }

        List<Subject> subjects = subjectDAO.getAllProdcutWithParam(searchParam, majorId);
        List<Subject> pagingSubject = subjectDAO.Paging(subjects, page, pageSize);

        if (user != null) {
            Map<Integer, Boolean> enrollmentStatusMap = new HashMap<>();
            for (Subject subject : pagingSubject) {
                boolean isEnrolled = userHasSubjectDAO.existUserInSubject(subject.getSubject_id(), user.getUser_id());
                enrollmentStatusMap.put(subject.getSubject_id(), isEnrolled);
            }
            request.setAttribute("enrollmentStatusMap", enrollmentStatusMap);
            List<Subject> recentSubject = subjectDAO.getTop3Subject();
        request.setAttribute("subjects", pagingSubject);
        request.setAttribute("totalPages", subjects.size() % pageSize == 0 ? (subjects.size() / pageSize) : (subjects.size() / pageSize + 1));
        request.setAttribute("currentPage", page);
        request.setAttribute("searchParam", searchParam);
        request.setAttribute("majorParam", majorParam);
        request.setAttribute("listM", listMajors);
        request.setAttribute("recentSubject", recentSubject);
        request.getRequestDispatcher("subjectList.jsp").forward(request, response);
        }
        else{
            response.sendRedirect("login");
        }
    }

}
