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
public class ExamCategoryDAO {
    
    private static final String GET_ALL_EXAM_CATEGORIES = "SELECT category_id, category_name, description FROM tblExamCategories";
    
    public List<ExamCategoryDTO> getAll() {
        List<ExamCategoryDTO> examCategories = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(GET_ALL_EXAM_CATEGORIES);
            rs = ps.executeQuery();

            while (rs.next()) {
                ExamCategoryDTO exCate = new ExamCategoryDTO();
                exCate.setCategory_id(rs.getInt("category_id"));
                exCate.setCategory_name(rs.getString("category_name"));
                exCate.setDescription(rs.getString("description"));
                
                examCategories.add(exCate);
            }
        } catch (Exception e) {
            System.err.println("Error in getAll(): " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }

        return examCategories;
    }
    
   
    private void closeResources(Connection conn, PreparedStatement ps, ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (Exception e) {
            System.err.println("Error closing resources: " + e.getMessage());
            e.printStackTrace();
        }
    }

   
    
}
