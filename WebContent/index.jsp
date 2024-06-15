<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
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
    document.addEventListener("DOMContentLoaded", function() {
        // Funzione per caricare i prodotti iniziali senza filtro
        loadInitialProducts();

        // Gestisci il click sui link dei generi
        var generiLinks = document.querySelectorAll('#generi-dropdown ul.dropdown-menu li a');
        
        generiLinks.forEach(function(link) {
            link.addEventListener('click', function(e) {
                e.preventDefault(); // Evita il comportamento predefinito del link
                
                var type = this.getAttribute('data-type'); // Ottieni il tipo di prodotto
                
                // Esegui una richiesta AJAX per ottenere i prodotti per il tipo selezionato
                var xhr = new XMLHttpRequest();
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === 4) {
                        if (xhr.status === 200) {
                            // Aggiorna la sezione dei prodotti con la risposta ottenuta
                            var productList = document.getElementById('product-list');
                            if (productList) {
                                productList.innerHTML = xhr.responseText;
                            }
                        } else {
                            console.error('Error:', xhr.status, xhr.statusText);
                        }
                    }
                };
                
                xhr.open('GET', 'ProductListServlet?type=' + encodeURIComponent(type), true);
                xhr.send();
            });
        });
    });

    function loadInitialProducts() {
        // Esegui una richiesta AJAX per ottenere tutti i prodotti iniziali senza filtro
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    // Aggiorna la sezione dei prodotti con la risposta ottenuta
                    var productList = document.getElementById('product-list');
                    if (productList) {
                        productList.innerHTML = xhr.responseText;
                    }
                } else {
                    console.error('Error:', xhr.status, xhr.statusText);
                }
            }
        };
        
        xhr.open('GET', 'ProductListServlet', true);
        xhr.send();
    }
    </script>
</head>
<body>


<jsp:include page="./fragments/header.jsp" />

<div class="container">
    <div class="row text-center" id="product-list">
        <%-- Questa sezione sarà popolata dinamicamente --%>
    </div>
</div>

<%@ include file="./fragments/footer.html" %>

</body>
</html>
