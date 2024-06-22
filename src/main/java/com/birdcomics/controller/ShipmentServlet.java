package com.birdcomics.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.birdcomics.model.OrderBean;
import com.birdcomics.model.OrderServiceDAO;

@WebServlet("/ShipmentServlet")
public class ShipmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userType = (String) session.getAttribute("usertype");
        if (userType == null) {
            response.sendRedirect("login.jsp?message=Access Denied, Login Again!!");
            return;
        }

        OrderServiceDAO orderdao = new OrderServiceDAO();
        List<OrderBean> orders = null;
        try {
            orders = orderdao.getAllOrders();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        String orderId = request.getParameter("orderid");
        String prodId = request.getParameter("prodid");

        if (orderId != null && prodId != null) {
            try {
                orderdao.shipNow(orderId, prodId);
                // Aggiorna la lista degli ordini dopo la spedizione
                orders = orderdao.getAllOrders();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        request.setAttribute("orders", orders);
        RequestDispatcher rd = request.getRequestDispatcher("/shippedItems.jsp");
        rd.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
