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

function CreateTreeList(treeListID, data, keyField, parentField, showRowLines, showBorders, columnAutoWidth, allowColumnResizing, columns) {
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

function CreateComboBox(comboBoxID, data, key, displayExpr, valueExpr, showClearButton, rtlEnabled, placeholder) {
    $("#" + comboBoxID).dxSelectBox({
        dataSource: new DevExpress.data.ArrayStore({
            data: data,
            key: key
        }),
        displayExpr: displayExpr,
        valueExpr: valueExpr,
        showClearButton: showClearButton,
        rtlEnabled: rtlEnabled,
        placeholder: placeholder == null ? "انتخاب" : placeholder,
        noDataText: "داده ای برای نمایش وجود ندارد",
        onValueChanged: function (selectedItems) {
            hdn.Set(comboBoxID, selectedItems.value);
        }
    });
}

function CreateTextBox(textBoxID, placeholder, showClearButton, value, mask, maskInvalidMessage, maskRules) {
    $("#" + textBoxID).dxTextBox({
        placeholder: (!placeholder ? null : placeholder  ),
        showClearButton: showClearButton,
        value: (!value ? null : value ),
        mask: (!mask ?  null : mask ),
        maskInvalidMessage: (!maskInvalidMessage ? null : maskInvalidMessage ),
        maskRules: (!maskRules ? null : maskRules ),
        onValueChanged: function (selectedItems) {
            hdn.Set(textBoxID, selectedItems.value);
        }
    });
}


