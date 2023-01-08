function Movie(movie_id, username_id, title, comment, description, viewed, stars) {
    this.volume_id;
    this.username_id;
    this.title;
    this.comment;
    this.description;
    this.viewed;
    this.stars;
}

function handleSearch(response) {
    console.log(response);
    $(".list-group").hide();

    for(let i = 0; i < 10; i++) {
        let imageURL = response.results[i]?.image,
            title = response.results[i]?.title,
            description = response.results[i]?.description,
            movie_id = response.results[i]?.id;

        createCard(i, movie_id);
        addToCard(i, imageURL, title, description);
    }
    $(".list-group").show();
}

function createCard(id, movie_id) {
    $("#btn" + id).attr("btn_movie_id", movie_id);
}

function addToCard(id, imageURL, title, description) {
    $("#list_item_" + id + " .img-thumbnail").attr("src", imageURL);
    $("#list_item_" + id + " .text-body").text(title);
}

function searchIMDbAPIs() {
    // https://imdb-api.com/en/API/SearchMovie/k_t7ckn23o/inception 2010
    // https://imdb-api.com/en/API/SearchTitle/k_t7ckn23o/
    let query = $("#searchBar").val();
    console.log("https://imdb-api.com/en/API/SearchMovie/k_t7ckn23o/" + query);

    $.ajax({
       datatype: "json",
       url: "https://imdb-api.com/en/API/SearchMovie/k_t7ckn23o/" + query,
       success: handleSearch
    });

}

$(window).ready(function () {
    //$(".list-group").hide();
});

$(document).ready(function() {
    // add searchIMDbAPIs to searchbar on input event
    //$("#searchBar").on("click", searchIMDbAPIs);
    $(".btn.btn-light").on("click", searchIMDbAPIs);
});