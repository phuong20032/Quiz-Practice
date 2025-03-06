package dal;

import java.sql.*;
import model.Quiz;
import model.User;
import model.UserAttemptQuiz;

/**
 *
 * @author ADMIN
 */
public class UserAttempQuizDAO extends DBContext {

    // Phương thức thêm bản ghi vào bảng user_attemp_quiz
    public void addUserAttempQuiz(int userId, int quizId, int times) throws SQLException {
        String query = "INSERT INTO user_attemp_quiz (user_id, quiz_id, times) VALUES (?, ?, ?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, quizId);
            preparedStatement.setInt(3, times);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

    // Phương thức lấy bản ghi từ bảng user_attemp_quiz theo user_id và quiz_id
    public UserAttemptQuiz getUserAttempQuizById(int userId, int quizId) {
        UserDAO udao = new UserDAO();
        QuizDAO qdao = new QuizDAO();
        String query = "SELECT * FROM user_attemp_quiz WHERE user_id = ? AND quiz_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, quizId);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    UserAttemptQuiz userAttempQuiz = new UserAttemptQuiz();
                    User user = udao.getAllInfoByID(rs.getInt("user_id"));
                    userAttempQuiz.setUser(user);
                    Quiz quiz = qdao.getById(rs.getInt("quiz_id"));
                    userAttempQuiz.setQuiz(quiz);
                    userAttempQuiz.setTimes(rs.getInt("times"));
                    return userAttempQuiz;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to get user attempt quiz by ID", e);
        }
        return null;
    }

    // Phương thức tăng số lần thực hiện quiz hoặc thêm bản ghi mới nếu chưa có
    public void incrementUserAttempt(int userId, int quizId) throws SQLException {
        UserAttemptQuiz userAttemptQuiz = getUserAttempQuizById(userId, quizId);
        if (userAttemptQuiz == null) {
            addUserAttempQuiz(userId, quizId, 1);
        } else {
            String query = "UPDATE user_attemp_quiz SET times = times + 1 WHERE user_id = ? AND quiz_id = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setInt(1, userId);
                preparedStatement.setInt(2, quizId);
                preparedStatement.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
                throw e;
            }
        }
    }

    // Phương thức kiểm tra số lần thực hiện quiz
    public boolean hasReachedMaxAttempts(int userId, int quizId, int maxAttempts) {
        String query = "SELECT times FROM user_attemp_quiz WHERE user_id = ? AND quiz_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, quizId);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("times") >= maxAttempts;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to check user attempt count", e);
        }
        return false;
    }

    // Phương thức lấy số lần thực hiện còn lại của người dùng
    public int getTimesLeft(int userId, int quizId, int maxAttempts) {
        String query = "SELECT times FROM user_attemp_quiz WHERE user_id = ? AND quiz_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, quizId);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    return maxAttempts - rs.getInt("times");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to get remaining attempts", e);
        }
        return maxAttempts; // If no record found, assume no attempts have been made yet
    }
}
