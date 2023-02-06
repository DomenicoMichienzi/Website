class Book {
    constructor({
        book_id = null,
        username_id = null,
        title = null,
        link = null,
        description = null,
        review = null,
        rating = 0.0,
        comment = null
    }) {
        this.volume_id = book_id;
        this.username_id = username_id;
        this.title = title;
        this.link = link;
        this.description = description;
        this.review = review;
        this.rating = rating;
        this.comment = comment;
    }
}

class Movie {
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

class Tv {
    constructor({
                    tv_id = null,
                    username_id = null,
                    title = null,
                    description = null,
                    review = null,
                    rating = 0.0,
                    comment = null
                }) {
        this.tv_id = tv_id;
        this.username_id = username_id;
        this.title = title;
        this.description = description;
        this.review = review;
        this.rating = rating;
        this.comment = comment;
    }
}

const maxItems = 35;

// Movie functions
// ====================================
function searchMovieTMDB() {
    let query = $("#searchBar").val(),
        apiKey = "?api_key=cf2703906ceb370d03128f8d53436252",
        lang = "&language=it-IT";

    $.ajax({
        datatype: "json",
        url: "https://api.themoviedb.org/3/search/movie" + apiKey + "&page=1&include_adult=false&query=" + query + lang,
        success: handleSearchMovieTMDB
    });
}

function handleSearchMovieTMDB(response) {

    // reset buttons from success (green) to danger (red)
    $(".btn-success").each(function () {
        $(this).removeClass("btn-success").addClass("btn-danger").text("Add to Library");
    });

    // remove cards
    $(".card").remove();

    // TODO - change with forEach and fix index with cards in the page
    for(let id = 0; id < maxItems && id < response.results.length; id++) {
        let posterPath = response.results[id]?.poster_path,
            imageURL = "https://image.tmdb.org/t/p/w342" + posterPath,
            title = response.results[id]?.title,
            overview = response.results[id]?.overview,
            movie_id = response.results[id]?.id,
            release_date = response.results[id].release_date;

        createCardMovie(id);

        let tmp_btn = $("#btn" + id);
        // Add onclick event to btn
        tmp_btn.on("click", function() {
            // add loading animation to button if not already present
            if(!$(this).find(".spinner-border").length) {
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
        if (posterPath === undefined || posterPath == null) {
            card_img.attr("src", "/assets/icons/image-not-found.svg")
            card_img.attr("style", "max-width: 8.5em;")
        } else {
            card_img.attr("src", imageURL)
        }

        $("#card_" + id + " .card-title").text(title);
        $("#card_" + id + " .card-overview").text(overview);

        const date = new Date(release_date);
        $("#card_" + id + " .card-date").text(date.toLocaleDateString());
    }


}

function createCardMovie(id) {
    $("#searchResults").append(
        '<div class="card my-3 border-0" id="card_' + id + '">\n' +
        '  <div class="row g-0">\n' +
        '    <div class="col-2 m-3 text-end">\n' +
        '      <img src="..." class="img-fluid rounded-3 p-1" alt="...">\n' +
        '    </div>\n' +
        '    <div class="col-7">\n' +
        '      <div class="card-body">\n' +
        '        <h5 class="card-title">...</h5>\n' +
        '        <p class="card-overview">...</p>\n' +
        '        <p class="card-date">...</p>\n' +
        '        <button type="button" class="btn btn-danger btn-sm" id="btn' + id + '">\n' +
        '          Add to Library\n' +
        '        </button>\n' +
        '      </div>\n' +
        '    </div>\n' +
        '  </div>\n' +
        '</div>'
    );
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
            }, 1150);

        }
    });
}

// ====================================


// Tv functions
// ====================================
function searchTvTMDB() {
    let query = $("#searchBar").val(),
        apiKey = "?api_key=cf2703906ceb370d03128f8d53436252",
        lang = "&language=it-IT";

    $.ajax({
       datatype: "json",
       url: "https://api.themoviedb.org/3/search/tv" + apiKey + "&page=1&include_adult=false&query=" + query + lang,
        success: handleSearchTvTMDB
    });
}

