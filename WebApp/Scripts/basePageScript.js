//Base Functions
function SetCurrentPageTitle(page) {
    debugger;
    $("#currentPage").html(page);
}

//---------------------

function AfterPageLoad() {
    if ($("#currentPage").html() == "") {
        if (document.title != "")
            SetCurrentPageTitle(document.title);
        else
            SetCurrentPageTitle(GetCurrentPage().split(".")[0]);
    }
}

window.onload = function () {
    AfterPageLoad();
}

$(document).ready(function () {

});