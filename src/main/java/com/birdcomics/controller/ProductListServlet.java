package com.birdcomics.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.birdcomics.model.ProductBean;
import com.birdcomics.model.ProductServiceDAO;

@WebServlet("/ProductListServlet")
public class ProductListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductServiceDAO productService;

    public ProductListServlet() {
        super();
        productService = new ProductServiceDAO(); // Assuming ProductServiceDAO handles data access
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=ISO-8859-1");

        String typeParam = request.getParameter("type");
        try {
            List<ProductBean> products;
            if (typeParam != null && !typeParam.isEmpty()) {
                products = productService.getAllProductsByType(typeParam);
            } else {
                products = productService.getAllProducts();
            }

            PrintWriter out = response.getWriter();
            for (ProductBean product : products) {
                out.println("<div class=\"col-sm-4\" style=\"height: 350px;\">");
                out.println("<div class=\"thumbnail\">");
                out.println("<img src=\"./ShowImage?pid=" + product.getProdId() + "\" alt=\"Product\" style=\"height: 150px; max-width: 180px\">");
                out.println("<p class=\"productname\">" + product.getProdName() + "</p>");
                String prodInfo = product.getProdInfo().length() > 100 ? product.getProdInfo().substring(0, 100) + ".." : product.getProdInfo();
                out.println("<p class=\"productinfo\">" + prodInfo + "</p>");
                out.println("<p class=\"price\">Rs " + product.getProdPrice() + "</p>");
                out.println("<form method=\"post\" action=\"AddToCartAndCheckout\">");
                out.println("<input type=\"hidden\" name=\"pid\" value=\"" + product.getProdId() + "\">");
                out.println("<button type=\"submit\" class=\"btn btn-success\">Add to Cart</button>");
                out.println("<input type=\"number\" name=\"pqty\" value=\"1\" min=\"1\" max=\"" + product.getProdQuantity() + "\">"); // Include la quantità con i limiti
                out.println("</form>");
                out.println("<br />");
                out.println("</div>");
                out.println("</div>");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
