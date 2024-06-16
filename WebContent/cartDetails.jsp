<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cart Details</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/changes.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>

<%@ include file="./fragments/header.jsp" %>

<div class="container">
    <h2 class="text-center" style="color: green; font-size: 24px; font-weight: bold;">Carrello</h2>
    <br>

    <table class="table table-hover">
        <thead style="background-color: black; color: white; font-size: 16px; font-weight: bold;">
            <tr>
                <th>Foto</th>
                <th>Prodotto</th>
                <th>Prezzo</th>
                <th>Quantità</th>
                <th>Totale</th>
            </tr>
        </thead>
        <tbody id="cartItems" style="background-color: white; font-size: 15px; font-weight: bold;">
            <!-- This tbody will be populated dynamically -->
        </tbody>
    </table>

    <script>
        $(document).ready(function() {
            // Function to update cart items dynamically
            function updateCartItems() {
                $.ajax({
                    url: "CartDataServlet", // Replace with your servlet URL
                    method: "GET",
                    success: function(data) {
                        $("#cartItems").html(data); // Update tbody with received data
                    },
                    error: function() {
                        alert("Error fetching cart data.");
                    }
                });
            }

            // Call updateCartItems function on page load
            updateCartItems();
        });
    </script>
</div>

<%@ include file="./fragments/footer.html" %>

</body>
</html>
