<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="en" data-bs-theme="dark">
<head>
  <title>Movies Page</title>

  <!-- jQuery from GoogleAPIs-->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

  <!-- Bootstrap CSS -->
  <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Bootstrap JavaScript -->
  <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Bootstrap icons -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">

  <!-- local JavaScript -->
  <script src="${pageContext.request.contextPath}/js/moviesPage.js"></script>
  <script src="${pageContext.request.contextPath}/js/color-modes.js"></script>

  <!-- local CSS -->
  <link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/moviesPage.css" rel="stylesheet">

</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-md justify-content-between bg-body-tertiary">
  <div class="container-fluid">
    <c:choose>
      <c:when test="${username != null}">
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
              <a class="nav-link active" href="${pageContext.request.contextPath}/getMovies">Movies</a>
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
          <!-- Search Bar -->
          <div class="d-flex" role="search">
            <input id="searchBar" class="form-control m-1" type="search" placeholder="Search" aria-label="Search">
          </div>

          <div class="nav-item m-2">
            <div class="vr"></div>
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
      </c:when>
      <c:otherwise>

      </c:otherwise>
    </c:choose>
  </div>
</nav>

<!-- Movies List -->
<div class="container-fluid text-center">
  <h2 class="m-4">My Movies</h2>
  <div class="container text-center">
    <div class="row row-cols-md-auto">
      <c:forEach items="${movies}" var="movie">
        <div class="col-auto" id="${movie.movie_id}">
          <div class="card w-100 border-0 text-truncate text-wrap" style="height: 30em; width: 25em">
            <div class="card-body" style="width: 15em">
              <img src="${pageContext.request.contextPath}/assets/movies/posters/${movie.username_id}/${movie.movie_id}.jpg"
                   class="card-img" alt="..." style="height: 10em; width: 7em">
              <p class="card-title d-flex align-items-center fs-5" style="height: 6em">${movie.title}</p>
              <p class="card-text text-wrap">${movie.description}</p>
              <!-- Button trigger modal -->
              <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#Modal_${movie.movie_id}">Modal</button>
              <!-- Modal -->
              <div class="modal fade" id="Modal_${movie.movie_id}" tabindex="-1" aria-labelledby="ModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h1 class="modal-title fs-5">Modal title</h1>
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                      <form>
                        <div class="mb-3">
                          <a class="text-bg-dark">${movie.title}</a>
                        </div>
                        <div class="mb-3">
                          <label for="rating_${movie.movie_id}" class="form-label">Rating: ${movie.rating}</label>
                          <input type="range" class="form-range" min="0" max="10" step="0.5" value="${movie.rating}" id="rating_${movie.movie_id}">
                          <a class="text-bg-dark current-rating" id="current_rating_${movie.movie_id}">Ciaone</a>
                        </div>
                        <div class="mb-3">
                          <label for="review-text_${movie.movie_id}" class="col-form-label">Review</label>
                          <textarea class="form-control" id="review-text_${movie.movie_id}">${movie.review}</textarea>
                        </div>
                        <div class="mp-3">
                          <label for="comment-text_${movie.movie_id}" class="col-form-label">Comment</label>
                          <textarea class="form-control" id="comment-text_${movie.movie_id}">${movie.comment}</textarea>
                        </div>
                      </form>
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                      <button type="button" class="btn btn-primary saveChangesBtn" data-movie_id="${movie.movie_id}">Save changes</button>
                    </div>
                  </div>
                </div>
              </div>
              <button type="button" class="btn btn-danger" data-btn_movie_id="${movie.movie_id}">Delete</button>
            </div>
          </div>
        </div>
      </c:forEach>
    </div>
  </div>
</div>

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
