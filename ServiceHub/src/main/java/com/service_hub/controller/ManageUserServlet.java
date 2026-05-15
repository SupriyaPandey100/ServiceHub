package com.service_hub.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.service_hub.dao.UserDAO;
import com.service_hub.model.UserModel;

/**
 * Servlet implementation class ManageUserServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/manageuser" })
public class ManageUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManageUserServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            UserDAO dao = new UserDAO();
            List<UserModel> users = dao.getAllUsers();

            request.setAttribute("users", users);

            request.getRequestDispatcher("/WEB-INF/pages/manageuser.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String action = request.getParameter("action");

            UserDAO dao = new UserDAO();

            if (action.equals("approve")) {
                dao.updateStatus(id, "approved");
            } else if (action.equals("reject")) {
                dao.updateStatus(id, "rejected");
            }

            response.sendRedirect("manageuser");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
