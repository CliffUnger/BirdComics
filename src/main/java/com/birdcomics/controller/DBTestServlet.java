package com.birdcomics.controller;


import com.birdcomics.util.DriverManagerConnectionPool;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DBTestServlet")
public class DBTestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<html><head><title>Database Connection Test</title></head><body>");

        try {
            Connection connection = DriverManagerConnectionPool.createDBConnection();
            if (connection != null) {
                out.println("<h3>Database Connection Test Successful</h3>");
                out.println("<p>Connection: " + connection + "</p>");
                DriverManagerConnectionPool.closeConnection(connection);
            } else {
                out.println("<h3>Database Connection Test Failed</h3>");
            }
        } catch (SQLException e) {
            out.println("<h3>Database Connection Test Failed</h3>");
            out.println("<p>Error: " + e.getMessage() + "</p>");
        } finally {
            out.println("</body></html>");
            out.close(); // Chiudi il PrintWriter
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        doGet(request, response);
    }
}