<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.birdcomics.model.*, java.util.List, java.util.ArrayList, javax.servlet.ServletOutputStream, java.io.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cart Details</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/changes.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>

    <%
    /* Checking the user credentials */
    String userName = (String) session.getAttribute("username");
    String password = (String) session.getAttribute("password");

    if (userName == null || password == null) {
        response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
    }

    String addS = request.getParameter("add");
    if (addS != null) {
        int add = Integer.parseInt(addS);
        String uid = request.getParameter("uid");
        String pid = request.getParameter("pid");
        int avail = Integer.parseInt(request.getParameter("avail"));
        int cartQty = Integer.parseInt(request.getParameter("qty"));
        CartServiceDAO cartService = new CartServiceDAO(); // Esempio di implementazione di CartServiceDAO

        if (add == 1) {
            // Add Product into the cart
            cartQty += 1;
            if (cartQty <= avail) {
                cartService.addProductToCart(uid, pid, 1); // Metodo ipotetico di aggiunta al carrello
            } else {
                response.sendRedirect("./AddtoCart?pid=" + pid + "&pqty=" + cartQty);
            }
        } else if (add == 0) {
            // Remove Product from the cart
            cartService.removeProductFromCart(uid, pid); // Metodo ipotetico di rimozione dal carrello
        }
    }
    %>

    <jsp:include page="/fragments/header.jsp" />

    <br><br>

    <div class="text-center" style="color: green; font-size: 24px; font-weight: bold;">Carrello</div>
    <br><br>

    <!-- Start of Product Items List -->
    <div class="container">
        <table class="table table-hover">
            <thead style="background-color: black; color: white; font-size: 16px; font-weight: bold;">
                <tr>
                    <th>Foto</th>
                    <th>Prodotto</th>
                    <th>Prezzo</th>
                    <th>Quantità</th>
                    <th>Prezzo Totale</th>
                </tr>
            </thead>
            <tbody style="background-color: white; font-size: 15px; font-weight: bold;">
                <%
                CartServiceDAO cartService = new CartServiceDAO();
                List<CartBean> cartItems = new ArrayList<CartBean>();
                cartItems = cartService.getAllCartItems(userName); // Metodo ipotetico per ottenere tutti gli elementi nel carrello

                double totAmount = 0;
                for (CartBean item : cartItems) {
                    String prodId = item.getProdId();
                    int prodQuantity = item.getQuantity();
                    ProductBean product = new ProductServiceDAO().getProductDetails(prodId); // Esempio di implementazione di getProductDetails in ProductServiceImpl

                    double currAmount = product.getProdPrice() * prodQuantity;
                    totAmount += currAmount;

                    if (prodQuantity > 0) {
                %>
                <tr>
                    <td><img src="./ShowImage?pid=<%=product.getProdId()%>" style="width: 50px; height: 50px;"></td>
                    <td><%=product.getProdName()%></td>
                    <td><%=product.getProdPrice()%></td>
                    <td>
                        <form method="post" action="./UpdateToCart">
                            <input type="number" name="pqty" value="<%=prodQuantity%>" style="max-width: 70px;" min="0">
                            <input type="hidden" name="pid" value="<%=product.getProdId()%>">
                            <input type="submit" name="Update" value="Aggiorna" style="max-width: 80px;">
                        </form>
                    </td>
                    <td><%=currAmount%></td>
                </tr>
                <%
                    }
                }
                %>
                <tr style="background-color: grey; color: white;">
                    <td colspan="4" style="text-align: center;">Totale da pagare</td>
                    <td><%=totAmount%></td>
                </tr>
                <%
                if (totAmount != 0) {
                %>
                <tr style="background-color: grey; color: white;">
                    <td colspan="3" style="text-align: center;"></td>
                    <td>
                        <form method="post">
                            <button formaction="userHome.jsp" style="background-color: black; color: white;">Cancella</button>
                        </form>
                    </td>
                    <td colspan="2" align="center">
                        <form method="post" action="payment.jsp">
                            <button style="background-color: black; color: white;" type="submit">Paga ora</button>
                            <input type="hidden" name="amount" value="<%=totAmount%>">
                        </form>
                    </td>
                </tr>
                <%
                }
                %>
            </tbody>
        </table>
    </div>
    <!-- End of Product Items List -->

    <br><br>
    <%@ include file="/fragments/footer.html"%>

</body>
</html>
