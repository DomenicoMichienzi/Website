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
    rating = $("#rating_" + book_id).val();
    review = $("#review-text_" + book_id).val();
    comment = $("#comment-text_" + book_id).val();

    console.log({book_id, rating, review, comment});

    // create a dummy Book object
    var book = new Book({
        book_id: book_id,
        rating: rating,
        review: review,
        comment: comment
    })
    console.log({book});
    console.log({book_id, rating, review, comment});

    // update book through RestAPI with ajax
    $.ajax({
        type: "POST",
        url: "/updateBook",
        contentType: "application/json",
        data: JSON.stringify(book),
        success: () => {
            console.log("Rating, Review and Comment successfully update");
        }
    })
}

function handleBook(response) {
    let Book = response.volumeInfo,
        author = Book.authors,
        title = Book.title,
        description = Book.description,
        coverURL = Book?.imageLinks?.thumbnail;

    addToCard(coverURL, author, title, description, response.id);
}

function addToCard(imageURL, authors, title, description, id) {
    $("#" + id + " > .card-body > .card-title").text(title);
    $("#" + id + " > .card-body > .card-text").text(authors);
    $("#" + id + " > .card-body > .card-img-bottom").attr("src", imageURL);
}

function loadBooks() {
    let items = document.querySelectorAll(".card.w-75");
    for(let i = 0; i < items.length; i++) {
        let volumeID = items[i].id;
        $.ajax({
            datatype: "json",
            url: "https://www.googleapis.com/books/v1/volumes/" + volumeID,
            success: handleBook
        });
    }
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


$(document).ready(function () {

    const popoverTriggerList = document.querySelectorAll('[data-bs-toggle="popover"]')
    const popoverList = [...popoverTriggerList].map(popoverTriggerEl => new bootstrap.Popover(popoverTriggerEl))

    // add current rating for modal
    $(".form-range").each(function () {
       $(this).on("input", function () {
           let current = $(this).val();
           $(this).siblings(".current-rating").text(current);
       })
    });

    // for each save button add the function to updateBook
    $(".saveChangesBtn").each(function () {
        $(this).on("click", function (){
            let book_id = $(this).attr("data-book_id");
            updateBook(book_id);

            // TODO - Adding animations on success
        });
    });

    // for each button of the books add the function to delete it from the library
    $(".card-body > .btn-danger").each(function() {
        $(this).on("click", function() {
            let vol_id = $(this).attr("data-btn_volume_id");
            removeBook(vol_id);

            // removing card
            $("#" + vol_id).remove();
        })
    });
});