package com.mycompany.dao;

import com.mycompany.model.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class ProductDAO {
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=TiviShopDB;encrypt=true;trustServerCertificate=true;loginTimeout=30";
    private static final String USER = "sa";
    private static final String PASS = "123456";

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM Product";
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setId(rs.getInt("id"));
                    product.setName(rs.getString("name"));
                    product.setPrice(rs.getDouble("price"));
                    product.setOriginalPrice(rs.getDouble("original_price"));
                    product.setDescription(rs.getString("description"));
                    product.setImage(rs.getString("image"));
                    String imagesStr = rs.getString("images");
                    product.setImages(imagesStr != null && !imagesStr.isEmpty() ? Arrays.asList(imagesStr.split(",")) : new ArrayList<>());
                    product.setQuantity(rs.getInt("quantity"));
                    product.setBrand(rs.getString("brand"));
                    products.add(product);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Product> getProducts(String brand, String sort) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM Product";
        if (brand != null && !brand.isEmpty()) {
            sql += " WHERE brand = ?";
        }
        if (sort != null) {
            if ("price_desc".equals(sort)) {
                sql += (brand != null && !brand.isEmpty() ? " ORDER BY price DESC" : " ORDER BY price DESC");
            } else if ("price_asc".equals(sort)) {
                sql += (brand != null && !brand.isEmpty() ? " ORDER BY price ASC" : " ORDER BY price ASC");
            }
        }
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                if (brand != null && !brand.isEmpty()) {
                    ps.setString(1, brand);
                }
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        Product p = new Product();
                        p.setId(rs.getInt("id"));
                        p.setName(rs.getString("name"));
                        p.setPrice(rs.getDouble("price"));
                        p.setOriginalPrice(rs.getDouble("original_price"));
                        p.setDescription(rs.getString("description"));
                        p.setImage(rs.getString("image"));
                        p.setQuantity(rs.getInt("quantity"));
                        p.setBrand(rs.getString("brand"));
                        String imagesStr = rs.getString("images");
                        p.setImages(imagesStr != null && !imagesStr.isEmpty() ? Arrays.asList(imagesStr.split(",")) : new ArrayList<>());
                        list.add(p);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> getProductsByName(String name) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM Product WHERE name LIKE ?";
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, "%" + (name != null ? name : "") + "%");
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        Product p = new Product();
                        p.setId(rs.getInt("id"));
                        p.setName(rs.getString("name"));
                        p.setPrice(rs.getDouble("price"));
                        p.setOriginalPrice(rs.getDouble("original_price"));
                        p.setDescription(rs.getString("description"));
                        p.setImage(rs.getString("image"));
                        p.setQuantity(rs.getInt("quantity"));
                        p.setBrand(rs.getString("brand"));
                        String imagesStr = rs.getString("images");
                        p.setImages(imagesStr != null && !imagesStr.isEmpty() ? Arrays.asList(imagesStr.split(",")) : new ArrayList<>());
                        list.add(p);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Product getProductById(int id) {
        Product p = null;
        String sql = "SELECT * FROM Product WHERE id = ?";
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, id);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        p = new Product();
                        p.setId(rs.getInt("id"));
                        p.setName(rs.getString("name"));
                        p.setPrice(rs.getDouble("price"));
                        p.setOriginalPrice(rs.getDouble("original_price"));
                        p.setDescription(rs.getString("description"));
                        p.setImage(rs.getString("image"));
                        p.setQuantity(rs.getInt("quantity"));
                        p.setBrand(rs.getString("brand"));
                        String imagesStr = rs.getString("images");
                        p.setImages(imagesStr != null && !imagesStr.isEmpty() ? Arrays.asList(imagesStr.split(",")) : new ArrayList<>());
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return p;
    }

    public List<String> getAllBrands() {
        List<String> brands = new ArrayList<>();
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement("SELECT DISTINCT brand FROM Product WHERE brand IS NOT NULL ORDER BY brand");
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    brands.add(rs.getString("brand"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return brands;
    }

    public boolean addProduct(Product product) {
        String sql = "INSERT INTO Product (name, price, original_price, description, image, quantity, brand, images) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, product.getName());
                ps.setDouble(2, product.getPrice());
                ps.setDouble(3, product.getOriginalPrice());
                ps.setString(4, product.getDescription());
                ps.setString(5, product.getImage());
                ps.setInt(6, product.getQuantity());
                ps.setString(7, product.getBrand());
                ps.setString(8, product.getImages() != null ? String.join(",", product.getImages()) : "");
                int rowsAffected = ps.executeUpdate();
                return rowsAffected > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateProduct(Product product) {
        String sql = "UPDATE Product SET name = ?, price = ?, original_price = ?, description = ?, image = ?, quantity = ?, brand = ?, images = ? WHERE id = ?";
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, product.getName());
                ps.setDouble(2, product.getPrice());
                ps.setDouble(3, product.getOriginalPrice());
                ps.setString(4, product.getDescription());
                ps.setString(5, product.getImage());
                ps.setInt(6, product.getQuantity());
                ps.setString(7, product.getBrand());
                ps.setString(8, product.getImages() != null ? String.join(",", product.getImages()) : "");
                ps.setInt(9, product.getId());
                int rowsAffected = ps.executeUpdate();
                return rowsAffected > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteProduct(int id) {
        String sql = "DELETE FROM Product WHERE id = ?";
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, id);
                int rowsAffected = ps.executeUpdate();
                return rowsAffected > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}