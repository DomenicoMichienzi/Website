class Book {
    constructor({
        book_id,
        username_id,
        title,
        isbn,
        comment,
        link,
        description,
        done,
        stars
    }) {
        this.volume_id = book_id;
        this.username_id = username_id;
        this.title = title;
        this.isbn = isbn;
        this.comment = comment;
        this.link = link;
        this.description = description;
        this.done = done;
        this.stars = stars;
    }
}

function handleSearch(response) {
    console.log(response);

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
    let book_id = response?.id,
        title = response?.volumeInfo?.title,
        description = response?.volumeInfo?.description,
        isbn = response?.volumeInfo?.industryIdentifiers[1]?.identifier,
        link = response?.volumeInfo?.volumeInfo?.canonicalVolumeLink,
        coverURL = response?.volumeInfo?.imageLinks?.thumbnail;

    var book = new Book({
        book_id: book_id,
        username_id: null,
        title: title,
        isbn: isbn,
        comment: null,
        link: link,
        description: description,
        done: false,
        stars: null
    });

    // Add book through RestAPI with ajax
    $.ajax({
        type: "POST",
        // pass coverURL as a query paramater in the address
        url: "/addBook?coverURL=" + coverURL,
        contentType: "application/json",
        data: JSON.stringify(book),
        success: () => {
            console.log("Book successfully added");
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
    console.log({book_id});

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
            let tmp_id = $(this).attr("btn_book_id");
            addBook(tmp_id);
        });
    }
});