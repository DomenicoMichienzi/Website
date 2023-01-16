class Movie{
    constructor({
        movie_id,
        username_id,
        title,
        comment,
        description,
        viewed,
        stars
    }) {
        this.movie_id = movie_id;
        this.username_id = username_id;
        this.title = title;
        this.comment = comment;
        this.description = description;
        this.viewed = viewed;
        this.stars = stars;
    }
}

function handleSearchTMDB(response) {

    // hide cards
    $(".list-group-item").hide();

    // TODO - change with forEach and fix index with cards in the page
    for(let i = 0; i < 10 && i < response.results.length; i++) {
        let imageURL = "https://image.tmdb.org/t/p/w500" + response.results[i]?.poster_path,
            title = response.results[i]?.title,
            overview = response.results[i]?.overview,
            movie_id = response.results[i]?.id;

        createCard(i, movie_id);
        addToCard(i, imageURL, title, overview);
    }

    // shows only the search results
    for(let i = 0; i < response.results.length; i++) {
        $("#list_item_" + i).show();
    }
}

function createCard(id, movie_id) {
    $("#btn" + id).attr("btn_movie_id", movie_id);
}

function addToCard(id, imageURL, title, description) {
    $("#list_item_" + id + " .img-thumbnail").attr("src", imageURL);
    $("#list_item_" + id + " .text-body").text(title);
}

function searchTMDB() {
    let query = $("#searchBar").val();
    let apiKey = "?api_key=cf2703906ceb370d03128f8d53436252",
        lang = "&language=it-IT";

    $.ajax({
       datatype: "json",
       url: "https://api.themoviedb.org/3/search/movie" + apiKey + "&page=1&include_adult=false&query=" + query + lang,
       success: handleSearchTMDB
    });
}

function handleAddMovie(response) {
    let movie_id = response.id,
        description = response.overview,
        title = response.title,
        posterPath = response.poster_path;

    var movie = new Movie({
        movie_id: movie_id,
        username_id: null,
        title: title,
        comment: null,
        description: description,
        viewed: false,
        stars: null
    });

    // Add movie through RestAPI with ajax
    $.ajax({
        type: "POST",
        // pass posterPath as a query paramater in the address
        url: "/addMovie?poster=" + posterPath,
        contentType: "application/json",
        data: JSON.stringify(movie),
        success:() => {
            console.log("Movie successfully added");
       }
    });
}

function addMovie(movie_id) {
    let apiKey = "?api_key=cf2703906ceb370d03128f8d53436252",
        lang = "&language=it-IT";
        url = "https://api.themoviedb.org/3/movie/" + movie_id + apiKey + lang;
        console.log(url);
    $.ajax({
        datatype: "json",
        url: url,
        success: handleAddMovie
    })
}

$(document).ready(() => {
    for(let id = 0; id < 10; id++) {
        // Add onclick event to btn
        $("#btn" + id).on("click", function () {
            let tmp_movie_id = $(this).attr("btn_movie_id");
            console.log(tmp_movie_id);
            addMovie(tmp_movie_id);
        });
    }
});

$(document).ready(() => {
    $(".btn.btn-light").on("click", searchTMDB);
});