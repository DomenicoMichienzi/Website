<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="en" data-bs-theme="auto">
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>TVs</title>

  <!-- jQuery from GoogleAPIs-->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">

  <!-- Bootstrap JavaScript -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>

  <!-- Bootstrap icons -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">

  <!-- local JavaScript -->
  <script src="${pageContext.request.contextPath}/js/tvs.js"></script>
  <script src="${pageContext.request.contextPath}/js/color-modes.js"></script>

  <!-- local CSS -->
  <link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/tvs.css" rel="stylesheet">

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
          <a class="nav-link active" href="${pageContext.request.contextPath}/getTVs"><i class="bi bi-tv"> TV Shows</i></a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/searchPage">
            <i class="bi bi-search active"> Search</i>
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



<!-- TVs List -->
<div class="container">
  <h2 class="m-4 text-center">TV Shows</h2>
  <div class="container">
    <div class="row justify-content-center justify-content-sm-start">
      <c:forEach items="${tvs}" var="tv">
        <div class="col-auto d-flex align-items-start p-0" id="${tv.tv_id}">
          <div class="card w-100 border-0 my-2">
            <div class="card-body">
              <!-- Poster -->
              <div class="container tv-img-container m-0 p-1">
                <img src="${pageContext.request.contextPath}/assets/tvs/posters/${tv.tv_id}.jpg"
                     class="card-img-top rounded shadow-sm" alt="...">
              </div>
              <!-- Title -->
              <p class="card-title mx-2 my-3 d-flex align-items-center">${tv.title}</p>
              <!-- Button trigger modal -->
              <button type="button" class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#Modal_${tv.tv_id}">Edit</button>
              <!-- Delete Button -->
              <button type="button" class="btn btn-sm btn-danger" data-btn_tv_id="${tv.tv_id}">Delete</button>
              <!-- Modal -->
              <div class="modal fade" id="Modal_${tv.tv_id}" tabindex="-1" aria-labelledby="ModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <!-- Title -->
                    <div class="modal-header">
                      <h3 class="modal-title">${tv.title}</h3>
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <!-- Body -->
                    <div class="modal-body">
                      <form>
                        <!-- Rating -->
                        <div class="mb-3">
                          <label for="rating_${tv.tv_id}" class="form-label">Rating: ${tv.rating}</label>
                          <input type="range" class="form-range" min="0" max="10" step="0.5" value="${tv.rating}" id="rating_${tv.tv_id}">
                          <p class="text-center current-rating" id="current_rating_${tv.tv_id}"></p>
                        </div>
                        <!-- Review -->
                        <div class="mb-3">
                          <label for="review-text_${tv.tv_id}" class="col-form-label">Review</label>
                          <textarea class="form-control" id="review-text_${tv.tv_id}">${tv.review}</textarea>
                        </div>
                        <!-- Comment -->
                        <div class="mp-3">
                          <label for="comment-text_${tv.tv_id}" class="col-form-label">Comment</label>
                          <textarea class="form-control" id="comment-text_${tv.tv_id}">${tv.comment}</textarea>
                        </div>
                      </form>
                    </div>
                    <div class="modal-footer">
                      <!-- Close Button -->
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                      <!-- Save changes Button -->
                      <button type="button" class="btn btn-primary saveChangesBtn" data-tv_id="${tv.tv_id}">Save changes</button>
                    </div>
                  </div>
                </div>
              </div>
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
