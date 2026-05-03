<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ServiceHub | Professional Home Services</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        /* Exact Figma Color Palette via CSS Variables */
        :root {
            --brown: #49301E;
            --green: #2C362B;
            --beige: #F8F2E4;
            --text-gray: #666666;
            --white: #ffffff;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--beige);
            color: var(--brown);
            line-height: 1.6;
        }

        /* Navbar */
        nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1.2rem 5%;
            background-color: var(--brown);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .logo { font-weight: 800; font-size: 1.5rem; color: var(--white); }
        .logo i { margin-right: 8px; }

        .nav-links { list-style: none; display: flex; gap: 2rem; }
        .nav-links a { text-decoration: none; color: var(--white); font-weight: 500; font-size: 0.95rem; transition: opacity 0.3s; }
        .nav-links a:hover { opacity: 0.8; }

        .auth-group { display: flex; gap: 1.5rem; align-items: center; }
        .login-link { color: var(--white); text-decoration: none; font-weight: 600; }
        
        .btn { padding: 0.7rem 1.5rem; border-radius: 6px; text-decoration: none; font-weight: 600; transition: all 0.3s ease; display: inline-block;}
        .btn-green { background: var(--green); color: var(--white); }
        .btn-green:hover { background: #1a2019; }

        /* Hero Section */
        .hero {
            position: relative;
            padding: 120px 10%;
            text-align: center;
            background: linear-gradient(rgba(73, 48, 30, 0.8), rgba(73, 48, 30, 0.8)), url('https://images.unsplash.com/photo-1581578731548-c64695cc6952?q=80&w=2070') center/cover;
            color: var(--white);
        }

        .hero h1 { font-size: 3.5rem; font-weight: 800; line-height: 1.2; margin-bottom: 1.5rem; }
        .hero p { font-size: 1.1rem; margin-bottom: 2.5rem; opacity: 0.9; max-width: 700px; margin-left: auto; margin-right: auto; }

        .hero-btns { display: flex; justify-content: center; gap: 1rem; }
        .btn-beige { background: var(--beige); color: var(--brown); }
        .btn-beige:hover { background: #e8e0cc; }
        .btn-outline { background: transparent; color: var(--white); border: 2px solid var(--beige); }
        .btn-outline:hover { background: rgba(255,255,255,0.1); }

        /* Section Formatting */
        .section-header { text-align: center; margin-bottom: 3rem; }
        .section-header h2 { font-size: 2.2rem; color: var(--brown); margin-bottom: 0.5rem; }
        .section-header p { color: var(--text-gray); }

        /* Services Grid */
        .services-section { padding: 5rem 10%; }
        .grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 2rem; }
        
        .service-card {
            background: var(--white);
            padding: 2.5rem 2rem;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(73, 48, 30, 0.05);
            transition: transform 0.3s ease;
        }
        .service-card:hover { transform: translateY(-5px); }
        .service-card i { font-size: 2.5rem; color: var(--brown); margin-bottom: 1.5rem; }
        .service-card h3 { font-size: 1.3rem; margin-bottom: 1rem; }
        .service-card p { color: var(--text-gray); font-size: 0.95rem; margin-bottom: 1.5rem; }
        .service-card a { color: var(--brown); font-weight: 700; text-decoration: none; font-size: 0.9rem; }

        /* Why Choose Us */
        .why-us { background: var(--beige); padding: 5rem 10%; border-top: 1px solid #eae1ce; border-bottom: 1px solid #eae1ce; }
        .feature-item { text-align: center; }
        .feature-item i { font-size: 3rem; color: var(--brown); margin-bottom: 1.5rem; }
        .feature-item h4 { font-size: 1.2rem; margin-bottom: 0.8rem; }
        .feature-item p { color: var(--text-gray); font-size: 0.95rem; }

        /* CTA Section */
        .cta-section { padding: 5rem 10%; display: flex; justify-content: center; }
        .cta-box {
            background: var(--brown);
            color: var(--white);
            padding: 4rem;
            border-radius: 16px;
            text-align: center;
            width: 100%;
            max-width: 1000px;
        }
        .cta-box h2 { font-size: 2.5rem; margin-bottom: 1rem; }
        .cta-box p { font-size: 1.1rem; margin-bottom: 2.5rem; opacity: 0.9; }

        /* Footer */
        footer { background: var(--brown); color: var(--white); padding: 4rem 10% 2rem; }
        .footer-grid { display: grid; grid-template-columns: 2fr 1fr 1fr; gap: 3rem; border-bottom: 1px solid rgba(255,255,255,0.1); padding-bottom: 3rem; margin-bottom: 2rem; }
        .footer-col h3 { font-size: 1.2rem; margin-bottom: 1.5rem; color: var(--beige); }
        .footer-col p, .footer-col a { color: rgba(248, 242, 228, 0.7); text-decoration: none; display: block; margin-bottom: 0.8rem; font-size: 0.95rem; }
        .copyright { text-align: center; color: rgba(248, 242, 228, 0.5); font-size: 0.9rem; }
    </style>
</head>
<body>

    <nav>
        <div class="logo"><i class="fas fa-wrench"></i> ServiceHub</div>
        <ul class="nav-links">
            <li><a href="index.jsp">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/services">Services</a></li>
            <li><a href="#">About</a></li>
            <li><a href="#">Contact</a></li>
        </ul>
        <div class="auth-group">
            <a href="${pageContext.request.contextPath}/login" class="login-link">Login</a>
            <a href="${pageContext.request.contextPath}/register" class="btn btn-green">Register</a>
        </div>
    </nav>

    <main>
        <section class="hero">
            <h1>Professional Home Services at Your Doorstep</h1>
            <p>Book trusted professionals for plumbing, electrical, cleaning, and more. Quick, reliable, and affordable services.</p>
            <div class="hero-btns">
                <a href="${pageContext.request.contextPath}/services" class="btn btn-beige">Browse Services &rarr;</a>
                <a href="${pageContext.request.contextPath}/register" class="btn btn-outline">Get Started</a>
            </div>
        </section>

        <section class="services-section">
            <div class="section-header">
                <h2>Our Services</h2>
                <p>Professional services for all your home needs</p>
            </div>
            <div class="grid">
                <div class="service-card">
                    <i class="fas fa-tools"></i>
                    <h3>Plumbing</h3>
                    <p>Expert plumbing services for all your needs including leaks, clogs, and pipes.</p>
                    <a href="${pageContext.request.contextPath}/services">Learn More &rarr;</a>
                </div>
                <div class="service-card">
                    <i class="fas fa-bolt"></i>
                    <h3>Electrical</h3>
                    <p>Licensed electricians for safe installations, wiring, and appliance repair.</p>
                    <a href="${pageContext.request.contextPath}/services">Learn More &rarr;</a>
                </div>
                <div class="service-card">
                    <i class="fas fa-paint-roller"></i>
                    <h3>Painting</h3>
                    <p>Professional interior and exterior painting and decoration services.</p>
                    <a href="${pageContext.request.contextPath}/services">Learn More &rarr;</a>
                </div>
                <div class="service-card">
                    <i class="fas fa-broom"></i>
                    <h3>Cleaning</h3>
                    <p>Deep cleaning and maintenance services for your entire home.</p>
                    <a href="${pageContext.request.contextPath}/services">Learn More &rarr;</a>
                </div>
                <div class="service-card">
                    <i class="fas fa-fan"></i>
                    <h3>AC Repair</h3>
                    <p>Air conditioning servicing, repair, and regular maintenance.</p>
                    <a href="${pageContext.request.contextPath}/services">Learn More &rarr;</a>
                </div>
                <div class="service-card">
                    <i class="fas fa-hammer"></i>
                    <h3>Carpentry</h3>
                    <p>Custom furniture, woodwork solutions, and general carpentry repairs.</p>
                    <a href="${pageContext.request.contextPath}/services">Learn More &rarr;</a>
                </div>
            </div>
        </section>

        <section class="why-us">
            <div class="section-header">
                <h2>Why Choose Us</h2>
                <p>Trusted by thousands of customers</p>
            </div>
            <div class="grid">
                <div class="feature-item">
                    <i class="fas fa-user-check"></i>
                    <h4>Verified Professionals</h4>
                    <p>All service providers are verified and thoroughly background-checked.</p>
                </div>
                <div class="feature-item">
                    <i class="fas fa-star"></i>
                    <h4>Quality Service</h4>
                    <p>Top-rated professionals with excellent customer reviews and ratings.</p>
                </div>
                <div class="feature-item">
                    <i class="fas fa-th-large"></i>
                    <h4>Wide Range</h4>
                    <p>Access to various home service categories all in one single platform.</p>
                </div>
            </div>
        </section>

        <section class="cta-section">
            <div class="cta-box">
                <h2>Ready to Get Started?</h2>
                <p>Join thousands of satisfied customers who trust our platform.</p>
                <a href="${pageContext.request.contextPath}/register" class="btn btn-beige">Create Account</a>
            </div>
        </section>
    </main>

    <footer>
        <div class="footer-grid">
            <div class="footer-col">
                <h3><i class="fas fa-wrench"></i> ServiceHub</h3>
                <p style="max-width: 300px;">Your trusted platform for quality home services. Book professional service providers with ease.</p>
            </div>
            <div class="footer-col">
                <h3>Quick Links</h3>
                <a href="${pageContext.request.contextPath}/services">Services</a>
                <a href="#">About Us</a>
                <a href="#">Contact</a>
            </div>
            <div class="footer-col">
                <h3>Contact Info</h3>
                <p><i class="far fa-envelope"></i> info@servicehub.com</p>
                <p><i class="fas fa-phone-alt"></i> +977 9841234567</p>
                <p><i class="fas fa-map-marker-alt"></i> Kathmandu, Nepal</p>
            </div>
        </div>
        <div class="copyright">
            &copy; 2026 ServiceHub. All rights reserved.
        </div>
    </footer>

</body>
</html>