package com.service_hub.model;

public class BookingModel {
    private int bookingId;
    private int userId;
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

    private String userName;
    private String userEmail;
    private String userPhone;
    private int technicianId;

    // Getters and Setters
    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public String getUserEmail() { return userEmail; }
    public void setUserEmail(String userEmail) { this.userEmail = userEmail; }

    public String getUserPhone() { return userPhone; }
    public void setUserPhone(String userPhone) { this.userPhone = userPhone; }

    public int getTechnicianId() { return technicianId; }
    public void setTechnicianId(int technicianId) { this.technicianId = technicianId; }
    // Getters
    public int getBookingId() { return bookingId; }
    public int getUserId() { return userId; }
    public String getServiceName() { return serviceName; }
    public double getServicePrice() { return servicePrice; }
    public String getCustomerName() { return customerName; }
    public String getCustomerPhone() { return customerPhone; }
    public String getPreferredDate() { return preferredDate; }
    public String getPreferredTime() { return preferredTime; }
    public String getServiceAddress() { return serviceAddress; }
    public String getAdditionalNotes() { return additionalNotes; }
    public String getStatus() { return status; }
    public String getPaymentStatus() { return paymentStatus; }
    public String getBookingDate() { return bookingDate; }
    
    // Setters
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }
    public void setUserId(int userId) { this.userId = userId; }
    public void setServiceName(String serviceName) { this.serviceName = serviceName; }
    public void setServicePrice(double servicePrice) { this.servicePrice = servicePrice; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }
    public void setCustomerPhone(String customerPhone) { this.customerPhone = customerPhone; }
    public void setPreferredDate(String preferredDate) { this.preferredDate = preferredDate; }
    public void setPreferredTime(String preferredTime) { this.preferredTime = preferredTime; }
    public void setServiceAddress(String serviceAddress) { this.serviceAddress = serviceAddress; }
    public void setAdditionalNotes(String additionalNotes) { this.additionalNotes = additionalNotes; }
    public void setStatus(String status) { this.status = status; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }
    public void setBookingDate(String bookingDate) { this.bookingDate = bookingDate; }
}
