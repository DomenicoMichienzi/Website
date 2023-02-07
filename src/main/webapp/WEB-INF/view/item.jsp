<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Item</title>

  <!-- jQuery from GoogleAPIs-->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

  <!-- Bootstrap CSS -->
  <!--<link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet">-->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">

  <!-- Bootstrap JavaScript -->
  <!--<script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.bundle.min.js"></script>-->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>


  <!-- Bootstrap icons -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">

  <!-- local JavaScript -->
  <script src="${pageContext.request.contextPath}/js/item.js"></script>
  <script src="${pageContext.request.contextPath}/js/color-modes.js"></script>

  <!-- local CSS -->
  <link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/item.css" rel="stylesheet">

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
    <span class="navbar-brand mb-0 h1" href="${pageContext.request.contextPath}/"><i class="bi bi-person"> ${username}</i></span>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/"><i class="bi bi-house"> Home</i></a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/getBooks"><i class="bi bi-book"> Books</i></a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/getMovies"><i class="bi bi-film"> Movies</i></a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/getTVs"><i class="bi bi-tv"> TV Show</i></a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/searchPage">
            <i class="bi bi-search"> Search</i>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/doLogout">Logout <i class="bi bi-box-arrow-left"></i></a>
        </li>
      </ul>

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
    </div>
  </div>
</nav>

<c:if test="${not empty items}">
  <!-- item contents -->
  <div class="row d-flex justify-content-start m-3">
    <div class="card mb-3 border-0">
      <div class="row g-0">
        <!-- Book Image -->
        <c:if test="${type == 'book'}">
          <div class="col-md-auto">
            <img class="img-fluid rounded-4 shadow-sm m-3"
                 src="${pageContext.request.contextPath}/assets/books/covers/${book_id}.png" alt="...">
          </div>
        </c:if>
        <!-- Movie Image -->
        <c:if test="${type == 'movie'}">
          <div class="col-md-auto">
            <img class="img-fluid rounded-4 shadow-sm m-3" style="max-width: 10em"
                 src="${pageContext.request.contextPath}/assets/movies/posters/${movie_id}.jpg" alt="...">
          </div>
        </c:if>
        <!-- TV Image -->
        <c:if test="${type == 'movie'}">
          <div class="col-md-auto">
            <img class="img-fluid rounded-4 shadow-sm m-3" style="max-width: 10em"
                 src="${pageContext.request.contextPath}/assets/tvs/posters/${tv_id}.jpg" alt="...">
          </div>
        </c:if>
        <!-- Card body -->
        <div class="col-md-auto">
          <div class="card-body">
            <h2 class="card-title">${items[0].title}</h2>
            <p class="card-description">${items[0].description}</p>
          </div>
        </div>
      </div>
    </div>

    <!-- Title, overview and other stuffs -->
    <c:forEach items="${items}" var="item" begin="0" end="15">
      <c:if test="${item.rating != 0.0}">
        <div class="container">
          <div class="card col-auto mb-3 border-0 shadow-sm">
            <div class="card-body">
              <h4 class="card-username">${item.username_id}</h4>
              <h5 class="card-rating">${item.rating}</h5>
              <c:if test="${not empty item.review}">
                <p class="card-review">${item.review}</p>
              </c:if>
            </div>
          </div>
        </div>
      </c:if>
    </c:forEach>
  </div>
</c:if>


<c:if test="${empty items}">
  <h4 class="text-center m-4">No reviews available for this item</h4>
</c:if>


<!-- Footer -->
<div class="container-fluid">
  <footer class="d-flex flex-wrap justify-content-between align-items-center py-3 my-4 border-top">
    <p class="col-md-4 mb-0 text-muted">© 2023 Unical, Exam</p>
    <a href="${pageContext.request.contextPath}/" class="col-md-4 d-flex align-items-center justify-content-center mb-3 mb-md-0 me-md-auto">
      <i class="bi-house" style="font-size: 2rem;"></i>
    </a>
    <ul class="nav col-md-4 justify-content-end">
      <li class="nav-item"><a href="#" class="nav-link px-2 text-muted">Home</a></li>
      <li class="nav-item"><a href="#" class="nav-link px-2 text-muted">Features</a></li>
      <li class="nav-item"><a href="#" class="nav-link px-2 text-muted">About</a></li>
    </ul>
  </footer>

</div>

</body>
</html>
