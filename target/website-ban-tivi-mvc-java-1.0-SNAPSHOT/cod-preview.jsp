<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@include file="header.jsp"%>
<html>
<head>
    <title>Xác Nhận Thanh Toán COD</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="css/style.css?ver=<%= System.currentTimeMillis() %>" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #e0eafc, #cfdef3);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            margin: 0;
        }
        .preview-container {
            background: #fff;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.15);
            max-width: 1100px;
            margin: 20px auto;
            flex-grow: 1;
        }
        .preview-title {
            color: #007bff;
            font-weight: 600;
            text-align: center;
            margin-top: 10px;
            margin-bottom: 10px;
        }
        .order-summary {
            margin-bottom: 15px;
            margin-top: 10px;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }
        .order-summary .summary-left ul,
        .order-summary .summary-right ul {
            list-style-type: none;
            padding-left: 0;
        }
        .order-summary ul li {
            margin: 8px 0;
        }
        .order-summary ul li::before {
            content: "•";
            color: #007bff;
            font-weight: bold;
            display: inline-block;
            width: 1em;
            margin-left: -1em;
        }
        .order-summary .billing-info ul li {
            padding-left: 0;
        }
        .order-summary .billing-info ul li::before {
            content: none;
        }
        .product-details {
            margin-bottom: 15px;
            margin-top: 10px;
        }
        .order-details {
            display: flex;
            align-items: center;
            padding: 12px;
            background: #f8f9fa;
            border-radius: 10px;
            margin-bottom: 8px;
            margin-top: 10px;
        }
        .order-details .product-img {
            width: auto;
            height: 60px;
            object-fit: cover;
            margin-right: 15px;
            margin-top: 10px;
            margin-bottom: 10px;
        }
        .order-details .details {
            flex-grow: 1;
        }
        .order-details .price {
            font-weight: bold;
            color: #dc3545;
            margin-left: auto;
        }
        .btn-confirm {
            background: linear-gradient(45deg, #007bff, #0056b3);
            color: white;
            font-weight: bold;
            border-radius: 25px;
            padding: 12px 30px;
            transition: all 0.3s ease;
            margin-top: 10px;
            margin-bottom: 10px;
            text-decoration: none;
        }
        .btn-back {
            background: linear-gradient(45deg, #28a745, #218838);
            color: white;
            font-weight: bold;
            border-radius: 25px;
            padding: 12px 30px;
            transition: all 0.3s ease;
            margin-top: 10px;
            margin-bottom: 10px;
            text-decoration: none;
        }
        .btn-confirm:hover, .btn-back:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.4);
            text-decoration: none;
            color: #FFD700;
        }
        .alert-info {
            border-radius: 10px;
            padding: 15px;
            background: #e7f1ff;
            color: #004085;
            margin-top: 10px;
            margin-bottom: 10px;
        }
        .alert-danger {
            border-radius: 10px;
            padding: 15px;
            margin-top: 10px;
            margin-bottom: 10px;
        }
        h4 {
            margin-top: 10px;
            margin-bottom: 10px;
        }
        .product-img:hover {
            transform: scale(1.1);
        }
        .text-center .btn {
            margin: 0 7px; 
        }

    </style>
</head>
<body>
    <div class="container preview-container">
        <div class="confirmation-header">
            <h1 class="preview-title"><i class="fa-solid fa-check-circle me-2"></i>Xác Nhận Đơn Hàng COD</h1>
        </div>
        <c:if test="${not empty error}">
            <div class="alert alert-danger text-center">${error}</div>
        </c:if>
        <div class="order-summary card p-3">
            <div class="summary-left">
                <ul>
                    <li><strong>Phương thức thanh toán:</strong> COD</li>
                    <li><strong>Tổng tiền:</strong> <fmt:formatNumber value="${pendingOrder.totalAmount}" pattern="#,##0" /> VND</li>
                    <li><strong>Địa chỉ giao hàng:</strong> ${pendingOrder.address}</li>
                </ul>
            </div>
            <div class="summary-right">
                <div class="billing-info">
                    <p><strong>Thông tin thanh toán:</strong></p>
                    <ul>
                        <li>Tên: ${pendingOrder.billingName}</li>
                        <li>Số điện thoại: ${pendingOrder.billingPhone}</li>
                        <li>Email: ${pendingOrder.billingEmail}</li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="product-details card p-3">
            <h4 class="mb-3">Chi tiết đơn hàng</h4>
            <c:forEach var="item" items="${pendingOrder.cartItems}">
                <div class="order-details">
                    <img src="images/${item.product.image}" alt="${item.product.name}" class="product-img">
                    <div class="details">
                        <div>${item.product.name}</div>
                        <div>Số lượng: ${item.quantity}</div>
                    </div>
                    <div class="price">
                        <fmt:formatNumber value="${item.product.price * item.quantity}" pattern="#,##0" /> VND
                    </div>
                </div>
            </c:forEach>
        </div>
        <div class="alert alert-info">
            <strong>Thanh Toán COD:</strong> Vui lòng chuẩn bị số tiền <strong><fmt:formatNumber value="${pendingOrder.totalAmount}" pattern="#,##0" /> VND</strong> để thanh toán cho shipper khi nhận hàng.
        </div>
        <form action="cod-confirm" method="post">
            <div class="text-center mt-3">
                <a href="checkout" class="btn btn-back btn-lg"><i class="fas fa-arrow-left"></i> Quay Lại Thông Tin </a>
                <button type="submit" class="btn btn-confirm btn-lg"><i class="fas fa-check"></i> Xác Nhận Đặt Hàng</button>
            </div>
        </form>
    </div>
    <%@include file="footer.jsp"%>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>