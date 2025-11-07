<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="css/style.css">
    <title>Khuyến Mãi</title>
    <style>
        .promo-title {
            text-align: center;
            color: #a34900;
            font-size: 28px;
            font-weight: bold;
            margin: 40px 0 20px;
        }

        .promo-title span {
            color: #d35400;
        }

        .product-list {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-around; /* hoặc space-between */
    gap: 25px;
    width: 100%;
    margin: 0;
    padding: 0 30px; /* để có khoảng cách nhẹ 2 bên, có thể bỏ nếu muốn sát mép */
    box-sizing: border-box;
}


        .product-card {
            position: relative;
            width: 300px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
            overflow: hidden;
            background-color: #fff;
            transition: transform 0.3s ease;
            text-align: center;
        }

        .product-card:hover {
            transform: translateY(-5px);
        }

        .discount-label {
            position: absolute;
            top: 10px;
            left: 10px;
            background-color: #e60000;
            color: #fff;
            font-weight: bold;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 14px;
        }

        .product-card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .product-card h3 {
            font-size: 18px;
            margin: 15px 0 5px;
            color: #333;
        }

        .price {
            font-size: 16px;
            margin-bottom: 10px;
        }

        .price .new {
            color: #ff6600;
            font-weight: bold;
        }

        .price .old {
            color: #777;
            text-decoration: line-through;
            margin-left: 8px;
        }

        .product-card button {
            background-color: #ff6600;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 15px;
            margin-bottom: 15px;
        }

        .product-card button:hover {
            background-color: #cc5200;
        }
        /* Banner ngang */
.promo-banner {
  width: 100%;
  display: flex;
  justify-content: center;
  margin: 20px 0 30px 0;
}

