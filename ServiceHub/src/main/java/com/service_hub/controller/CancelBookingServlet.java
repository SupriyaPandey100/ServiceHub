package com.service_hub.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.service_hub.dao.BookingDAO;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/cancel-booking")
public class CancelBookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookingDAO bookingDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        bookingDAO = new BookingDAO();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        String bookingIdStr = request.getParameter("bookingId");
        
        StringBuilder jsonResponse = new StringBuilder();
        response.setContentType("application/json");
        
        if (userId == null) {
            jsonResponse.append("{\"success\": false, \"message\": \"Please login first\"}");
            response.getWriter().write(jsonResponse.toString());
            return;
        }
        
        if (bookingIdStr == null || bookingIdStr.isEmpty()) {
            jsonResponse.append("{\"success\": false, \"message\": \"Invalid booking ID\"}");
            response.getWriter().write(jsonResponse.toString());
            return;
        }
        
        int bookingId = Integer.parseInt(bookingIdStr);
        
        // Cancel booking using DAO (NO SQL HERE)
        boolean cancelled = bookingDAO.cancelBooking(bookingId, userId);
        
        if (cancelled) {
            jsonResponse.append("{\"success\": true, \"message\": \"Booking cancelled successfully\"}");
        } else {
            jsonResponse.append("{\"success\": false, \"message\": \"Cannot cancel this booking. It may already be confirmed or completed.\"}");
        }
        
        PrintWriter out = response.getWriter();
        out.write(jsonResponse.toString());
        out.flush();
    }
}