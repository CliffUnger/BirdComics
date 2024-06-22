package com.birdcomics.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
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
import com.birdcomics.model.TransServiceDAO;
import com.birdcomics.model.UserServiceDAO;

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
        List<String> ArrayUserId = new ArrayList<>();
        List<String> ArrayUserAddr = new ArrayList<>();
        String search = request.getParameter("search");
        String date = request.getParameter("date");

        try {
            if (search != null && !search.isEmpty()) {
                orders = orderdao.getOrdersByUserId(search);
            } 
            else {
                orders = orderdao.getAllOrders();
            }

            // Populate ArrayUserId and ArrayUserAddr
            for (OrderBean order : orders) {
                String transId = order.getTransactionId();
                String userId = new TransServiceDAO().getUserId(transId);
                String userAddr = new UserServiceDAO().getUserAddr(userId);

                ArrayUserId.add(userId);
                ArrayUserAddr.add(userAddr);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("orders", orders);
        request.setAttribute("ArrayUserId", ArrayUserId);
        request.setAttribute("ArrayUserAddr", ArrayUserAddr);
        RequestDispatcher rd = request.getRequestDispatcher("/shippedItems.jsp");
        rd.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
