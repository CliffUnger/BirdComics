<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page
	import="com.birdcomics.model.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Update Product</title>
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
    <jsp:include page="/fragments/header.jsp" />

    <div class="container">
        <div class="row"
            style="margin-top: 35px; margin-left: 2px; margin-right: 2px; margin-bottom: 35px">
            <form action="UpdateProductSrv" method="post"
                class="col-md-4 col-md-offset-4">
                <div style="font-weight: bold;" class="text-center">
                    <h3 style="color: green;">Product Update Form</h3>
                    <% 
                    String message = (String) request.getAttribute("message");
                    ProductBean product = (ProductBean) request.getAttribute("product");
                    %>
                    <% if (message != null) { %>
                        <p style="color: blue;">
                            <%= message %>
                        </p>
                    <% } %>
                </div>
                <div class="row">
                    <div class="col-md-12 form-group">
                        <label for="prodid">Product Id</label>
                        <input type="text" placeholder="Enter Product Id" name="prodid"
                            class="form-control" id="prodid" value="<%= product != null ? product.getProdId() : "" %>"
                            required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 form-group">
                        <label for="name">Product Name</label>
                        <input type="text" placeholder="Enter Product Name" name="name"
                            class="form-control" id="name"
                            value="<%= product != null ? product.getProdName() : "" %>" required>
                    </div>
                    <div class="col-md-6 form-group">
                        <label for="type">Product Type</label>
                        <select name="type" id="type" class="form-control" required>
                            <option value="mobile"
                                <%= product != null && "mobile".equalsIgnoreCase(product.getProdType()) ? "selected" : "" %>>MOBILE</option>
                            <option value="tv"
                                <%= product != null && "tv".equalsIgnoreCase(product.getProdType()) ? "selected" : "" %>>TV</option>
                            <option value="camera"
                                <%= product != null && "camera".equalsIgnoreCase(product.getProdType()) ? "selected" : "" %>>CAMERA</option>
                            <option value="laptop"
                                <%= product != null && "laptop".equalsIgnoreCase(product.getProdType()) ? "selected" : "" %>>LAPTOP</option>
                            <option value="tablet"
                                <%= product != null && "tablet".equalsIgnoreCase(product.getProdType()) ? "selected" : "" %>>TABLET</option>
                            <option value="speaker"
                                <%= product != null && "speaker".equalsIgnoreCase(product.getProdType()) ? "selected" : "" %>>SPEAKER</option>
                            <option value="other"
                                <%= product != null && "other".equalsIgnoreCase(product.getProdType()) ? "selected" : "" %>>Some Other Appliances</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label for="info">Product Description</label>
                    <textarea name="info" class="form-control" id="info" required><%= product != null ? product.getProdInfo() : "" %></textarea>
                </div>
                <div class="row">
                    <div class="col-md-6 form-group">
                        <label for="price">Unit Price</label>
                        <input type="number" placeholder="Enter Unit Price" name="price"
                            class="form-control" id="price"
                            value="<%= product != null ? product.getProdPrice() : "" %>" required>
                    </div>
                    <div class="col-md-6 form-group">
                        <label for="quantity">Stock Quantity</label>
                        <input type="number" placeholder="Enter Stock Quantity" name="quantity"
                            class="form-control" id="quantity"
                            value="<%= product != null ? product.getProdQuantity() : "" %>" required>
                    </div>
                </div>
                <div class="row text-center">
                    <div class="col-md-4" style="margin-bottom: 2px;">
                        <a href="adminStock.jsp" class="btn btn-info">Cancel</a>
                    </div>
                    <div class="col-md-4">
                        <button type="submit" class="btn btn-danger">Update Product</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <jsp:include page="/fragments/footer.html" />

</body>
</html>
