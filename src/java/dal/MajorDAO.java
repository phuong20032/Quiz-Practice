/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Major;

/**
 *
 * @author ADMIN
 */
public class MajorDAO extends DBContext{
    public List<Major> getAll() {
        List<Major> list = new ArrayList<>();
        String sql = "Select * from major";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Major p = new Major(rs.getInt("major_id"),rs.getString("major_name"));
               
                list.add(p);
            }
        } catch (SQLException ex) {
            Logger.getLogger(MajorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
}
