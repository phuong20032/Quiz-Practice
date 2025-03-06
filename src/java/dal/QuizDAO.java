/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import java.util.List;
import model.Quiz;
import java.sql.*;
import model.Lesson;
import model.User;

/**
 *
 * @author ADMIN
 */
public class QuizDAO extends DBContext {

    public List<Quiz> getAllQuizByLesson(Integer lesson_id) {
        List<Quiz> lessons = new ArrayList<>();
        List<Object> list = new ArrayList<>();
        UserDAO userDao = new UserDAO();
        try {
            StringBuilder query = new StringBuilder();
            query.append("""
                         select q.* from quiz q
                         JOIN lesson_has_quiz sq 
                         ON q.quiz_id = sq.quiz_id
                         JOIN lesson l 
                         ON l.lesson_id = sq.lesson_id                         
                         where l.status = 1 """);
            if (lesson_id != null) {
                query.append(" AND  sq.lesson_id = ? ");
                list.add(lesson_id);
            }

            query.append(" ORDER BY sq.quiz_id ASC");
            PreparedStatement preparedStatement;
            preparedStatement = connection.prepareStatement(query.toString());
            mapParams(preparedStatement, list);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    Quiz quiz = new Quiz();
                    quiz.setQuiz_id(rs.getInt("quiz_id"));
                    quiz.setQuiz_name(rs.getString("quiz_title"));
                    quiz.setCreated_at(rs.getDate("created_at"));
                    quiz.setUpdated_at(rs.getDate("updated_at"));
                    quiz.setStatus(rs.getInt("status"));
                    User u = userDao.getById(rs.getInt("creator_id"));
                    quiz.setCreator(u);
                    lessons.add(quiz);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lessons;
    }

    public List<Quiz> getAllQuizNotInLesson(Integer lesson_id) {
        List<Quiz> quizes = new ArrayList<>();
        List<Object> list = new ArrayList<>();
        UserDAO userDao = new UserDAO();
        try {
            StringBuilder query = new StringBuilder();
            query.append("""
                         SELECT * 
                             FROM Quiz 
                             WHERE quiz_id NOT IN (select quiz_id from lesson_has_quiz where lesson_id = ?)                    
                             And status = 1 """);
            list.add(lesson_id);
            // first lesson added to subject -> lesson 1
            query.append(" ORDER BY quiz_id ASC");
            PreparedStatement preparedStatement;
            preparedStatement = connection.prepareStatement(query.toString());
            mapParams(preparedStatement, list);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    Quiz quiz = new Quiz();
                    quiz.setQuiz_id(rs.getInt("quiz_id"));
                    quiz.setQuiz_name(rs.getString("quiz_title"));
                    quiz.setCreated_at(rs.getDate("created_at"));
                    quiz.setUpdated_at(rs.getDate("updated_at"));
                    quiz.setStatus(rs.getInt("status"));
                    User u = userDao.getById(rs.getInt("creator_id"));
                    quiz.setCreator(u);
                    quizes.add(quiz);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return quizes;
    }

    public List<Quiz> getAllQuizWithParam(String searchParam, Integer status, Integer lesson_id) {
        List<Quiz> quizes = new ArrayList<>();
        List<Object> list = new ArrayList<>();
        UserDAO userDao = new UserDAO();
        try {
            StringBuilder query = new StringBuilder();
            query.append("""
           WITH QuizLessonNames AS (
            SELECT 
                q.quiz_id,
                STRING_AGG(l.lesson_name, ', ') AS lesson_name
            FROM 
                quiz q
            LEFT JOIN 
                lesson_has_quiz qs ON q.quiz_id = qs.quiz_id
            LEFT JOIN 
                lesson l ON l.lesson_id = qs.lesson_id
            GROUP BY 
                q.quiz_id
        )
        SELECT 
            q.quiz_id,
            q.quiz_title,
            q.created_at,
            q.updated_at,
            q.creator_id,
            q.status,
            q.min_to_pass,
            q.attemp_time,
            q.count_down,
            COALESCE(ql.lesson_name, '') AS lesson_name,
            (SELECT COUNT(*) FROM quiz_has_question qh JOIN question qu on qu.question_id = qh.question_id WHERE qh.quiz_id = q.quiz_id and qu.status = 1) AS total_question,
            CASE 
                WHEN COUNT(u.user_id) = 0 THEN 0
                ELSE CAST(SUM(CASE WHEN u.is_pass = 1 THEN 1 ELSE 0 END) AS FLOAT) / COUNT(u.user_id) * 100
            END AS pass_rate
        FROM 
            quiz q
        LEFT JOIN 
            QuizLessonNames ql ON q.quiz_id = ql.quiz_id
        LEFT JOIN
            user_has_done_quiz u ON q.quiz_id = u.quiz_id
        LEFT JOIN
            lesson_has_quiz qs ON q.quiz_id = qs.quiz_id
        WHERE 1 = 1
        """);
            if (searchParam != null && !searchParam.trim().isEmpty()) {
                query.append(" AND q.quiz_title LIKE ? ");
                list.add("%" + searchParam + "%");
            }
            if (status != null) {
                query.append(" AND q.status = ? ");
                list.add(status);
            }
            if (lesson_id != null) {
                query.append(" AND qs.lesson_id = ? ");
                list.add(lesson_id);
            }
            query.append("""
            GROUP BY 
                        q.quiz_id,
                        q.quiz_title,
                        q.created_at,
                        q.updated_at,
                        q.creator_id,
                        q.status,
                        q.min_to_pass,
                        q.count_down,
                         q.attemp_time,
                        ql.lesson_name
                    ORDER BY 
                        q.quiz_id ASC;
            """);
            PreparedStatement preparedStatement;
            preparedStatement = connection.prepareStatement(query.toString());
            mapParams(preparedStatement, list);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    Quiz quiz = new Quiz();
                    quiz.setQuiz_id(rs.getInt("quiz_id"));
                    quiz.setQuiz_name(rs.getString("quiz_title"));
                    quiz.setCreated_at(rs.getDate("created_at"));
                    quiz.setUpdated_at(rs.getDate("updated_at"));
                    quiz.setStatus(rs.getInt("status"));
                    quiz.setMin_to_pass(rs.getInt("min_to_pass"));
                    quiz.setPass_rate(rs.getInt("pass_rate"));
                    quiz.setLesson_name(rs.getString("lesson_name"));
                    quiz.setCount_down(rs.getInt("count_down"));
                    quiz.setTotal_question(rs.getInt("total_question"));
                    quiz.setAttemp_time(rs.getInt("attemp_time"));
                    User u = userDao.getById(rs.getInt("creator_id"));
                    boolean isQuizTaken = isQuizTaken(rs.getInt("quiz_id"));
                    quiz.setIsQuizTaken(isQuizTaken);
                    quiz.setCreator(u);
                    quizes.add(quiz);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return quizes;
    }

    public List<Quiz> Paging(List<Quiz> products, int page, int pageSize) {
        int fromIndex = (page - 1) * pageSize;
        int toIndex = Math.min(fromIndex + pageSize, products.size());

        if (fromIndex > toIndex) {
            // Handle the case where fromIndex is greater than toIndex
            fromIndex = toIndex;
        }

        return products.subList(fromIndex, toIndex);
    }

    public void addQuizToLesson(int lesson_id, String[] quizIds) throws SQLException {
        String query = "INSERT INTO lesson_has_quiz (lesson_id, quiz_id) VALUES (?, ?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            for (String quizIdStr : quizIds) {
                int quizId = Integer.parseInt(quizIdStr);
                preparedStatement.setInt(1, lesson_id);
                preparedStatement.setInt(2, quizId);
                preparedStatement.addBatch();
            }
            preparedStatement.executeBatch();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }

    }

    public boolean removeQuizFromLesson(int lessonId, int quizId) {
        String sql = "Delete from lesson_has_quiz WHERE lesson_id = ? and quiz_id = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, lessonId);
            statement.setInt(2, quizId);

            int rowsAffected = statement.executeUpdate();

            // Check if the update was successful
            return rowsAffected > 0;
        } catch (SQLException ex) {
            throw new RuntimeException("Delete failed: " + ex);
        }
    }

