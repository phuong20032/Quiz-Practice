package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.*;

public class NewSubjectDAO extends DBContext {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    // Select a subject by its ID
    public Subject selectSubject(int subject_id) {
        String sql = "SELECT [subject_id], [subject_name], [creator_id], [created_at], [updated_at], [status], [subject_img] "
                + "FROM [dbo].[subject] WHERE [subject_id] = ?";
        try (Connection conn = connection; PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, subject_id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Subject subject = new Subject();
                    subject.setSubject_id(rs.getInt("subject_id"));
                    subject.setSubject_name(rs.getString("subject_name"));
                    subject.setCreator_id(rs.getInt("creator_id"));
                    subject.setCreated_at(rs.getDate("created_at"));
                    subject.setUpdated_at(rs.getDate("updated_at"));
                    subject.setStatus(rs.getInt("status"));
                    subject.setSubject_img(rs.getString("subject_img"));
                    return subject;
                }
            }
        } catch (SQLException e) {
            System.out.println("SQL Exception: " + e.getMessage());
        }
        return null;
    }

    public List<QSubjectList> getAllSubject() {
        List<QSubjectList> list = new ArrayList<>();
        String query = """
                       SELECT s.[subject_id],  s.[subject_name],  s.[creator_id],  
                       s.[created_at],  s.[updated_at], s.[status],  
                       s.[subject_img],s.major_id,s.subject_content,
                       s.subject_title, m.[major_name]
                        FROM [dbo].[subject] as s
                        join [dbo].[major] as m on s.major_id = m.major_id where s.status =1""";
        try {
            conn = connection;
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new QSubjectList(rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getDate(4),
                        rs.getDate(5),
                        rs.getInt(6),
                        rs.getString(7),
                        rs.getInt(8),
                        rs.getString(9),
                        rs.getString(10),
                        rs.getString(11)));
            }
        } catch (SQLException e) {
        }
        return list;
    }

    public List<QSubjectList> getNewsSubject() {
        List<QSubjectList> list = new ArrayList<>();
        String query = """
                       SELECT s.[subject_id],  s.[subject_name],
                       s.[creator_id],  s.[created_at],  s.[updated_at],
                       s.[status],  s.[subject_img],s.major_id,s.subject_content,
                       s.subject_title, m.[major_name]
                        FROM [dbo].[subject] as s
                        join [dbo].[major] as m on s.major_id = m.major_id where s.status =1
                        ORDER BY created_at DESC""";
        try {
            conn = connection;
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new QSubjectList(rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getDate(4),
                        rs.getDate(5),
                        rs.getInt(6),
                        rs.getString(7),
                        rs.getInt(8),
                        rs.getString(9),
                        rs.getString(10),
                        rs.getString(11)));
            }
        } catch (SQLException e) {
        }
        return list;
    }

    public List<User> getAllTeacher() {
        List<User> list = new ArrayList<>();
        String query = """
                       SELECT u.[user_id], u.[userName], u.[email], 
                       u.[password], u.[phone], u.[gender], 
                       u.[fullName], u.[school], u.[facebook], 
                       u.[twitter], u.[instagram], u.[description],
                       u.[created_at], u.[role_id]
                       FROM [dbo].[user] AS u
                       JOIN [dbo].[role] AS r ON u.role_id = r.role_id
                       WHERE r.role_name = 'Expert'""";
        try {
            conn = connection;
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUser_id(rs.getInt("user_id"));
                user.setUserName(rs.getString("userName"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setPhone(rs.getString("phone"));
                user.setGender(rs.getInt("gender"));
                user.setFullName(rs.getString("fullName"));
                user.setSchool(rs.getString("school"));
                user.setFacebook(rs.getString("facebook"));
                user.setTwitter(rs.getString("twitter"));
                user.setInstagram(rs.getString("instagram"));
                user.setDescription(rs.getString("description"));
                user.setCreate_at(rs.getDate("created_at"));

                Role role = new Role();
                role.setRole_id(rs.getInt("role_id"));
                user.setRole(role);

                list.add(user);
            }
        } catch (SQLException e) {

        }
        return list;
    }

    public List<QSubjectList> searchSubjectByName(String txtSearch) {
        List<QSubjectList> list = new ArrayList<>();
        String query = """
                       SELECT 
                           s.[subject_id],  
                           s.[subject_name],  
                           s.[creator_id],  
                           s.[created_at],  
                           s.[updated_at], 
                           s.[status],  
                           s.[subject_img],
                           s.[major_id],
                           s.[subject_content],
                           s.[subject_title],
                           m.[major_name]
                       FROM 
                           [dbo].[subject] AS s
                       JOIN 
                           [dbo].[major] AS m ON s.major_id = m.major_id
                       WHERE 
                           s.[subject_name] LIKE ? and  s.status =1""";
        try {
            conn = connection;
            ps = conn.prepareStatement(query);
            ps.setString(1, "%" + txtSearch + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new QSubjectList(rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getDate(4),
                        rs.getDate(5),
                        rs.getInt(6),
                        rs.getString(7),
                        rs.getInt(8),
                        rs.getString(9),
                        rs.getString(10),
                        rs.getString(11)));
            }
        } catch (SQLException e) {
            // Handle the exception appropriately

        }
        return list;
    }

    public QSubjectDetail getSubjectById(String id) {

        String query = """
                       SELECT 
                           s.subject_id, 
                           u.userName, 
                           u.email, 
                           u.phone, 
                           u.gender, 
                           u.fullName, 
                           u.facebook, 
                           u.twitter, 
                           u.instagram, 
                           u.[description], 
                           s.subject_name, 
                           s.subject_img, 
                           s.subject_content, 
                           s.subject_title
                       FROM 
                           [dbo].[user] u
                       JOIN 
                           dbo.subject s ON u.user_id = s.creator_id
                       WHERE 
                           s.subject_id = ?;""";
        try {
            conn = connection;
            ps = conn.prepareStatement(query);
            ps.setString(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {

                return new QSubjectDetail(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getInt(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getString(10),
                        rs.getString(11),
                        rs.getString(12),
                        rs.getString(13),
                        rs.getString(14));
            }
        } catch (SQLException e) {
        }
        return null;
    }
}
