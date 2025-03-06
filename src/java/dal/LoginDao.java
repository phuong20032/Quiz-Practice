/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Role;
import model.User;

/**
 *
 * @author ADMIN
 */
public class LoginDao extends DBContext {

    //Check login if user login account doesn't exist:
    public User checkLogin(String email, String password) {
        String sql = "SELECT [email]\n" //1
                + "      ,[password]\n" //2
                + "  FROM [dbo].[User]\n"
                + "  where email = ? "
                + "and password = ? ";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setEmail(rs.getString(1));
                user.setPassword(rs.getString(2));
                return user;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public User getAllInfoByEmail(String email) {
        String sql = "SELECT [user_id]\n"
                + "      ,[userName]\n"
                + "      ,[email]\n"
                + "      ,[password]\n"
                + "      ,[phone]\n"
                + "      ,[gender]\n"
                + "      ,[fullName]\n"
                + "      ,[school]\n"
                + "      ,[facebook]\n"
                + "      ,[twitter]\n"
                + "      ,[instagram]\n"
                + "      ,[description]\n"
                + "      ,[created_at]\n"
                + "      ,[role_id]\n"
                + "      ,[status]\n"
                + "  FROM [SWP391_G4].[dbo].[user]"
                + "where email = ? ";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUser_id(rs.getInt(1));
                user.setUserName(rs.getString(2));
                user.setEmail(rs.getString(3));
                user.setPassword(rs.getString(4));
                user.setPhone(rs.getString(5));
                user.setGender(rs.getInt(6));
                user.setFullName(rs.getString(7));
                user.setSchool(rs.getString(8));
                user.setFacebook(rs.getString(9));
                user.setTwitter(rs.getString(10));
                user.setInstagram(rs.getString(11));
                user.setDescription(rs.getString(12));
                user.setCreate_at(rs.getDate(13));
                
                Role role = new Role();
                role.setRole_id(rs.getInt(14));
                user.setRole(role);
                user.setStatus(rs.getInt(15));
                return user;
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    
    public static void main(String[] args) {
        LoginDao ld = new LoginDao() ;
        User user = ld.getAllInfoByEmail("tientvhe181590@fpt.edu.vn") ;
        System.out.println(user.getEmail());
    }
}
