package com.service_hub.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.service_hub.dao.AdminDAO;
import com.service_hub.model.BookingModel;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AdminDAO adminDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        adminDAO = new AdminDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        
        // Check if admin is logged in
        if (role == null || !"admin".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get filter parameter
        String filter = request.getParameter("filter");
        if (filter == null || filter.isEmpty()) {
            filter = "all";
        }
        
        // Get data using DAO (NO SQL HERE)
        List<BookingModel> bookings = adminDAO.getAllBookings(filter);
        Map<String, Integer> statusCounts = adminDAO.getBookingCounts();
        Map<String, Object> statistics = adminDAO.getDashboardStatistics();
        
        // Set attributes for JSP
        request.setAttribute("bookings", bookings);
        request.setAttribute("statusCounts", statusCounts);
        request.setAttribute("currentFilter", filter);
        request.setAttribute("totalServices", statistics.get("totalServices"));
        request.setAttribute("totalTechnicians", statistics.get("totalTechnicians"));
        request.setAttribute("totalBookings", statistics.get("totalBookings"));
        request.setAttribute("pendingBookings", statistics.get("pendingBookings"));
        
        request.getRequestDispatcher("/WEB-INF/pages/admindashboard.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        
        if (role == null || !"admin".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("updateStatus".equals(action)) {
            String bookingIdStr = request.getParameter("bookingId");
            String newStatus = request.getParameter("status");
            
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            
            if (bookingIdStr != null && newStatus != null) {
                int bookingId = Integer.parseInt(bookingIdStr);
                boolean updated = adminDAO.updateBookingStatus(bookingId, newStatus);
                
                if (updated) {
                    out.write("{\"success\": true, \"message\": \"Booking status updated successfully\"}");
                } else {
                    out.write("{\"success\": false, \"message\": \"Failed to update booking status\"}");
                }
            } else {
                out.write("{\"success\": false, \"message\": \"Invalid parameters\"}");
            }
            out.flush();
            return;
        }
        
        response.sendRedirect(request.getContextPath() + "/admin");
    }
}