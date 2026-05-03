package com.service_hub.service;

import java.util.ArrayList;
import java.util.List;
import com.service_hub.model.UserModel;

/**
 * ListService handles bulk data retrieval for dashboards and grids.
 */
public class ListService {
    
    /**
     * Placeholder method for fetching all users.
     * This will be used in the Admin Dashboard to "Manage Users".
     */
    public List<UserModel> fetchAllUsers() throws Exception {
        // In the future, this will call a UserDAO method like dao.getAllUsers()
        return new ArrayList<>(); 
    }
    
    // Future Note: You will add public List<ServiceModel> fetchAllServices() here
    // to dynamically populate the "Our Services" grid on your home.jsp page.
}