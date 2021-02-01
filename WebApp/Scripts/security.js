
function GetAllElemnts() {
    debugger;

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

GetAllElemnts();



