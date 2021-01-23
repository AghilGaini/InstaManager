function CreateGridView(gridID, data, keyFieldName, showPageSizeSelector, pageSize, allowedPageSizes, showInfo, showColumnLines, showRowLines, showBorders, rowAlternationEnabled, allowColumnResizing, columnResizingMode, columnAutoWidth, columns) {
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

function CreateComboBox(comboBoxID, data, key, displayExpr, valueExpr, showClearButton, rtlEnabled, placeholder, width, height) {
    debugger;
    $("#" + comboBoxID).dxSelectBox({
        dataSource: new DevExpress.data.ArrayStore({
            data: data,
            key: key
        }),
        displayExpr: displayExpr,
        valueExpr: valueExpr,
        showClearButton: showClearButton,
        rtlEnabled: rtlEnabled,
        width: width,
        height: height,
        placeholder: placeholder == null ? "انتخاب" : placeholder,
        noDataText: "داده ای برای نمایش وجود ندارد",
        onValueChanged: function (selectedItems) {
            hdn.Set(comboBoxID, selectedItems.value);
        }
    });
}

function CreateTextBox(textBoxID, placeholder, showClearButton, value, mask, maskInvalidMessage, maskRules) {
    $("#" + textBoxID).dxTextBox({
        placeholder: (!placeholder ? null : placeholder),
        showClearButton: showClearButton,
        value: (!value ? null : value),
        mask: (!mask ? null : mask),
        maskInvalidMessage: (!maskInvalidMessage ? null : maskInvalidMessage),
        maskRules: (!maskRules ? null : maskRules),
        onValueChanged: function (selectedItems) {
            hdn.Set(textBoxID, selectedItems.value);
        }
    });
}

function CreateNumericBox(numbericBoxID, value, format, step, showSpinButtons, placeholder, showClearButton, invalidValueMessage) {
    $("#" + numbericBoxID).dxNumberBox({
        format: !format ? null : format,
        value: !value ? null : value,
        step: !step ? null : step, // 1 Step = 100 Unit
        showSpinButtons: showSpinButtons,
        showClearButton: showClearButton,
        placeholder: !placeholder ? null : placeholder,
        invalidValueMessage: !invalidValueMessage ? null : invalidValueMessage,
        onValueChanged: function (selectedItems) {
            hdn.Set(numbericBoxID, selectedItems.value);
        }
    });
}

function CreateTextArea(textAreaID, value, placeholder, autoResizeEnabled, height, weight) {
    $("#" + textAreaID).dxTextArea({
        value: !value ? null : value,
        placeholder: !placeholder ? null : placeholder,
        autoResizeEnabled: autoResizeEnabled,
        height: !height ? null : height,
        weight: !weight ? null : weight,
        onValueChanged: function (selectedItems) {
            hdn.Set(textAreaID, selectedItems.value);
        }
    });
}

function CreateToast(message, type, time, height,width) {
    DevExpress.ui.notify({
        message: message,
        type: type,
        displayTime: time,
        height: height,
        width:width
    });
}
