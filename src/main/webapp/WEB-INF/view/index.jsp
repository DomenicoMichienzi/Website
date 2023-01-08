<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Index</title>

    <!-- Bootstrap CSS -->
    <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap JavaScript -->
    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>

    <!-- jQuery from GoogleAPIs-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

    <!-- local JavaScript -->
    <script src="${pageContext.request.contextPath}/js/index.js"></script>

</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <c:choose>
            <c:when test="${username != null}">
                <a class="navbar-brand" href="#">${username}</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                        data-bs-target="#navbarScroll" aria-controls="navbarScroll" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarScroll">
                    <ul class="navbar-nav me-auto my-2 my-lg-0 navbar-nav-scroll" style="--bs-scroll-height: 100px;">
                        <li class="nav-item">
                            <a class="nav-link" aria-current="page" href="/doBooks">My Books</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" aria-current="page" href="/doMovies">My Movies</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" aria-current="page" href="/searchMovies">Search Movies</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/doLogout">Logout</a>
                        </li>
                    </ul>
                    <form class="d-flex" role="search">
                        <input class="form-control me-2" id="searchBar" type="search"
                               placeholder="Search" aria-label="Search">
                        <button class="btn btn-light" type="submit">Search</button>
                    </form>
                </div>
            </c:when>
            <c:otherwise>
                <ul class="navbar-nav me-auto my-2 my-lg-0 navbar-nav-scroll" style="--bs-scroll-height: 100px;">
                    <li class="nav-item">
                        <a class="nav-link" href="/loginPage">Login</a>
                    </li>
                </ul>
            </c:otherwise>
        </c:choose>
    </div>
</nav>

<div class="container-fluid">
    <div class="d-flex justify-content-center" id="main_row">
        <ul class="list-group">
        <c:forEach var="i" begin="0" end="14">
            <li id="list_item_${i}" class="list-group-item">
                <div class="d-flex w-100 justify-content-between">
                    <img src="" class="img-thumbnail" alt="...">
                    <h5 class="mb-1 text-body">List group item heading</h5>
                </div>
                <p class="mb-1 text-authors">Autori</p>
                <a class="btn btn-primary" id="btn${i}" btn_volume_id="">Add</a>
            </li>

            <%--
            <li class="list-group-item d-flex justify-content-between align-items-center">
                <div class="d-flex align-items-center">
                    <img src="https://mdbootstrap.com/img/new/avatars/8.jpg" alt="" style="width: 45px; height: 45px"
                         class="rounded-circle" />
                    <div class="ms-3">
                        <p class="fw-bold mb-1">John Doe</p>
                        <p class="text-muted mb-0">john.doe@gmail.com</p>
                    </div>
                </div>
                <span class="badge rounded-pill badge-success">Active</span>
            </li>
            <li class="list-group-item d-flex justify-content-between align-items-center">
                <div class="d-flex align-items-center">
                    <img src="https://mdbootstrap.com/img/new/avatars/6.jpg" class="rounded-circle" alt=""
                         style="width: 45px; height: 45px" />
                    <div class="ms-3">
                        <p class="fw-bold mb-1">Alex Ray</p>
                        <p class="text-muted mb-0">alex.ray@gmail.com</p>
                    </div>
                </div>
                <span class="badge rounded-pill badge-primary">Onboarding</span>
            </li>
            <li class="list-group-item d-flex justify-content-between align-items-center">
                <div class="d-flex align-items-center">
                    <img src="https://mdbootstrap.com/img/new/avatars/7.jpg" class="rounded-circle" alt=""
                         style="width: 45px; height: 45px" />
                    <div class="ms-3">
                        <p class="fw-bold mb-1">Kate Hunington</p>
                        <p class="text-muted mb-0">kate.hunington@gmail.com</p>
                    </div>
                </div>
                <span class="badge rounded-pill badge-warning">Awaiting</span>
            </li>
            --%>
        </c:forEach>
        </ul>
    </div>
</div>

</body>
</html>