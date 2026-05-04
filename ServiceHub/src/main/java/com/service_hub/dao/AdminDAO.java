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

public class AdminDAO {
    
    // Get all bookings with user details
    public List<BookingModel> getAllBookings(String filter) {
        List<BookingModel> bookings = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql;
            
            if ("all".equals(filter)) {
                sql = "SELECT b.*, u.full_name as user_name, u.email as user_email, u.phone as user_phone " +
                      "FROM bookings b LEFT JOIN users u ON b.user_id = u.user_id " +
                      "ORDER BY b.booking_id DESC";
                pstmt = conn.prepareStatement(sql);
            } else {
                sql = "SELECT b.*, u.full_name as user_name, u.email as user_email, u.phone as user_phone " +
                      "FROM bookings b LEFT JOIN users u ON b.user_id = u.user_id " +
                      "WHERE b.status = ? ORDER BY b.booking_id DESC";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, filter);
            }
            
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                BookingModel booking = new BookingModel();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setUserId(rs.getInt("user_id"));
                booking.setUserName(rs.getString("user_name"));
                booking.setUserEmail(rs.getString("user_email"));
                booking.setUserPhone(rs.getString("user_phone"));
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
                booking.setTechnicianId(rs.getInt("technician_id"));
                bookings.add(booking);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, pstmt, conn);
        }
        
        return bookings;
    }
    
    // Get booking counts by status
    public Map<String, Integer> getBookingCounts() {
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
            
            String sql = "SELECT status, COUNT(*) as count FROM bookings GROUP BY status";
            pstmt = conn.prepareStatement(sql);
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
    
    // Get dashboard statistics
    public Map<String, Object> getDashboardStatistics() {
        Map<String, Object> stats = new HashMap<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            
            // Total services
            String sql = "SELECT COUNT(*) as count FROM services";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if (rs.next()) stats.put("totalServices", rs.getInt("count"));
            rs.close();
            pstmt.close();
            
            // Total technicians
            sql = "SELECT COUNT(*) as count FROM technicians";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if (rs.next()) stats.put("totalTechnicians", rs.getInt("count"));
            rs.close();
            pstmt.close();
            
            // Total bookings
            sql = "SELECT COUNT(*) as count FROM bookings";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if (rs.next()) stats.put("totalBookings", rs.getInt("count"));
            rs.close();
            pstmt.close();
            
            // Pending bookings
            sql = "SELECT COUNT(*) as count FROM bookings WHERE status = 'pending'";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if (rs.next()) stats.put("pendingBookings", rs.getInt("count"));
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, pstmt, conn);
        }
        
        return stats;
    }
    
    // Update booking status
    public boolean updateBookingStatus(int bookingId, String status) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "UPDATE bookings SET status = ? WHERE booking_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, status);
            pstmt.setInt(2, bookingId);
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResources(null, pstmt, conn);
        }
    }
    
    // Assign technician to booking
    public boolean assignTechnician(int bookingId, int technicianId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "UPDATE bookings SET technician_id = ?, status = 'confirmed' WHERE booking_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, technicianId);
            pstmt.setInt(2, bookingId);
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResources(null, pstmt, conn);
        }
    }
    
    // Get all technicians
    public List<Map<String, Object>> getAllTechnicians() {
        List<Map<String, Object>> technicians = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT technician_id, technician_name, specialty, phone FROM technicians WHERE is_available = true";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> tech = new HashMap<>();
                tech.put("id", rs.getInt("technician_id"));
                tech.put("name", rs.getString("technician_name"));
                tech.put("specialty", rs.getString("specialty"));
                tech.put("phone", rs.getString("phone"));
                technicians.add(tech);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, pstmt, conn);
        }
        
        return technicians;
    }
    
    // Helper method to close resources
    private void closeResources(ResultSet rs, PreparedStatement pstmt, Connection conn) {
        try { if (rs != null) rs.close(); } catch (SQLException e) {}
        try { if (pstmt != null) pstmt.close(); } catch (SQLException e) {}
        try { if (conn != null) conn.close(); } catch (SQLException e) {}
    }
}