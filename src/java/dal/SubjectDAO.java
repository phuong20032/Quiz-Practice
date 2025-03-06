/* 18/5
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.*;
import java.sql.Timestamp;

/**
 *
 * @author ADMIN
 */
public class SubjectDAO extends DBContext {

    public List<Subject> getAll(int index) {
        List<Subject> list = new ArrayList<>();
        String sql;
//        if (id == 0) {
        // When id is 0, select all subjects
        sql = "SELECT s.*\n"
                + "FROM [subject] s where s.status =1\n"
                + "ORDER BY s.subject_id\n"
                + "OFFSET ? ROWS FETCH NEXT 2 ROWS ONLY";
//        } else {
        // When id is not 0, select subjects that the user has not registered for
//            sql = "SELECT s.*\n"
//                    + "FROM [subject] s\n"
//                    + "LEFT JOIN user_has_subject uhs ON s.subject_id = uhs.subject_id AND uhs.user_id = ?\n"
//                    + "WHERE uhs.user_id IS NULL\n"
//                    + "ORDER BY s.subject_id\n"
//                    + "OFFSET ? ROWS FETCH NEXT 2 ROWS ONLY";
//        }

        try {
            PreparedStatement st = connection.prepareStatement(sql);

//            if (id == 0) {
            // Only set the offset parameter when id is 0
            st.setInt(1, (index - 1) * 2);
//            } else {
//                // Set the user_id parameter first when id is not 0
//                st.setInt(1, id);
//                // Set the offset parameter next
//                st.setInt(2, (index - 1) * 2);
//            }

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Subject p = new Subject(
                        rs.getInt("subject_id"),
                        rs.getString("subject_name"),
                        rs.getInt("creator_id"),
                        rs.getDate("created_at"),
                        rs.getDate("updated_at"),
                        rs.getInt("status"),
                        rs.getString("subject_img"),
                        rs.getInt("major_id"),
                        rs.getString("subject_content"),
                        rs.getString("subject_title")
                );
                list.add(p);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Subject> getAll() {
        List<Subject> list = new ArrayList<>();
        String sql;
        sql = """
              SELECT s.*
              FROM [subject] s where s.status =1
              ORDER BY s.subject_id
              """;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Subject p = new Subject(
                        rs.getInt("subject_id"),
                        rs.getString("subject_name"),
                        rs.getInt("creator_id"),
                        rs.getDate("created_at"),
                        rs.getDate("updated_at"),
                        rs.getInt("status"),
                        rs.getString("subject_img"),
                        rs.getInt("major_id"),
                        rs.getString("subject_content"),
                        rs.getString("subject_title")
                );
                list.add(p);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Subject> getAllUserSubject(int user_id) {
        List<Subject> list = new ArrayList<>();
        String sql;
        sql = "select * from user_has_subject us \n"
                + "JOIN subject s ON s.subject_id = us.subject_id\n"
                + "where us.user_id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);

            st.setInt(1, user_id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Subject p = new Subject(
                        rs.getInt("subject_id"),
                        rs.getString("subject_name"),
                        rs.getInt("creator_id"),
                        rs.getDate("created_at"),
                        rs.getDate("updated_at"),
                        rs.getInt("status"),
                        rs.getString("subject_img"),
                        rs.getInt("major_id"),
                        rs.getString("subject_content"),
                        rs.getString("subject_title")
                );
                list.add(p);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    // Count all the blog pagination standard
    public List<Subject> getTop3Subject() {
        List<Subject> list = new ArrayList<>();
        String sql;
        sql = """
              select top 3 * from subject where status = 1  order by subject_id desc
              """;

        try {
            PreparedStatement st = connection.prepareStatement(sql);

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Subject p = new Subject(
                        rs.getInt("subject_id"),
                        rs.getString("subject_name"),
                        rs.getInt("creator_id"),
                        rs.getDate("created_at"),
                        rs.getDate("updated_at"),
                        rs.getInt("status"),
                        rs.getString("subject_img"),
                        rs.getInt("major_id"),
                        rs.getString("subject_content"),
                        rs.getString("subject_title")
                );
                list.add(p);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    // Count all the blog pagination standard
    public int getTatolSubject(String id) {
        String sql = "Select count(*) from subject  where  status = 1 and [major_id] like '%" + id + "%'";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public int getTatolName(String id) {
        String sql = "Select count(*) from subject  where subject_name like '%" + id + "%'";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    //Search by subject name ex: SE, AI
    public List<Subject> searchByCourseName(int course, String id) {
        List<Subject> list = new ArrayList<>();

        String sql = "SELECT [subject_id]\n"
                + "      ,[subject_name]\n"
                + "      ,[creator_id]\n"
                + "      ,[created_at]\n"
                + "      ,[updated_at]\n"
                + "      ,[status]\n"
                + "      ,[subject_img]\n"
                + "      ,[major_id]\n"
                + "      ,[subject_content]\n"
                + "      ,[subject_title]\n"
                + "  FROM [dbo].[subject] where [major_id] Like '%" + id + "%'\n"
                + "  Order By created_at DESC,subject_id\n"
                + "    OffSet ? Rows Fetch Next 2 Rows Only";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            // couce is name number pasge
            st.setInt(1, (course - 1) * 2);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Subject p = new Subject(rs.getInt("subject_id"), rs.getString("subject_name"), rs.getInt("creator_id"), rs.getDate("created_at"),
                        rs.getDate("updated_at"), rs.getInt("status"),
                        rs.getString("subject_img"), rs.getInt("major_id"), rs.getString("subject_content"), rs.getString("subject_title"));
                list.add(p);
            }

        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }

    public List<Subject> searchByName(int course, String id) {
        List<Subject> list = new ArrayList<>();

        String sql = "SELECT [subject_id]\n"
                + "      ,[subject_name]\n"
                + "      ,[creator_id]\n"
                + "      ,[created_at]\n"
                + "      ,[updated_at]\n"
                + "      ,[status]\n"
                + "      ,[subject_img]\n"
                + "      ,[major_id]\n"
                + "      ,[subject_content]\n"
                + "      ,[subject_title]\n"
                + "  FROM [dbo].[subject] where status =1 and  [subject_name] Like '%" + id + "%'\n"
                + "  Order By created_at DESC,subject_id\n"
                + "    OffSet ? Rows Fetch Next 2 Rows Only";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            // couce is name number pasge
            st.setInt(1, (course - 1) * 2);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Subject p = new Subject(rs.getInt("subject_id"), rs.getString("subject_name"), rs.getInt("creator_id"), rs.getDate("created_at"),
                        rs.getDate("updated_at"), rs.getInt("status"),
                        rs.getString("subject_img"), rs.getInt("major_id"), rs.getString("subject_content"), rs.getString("subject_title"));
                list.add(p);
            }

        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }

    public List<Subject> getAllProdcutWithParam(String searchParam, Integer status, Integer major_id) {
        List<Subject> subjects = new ArrayList<>();
        List<Object> list = new ArrayList<>();
        UserDAO userDAO = new UserDAO();
        try {
            StringBuilder query = new StringBuilder();
            query.append("""
                         SELECT s.*,m.major_id, m.major_name, u.userName ,
                                (SELECT COUNT(*) 
                         	   FROM subject_has_lesson AS total_lesson WHERE subject_id = s.subject_id) 
                         	   AS total_lessons
                         FROM subject s
                         JOIN major m ON m.major_id = s.major_id
                         JOIN [user] u ON u.user_id = s.creator_id  where 1=1""");
            if (searchParam != null && !searchParam.trim().isEmpty()) {
                query.append(" AND  s.subject_name LIKE ? ");
                list.add("%" + searchParam + "%");
            }
            if (status != null) {
                query.append(" AND  s.status = ? ");
                list.add(status);
            }
            if (major_id != null) {
                query.append(" AND  s.major_id = ? ");
                list.add(major_id);
            }
            query.append(" ORDER BY s.subject_id DESC");
            PreparedStatement preparedStatement;
            preparedStatement = connection.prepareStatement(query.toString());
            mapParams(preparedStatement, list);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    Subject subject = new Subject();
                    subject.setSubject_id(rs.getInt("subject_id"));
                    subject.setSubject_name(rs.getString("subject_name"));
                    subject.setCreator_id(rs.getInt("creator_id"));
                    subject.setCreated_at(rs.getDate("created_at"));
                    subject.setUpdated_at(rs.getDate("updated_at"));
                    subject.setStatus(rs.getInt("status"));
                    subject.setSubject_img(rs.getString("subject_img"));
                    subject.setMajor_id(rs.getInt("major_id"));
                    subject.setSubject_content(rs.getString("subject_content"));
                    subject.setSubject_title(rs.getString("subject_title"));
                    subject.setTotal_lesson(rs.getInt("total_lessons"));
                    subject.setFeatured_flag(rs.getInt("featured_flag"));
                    subject.setCreator_name(rs.getString("userName"));
                    // If Major is another class and you need to set it
                    Major major = new Major();
                    major.setMajor_name(rs.getString("major_name"));
                    subject.setMajor(major);
                    User u = userDAO.getById(rs.getInt("owner_id"));
                    subject.setOwner(u);
                    subjects.add(subject);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return subjects;
    }

    public List<Subject> getAllProdcutWithParamForExpert(String searchParam, Integer status, Integer major_id, Integer owner_id) {
        List<Subject> subjects = new ArrayList<>();
        List<Object> list = new ArrayList<>();
        UserDAO userDAO = new UserDAO();
        try {
            StringBuilder query = new StringBuilder();
            query.append("""
                         SELECT s.*,m.major_id, m.major_name, u.userName ,
                                (SELECT COUNT(*) 
                         	   FROM subject_has_lesson AS total_lesson WHERE subject_id = s.subject_id) 
                         	   AS total_lessons
                         FROM subject s
                         JOIN major m ON m.major_id = s.major_id
                         JOIN [user] u ON u.user_id = s.creator_id  where owner_id = ? """);
            list.add(owner_id);
            if (searchParam != null && !searchParam.trim().isEmpty()) {
                query.append(" AND  s.subject_name LIKE ? ");
                list.add("%" + searchParam + "%");
            }
            if (status != null) {
                query.append(" AND  s.status = ? ");
                list.add(status);
            }
            if (major_id != null) {
                query.append(" AND  s.major_id = ? ");
                list.add(major_id);
            }
            query.append(" ORDER BY s.subject_id DESC");
            PreparedStatement preparedStatement;
            preparedStatement = connection.prepareStatement(query.toString());
            mapParams(preparedStatement, list);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    Subject subject = new Subject();
                    subject.setSubject_id(rs.getInt("subject_id"));
                    subject.setSubject_name(rs.getString("subject_name"));
                    subject.setCreator_id(rs.getInt("creator_id"));
                    subject.setCreated_at(rs.getDate("created_at"));
                    subject.setUpdated_at(rs.getDate("updated_at"));
                    subject.setStatus(rs.getInt("status"));
                    subject.setSubject_img(rs.getString("subject_img"));
                    subject.setMajor_id(rs.getInt("major_id"));
                    subject.setSubject_content(rs.getString("subject_content"));
                    subject.setSubject_title(rs.getString("subject_title"));
                    subject.setTotal_lesson(rs.getInt("total_lessons"));
                    subject.setFeatured_flag(rs.getInt("featured_flag"));
                    subject.setCreator_name(rs.getString("userName"));
                    // If Major is another class and you need to set it
                    Major major = new Major();
                    major.setMajor_name(rs.getString("major_name"));
                    subject.setMajor(major);
                    User u = userDAO.getById(rs.getInt("owner_id"));
                    subject.setOwner(u);
                    subjects.add(subject);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return subjects;
    }

    public List<Subject> getAllProdcutWithParam(String searchParam, Integer major_id) {
        List<Subject> subjects = new ArrayList<>();
        List<Object> list = new ArrayList<>();
        UserDAO userDAO = new UserDAO();
        try {
            StringBuilder query = new StringBuilder();
            query.append("""
                         SELECT s.*,m.major_id, m.major_name, u.userName ,
                                (SELECT COUNT(*) 
                         	   FROM subject_has_lesson AS total_lesson WHERE subject_id = s.subject_id) 
                         	   AS total_lessons
                         FROM subject s
                         JOIN major m ON m.major_id = s.major_id
                         JOIN [user] u ON u.user_id = s.creator_id  where s.status = 1 """);
            if (searchParam != null && !searchParam.trim().isEmpty()) {
                query.append(" AND  s.subject_name LIKE ? ");
                list.add("%" + searchParam + "%");
            }
            if (major_id != null) {
                query.append(" AND  s.major_id = ? ");
                list.add(major_id);
            }
            query.append(" ORDER BY s.subject_id DESC");
            PreparedStatement preparedStatement;
            preparedStatement = connection.prepareStatement(query.toString());
            mapParams(preparedStatement, list);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    Subject subject = new Subject();
                    subject.setSubject_id(rs.getInt("subject_id"));
                    subject.setSubject_name(rs.getString("subject_name"));
                    subject.setCreator_id(rs.getInt("creator_id"));
                    subject.setCreated_at(rs.getDate("created_at"));
                    subject.setUpdated_at(rs.getDate("updated_at"));
                    subject.setStatus(rs.getInt("status"));
                    subject.setSubject_img(rs.getString("subject_img"));
                    subject.setMajor_id(rs.getInt("major_id"));
                    subject.setSubject_content(rs.getString("subject_content"));
                    subject.setSubject_title(rs.getString("subject_title"));
                    subject.setTotal_lesson(rs.getInt("total_lessons"));
                    subject.setFeatured_flag(rs.getInt("featured_flag"));
                    subject.setCreator_name(rs.getString("userName"));
                    // If Major is another class and you need to set it
                    Major major = new Major();
                    major.setMajor_name(rs.getString("major_name"));
                    subject.setMajor(major);
                    User u = userDAO.getById(rs.getInt("owner_id"));
                    subject.setOwner(u);
                    subjects.add(subject);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return subjects;
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

    public List<Subject> Paging(List<Subject> products, int page, int pageSize) {
        int fromIndex = (page - 1) * pageSize;
        int toIndex = Math.min(fromIndex + pageSize, products.size());

        if (fromIndex > toIndex) {
            // Handle the case where fromIndex is greater than toIndex
            fromIndex = toIndex;
        }

        return products.subList(fromIndex, toIndex);
    }

    public boolean changeSubjectStatus(int subjectId, int newStatus) {
        String sql = "UPDATE subject SET status = ? WHERE subject_id = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, newStatus);
            statement.setInt(2, subjectId);

            int rowsAffected = statement.executeUpdate();

            // Check if the update was successful
            return rowsAffected > 0;
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public boolean removeLessonFromSubject(int subjectId, int lessonId) {
        String sql = "Delete from subject_has_lesson WHERE subject_id = ? and lesson_id = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, subjectId);
            statement.setInt(2, lessonId);

            int rowsAffected = statement.executeUpdate();

            // Check if the update was successful
            return rowsAffected > 0;
        } catch (SQLException ex) {
            throw new RuntimeException("Delete failed: " + ex);
        }
    }

    public boolean addSubject(Subject subject) {
        String sql = "INSERT INTO subject (subject_name, creator_id,owner_id, created_at, updated_at, status, subject_img, major_id, subject_content, subject_title, featured_flag) "
                + "VALUES (?, ?, ?,?,?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, subject.getSubject_name());
            statement.setInt(2, subject.getCreator_id());
            statement.setInt(3, subject.getOwner().getUser_id());
            statement.setTimestamp(4, new Timestamp(subject.getCreated_at().getTime()));
            statement.setTimestamp(5, new Timestamp(subject.getUpdated_at().getTime()));
            statement.setInt(6, subject.getStatus());
            statement.setString(7, subject.getSubject_img());
            statement.setInt(8, subject.getMajor_id());
            statement.setString(9, subject.getSubject_content());
            statement.setString(10, subject.getSubject_title());
            statement.setInt(11, subject.getFeatured_flag());

            int rowsAffected = statement.executeUpdate();

            // Check if the insertion was successful
            return rowsAffected > 0;
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public boolean editSubject(Subject subject) {
        String sql = "UPDATE subject SET subject_name = ?, creator_id = ?, created_at = ?, updated_at = ?, status = ?, "
                + "subject_img = ?, major_id = ?, subject_content = ?, subject_title = ?, owner_id = ?, featured_flag = ? WHERE subject_id = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, subject.getSubject_name());
            statement.setInt(2, subject.getCreator_id());
            statement.setTimestamp(3, new Timestamp(subject.getCreated_at().getTime()));
            statement.setTimestamp(4, new Timestamp(subject.getUpdated_at().getTime()));
            statement.setInt(5, subject.getStatus());
            statement.setString(6, subject.getSubject_img());
            statement.setInt(7, subject.getMajor_id());
            statement.setString(8, subject.getSubject_content());
            statement.setString(9, subject.getSubject_title());
            statement.setInt(10, subject.getOwner().getUser_id()); // Save owner ID
            statement.setInt(11, subject.getFeatured_flag());
            statement.setInt(12, subject.getSubject_id());

            int rowsAffected = statement.executeUpdate();

            // Check if the update was successful
            return rowsAffected > 0;
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public Subject getSubjectById(int subjectId) {
        String sql = "SELECT * FROM subject WHERE subject_id = ?";
        UserDAO userDAO = new UserDAO();
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, subjectId);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                Subject subject = new Subject();
                subject.setSubject_id(rs.getInt("subject_id"));
                subject.setSubject_name(rs.getString("subject_name"));
                subject.setCreator_id(rs.getInt("creator_id"));
                subject.setCreated_at(rs.getDate("created_at"));
                subject.setUpdated_at(rs.getDate("updated_at"));
                subject.setStatus(rs.getInt("status"));
                subject.setSubject_img(rs.getString("subject_img"));
                subject.setMajor_id(rs.getInt("major_id"));
                subject.setSubject_content(rs.getString("subject_content"));
                subject.setSubject_title(rs.getString("subject_title"));
                subject.setFeatured_flag(rs.getInt("featured_flag"));
                // If Major is another class and you need to set it
                Major major = new Major();
                subject.setMajor(major);
                User u = userDAO.getById(rs.getInt("owner_id"));
                subject.setOwner(u);
                return subject;
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null; // Subject not found
    }

    public boolean isSubjectNameExist(String subjectName, int excludeId) {
        String query = "SELECT COUNT(*) FROM subject WHERE subject_name = ? AND subject_id != ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, subjectName);
            ps.setInt(2, excludeId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean isSubjectNameExists(String subjectName) {
        String query = "SELECT COUNT(*) FROM subject WHERE subject_name = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, subjectName);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public static void main(String[] args) {
        SubjectDAO s = new SubjectDAO();
        boolean check = s.isSubjectNameExists("PRJ301");
        System.out.println(check);
    }
}
