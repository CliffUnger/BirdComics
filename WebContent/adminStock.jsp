<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page
	import="com.birdcomics.model.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Product Stocks</title>
<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/changes.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
</head>
<body>
  <%  String userType = (String) session.getAttribute("usertype");
     if (userType == null || userType.isEmpty()) {
        RequestDispatcher dispatcher = request.getRequestDispatcher("./adminStock");
        dispatcher.forward(request, response);

        return;
    }
     
     if (userType.isEmpty()) {
         return;
     }
%>

<jsp:include page="./fragments/header.jsp" />

<div class="text-center"
    style="color: green; font-size: 24px; font-weight: bold; margin-top: 15px; margin-bottom: 15px;">Gestione libri</div>


<div class="search-bar">
    <form class="search-form" action="adminStock" method="get">
        <input type="text" name="search" placeholder="Cerca un libro..."">
        <input type="submit" value="Submit">
    </form>   
</div>
 <% String message = (String) request.getAttribute("message");%>
    <h3 style="text-align: center;"><%= message%></h3>
<div class="container-fluid">
    <div class="table-responsive">
        <table class="table table-hover table-sm">
            <thead style="background-color: #2c6c4b; color: white; font-size: 18px;">
                <tr>
                    <th>Image</th>
                    <th>ProductId</th>
                    <th>Name</th>
                    <th>Type</th>
                    <th>Price</th>
                    <th>Sold Qty</th>
                    <th>Stock Qty</th>
                    <th colspan="2" style="text-align: center">Actions</th>
                </tr>
            </thead>
            <tbody style="background-color: white; font-size: 16px;">
                <% List<ProductBean> products = (List<ProductBean>) request.getAttribute("products");
                List<Integer> soldQuantities = (List<Integer>) request.getAttribute("soldQuantities");
                int index = 0;
            	OrderServiceDAO orderDao = new OrderServiceDAO();
                   if (products != null) {
                       for (ProductBean product : products) { %>
       
                           <tr>
                               <td><img src="./ShowImage?pid=<%= product.getProdId() %>"
                                    style="width: 50px; height: 50px;"></td>
                               <td><a href="./updateProduct.jsp?prodid=<%= product.getProdId() %>"><%= product.getProdId() %></a></td>
                               <%-- Limit name to 25 characters --%>
                               <% String name = product.getProdName().substring(0, Math.min(product.getProdName().length(), 25)) + ".."; %>
                               <td><%= name %></td>
                               <td><%= product.getProdType().toUpperCase() %></td>
                               <td><%= product.getProdPrice() %></td>
                               <td><%= soldQuantities.get(index++) %></td>
                               <td><%= product.getProdQuantity() %></td>
                               <td>
                                   <form method="post" action="./updateProduct.jsp">
                                       <input type="hidden" name="prodid" value="<%= product.getProdId() %>">
                                       <button type="submit" class="btn btn-primary">Update</button>
                                   </form>
                               </td>
                               <td>
                                   <form method="post" action="./RemoveProductSrv">
                                       <input type="hidden" name="prodid" value="<%= product.getProdId() %>">
                                       <button type="submit" class="btn btn-danger">Remove</button>
                                   </form>
                               </td>
                           </tr>
               <%     }
                     } else { %>
                           <tr style="background-color: grey; color: white;">
                               <td colspan="7" style="text-align: center;">No Items Available</td>
                           </tr>
               <%  } %>
            </tbody>
        </table>
    </div>
</div>

<!DOCTYPE html>
<html>

<head>
	<title>Shopping Center</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="css/changes.css">

</head>




<body>
<br>
<br>
<br>
<br>
<br>
	<footer class="footer-area footer--light">
		<div class="footer-big">
			<!-- start .container -->
			<div class="container">
				<div class="row">
					<div class="col-md-3 col-sm-12">
						<div class="footer-widget">
							<div class="widget-about">
								<h1>Birdcomics</h1>
								<p>Acquista online e risparmia con le offerte. Tutti i libri bestseller su Birdcomics.</p>
								<ul class="contact-details">
									<li>
										<span class="icon-earphones"></span> Contattaci:
										<a href="tel:344-755-111">344-755-111</a>
									</li>
									<li>
										<span class="icon-envelope-open"></span>
										<a href="mailto:support@aazztech.com">support@birdcomics.com</a>
									</li>
								</ul>
							</div>
						</div>
						<!-- Ends: .footer-widget -->
					</div>
				


					<div class="col-md-3 col-sm-4">
						<div class="footer-widget">
							<div class="footer-menu no-padding">
								<h4 class="footer-widget-title">Pagine</h4>
								<ul>
									<li>
										<a href="index.jsp">Home</a>
									</li>
			
									<li>
										<a href="privacy.jsp">Privacy Policy</a>
									</li>
									
									
								</ul>
							</div>
							<!-- end /.footer-menu -->
						</div>
						<!-- Ends: .footer-widget -->
					</div>
					<!-- Ends: .col-lg-3 -->

				</div>
				<!-- end /.row -->
			</div>
			<!-- end /.container -->
		</div>
		<!-- end /.footer-big -->

		<div class="mini-footer">
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<div class="copyright-text">
							<p>Copyright 2024 Birdcomics
							</p>
						</div>

					</div>
				</div>
			</div>
		</div>
	</footer>
	




	<script src="scripts/menu.js"></script>

</body>

</html>

</body>
</html>
