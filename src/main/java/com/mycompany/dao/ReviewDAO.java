package com.mycompany.dao;

import com.mycompany.model.Review;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=TiviShopDB;encrypt=true;trustServerCertificate=true;loginTimeout=30";
    private static final String USER = "sa";
    private static final String PASS = "123456";

    public List<Review> getReviewsByProductId(int productId) {
        List<Review> list = new ArrayList<>();
        String sql = "SELECT r.*, u.username FROM Review r JOIN [User] u ON r.user_id = u.id WHERE r.product_id = ? ORDER BY r.created_date DESC";
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, productId);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        Review r = new Review();
                        r.setId(rs.getInt("id"));
                        r.setProductId(rs.getInt("product_id"));
                        r.setUserId(rs.getInt("user_id"));
                        r.setRating(rs.getInt("rating"));
                        r.setComment(rs.getString("comment"));
                        r.setCreatedDate(rs.getDate("created_date"));
                        r.setUsername(rs.getString("username")); // Get username from User table
                        list.add(r);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addReview(int productId, int userId, int rating, String comment) {
        String sql = "INSERT INTO Review (product_id, user_id, rating, comment) VALUES (?, ?, ?, ?)";
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, productId);
                ps.setInt(2, userId);
                ps.setInt(3, rating);
                ps.setString(4, comment);
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}