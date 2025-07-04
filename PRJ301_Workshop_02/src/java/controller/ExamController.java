/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.ExamCategoryDAO;
import model.ExamCategoryDTO;
import model.ExamDAO;
import model.ExamDTO;
import utils.AuthUtils;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ExamController", urlPatterns = {"/ExamController"})
public class ExamController extends HttpServlet {

    ExamCategoryDAO ecdao = new ExamCategoryDAO();
    ExamDAO edao = new ExamDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = "";
        try {
            String action = request.getParameter("action");
            if (action.equals("addExam")) {
                url = handleExamsAdding(request, response);
            } else if (action.equals("showAll")) {
                url = handleDisplayAllExams(request, response);
            } else if (action.equals("filter")) {
                url = handleFilterExams(request, response);
            }

        } catch (Exception e) {
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private String handleExamsAdding(HttpServletRequest request, HttpServletResponse response) {
        if (AuthUtils.isInstructor(request)) {
            String checkError = "";
            String message = "";

            String title = request.getParameter("exam_title");
            String subject = request.getParameter("subject");
            String strCategoryId = request.getParameter("category_id");
            String totalMarksStr = request.getParameter("total_marks");
            String durationStr = request.getParameter("duration");
//categyry_id
            int categoryId = 0;
            try {
                categoryId = Integer.parseInt(strCategoryId);
            } catch (Exception e) {
                checkError += "Error in category ID.<br/>";
            }

//Mark
            int totalMarks = 0;
            try {
                totalMarks = Integer.parseInt(totalMarksStr);
                if (totalMarks <= 0) {
                    checkError += "Total Marks must be greater than zero.<br/>";
                }
            } catch (Exception e) {
                checkError += "Invalid total marks.<br/>";
            }

//duration           
            int duration = 0;
            try {
                duration = Integer.parseInt(durationStr);
                if (duration <= 0) {
                    checkError += "Duration must be greater than zero.<br/>";
                }
            } catch (Exception e) {
                checkError += "Invalid duration.<br/>";
            }
//title
            if (title == null || title.isEmpty()) {
                checkError += "Exam Title is required.<br/>";
            } else if (title.length()>100){
                checkError += "Exam Title can not exceed 100 characters.";
            }
//subject
            if (subject == null || subject.isEmpty()) {
                checkError += "Subject is required.<br/>";
            } else if(subject.length()>50){
                checkError += "Subject can not exceed 50 characters.";
            }

            ExamDTO exam = new ExamDTO(0, title, subject, categoryId, totalMarks, duration);
           
            if (checkError.isEmpty()) {
                if (edao.create(exam)) {
                    message += "Exam created successfully.";
                    request.setAttribute("exam", exam);
                }
            } else {
                System.out.println("ko dc");
                checkError += "Failed to create exam.";
            }

            
            request.setAttribute("checkError", checkError);
            request.setAttribute("message", message);
        }
        return "examForm.jsp";
    }

    private String handleDisplayAllExams(HttpServletRequest request, HttpServletResponse response) {
        List<ExamCategoryDTO> list = ecdao.getAll();
        request.setAttribute("list", list);
        return "welcome.jsp";
    }

    private String handleFilterExams(HttpServletRequest request, HttpServletResponse response) {
        String categoryId = request.getParameter("category_id");
        List<ExamDTO> examList = edao.filterByCategoryId(categoryId);
        String categoryName = edao.getCategoryNameById(categoryId);
        request.setAttribute("categoryName", categoryName);
        request.setAttribute("examList", examList);

        return "examList.jsp";
    }

}
