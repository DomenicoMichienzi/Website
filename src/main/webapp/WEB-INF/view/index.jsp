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
    <div class="row row-cols-md-auto row-cols-md-auto g-4" id="main_row">
        <c:forEach var="i" begin="0" end="14">
            <div hidden class="card w-75" id="card${i}" style="max-width: 180px">
                <img class="card-img-top" alt="..." src="">
                <div class="card-body">
                    <h5 class="card-title text-truncate"></h5>
                    <p class="card-text"></p>
                    <a class="btn btn-primary" id="btn${i}" btn_volume_id="">Add</a>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

</body>
</html>