<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="en">
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Books Page</title>

  <!-- Bootstrap CSS -->
  <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Bootstrap JavaScript -->
  <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- jQuery from GoogleAPIs-->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

  <!-- local JavaScript -->
  <script src="${pageContext.request.contextPath}/js/booksPage.js"></script>

</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container-fluid">
    <c:choose>
      <c:when test="${username != null}">
        <a class="navbar-brand" href="/">${username}</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarScroll" aria-controls="navbarScroll" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarScroll">
          <ul class="navbar-nav me-auto my-2 my-lg-0 navbar-nav-scroll" style="--bs-scroll-height: 100px;">
            <li class="nav-item">
              <a class="nav-link active" aria-current="page" href="/getBooks">My Books</a>
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
  <h1>My Books</h1>
  <p> List of Book:</p>
  <div class="row row-cols-md-auto">
    <c:forEach items="${books}" var="book">
      <div class="col">
        <div class="card w-100 text-wrap" style="height: 35em; width: 15em" id="${book.volume_id}">
          <div class="card-body" style="width: 15em">
            <img src="${pageContext.request.contextPath}/assets/books/covers/${book.username_id}/${book.volume_id}.png" class="card-img" alt="...">
            <h5 class="card-title">${book.title}</h5>
            <p class="card-text"></p>
            <!-- Button trigger modal -->
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#Modal_${book.volume_id}">Modal</button>
            <!-- Modal -->
            <div class="modal fade" id="Modal_${book.volume_id}" tabindex="-1" aria-labelledby="ModalLabel" aria-hidden="true">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <h1 class="modal-title fs-5">Modal title</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                    <form>
                      <div class="mb-3">
                        <a class="text-bg-dark">${book.title}</a>
                      </div>
                      <div class="mb-3">
                        <label for="rating_${book.volume_id}" class="form-label">Rating: ${book.rating}</label>
                        <input type="range" class="form-range" min="0" max="10" step="0.5" value="${book.rating}" id="rating_${book.volume_id}">
                        <a class="text-bg-dark current-rating" id="current_rating_${book.volume_id}">Ciaone</a>
                      </div>
                      <div class="mb-3">
                        <label for="review-text_${book.volume_id}" class="col-form-label">Review</label>
                        <textarea class="form-control" id="review-text_${book.volume_id}">${book.review}</textarea>
                      </div>
                      <div class="mp-3">
                        <label for="comment-text_${book.volume_id}" class="col-form-label">Comment</label>
                        <textarea class="form-control" id="comment-text_${book.volume_id}">${book.comment}</textarea>
                      </div>
                    </form>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary saveChangesBtn" data-book_id="${book.volume_id}">Save changes</button>
                  </div>
                </div>
              </div>
            </div>
            <button type="button" class="btn btn-danger" data-btn_volume_id="${book.volume_id}">Delete</button>
          </div>
        </div>
      </div>
    </c:forEach>
  </div>
</div>

</body>
</html>
