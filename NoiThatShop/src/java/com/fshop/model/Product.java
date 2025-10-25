/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fshop.model;

/**
 *
 * @author FPT SHOP
 */
public class Product {
     private int id;
    private int idDanhMuc;
    private String maSanPham;
    private String tenSanPham;
    private String moTa;
    private double gia;
    private String hinhAnh;
    private boolean moi;
    private boolean noiBat;
    private boolean giamGia;

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getIdDanhMuc() { return idDanhMuc; }
    public void setIdDanhMuc(int idDanhMuc) { this.idDanhMuc = idDanhMuc; }

    public String getMaSanPham() { return maSanPham; }
    public void setMaSanPham(String maSanPham) { this.maSanPham = maSanPham; }

    public String getTenSanPham() { return tenSanPham; }
    public void setTenSanPham(String tenSanPham) { this.tenSanPham = tenSanPham; }

    public String getMoTa() { return moTa; }
    public void setMoTa(String moTa) { this.moTa = moTa; }

    public double getGia() { return gia; }
    public void setGia(double gia) { this.gia = gia; }

    public String getHinhAnh() { return hinhAnh; }
    public void setHinhAnh(String hinhAnh) { this.hinhAnh = hinhAnh; }

    public boolean isMoi() { return moi; }
    public void setMoi(boolean moi) { this.moi = moi; }

    public boolean isNoiBat() { return noiBat; }
    public void setNoiBat(boolean noiBat) { this.noiBat = noiBat; }

    public boolean isGiamGia() { return giamGia; }
    public void setGiamGia(boolean giamGia) { this.giamGia = giamGia; }
}
