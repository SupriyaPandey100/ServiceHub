package com.service_hub.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/about")
public class AboutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        // --- NEW LOGIC START ---
        // If the button is clicked, this will trigger a redirect to the Services page
        if ("browse".equals(action)) {
            // Redirect to your ServiceServlet (check if your mapping is /service or /services)
            response.sendRedirect(request.getContextPath() + "/services");
            return; // Stop further execution to prevent forwarding to about.jsp
        }
        // --- NEW LOGIC END ---

        if (action != null) {
            request.setAttribute("infoMessage", "You clicked: " + action);
        }

        // Standard forward to the About page
        request.getRequestDispatcher("/WEB-INF/pages/about.jsp")
               .forward(request, response);
    }
}
