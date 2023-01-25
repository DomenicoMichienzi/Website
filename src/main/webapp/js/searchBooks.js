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

function handleSearch(response) {
    // reset buttons from success (green) to danger (red)
    $(".btn-success").each(function () {
        $(this).removeClass("btn-success").addClass("btn-danger").text("Add to Library");
    });

    // hide cards
    $(".card").hide();

    // TODO - change with forEach and fix index with cards in the page
    for(let i = 0; i < 10; i++) {
        let coverURL = response.items[i].volumeInfo?.imageLinks?.thumbnail,
            authors = response.items[i].volumeInfo?.authors,
            title = response.items[i].volumeInfo?.title,
            book_id = response.items[i]?.id;

        console.table({coverURL, authors, title, book_id});

        // Add book_id to the button
        $("#btn" + i).attr("btn_book_id", book_id);

        // Fill card with contents
        $("#card_" + i + " .img-fluid").attr("src", coverURL);
        $("#card_" + i + " .card-title").text(title);
        $("#card_" + i + " .card-authors").text(authors);
    }

    // show only the search results
    for(let i = 0; i < response.items.length; i++) {
        $("#card_" + i).show();
    }
}

function handleAddBook(response) {
    console.log({response});
    let book_id = response?.id,
        title = response?.volumeInfo?.title,
        description = response?.volumeInfo?.description,
        isbn = response?.volumeInfo?.industryIdentifiers[1]?.identifier,
        link = response?.volumeInfo?.previewLink,
        coverURL = response?.volumeInfo?.imageLinks?.thumbnail;

    var book = new Book({
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
        // pass coverURL as a query paramater in the address
        url: "/addBook?coverURL=" + coverURL,
        contentType: "application/json",
        data: JSON.stringify(book),
        success: (response) => {
            console.log("Book successfully added");
            console.log({response});

            // TODO - Handle what to do with the response
            // change button from danger (red) to success (green)
            $("[btn_book_id=" + book_id + "]").removeClass("btn-danger").addClass("btn-success").text("Added to Library");
        }
    });
}

function searchGoogleBooksAPIs() {
    let query = $("#searchBar").val(),
        // hard coded key, for the sake of simplicity
        key = '&key=' + 'AIzaSyAKiMubw-TRmctMZMlbTXvuUrmOycPcEk0',
        maxResults = '&maxResults=' + 15;

    $.ajax({
        datatype: "json",
        url: "https://www.googleapis.com/books/v1/volumes?q=" + query + key + maxResults,
        success: handleSearch
    });
}

function addBook(book_id) {
    //console.log({book_id});

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

    for(let id = 0; id < 10; id++) {
        // Add onclick event to btn
        $("#btn" + id).on("click", function() {
            // add loading animation to button
            $(this).append('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>');

            let tmp_id = $(this).attr("btn_book_id");
            addBook(tmp_id);
        });
    }
});