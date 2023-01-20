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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

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
                            <a class="nav-link" aria-current="page" href="/getBooks">My Books</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" aria-current="page" href="/searchBooks">Search Books</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" aria-current="page" href="/getMovies">My Movies</a>
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

<!-- Login Form -->
<c:choose>
    <c:when test="${username == null}">
        <div class="d-flex justify-content-center">
            <form method="post" action="doLogin">
                <div class="mb-3">
                    <label for="exampleInputUsername1" class="form-label">Username</label>
                    <input type="text" name="username" class="form-control" id="exampleInputUsername1" aria-describedby="emailHelp">
                    <div id="emailHelp" class="form-text"></div>
                </div>
                <div class="mb-3">
                    <label for="exampleInputPassword1" class="form-label">Password</label>
                    <input type="password" name="passwd" class="form-control" id="exampleInputPassword1">
                </div>
                <button type="submit" class="btn btn-primary">Submit</button>
            </form>
        </div>

    </c:when>
</c:choose>

<!-- Login-Register Form 2 -->
<c:choose>

    <c:when test="${username == null}">
    </c:when>

</c:choose>

</body>
</html>