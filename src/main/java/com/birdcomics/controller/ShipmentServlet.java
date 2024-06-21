package com.birdcomics.controller;

import java.io.IOException;
import java.io.PrintWriter;
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
 * Servlet implementation class ShipmentServlet
 */
@WebServlet("/ShipmentServlet")
public class ShipmentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ShipmentServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		String userType = (String) session.getAttribute("usertype");
		if (userType == null) {

			response.sendRedirect("login.jsp?message=Access Denied, Login Again!!");
			return;
		}

		String orderId = request.getParameter("orderid");
		String prodId = request.getParameter("prodid");
		String userName = request.getParameter("userid");
		Double amount = Double.parseDouble(request.getParameter("amount"));
		String status;
		try {
			status = new OrderServiceDAO().shipNow(orderId, prodId);
			String pagename = "shippedItems.jsp";
			if ("FAILURE".equalsIgnoreCase(status)) 
				pagename = "unshippedItems.jsp";
			PrintWriter pw = response.getWriter();
			response.setContentType("text/html");

			RequestDispatcher rd = request.getRequestDispatcher(pagename);
			rd.include(request, response);

			pw.println("<script>document.getElementById('message').innerHTML='" + status + "'</script>");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		


	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}