<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>장바구니</title>
    <link rel="icon" href="/static/img/logo.png" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <link rel="stylesheet" href="/static/css/style.css" />
</head>
<body>
    <nav class="navbar bg-dark navbar-expand-lg bg-body-tertiary" data-bs-theme="dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="/">Home</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="/shop/products.jsp">Product</a>
                    </li>
                </ul>
                <ul class="navbar-nav d-flex align-items-center px-3">
                    <li class="nav-item">
                        <a class="nav-link" aria-current="page" href="/user/login.jsp">로그인</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" aria-current="page" href="/user/join.jsp">회원가입</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" aria-current="page" href="/user/order.jsp">주문내역</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link position-relative" aria-current="page" href="/shop/cart.jsp">
                            <i class="material-symbols-outlined">shopping_bag</i>
                            <span class="cart-count">0</span>
                        </a>
                    </li>
                </ul>
                <form class="d-flex" role="search" action="/shop/products.jsp" method="get">
                    <input class="form-control me-2" type="search" name="keyword" placeholder="Search" aria-label="Search" value="">
                    <button class="btn btn-outline-success" type="submit">Search</button>
                </form>
            </div>
        </div>
    </nav>

    <div class="px-4 py-5 my-5 text-center">
        <h1 class="display-5 fw-bold text-body-emphasis">장바구니</h1>
        <div class="col-lg-6 mx-auto">
            <p class="lead mb-4">장바구니 목록 입니다.</p>
        </div>
    </div>

    <!-- 장바구니 영역 -->
    <div class="container order">
        <table class="table table-striped table-hover table-bordered text-center align-middle">
            <thead>
                <tr class="table-primary">
                    <th>상품</th>
                    <th>가격</th>
                    <th>수량</th>
                    <th>소계</th>
                    <th>비고</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${cartItems}">
                    <tr>
                        <td>${item.productName}</td>
                        <td>${item.unitPrice}</td>
                        <td>
                            <form action="updateCart.jsp" method="post" class="d-inline">
                                <input type="hidden" name="productId" value="${item.productId}">
                                <input type="number" name="quantity" value="${item.quantity}" min="1" class="form-control d-inline" style="width: 60px;">
                                <button type="submit" class="btn btn-sm btn-primary">변경</button>
                            </form>
                        </td>
                        <td>${item.unitPrice * item.quantity}</td>
                        <td>
                            <a href="deleteCart.jsp?productId=${item.productId}" class="btn btn-sm btn-danger">삭제</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
            <tfoot>
                <tr>
                    <td colspan="4">총합계:</td>
                    <td>${totalPrice}</td>
                </tr>
                <tr>
                    <td colspan="5">상품이 없습니다.</td>
                </tr>
            </tfoot>
        </table>

        <!-- 버튼 영역 -->
        <div class="d-flex justify-content-between align-items-center p-3">
            <a href="deleteCart.jsp?cartId=C2F98A6232140B9131815A97FA0C489D" class="btn btn-lg btn-danger">전체삭제</a>
            <a href="javascript:;" class="btn btn-lg btn-primary" onclick="order()">주문하기</a>
        </div>
    </div>

    <footer class="container p-5">
        <p>copyright Shop</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
    <script src="/static/js/validation.js"></script>
</body>
</html>