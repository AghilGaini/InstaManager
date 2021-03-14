
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

function GetConnectionInfo() {
    var entity = {};
    entity.referrer = document.referrer;
    entity.browserName = navigator.appName;
    entity.browserEngine = navigator.product;
    entity.browserVersion1a = navigator.appVersion;
    entity.browserVersion1b = navigator.userAgent;
    entity.browserLanguage = navigator.languag;
    entity.javaEnabled = navigator.javaEnabled();
    entity.cookieEnabled = navigator.cookieEnabled;
    entity.screenWidth = screen.width;
    entity.screenHeight = screen.height;
    entity.innerHeight = innerHeight;
    entity.innerWidth = innerWidth;

    entity = JSON.stringify(entity);

    return entity;
}


$(document).ready(function () {

    if (CheckCookie("userinfo") == false && GetCurrentPage() != "Login.aspx") {
        window.location.href = "/" + WebAppName + "/Pages/Login.aspx";
    }
    else {
        SetCookie("userinfo", GetCookie("userinfo"), 0, 0, 15);
    }

    if (GetCurrentPage() != "Login.aspx")
        SetCookie("lastPath", window.location.href, 0, 0, 15);

    GetAllElemnts();
});



