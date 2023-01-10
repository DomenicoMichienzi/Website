<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--

--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Movies Page</title>

    <!-- Bootstrap CSS -->
    <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap JavaScript -->
    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>

    <!-- jQuery from GoogleAPIs-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

    <!-- local JavaScript -->
    <script src="${pageContext.request.contextPath}/js/moviesPage.js"></script>

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
                            <a class="nav-link active" aria-current="page" href="/doMovies">My Movies</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" aria-current="page" href="/searchMovies">Search Movies</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/doLogout">Logout</a>
                        </li>
                    </ul>
                    <div class="d-flex" role="search">
                        <input class="form-control me-2" id="searchBar" type="search"
                               placeholder="Search" aria-label="Search">
                        <button class="btn btn-light" type="submit">Search</button>
                    </div>
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
    <h1>My Movies</h1>
    <p> List of Movies:</p>
    <div class="card-group">
        <c:forEach items="${movies}" var="movie">
            <div class="card w-75" style="max-width: 200px" id="${movie.movie_id}">
                <div class="card-body">
                    <img src="${pageContext.request.contextPath}/assets/movies/posters/${movie.movie_id}.jpg" class="card-img-bottom" alt="...">
                    <h5 class="card-title">${movie.title}</h5>
                    <p class="card-text"></p>
                    <a href="#" class="btn btn-danger" btn_movie_id="${movie.movie_id}">Delete</a>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

</body>
</html>