function handleSearchTvTMDB(response) {
    console.log(response);
    // reset buttons from success (green) to danger (red)
    $(".btn-success").each(function () {
        $(this).removeClass("btn-success").addClass("btn-danger").text("Add to Library");
    });

    // remove cards
    $(".card").remove();

    // TODO - change with forEach and fix index with cards in the page
    for(let id = 0; id < maxItems && id < response.results.length; id++) {
        let posterPath = response.results[id]?.poster_path,
            imageURL = "https://image.tmdb.org/t/p/w342" + posterPath,
            title = response.results[id]?.name,
            overview = response.results[id]?.overview,
            tv_id = response.results[id]?.id,
            first_air_date = response.results[id].first_air_date;

        createCardTv(id);

        let tmp_btn = $("#btn" + id);

        // Add onclick event to btn
        tmp_btn.on("click", function() {
            // add loading animation to button if not already present
            if(!$(this).find(".spinner-border").length) {
                $(this).append('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>');
            }

            let tmp_id = $(this).attr("data-btn_tv_id");
            addTv(tmp_id);
        });

        // Add tv_id to the button
        tmp_btn.attr("data-btn_tv_id", tv_id);

        // Fill card with contents

        // cover thumbnail
        let card_img = $("#card_" + id + " .img-fluid");
        if (posterPath === undefined || posterPath == null) {
            card_img.attr("src", "/assets/icons/image-not-found.svg")
            card_img.attr("style", "max-width: 8.5em;")
        } else {
            card_img.attr("src", imageURL)
        }

        $("#card_" + id + " .card-title").text(title);
        $("#card_" + id + " .card-overview").text(overview);

        const date = new Date(first_air_date);
        $("#card_" + id + " .card-date").text(date.toLocaleDateString());
    }
}

function createCardTv(id) {
    $("#searchResults").append(
        '<div class="card my-3 border-0" id="card_' + id + '">\n' +
        '  <div class="row g-0">\n' +
        '    <div class="col-2 m-3 text-end">\n' +
        '      <img src="..." class="img-fluid rounded-3 p-1" alt="...">\n' +
        '    </div>\n' +
        '    <div class="col-7">\n' +
        '      <div class="card-body">\n' +
        '        <h5 class="card-title">...</h5>\n' +
        '        <p class="card-overview">...</p>\n' +
        '        <p class="card-date">...</p>\n' +
        '        <button type="button" class="btn btn-danger btn-sm" id="btn' + id + '">\n' +
        '          Add to Library\n' +
        '        </button>\n' +
        '      </div>\n' +
        '    </div>\n' +
        '  </div>\n' +
        '</div>'
    );
}

function addTv(tv_id) {
    let apiKey = "?api_key=cf2703906ceb370d03128f8d53436252",
        lang = "&language=it-IT",
        url = "https://api.themoviedb.org/3/tv/" + tv_id + apiKey + lang;
    $.ajax({
        datatype: "json",
        url: url,
        success: handleAddTv
    })
}

function handleAddTv(response) {
    let tv_id = response.id,
        description = response.overview,
        title = response.name,
        posterPath = response.poster_path;

    let tv = new Tv({
        tv_id: tv_id,
        username_id: null,
        title: title,
        description: description,
        review: null,
        rating: null,
        comment: null
    });

    // Add tv through RestAPI with ajax
    $.ajax({
        type: "POST",
        // pass posterPath as a query parameter in the address
        url: "/addTv?poster=" + posterPath,
        contentType: "application/json",
        data: JSON.stringify(tv),
        success:(response) => {

            // delay animation for aesthetics reasons
            setTimeout(() => {
                let btn = $("[data-btn_tv_id=" + tv_id + "]");
                if(response === "exists") {
                    // change button from danger (red) to warning (yellow)
                    btn.removeClass("btn-danger btn-success").addClass("btn-warning").text("Already Added ");
                }

                if (response === "Success") {
                    // change button from danger (red) to success (green)
                    btn.removeClass("btn-danger").addClass("btn-success").text("Added to Library ");
                }
            }, 1150);

        }
    });
}
// ====================================


// Book functions
// ====================================
function handleSearchBook(response) {

    // reset buttons from success (green) to danger (red)
    $(".btn-success").each(function () {
        $(this).removeClass("btn-success").addClass("btn-danger").text("Add to Library");
    });

    // remove cards
    $(".card").remove();

    // TODO - change with forEach and fix index with cards in the page
    for(let id = 0; id < maxItems; id++) {
        let coverURL = response.items[id].volumeInfo?.imageLinks?.thumbnail,
            authors = response.items[id].volumeInfo?.authors,
            title = response.items[id].volumeInfo?.title,
            book_id = response.items[id]?.id,
            description = response.items[id]?.volumeInfo?.description;

        createCard(id);

        let tmp_btn = $("#btn" + id);
        // Add onclick event to btn
        tmp_btn.on("click", function() {
            // add loading animation to button if not already present
            if(!$(this).find(".spinner-border").length) {
                $(this).append('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>');
            }

            let tmp_id = $(this).attr("data-btn_book_id");
            addBook(tmp_id);
        });

        // Add book_id to the button
        tmp_btn.attr("data-btn_book_id", book_id);

        // Fill card with contents

        // cover thumbnail
        let card_img = $("#card_" + id + " .img-fluid");
        if (coverURL === undefined || coverURL == null) {
            card_img.attr("src", "/assets/icons/image-not-found.svg")
            card_img.attr("style", "max-width: 8.5em;")
        } else {
            card_img.attr("src", coverURL)
        }

        $("#card_" + id + " .card-title").text(title);
        $("#card_" + id + " .card-authors").text(authors);
        $("#card_" + id + " .card-description").text(description);
    }
}

