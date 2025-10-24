<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@include file="header.jsp"%>
<html>
<head>
    <title>Xác Nhận Đơn Hàng Thành Công</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="css/style.css" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', sans-serif; background: #f4f6f8; }
        .confirmation-container { background: #fff; padding: 30px; border-radius: 15px; box-shadow: 0 4px 20px rgba(0,0,0,0.1); text-align: center; }
        .btn-home { background: #007bff; color: white; font-weight: bold; }
    </style>
</head>
<body>
    <div class="container my-5 confirmation-container">
        <i class="fas fa-check-circle fa-5x text-success mb-3"></i>
        <h1 class="mb-4">Đặt Hàng Thành Công!</h1>
        <p class="lead">Cảm ơn bạn đã đặt hàng. Mã đơn hàng của bạn là: <strong>#${order.id}</strong></p>
        <p>Tổng tiền: <fmt:formatNumber value="${order.totalAmount + 50000}" pattern="#,##0" /> VND (bao gồm ship)</p>
        <p>Địa chỉ giao hàng: ${order.address}</p>
        <p>Trạng thái: ${order.status}</p>
        <p>Chúng tôi sẽ gửi email xác nhận và cập nhật tình trạng đơn hàng.</p>
        <a href="products" class="btn btn-home btn-lg mt-4"><i class="fas fa-home"></i> Về Trang Chủ</a>
                <a href="order-history" class="btn btn-home btn-lg mt-4"><i class="fas fa-home"></i> LS</a>
    </div>
    <%@include file="footer.jsp"%>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>