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

const maxItems = 15;

// Movie functions
// ====================================
function trendingMovies() {

    let apiKey = "?api_key=cf2703906ceb370d03128f8d53436252",
        lang = "&language=en-US";
    $.ajax({
       datatype: "json",
       url: "https://api.themoviedb.org/3/trending/movie/day" + apiKey + lang,
       success: handleTrendingMovies
    });
}

function handleTrendingMovies(response) {
    // reset buttons from success (green) to danger (red)
    $(".btn-success").each(function () {
        $(this).removeClass("btn-success").addClass("btn-danger").text("Add");
    });

    // remove cards
    // $(".card").remove();

    for (let id = 0; id < maxItems && response.results.length; id++) {
        let items = response.results,
            posterPath = items[id]?.poster_path,
            imageURL = "https://image.tmdb.org/t/p/w342" + posterPath,
            title = items[id]?.title,
            overview = items[id]?.overview,
            movie_id = items[id]?.id,
            vote_average = items[id]?.vote_average.toFixed(1),
            popularity = items[id]?.popularity;

        createCardTrendingMovie(id, movie_id);

        let tmp_btn = $("#btn_movie_" + id);
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
        let card_img = $("#card_" + id + " .card-img-top");
        if (posterPath === undefined || posterPath == null) {
            card_img.attr("src", "/assets/icons/image-not-found.svg")
            card_img.attr("style", "max-width: 8.5em;")
        } else {
            card_img.attr("src", imageURL)
        }

        $("#card_" + id + " .vote_average").text(vote_average);
        $("#card_" + id + " .card-title .text-decoration-none").text(title);
    }
}

function createCardTrendingMovie(id, movie_id) {
    $("#trendingMovies").append(
        '    <div class="card col-auto border-0" id="card_' + id + '">\n' +
        '      <img src="..." class="card-img-top rounded-3 shadow-sm" alt="...">\n' +
        '      <div class="card-body p-1">\n' +
        '        <p class="vote_average d-inline my-1"></p>\n' +
        '        <p class="card-title text-start d-flex align-items-center">\n' +
        '          <a class="text-decoration-none"\n' +
        '             href="item?item_type=movie&item_id=' + movie_id + '">\n' +
        '          </a>\n' +
        '        </p>\n' +
        '        <button type="button" class="btn btn-danger btn-sm my-2" id="btn_movie_' + id + '">\n' +
        '          Add\n' +
        '        </button>\n' +
        '      </div>\n' +
        '    </div>\n'
    );
}

function addMovie(movie_id) {
    let apiKey = "?api_key=cf2703906ceb370d03128f8d53436252",
        lang = "&language=en-US",
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
                    btn.removeClass("btn-danger").addClass("btn-success").text("Added ");
                }
            }, 1150);

        }
    });
}
// ====================================

// TVs functions
// ====================================
function trendingTVs() {
    let apiKey = "?api_key=cf2703906ceb370d03128f8d53436252",
        lang = "&language=en-US";
    $.ajax({
        datatype: "json",
        url: "https://api.themoviedb.org/3/trending/tv/day" + apiKey + lang,
        success: handleTrendingTVs
    });
}

function handleTrendingTVs(response) {
    // reset buttons from success (green) to danger (red)
    $(".btn-success").each(function () {
        $(this).removeClass("btn-success").addClass("btn-danger").text("Add");
    });

    for (let id = 0; id < maxItems && response.results.length; id++) {
        let items = response.results,
            posterPath = items[id]?.poster_path,
            imageURL = "https://image.tmdb.org/t/p/w342" + posterPath,
            title = items[id]?.name,
            overview = items[id]?.overview,
            tv_id = items[id]?.id,
            vote_average = items[id]?.vote_average.toFixed(1),
            popularity = items[id]?.popularity;

        createCardTrendingTv(id);

        let tmp_btn = $("#btn_tv_" + id);
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
        let card_img = $("#card_tv_" + id + " .card-img-top");
        if (posterPath === undefined || posterPath == null) {
            card_img.attr("src", "/assets/icons/image-not-found.svg")
            card_img.attr("style", "max-width: 8.5em;")
        } else {
            card_img.attr("src", imageURL)
        }

        $("#card_tv_" + id + " .vote_average").text(vote_average);
        $("#card_tv_" + id + " .card-title").text(title);
    }
}

function createCardTrendingTv(id) {
    $("#trendingTvShows").append(
        '    <div class="card col-auto border-0" id="card_tv_' + id + '">\n' +
        '      <img src="..." class="card-img-top rounded-3 shadow-sm" alt="...">\n' +
        '      <div class="card-body p-1">\n' +
        '        <p class="vote_average d-inline my-1"></p>\n' +
        '        <p class="card-title text-start d-flex align-items-center"></p>\n' +
        '        <button type="button" class="btn btn-danger btn-sm my-2" id="btn_tv_' + id + '">\n' +
        '          Add\n' +
        '        </button>\n' +
        '      </div>\n' +
        '    </div>\n'
    );
}

function addTv(tv_id) {
    let apiKey = "?api_key=cf2703906ceb370d03128f8d53436252",
        lang = "&language=en-US",
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
                    btn.removeClass("btn-danger").addClass("btn-success").text("Added ");
                }
            }, 1150);

        }
    });
}
// ====================================

// Book functions
// ====================================
function addBook(book_id) {
    $.ajax({
        datatype: "json",
        url: "https://www.googleapis.com/books/v1/volumes/" + book_id,
        success: handleAddBook
    });
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
                    btn.removeClass("btn-danger").addClass("btn-success").text("Added ");
                }
            }, 1150);
        }
    });
}
// ====================================


// Document ready
$(document).ready(() => {
    // calling
    trendingMovies();
    trendingTVs();

    // Add onclick event (for add book) to btn
    $(".book").find('.btn').each(function () {
        $(this).on("click", function () {
            // add loading animation to button if not already present
            if(!$(this).find(".spinner-border").length) {
                $(this).append('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>');
            }
            let tmp_id = $(this).attr("data-btn_book_id");
            addBook(tmp_id);
        });
    });
})


