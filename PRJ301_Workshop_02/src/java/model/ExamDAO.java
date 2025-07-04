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
public class ExamDAO {

    private static final String GET_DETAIL_EXAM_BY_CATEGORY_ID = "SELECT exam_id, exam_title, subject, total_marks, duration, category_id FROM tblExams WHERE category_id = ?";
    private static final String ADD_EXAM = "INSERT INTO tblExams (exam_title, subject, category_id, total_marks, duration) VALUES (?, ?, ?, ?, ?)";
    private static final String GET_CTNAME_BY_ID = "SELECT category_name FROM tblExamCategories WHERE category_id = ?";
    
    public List<ExamDTO> filterByCategoryId(String categoryId) {
        List<ExamDTO> elist = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(GET_DETAIL_EXAM_BY_CATEGORY_ID);
            ps.setString(1, categoryId);
            rs = ps.executeQuery();

            while (rs.next()) {
                ExamDTO e = new ExamDTO();
                e.setExam_id(rs.getInt("exam_id"));
                e.setExam_title(rs.getString("exam_title"));
                e.setSubject(rs.getString("subject"));
                e.setTotal_marks(rs.getInt("total_marks"));
                e.setDuration(rs.getInt("duration"));
                e.setCategory_id(rs.getInt("category_id"));
                elist.add(e);
            }
        } catch (Exception e) {
            System.err.println("Error in filterByCategoryId(): " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }

        return elist;
    }

    public String getCategoryNameById(String categoryId) {
        String categoryName = null;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(GET_CTNAME_BY_ID);
            ps.setInt(1, Integer.parseInt(categoryId));
            rs = ps.executeQuery();

            if (rs.next()) {
                categoryName = rs.getString("category_name");
            }
        } catch (Exception e) {
            System.err.println("Error in getCategoryNameById(): " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }

        return categoryName;
    }

    public boolean create(ExamDTO exam) {
        boolean success = false;
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(ADD_EXAM);

            ps.setString(1, exam.getExam_title());
            ps.setString(2, exam.getSubject());
            ps.setInt(3, exam.getCategory_id());
            ps.setInt(4, exam.getTotal_marks());
            ps.setInt(5, exam.getDuration());

            int rowsAffected = ps.executeUpdate();
            success = (rowsAffected > 0);
        } catch (Exception e) {
            System.err.println("Error in create(ExamDTO): " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, null);
        }

        return success;
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
