<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="com.birdcomics.model.ProductBean" %>
<!DOCTYPE html>
<html>
<head>
    <title>Birdcomics</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/changes.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
</head>
<body>

<jsp:include page="/fragments/header.jsp" />

<div class="text-center"
     style="color: black; font-size: 14px; font-weight: bold;"><%= request.getAttribute("message") %></div>
<div class="text-center" id="message"
     style="color: black; font-size: 14px; font-weight: bold;"></div>

<%
    List<ProductBean> products = (List<ProductBean>) request.getAttribute("products");

    if (products == null) {
        RequestDispatcher dispatcher = request.getRequestDispatcher("./ProductListServlet");
        dispatcher.forward(request, response);

        return;
    }
    

    if (products.isEmpty()) {
        return;
    }
%>

<!-- Start of Product Items List -->
<div class="container">
    <div class="row text-center">
        <%
            for (ProductBean product : products) {
        %>
            <div class="col-sm-4" style='height: 350px;'>
                <div class="thumbnail">
                    <a href="./SingleProductServlet?pid=<%= product.getProdId() %>">
            <img src="./ShowImage?pid=<%= product.getProdId() %>" alt="Product" style="height: 150px; max-width: 180px">
        </a>
                    <p class="productname"><%= product.getProdName() %></p>
                    <p class="productinfo">
                        <%-- Display first 100 characters of prodInfo followed by "..." if longer --%>
                        <%= (product.getProdInfo().length() > 100) ? product.getProdInfo().substring(0, 100) + "..." : product.getProdInfo() %>
                    </p>
                    <p class="price">Euro <%= product.getProdPrice() %></p>
                    <form method="post" action="AddToCart">
                        <input type="hidden" name="pid" value="<%= product.getProdId() %>">
                        <button type="submit" class="btn btn-success">Add to Cart</button>
                        <input type="number" name="pqty" value="1" min="1" max="<%= product.getProdQuantity() %>">
                    </form>
                    <br />
                </div>
            </div>
        <%
            }
        %>
    </div>
</div>
<!-- End of Product Items List -->

<jsp:include page="/fragments/footer.html" />

</body>
</html>
