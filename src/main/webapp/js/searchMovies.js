class Movie{
    constructor({
                    movie_id = null,
                    username_id = null,
                    title = null,
                    description = null,
                    review = null,
                    rating = 0.0,
                    comment = null
    }) {
        this.movie_id = movie_id;
        this.username_id = username_id;
        this.title = title;
        this.description = description;
        this.review = review;
        this.rating = rating;
        this.comment = comment;
    }
}

const maxItems = 35;

function handleSearchTMDB(response) {

    // reset buttons from success (green) to danger (red)
    $(".btn-success").each(function () {
        $(this).removeClass("btn-success").addClass("btn-danger").text("Add to Library");
    });

    // remove cards
    $(".card").remove();

    // TODO - change with forEach and fix index with cards in the page
    for(let id = 0; id < maxItems && id < response.results.length; id++) {
        let imageURL = "https://image.tmdb.org/t/p/w500" + response.results[id]?.poster_path,
            title = response.results[id]?.title,
            overview = response.results[id]?.overview,
            movie_id = response.results[id]?.id;

        createCard(id);

        let tmp_btn = $("#btn" + id);
        // Add onclick event to btn
        tmp_btn.on("click", function() {
            // add loading animation to button if not already present
            if(!$(".spinner-border").length) {
                $(this).append('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>');
            }

            let tmp_id = $(this).attr("data-btn_movie_id");
            addMovie(tmp_id);
        });

        // Add movie_id to the button
        tmp_btn.attr("data-btn_movie_id", movie_id);

        // Fill card with contents

        // cover thumbnail
        let card_img = $("#card_" + id + " .img-fluid");
        (imageURL === undefined) ? card_img.attr("src", "/assets/icons/image-not-found.svg") : card_img.attr("src", imageURL);

        $("#card_" + id + " .card-title").text(title);
        //$("#card_" + id + " .card-authors").text(authors);
        $("#card_" + id + " .card-overview").text(overview);
    }


}

function createCard(id) {
    $("#searchResults").append(
        '<div class="card my-3 border-0" id="card_' + id + '">\n' +
        '  <div class="row g-0">\n' +
        '    <div class="col-auto">\n' +
        '      <img src="..." class="img-fluid rounded p-1" alt="...">\n' +
        '    </div>\n' +
        '    <div class="col-6">\n' +
        '      <div class="card-body ">\n' +
        '        <h5 class="card-title">Card title</h5>\n' +
        '        <p class="card-overview">This is a wider card with supporting text below as.</p>\n' +
        '        <p class="card-authors"><small class="text-muted">AUTORI</small></p>\n' +
        '        <button type="button" class="btn btn-danger btn-sm" id="btn' + id + '">\n' +
        '          Add to Library\n' +
        '        </button>\n' +
        '      </div>\n' +
        '    </div>\n' +
        '  </div>\n' +
        '</div>'
    );
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

    let movie = new Movie({
        movie_id: movie_id,
        username_id: null,
        title: title,
        description: description,
        review: null,
        rating: null,
        comment: null
    });

    // Add movie through RestAPI with ajax
    $.ajax({
        type: "POST",
        // pass posterPath as a query parameter in the address
        url: "/addMovie?poster=" + posterPath,
        contentType: "application/json",
        data: JSON.stringify(movie),
        success:(response) => {

            // delay animation for aesthetics reasons
            setTimeout(() => {
                let btn = $("[data-btn_movie_id=" + movie_id + "]");
                if(response === "exists") {
                    // change button from danger (red) to warning (yellow)
                    btn.removeClass("btn-danger btn-success").addClass("btn-warning").text("Already Added ");
                }

                if (response === "Success") {
                    // change button from danger (red) to success (green)
                    btn.removeClass("btn-danger").addClass("btn-success").text("Added to Library ");
                }
            }, 1250);

       }
    });
}

function addMovie(movie_id) {
    let apiKey = "?api_key=cf2703906ceb370d03128f8d53436252",
        lang = "&language=it-IT",
        url = "https://api.themoviedb.org/3/movie/" + movie_id + apiKey + lang;
    $.ajax({
        datatype: "json",
        url: url,
        success: handleAddMovie
    })
}

// Document ready
$(document).ready(() => {
    // add searchTMDB to searchbar on input event
    $("#searchBar").on("input", searchTMDB);

    // switch theme
    $("#theme").on("click", function () {
        let sel = $("html"),
            theme = sel.attr("data-bs-theme");

        (theme === "dark") ? sel.attr("data-bs-theme", "light") : sel.attr("data-bs-theme", "dark");
    })
});