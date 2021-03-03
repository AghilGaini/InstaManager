
function GetAllElemnts() {

    var all = $('[gid]');
    var items = {};

    for (i = 0; i < all.length; i++) {
        if ($(all[i]).attr('gid').length != 0) {
            var current = {};
            current.gid = $(all[i]).attr('gid');
            current.gref = $(all[i]).attr('gref') == undefined ? null : $(all[i]).attr('gref');
            current.title = $(all[i]).attr('title') == undefined ? null : $(all[i]).attr('title');
            items[i] = current;
        }
    }
}

function SetCookie(cname, cvalue, exdays, exhours, exminutes) {

    var exmiliseconds = (exdays * 24 * 60 * 60 * 1000) + (exhours * 60 * 60 * 1000) + (exminutes * 60 * 1000);

    var d = new Date();
    d.setTime(d.getTime() + exmiliseconds);
    var expires = "expires=" + d.toUTCString();
    document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}

function GetCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}

function CheckCookie(cname) {
    var user = GetCookie(cname);
    if (user != "") {
        return true;
    } else {
        return false;
    }
}

function GetCurrentPage() {
    var path = window.location.pathname;
    var page = path.split("/").pop();
    return page;
}

$(document).ready(function () {

    if (CheckCookie("username") == false && GetCurrentPage() != "Login.aspx") {
        window.location.href = "/" + WebAppName + "/Pages/Login.aspx";
    }
    else {
        SetCookie("username", GetCookie("username"), 0, 0, 15);
    }

    if (GetCurrentPage() != "Login.aspx")
        SetCookie("lastPath", window.location.href, 0, 0, 15);

    GetAllElemnts();
});