    public void mapParams(PreparedStatement ps, List<Object> args) throws SQLException {
        int i = 1;
        for (Object arg : args) {
            if (arg instanceof Date) {
                ps.setTimestamp(i++, new Timestamp(((Date) arg).getTime()));
            } else if (arg instanceof Integer) {
                ps.setInt(i++, (Integer) arg);
            } else if (arg instanceof Long) {
                ps.setLong(i++, (Long) arg);
            } else if (arg instanceof Double) {
                ps.setDouble(i++, (Double) arg);
            } else if (arg instanceof Float) {
                ps.setFloat(i++, (Float) arg);
            } else {
                ps.setString(i++, (String) arg);
            }

        }
    }

    public void updateQuizStatus(int quizId, int newStatus) throws SQLException {
        String query = """
        UPDATE quiz 
        SET status = ?, updated_at = ? 
        WHERE quiz_id = ?
    """;
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, newStatus);
            preparedStatement.setDate(2, new java.sql.Date(System.currentTimeMillis()));
            preparedStatement.setInt(3, quizId);

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

    public void addQuiz(String title, int creatorId, int status, int countDown, int min_to_pass, int time_attemp) throws SQLException {
        String query = """
        INSERT INTO quiz (quiz_title, creator_id, status, count_down, created_at, updated_at, min_to_pass, attemp_time) 
        VALUES (?, ?, ?, ?, ?, ?, ?, ? )
    """;
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, title);
            preparedStatement.setInt(2, creatorId);
            preparedStatement.setInt(3, status);
            preparedStatement.setInt(4, countDown);
            preparedStatement.setDate(5, new java.sql.Date(System.currentTimeMillis()));
            preparedStatement.setDate(6, new java.sql.Date(System.currentTimeMillis()));
            preparedStatement.setInt(7, min_to_pass);
            preparedStatement.setInt(8, time_attemp);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

