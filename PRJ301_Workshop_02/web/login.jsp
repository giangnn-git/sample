<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.UserDTO" %>
<%@page import="utils.AuthUtils" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <!--<link rel="stylesheet" href="assests/css/login.css">-->
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f2f4f7;
                display: flex;
                align-items: center;
                justify-content: center;
                height: 100vh;
                margin: 0;
            }

            .login-container {
                background: white;
                padding: 30px 40px;
                border-radius: 12px;
                box-shadow: 0 0 15px rgba(0,0,0,0.1);
                width: 100%;
                max-width: 400px;
            }

            .login-title {
                text-align: center;
                margin-bottom: 20px;
                color: #333;
            }

            .login-form .form-group {
                margin-bottom: 15px;
            }

            .login-form label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
                color: #555;
            }

            .form-input {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 14px;
            }

            .btn-submit {
                width: 100%;
                background-color: #007bff;
                color: white;
                padding: 10px;
                border: none;
                border-radius: 6px;
                font-weight: bold;
                cursor: pointer;
            }

            .btn-submit:hover {
                background-color: #0056b3;
            }

            .message-error {
                margin-top: 15px;
                color: red;
                text-align: center;
                font-weight: bold;
            }

        </style>
    </head>
    <body>
        <%
            if (AuthUtils.isLoggedIn(request)) {
                response.sendRedirect("welcome.jsp");
            } else {
                Object objMS = request.getAttribute("message");
                String msg = (objMS == null) ? "" : (objMS + "");
        %>
        <div class="login-container">
            <h2 class="login-title">Login</h2>
            <form action="MainController" method="post" class="login-form">
                <input type="hidden" name="action" value="login"/>

                <div class="form-group">
                    <label for="username">User Name:</label>
                    <input type="text" name="strUserName" id="username" class="form-input"/>
                </div>

                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" name="strPassword" id="password" class="form-input"/>
                </div>

                <div class="form-actions">
                    <input type="submit" value="Login" class="btn-submit"/>
                </div>
            </form>

            <div class="message-error"><%= msg %></div>
        </div>
        <% } %>
    </body>
</html>
