/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import java.util.List;
import model.Lesson;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;

/**
 *
 * @author ADMIN
 */
public class LessonDAO extends DBContext {

    public List<Lesson> getAllLessonWithParam(String searchParam, Integer status, Integer subjectId) {
        List<Lesson> lessons = new ArrayList<>();
        List<Object> list = new ArrayList<>();
        UserDAO userDao = new UserDAO();
        try {
            StringBuilder query = new StringBuilder();
            query.append("""
               SELECT 
                l.lesson_id, 
                l.lesson_name, 
                l.creator_id,
                l.created_at, 
                l.updated_at, 
                l.status, 
                l.description, 
                STRING_AGG(s.subject_name, ', ') AS subject_name,
               (Select count(*) from lesson_has_quiz where lesson_id = l.lesson_id)
               As total_quiz
            FROM 
                lesson l
             LEFT JOIN 
                subject_has_lesson sl ON l.lesson_id = sl.lesson_id
              LEFT JOIN 
                subject s ON s.subject_id = sl.subject_id """);
            if (searchParam != null && !searchParam.trim().isEmpty()) {
                query.append(" AND  l.lesson_name LIKE ? ");
                list.add("%" + searchParam + "%");
            }
            if (status != null) {
                query.append(" AND  l.status = ? ");
                list.add(status);
            }
            if (subjectId != null) {
                query.append(" AND  sl.subject_id = ? ");
                list.add(subjectId);
            }

            // first lesson add to subject -> lesson 1
            query.append("""
                          GROUP BY 
                             l.lesson_id, 
                             l.lesson_name, 
                             l.creator_id,
                             l.created_at, 
                             l.updated_at, 
                             l.status,
                           l.description
                         ORDER BY 
                             l.lesson_id ASC;""");
            PreparedStatement preparedStatement;
            preparedStatement = connection.prepareStatement(query.toString());
            mapParams(preparedStatement, list);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    Lesson lesson = new Lesson();
                    lesson.setLesson_id(rs.getInt("lesson_id"));
                    lesson.setLesson_name(rs.getString("lesson_name"));
                    lesson.setCreateAt(rs.getDate("created_at"));
                    lesson.setUpdaetAt(rs.getDate("updated_at"));
                    lesson.setStatus(rs.getInt("status"));
                    lesson.setSubject_name(rs.getString("subject_name"));
                    User u = userDao.getById(rs.getInt("creator_id"));
                    lesson.setCreator(u);
                    lesson.setQuiz_count(rs.getInt("total_quiz"));
                    lesson.setDescription(rs.getString("description"));
                    lessons.add(lesson);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lessons;
    }

    public List<Lesson> getAllLessonBySubject(Integer subjectId) {
        List<Lesson> lessons = new ArrayList<>();
        List<Object> list = new ArrayList<>();
        UserDAO userDao = new UserDAO();
        try {
            StringBuilder query = new StringBuilder();
            query.append("""
                         select l.* from lesson l 
                         JOIN subject_has_lesson sl 
                         ON l.lesson_id = sl.lesson_id
                         JOIN subject s 
                         ON s.subject_id = sl.subject_id                         
                         where l.status = 1 """);
            if (subjectId != null) {
                query.append(" AND  sl.subject_id = ? ");
                list.add(subjectId);
            }

            // first lesson added to subject -> lesson 1
            query.append(" ORDER BY sl.lesson_id ASC");
            PreparedStatement preparedStatement;
            preparedStatement = connection.prepareStatement(query.toString());
            mapParams(preparedStatement, list);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    Lesson lesson = new Lesson();
                    lesson.setLesson_id(rs.getInt("lesson_id"));
                    lesson.setLesson_name(rs.getString("lesson_name"));
                    lesson.setCreateAt(rs.getDate("created_at"));
                    lesson.setUpdaetAt(rs.getDate("updated_at"));
                    lesson.setStatus(rs.getInt("status"));
                    lesson.setDescription(rs.getString("description"));
                    User u = userDao.getById(rs.getInt("creator_id"));
                    lesson.setCreator(u);
                    lessons.add(lesson);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lessons;
    }

    public List<Lesson> getAllLessonByNotInSubject(Integer subjectId) {
        List<Lesson> lessons = new ArrayList<>();
        List<Object> list = new ArrayList<>();
        UserDAO userDao = new UserDAO();
        try {
            StringBuilder query = new StringBuilder();
            query.append("""
                         SELECT * 
                         FROM lesson 
                         WHERE lesson_id NOT IN (select lesson_id from subject_has_lesson where subject_id = ?)                    
                         And status = 1 """);
            list.add(subjectId);
            // first lesson added to subject -> lesson 1
            query.append(" ORDER BY lesson_id ASC");
            PreparedStatement preparedStatement;
            preparedStatement = connection.prepareStatement(query.toString());
            mapParams(preparedStatement, list);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    Lesson lesson = new Lesson();
                    lesson.setLesson_id(rs.getInt("lesson_id"));
                    lesson.setLesson_name(rs.getString("lesson_name"));
                    lesson.setCreateAt(rs.getDate("created_at"));
                    lesson.setUpdaetAt(rs.getDate("updated_at"));
                    lesson.setStatus(rs.getInt("status"));
                    lesson.setDescription(rs.getString("description"));
                    User u = userDao.getById(rs.getInt("creator_id"));
                    lesson.setCreator(u);
                    lessons.add(lesson);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lessons;
    }

    public List<Lesson> getAll() {
        List<Lesson> lessons = new ArrayList<>();

        UserDAO userDao = new UserDAO();
        try {
            StringBuilder query = new StringBuilder();
            query.append("""
                         SELECT * 
                         FROM lesson 
                         WHERE  status = 1 """);

            // first lesson added to subject -> lesson 1
            query.append(" ORDER BY lesson_id ASC");
            PreparedStatement preparedStatement;
            preparedStatement = connection.prepareStatement(query.toString());

            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    Lesson lesson = new Lesson();
                    lesson.setLesson_id(rs.getInt("lesson_id"));
                    lesson.setLesson_name(rs.getString("lesson_name"));
                    lesson.setCreateAt(rs.getDate("created_at"));
                    lesson.setUpdaetAt(rs.getDate("updated_at"));
                    lesson.setStatus(rs.getInt("status"));
                    User u = userDao.getById(rs.getInt("creator_id"));
                    lesson.setDescription(rs.getString("description"));
                    lesson.setCreator(u);
                    lessons.add(lesson);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lessons;
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

    public List<Lesson> Paging(List<Lesson> lesson, int page, int pageSize) {
        int fromIndex = (page - 1) * pageSize;
        int toIndex = Math.min(fromIndex + pageSize, lesson.size());

        if (fromIndex > toIndex) {
            // Handle the case where fromIndex is greater than toIndex
            fromIndex = toIndex;
        }

        return lesson.subList(fromIndex, toIndex);
    }

    public void addLessonsToSubject(int subjectId, String[] lessonIds) throws SQLException {
        String query = "INSERT INTO subject_has_lesson (subject_id, lesson_id) VALUES (?, ?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            for (String lessonIdStr : lessonIds) {
                int lessonId = Integer.parseInt(lessonIdStr);
                preparedStatement.setInt(1, subjectId);
                preparedStatement.setInt(2, lessonId);
                preparedStatement.addBatch();
            }
            preparedStatement.executeBatch();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

    public Lesson getLessonById(int lessonId) {
        Lesson lesson = null;
        UserDAO userDao = new UserDAO();
        try {
            String query = """
            SELECT l.* ,
            (Select count(*) from lesson_has_quiz where lesson_id = l.lesson_id)
                           As total_quiz
            			     FROM 
                            lesson l
                        LEFT JOIN 
                            subject_has_lesson sl ON l.lesson_id = sl.lesson_id
                        LEFT  JOIN 
                            subject s ON s.subject_id = sl.subject_id  WHERE l.lesson_id = ?
        """;

            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, lessonId);

            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    lesson = new Lesson();
                    lesson.setLesson_id(rs.getInt("lesson_id"));
                    lesson.setLesson_name(rs.getString("lesson_name"));
                    lesson.setCreateAt(rs.getDate("created_at"));
                    lesson.setUpdaetAt(rs.getDate("updated_at"));
                    lesson.setStatus(rs.getInt("status"));
                    lesson.setQuiz_count(rs.getInt("total_quiz"));
                    User u = userDao.getById(rs.getInt("creator_id"));
                    lesson.setDescription(rs.getString("description"));

                    lesson.setCreator(u);

                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lesson;
    }

    public void addLesson(String name, int user_id, int status, String descripton) throws SQLException {
        String query = """
        INSERT INTO lesson (lesson_name, creator_id, status, description,  created_at, updated_at) 
        VALUES (?, ?, ?,?,?,?)
    """;
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, name);
            preparedStatement.setInt(2, user_id);
            preparedStatement.setInt(3, status);
            preparedStatement.setString(4, descripton);
            java.sql.Date currentDate = new java.sql.Date(System.currentTimeMillis());
            preparedStatement.setDate(5, currentDate);
            preparedStatement.setDate(6, currentDate);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

    public void updateLessonStatus(int lessonId, int newStatus) throws SQLException {
        String query = """
        UPDATE lesson 
        SET status = ?, updated_at = ? 
        WHERE lesson_id = ?
    """;
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, newStatus);
            preparedStatement.setDate(2, new java.sql.Date(System.currentTimeMillis()));
            preparedStatement.setInt(3, lessonId);

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

    public void updateLesson(String name, String description, int id) throws SQLException {
        String query = """
        UPDATE lesson 
        SET lesson_name = ?, description = ?, updated_at = ?
        WHERE lesson_id = ?
        """;
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, name);
            preparedStatement.setString(2, description);
            java.sql.Date currentDate = new java.sql.Date(System.currentTimeMillis());
            preparedStatement.setDate(3, currentDate);
            preparedStatement.setInt(4, id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }
    public boolean isLessonNameExist(String lessonName) {
        String query = "SELECT COUNT(*) FROM lesson WHERE lesson_name = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, lessonName);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(LessonDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    public boolean isLessonNameExist(String lessonName, int excludeId) {
        String query = "SELECT COUNT(*) FROM lesson WHERE lesson_name = ? AND lesson_id != ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, lessonName);
            ps.setInt(2, excludeId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(LessonDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public static void main(String[] args) {
        LessonDAO dao = new LessonDAO();
        String name = "lesson_name";
        String description ="description";
        try {
            dao.addLesson(name, 1, 1, description);
        } catch (SQLException ex) {
            Logger.getLogger(LessonDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
