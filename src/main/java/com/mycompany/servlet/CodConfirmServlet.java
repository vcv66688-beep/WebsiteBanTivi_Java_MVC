package com.mycompany.servlet;

import com.mycompany.dao.OrderDAO;
import com.mycompany.model.CartItem;
import com.mycompany.model.Order;
import com.mycompany.model.Payment;
import com.mycompany.model.PendingOrder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;
import java.util.UUID;

@WebServlet("/cod-confirm")
public class CodConfirmServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:sqlserver://localhost:1433;databaseName=TiviShopDB;encrypt=true;trustServerCertificate=true;loginTimeout=30";
    private static final String DB_USER = "sa";
    private static final String DB_PASS = "123456";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        PendingOrder pendingOrder = (PendingOrder) session.getAttribute("pendingOrder");

        if (pendingOrder == null) {
            resp.sendRedirect("checkout");
            return;
        }

        List<CartItem> cart = pendingOrder.getCartItems();
        OrderDAO orderDAO = new OrderDAO();
        Connection conn = null;

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            conn.setAutoCommit(false);

            // ✅ Kiểm tra tồn kho
            if (!orderDAO.updateProductQuantities(cart)) {
                throw new SQLException("Một số sản phẩm không đủ tồn kho!");
            }

            // ✅ Tạo Order từ PendingOrder
            Order order = new Order();
            order.setUserId(pendingOrder.getUserId());
            order.setTotalAmount(pendingOrder.getTotalAmount());
            order.setStatus("PENDING");
            order.setCreatedDate(pendingOrder.getCreatedDate());
            order.setAddress(pendingOrder.getAddress());
            order.setBillingName(pendingOrder.getBillingName());
            order.setBillingPhone(pendingOrder.getBillingPhone());
            order.setBillingEmail(pendingOrder.getBillingEmail());

            int orderId = orderDAO.createOrder(order);
            if (orderId == -1) {
                throw new SQLException("Tạo đơn hàng thất bại!");
            }

            // ✅ Thêm OrderDetails
            if (!orderDAO.addOrderDetails(orderId, cart)) {
                throw new SQLException("Thêm chi tiết đơn hàng thất bại!");
            }

            // ✅ Tạo Payment
            String transactionId = "COD-TX-" + UUID.randomUUID().toString().substring(0, 8);
            Payment payment = new Payment();
            payment.setOrderId(orderId);
            payment.setAmount(pendingOrder.getTotalAmount());
            payment.setTransactionId(transactionId);
            payment.setStatus("PENDING");
            if (!orderDAO.createPayment(payment)) {
                throw new SQLException("Tạo thanh toán thất bại!");
            }

            // ✅ Commit
            conn.commit();

            // ✅ Lấy lại order và chi tiết đơn hàng
            Order confirmedOrder = orderDAO.getOrderById(orderId);
            confirmedOrder.setOrderDetails(orderDAO.getOrderDetailsByOrderId(orderId));

            // ✅ Xóa session tạm
            session.removeAttribute("cart");
            session.removeAttribute("pendingOrder");

            // ✅ Gửi dữ liệu sang JSP hiển thị kết quả
            req.setAttribute("order", confirmedOrder);
            req.getRequestDispatcher("/cod-confirmation.jsp").forward(req, resp);

        } catch (SQLException e) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            req.setAttribute("error", "Lỗi: " + e.getMessage());
            req.getRequestDispatcher("/cod-preview.jsp").forward(req, resp);

        } catch (Exception e) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            req.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            req.getRequestDispatcher("/cod-preview.jsp").forward(req, resp);

        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
