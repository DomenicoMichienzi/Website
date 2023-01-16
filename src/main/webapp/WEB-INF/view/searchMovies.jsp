<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--

--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Movies Search</title>

  <!-- Bootstrap CSS -->
  <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Bootstrap JavaScript -->
  <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>

  <!-- jQuery from GoogleAPIs-->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

  <!-- local JavaScript -->
  <script src="${pageContext.request.contextPath}/js/searchMovies.js"></script>

  <!-- local CSS -->
  <link href="${pageContext.request.contextPath}/css/movieSearch.css" rel="stylesheet">
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
              <a class="nav-link active" aria-current="page" href="/searchMovies">Search Movies</a>
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
  <div class="d-flex justify-content-center" id="main_row">
    <ul class="list-group">
      <c:forEach var="i" begin="0" end="9">
        <li id="list_item_${i}" class="list-group-item">
          <div class="d-flex w-100 justify-content-between">
            <img src="" class="img-thumbnail" style="max-width: 150px" alt="...">
            <h5 class="mb-1 text-body">List group item heading</h5>
          </div>
          <p class="mb-1 text-authors">Autori</p>
          <a class="btn btn-primary" id="btn${i}" btn_movie_id="">Add</a>
        </li>
      </c:forEach>
    </ul>
  </div>
</div>

</body>
</html>
