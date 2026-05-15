<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false"%>

<style>
:root {
    --brown: #49301E;
    --green: #2C362B;
    --beige: #F8F2E4;
    --white: #ffffff;
}

.navbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 1.2rem 5%;
    background-color: var(--brown);
    color: var(--white);
}

.logo {
    font-weight: 800;
    font-size: 1.4rem;
}

.nav-links {
    list-style: none;
    display: flex;
    gap: 2rem;
}

.nav-links a {
    text-decoration: none;
    color: var(--white);
    font-weight: 500;
}

.nav-right {
    display: flex;
    align-items: center;
    gap: 15px;
}

.nav-right i {
    cursor: pointer;
    font-size: 16px;
}

.btn {
    background: var(--green);
    padding: 6px 12px;
    border-radius: 5px;
    color: white;
    text-decoration: none;
}
</style>

<nav class="navbar">

    <!-- LOGO -->
    <div class="logo">
        <i class="fas fa-wrench"></i> ServiceHub
    </div>

    <!-- NAV LINKS -->
    <ul class="nav-links">
        <li><a href="<%= request.getContextPath() %>/">Home</a></li>
        <li><a href="<%= request.getContextPath() %>/services">Services</a></li>
        <li><a href="#">About</a></li>

        <%
            Object userObj = session.getAttribute("user");

            if (userObj != null) {
                com.service_hub.model.UserModel u = (com.service_hub.model.UserModel) userObj;

                if ("admin".equalsIgnoreCase(u.getRole())) {
        %>
                    <li><a href="<%= request.getContextPath() %>/admin">Dashboard</a></li>
        <%
                } else {
        %>
                    <li><a href="<%= request.getContextPath() %>/dashboard">Dashboard</a></li>
        <%
                }
            }
        %>
    </ul>

    <!-- RIGHT SIDE -->
    <div class="nav-right">

        <%
            if (userObj == null) {
        %>

            <!-- BEFORE LOGIN -->
            <a href="<%= request.getContextPath() %>/login" style="color:white;">Login</a>
            <a href="<%= request.getContextPath() %>/register" class="btn">Register</a>

        <%
            } else {
                com.service_hub.model.UserModel u = (com.service_hub.model.UserModel) userObj;
        %>

            <!-- SEARCH + NOTIFICATION -->
            <i class="fas fa-search"></i>
            <i class="fas fa-bell"></i>

            <!-- USER NAME (CLICKABLE) -->
            <a href="<%= request.getContextPath() %>/<%= 
                "admin".equalsIgnoreCase(u.getRole()) ? "admin" : "dashboard" %>" 
               style="color:white; text-decoration:none;">
               
               <i class="fas fa-user"></i> <%= u.getFullName() %>
            </a>

            <!-- LOGOUT BUTTON -->
            <a href="<%= request.getContextPath() %>/logout" class="btn">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>

        <%
            }
        %>

    </div>

</nav>