<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.birdcomics.model.*, java.util.*, javax.servlet.ServletOutputStream, java.io.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Order Details</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <script
            src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script
            src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="css/changes.css">
</head>
<body>

<%
/* Checking the user credentials */
String userName = (String) session.getAttribute("username");
String password = (String) session.getAttribute("password");

if (userName == null || password == null) {
    response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
}

OrderServiceDAO dao = new OrderServiceDAO();
List<OrderDetailsBean> orders = dao.getAllOrderDetails(userName);
%>

<jsp:include page="/fragments/header.jsp" />

<br><br>
<div class="text-center"
     style="color: green; font-size: 24px; font-weight: bold;">Order
    Details
</div>
<!-- Start of Product Items List -->
<br><br>
<div class="container">
    <div class="table-responsive ">
        <table class="table table-hover table-sm">
            <thead
                    style="background-color: black; color: white; font-size: 14px; font-weight: bold;">
            <tr>
                <th>Picture</th>
                <th>ProductName</th>
                <th>OrderId</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Time</th>
                <th>Status</th>
            </tr>
            </thead>
            <tbody style="background-color: white; font-size: 15px; font-weight: bold;">
            <% 
            for (OrderDetailsBean order : orders) {
                out.println("<tr>");
                out.println("<td><img src=\"./ShowImage?pid=" + order.getProductId() + "\" style=\"width: 50px; height: 50px;\"></td>");
                out.println("<td>" + order.getProdName() + "</td>");
                out.println("<td>" + order.getOrderId() + "</td>");
                out.println("<td>" + order.getQty() + "</td>");
                out.println("<td>" + order.getAmount() + "</td>");
                out.println("<td>" + order.getTime() + "</td>");
                out.println("<td class=\"text-success\">" + (order.getShipped() == 0 ? "ORDER_PLACED" : "ORDER_SHIPPED") + "</td>");
                out.println("</tr>");
            }
            %>
            </tbody>
        </table>
    </div>
</div>
<!-- End of Product Items List -->

<br><br>
<%@ include file="/fragments/footer.html"%>

</body>
</html>
