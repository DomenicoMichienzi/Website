<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="en" data-bs-theme="auto">
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Search</title>

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
  <script src="${pageContext.request.contextPath}/js/search.js"></script>
  <script src="${pageContext.request.contextPath}/js/color-modes.js"></script>

  <!-- local CSS -->
  <link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/search.css" rel="stylesheet">

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
          <a class="nav-link" href="${pageContext.request.contextPath}/getTVs"><i class="bi bi-tv"> TV Shows</i></a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" href="${pageContext.request.contextPath}/searchPage">
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



<!-- Search Bar -->
<div class="d-flex justify-content-center mt-3">
  <div class="d-flex" role="search">
    <input id="searchBar" class="form-control m-1" type="search" placeholder="Search" aria-label="Search">
  </div>
</div>

<!-- radio buttons -->
<div class="d-flex justify-content-center">
  <div class="input-group-sm border-4 m-1" id="searchTypeRadio">
    <!-- Movie Radio -->
    <div class="form-check form-check-inline">
      <input class="form-check-input" type="radio" name="searchRadioOptions" id="inlineRadioMovie" value="movie">
      <label class="form-check-label" for="inlineRadioMovie"><i class="bi bi-film"> Movie</i></label>
    </div>
    <!-- Book Radio -->
    <div class="form-check form-check-inline">
      <input class="form-check-input" type="radio" name="searchRadioOptions" id="inlineRadioBook" value="book">
      <label class="form-check-label" for="inlineRadioBook"><i class="bi bi-book"> Book</i></label>
    </div>
    <!-- TV Show Radio -->
    <div class="form-check form-check-inline">
      <input class="form-check-input" type="radio" name="searchRadioOptions" id="inlineRadioTvShow" value="TvShow">
      <label class="form-check-label" for="inlineRadioTvShow"><i class="bi bi-tv"> TV Show</i></label>
    </div>
  </div>
</div>


<!-- Cards -->
<div class="container-fluid d-flex p-1 justify-content-center">
  <div class="col-9" id="searchResults">
  </div>
</div>

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