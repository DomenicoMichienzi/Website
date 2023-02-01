function tradingMovies() {

    let apiKey = "?api_key=cf2703906ceb370d03128f8d53436252";

    $.ajax({
       datatype: "json",
       url: "https://api.themoviedb.org/3/trending/movie/day" + apiKey,
       success: handleTradingMovies
    });
}

function handleTradingMovies(response) {
    // reset buttons from success (green) to danger (red)
    $(".btn-success").each(function () {
        $(this).removeClass("btn-success").addClass("btn-danger").text("Add to Library");
    });

    // remove cards
    $(".card").remove();

    for (let id = 0; id < maxItems; response.results.length, id++) {
        let items = response.results,
            posterPath = items[id]?.poster_path,
            imageURL = "https://image.tmdb.org/t/p/w342" + posterPath,
            title = items[id]?.title,
            movie_id = items[id]?.id,
            vote_average = items[id]?.vote_average,
            popularity = items[id]?.popularity;

        createCardTrendingMovie(id);

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
    }
}

function createCardTrendingMovie(id) {

}

// Document ready
$(document).ready(() => {

})


