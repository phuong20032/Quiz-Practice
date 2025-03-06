package controller.admin;

import com.google.gson.Gson;
import dal.DashboardDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.UserHasSubject;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;
@WebServlet(name = "DashboardController", urlPatterns = {"/admin/dashboard"})
public class DashboardController extends HttpServlet {

    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    private static final DateTimeFormatter DISPLAY_DATE_FORMATTER = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    private static final LocalDate DEFAULT_START_DATE = LocalDate.of(2000, 1, 1);
    private static final LocalDate DEFAULT_END_DATE = LocalDate.of(2050, 1, 1);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String dateRangeParam = request.getParameter("dateRange");
        String startDateParam = request.getParameter("startDate");
        String endDateParam = request.getParameter("endDate");

        DashboardDAO dashboardDAO = new DashboardDAO();
        LocalDate startDate = null;
        LocalDate endDate = null;

        if (dateRangeParam != null) {
            switch (dateRangeParam) {
                case "1week":
                    startDate = LocalDate.now().minusWeeks(1);
                    endDate = LocalDate.now();
                    break;
                case "1month":
                    startDate = LocalDate.now().minusMonths(1);
                    endDate = LocalDate.now();
                    break;
                case "6months":
                    startDate = LocalDate.now().minusMonths(6);
                    endDate = LocalDate.now();
                    break;
                case "1year":
                    startDate = LocalDate.now().minusYears(1);
                    endDate = LocalDate.now();
                    break;
                case "all":
                    startDate = DEFAULT_START_DATE;
                    endDate = DEFAULT_END_DATE;
                    break;
                default:
                    break;
            }
        }

        if (startDateParam != null && !startDateParam.isEmpty() && endDateParam != null && !endDateParam.isEmpty()) {
            try {
                startDate = LocalDate.parse(startDateParam, DATE_FORMATTER);
                endDate = LocalDate.parse(endDateParam, DATE_FORMATTER);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        if (startDate == null || endDate == null) {
            startDate = DEFAULT_START_DATE;
            endDate = DEFAULT_END_DATE;
        }

        String rangeDescription = "from " + startDate.format(DISPLAY_DATE_FORMATTER) + " to " + endDate.format(DISPLAY_DATE_FORMATTER);

        try {
            Date sqlStartDate = Date.valueOf(startDate);
            Date sqlEndDate = Date.valueOf(endDate);

            int newSubjects = dashboardDAO.getNewSubjectsCount(sqlStartDate, sqlEndDate);
            int allSubjects = dashboardDAO.getAllSubjectsCount();
            int allQuizzes = dashboardDAO.getAllQuizzes().size();
            List<Integer> quizParticipationCounts = dashboardDAO.getQuizParticipationCounts(sqlStartDate, sqlEndDate);
            List<UserHasSubject> registrations = dashboardDAO.getAllSubjectRegistrations(sqlStartDate, sqlEndDate);

            Map<String, Integer> subjectRegistrations = dashboardDAO.getSubjectRegistrations(sqlStartDate, sqlEndDate);
            List<String> subjectNames = new ArrayList<>(subjectRegistrations.keySet());
            List<Integer> subjectCounts = new ArrayList<>(subjectRegistrations.values());

            Gson gson = new Gson();
            String subjectNamesJson = gson.toJson(subjectNames);
            String subjectCountsJson = gson.toJson(subjectCounts);
            Map<String, Map<String, Integer>> categorySubjectRegistrations = dashboardDAO.getSubjectRegistrationsByCategory(sqlStartDate, sqlEndDate);
            String categorySubjectRegistrationsJson = gson.toJson(categorySubjectRegistrations);

            request.setAttribute("categorySubjectRegistrationsJson", categorySubjectRegistrationsJson);

            request.setAttribute("registrations", registrations);
            request.setAttribute("newSubjects", newSubjects);
            request.setAttribute("allSubjects", allSubjects);
            request.setAttribute("allQuizzes", allQuizzes);
            request.setAttribute("quizParticipationCounts", quizParticipationCounts);
            request.setAttribute("startDateFormatted", startDate.format(DATE_FORMATTER));
            request.setAttribute("endDateFormatted", endDate.format(DATE_FORMATTER));
            request.setAttribute("selectedStartDate", startDate.format(DATE_FORMATTER));
            request.setAttribute("selectedEndDate", endDate.format(DATE_FORMATTER));
            request.setAttribute("rangeDescription", rangeDescription);

            request.setAttribute("subjectNamesJson", subjectNamesJson);
            request.setAttribute("subjectCountsJson", subjectCountsJson);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}