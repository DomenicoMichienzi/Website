
const settings = {
    "async": true,
    "crossDomain": true,
    "url": "https://spotify23.p.rapidapi.com/search/?q=Sam%20Smith&type=multi&offset=0&limit=35&numberOfTopResults=5",
    "method": "GET",
    "headers": {
        "X-RapidAPI-Key": "50d88f0368msh1c2d9146f9fe91dp1cecd8jsned58d6937256",
        "X-RapidAPI-Host": "spotify23.p.rapidapi.com"
    }
};

$.ajax(settings).done(function (response) {
    console.log(response);
});