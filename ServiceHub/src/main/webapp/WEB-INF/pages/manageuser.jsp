<%@ page import="java.util.*,com.service_hub.model.UserModel" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
List<UserModel> users = (List<UserModel>) request.getAttribute("users");

int pending = 0;
if(users != null){
    for(UserModel u : users){
        if("pending".equals(u.getStatus())) pending++;
    }
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Users | ServiceHub</title>

<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
:root {
    --brown: #49301E;
    --green: #2C362B;
    --beige: #F8F2E4;
    --text-gray: #666;
    --white: #fff;
}

*{margin:0;padding:0;box-sizing:border-box;}

body{
    font-family:'Plus Jakarta Sans',sans-serif;
    background:var(--beige);
    color:var(--brown);
}



/* MAIN */
.container{
    padding:30px 5%;
}

h1{font-size:26px;}
p{color:var(--text-gray); margin-bottom:20px;}

/* TABLE */
table{
    width:100%;
    background:white;
    border-radius:10px;
    border-collapse:collapse;
    overflow:hidden;
}

th,td{
    padding:15px;
}

th{
    background:#f2ece2;
}

tr{
    border-bottom:1px solid #eee;
}

/* STATUS */
.status{
    padding:5px 10px;
    border-radius:20px;
    font-size:12px;
}

.pending{background:#f4d35e;}
.approved{background:#2C362B;color:white;}
.rejected{background:#d9534f;color:white;}

/* BUTTONS */
button{
    border:none;
    padding:5px 10px;
    margin:2px;
    border-radius:5px;
    cursor:pointer;
}

.approve{background:green;color:white;}
.reject{background:red;color:white;}

/* MESSAGE */
.message{
    margin-top:15px;
    padding:10px;
    background:#fff3cd;
    border:1px solid #e6c98f;
    border-radius:6px;
}

/* FOOTER */
footer{
    background:var(--brown);
    color:white;
    padding:4rem 10% 2rem;
    margin-top:40px;
}

.footer-grid{
    display:grid;
    grid-template-columns:2fr 1fr 1fr;
    gap:3rem;
    border-bottom:1px solid rgba(255,255,255,0.1);
    padding-bottom:2rem;
    margin-bottom:2rem;
}

.footer-col h3{
    color:#F8F2E4;
    margin-bottom:1rem;
}

.footer-col p, .footer-col a{
    color:rgba(248,242,228,0.7);
    font-size:14px;
    display:block;
    margin-bottom:8px;
    text-decoration:none;
}

.copyright{
    text-align:center;
    color:rgba(248,242,228,0.5);
}
</style>
</head>

<body>

<jsp:include page="/components/header.jsp" />

<!-- MAIN -->
<div class="container">

    <h1>Manage Users</h1>
    <p>Approve, reject, or remove users</p>

    <table>
        <tr>
            <th>Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>

        <%
        if(users != null){
            for(UserModel u : users){
        %>

        <tr>
            <td><%= u.getFullName() %></td>
            <td><%= u.getEmail() %></td>
            <td><%= u.getNumber() %></td>

            <td>
                <span class="status <%=u.getStatus()%>">
                    <%=u.getStatus()%>
                </span>
            </td>

            <td>

                <% if("pending".equals(u.getStatus())){ %>

                <form method="post" action="manageuser">
                    <input type="hidden" name="id" value="<%=u.getUserId()%>">

                    <button name="action" value="approve" class="approve">✔</button>
                    <button name="action" value="reject" class="reject">✖</button>
                </form>

                <% } %>

            </td>
        </tr>

        <%
            }
        }
        %>

    </table>

    <div class="message">
        <%= pending %> user registration(s) pending approval
    </div>

</div>

<!-- FOOTER -->
<footer>
    <div class="footer-grid">

        <div class="footer-col">
            <h3><i class="fas fa-wrench"></i> ServiceHub</h3>
            <p>Your trusted platform for quality home services.</p>
        </div>

        <div class="footer-col">
            <h3>Quick Links</h3>
            <a href="#">Services</a>
            <a href="#">About Us</a>
            <a href="#">Contact</a>
        </div>

        <div class="footer-col">
            <h3>Contact Info</h3>
            <p>info@servicehub.com</p>
            <p>+977 9841234567</p>
            <p>Kathmandu, Nepal</p>
        </div>

    </div>

    <div class="copyright">
        © 2026 ServiceHub. All rights reserved.
    </div>
</footer>

</body>
</html>