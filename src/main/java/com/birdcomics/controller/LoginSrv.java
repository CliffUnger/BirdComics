package com.birdcomics.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.birdcomics.model.*;

/**
 * Servlet implementation class LoginSrv
 */
@WebServlet("/LoginSrv")
public class LoginSrv extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public LoginSrv() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userName = request.getParameter("username");
        String password = request.getParameter("password");
        String userType = request.getParameter("usertype");
        response.setContentType("text/html");

        String status = "Login Denied! Invalid Username or password.";

        if (userType.equals("admin")) { // Login as Admin

            UserServiceDAO udao = new UserServiceDAO();

            try {
                status = udao.isValidCredential(userName, password);
            } catch (SQLException e) {
                e.printStackTrace();
            }

            if (status.equalsIgnoreCase("valid")) {
                // valid user

                // Check if the user is an admin
                try {
					if (udao.getUserType(userName).equals("admin")) {
					    // Admin login successful

					    UserBean user = null;
					    try {
					        user = udao.getUserDetails(userName, password);
					    } catch (SQLException e) {
					        e.printStackTrace();
					    }

					    HttpSession session = request.getSession();

					    session.setAttribute("userdata", user);
					    session.setAttribute("username", userName);
					    session.setAttribute("password", password);
					    session.setAttribute("usertype", userType);

					    RequestDispatcher rd = request.getRequestDispatcher("adminStock.jsp");
					    rd.forward(request, response);
					} else {
					    // User is not admin, handle accordingly
					    status = "Login Denied! You are not authorized as Admin.";
					    RequestDispatcher rd = request.getRequestDispatcher("login.jsp?message=" + status);
					    rd.include(request, response);
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (ServletException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

            } else {
                // Invalid credentials
                RequestDispatcher rd = request.getRequestDispatcher("login.jsp?message=" + status);
                rd.include(request, response);
            }

        } else { // Login as customer

            UserServiceDAO udao = new UserServiceDAO();

            try {
                status = udao.isValidCredential(userName, password);
            } catch (SQLException e) {
                e.printStackTrace();
            }

            if (status.equalsIgnoreCase("valid")) {
                // valid user

                UserBean user = null;
                try {
                    user = udao.getUserDetails(userName, password);
                } catch (SQLException e) {
                    e.printStackTrace();
                }

                HttpSession session = request.getSession();

                session.setAttribute("userdata", user);
                session.setAttribute("username", userName);
                session.setAttribute("password", password);
                session.setAttribute("usertype", userType);

                RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
                rd.forward(request, response);

            } else {
                // invalid user;
                RequestDispatcher rd = request.getRequestDispatcher("login.jsp?message=" + status);
                rd.include(request, response);
            }
        }

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }

}
