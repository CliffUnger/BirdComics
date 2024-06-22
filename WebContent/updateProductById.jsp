<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
	<%
	/* Checking the user credentials */
	String userType = (String) session.getAttribute("usertype");
	String userName = (String) session.getAttribute("username");
	String password = (String) session.getAttribute("password");

	if (userType == null || !userType.equals("admin")) {
		response.sendRedirect("login.jsp?message=Access Denied, Login As Admin!!");
		return;

	} else if (userName == null || password == null) {
		response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
		return;
	}
	%>

	<jsp:include page="/fragments/header.jsp" />

	<%
	String message = request.getParameter("message");
	%>
	<div class="container">
		<div class="row"
			style="margin-top: 35px; margin-left: 2px; margin-right: 2px; margin-bottom: 35px">
			<form action="./UpdateProductSrv" method="get"
				class="col-md-4 col-md-offset-4">
				<div style="font-weight: bold;" class="text-center">
					<h3 style="color: green;">Product Update Form</h3>
					<%
					if (message != null) {
					%>
					<p style="color: blue;">
						<%=message%>
					</p>
					<%
					}
					%>
				</div>
				<div></div>
				<div class="row">
					<div class="col-md-12 form-group">
						<label for="last_name">Product Id</label> <input type="text"
							placeholder="Enter Product Id" name="prodid" class="form-control"
							id="last_name" required>
					</div>
				</div>
				<div class="row">
					<div class="col-md-6 text-center" style="margin-bottom: 2px;">
						<a href="adminViewProduct.jsp" class="btn btn-info">Cancel</a>
					</div>
					<div class="col-md-6 text-center">
						<button type="submit" class="btn btn-danger">Update
							Product</button>
					</div>
				</div>
			</form>
		</div>
	</div>


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