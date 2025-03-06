/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author User
 */
public class UserHasSubjectDAO extends DBContext {

    public void addUserHasSubject(int subject_id, int user_id) {
        String sql = "INSERT INTO user_has_subject (subject_id, user_id, start_date) VALUES (?, ?, ?)";

        try (
                 PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, subject_id);
            statement.setInt(2, user_id);
            statement.setDate(3, java.sql.Date.valueOf(LocalDate.now()));

            statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserHasSubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void removeUserFromSubject(int subject_id, int user_id) {
        String sql = "DELETE FROM user_has_subject WHERE subject_id = ? AND user_id = ?";

        try ( PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, subject_id);
            statement.setInt(2, user_id);

            statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserHasSubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // Method to check if a user is already in a subject
    public boolean existUserInSubject(int subject_id, int user_id) {
        String sql = "SELECT 1 FROM user_has_subject WHERE subject_id = ? AND user_id = ?";

        try ( PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, subject_id);
            statement.setInt(2, user_id);

            try ( ResultSet rs = statement.executeQuery()) {
                return rs.next(); // If a record is found, return true
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserHasSubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public static void main(String[] args) {
        UserHasSubjectDAO dao = new UserHasSubjectDAO();
        System.out.println(dao.existUserInSubject(5, 1));
    }
}
