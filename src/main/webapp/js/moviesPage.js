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

            // delay animation for aesthetics reasons
            setTimeout(() => {
                $(".saveChangesBtn").find(".spinner-border").remove();
            }, 1000);
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
        }
    });
}

// Document ready
$(document).ready(function() {
    $("textarea").autoHeight()

    // add current rating for modal
    $(".form-range").each(function () {
        $(this).on("input", function () {
            let current = $(this).val();
            $(this).siblings(".current-rating").text('Current Rating: '+ current);
        })
    });

    // for each save button add the function to updateMovie
    $(".saveChangesBtn").each(function () {
        $(this).on("click", function (){

            if(!$(this).find(".spinner-border").length) {
                $(this).append('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>');
            }

            let movie_id = $(this).attr("data-movie_id");
            updateMovie(movie_id);
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

jQuery.fn.extend({
    autoHeight: function () {
        function autoHeight_(element) {
            return jQuery(element)
                .css({ "height": 0, "overflow-y": "hidden" })
                .height(element.scrollHeight);
        }
        return this.each(function() {
            autoHeight_(this).on("input", function() {
                autoHeight_(this);
            });
        });
    }
});