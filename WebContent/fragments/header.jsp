<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.birdcomics.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>


<html>
<head>
<title>Logout Header</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" href="css/changes.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
</head>
<body>


	<nav>
		<div class="menu-icon">
			<span class="fas fa-bars"></span>
		</div>
		<div class="logo">BirdComics</div>
		<div class="nav-items">
			<ul class="nav navbar-nav">
				<c:choose>
					<c:when test="${'admin' eq sessionScope.usertype}">
						<!-- Elementi specifici per admin -->
						<li class="dropdown"><a class="dropdown-toggle"
							data-toggle="dropdown" href="#">Gestione libri <span
								class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="adminStock.jsp">Elenco libri</a></li>
								<li><a href="addProduct.jsp">Aggiungi libro</a></li>
								<li><a href="removeProduct.jsp">Rimuovi libro</a></li>
								<li><a href="updateProductById.jsp">Aggiorna libro</a></li>
							</ul></li>
						<li class="dropdown"><a class="dropdown-toggle"
							data-toggle="dropdown" href="#">Gestione ordini <span
								class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="unshippedItems.jsp">Ordini da spedire</a></li>
								<li><a href="shippedItems.jsp">Ordini spediti</a></li>
							</ul></li>
						<li><a href="userHome.jsp?type=mobile">Gestione utenti</a></li>
						<li><a href="./LogoutSrv">Logout</a></li>
					</c:when>
					<c:otherwise>
						<!-- Elementi comuni per utente loggato e non loggato -->
						<li><a href="index.jsp">Home</a></li>
						<li><a href="index.jsp">Libri</a></li>


						<li class="dropdown" id="generi-dropdown"><a
							class="dropdown-toggle" data-toggle="dropdown" href="#">Generi
								<span class="caret"></span>
						</a>
							<ul class="dropdown-menu">
								<li><a href="#" data-type="mobile">Mobiles</a></li>
								<li><a href="#" data-type="tv">TVs</a></li>
								<li><a href="#" data-type="laptop">Laptops</a></li>
								<li><a href="index.jsp?type=camera" data-type="camera">Camera</a></li>
								<li><a href="index.jsp?type=speaker" data-type="speaker">Speakers</a></li>
								<li><a href="index.jsp?type=tablet" data-type="tablet">Tablets</a></li>
								<!-- Altri tipi di prodotto -->
							</ul></li>

						<c:choose>
							<c:when test="${not empty sessionScope.usertype}">
								<!-- Elementi specifici per utente loggato -->
								<li><a href="cartDetails.jsp">Carrello</a></li>
								<li><a href="orderDetails.jsp">Ordini</a></li>
								<li><a href="userProfile.jsp">Profilo</a></li>
								<li><a href="./LogoutSrv">Logout</a></li>
							</c:when>
							<c:otherwise>
								<!-- Elementi specifici per utente non loggato -->
								<li><a href="login.jsp">Login</a></li>
								<li><a href="register.jsp">Registrati</a></li>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
		<div class="search-icon">
			<span class="fas fa-search"></span>
		</div>
		<div class="cancel-icon">
			<span class="fas fa-times"></span>
		</div>
		<form class="form-inline" action="index.jsp" method="get">
			<input type="text" class="search-data form-control" name="search"
				placeholder="Cerca libri..." required>
			<button type="submit" class="fas fa-search"></button>
		</form>
	</nav>



</body>
</html>