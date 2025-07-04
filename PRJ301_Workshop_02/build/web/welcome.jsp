<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.UserDTO" %>
<%@page import="utils.AuthUtils" %>
<%@page import="java.util.List" %>
<%@page import="model.ExamCategoryDTO" %>
<!DOCTYPE html>
<html>
<head>
    
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Welcome</title>
    <!--<link rel="stylesheet" href="assests/css/welcome.css">-->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f2f5;
            padding: 40px;
        }

        .container {
            max-width: 800px;
            margin: auto;
            background-color: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        .header {
            margin-bottom: 20px;
        }

        .header h1 {
            margin: 0;
            font-size: 28px;
            color: #333;
        }

        .logout-link {
            float: right;
            color: #dc3545;
            text-decoration: none;
            font-weight: bold;
        }

        .action-links {
            margin: 20px 0;
        }

        .action-links a {
            display: inline-block;
            margin-right: 15px;
            color: #007bff;
            text-decoration: none;
            font-weight: bold;
        }

        .filter-form {
            margin-bottom: 30px;
        }

        .filter-form label {
            font-weight: bold;
            margin-right: 10px;
        }

        .filter-form select,
        .filter-form input[type="submit"] {
            padding: 8px 10px;
            font-size: 14px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        table th, table td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }

        table th {
            background-color: #f8f9fa;
        }

        .no-data {
            color: #888;
            margin-top: 20px;
        }

        .access-denied {
            text-align: center;
            color: #dc3545;
            font-weight: bold;
        }

        a.login-link {
            color: #007bff;
            text-decoration: none;
            font-weight: bold;
        }
    </style>
</head>
<body>
<%
    if (AuthUtils.isLoggedIn(request)) {
        UserDTO user = AuthUtils.getCurrentUser(request);
        String keyword = (String) request.getAttribute("keyword");
%>
<div class="container">
    <div class="header">
        <h1>Welcome <%= user.getName() %>!</h1>
        <a href="MainController?action=logout" class="logout-link">Log Out</a>
    </div>

    <hr/>

    <div class="action-links">
        <% if (AuthUtils.isInstructor(request)) { %>
            <a href="examForm.jsp">➕ Create Exam</a>
        <% } %>
        <a href="MainController?action=showAll">📂 Show All Exam Categories</a>
    </div>

    <form action="MainController" method="post" class="filter-form">
        <input type="hidden" name="action" value="filter"/>
        <label for="category_id">Filter by Category:</label>
        <select id="category_id" name="category_id">
            <option value="1">Quiz</option>
            <option value="2">Midterm</option>
            <option value="3">Final</option>
            <option value="4">Practicing</option>
        </select>
        <input type="submit" value="Filter"/>
    </form>

    <%
        List<ExamCategoryDTO> list = (List<ExamCategoryDTO>) request.getAttribute("list");
        if (list != null && list.isEmpty()) {
    %>
        <h3 class="no-data">No Exams were found</h3>
    <%
        } else if (list != null && !list.isEmpty()) {
    %>
    <table>
        <thead>
            <tr>
                <th>Category Name</th>
                <th>Description</th>
            </tr>
        </thead>
        <tbody>
            <% for (ExamCategoryDTO ec : list) { %>
                <tr>
                    <td><%= ec.getCategory_name() %></td>
                    <td><%= ec.getDescription() %></td>
                </tr>
            <% } %>
        </tbody>
    </table>
    <% } %>
</div>
<% } else { %>
    <div class="container access-denied">
        <%= AuthUtils.getAccessDeniedMessage("welcome.jsp") %><br/>
        (Or <a href="<%= AuthUtils.getLoginURL() %>" class="login-link">Login</a>)
    </div>
<% } %>
</body>
</html>
