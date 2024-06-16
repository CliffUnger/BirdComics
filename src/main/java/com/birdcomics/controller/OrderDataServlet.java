package com.birdcomics.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.birdcomics.model.OrderDetailsBean;
import com.birdcomics.model.OrderServiceDAO;

/**
 * Servlet implementation class OrderServlet
 */
@WebServlet("/OrderDataServlet")
public class OrderDataServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        String userName = (String) session.getAttribute("username");

        OrderServiceDAO orderService = new OrderServiceDAO();

        try {
            List<OrderDetailsBean> orders = orderService.getAllOrderDetails(userName);

            out.println("<table class=\"table table-hover table-sm\">");
            out.println("<thead style=\"background-color: black; color: white; font-size: 14px; font-weight: bold;\">");
            out.println("<tr>");
            out.println("<th>Picture</th>");
            out.println("<th>ProductName</th>");
            out.println("<th>OrderId</th>");
            out.println("<th>Quantity</th>");
            out.println("<th>Price</th>");
            out.println("<th>Time</th>");
            out.println("<th>Status</th>");
            out.println("</tr>");
            out.println("</thead>");
            out.println("<tbody style=\"background-color: white; font-size: 15px; font-weight: bold;\">");

            for (OrderDetailsBean order : orders) {
                out.println("<tr>");
                out.println("<td><img src=\"./ShowImage?pid=" + order.getProductId() + "\" style=\"width: 50px; height: 50px;\"></td>");
                out.println("<td>" + order.getProdName() + "</td>");
                out.println("<td>" + order.getOrderId() + "</td>");
                out.println("<td>" + order.getQty() + "</td>");
                out.println("<td>" + order.getAmount() + "</td>");
                out.println("<td>" + order.getTime() + "</td>");
                out.println("<td class=\"text-success\">" + (order.getShipped() == 0 ? "ORDER_PLACED" : "ORDER_SHIPPED") + "</td>");
                out.println("</tr>");
            }

            out.println("</tbody>");
            out.println("</table>");

        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database error", e);
        } finally {
            out.close();
        }
    }
}


