<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Title</title>
</head>
<body>

<div class="container-fluid">
    <nav class="navbar navbar-dark bg-dark">
        <a class="navbar-brand">${username}</a>
        <a class="nav-item align-content-center" href="/">Home</a>
    </nav>
    <h1>My Books Page</h1>
    <p>
        List of books:
    </p>
    <div class="card-group">
        <c:forEach items="${books}" var="book">
            <div class="card w-75" style="max-width: 200px" id="${book.volume_id}">
                <div class="card-body">
                    <img src="..." class="card-img-bottom" alt="...">
                    <h5 class="card-title"></h5>
                    <p class="card-text"></p>
                    <a href="#" class="btn btn-primary">Delete</a>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

</body>
</html>
