<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.UserDTO" %>
<%@page import="model.ExamCategoryDTO" %>
<%@page import="utils.AuthUtils" %>
<%@page import="java.util.List" %>
<%@page import="model.ExamDTO" %>
<!DOCTYPE html>
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Exam Form</title>
    <!--<link rel="stylesheet" href="assests/css/examForm.css">-->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
            padding: 40px;
        }

        .container {
            max-width: 600px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 12px rgba(0,0,0,0.1);
        }

        .header {
            margin-bottom: 20px;
        }

        .header a {
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
        }

        .header h1 {
            margin: 10px 0;
            font-size: 28px;
            color: #333;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
            color: #555;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 8px 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
        }

        .form-actions {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }

        .form-actions input {
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            background-color: #007bff;
            color: white;
            font-weight: bold;
            cursor: pointer;
        }

        .form-actions input[type="reset"] {
            background-color: #6c757d;
        }

        .message {
            margin-top: 15px;
            padding: 10px;
            border-radius: 6px;
            font-weight: bold;
        }

        .error {
            background-color: #f8d7da;
            color: #842029;
        }

        .success {
            background-color: #d1e7dd;
            color: #0f5132;
        }

        .access-denied {
            text-align: center;
            color: #dc3545;
        }
    </style>
</head>
<body>
    <div class="container">
        <% if (AuthUtils.isInstructor(request)) {
            String checkError = (String)request.getAttribute("checkError");
            String message = (String) request.getAttribute("message");
            String keyword = (String) request.getAttribute("keyword");
            ExamDTO exam = (ExamDTO) request.getAttribute("exam");
        %>

        <div class="header">
            <a href="welcome.jsp">← Back to Exams</a>
            <h1>Create Exam</h1>
        </div>

        <div class="form-content">
            <form action="MainController" method="post">
                <input type="hidden" name="action" value="addExam"/>

                <div class="form-group">
                    <label for="exam_title">Exam Title *</label>
                    <input type="text" id="exam_title" name="exam_title" required="required"
                           value="<%= exam!=null ? exam.getExam_title():""%>" />
                </div>

                <div class="form-group">
                    <label for="subject">Subject *</label>
                    <input type="text" id="subject" name="subject" required="required"
                           value="<%= exam!=null ? exam.getSubject():""%>" />
                </div>

                <div class="form-group">
                    <label for="category_id">Category Name:</label>
                    <select id="category_id" name="category_id">
                        <option value="1" <%= (exam != null && exam.getCategory_id() == 1) ? "selected" : "" %>>Quiz</option>
                        <option value="2" <%= (exam != null && exam.getCategory_id() == 2) ? "selected" : "" %>>Midterm</option>
                        <option value="3" <%= (exam != null && exam.getCategory_id() == 3) ? "selected" : "" %>>Final</option>
                        <option value="4" <%= (exam != null && exam.getCategory_id() == 4) ? "selected" : "" %>>Practicing</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="total_marks">Total Marks *</label>
                    <input type="number" id="total_marks" name="total_marks" required="required"
                            value="<%= exam!=null ? exam.getTotal_marks():""%>" />
                </div>

                <div class="form-group">
                    <label for="duration">Duration (minutes) *</label>
                    <input type="number" id="duration" name="duration" required="required"
                            value="<%= exam!=null ? exam.getDuration():""%>" />
                </div>

                <div class="form-actions">
                    <input type="submit" value="Add Exam" />
                    <input type="reset" value="Reset" />
                </div>
            </form>

            <% if(checkError != null && !checkError.isEmpty()) { %>
            <div class="message error"><%=checkError%></div>
            <% } else if(message != null && !message.isEmpty()) { %>
            <div class="message success"><%=message%></div>
            <% } %>
        </div>

        <% } else { %>
        <div class="access-denied">
            <h1>ACCESS DENIED</h1>
            <div><%=AuthUtils.getAccessDeniedMessage("Exam Form")%></div>
        </div>
        <% } %>
    </div>
</body>
</html>
