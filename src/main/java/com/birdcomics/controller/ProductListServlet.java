package com.birdcomics.controller;



import com.birdcomics.model.ProductBean;
import com.birdcomics.model.ProductServiceDAO;

import java.io.IOException;

import com.birdcomics.model.ProductBean;
import com.birdcomics.model.ProductServiceDAO;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ProductListServlet")
public class ProductListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ProductServiceDAO prodDao;


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
        	prodDao = new ProductServiceDAO();
            List<ProductBean> products = prodDao.getAllProducts();
            String message = "All Products";

            if (products.isEmpty()) {
                message = "No products found.";
            }

            // Imposta gli attributi sulla richiesta per renderli disponibili nella JSP
            request.setAttribute("products", products);
            request.setAttribute("message", message);

            // Reindirizza alla tua index.jsp
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace(); // Puoi gestire l'eccezione in modo appropriato
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Gestione delle richieste POST se necessario
        doGet(request, response);
    }

    public void destroy() {
        // Chiudi eventuali risorse come il DAO quando la servlet viene distrutta

    }
}
