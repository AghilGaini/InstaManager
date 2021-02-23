function CallAjax(type, url, contentType, dataType, onSuccess, onFailure) {
    $.ajax({
        type: type,
        url: url,
        contentType: contentType,
        dataType: dataType
    }).then(
        function (data) {
            onSuccess(data);
        },
        function (data) {
            onFailure(data);
        }
    )
}

