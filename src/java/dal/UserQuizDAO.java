/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.*;
import model.*;
import java.sql.*;

/**
 *
 * @author ADMIN
 */
public class UserQuizDAO extends DBContext {

    public List<UserDoneQuiz> getAllQuizDoneByUser(int userId, String searchParam, String filter, String sortBy) {
        List<UserDoneQuiz> userDoneQuizs = new ArrayList<>();
        List<Object> list = new ArrayList<>();
        UserDAO userDAO = new UserDAO();
        QuizDAO qdao = new QuizDAO();
        try {
            StringBuilder query = new StringBuilder();
            query.append("""
                     select distinct uq.*, q.*   from user_has_done_quiz uq
                                          join quiz q on q.quiz_id = uq.quiz_id
                     where uq.user_id = ?
                     """);
            list.add(userId);

            if (searchParam != null && !searchParam.trim().isEmpty()) {
                query.append(" AND q.quiz_title LIKE ? ");
                list.add("%" + searchParam + "%");
            }

            if (filter != null && !filter.trim().isEmpty()) {
                if (filter.equalsIgnoreCase("pass")) {
                    query.append(" AND uq.is_pass = 1 ");
                } else if (filter.equalsIgnoreCase("notPass")) {
                    query.append(" AND uq.is_pass = 0 ");
                }
            }

            

            if (sortBy != null && !sortBy.trim().isEmpty()) {
                if (sortBy.equalsIgnoreCase("score")) {
                    query.append(" ORDER BY uq.score ");
                } else if (sortBy.equalsIgnoreCase("time_done")) {
                    query.append(" ORDER BY uq.time_done ");
                }
            } else {
                query.append(" ORDER BY q.quiz_id ");
            }

            PreparedStatement preparedStatement;
            preparedStatement = connection.prepareStatement(query.toString());
            mapParams(preparedStatement, list);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    UserDoneQuiz user = new UserDoneQuiz();
                    user.setUser(userDAO.getById(rs.getInt("user_id")));
                    user.setQuiz(qdao.getById(rs.getInt("quiz_id")));
                    user.setScore(rs.getInt("score"));
                    user.setIs_pass(rs.getInt("is_pass"));
                    user.setTime_done(rs.getFloat("time_done"));
                    userDoneQuizs.add(user);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userDoneQuizs;
    }

    public Integer getCorrectAnswer(int questionId) {
        String query = """
                       SELECT a.answer_id FROM question_has_answer qa
                       JOIN answer a ON a.answer_id = qa.answer_id
                       WHERE question_id = ? AND is_correct = 1""";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, questionId);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("answer_id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Integer getUserAnswer(int userId, int quizId, int questionId) {
        String query = "SELECT answer_choose FROM quiz_result WHERE user_id = ? AND quiz_id = ? AND question_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, quizId);
            preparedStatement.setInt(3, questionId);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("answer_choose");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public UserDoneQuiz getByUserAndQuiz(int userId, int quizId) {

        List<Object> list = new ArrayList<>();
        UserDAO userDAO = new UserDAO();
        QuizDAO qdao = new QuizDAO();
        try {
            StringBuilder query = new StringBuilder();
            query.append("""
                         select * from quiz q 
                         join user_has_done_quiz uq 
                         on q.quiz_id = uq.quiz_id where user_id = ? and uq.quiz_id = ? 
                         """);
            list.add(userId);
            list.add(quizId);
            query.append(" order by q.quiz_id desc ");
            PreparedStatement preparedStatement;
            preparedStatement = connection.prepareStatement(query.toString());
            mapParams(preparedStatement, list);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    UserDoneQuiz user = new UserDoneQuiz();
                    user.setUser(userDAO.getById(rs.getInt("user_id")));
                    user.setQuiz(qdao.getById(rs.getInt("quiz_id")));
                    user.setScore(rs.getInt("score"));
                    user.setIs_pass(rs.getInt("is_pass"));
                    user.setTime_done(rs.getInt("time_done"));
                    return user;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean isUserTakenQuiz(int userId, int quizId) {
        boolean result = false;
        String query = """
                   select count(*) as count from user_has_done_quiz where user_id = ? and quiz_id = ?
                   """;
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, quizId);

            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt("count");
                    result = count > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public void storeUserAnswer(int userId, int quizId, int questionId, int answerId) throws SQLException {
        String query = """
            IF EXISTS (SELECT 1 FROM quiz_result WHERE user_id = ? AND quiz_id = ? AND question_id = ?)
                UPDATE quiz_result SET answer_choose = ? WHERE user_id = ? AND quiz_id = ? AND question_id = ?
            ELSE
                INSERT INTO quiz_result (user_id, quiz_id, question_id, answer_choose) VALUES (?, ?, ?, ?)
        """;
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, quizId);
            preparedStatement.setInt(3, questionId);
            preparedStatement.setInt(4, answerId);
            preparedStatement.setInt(5, userId);
            preparedStatement.setInt(6, quizId);
            preparedStatement.setInt(7, questionId);
            preparedStatement.setInt(8, userId);
            preparedStatement.setInt(9, quizId);
            preparedStatement.setInt(10, questionId);
            preparedStatement.setInt(11, answerId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

    public void storeUserAnswerNull(int userId, int quizId, int questionId) throws SQLException {
        String query = """
            IF EXISTS (SELECT 1 FROM quiz_result WHERE user_id = ? AND quiz_id = ? AND question_id = ?)
                UPDATE quiz_result SET answer_choose = NULL WHERE user_id = ? AND quiz_id = ? AND question_id = ?
            ELSE
                INSERT INTO quiz_result (user_id, quiz_id, question_id, answer_choose) VALUES (?, ?, ?, NULL)
        """;
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, quizId);
            preparedStatement.setInt(3, questionId);
            preparedStatement.setInt(4, userId);
            preparedStatement.setInt(5, quizId);
            preparedStatement.setInt(6, questionId);
            preparedStatement.setInt(7, userId);
            preparedStatement.setInt(8, quizId);
            preparedStatement.setInt(9, questionId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

   public void storeQuizResult(int userId, int quizId, int score, boolean isPass, float timeDone) throws SQLException {
    String query = """
        IF EXISTS (SELECT 1 FROM user_has_done_quiz WHERE user_id = ? AND quiz_id = ?)
            UPDATE user_has_done_quiz SET score = ?, is_pass = ?, time_done = ? WHERE user_id = ? AND quiz_id = ?
        ELSE
            INSERT INTO user_has_done_quiz (user_id, quiz_id, score, is_pass, time_done) VALUES (?, ?, ?, ?, ?)
    """;
    try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
        preparedStatement.setInt(1, userId);
        preparedStatement.setInt(2, quizId);
        preparedStatement.setInt(3, score);
        preparedStatement.setBoolean(4, isPass);
        preparedStatement.setFloat(5, timeDone);
        preparedStatement.setInt(6, userId);
        preparedStatement.setInt(7, quizId);
        preparedStatement.setInt(8, userId);
        preparedStatement.setInt(9, quizId);
        preparedStatement.setInt(10, score);
        preparedStatement.setBoolean(11, isPass);
        preparedStatement.setFloat(12, timeDone);
        preparedStatement.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
        throw e;
    }
}


    public boolean isAnswerCorrect(int answerId) {
        String query = "SELECT is_correct FROM answer WHERE answer_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, answerId);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    return rs.getBoolean("is_correct");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void mapParams(PreparedStatement ps, List<Object> args) throws SQLException {
        int i = 1;
        for (Object arg : args) {
            if (arg instanceof java.util.Date) {
                ps.setTimestamp(i++, new Timestamp(((java.util.Date) arg).getTime()));
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

    public List<UserDoneQuiz> Paging(List<UserDoneQuiz> users, int page, int pageSize) {
        int fromIndex = (page - 1) * pageSize;
        int toIndex = Math.min(fromIndex + pageSize, users.size());

        if (fromIndex > toIndex) {
            // Handle the case where fromIndex is greater than toIndex
            fromIndex = toIndex;
        }

        return users.subList(fromIndex, toIndex);
    }

}
