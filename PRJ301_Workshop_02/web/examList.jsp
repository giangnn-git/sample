<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.UserDTO" %>
<%@page import="utils.AuthUtils" %>
<%@page import="java.util.List" %>
<%@page import="model.ExamDTO" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Exam List</title>
        <!--<link rel="stylesheet" href="assests/css/examList.css">-->
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f7f9fc;
                padding: 40px;
            }

            .container {
                max-width: 900px;
                margin: auto;
                background: white;
                padding: 30px 40px;
                border-radius: 12px;
                box-shadow: 0 0 15px rgba(0,0,0,0.1);
            }

            .back-link {
                text-decoration: none;
                color: #007bff;
                font-weight: bold;
            }

            h2 {
                margin-top: 20px;
                color: #333;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            th, td {
                padding: 12px 15px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            th {
                background-color: #f0f0f0;
                font-weight: bold;
            }

            tr:hover {
                background-color: #f9f9f9;
            }

            .no-data {
                margin-top: 20px;
                color: #888;
            }

            .access-denied {
                text-align: center;
                color: #dc3545;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <%
            if (AuthUtils.isLoggedIn(request)) {
                List<ExamDTO> examList = (List<ExamDTO>) request.getAttribute("examList");
                String categoryName = (String) request.getAttribute("categoryName");
                UserDTO user = AuthUtils.getCurrentUser(request);
        %>
        <div class="container">
            <a href="welcome.jsp" class="back-link">← Back to Exam Category</a>
            <h2>Exams in Category: <%= categoryName %></h2>

            <% if (examList == null || examList.isEmpty()) { %>
            <p class="no-data">No exams found for this category.</p>
            <% } else { %>
            <table class="exam-table">
                <thead>
                    <tr>
                        <th>Exam Title</th>
                        <th>Subject</th>
                        <th>Total Marks</th>
                        <th>Duration (min)</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (ExamDTO e : examList) { %>
                    <tr>
                        <td><%= e.getExam_title() %></td>
                        <td><%= e.getSubject() %></td>
                        <td><%= e.getTotal_marks() %></td>
                        <td><%= e.getDuration() %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <% } %>
        </div>
        <% } else { %>
        <div class="container access-denied">
            <%= AuthUtils.getAccessDeniedMessage("welcome.jsp") %> <br/>
            (Or <a href="<%= AuthUtils.getLoginURL() %>">Login</a>)
        </div>
        <% } %>
    </body>
</html>