    public void updateQuiz(int quizId, String title, int countDown, int min_to_pass, int time_attemp) throws SQLException {
        String query = """
    UPDATE quiz 
    SET quiz_title = ?, count_down = ?,min_to_pass=? , updated_at = ? , attemp_time = ?
    WHERE quiz_id = ?
    """;
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, title);
            preparedStatement.setInt(2, countDown);
            preparedStatement.setInt(3, min_to_pass);
            preparedStatement.setDate(4, new java.sql.Date(System.currentTimeMillis()));
            preparedStatement.setInt(5, time_attemp);
            preparedStatement.setInt(6, quizId);

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to update quiz", e);
        }
    }

    public boolean isQuizTaken(int quizId) {
        String query = "SELECT COUNT(*) AS count FROM user_has_done_quiz WHERE quiz_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, quizId);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("count") > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to check if users have done quiz", e);
        }
        return false;
    }

    public Quiz getById(int quizId) {
        String query = """
                       WITH QuizLessonNames AS (
                                   SELECT 
                                       q.quiz_id,
                                       STRING_AGG(l.lesson_name, ', ') AS lesson_name
                                   FROM 
                                       quiz q
                                   LEFT JOIN 
                                       lesson_has_quiz qs ON q.quiz_id = qs.quiz_id
                                   LEFT JOIN 
                                       lesson l ON l.lesson_id = qs.lesson_id
                                   GROUP BY 
                                       q.quiz_id
                               )
                               SELECT 
                                   q.quiz_id,
                                   q.quiz_title,
                                   q.created_at,
                                   q.updated_at,
                                   q.creator_id,
                                   q.status,
                                   q.attemp_time,
                                   q.min_to_pass,
                                   q.count_down,
                                   COALESCE(ql.lesson_name, '') AS lesson_name,
                                   (SELECT COUNT(*) FROM quiz_has_question qh JOIN question qu on qu.question_id = qh.question_id WHERE qh.quiz_id = q.quiz_id and qu.status = 1) AS total_question,
                                     CASE 
                                       WHEN COUNT(u.user_id) = 0 THEN 0
                                       ELSE CAST(SUM(CASE WHEN u.is_pass = 1 THEN 1 ELSE 0 END) AS FLOAT) / COUNT(u.user_id) * 100
                                   END AS pass_rate
                               FROM 
                                   quiz q
                               LEFT JOIN 
                                   QuizLessonNames ql ON q.quiz_id = ql.quiz_id
                               LEFT JOIN
                                   user_has_done_quiz u ON q.quiz_id = u.quiz_id
                               LEFT JOIN
                                   lesson_has_quiz qs ON q.quiz_id = qs.quiz_id
                               WHERE q.quiz_id = ?
                       GROUP BY 
                                q.quiz_id,
                                q.quiz_title,
                                               q.created_at,
                                               q.updated_at,
                                               q.creator_id,
                                               q.status,
                                               q.min_to_pass,
                                               q.count_down,
                                               q.attemp_time,
                                               ql.lesson_name
                                           ORDER BY 
                                               q.quiz_id DESC;
                       """;
        UserDAO userDao = new UserDAO();
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, quizId);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    Quiz quiz = new Quiz();
                    quiz.setQuiz_id(rs.getInt("quiz_id"));
                    quiz.setQuiz_name(rs.getString("quiz_title"));
                    quiz.setCreated_at(rs.getDate("created_at"));
                    quiz.setUpdated_at(rs.getDate("updated_at"));
                    quiz.setStatus(rs.getInt("status"));
                    quiz.setMin_to_pass(rs.getInt("min_to_pass"));
                    quiz.setPass_rate(rs.getInt("pass_rate"));
                    quiz.setLesson_name(rs.getString("lesson_name"));
                    quiz.setCount_down(rs.getInt("count_down"));
                    quiz.setTotal_question(rs.getInt("total_question"));
                    quiz.setAttemp_time(rs.getInt("attemp_time"));
                    User u = userDao.getById(rs.getInt("creator_id"));
                    boolean isQuizTaken = isQuizTaken(rs.getInt("quiz_id"));
                    quiz.setIsQuizTaken(isQuizTaken);
                    quiz.setCreator(u);
                    return quiz;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to get quiz by ID", e);
        }
        return null;
    }

    public int getTimeAttempt(int quizId) {
        String query = "SELECT attemp_time FROM quiz WHERE quiz_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, quizId);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("attemp_time");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to get attempt time for quiz", e);
        }
        return 0; // Hoặc giá trị mặc định nếu không tìm thấy
    }

    public boolean isQuizNameExist(String quizName) {
        String query = "SELECT COUNT(*) FROM quiz WHERE quiz_title = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, quizName);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException ex) {
        }
        return false;
    }
public boolean isQuizNameExist(String quizName, int excludeId) {
        String query = "SELECT COUNT(*) FROM quiz WHERE quiz_title = ? AND quiz_id != ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, quizName);
            ps.setInt(2, excludeId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException ex) {
        }
        return false;
    }
    public static void main(String[] args) {
        LessonDAO dao = new LessonDAO();
        Lesson list = dao.getLessonById(1);
        System.out.println(list);
//        for (Quiz q : list) {
//            System.out.println(q);
//        }
//        System.out.println(dao.isQuizNameExist("ok33"));
    }
}
