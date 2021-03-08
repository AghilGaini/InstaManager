//Base Functions
function SetCurrentPageTitle(page) {
    debugger;
    $("#pageTitle").html(page);
}

//---------------------

function AfterPageLoad() {
    if ($("#pageTitle").html() == "") {
        if (document.title != "")
            SetCurrentPageTitle(document.title);
        else
            SetCurrentPageTitle(GetCurrentPage().split(".")[0]);
    }

    if ($("#panelName").html() == "") {
        $("#panelName").html("(" + GetCookie("username") + ") " + PanelName);
    }
}

window.onload = function () {
    AfterPageLoad();
}

