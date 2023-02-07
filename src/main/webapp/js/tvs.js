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

function updateTv(tv_id) {
    // retrieve rating, review and comment from the modal
    let rating = $("#rating_" + tv_id).val(),
        review = $("#review-text_" + tv_id).val(),
        comment = $("#comment-text_" + tv_id).val();

    // create a dummy Tv object
    let tv = new Tv({
        tv_id: tv_id,
        rating: rating,
        review: review,
        comment: comment
    });

    // update Tv through RestAPI with ajax
    $.ajax({
        type: "POST",
        url: "/updateTv",
        contentType: "application/json",
        data: JSON.stringify(tv),
        success: (response) => {
            // delay animation for aesthetics reasons
            setTimeout(() => {
                $(".saveChangesBtn").find(".spinner-border").remove();
            }, 1000);
        }
    })
}

function removeTv(tv_id) {
    $.ajax({
        type: "POST",
        url: "/removeTv",
        contentType: "application/json",
        data: tv_id,
        success: () => {
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

    // for each save button add the function to updateTv
    $(".saveChangesBtn").each(function () {
        $(this).on("click", function (){

            if(!$(this).find(".spinner-border").length) {
                $(this).append('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>');
            }

            let tv_id = $(this).attr("data-tv_id");
            updateTv(tv_id);
        });
    });

    // for each button of the Tvs add the function to delete it from the library
    $(".card-body > .btn-danger").each(function() {
        $(this).on("click", function() {
            let tv_id = $(this).attr("data-btn_tv_id");
            removeTv(tv_id);

            // removing column of card
            $("#" + tv_id).remove();
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