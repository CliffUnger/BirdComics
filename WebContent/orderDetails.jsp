<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.birdcomics.model.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Order Details</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="css/changes.css">
</head>
<body>

    <%@ include file="/fragments/header.jsp" %>

    <br><br>
    <div class="text-center" style="color: green; font-size: 24px; font-weight: bold;">Order Details</div>
    <br><br>
    <div class="container">
        <div id="orderTableDiv" class="table-responsive">
            <!-- Dynamic content will be loaded here -->
        </div>
    </div>

    <br><br>
    <%@ include file="/fragments/footer.html" %>

    <script>
        $(document).ready(function() {
            // Function to update order details dynamically
            function updateOrderDetails() {
                $.ajax({
                    url: "OrderDataServlet", // Replace with your servlet URL
                    method: "GET",
                    success: function(data) {
                        $("#orderTableDiv").html(data); // Update div with received data
                    },
                    error: function() {
                        alert("Error fetching order data.");
                    }
                });
            }

            // Call updateOrderDetails function on page load
            updateOrderDetails();
        });
    </script>

</body>
</html>
