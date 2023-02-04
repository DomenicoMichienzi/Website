<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="en" data-bs-theme="auto">
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Index</title>

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
  <script src="${pageContext.request.contextPath}/js/index.js"></script>
  <script src="${pageContext.request.contextPath}/js/color-modes.js"></script>

  <!-- local CSS -->
  <link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/index.css" rel="stylesheet">

  <!-- Favicons -->
  <link rel="apple-touch-icon" href="${pageContext.request.contextPath}/assets/img/favicons/apple-touch-icon.png" sizes="180x180">
  <link rel="icon" href="${pageContext.request.contextPath}/assets/img/favicons/favicon-32x32.png" sizes="32x32" type="image/png">
  <link rel="icon" href="${pageContext.request.contextPath}/assets/img/favicons/favicon-16x16.png" sizes="16x16" type="image/png">
  <link rel="manifest" href="${pageContext.request.contextPath}/assets/img/favicons/site.webmanifest">
  <link rel="icon" href="${pageContext.request.contextPath}/assets/img/favicons/favicon.ico">
</head>
<body>

<!-- Navbar -->
<c:choose>
  <c:when test="${username != null}">
    <nav class="navbar navbar-expand-md justify-content-between bg-body-tertiary">
      <div class="container-fluid">
        <span class="navbar-brand mb-0 h1" href="${pageContext.request.contextPath}/">${username}</span>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav me-auto mb-2 mb-lg-0">
            <li class="nav-item">
              <a class="nav-link active" href="${pageContext.request.contextPath}/">Home</a>
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
  </c:when>
    <c:otherwise>
    </c:otherwise>
</c:choose>



<c:choose>
  <c:when test="${username == null}">
    <div class="d-flex justify-content-center m-4">
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
    <h4 class="text-center m-3">Welcome</h4>
    <h5 class="text-center m-3">Please Login or register</h5>
    <div class="d-flex justify-content-center">
      <!-- Login Form -->
      <div class="container my-5">
        <h5 class="text-center"><i class="bi bi-box-arrow-in-right"> Login</i></h5>
        <div class="d-flex justify-content-center">
          <form method="post" action="${pageContext.request.contextPath}/doLogin">
            <div class="mb-3">
              <label for="inputUsername" class="form-label">Username</label>
              <input type="text" name="username" class="form-control" id="inputUsername">
              <!--<div id="emailHelp" class="form-text"></div>-->
            </div>
            <div class="mb-3">
              <label for="inputPassword" class="form-label">Password</label>
              <input type="password" name="passwd" class="form-control" id="inputPassword">
            </div>
            <button type="submit" class="btn btn-primary">Login</button>
          </form>
        </div>
      </div>
      <!-- Sign Up Form -->
      <div class="container my-5">
        <h5 class="text-center"><i class="bi bi-person-plus-fill"> Sign Up</i></h5>
        <div class="d-flex justify-content-center">
          <form method="post" action="${pageContext.request.contextPath}/doSignUp">
            <div class="mb-3">
              <label for="signUpInputEmail" class="form-label">email</label>
              <input type="email" name="email" class="form-control" id="signUpInputEmail">
            </div>
            <div class="mb-3">
              <label for="signUpInputUsername" class="form-label">Username</label>
              <input type="text" name="username" class="form-control" id="signUpInputUsername">
            </div>
            <div class="mb-3">
              <label for="signUpInputPassword" class="form-label">Password</label>
              <input type="password" name="passwd" class="form-control" id="signUpInputPassword">
            </div>
            <button type="submit" class="btn btn-primary">Sign Up</button>
          </form>
        </div>
      </div>
    </div>
  </c:when>
</c:choose>

<!-- Movies, Books and TV Shows -->
<c:choose>
  <c:when test="${username != null}">

    <!-- Trending Movie from TMDB -->
    <div class="container-fluid py-2">
      <h2 class="font-weight-light m-3">Trending Movies on TMDB</h2>
      <div class="d-flex flex-row flex-nowrap overflow-scroll align-items-end" id="trendingMovies">

      </div>
    </div>

    <!-- Most Rated Books -->
    <div class="container-fluid py-2">
      <h2 class="font-weight-light m-3">Most Rated Books on the site</h2>
      <div class="d-flex flex-row flex-nowrap overflow-scroll align-items-end" id="mostRatedBooks">
        <c:forEach items="${books}" var="book" begin="0" end="15">
          <div class="card col-auto border-0">
            <img src="${pageContext.request.contextPath}/assets/books/covers/${book.book_id}.png"
                 class="card-img-top rounded-3" alt="...">
            <div class="card-body p-1">
              <p class="vote_average d-inline my-1">${book.avgRating}</p>
              <p class="card-title text-start">
                <a href="${pageContext.request.contextPath}/itemPage?item_type=book&item_id=${book.book_id}">
                    ${book.title}
                </a>
              </p>
              <button type="button" class="btn btn-danger btn-sm my-2">
                Add to Library
              </button>
            </div>
          </div>
        </c:forEach>
      </div>
    </div>

    <!-- Trending TV Shows from TMDB -->
    <div class="container-fluid py-2">
      <h2 class="font-weight-light m-3">Trending TV Shows on TMDB</h2>
      <div class="d-flex flex-row flex-nowrap overflow-scroll align-items-end" id="trendingTvShows">

      </div>
    </div>

  </c:when>
</c:choose>


<!-- Footer -->
<div class="container-fluid">
  <footer class="d-flex flex-wrap justify-content-between align-items-center py-3 my-4 border-top">
    <p class="col-md-4 mb-0 text-muted">© 2022 Company, Inc</p>

    <a href="${pageContext.request.contextPath}/" class="col-md-4 d-flex align-items-center justify-content-center mb-3 mb-md-0 me-md-auto link-dark text-decoration-none">
      <i class="bi-house-heart-fill" style="font-size: 2rem; color: #0d6efd;"></i>
    </a>

    <ul class="nav col-md-4 justify-content-end">
      <li class="nav-item"><a href="#" class="nav-link px-2 text-muted">Home</a></li>
      <li class="nav-item"><a href="#" class="nav-link px-2 text-muted">Features</a></li>
      <li class="nav-item"><a href="#" class="nav-link px-2 text-muted">Pricing</a></li>
      <li class="nav-item"><a href="#" class="nav-link px-2 text-muted">FAQs</a></li>
      <li class="nav-item"><a href="#" class="nav-link px-2 text-muted">About</a></li>
    </ul>
  </footer>

</div>
</body>
</html>