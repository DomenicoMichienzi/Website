/*
function Book(volume_id, username_id, title, isbn, comment, link, description, done, stars) {
    this.volume_id = volume_id;
    this.username_id = username_id;
    this.title = title;
    this.isbn = isbn;
    this.comment = comment;
    this.link = link;
    this.description = description;
    this.done = done;
    this.stars = stars;
}
*/

function handleSearch(response) {
    hiddenCards();
    // TODO - indexing on for loop
    for(let i = 0; i < 10; i++) {
        /*Optional chaining (?.)
        The optional chaining (?.) operator accesses an object's property or calls a function.
        If the object is undefined or null, it returns undefined instead of throwing an error.*/
        let coverURL = response.items[i].volumeInfo?.imageLinks?.thumbnail,
            author = response.items[i].volumeInfo.authors,
            title = response.items[i].volumeInfo.title,
            volumeID = response.items[i].id;

        createCard(i, volumeID)
        addToCard(coverURL, title, author, i, volumeID);
        addToList(coverURL, title, author, i);
    }
}

// TODO rename function
function createCard(id, volumeID) {
    // Add volumeID to the btn
    $("#btn" + id).attr("btn_volume_id", volumeID);

}

function handleAddBook(response) {
    console.log(response);
    let volume_id = response.id,
        isbn = response?.volumeInfo?.industryIdentifiers[1]?.identifier,
        link = response?.volumeInfo?.canonicalVolumeLink,
        description = response?.volumeInfo?.description,
        coverURL = response.volumeInfo?.imageLinks?.thumbnail,
        title = response.volumeInfo?.title;

    var book = new Book(volume_id, null, title, isbn, null, link, description, false, null);
    console.log("coverURL: " + coverURL)
    // add book through RestAPI with ajax
    $.ajax({
        type:"POST",
        url: "/addBook?coverURL=" + coverURL,
        contentType: "application/json",
        data: JSON.stringify(book),
        success: function() {
            console.log("Book successfully added");
        }
    });
}

// TODO change with jQuery
function hiddenCards() {

    const cards = $(".card");
    cards.each(function () {
        $(this).attr("hidden", true);
    });

    /*
    const cards = document.querySelectorAll('.card');

    cards.forEach(card => {
        card.setAttribute("hidden", true);
    })*/
}

function addToList(imageURL, title, authors, id) {
    $("#list_item_" + id + " .img-thumbnail").attr("src", imageURL);

}

function addToCard(imageURL, title, authors, id, volumeID) {
    $("#card" + id + " > .card-body > .card-title").text(title);
    $("#card" + id + " > .card-body > .card-text").text(authors);
    $("#card" + id + " > .card-img-top").attr("src", imageURL);
    $("#card" + id).removeAttr("hidden");
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

function addBook(volume_id) {
    $.ajax({
        datatype: "json",
        url: "https://www.googleapis.com/books/v1/volumes/" + volume_id,
        success: handleAddBook
    });
}

$(document).ready(function() {
    // add searchGoogleBooksAPIs to searchbar on input event
    $("#searchBar").on("input", searchGoogleBooksAPIs);

    for(let id = 0; id < 10; id++) {
        // Add onclick event to btn
        $("#btn" + id).on("click", function () {
            let tmp = $(this).attr("btn_volume_id");
            addBook(tmp);
        });
    }
});