function createCard(id) {
    $("#searchResults").append(
        '<div class="card my-3 border-0" id="card_' + id + '">\n' +
        '  <div class="row g-0">\n' +
        '    <div class="col-2 m-3 text-end">\n' +
        '      <img src="..." class="img-fluid rounded-3 p-1" alt="...">\n' +
        '    </div>\n' +
        '    <div class="col-7">\n' +
        '      <div class="card-body">\n' +
        '        <h5 class="card-title">...</h5>\n' +
        '        <p class="card-description">...</p>\n' +
        '        <p class="card-authors"><small class="text-muted"></small></p>\n' +
        '        <button type="button" class="btn btn-danger btn-sm" id="btn' + id + '">\n' +
        '          Add to Library\n' +
        '        </button>\n' +
        '      </div>\n' +
        '    </div>\n' +
        '  </div>\n' +
        '</div>'
    );
}

function handleAddBook(response) {
    let book_id = response?.id,
        title = response?.volumeInfo?.title,
        description = response?.volumeInfo?.description,
        link = response?.volumeInfo?.previewLink,
        coverURL = response?.volumeInfo?.imageLinks?.thumbnail;

    let book = new Book({
        book_id: book_id,
        username_id: null,
        title: title,
        link: link,
        description: description,
        review: null,
        rating: null,
        comment: null,
    });

    // Add book through RestAPI with ajax
    $.ajax({
        type: "POST",
        // pass coverURL as a query parameter in the address
        url: "/addBook?coverURL=" + coverURL,
        contentType: "application/json",
        data: JSON.stringify(book),
        success: (response) => {

            // delay animation for aesthetics reasons
            setTimeout(() => {
                let btn = $("[data-btn_book_id=" + book_id + "]");
                if(response === "exists") {
                    // change button from danger (red) to warning (yellow)
                    btn.removeClass("btn-danger btn-success").addClass("btn-warning").text("Already Added ");
                }

                if (response === "Success") {
                    // change button from danger (red) to success (green)
                    btn.removeClass("btn-danger").addClass("btn-success").text("Added to Library ");
                }
            }, 1150);
        }
    });
}

function searchGoogleBooksAPIs() {
    let query = $("#searchBar").val(),
        // hard coded key, for the sake of simplicity
        key = '&key=' + 'AIzaSyAKiMubw-TRmctMZMlbTXvuUrmOycPcEk0',
        maxResults = '&maxResults=' + maxItems;

    // book information retrieval
    $.ajax({
        datatype: "json",
        url: "https://www.googleapis.com/books/v1/volumes?q=" + query + key + maxResults,
        success: handleSearchBook
    });
}

function addBook(book_id) {
    $.ajax({
        datatype: "json",
        url: "https://www.googleapis.com/books/v1/volumes/" + book_id,
        success: handleAddBook
    });
}
// ====================================


// Document ready
$(document).ready(() => {
    $("#searchTypeRadio").change(function () {
        let selected_value = $("input[name='searchRadioOptions']:checked").val(),
            search_bar = $("#searchBar");
        switch (selected_value) {
            case "book":
                // remove any search_bar events
                search_bar.off("input");
                search_bar.off("keypress");

                // add searchGoogleBooksAPIs to searchbar on input event
                search_bar.on("input", searchGoogleBooksAPIs);
                // Enter on Keyboard
                search_bar.on("keypress", (e)=>{
                    if(e.which === 13) {
                        searchGoogleBooksAPIs();
                    }
                })
                break

            case "movie":
                // remove any search_bar events
                search_bar.off("input");
                search_bar.off("keypress");


                // add searchMovieTMDB to searchbar on input event
                search_bar.on("input", searchMovieTMDB);
                // Enter on Keyboard
                search_bar.on("keypress", (e)=>{
                    if(e.which === 13) {
                        searchMovieTMDB();
                    }
                })
                break;

            case "TvShow":
                // remove any search_bar events
                search_bar.off("input");
                search_bar.off("keypress");

                // add searchTvTMDB to searchbar on input event
                search_bar.on("input", searchTvTMDB);
                search_bar.on("keypress", (e)=>{
                    if(e.which === 13) {
                        searchTvTMDB();
                    }
                })
                break;
        }
    });
});