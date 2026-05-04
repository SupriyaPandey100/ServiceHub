package com.service_hub.dao;

import com.service_hub.model.BookingModel;
import com.service_hub.utils.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BookingDAO {
    
    // Helper method to get service ID
    private int getServiceId(Connection conn, String serviceName) throws SQLException {
        String sql = "SELECT service_id FROM services WHERE service_name = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, serviceName);
        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            return rs.getInt("service_id");
        }
        return 0;
    }
    
    // Create a new booking
    public boolean createBooking(BookingModel booking) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBConnection.getConnection();
            
            // Get service_id from service_name
            int serviceId = getServiceId(conn, booking.getServiceName());
            
            String sql = "INSERT INTO bookings (user_id, service_id, service_name, service_price, customer_name, customer_phone, preferred_date, preferred_time, service_address, additional_notes, total_amount, status, payment_status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'pending', 'pending')";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, booking.getUserId());
            pstmt.setInt(2, serviceId);
            pstmt.setString(3, booking.getServiceName());
            pstmt.setDouble(4, booking.getServicePrice());
            pstmt.setString(5, booking.getCustomerName());
            pstmt.setString(6, booking.getCustomerPhone());
            pstmt.setDate(7, java.sql.Date.valueOf(booking.getPreferredDate()));
            pstmt.setString(8, booking.getPreferredTime());
            pstmt.setString(9, booking.getServiceAddress());
            pstmt.setString(10, booking.getAdditionalNotes());
            pstmt.setDouble(11, booking.getServicePrice());
            
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResources(null, pstmt, conn);
        }
    }
    
    // Create booking with notification
    public boolean createBookingWithNotification(BookingModel booking) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        PreparedStatement notifStmt = null;
        
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);
            
            int serviceId = getServiceId(conn, booking.getServiceName());
            
            String sql = "INSERT INTO bookings (user_id, service_id, service_name, service_price, customer_name, customer_phone, preferred_date, preferred_time, service_address, additional_notes, total_amount, status, payment_status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'pending', 'pending')";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, booking.getUserId());
            pstmt.setInt(2, serviceId);
            pstmt.setString(3, booking.getServiceName());
            pstmt.setDouble(4, booking.getServicePrice());
            pstmt.setString(5, booking.getCustomerName());
            pstmt.setString(6, booking.getCustomerPhone());
            pstmt.setDate(7, java.sql.Date.valueOf(booking.getPreferredDate()));
            pstmt.setString(8, booking.getPreferredTime());
            pstmt.setString(9, booking.getServiceAddress());
            pstmt.setString(10, booking.getAdditionalNotes());
            pstmt.setDouble(11, booking.getServicePrice());
            
            int result = pstmt.executeUpdate();
            
            if (result > 0) {
                String notifSql = "INSERT INTO notifications (user_id, title, message) VALUES (?, ?, ?)";
                notifStmt = conn.prepareStatement(notifSql);
                notifStmt.setInt(1, booking.getUserId());
                notifStmt.setString(2, "Booking Confirmed");
                notifStmt.setString(3, "Your booking for " + booking.getServiceName() + " on " + booking.getPreferredDate() + " has been confirmed.");
                notifStmt.executeUpdate();
                
                conn.commit();
                return true;
            } else {
                conn.rollback();
                return false;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            try { if (conn != null) conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            return false;
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) {}
            try { if (notifStmt != null) notifStmt.close(); } catch (SQLException e) {}
            try { if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            } } catch (SQLException e) {}
        }
    }
    
    // Get all bookings for a user
    public List<BookingModel> getUserBookings(int userId, String filter) {
        List<BookingModel> bookings = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql;
            
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
                BookingModel booking = new BookingModel();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setUserId(rs.getInt("user_id"));
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
            closeResources(rs, pstmt, conn);
        }
        
        return bookings;
    }
    
    // Get booking counts
    public Map<String, Integer> getBookingCounts(int userId) {
        Map<String, Integer> counts = new HashMap<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            counts.put("all", 0);
            counts.put("pending", 0);
            counts.put("confirmed", 0);
            counts.put("completed", 0);
            counts.put("cancelled", 0);
            
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
            closeResources(rs, pstmt, conn);
        }
        
        return counts;
    }
    
    // Cancel booking
    public boolean cancelBooking(int bookingId, int userId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "UPDATE bookings SET status = 'cancelled' WHERE booking_id = ? AND user_id = ? AND status = 'pending'";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, bookingId);
            pstmt.setInt(2, userId);
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResources(null, pstmt, conn);
        }
    }
    
    // Helper method to close resources
    private void closeResources(ResultSet rs, PreparedStatement pstmt, Connection conn) {
        try { if (rs != null) rs.close(); } catch (SQLException e) {}
        try { if (pstmt != null) pstmt.close(); } catch (SQLException e) {}
        try { if (conn != null) conn.close(); } catch (SQLException e) {}
    }
}