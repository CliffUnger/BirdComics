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
import javax.servlet.http.HttpSession;

import com.birdcomics.model.CartBean;
import com.birdcomics.model.CartServiceDAO;
import com.birdcomics.model.ProductBean;
import com.birdcomics.model.ProductServiceDAO;

@WebServlet("/CartDataServlet")
public class CartDataServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        String userName = (String) session.getAttribute("username");

        CartServiceDAO cartService = new CartServiceDAO();
        ProductServiceDAO productService = new ProductServiceDAO();

        try {
            List<CartBean> cartItems = cartService.getAllCartItems(userName);
            double totAmount = 0;

            // Begin generating HTML
           
            out.println("<table class=\"table table-hover\">");
            out.println("<thead style=\"background-color: black; color: white; font-size: 16px; font-weight: bold;\">");
            out.println("<tr>");
           
            out.println("</tr>");
            out.println("</thead>");
            out.println("<tbody style=\"background-color: white; font-size: 15px; font-weight: bold;\">");

            for (CartBean item : cartItems) {
                String prodId = item.getProdId();
                int prodQuantity = item.getQuantity();
                ProductBean product = productService.getProductDetails(prodId);

                double currAmount = product.getProdPrice() * prodQuantity;
                totAmount += currAmount;

                if (prodQuantity > 0) {
                    out.println("<tr>");
                    out.println("<td><img src=\"ShowImage?pid=" + product.getProdId() + "\" style=\"width: 50px; height: 50px;\"></td>");
                    out.println("<td>" + product.getProdName() + "</td>");
                    out.println("<td>" + product.getProdPrice() + "</td>");
                    out.println("<td>");
                    out.println("<form method=\"post\" action=\"UpdateToCart\">");
                    out.println("<input type=\"number\" name=\"pqty\" value=\"" + prodQuantity + "\" style=\"max-width: 70px;\" min=\"0\">");
                    out.println("<input type=\"hidden\" name=\"pid\" value=\"" + product.getProdId() + "\">");
                    out.println("<input type=\"submit\" name=\"Update\" value=\"Aggiorna\" style=\"max-width: 80px;\">");
                    out.println("</form>");
                    out.println("</td>");
                    out.println("<td>" + currAmount + "</td>");
                    out.println("</tr>");
                }
            }

            out.println("<tr style=\"background-color: grey; color: white;\">");
            out.println("<td colspan=\"4\" style=\"text-align: center;\">Totale da pagare</td>");
            out.println("<td>" + totAmount + "</td>");
            out.println("</tr>");

            if (totAmount != 0) {
                out.println("<tr style=\"background-color: grey; color: white;\">");
                out.println("<td colspan=\"3\" style=\"text-align: center;\"></td>");
                out.println("<td>");
                out.println("<form method=\"post\" action=\"index.jsp\">");
                out.println("<button style=\"background-color: black; color: white;\">Cancella</button>");
                out.println("</form>");
                out.println("</td>");
                out.println("<td colspan=\"2\" align=\"center\">");
                out.println("<form method=\"post\" action=\"payment.jsp\">");
                out.println("<button style=\"background-color: black; color: white;\" type=\"submit\">Paga ora</button>");
                out.println("<input type=\"hidden\" name=\"amount\" value=\"" + totAmount + "\">");
                out.println("</form>");
                out.println("</td>");
                out.println("</tr>");
            }

            out.println("</tbody>");
            out.println("</table>");
            out.println("</div>");

        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database error", e);
        } finally {
            out.close();
        }
    }
}
