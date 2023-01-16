
function handleBook(response) {
    console.log("handleBook: ");
    console.log(response);
    let Book = response.volumeInfo,
        author = Book.authors,
        title = Book.title,
        description = Book.description;

    /*
    let coverURL = Book?.imageLinks?.medium;
    if(coverURL === undefined) {
        coverURL = Book?.imageLinks?.thumbnail;
    }
    */

    let coverURL = Book?.imageLinks?.thumbnail;
    console.log("coverURL: " + coverURL);
    addToCard(coverURL, author, title, description, response.id);
}

function addToCard(imageURL, authors, title, description, id) {
    $("#" + id + " > .card-body > .card-title").text(title);
    $("#" + id + " > .card-body > .card-text").text(authors);
    $("#" + id + " > .card-body > .card-img-bottom").attr("src", imageURL);
}

function loadBooks() {
    //console.log("loadBooks");
    let items = document.querySelectorAll(".card.w-75");
    for(let i = 0; i < items.length; i++) {
        let volumeID = items[i].id;
        // hard coded key, for the sake of simplicity
        //let key = '&key=' + 'AIzaSyAKiMubw-TRmctMZMlbTXvuUrmOycPcEk0';
        // console.log("volumeID = " + volumeID);
        $.ajax({
            datatype: "json",
            url: "https://www.googleapis.com/books/v1/volumes/" + volumeID,
            success: handleBook
        });
    }
}


function removeBook(volume_id) {
    console.log("v_id: " + volume_id);
    //console.log(JSON.stringify(volume_id))
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

//$(document).ready(loadBooks);
$(document).ready(function () {
    $(".card-body > .btn").each(function () {

        $(this).on("click", function () {
            let vol_id = $(this).attr("btn_volume_id");
            removeBook(vol_id);

            $("#" + vol_id).remove();
        })
    });
});