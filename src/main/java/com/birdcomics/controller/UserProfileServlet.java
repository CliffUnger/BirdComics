package com.birdcomics.controller;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.birdcomics.model.*;

@WebServlet("/UserProfileServlet")
public class UserProfileServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userName = (String) request.getSession().getAttribute("username");
        String password = (String) request.getSession().getAttribute("password");
        if (userName != null) {
        	UserServiceDAO dao = new UserServiceDAO();
        	try {
				UserBean user = dao.getUserDetails(userName, password);
				 request.setAttribute("user", user);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
           
            request.getRequestDispatcher("/userProfile.jsp").forward(request, response);
        } 
    }
}


