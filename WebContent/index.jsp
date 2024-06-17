<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page
    import="com.birdcomics.model.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Birdcomics</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
    href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" href="css/changes.css">
<script
    src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
    src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
</head>
<body>

    <%
    /* Checking the user credentials */
    String userName = (String) session.getAttribute("username");
    String password = (String) session.getAttribute("password");
    String userType = (String) session.getAttribute("usertype");

    boolean isValidUser = true;

    if (userType == null || userName == null || password == null || !userType.equals("customer")) {

        isValidUser = false;
    }

    ProductServiceDAO prodDao = new ProductServiceDAO();
    List<ProductBean> products = new ArrayList<ProductBean>();

    String search = request.getParameter("search");
    String type = request.getParameter("type");
    String message = "All Products";
    if (search != null) {
        products = prodDao.searchAllProducts(search);
        message = "Showing Results for '" + search + "'";
    } else if (type != null) {
        products = prodDao.getAllProductsByType(type);
        message = "Showing Results for '" + type + "'";
    } else {
        products = prodDao.getAllProducts();
    }
    if (products.isEmpty()) {
        message = "No items found for the search '" + (search != null ? search : type) + "'";
        products = prodDao.getAllProducts();
    }
    %>

    <jsp:include page="/fragments/header.jsp" />

    <div class="text-center"
        style="color: black; font-size: 14px; font-weight: bold;"><%=message%></div>
    <div class="text-center" id="message"
        style="color: black; font-size: 14px; font-weight: bold;"></div>
    <!-- Start of Product Items List -->
    <div class="container">
        <div class="row text-center">

            <%
            for (ProductBean product : products) {
                String prodInfo = product.getProdInfo().length() > 100 ? product.getProdInfo().substring(0, 100) + ".." : product.getProdInfo();
            %>
            <div class="col-sm-4" style='height: 350px;'>
                <div class="thumbnail">
                    <img src="./ShowImage?pid=<%=product.getProdId()%>" alt="Product"
                        style="height: 150px; max-width: 180px">
                    <p class="productname"><%=product.getProdName()%>
                    </p>
                    <p class="productinfo"><%=prodInfo%>
                    </p>
                    <p class="price">
                        Rs
                        <%=product.getProdPrice()%>
                    </p>
                    <form method="post" action="AddToCart">
                        <input type="hidden" name="pid" value="<%=product.getProdId()%>">
                        <button type="submit" class="btn btn-success">Add to Cart</button>
                        <input type="number" name="pqty" value="1" min="1" max="<%=product.getProdQuantity()%>">
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

    <%@ include file="/fragments/footer.html"%>

</body>
</html>
