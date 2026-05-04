package com.service_hub.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

@WebServlet("/services")
public class ServiceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public static class Service {
        private String name, category, duration, description, imageUrl;
        private int price, reviews;
        private double rating;
        
        public Service(String name, String category, int price, double rating, 
                      int reviews, String duration, String description, String imageUrl) {
            this.name = name;
            this.category = category;
            this.price = price;
            this.rating = rating;
            this.reviews = reviews;
            this.duration = duration;
            this.description = description;
            this.imageUrl = imageUrl;
        }
        
        public String getName() { return name; }
        public String getCategory() { return category; }
        public int getPrice() { return price; }
        public double getRating() { return rating; }
        public int getReviews() { return reviews; }
        public String getDuration() { return duration; }
        public String getDescription() { return description; }
        public String getImageUrl() { return imageUrl; }
    }
    
    private List<Service> getAllServices() {
        List<Service> services = new ArrayList<>();
        
        services.add(new Service("Plumbing Repairs", "Plumbing", 1500, 4.8, 156, "2 hours", 
            "Professional plumbing repair services for leaks, clogs, and pipes", 
            "images/plumbing.jpg"));
            
        services.add(new Service("Electrical Installation", "Electrical", 2000, 4.9, 208, "3 hours", 
            "Licensed electricians for wiring and installations", 
            "images/electrical.jpg"));
            
        services.add(new Service("House Painting", "Painting", 5000, 4.8, 199, "1 day", 
            "Interior and exterior painting with premium quality paints", 
            "images/painting.jpg"));
            
        services.add(new Service("Deep Cleaning", "Cleaning", 3000, 4.7, 122, "4 hours", 
            "Complete deep cleaning for your home", 
            "images/cleaning.jpg"));
            
        services.add(new Service("AC Service & Repair", "AC Repair", 1800, 4.9, 187, "2 hours", 
            "Air conditioner servicing and maintenance", 
            "images/ac-repair.jpg"));
            
        services.add(new Service("Custom Carpentry", "Carpentry", 4000, 4.8, 145, "1 day", 
            "Custom furniture and woodwork solutions", 
            "images/carpentry.jpg"));
            
        services.add(new Service("Kitchen Plumbing", "Plumbing", 1800, 4.7, 111, "2 hours", 
            "Sink and kitchen plumbing services", 
            "images/kitchen-plumbing.jpg"));
            
        services.add(new Service("Appliance Repair", "Electrical", 1200, 4.8, 124, "1 hour", 
            "Repair services for home appliances", 
            "images/appliance-repair.jpg"));
            
        return services;
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String categoryFilter = request.getParameter("category");
        String searchQuery = request.getParameter("search");
        
        List<Service> allServices = getAllServices();
        List<Service> filteredServices = allServices;
        
        // Apply category filter
        if (categoryFilter != null && !categoryFilter.isEmpty() && !categoryFilter.equals("all")) {
            filteredServices = allServices.stream()
                .filter(service -> service.getCategory().equalsIgnoreCase(categoryFilter))
                .collect(Collectors.toList());
        }
        
        // Apply search filter
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            String searchLower = searchQuery.toLowerCase().trim();
            filteredServices = filteredServices.stream()
                .filter(service -> 
                    service.getName().toLowerCase().contains(searchLower) ||
                    service.getDescription().toLowerCase().contains(searchLower) ||
                    service.getCategory().toLowerCase().contains(searchLower))
                .collect(Collectors.toList());
        }
        
        // Set attributes for JSP
        request.setAttribute("services", filteredServices);
        request.setAttribute("selectedCategory", categoryFilter != null ? categoryFilter : "all");
        request.setAttribute("searchQuery", searchQuery != null ? searchQuery : "");
        
        // Forward to JSP
        request.getRequestDispatcher("/WEB-INF/pages/service.jsp").forward(request, response);
    }
}