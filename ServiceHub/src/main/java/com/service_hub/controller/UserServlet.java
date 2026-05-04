package com.service_hub.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.service_hub.utils.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(asyncSupported = true, urlPatterns = { "/User" })
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // Inner class for Booking model
    public static class Booking {
        private int bookingId;
        private String serviceName;
        private double servicePrice;
        private String customerName;
        private String customerPhone;
        private String preferredDate;
        private String preferredTime;
        private String serviceAddress;
        private String additionalNotes;
        private String status;
        private String paymentStatus;
        private String bookingDate;
        
        // Getters and Setters
        public int getBookingId() { return bookingId; }
        public void setBookingId(int bookingId) { this.bookingId = bookingId; }
        
        public String getServiceName() { return serviceName; }
        public void setServiceName(String serviceName) { this.serviceName = serviceName; }
        
        public double getServicePrice() { return servicePrice; }
        public void setServicePrice(double servicePrice) { this.servicePrice = servicePrice; }
        
        public String getCustomerName() { return customerName; }
        public void setCustomerName(String customerName) { this.customerName = customerName; }
        
        public String getCustomerPhone() { return customerPhone; }
        public void setCustomerPhone(String customerPhone) { this.customerPhone = customerPhone; }
        
        public String getPreferredDate() { return preferredDate; }
        public void setPreferredDate(String preferredDate) { this.preferredDate = preferredDate; }
        
        public String getPreferredTime() { return preferredTime; }
        public void setPreferredTime(String preferredTime) { this.preferredTime = preferredTime; }
        
        public String getServiceAddress() { return serviceAddress; }
        public void setServiceAddress(String serviceAddress) { this.serviceAddress = serviceAddress; }
        
        public String getAdditionalNotes() { return additionalNotes; }
        public void setAdditionalNotes(String additionalNotes) { this.additionalNotes = additionalNotes; }
        
        public String getStatus() { return status; }
        public void setStatus(String status) { this.status = status; }
        
        public String getPaymentStatus() { return paymentStatus; }
        public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }
        
        public String getBookingDate() { return bookingDate; }
        public void setBookingDate(String bookingDate) { this.bookingDate = bookingDate; }
    }
    
    public UserServlet() {
        super();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        
        // Check if user is logged in
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get filter parameter (pending, confirmed, completed, cancelled, all)
        String filter = request.getParameter("filter");
        if (filter == null || filter.isEmpty()) {
            filter = "all";
        }
        
        // Fetch bookings from database
        List<Booking> bookings = getUserBookings(userId, filter);
        
        // Get counts for each status
        Map<String, Integer> statusCounts = getBookingCounts(userId);
        
        // Set attributes for JSP
        request.setAttribute("bookings", bookings);
        request.setAttribute("statusCounts", statusCounts);
        request.setAttribute("currentFilter", filter);
        
        // Forward to user dashboard
        request.getRequestDispatcher("/WEB-INF/pages/userdashboard.jsp").forward(request, response);
    }
    
    private List<Booking> getUserBookings(int userId, String filter) {
        List<Booking> bookings = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql;
            
            // Build SQL based on filter
            if ("all".equals(filter)) {
                sql = "SELECT * FROM bookings WHERE user_id = ? ORDER BY booking_id DESC";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, userId);
            } else {
                sql = "SELECT * FROM bookings WHERE user_id = ? AND status = ? ORDER BY booking_id DESC";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, userId);
                pstmt.setString(2, filter);
            }
            
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setServiceName(rs.getString("service_name"));
                booking.setServicePrice(rs.getDouble("service_price"));
                booking.setCustomerName(rs.getString("customer_name"));
                booking.setCustomerPhone(rs.getString("customer_phone"));
                booking.setPreferredDate(rs.getString("preferred_date"));
                booking.setPreferredTime(rs.getString("preferred_time"));
                booking.setServiceAddress(rs.getString("service_address"));
                booking.setAdditionalNotes(rs.getString("additional_notes"));
                booking.setStatus(rs.getString("status"));
                booking.setPaymentStatus(rs.getString("payment_status"));
                booking.setBookingDate(rs.getString("booking_date"));
                bookings.add(booking);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) {}
            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) {}
            try { if (conn != null) conn.close(); } catch (SQLException e) {}
        }
        
        return bookings;
    }
    
    private Map<String, Integer> getBookingCounts(int userId) {
        Map<String, Integer> counts = new HashMap<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            
            // Initialize counts
            counts.put("all", 0);
            counts.put("pending", 0);
            counts.put("confirmed", 0);
            counts.put("completed", 0);
            counts.put("cancelled", 0);
            
            // Get total count
            String sql = "SELECT status, COUNT(*) as count FROM bookings WHERE user_id = ? GROUP BY status";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            rs = pstmt.executeQuery();
            
            int total = 0;
            while (rs.next()) {
                String status = rs.getString("status");
                int count = rs.getInt("count");
                counts.put(status, count);
                total += count;
            }
            counts.put("all", total);
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) {}
            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) {}
            try { if (conn != null) conn.close(); } catch (SQLException e) {}
        }
        
        return counts;
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}