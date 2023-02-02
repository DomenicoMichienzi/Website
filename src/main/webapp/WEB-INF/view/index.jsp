<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="en" data-bs-theme="auto">
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Index</title>

  <!-- jQuery from GoogleAPIs-->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

  <!-- Bootstrap CSS -->
  <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Bootstrap JavaScript -->
  <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Bootstrap icons -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">

  <!-- local JavaScript -->
  <script src="${pageContext.request.contextPath}/js/index.js"></script>
  <script src="${pageContext.request.contextPath}/js/color-modes.js"></script>

  <!-- local CSS -->
  <link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/index.css" rel="stylesheet">

</head>
<body>

<!-- Navbar -->
<c:choose>
  <c:when test="${username != null}">
    <nav class="navbar navbar-expand-md justify-content-between bg-body-tertiary">
      <div class="container-fluid">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">${username}</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav me-auto mb-2 mb-lg-0">
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
      </div>
    </nav>
  </c:when>
    <c:otherwise>
    </c:otherwise>
</c:choose>


<!-- Login Form -->
<c:choose>
  <c:when test="${username == null}">
    <div class="container">
      <div class="d-flex justify-content-center">
        <form method="post" action="${pageContext.request.contextPath}/doLogin">
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
    </div>
  </c:when>
</c:choose>


<!-- Trending Movie -->
<div class="container-fluid py-2">
  <h2 class="font-weight-light m-3">Trending Movies</h2>
  <div class="d-flex flex-row flex-nowrap overflow-scroll align-items-end" id="trendingMovies">

  </div>
</div>

<!-- Trending TV Shows -->
<div class="container-fluid py-2">
  <h2 class="font-weight-light m-3">Trending TV Shows</h2>
  <div class="d-flex flex-row flex-nowrap overflow-scroll align-items-end" id="trendingTvShows">

  </div>
</div>

<!-- Load top rating Books -->
<c:choose>
  <c:when test="${username != null}">
    <c:forEach items="${books}" var="book">

    </c:forEach>
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