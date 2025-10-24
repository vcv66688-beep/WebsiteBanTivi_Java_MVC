<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@include file="header.jsp"%>
<html>
<head>
    <title>TV Store - Công Nghệ Hiện Đại Trong Tầm Tay</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="css/style.css" rel="stylesheet">
    <meta http-equiv="cache-control" content="max-age=3600">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --dark-gradient: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            --text-primary: #2d3748;
            --text-secondary: #718096;
            --surface-white: #ffffff;
            --surface-light: #f7fafc;
            --shadow-soft: 0 10px 25px -5px rgba(0, 0, 0, 0.1);
            --shadow-medium: 0 20px 40px -10px rgba(0, 0, 0, 0.15);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            line-height: 1.6;
            color: var(--text-primary);
            background: var(--surface-light);
        }

        /* Hero Carousel Styles */
        .hero-carousel {
            position: relative;
            height: 70vh;
            min-height: 500px;
            overflow: hidden;
            border-radius: 0 0 40px 40px;
        }

        .carousel-item {
            height: 70vh;
            min-height: 500px;
            position: relative;
        }

        .carousel-item::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(45deg, rgba(0,0,0,0.4), rgba(0,0,0,0.2));
            z-index: 1;
        }

        .carousel-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            filter: brightness(0.8) contrast(1.1);
        }

        .carousel-caption {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 2;
            text-align: center;
            max-width: 600px;
            padding: 2rem;
        }

        .carousel-caption h5 {
            font-family: 'Playfair Display', serif;
            font-size: 3.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
            color: white;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
            animation: slideInUp 0.8s ease-out;
        }

        .carousel-caption p {
            font-size: 1.3rem;
            margin-bottom: 2rem;
            color: rgba(255,255,255,0.95);
            text-shadow: 1px 1px 2px rgba(0,0,0,0.3);
            animation: slideInUp 0.8s ease-out 0.2s both;
        }

        .btn-hero {
            background: var(--primary-gradient);
            border: none;
            padding: 15px 40px;
            font-size: 1.1rem;
            font-weight: 600;
            border-radius: 50px;
            color: white;
            text-decoration: none;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-soft);
            animation: slideInUp 0.8s ease-out 0.4s both;
        }

        .btn-hero:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-medium);
            color: white;
        }

        /* Carousel Controls */
        .carousel-control-prev,
        .carousel-control-next {
            width: 60px;
            height: 60px;
            top: 50%;
            transform: translateY(-50%);
            background: rgba(255,255,255,0.1);
            backdrop-filter: blur(10px);
            border-radius: 50%;
            border: 1px solid rgba(255,255,255,0.2);
            transition: all 0.3s ease;
        }

        .carousel-control-prev:hover,
        .carousel-control-next:hover {
            background: rgba(255,255,255,0.2);
            transform: translateY(-50%) scale(1.1);
        }

        .carousel-control-prev {
            left: 30px;
        }

        .carousel-control-next {
            right: 30px;
        }

        /* Welcome Section */
        .welcome-section {
            padding: 100px 0;
            background: var(--surface-white);
            position: relative;
        }

        .welcome-section::before {
            content: '';
            position: absolute;
            top: -50px;
            left: 0;
            right: 0;
            height: 100px;
            background: var(--surface-light);
            clip-path: ellipse(100% 100% at 50% 0%);
        }

        .section-title {
            font-family: 'Playfair Display', serif;
            font-size: 3.2rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            text-align: center;
        }

        .section-subtitle {
            font-size: 1.3rem;
            color: var(--text-secondary);
            margin-bottom: 3rem;
            text-align: center;
            max-width: 700px;
            margin-left: auto;
            margin-right: auto;
        }

        /* Features Grid */
        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin: 4rem 0;
        }

        .feature-card {
            background: var(--surface-white);
            padding: 2.5rem;
            border-radius: 20px;
            text-align: center;
            box-shadow: var(--shadow-soft);
            transition: all 0.3s ease;
            border: 1px solid rgba(0,0,0,0.05);
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow-medium);
        }

        .feature-icon {
            width: 80px;
            height: 80px;
            margin: 0 auto 1.5rem;
            background: var(--primary-gradient);
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            color: white;
        }

        .feature-title {
            font-size: 1.4rem;
            font-weight: 600;
            margin-bottom: 1rem;
            color: var(--text-primary);
        }

        .feature-description {
            color: var(--text-secondary);
            line-height: 1.6;
        }

        /* CTA Section */
        .cta-section {
            background: var(--dark-gradient);
            padding: 80px 0;
            color: white;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .cta-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="white" opacity="0.05"/><circle cx="75" cy="75" r="1" fill="white" opacity="0.05"/><circle cx="50" cy="10" r="1" fill="white" opacity="0.03"/><circle cx="20" cy="60" r="1" fill="white" opacity="0.04"/><circle cx="80" cy="30" r="1" fill="white" opacity="0.06"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
        }

        .cta-title {
            font-family: 'Playfair Display', serif;
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
            position: relative;
            z-index: 1;
        }

        .cta-subtitle {
            font-size: 1.2rem;
            margin-bottom: 2rem;
            opacity: 0.9;
            position: relative;
            z-index: 1;
        }

        .btn-cta {
            background: var(--secondary-gradient);
            border: none;
            padding: 18px 50px;
            font-size: 1.2rem;
            font-weight: 600;
            border-radius: 50px;
            color: white;
            text-decoration: none;
            transition: all 0.3s ease;
            box-shadow: 0 15px 30px -10px rgba(0,0,0,0.3);
            position: relative;
            z-index: 1;
        }

        .btn-cta:hover {
            transform: translateY(-3px);
            box-shadow: 0 20px 40px -10px rgba(0,0,0,0.4);
            color: white;
        }

        /* Animations */
        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeInScale {
            from {
                opacity: 0;
                transform: scale(0.9);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        .animate-on-scroll {
            opacity: 0;
            transform: translateY(30px);
            transition: all 0.6s ease;
        }

        .animate-on-scroll.visible {
            opacity: 1;
            transform: translateY(0);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .hero-carousel {
                height: 60vh;
                min-height: 400px;
                border-radius: 0 0 20px 20px;
            }

            .carousel-item {
                height: 60vh;
                min-height: 400px;
            }

            .carousel-caption {
                padding: 1rem;
            }

            .carousel-caption h5 {
                font-size: 2.5rem;
            }

            .carousel-caption p {
                font-size: 1.1rem;
            }

            .section-title {
                font-size: 2.5rem;
            }

            .section-subtitle {
                font-size: 1.1rem;
            }

            .welcome-section {
                padding: 60px 0;
            }

            .features-grid {
                grid-template-columns: 1fr;
                margin: 2rem 0;
            }

            .feature-card {
                padding: 2rem;
            }

            .cta-section {
                padding: 60px 0;
            }

            .cta-title {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
    <!-- Hero Carousel -->
    <div id="heroCarousel" class="carousel slide hero-carousel" data-bs-ride="carousel" data-bs-interval="5000">
        <div class="carousel-indicators">
            <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="0" class="active"></button>
            <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="1"></button>
            <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="2"></button>
        </div>
        
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="images/Apple-iPhone-15-Pro-1024x576.jpg" class="d-block w-100" alt="iPhone 15 Pro">
                <div class="carousel-caption">
                    <h5>iPhone 15 Pro</h5>
                    <p>Trải nghiệm công nghệ titanium đẳng cấp với chip A17 Pro mạnh mẽ</p>
                    <a href="products" class="btn btn-hero">
                        <i class="fas fa-shopping-bag me-2"></i>Khám Phá Ngay
                    </a>
                </div>
            </div>
            
            <div class="carousel-item">
                <img src="images/Apple-iPhone-15-Pro-1024x576.jpg" class="d-block w-100" alt="TV Collection">
                <div class="carousel-caption">
                    <h5>Smart TV 4K</h5>
                    <p>Thế giới giải trí không giới hạn với chất lượng hình ảnh đỉnh cao</p>
                    <a href="products" class="btn btn-hero">
                        <i class="fas fa-tv me-2"></i>Xem Bộ Sưu Tập
                    </a>
                </div>
            </div>
            
            <div class="carousel-item">
                <img src="images/Apple-iPhone-15-Pro-1024x576.jpg" class="d-block w-100" alt="Special Offers">
                <div class="carousel-caption">
                    <h5>Ưu Đãi Đặc Biệt</h5>
                    <p>Giảm giá lên đến 30% cho tất cả sản phẩm trong tháng này</p>
                    <a href="products" class="btn btn-hero">
                        <i class="fas fa-percent me-2"></i>Mua Ngay
                    </a>
                </div>
            </div>
        </div>
        
        <button class="carousel-control-prev" type="button" data-bs-target="#heroCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#heroCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>

    <!-- Welcome Section -->
    <section class="welcome-section">
        <div class="container">
            <div class="animate-on-scroll">
                <h1 class="section-title">Chào Mừng Đến NVT Store</h1>
                <p class="section-subtitle">
                    Nơi hội tụ những công nghệ tiên tiến nhất trong lĩnh vực Ti Vi. 
                    Chúng tôi mang đến cho bạn trải nghiệm mua sắm đẳng cấp với sản phẩm chính hãng và dịch vụ hoàn hảo.
                </p>
            </div>

            <!-- Features Grid -->
            <div class="features-grid animate-on-scroll">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                    <h3 class="feature-title">Chính Hãng 100%</h3>
                    <p class="feature-description">
                        Tất cả sản phẩm đều được nhập khẩu chính hãng với đầy đủ giấy tờ và bảo hành toàn cầu
                    </p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-truck-fast"></i>
                    </div>
                    <h3 class="feature-title">Giao Hàng Nhanh</h3>
                    <p class="feature-description">
                        Miễn phí giao hàng toàn quốc trong 24h với đội ngũ vận chuyển chuyên nghiệp
                    </p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-headset"></i>
                    </div>
                    <h3 class="feature-title">Hỗ Trợ 24/7</h3>
                    <p class="feature-description">
                        Đội ngũ tư vấn chuyên nghiệp sẵn sàng hỗ trợ bạn mọi lúc, mọi nơi
                    </p>
                </div>
            </div>
        </div>
    </section>

    <!-- Call to Action Section -->
    <section class="cta-section">
        <div class="container">
            <div class="animate-on-scroll">
                <h2 class="cta-title">Sẵn Sàng Khám Phá?</h2>
                <p class="cta-subtitle">Hãy bắt đầu hành trình trải nghiệm công nghệ đỉnh cao cùng chúng tôi</p>
                <a href="products" class="btn btn-cta">
                    <i class="fas fa-rocket me-2"></i>Khám Phá Sản Phẩm
                </a>
            </div>
        </div>
    </section>

    <!-- JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Animate on scroll
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('visible');
                }
            });
        }, observerOptions);

        document.querySelectorAll('.animate-on-scroll').forEach(el => {
            observer.observe(el);
        });

        // Smooth scrolling for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });

        // Enhanced carousel auto-play with pause on hover
        const carousel = document.querySelector('#heroCarousel');
        const bsCarousel = new bootstrap.Carousel(carousel);
        
        carousel.addEventListener('mouseenter', () => {
            bsCarousel.pause();
        });
        
        carousel.addEventListener('mouseleave', () => {
            bsCarousel.cycle();
        });
    </script>

    <%@include file="footer.jsp"%>
</body>
</html>