package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import model.Subject;
import model.User;
import model.UserHasSubject;

public class DashboardDAO extends DBContext {

    public int getNewSubjectsCount(Date startDate, Date endDate) throws SQLException {
        String query = "SELECT COUNT(*) AS count FROM subject WHERE created_at BETWEEN ? AND ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setDate(1, startDate);
            preparedStatement.setDate(2, endDate);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("count");
                }
            }
        }
        return 0;
    }

    public int getAllSubjectsCount() throws SQLException {
        String query = "SELECT COUNT(*) AS count FROM subject";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query); ResultSet rs = preparedStatement.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("count");
            }
        }
        return 0;
    }

    public int getNewRegistrationsCount(Date startDate, Date endDate) throws SQLException {
        String query = "SELECT COUNT(*) AS count FROM user_has_subject WHERE start_date BETWEEN ? AND ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setDate(1, startDate);
            preparedStatement.setDate(2, endDate);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("count");
                }
            }
        }
        return 0;
    }

    public int getNewlyRegisteredCustomersCount(Date startDate, Date endDate) throws SQLException {
        String query = "SELECT COUNT(*) AS count FROM [user] WHERE created_at BETWEEN ? AND ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setDate(1, startDate);
            preparedStatement.setDate(2, endDate);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("count");
                }
            }
        }
        return 0;
    }

    public List<String> getAllCustomers() throws SQLException {
        List<String> customers = new ArrayList<>();
        String query = "SELECT userName FROM [user]";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query); ResultSet rs = preparedStatement.executeQuery()) {
            while (rs.next()) {
                customers.add(rs.getString("userName"));
            }
        }
        return customers;
    }

    public List<String> getAllLessonsOfQuestion(int questionId) throws SQLException {
        List<String> lessons = new ArrayList<>();
        String query = "SELECT l.lesson_name FROM lesson l JOIN lesson_has_quiz lhq ON l.lesson_id = lhq.lesson_id JOIN quiz_has_question qhq ON lhq.quiz_id = qhq.quiz_id WHERE qhq.question_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, questionId);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    lessons.add(rs.getString("lesson_name"));
                }
            }
        }
        return lessons;
    }

    public List<String> getAllQuizzes() throws SQLException {
        List<String> quizzes = new ArrayList<>();
        String query = "SELECT quiz_title FROM quiz";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query); ResultSet rs = preparedStatement.executeQuery()) {
            while (rs.next()) {
                quizzes.add(rs.getString("quiz_title"));
            }
        }
        return quizzes;
    }

    public List<Integer> getQuizParticipationCounts(Date startDate, Date endDate) throws SQLException {
        List<Integer> counts = new ArrayList<>();
        String query = """
                       SELECT 
                           COUNT(*) AS count, 
                           CONVERT(DATE, start_date) AS start_date
                       FROM 
                           user_has_subject 
                       WHERE 
                           start_date BETWEEN ? AND ?
                       GROUP BY 
                           CONVERT(DATE, start_date);""";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setDate(1, startDate);
            preparedStatement.setDate(2, endDate);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    counts.add(rs.getInt("count"));
                }
            }
        }
        return counts;
    }

    public List<UserHasSubject> getAllSubjectRegistrations(Date startDate, Date endDate) throws SQLException {
        List<UserHasSubject> registrations = new ArrayList<>();
        SubjectDAO sdao = new SubjectDAO();
        UserDAO udao = new UserDAO();
        String query = """
                 SELECT
                                                        
                                                       s.subject_name,
                                                       u.userName,
                                                       us.start_date,
                                   					u.user_id as UID,
                                   					us.subject_id as SID
                                                   FROM
                                                       user_has_subject us
                                                   JOIN
                                                       subject s ON us.subject_id = s.subject_id
                                                   JOIN
                                                       [user] u ON us.user_id = u.user_id
                       WHERE us.start_date BETWEEN ? AND ?
                                                   ORDER BY
                                                       us.start_date DESC""";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setDate(1, startDate);
            preparedStatement.setDate(2, endDate);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    UserHasSubject registration = new UserHasSubject();
                    User u = udao.getAllInfoByID(rs.getInt("UID"));
                    registration.setUser(u);
                    Subject subject = sdao.getSubjectById(rs.getInt("SID"));
                    registration.setSubject(subject);
                    registration.setStart_date(rs.getDate("start_date"));
                    registrations.add(registration);
                }
            }
            return registrations;
        }
    }

    public Map<String, Integer> getSubjectRegistrations(Date startDate, Date endDate) throws SQLException {
        Map<String, Integer> subjectRegistrations = new LinkedHashMap<>();
        String query = """
                       SELECT
                           s.subject_name,
                           COUNT(*) AS count
                       FROM
                           user_has_subject us
                       JOIN
                           subject s ON us.subject_id = s.subject_id
                       WHERE
                           us.start_date BETWEEN ? AND ?
                       GROUP BY
                           s.subject_name
                       ORDER BY
                           s.subject_name;
                       """;
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setDate(1, startDate);
            preparedStatement.setDate(2, endDate);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    subjectRegistrations.put(rs.getString("subject_name"), rs.getInt("count"));
                }
            }
        }
        return subjectRegistrations;
    }

    public Map<String, Map<String, Integer>> getSubjectRegistrationsByCategory(Date startDate, Date endDate) throws SQLException {
        Map<String, Map<String, Integer>> categorySubjectRegistrations = new LinkedHashMap<>();
        String query = """
                    SELECT
                          m.major_name,
                          s.subject_name,
                          COUNT(*) AS count
                          FROM
                            user_has_subject us
                          JOIN
                             subject s ON us.subject_id = s.subject_id
                          JOIN
                              major m ON s.major_id = m.major_id
                          WHERE
                              us.start_date BETWEEN ? AND ?
                           GROUP BY
                              m.major_name, s.subject_name
                           ORDER BY
                             m.major_name, s.subject_name;
                   """;
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setDate(1, startDate);
            preparedStatement.setDate(2, endDate);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    String categoryName = rs.getString("major_name");
                    String subjectName = rs.getString("subject_name");
                    int count = rs.getInt("count");

                    categorySubjectRegistrations
                            .computeIfAbsent(categoryName, k -> new LinkedHashMap<>())
                            .put(subjectName, count);
                }
            }
        }
        return categorySubjectRegistrations;
    }

    public static void main(String[] args) {
        DashboardDAO o = new DashboardDAO();
        try {
            // Convert String to java.sql.Date
            Date startDate = Date.valueOf("2024-01-01");
            Date endDate = Date.valueOf("2025-01-01");
            System.out.println(o.getSubjectRegistrations(startDate, endDate));
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
