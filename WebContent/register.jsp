<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/changes.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
</head>
<body>

<%@ include file="./fragments/header.jsp" %>

<div class="container" style="margin-top: 35px; margin-bottom: 40px;">
    <div class="row" style="margin-top: 5px; margin-left: 2px; margin-right: 2px;">

        <form action="./RegisterSrv" method="post" class="col-md-6 col-md-offset-3">
            <div style="font-weight: bold;" class="text-center">
                <h2>Registration Form</h2>
                <c:if test="${not empty param.message}">
                    <p style="color: blue;">${param.message}</p>
                </c:if>
            </div>
            <div class="row">
                <div class="col-md-6 form-group">
                    <label for="first_name">Username</label>
                    <input type="text" name="username" class="form-control" id="first_name" required>
                </div>
                <div class="col-md-6 form-group">
                    <label for="last_name">Email</label>
                    <input type="email" name="email" class="form-control" id="last_name" required>
                </div>
            </div>
            <div class="form-group">
                <label for="address">Address</label>
                <textarea name="address" class="form-control" id="address" required></textarea>
            </div>
            <div class="row">
                <div class="col-md-6 form-group">
                    <label for="mobile">Mobile</label>
                    <input type="number" name="mobile" class="form-control" id="mobile" required>
                </div>
                <div class="col-md-6 form-group">
                    <label for="pincode">Pin Code</label>
                    <input type="number" name="pincode" class="form-control" id="pincode" required>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 form-group">
                    <label for="password">Password</label>
                    <input type="password" name="password" class="form-control" id="password" required>
                </div>
                <div class="col-md-6 form-group">
                    <label for="confirmPassword">Confirm Password</label>
                    <input type="password" name="confirmPassword" class="form-control" id="confirmPassword" required>
                </div>
            </div>
            <div class="row text-center">
                <div class="col-md-6" style="margin-bottom: 2px;">
                    <button type="reset" class="btn btn-danger">Reset</button>
                </div>
                <div class="col-md-6">
                    <button type="submit" class="btn btn-success">Register</button>
                </div>
            </div>
        </form>
    </div>
</div>

<%@ include file="./fragments/footer.html" %>

</body>
</html>
