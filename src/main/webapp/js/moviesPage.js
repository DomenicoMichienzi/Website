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

function updateMovie(movie_id) {
    // retrieve rating, review and comment from the modal
    let rating = $("#rating_" + movie_id).val(),
        review = $("#review-text_" + movie_id).val(),
        comment = $("#comment-text_" + movie_id).val();

    // create a dummy Movie object
    let movie = new Movie({
        movie_id: movie_id,
        rating: rating,
        review: review,
        comment: comment
    });

    // update movie through RestAPI with ajax
    $.ajax({
        type: "POST",
        url: "/updateMovie",
        contentType: "application/json",
        data: JSON.stringify(movie),
        success: (response) => {
            // TODO - Handle response
        }
    })
}

function removeMovie(movie_id) {
    $.ajax({
        type: "POST",
        url: "/removeMovie",
        contentType: "application/json",
        data: movie_id,
        success: function() {
            console.log("Movie successfully removed ")
        }
    });
}

// Document ready
$(document).ready(function() {
    const popoverTriggerList = document.querySelectorAll('[data-bs-toggle="popover"]')
    const popoverList = [...popoverTriggerList].map(popoverTriggerEl => new bootstrap.Popover(popoverTriggerEl))

    // switch theme
    $("#theme").on("click", function () {
        let sel = $("html"),
            theme = sel.attr("data-bs-theme");

        (theme === "dark") ? sel.attr("data-bs-theme", "light") : sel.attr("data-bs-theme", "dark");
    })

    // add current rating for modal
    $(".form-range").each(function () {
        $(this).on("input", function () {
            let current = $(this).val();
            $(this).siblings(".current-rating").text(current);
        })
    });

    // for each save button add the function to updateMovie
    $(".saveChangesBtn").each(function () {
        $(this).on("click", function (){
            let movie_id = $(this).attr("data-movie_id");
            updateMovie(movie_id);

            // TODO - Adding animations on success
        });
    });

    // for each button of the movies add the function to delete it from the library
    $(".card-body > .btn-danger").each(function() {
        $(this).on("click", function() {
            let movie_id = $(this).attr("data-btn_movie_id");
            removeMovie(movie_id);

            // removing column of card
            $("#" + movie_id).remove();
        })
    });
})