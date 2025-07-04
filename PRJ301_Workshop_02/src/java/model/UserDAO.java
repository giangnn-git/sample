/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import utils.DbUtils;

/**
 *
 * @author Admin
 */
public class UserDAO {
    
    public boolean login(String userName, String password) {
        UserDTO user = getUserByUserName(userName);
        if(user!=null){
            if(user.getPassword().equals(password)){
                    return true;
            }
        }
        return false;
    }
    
     public UserDTO getUserByUserName(String uName) {
        UserDTO user = null;
        try {
            String sql = "SELECT * FROM tblUsers WHERE username=?";

            Connection conn = DbUtils.getConnection();

            PreparedStatement pr = conn.prepareStatement(sql);
            pr.setString(1, uName);

            ResultSet rs = pr.executeQuery();

            while (rs.next()) {
                String userName = rs.getString("username");
                String name = rs.getString("name");
                String password = rs.getString("password");
                String role = rs.getString("role");

                user = new UserDTO(userName, name, password, role);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return user;
    }
    
    public List<UserDTO> getAllUsers() {
        List<UserDTO> userList = new ArrayList<>();
        String sql = "SELECT username, name, password, role FROM tblUsers ORDER BY Username";
        try {
            Connection conn = DbUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                UserDTO user = new UserDTO();
                user.setUserName(rs.getString("userName"));
                user.setName(rs.getString("name"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                userList.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userList;
    }

    public boolean updatePassword(String userName, String newPassword) {
        String sql = "UPDATE tblUsers SET password = ? WHERE username = ?";
        try {
            Connection conn = DbUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, newPassword);
            ps.setString(2, userName);
            int result = ps.executeUpdate();
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
}

