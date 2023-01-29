$(document).ready(function() {

    // switch theme
    $("#theme").on("click", function () {
        let sel = $("html"),
            theme = sel.attr("data-bs-theme");

        (theme === "dark") ? sel.attr("data-bs-theme", "light") : sel.attr("data-bs-theme", "dark");
    })
});