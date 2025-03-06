/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.AccountDTO;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Role;
import model.User;

/**
 *
 * @author PC
 */
public class UserDAO extends DBContext {

    public User getAllInfoByEmail(String email) {
        String sql = "SELECT [user_id]\n"
                + "      ,[userName]\n"
                + "      ,[email]\n"
                + "      ,[password]\n"
                + "      ,[phone]\n"
                + "      ,[gender]\n"
                + "      ,[fullName]\n"
                + "      ,[school]\n"
                + "      ,[description]\n"
                + "      ,[created_at]\n"
                + "      ,[role_id]\n"
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
                user.setDescription(rs.getString(9));
                user.setCreate_at(rs.getDate(10));
                Role role = new Role();
                role.setRole_id(rs.getInt(11));
                user.setRole(role);
                return user;
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public User getAllInfoByID(int id) {
        String sql = "SELECT * from [user] where user_id = ?  ";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
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
                user.setDescription(rs.getString(9));
                user.setCreate_at(rs.getDate(10));

                Role role = new Role();
                role.setRole_id(rs.getInt(11));
                user.setRole(role);
                user.setStatus(rs.getInt("status"));
                return user;
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<User> getAllUserByROle(int role) {
        List<User> list = new ArrayList<>();
        String sql = """
                     SELECT *    FROM [SWP391_G4].[dbo].[user] where role_id = ? """;

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, role);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUser_id(rs.getInt(1));
                user.setUserName(rs.getString(2));
                user.setEmail(rs.getString(3));
                user.setPassword(rs.getString(4));
                user.setPhone(rs.getString(5));
                user.setGender(rs.getInt(6));
                user.setFullName(rs.getString(7));
                user.setSchool(rs.getString(8));
                user.setDescription(rs.getString(9));
                user.setCreate_at(rs.getDate(10));

                Role roles = new Role();
                roles.setRole_id(rs.getInt(11));
                user.setRole(roles);
                list.add(user);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public void updateProfile(String email, String userName, String fulName, String phone, String school) {
        String sql = "UPDATE [dbo].[user]\n"
                + "   SET [userName] = ?\n,"
                + "    [phone] = ?\n,"
                + "    [fullName] = ?\n,"
                + "    [school] = ?\n,"
                + " WHERE email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, userName);
            ps.setString(2, phone);
            ps.setString(3, fulName);
            ps.setString(4, school);
            ps.setString(5, email);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void addUser(
            String username,
            String email,
            String password,
            String phone,
            int gender,
            String fullName,
            int role_id,
            int status
    ) {
        String sql = """
                     INSERT INTO [dbo].[user]
                                 ([userName]
                                 ,[email]
                                 ,[password]
                                 ,[phone]
                                 ,[gender]
                                 ,[fullName]
                                 ,[created_at]
                                 ,[role_id]
                                 ,[status])
                           VALUES
                                 (?,?,?,?,?,?,getDate(),?,?)""";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, phone);
            ps.setInt(5, gender);
            ps.setString(6, fullName);
            ps.setInt(7, role_id);
            ps.setInt(8, status);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public User getById(int userId) {
        String sql = "SELECT [user_id], [userName], [email], [password], [phone], [gender], "
                + "[fullName], [school], [description], "
                + "[created_at], [role_id] "
                + "FROM [SWP391_G4].[dbo].[user] "
                + "WHERE [user_id] = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
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
                user.setDescription(rs.getString(9));
                user.setCreate_at(rs.getDate(10));

                Role role = new Role();
                role.setRole_id(rs.getInt(11));
                user.setRole(role);

                return user;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public Role getRoleById(int role_id) {
        String sql = "Select * from role where role_id = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, role_id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Role role = new Role();
                role.setRole_id(rs.getInt("role_id"));
                role.setRole_name(rs.getString("role_name"));
                return role;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<Role> getAllRoles() {
        String sql = "Select * from role";
        List<Role> roles = new ArrayList<>();
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Role role = new Role();
                role.setRole_id(rs.getInt("role_id"));
                role.setRole_name(rs.getString("role_name"));
                roles.add(role);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return roles;
    }

    public List<User> getAllUserWithParams(int userId, String searchParam, Integer role_id, Integer status, String gender) {
        List<User> users = new ArrayList<>();
        List<Object> list = new ArrayList<>();

        try {
            StringBuilder query = new StringBuilder();
            query.append("""
                         select * from [user] where user_id != ? """);
            list.add(userId);
            if (searchParam != null && !searchParam.trim().isEmpty()) {
                query.append(" AND  ( email LIKE ? or username like ? or fullname like ?  or phone like ?)");
                list.add("%" + searchParam + "%");
                list.add("%" + searchParam + "%");
                list.add("%" + searchParam + "%");
                list.add("%" + searchParam + "%");
            }
            if (role_id != null) {
                query.append(" AND  role_id = ? ");
                list.add(role_id);
            }
            if (status != null) {
                query.append(" AND  status = ? ");
                list.add(status);
            }
            if (gender != null && !gender.trim().isBlank()) {
                query.append(" AND  gender = ? ");
                list.add(gender);
            }
            query.append(" ORDER BY  user_id  DESC");
            PreparedStatement preparedStatement;
            preparedStatement = connection.prepareStatement(query.toString());
            mapParams(preparedStatement, list);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    User user = new User();
                    user.setUser_id(rs.getInt("user_id"));
                    user.setUserName(rs.getString("userName"));
                    user.setEmail(rs.getString("email"));
                    user.setPhone(rs.getString("phone"));
                    user.setGender(rs.getInt("gender"));
                    user.setFullName(rs.getString("fullName"));
                    user.setSchool(rs.getString("school"));
                    user.setDescription(rs.getString("description"));
                    user.setCreate_at(rs.getDate("created_at"));
                    user.setStatus(rs.getInt("status"));
                    Role role = getRoleById(rs.getInt("role_id"));
                    user.setRole(role);
                    users.add(user);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }

    public void changeStatus(int status, int userId) {
        String sql = """
                     UPDATE [dbo].[user]
                        SET [status] = ?
                        WHERE user_id = ?""";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, status);
            ps.setInt(2, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void updateRoleAndStatus(int userId, int roleId, int status) {
        String sql = "UPDATE [dbo].[user] SET [role_id] = ?, [status] = ? WHERE user_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, roleId);
            ps.setInt(2, status);
            ps.setInt(3, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
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

    public List<User> Paging(List<User> users, int page, int pageSize) {
        int fromIndex = (page - 1) * pageSize;
        int toIndex = Math.min(fromIndex + pageSize, users.size());

        if (fromIndex > toIndex) {
            // Handle the case where fromIndex is greater than toIndex
            fromIndex = toIndex;
        }

        return users.subList(fromIndex, toIndex);
    }

    public void insertAccount(AccountDTO rg) {

        //Insert userName, email, password, created Date to database.
        // Object User is information of User to save data when get in servlet.
        String sql = "INSERT INTO [dbo].[user]\n"
                + "           ([userName]\n"
                + "           ,[email]\n"
                + "           ,[password]\n"
                + "           ,[created_at])\n"
                + "     VALUES\n"
                + "           (?,?,?,GETDATE())";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, rg.getUserName());
            ps.setString(2, rg.getEmail());
            ps.setString(3, rg.getPassword());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public boolean insertAccount(User u) {

        //Insert userName, email, password, created Date to database.
        // Object User is information of User to save data when get in servlet.
        String sql = "INSERT INTO [dbo].[user]\n"
                + "           ([phone]\n"
                + "           ,[email]\n"
                + "           ,[username]\n"
                + "           ,[gender]\n"
                + "           ,[fullName]\n"
                + "           ,[password]\n"
                + "           ,[created_at])\n"
                + "     VALUES\n"
                + "           (?,?,?,?,?,?,GETDATE())";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, u.getPhone());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getUserName());
            ps.setInt(4, u.getGender());
            ps.setString(5, u.getFullName());
            ps.setString(6, u.getPassword());
            int s = ps.executeUpdate();
            if (s > 0) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    //Check userId and email if user reuse the userID or email.
    public boolean checkExistedRegister(AccountDTO rd) {
        String sql = "SELECT email \n"
                + "  FROM [SWP391_G4].[dbo].[user]\n"
                + "  where email = ? or userName = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, rd.getEmail());
            ps.setString(2, rd.getUserName());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public boolean checkExistedEmail(String email) {
        String sql = "SELECT email \n"
                + "  FROM [SWP391_G4].[dbo].[user]\n"
                + "  where email = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public int getLastId() {
        int lastId = -1; // Default value if no user exists
        String sql = "SELECT MAX(user_id) AS last_id FROM [dbo].[user]";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                lastId = rs.getInt("last_id");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return lastId;
    }
}
