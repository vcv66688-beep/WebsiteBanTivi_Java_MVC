package com.mycompany.dao;

import com.mycompany.model.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=TiviShopDB;encrypt=true;trustServerCertificate=true;loginTimeout=30";
    private static final String USER = "sa";
    private static final String PASS = "123456"; // Replace with your SQL Server password
    
    // Get user by ID
    public User getUserById(int id) {
        User user = null;
        String sql = "SELECT * FROM [User] WHERE id = ?";
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, id);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        user = new User();
                        user.setId(rs.getInt("id"));
                        user.setUsername(rs.getString("username"));
                        user.setPassword(rs.getString("password"));
                        user.setEmail(rs.getString("email"));
                        user.setFullName(rs.getString("full_name"));
                        user.setRole(rs.getString("role") != null ? rs.getString("role").trim() : "USER");
                        user.setPhone(rs.getString("phone"));
                        user.setAddress(rs.getString("address"));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    // Get all users
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement("SELECT * FROM [User] ORDER BY id");
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password"));
                    user.setEmail(rs.getString("email"));
                    user.setFullName(rs.getString("full_name"));
                    user.setRole(rs.getString("role") != null ? rs.getString("role").trim() : "USER");
                    users.add(user);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }

    // Add a new user
    public boolean addUser(User user) {
        String sql = "INSERT INTO [User] (username, password, email, full_name, role) VALUES (?, ?, ?, ?, ?)";
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, user.getUsername());
                ps.setString(2, user.getPassword());
                ps.setString(3, user.getEmail());
                ps.setString(4, user.getFullName());
                ps.setString(5, user.getRole());
                int rowsAffected = ps.executeUpdate();
                return rowsAffected > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Update user
    public boolean updateUser(User user) {
        String sql = "UPDATE [User] SET username = ?, password = ?, email = ?, full_name = ?, role = ?, phone = ?, address = ? WHERE id = ?";
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, user.getUsername());
                ps.setString(2, user.getPassword());
                ps.setString(3, user.getEmail());
                ps.setString(4, user.getFullName());
                ps.setString(5, user.getRole());
                ps.setString(6, user.getPhone());
                ps.setString(7, user.getAddress());
                ps.setInt(8, user.getId());
                int rowsAffected = ps.executeUpdate();
                return rowsAffected > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

        public boolean deleteUser(int id) {
            try {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                try (Connection conn = DriverManager.getConnection(URL, USER, PASS)) {

                    // Xóa payment liên quan (nếu có)
                    String deletePaymentsSql = "DELETE FROM [Payment] WHERE user_id = ?";
                    try (PreparedStatement ps = conn.prepareStatement(deletePaymentsSql)) {
                        ps.setInt(1, id);
                        ps.executeUpdate();
                    }

                    // Xóa order liên quan
                    String deleteOrdersSql = "DELETE FROM [Order] WHERE user_id = ?";
                    try (PreparedStatement psOrders = conn.prepareStatement(deleteOrdersSql)) {
                        psOrders.setInt(1, id);
                        psOrders.executeUpdate();
                    }

                    // Xóa user
                    String deleteUserSql = "DELETE FROM [User] WHERE id = ?";
                    try (PreparedStatement psUser = conn.prepareStatement(deleteUserSql)) {
                        psUser.setInt(1, id);
                        int rowsAffected = psUser.executeUpdate();
                        return rowsAffected > 0;
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                return false;
            }
        }



    // Authenticate user
    public User authenticateUser(String username, String password) {
        User user = null;
        String sql = "SELECT * FROM [User] WHERE username = ? AND password = ?";
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, username);
                ps.setString(2, password);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        user = new User();
                        user.setId(rs.getInt("id"));
                        user.setUsername(rs.getString("username"));
                        user.setPassword(rs.getString("password"));
                        user.setEmail(rs.getString("email"));
                        user.setFullName(rs.getString("full_name"));
                        user.setRole(rs.getString("role") != null ? rs.getString("role").trim() : "USER");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    // Check if username or email exists
    public boolean isUsernameOrEmailExists(String username, String email) {
        String sql = "SELECT COUNT(*) FROM [User] WHERE username = ? OR email = ?";
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, username);
                ps.setString(2, email);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        return rs.getInt(1) > 0;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}