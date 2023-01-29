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

const maxItems = 35;

function handleSearch(response) {

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
        (coverURL === undefined) ? card_img.attr("src", "/assets/icons/image-not-found.svg") : card_img.attr("src", coverURL);

        $("#card_" + id + " .card-title").text(title);
        $("#card_" + id + " .card-authors").text(authors);
        $("#card_" + id + " .card-description").text(description);
    }
}

function createCard(id) {
    $("#searchResults").append(
        '<div class="card my-3 border-0" id="card_' + id + '">\n' +
        '  <div class="row g-0">\n' +
        '    <div class="col-auto">\n' +
        '      <img src="..." class="img-fluid rounded p-1" alt="...">\n' +
        '    </div>\n' +
        '    <div class="col-6">\n' +
        '      <div class="card-body ">\n' +
        '        <h5 class="card-title">Card title</h5>\n' +
        '        <p class="card-description">No description</p>\n' +
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
            }, 0);
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
        success: handleSearch
    });
}

function addBook(book_id) {
    $.ajax({
        datatype: "json",
        url: "https://www.googleapis.com/books/v1/volumes/" + book_id,
        success: handleAddBook
    });
}

// Document ready
$(document).ready(() => {
    // add searchGoogleBooksAPIs to searchbar on input event
    $("#searchBar").on("input", searchGoogleBooksAPIs);

    // switch theme
    $("#theme").on("click", function () {
        let sel = $("html"),
            theme = sel.attr("data-bs-theme");

        (theme === "dark") ? sel.attr("data-bs-theme", "light") : sel.attr("data-bs-theme", "dark");
    })
});