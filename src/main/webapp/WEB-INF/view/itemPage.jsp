<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Item Page</title>

  <!-- jQuery from GoogleAPIs-->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

  <!-- Bootstrap CSS -->
  <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Bootstrap JavaScript -->
  <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Bootstrap icons -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">

  <!-- local JavaScript -->
  <script src="${pageContext.request.contextPath}/js/itemPage.js"></script>
  <script src="${pageContext.request.contextPath}/js/color-modes.js"></script>

  <!-- local CSS -->
  <link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/itemPage.css" rel="stylesheet">

  <!-- Favicons -->
  <link rel="apple-touch-icon" href="${pageContext.request.contextPath}/assets/img/favicons/apple-touch-icon.png" sizes="180x180">
  <link rel="icon" href="${pageContext.request.contextPath}/assets/img/favicons/favicon-32x32.png" sizes="32x32" type="image/png">
  <link rel="icon" href="${pageContext.request.contextPath}/assets/img/favicons/favicon-16x16.png" sizes="16x16" type="image/png">
  <link rel="manifest" href="${pageContext.request.contextPath}/assets/img/favicons/site.webmanifest">
  <link rel="icon" href="${pageContext.request.contextPath}/assets/img/favicons/favicon.ico">
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-md justify-content-between bg-body-tertiary">
  <div class="container-fluid">
    <span class="navbar-brand mb-0 h1" href="${pageContext.request.contextPath}/">${username}</span>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/searchPage">Search</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/getBooks">Books</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/getMovies">Movies</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/doLogout">Logout</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Info</a>
        </li>
      </ul>
      <div class="nav-item m-2">
        <div class="vr"></div>
      </div>
    </div>
    <!-- Theme Buttons -->
    <button type="button" class="btn btn-sm btn-dark m-1" data-bs-theme-value="dark">
      <i class="bi bi-moon-stars-fill"> dark</i>
    </button>
    <button type="button" class="btn btn-sm btn-light m-1" data-bs-theme-value="light">
      <i class="bi bi-brightness-high-fill"> light</i>
    </button>
    <button type="button" class="btn btn-sm btn-primary m-1" data-bs-theme-value="auto">
      <i class="bi bi-layers-half"> auto</i>
    </button>
    <div class="nav-item m-2">
      <div class="vr"></div>
    </div>
  </div>
</nav>


<div class="row d-flex justify-content-start m-4">
  <!-- Book Image -->
  <c:if test="${type == 'book'}">
    <img  style="max-width: 13em" class="figure-img rounded-4" src="${pageContext.request.contextPath}/assets/books/covers/${book_id}.png" alt="...">
  </c:if>

  <!-- Title, overview and other stuffs -->

  <c:forEach items="${items}" var="item" begin="0" end="15">
    <div class="container">
      <div class="card col-auto mb-3 border-0">
        <div class="card-body">
          <h5 class="card-rating">Rating: ${item.rating}</h5>
          <h5 class="card-review">Review: ${item.review}</h5>
        </div>
      </div>
    </div>
  </c:forEach>
</div>



</body>
</html>
