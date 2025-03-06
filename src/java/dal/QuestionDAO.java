/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import model.Answer;
import model.Question;

/**
 *
 * @author ADMIN
 */
public class QuestionDAO extends DBContext {

    public List<Question> getAllQuestionWithParam(String searchParam, Integer status, Integer lesson_id) {
        List<Question> question = new ArrayList<>();
        List<Object> list = new ArrayList<>();
        try {
            StringBuilder query = new StringBuilder();
            query.append("""
               SELECT 
                          q.*,
                            STRING_AGG(l.quiz_title, ', ') AS quiz_name,
                            (SELECT COUNT(*) FROM question_has_answer WHERE question_id = q.question_id) AS total_answer
                        FROM 
                            question q
                        LEFT JOIN 
                            quiz_has_question qs ON q.question_id = qs.question_id
                        LEFT JOIN 
                            Quiz l ON l.quiz_id = qs.quiz_id 
                         
                        WHERE 1 = 1
            """);
            if (searchParam != null && !searchParam.trim().isEmpty()) {
                query.append(" AND  q.question_detail LIKE ? ");
                list.add("%" + searchParam + "%");
            }
            if (status != null) {
                query.append(" AND  q.status = ? ");
                list.add(status);
            }
            if (lesson_id != null) {
                query.append(" AND  qs.quiz_id = ? ");
                list.add(lesson_id);
            }
            query.append("""
                 GROUP BY 
                    q.question_id,
                    q.question_detail,
                    q.status
                    ORDER BY 
                    q.question_id ASC
                """);
            PreparedStatement preparedStatement;
            preparedStatement = connection.prepareStatement(query.toString());
            mapParams(preparedStatement, list);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    Question qeQuestion = new Question();
                    qeQuestion.setQuestion_id(rs.getInt("question_id"));
                    qeQuestion.setQuestion_name(rs.getString("question_detail"));
                    qeQuestion.setQuiz_name(rs.getString("quiz_name"));
                    qeQuestion.setAnswer_count(rs.getInt("total_answer"));
                    qeQuestion.setStatus(rs.getInt("status"));
                    question.add(qeQuestion);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return question;
    }

    public List<Question> getAllQuestionByQuiz(Integer lesson_id) {
        List<Question> question = new ArrayList<>();
        List<Object> list = new ArrayList<>();
        
        try {
            StringBuilder query = new StringBuilder();
            query.append("""
                         select q.* from question q
                         JOIN quiz_has_question sq 
                         ON q.question_id = sq.question_id
                         JOIN Quiz l 
                         ON l.quiz_id = sq.quiz_id                         
                         where q.status = 1 """);
            if (lesson_id != null) {
                query.append(" AND  sq.quiz_id = ? ");
                list.add(lesson_id);
            }

            query.append(" ORDER BY sq.question_id ASC");
            PreparedStatement preparedStatement;
            preparedStatement = connection.prepareStatement(query.toString());
            mapParams(preparedStatement, list);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    Question qeQuestion = new Question();
                    qeQuestion.setQuestion_id(rs.getInt("question_id"));
                    qeQuestion.setQuestion_name(rs.getString("question_detail"));
                    qeQuestion.setStatus(rs.getInt("status"));
                    qeQuestion.setAnswers(getAllAnswerByQuestion(rs.getInt("question_id")));
                    question.add(qeQuestion);

                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return question;
    }

    public List<Answer> getAllAnswerByQuestion(int questionId) {
        List<Answer> answers = new ArrayList<>();
        try {
            String query = """
                           select a.* from answer a 
                           JOIN question_has_answer qa 
                           ON a.answer_id =  qa.answer_id 
                           JOIN question q 
                           ON q.question_id = qa.question_id 
                           WHERE q.question_id = ?
                           Order by a.answer_id
                            """;

            PreparedStatement preparedStatement;
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, questionId);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    Answer answer = new Answer();
                    answer.setAnswer_id(rs.getInt("answer_id"));
                    answer.setAnswer_content(rs.getString("answer_detail"));
                    answer.setIsCorrect(rs.getBoolean("is_correct"));
                    answers.add(answer);

                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return answers;
    }

    public Question getAllQuestionByID(Integer questionId) {

        try {
            String query = "Select * from question where question_id = ? ";

            PreparedStatement preparedStatement;
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, questionId);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    Question qeQuestion = new Question();
                    qeQuestion.setQuestion_id(rs.getInt("question_id"));
                    qeQuestion.setQuestion_name(rs.getString("question_detail"));
                    qeQuestion.setStatus(rs.getInt("status"));
                    return qeQuestion;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
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

    public List<Question> Paging(List<Question> questions, int page, int pageSize) {
        int fromIndex = (page - 1) * pageSize;
        int toIndex = Math.min(fromIndex + pageSize, questions.size());

        if (fromIndex > toIndex) {
            // Handle the case where fromIndex is greater than toIndex
            fromIndex = toIndex;
        }

        return questions.subList(fromIndex, toIndex);
    }

    public boolean addQuestion(Question question) throws SQLException {
        String checkQuestionSQL = "SELECT question_id FROM question WHERE question_detail = ?";
        String insertQuestionSQL = "INSERT INTO question (question_detail, status) VALUES (?, ?)";
        String fetchQuestionIdSQL = "SELECT question_id FROM question WHERE question_detail = ? AND status = ?";
        String insertAnswerSQL = "INSERT INTO answer (answer_detail, is_correct) VALUES (?, ?)";
        String fetchAnswerIdSQL = "SELECT answer_id FROM answer WHERE answer_detail = ? AND is_correct = ?";
        String linkQuestionAnswerSQL = "INSERT INTO question_has_answer (question_id, answer_id) VALUES (?, ?)";

        try (PreparedStatement psCheckQuestion = connection.prepareStatement(checkQuestionSQL)) {
            psCheckQuestion.setString(1, question.getQuestion_name());
            try (ResultSet rs = psCheckQuestion.executeQuery()) {
                if (rs.next()) {
                    // Question already exists
                    return false;
                }
            }

            connection.setAutoCommit(false); // Begin transaction

            // Insert question
            try (PreparedStatement psInsertQuestion = connection.prepareStatement(insertQuestionSQL)) {
                psInsertQuestion.setString(1, question.getQuestion_name());
                psInsertQuestion.setInt(2, 1);
                psInsertQuestion.executeUpdate();
            }

            // Retrieve generated question ID
            int questionId;
            try (PreparedStatement psFetchQuestionId = connection.prepareStatement(fetchQuestionIdSQL)) {
                psFetchQuestionId.setString(1, question.getQuestion_name());
                psFetchQuestionId.setInt(2, 1);
                try (ResultSet rs = psFetchQuestionId.executeQuery()) {
                    if (rs.next()) {
                        questionId = rs.getInt("question_id");
                        question.setQuestion_id(questionId);
                    } else {
                        throw new SQLException("Retrieving question ID failed, no ID obtained.");
                    }
                }
            }

            // Insert answers and link them to the question
            try (PreparedStatement psInsertAnswer = connection.prepareStatement(insertAnswerSQL); PreparedStatement psFetchAnswerId = connection.prepareStatement(fetchAnswerIdSQL); PreparedStatement psLinkQuestionAnswer = connection.prepareStatement(linkQuestionAnswerSQL)) {
                for (Answer answer : question.getAnswers()) {
                    // Insert answer
                    psInsertAnswer.setString(1, answer.getAnswer_content());
                    psInsertAnswer.setBoolean(2, answer.isIsCorrect());
                    psInsertAnswer.executeUpdate();

                    // Retrieve generated answer ID
                    int answerId;
                    psFetchAnswerId.setString(1, answer.getAnswer_content());
                    psFetchAnswerId.setBoolean(2, answer.isIsCorrect());
                    try (ResultSet rs = psFetchAnswerId.executeQuery()) {
                        if (rs.next()) {
                            answerId = rs.getInt("answer_id");
                        } else {
                            throw new SQLException("Retrieving answer ID failed, no ID obtained.");
                        }
                    }

                    // Link question and answer
                    psLinkQuestionAnswer.setInt(1, questionId);
                    psLinkQuestionAnswer.setInt(2, answerId);
                    psLinkQuestionAnswer.addBatch();
                }
                psLinkQuestionAnswer.executeBatch();
            }

            connection.commit(); // Commit transaction
            return true; // Indicate success
        } catch (SQLException e) {
            connection.rollback(); // Rollback transaction on error
            throw e;
        } finally {
            connection.setAutoCommit(true); // Restore default auto-commit behavior
        }
    }

    public void updateCorrectAnswer(int questionId, int correctAnswerId) {
        String updateCorrectSQL = "UPDATE answer SET is_correct = CASE WHEN answer_id = ? THEN 1 ELSE 0 END WHERE answer_id IN (SELECT answer_id FROM question_has_answer WHERE question_id = ?)";
        try (PreparedStatement ps = connection.prepareStatement(updateCorrectSQL)) {
            ps.setInt(1, correctAnswerId);
            ps.setInt(2, questionId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteAnswerFromQuestion(int questionId, int answerId) {
        String deleteSQL = "DELETE FROM question_has_answer WHERE question_id = ? AND answer_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(deleteSQL)) {
            ps.setInt(1, questionId);
            ps.setInt(2, answerId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateQuestion(int questionId, String questionName) {
        String updateSQL = "UPDATE question SET question_detail = ? WHERE question_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(updateSQL)) {
            ps.setString(1, questionName);
            ps.setInt(2, questionId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateQuestionStatus(int questionId, int status) {
        String updateSQL = "UPDATE question SET status = ? WHERE question_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(updateSQL)) {
            ps.setInt(1, status);
            ps.setInt(2, questionId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteQuestion(int questionId) {
        String deleteQuestionHasAnswerSQL = "DELETE FROM question_has_answer WHERE question_id = ?";
        String deleteAnswerSQL = "DELETE FROM answer WHERE answer_id IN (SELECT answer_id FROM question_has_answer WHERE question_id = ?)";
        String deleteQuestionSQL = "DELETE FROM question WHERE question_id = ?";

        try {
            // Start transaction
            connection.setAutoCommit(false);

            // Delete from question_has_answer
            try (PreparedStatement ps1 = connection.prepareStatement(deleteQuestionHasAnswerSQL)) {
                ps1.setInt(1, questionId);
                ps1.executeUpdate();
            }

            // Delete from answer
            try (PreparedStatement ps2 = connection.prepareStatement(deleteAnswerSQL)) {
                ps2.setInt(1, questionId);
                ps2.executeUpdate();
            }

            // Delete from question
            try (PreparedStatement ps3 = connection.prepareStatement(deleteQuestionSQL)) {
                ps3.setInt(1, questionId);
                ps3.executeUpdate();
            }

            // Commit transaction
            connection.commit();

        } catch (SQLException e) {
            e.printStackTrace();
            try {
                // Rollback transaction in case of an error
                if (connection != null) {
                    connection.rollback();
                }
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
        } finally {
            try {
                // Reset auto-commit to true
                if (connection != null) {
                    connection.setAutoCommit(true);
                }
            } catch (SQLException finalEx) {
                finalEx.printStackTrace();
            }
        }
    }

    public boolean doesQuestionExist(String questionName) {
        String query = "SELECT COUNT(*) FROM question WHERE question_detail = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, questionName);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean addQuestionToQuiz(int quizId, int questionId) {
        String linkQuestionToQuizSQL = "INSERT INTO quiz_has_question (quiz_id, question_id) VALUES (?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(linkQuestionToQuizSQL)) {
            ps.setInt(1, quizId);
            ps.setInt(2, questionId);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int getQuestionIdByName(String questionName) {
        String query = "SELECT question_id FROM question WHERE question_detail = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, questionName);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("question_id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // Return -1 if not found
    }

    public boolean isQuestionInQuiz(int quizId, int questionId) {
        String query = "SELECT COUNT(*) FROM quiz_has_question WHERE quiz_id = ? AND question_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, quizId);
            ps.setInt(2, questionId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean removeQuestionFromQuiz(int quizId, int questionId) {
        String sql = "Delete from quiz_has_question WHERE quiz_id = ? and question_id = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, quizId);
            statement.setInt(2, questionId);

            int rowsAffected = statement.executeUpdate();

            // Check if the update was successful
            return rowsAffected > 0;
        } catch (SQLException ex) {
            throw new RuntimeException("Delete failed: " + ex);
        }
    }

    public static void main(String[] args) {
        QuestionDAO questionDAO = new QuestionDAO();
        List<Question> list = questionDAO.getAllQuestionByQuiz(1);
        for (Question q : list) {
            System.out.println(q);
        }
//        List<Answer> listA = questionDAO.getAllAnswerByQuestion(1);
//        for (Answer a : listA) {
//            System.out.println(a);
//        }
    }

}
