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
    <script>
        $(document).ready(function() {
            // Function to load initial products
            function loadInitialProducts() {
                $.ajax({
                    url: "ProductListServlet",
                    method: "GET",
                    success: function(responseHtml) {
                        $("#product-list").html(responseHtml); // Update product list with received HTML
                    },
                    error: function() {
                        console.error("Error fetching initial products.");
                    }
                });
            }

            // Call loadInitialProducts function on page load
            loadInitialProducts();
            
            // Event listener for genre links
            $('#generi-dropdown ul.dropdown-menu li a').on('click', function(e) {
                e.preventDefault();
                var type = $(this).data('type');
                
                $.ajax({
                    url: 'ProductListServlet?type=' + encodeURIComponent(type),
                    method: 'GET',
                    success: function(responseHtml) {
                        $("#product-list").html(responseHtml); // Update product list with filtered products
                    },
                    error: function() {
                        console.error('Error fetching products for type: ' + type);
                    }
                });
            });

            // Event listener for search form
            $('form[action="index.jsp"]').submit(function(e) {
                e.preventDefault();
                var searchQuery = $(this).find('.search-data').val();

                $.ajax({
                    url: 'ProductListServlet?search=' + encodeURIComponent(searchQuery),
                    method: 'GET',
                    success: function(responseHtml) {
                        $("#product-list").html(responseHtml); // Update product list with search results
                    },
                    error: function() {
                        console.error('Error fetching products for search query: ' + searchQuery);
                    }
                });
            });
        });
    </script>
</head>
<body>

<jsp:include page="./fragments/header.jsp" />

<div class="container">
    <div class="row text-center" id="product-list">
        <%-- This section will be populated dynamically --%>
    </div>
</div>

<%@ include file="./fragments/footer.html" %>

</body>
</html>
