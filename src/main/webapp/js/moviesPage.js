function removeMovie(movie_id) {
    console.log("movie_id: " + movie_id);
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

$(document).ready(function() {
    $(".card-body > .btn").each(function() {

        $(this).on("click", function () {
            let movie_id = $(this).attr("btn_movie_id");
            removeMovie(movie_id);

            $("#" + movie_id).remove();
        })
    })
})