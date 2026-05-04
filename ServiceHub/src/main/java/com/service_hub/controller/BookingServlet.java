package com.service_hub.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.service_hub.dao.BookingDAO;
import com.service_hub.model.BookingModel;
import java.io.IOException;

@WebServlet("/booking")
public class BookingServlet extends HttpServlet {
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
        
        // Check if user is logged in
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get form parameters
        String serviceName = request.getParameter("serviceName");
        String servicePriceStr = request.getParameter("servicePrice");
        String customerName = request.getParameter("customerName");
        String customerPhone = request.getParameter("customerPhone");
        String preferredDate = request.getParameter("preferredDate");
        String preferredTime = request.getParameter("preferredTime");
        String serviceAddress = request.getParameter("serviceAddress");
        String additionalNotes = request.getParameter("additionalNotes");
        
        // Validate required fields
        if (serviceName == null || servicePriceStr == null || customerName == null || 
            customerPhone == null || preferredDate == null || preferredTime == null || 
            serviceAddress == null) {
            session.setAttribute("bookingError", "All fields are required");
            response.sendRedirect(request.getContextPath() + "/services");
            return;
        }
        
        double servicePrice = Double.parseDouble(servicePriceStr);
        
        // Create Booking object (Model)
        BookingModel booking = new BookingModel();
        booking.setUserId(userId);
        booking.setServiceName(serviceName);
        booking.setServicePrice(servicePrice);
        booking.setCustomerName(customerName);
        booking.setCustomerPhone(customerPhone);
        booking.setPreferredDate(preferredDate);
        booking.setPreferredTime(preferredTime);
        booking.setServiceAddress(serviceAddress);
        booking.setAdditionalNotes(additionalNotes);
        
        // Save booking using DAO (NO SQL HERE)
        boolean success = bookingDAO.createBooking(booking);
        
        if (success) {
            session.setAttribute("bookingSuccess", true);
            session.setAttribute("bookingMessage", "Your booking for " + serviceName + " has been confirmed!");
        } else {
            session.setAttribute("bookingError", "Failed to book service. Please try again.");
        }
        
        response.sendRedirect(request.getContextPath() + "/User");
    }
}
