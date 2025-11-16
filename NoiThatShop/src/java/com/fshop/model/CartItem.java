/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fshop.model;

/**
 *
 * @author FPT SHOP
 */
public class CartItem {
    // Thuộc tính
    private Product product; // Tham chiếu đến đối tượng Product
    private int quantity;    // Số lượng của sản phẩm này trong giỏ hàng

    // 1. Constructor mặc định (cần thiết cho một số Framework)
    public CartItem() {
    }

    // 2. Constructor đầy đủ
    public CartItem(Product product, int quantity) {
        this.product = product;
        this.quantity = quantity;
    }

    // 3. Getters và Setters

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    // 4. Phương thức tính toán

    /**
     * Tính tổng tiền của mặt hàng này (Giá * Số lượng).
     * @return Tổng tiền (double)
     */
    public double getTotalPrice() {
        if (product != null) {
            // Giả định phương thức getGia() tồn tại trong lớp Product
            return product.getGia() * this.quantity; 
        }
        return 0.0;
    }

    // 5. toString() (Tùy chọn, hữu ích cho Debugging)
    @Override
    public String toString() {
        return "CartItem{" +
                "productId=" + (product != null ? product.getId() : "N/A") +
                ", productName=" + (product != null ? product.getTenSanPham() : "N/A") +
                ", quantity=" + quantity +
                ", totalPrice=" + String.format("%,.0f", getTotalPrice()) +
                '}';
    }
}
