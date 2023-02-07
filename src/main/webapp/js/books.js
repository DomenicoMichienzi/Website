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

function updateBook(book_id) {
    // retrieve rating, review and comment from the modal
    let rating = $("#rating_" + book_id).val(),
        review = $("#review-text_" + book_id).val(),
        comment = $("#comment-text_" + book_id).val();

    // create a dummy Book object
    let book = new Book({
        book_id: book_id,
        rating: rating,
        review: review,
        comment: comment
    });

    // update book through RestAPI with ajax
    $.ajax({
        type: "POST",
        url: "/updateBook",
        contentType: "application/json",
        data: JSON.stringify(book),
        success: (response) => {
            // TODO - Handle response

            // delay animation for aesthetics reasons
            setTimeout(() => {
                $(".saveChangesBtn").find(".spinner-border").remove();
            }, 1000);
        }
    })
}

function removeBook(volume_id) {
    $.ajax({
        type: "POST",
        url: "/removeBook",
        contentType: "application/json",
        data: volume_id,
        success: function() {
            console.log("Book successfully removed");
        }
    });
}

// Document ready
$(document).ready(function () {
    $("textarea").autoHeight()

    // add current rating for modal
    $(".form-range").each(function () {
       $(this).on("input", function () {
           let current = $(this).val();
           $(this).siblings(".current-rating").text('Current Rating: ' + current);
       })
    });

    // for each save button add the function to updateBook
    $(".saveChangesBtn").each(function () {
        $(this).on("click", function (){

            if(!$(this).find(".spinner-border").length) {
                $(this).append('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>');
            }

            let book_id = $(this).attr("data-book_id");
            updateBook(book_id);
        });
    });

    // for each button of the books add the function to delete it from the library
    $(".card-body > .btn-danger").each(function() {
        $(this).on("click", function() {
            let vol_id = $(this).attr("data-btn_volume_id");
            removeBook(vol_id);

            // removing column of card
            $("#" + vol_id).remove();
        })
    });
});

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