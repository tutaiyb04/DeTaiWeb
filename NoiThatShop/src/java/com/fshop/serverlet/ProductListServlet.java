/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.fshop.serverlet;

import com.fshop.dao.ProductDAO;
import com.fshop.model.Product;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import util.DBConection;

@WebServlet("/products")
public class ProductListServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        ProductDAO dao = new ProductDAO();
        try {
            List<Product> products = dao.listAll();
            req.setAttribute("products", products);
            RequestDispatcher rd = req.getRequestDispatcher("index.jsp");
            rd.forward(req, resp);
        } catch (Exception e) {
            throw new ServletException("Lỗi khi lấy sản phẩm: " + e.getMessage());
        }
    }
}
