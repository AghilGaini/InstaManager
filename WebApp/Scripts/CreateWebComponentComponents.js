function CreateGridView(gridID, data, keyFieldName, showPageSizeSelector, pageSize, allowedPageSizes, showInfo, showColumnLines, showRowLines, showBorders, rowAlternationEnabled,allowColumnResizing, columnResizingMode, columnAutoWidth, columns){
    $("#" + gridID).dxDataGrid({
        dataSource: data,
        keyExpr: keyFieldName,
        selection: {
            mode: "single"
        },
        paging: {
            pageSize: pageSize
        },
        pager: {
            showPageSizeSelector: showPageSizeSelector,
            allowedPageSizes: allowedPageSizes,
            showInfo: showInfo,
            infoText: 'صفحه {0} از {1} - تعداد کل {2}'
        },
        showColumnLines: showColumnLines,
        showRowLines: showRowLines,
        showBorders: showBorders,
        rowAlternationEnabled: rowAlternationEnabled,
        allowColumnResizing: allowColumnResizing,
        columnResizingMode: columnResizingMode,
        columnAutoWidth: columnAutoWidth,
        noDataText: "داده ای برای نمایش وجود ندارد",
        columns: columns,
        onSelectionChanged: function (selectedItems) {
            hdn.Set(gridID, selectedItems.selectedRowsData[0]);
        }
    });


}

function CreateTreeList(treeListID, data, keyField, parentField, showRowLines, showBorders, columnAutoWidth,allowColumnResizing,columns) {
    $("#" + treeListID).dxTreeList({
        dataSource: data,
        rootValue: -1,
        selection: {
            mode: "single"
        },
        keyExpr: keyField,
        parentIdExpr: parentField,
        noDataText: "داده ای برای نمایش وجود ندارد",
        columns: columns,
        expandedRowKeys: [1],
        showRowLines: showRowLines,
        showBorders: showBorders,
        columnAutoWidth: columnAutoWidth,
        allowColumnResizing: allowColumnResizing,
        onSelectionChanged: function (selectedItems) {
            hdn.Set(treeListID, selectedItems.selectedRowsData[0]);
        }
    });
}

//function UploadFile(fileUploadID,filesCount,AfterSave) {
//    var fileUpload = $("#" + fileUploadID).get(0);
//    if (fileUpload == 'undefined')
//        return;

//    var files = fileUpload.files;
//    if (files.length != filesCount)
//        return;

//    var fileData = new FormData();
//    for (var i = 0; i < files.length; i++) {

//        if (files[i].type != 'image/jpeg')
//            continue;

//        fileData.append(files[i].name, files[i]);
//    }

//    $.ajax({
//        type: 'POST',
//        data: fileData,
//        contentType: false,
//        processData: false,
//        async: false,
//        url: '<%= ResolveUrl("~")%>Classes/Handlers/FileUploadHandler.ashx',
//        success: function (data) {
//            AfterSave(Res);
//        },
//        error: function (data) {
//            alert('Server Connection');
//        }
//    })
//}
