package controller.admin;

import dal.MajorDAO;
import dal.SubjectDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Major;
import model.Subject;
import model.User;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "subjectListController", urlPatterns = {"/admin/subject-list"})
public class subjectListController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        if (user != null && user.getRole().getRole_id() == 3) {
            MajorDAO majorDAO = new MajorDAO();
            SubjectDAO subjectDAO = new SubjectDAO();
            List<Major> listMajors = majorDAO.getAll();

            String pageParam = request.getParameter("page");
            String searchParam = request.getParameter("search");
            String majorParam = request.getParameter("major");
            String statusParam = request.getParameter("status");
            Integer majorId = (majorParam != null && !majorParam.isEmpty()) ? Integer.valueOf(majorParam) : null;
            Integer status = (statusParam != null && !statusParam.isEmpty()) ? Integer.valueOf(statusParam) : null;

            int page = 1; // Default to the first page
            int pageSize = 5; // Set the desired page size
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
            }

            List<Subject> subjects = subjectDAO.getAllProdcutWithParam(searchParam, status, majorId);
            List<Subject> pagingSubject = subjectDAO.Paging(subjects, page, pageSize);

            request.setAttribute("subjects", pagingSubject);
            request.setAttribute("totalPages", subjects.size() % pageSize == 0 ? (subjects.size() / pageSize) : (subjects.size() / pageSize + 1));
            request.setAttribute("currentPage", page);
            request.setAttribute("searchParam", searchParam);
            request.setAttribute("majorParam", majorParam);
            request.setAttribute("statusParam", statusParam);
            request.setAttribute("listM", listMajors);
            request.getRequestDispatcher("subject-list.jsp").forward(request, response);
        } else if (user != null && user.getRole().getRole_id() == 2) {
            MajorDAO majorDAO = new MajorDAO();
            SubjectDAO subjectDAO = new SubjectDAO();
            List<Major> listMajors = majorDAO.getAll();

            String pageParam = request.getParameter("page");
            String searchParam = request.getParameter("search");
            String majorParam = request.getParameter("major");
            String statusParam = request.getParameter("status");
            Integer majorId = (majorParam != null && !majorParam.isEmpty()) ? Integer.valueOf(majorParam) : null;
            Integer status = (statusParam != null && !statusParam.isEmpty()) ? Integer.valueOf(statusParam) : null;

            int page = 1; // Default to the first page
            int pageSize = 5; // Set the desired page size
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
            }

            List<Subject> subjects = subjectDAO.getAllProdcutWithParamForExpert(searchParam, status, majorId, user.getUser_id());
            List<Subject> pagingSubject = subjectDAO.Paging(subjects, page, pageSize);

            request.setAttribute("subjects", pagingSubject);
            request.setAttribute("totalPages", subjects.size() % pageSize == 0 ? (subjects.size() / pageSize) : (subjects.size() / pageSize + 1));
            request.setAttribute("currentPage", page);
            request.setAttribute("searchParam", searchParam);
            request.setAttribute("majorParam", majorParam);
            request.setAttribute("statusParam", statusParam);
            request.setAttribute("listM", listMajors);
            request.getRequestDispatcher("subject-list.jsp").forward(request, response);
        } else {
            response.sendRedirect("../home");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        SubjectDAO subjectDAO = new SubjectDAO();
        String action = request.getParameter("action");
        if (user != null && user.getRole().getRole_id() == 3) {
            if ("change-status".equals(action)) {
                String idParam = request.getParameter("subjectId");
                System.out.println(idParam + " id");
                int status = Integer.parseInt(request.getParameter("status"));
                if (idParam != null && status == 1) {
                    int id = Integer.parseInt(idParam);
                    if (subjectDAO.changeSubjectStatus(id, 0)) {
                        session.setAttribute("notification", "Un-publish subject successfully!");
                        response.sendRedirect("subject-list");
                    } else {
                        session.setAttribute("notificationErr", "Error to update subject status!");
                        response.sendRedirect("subject-list");
                    }

                }
                if (idParam != null && status == 0) {
                    int id = Integer.parseInt(idParam);
                    if (subjectDAO.changeSubjectStatus(id, 1)) {
                        session.setAttribute("notification", "Publish subject successfully!");
                        response.sendRedirect("subject-list");
                    } else {
                        session.setAttribute("notificationErr", "Error to update subject status!");
                        response.sendRedirect("subject-list");
                    }

                }
            }
        } 
    }
}
