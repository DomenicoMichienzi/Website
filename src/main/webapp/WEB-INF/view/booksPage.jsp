<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Personal Page</title>

    <!-- Bootstrap CSS -->
    <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap JavaScript -->
    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>

    <!-- jQuery from GoogleAPIs-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

    <!-- local JavaScript -->
    <script src="${pageContext.request.contextPath}/js/booksPage.js"></script>

</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">${username}</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarScroll" aria-controls="navbarScroll" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarScroll">
            <ul class="navbar-nav me-auto my-2 my-lg-0 navbar-nav-scroll" style="--bs-scroll-height: 100px;">
                <li class="nav-item">
                    <a class="nav-link" aria-current="page" href="/">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="doLogout">Logout</a>
                </li>
            </ul>
            <form class="d-flex" role="search">
                <input class="form-control me-2" id="searchBar" type="search"
                       placeholder="Search" aria-label="Search">
                <button class="btn btn-outline-success" type="submit">Search</button>
            </form>
        </div>
    </div>
</nav>

<div class="container-fluid">
    <h1>My Books</h1>
    <p> List of Book:</p>
    <div class="card-group">
        <c:forEach items="${books}" var="book">
            <div class="card w-75" style="max-width: 200px" id="${book.volume_id}">
                <div class="card-body">
                    <img src="..." class="card-img-bottom" alt="...">
                    <h5 class="card-title"></h5>
                    <p class="card-text"></p>
                    <a href="#" class="btn btn-danger" btn_volume_id="${book.volume_id}">Delete</a>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

</body>
</html>