.promo-banner .banner-img {
  width: 100%;
  max-width: 1200px; /* 👈 Giới hạn chiều rộng tối đa */
  height: auto;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.promo-banner .banner-img:hover {
  transform: scale(1.02);
  box-shadow: 0 6px 18px rgba(0,0,0,0.25);
}

.promo-banner .banner-img img {
  width: 100%;
  height: auto;
  display: block;
  object-fit: cover; /* đảm bảo ảnh đẹp trong khung */
}

 /* Popup container */
.popup-container {
  display: flex;
  justify-content: center;
  align-items: center;
  position: fixed;
  top: 0; left: 0;
  width: 100%; height: 100%;
  background-color: rgba(0, 0, 0, 0.6);
  z-index: 9999;
}

/* Popup content */
.popup-content {
  position: relative;
  background: #fff;
  border-radius: 12px;
  box-shadow: 0 4px 20px rgba(0,0,0,0.3);
  overflow: hidden;
  animation: popupFade 0.4s ease;
}

.popup-image {
  width: 600px;
  height: auto;
  display: block;
}

/* Nút đóng */
.close-btn {
  position: absolute;
  top: 10px;
  right: 15px;
  color: #fff;
  background: #f44336;
  font-size: 26px;
  font-weight: bold;
  cursor: pointer;
  border-radius: 50%;
  padding: 2px 8px;
  line-height: 1;
}

@keyframes popupFade {
  from { opacity: 0; transform: scale(0.8); }
  to { opacity: 1; transform: scale(1); }
}


    </style>
</head>
<script>
  // Tự động hiển thị popup khi trang tải xong
  window.onload = function() {
    document.getElementById("promoPopup").style.display = "flex";
  };

  // Hàm đóng popup
  function closePopup() {
    document.getElementById("promoPopup").style.display = "none";
  }
</script>

<body>
    <jsp:include page="includes/header.jsp" />
  <!-- Popup Banner -->
<div id="promoPopup" class="popup-container">
    <div class="popup-content">
        <span class="close-btn" onclick="closePopup()">&times;</span>
        <img src="images/quangcao.jpg" alt="Khuyến mãi" class="popup-image">
    </div>
</div>


    <h1 class="promo-title">🎉 ƯU ĐÃI KHỦNG – <span>GIẢM GIÁ ĐẾN 50%</span> 🎉</h1>
    <div class="promo-banner">
  <img src="images/Flash.jpg" alt="Banner khuyến mãi" class="banner-img">
</div>

    <div class="product-list">
        <div class="product-card">
            <div class="discount-label">-30%</div>
            <img src="images/sofa_goc_L.jpg" alt="Sofa Góc L Shape">
            <h3>Sofa Góc L Shape</h3>
            <div class="price">
                <span class="new">9,093,000đ</span>
                <span class="old">12,990,000đ</span>
            </div>
            <button>Mua ngay</button>
        </div>

        <div class="product-card">
            <div class="discount-label">-40%</div>
            <img src="images/ban_tra_scandi.jpg" alt="Bộ Bàn Trà Scandi">
            <h3>Bộ Bàn Trà Scandi</h3>
            <div class="price">
                <span class="new">774,000đ</span>
                <span class="old">1,290,000</span>
            </div>
            <button>Mua ngay</button>
        </div>

        <div class="product-card">
            <div class="discount-label">-20%</div>
            <img src="images/sofa_bed.jpg" alt="Sofa Bed Tiện Dụng">
            <h3>Sofa Bed Tiện Dụng</h3>
            <div class="price">
                <span class="new">5,992,000đ</span>
                <span class="old">7,490,000đ</span>
            </div>
            <button>Mua ngay</button>
        </div>

        <div class="product-card">
            <div class="discount-label">-35%</div>
            <img src="images/ghe_eames.jpg" alt="Ghế Ăn Eames">
            <h3>Ghế Ăn Eames</h3>
            <div class="price">
                <span class="new">188,500đ</span>
                <span class="old">290,000đ</span>
            </div>
            <button>Mua ngay</button>
        </div>

        <div class="product-card">
            <div class="discount-label">-25%</div>
            <img src="images/nem_foam.jpg" alt="Tấm Nệm Foam 20cm">
            <h3>Tấm Nệm Foam 20cm</h3>
            <div class="price">
                <span class="new">1,642,500đ</span>
                <span class="old">2,190,000đ</span>
            </div>
            <button>Mua ngay</button>
        </div>

        <div class="product-card">
            <div class="discount-label">-50%</div>
            <img src="images/ban_vi_tinh.jpg" alt="Bàn Vi Tính Compact">
            <h3>Bàn Vi Tính Compact</h3>
            <div class="price">
                <span class="new">299,500đ</span>
                <span class="old">599,000đ</span>
            </div>
            <button>Mua ngay</button>
        </div>

        <!-- Sản phẩm thêm mới -->
        <div class="product-card">
            <div class="discount-label">-45%</div>
            <img src="images/giuong_2_tang.jpg" alt="Giường tầng bé yêu">
            <h3>Giường tầng bé yêu</h3>
            <div class="price">
                <span class="new">709,500đ</span>
                <span class="old">1,290,000đ</span>
            </div>
            <button>Mua ngay</button>
        </div>

        <div class="product-card">
            <div class="discount-label">-30%</div>
            <img src="images/tu_tivi.jpg" alt="Kệ Tivi Nordic">
            <h3>Kệ Tivi Nordic</h3>
            <div class="price">
                <span class="new">1,393,000đ</span>
                <span class="old">1,990,000đ</span>
            </div>
            <button>Mua ngay</button>
        </div>
        <div class="product-card">
            <div class="discount-label">-30%</div>
            <img src="images/ghe_don.jpg" alt="Ghế Đôn Milan">
            <h3>Ghế Đôn Milan</h3>
            <div class="price">
                <span class="new">315,000đ</span>
                <span class="old">450,000đ</span>
            </div>
            <button>Mua ngay</button>
        </div>
        <div class="product-card">
            <div class="discount-label">-30%</div>
            <img src="images/ban_trang_diem.jpg" alt="Bàn Trang Điểm Lily">
            <h3>Bàn Trang Điểm Lily</h3>
            <div class="price">
                <span class="new">1,183,000đ</span>
                <span class="old">1,690,000đ</span>
            </div>
            <button>Mua ngay</button>
        </div>
    </div>

    <jsp:include page="includes/footer.jsp" />
</body>
</html>