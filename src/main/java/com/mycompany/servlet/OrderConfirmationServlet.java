package com.mycompany.servlet;

import com.mycompany.dao.OrderDAO;
import com.mycompany.model.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/order-confirmation")
public class OrderConfirmationServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy orderId từ tham số URL
        int orderId;
        try {
            orderId = Integer.parseInt(req.getParameter("id"));
        } catch (NumberFormatException e) {
            req.setAttribute("error", "Mã đơn hàng không hợp lệ!");
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
            return;
        }

        // Tạo OrderDAO để lấy thông tin đơn hàng
        OrderDAO orderDAO = new OrderDAO();
        Order order = orderDAO.getOrderById(orderId);

        // Kiểm tra nếu không tìm thấy đơn hàng
        if (order == null) {
            req.setAttribute("error", "Không tìm thấy đơn hàng với mã: " + orderId);
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
            return;
        }

        // Đặt order vào request attribute để hiển thị trên JSP
        req.setAttribute("order", order);
        req.getRequestDispatcher("/order-confirmation.jsp").forward(req, resp);
    }
}