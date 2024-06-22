<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List, com.birdcomics.model.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Shipping Orders</title>
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
    List<OrderBean> orders = (List<OrderBean>) request.getAttribute("orders");
    List<String> ArrayUserId = (List<String>) request.getAttribute("ArrayUserId");
    List<String> ArrayUserAddr = (List<String>) request.getAttribute("ArrayUserAddr");
    %>

   <jsp:include page="/fragments/header.jsp" />
   
   <div class="search-bar">
    <form class="search-form" action="ShipmentServlet" method="get">
        <input type="text" name="search" placeholder="Cerca utente per email">
        <input type="submit" value="Submit">
    </form>   
</div>

    <div class="container-fluid">
        <div class="text-center"
            style="color: green; font-size: 24px; font-weight: bold; margin-top: 15px; margin-bottom: 15px;">
            Orders</div>
        <div class="table-responsive">
            <table class="table table-hover table-sm">
                <thead style="background-color: #700fb7; color: white; font-size: 16px;">
                    <tr>
                        <th>TransactionId</th>
                        <th>ProductId</th>
                        <th>User Email Id</th>
                        <th>Address</th>
                        <th>Quantity</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody style="background-color: white;">

                    <% 
                    
       				int index = 0;
                    for (OrderBean order : orders) {
                        String transId = order.getTransactionId();
                        String prodId = order.getProductId();
                        int quantity = order.getQuantity();
                        int shipped = order.getShipped();
                        String userId = ArrayUserId.get(index);
                        String userAddr = ArrayUserAddr.get(index);
                        index++;
                        if (shipped == 0) {
                    %>

                    <tr>
                        <td><%=transId%></td>
                        <td><%=prodId%></td>
                        <td><%=userId%></td>
                        <td><%=userAddr%></td>
                        <td><%=quantity%></td>
                        <td>READY_TO_SHIP</td>
                        <td><a href="ShipmentServlet?orderid=<%=order.getTransactionId()%>&userid=<%=userId%>&prodid=<%=order.getProductId()%>"
                            class="btn btn-success">SHIP NOW</a></td>
                    </tr>

                    <% 
                        } else {
                    %>

                    <tr>
                        <td><%=transId%></td>
                        <td><%=prodId%></td>
                        <td><%=userId%></td>
                        <td><%=userAddr%></td>
                        <td><%=quantity%></td>
                        <td>SHIPPED</td>
                        <td></td><!-- Empty action cell for shipped items -->
                    </tr>

                    <% 
                        }
                    } 
                    %>

                </tbody>
            </table>
        </div>
    </div>

    <%@ include file="/fragments/footer.html"%>
</body>
</html>
