function CreateGridView(gridID, data, keyFieldName, showPageSizeSelector, pageSize, allowedPageSizes, showInfo, showColumnLines, showRowLines, showBorders, rowAlternationEnabled, allowColumnResizing, columnResizingMode, columnAutoWidth, columns,Isexport,onExportingFunction,excelFileName,excelWorksheet) {
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
        export: {
            enabled: Isexport
        },
        onExporting: function (e) {
            if (!onExportingFunction)
            {
                var workbook = new ExcelJS.Workbook();
                var worksheet = workbook.addWorksheet('WorkSheet');
                DevExpress.excelExporter.exportDataGrid({
                    component: e.component,
                    worksheet: worksheet,
                    keepColumnWidths: false,
                }).then(function () {
                    workbook.xlsx.writeBuffer().then(function (buffer) {
                        saveAs(new Blob([buffer], { type: "application/octet-stream" }), gridID + ".xlsx");
                    });
                });
                e.cancel = true;
            }
            else
                onExportingFunction(e, excelFileName, excelWorksheet);
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

function CreateComboBoxWithURL(comboBoxID, URL, key, displayExpr, valueExpr, showClearButton, rtlEnabled, placeholder, width, height) {

    $.ajax({
        type: 'GET',
        url: URL,
        contentType: "application/json; charset=utf-8",
        dataType: "json"
    }).then(
        function (data) {
            CreateComboBox(comboBoxID, data.payload, key, displayExpr, valueExpr, showClearButton, rtlEnabled, placeholder, width, height);
        },
        function (data) {
            ShowError("data: " + data.d, "عدم برقراری ارتباط");
        }
    )


}

function CreateTextBox(textBoxID, placeholder, showClearButton, value, mask, maskInvalidMessage, maskRules, rtlEnabled) {
    $("#" + textBoxID).dxTextBox({
        placeholder: (!placeholder ? null : placeholder),
        showClearButton: showClearButton,
        value: (!value ? null : value),
        mask: (!mask ? null : mask),
        maskInvalidMessage: (!maskInvalidMessage ? null : maskInvalidMessage),
        maskRules: (!maskRules ? null : maskRules),
        rtlEnabled: rtlEnabled,
        onValueChanged: function (selectedItems) {
            hdn.Set(textBoxID, selectedItems.value);
        }
    });
}

function CreateNumericBox(numbericBoxID, value, format, step, showSpinButtons, placeholder, showClearButton, invalidValueMessage, width, height, max, min, rtlEnabled) {
    $("#" + numbericBoxID).dxNumberBox({
        format: !format ? null : format,
        value: !value ? null : value,
        step: !step ? null : step, // 1 Step = 100 Unit
        showSpinButtons: showSpinButtons,
        showClearButton: showClearButton,
        placeholder: !placeholder ? null : placeholder,
        invalidValueMessage: !invalidValueMessage ? null : invalidValueMessage,
        width: width,
        height: height,
        max: max,
        min: min,
        rtlEnabled: rtlEnabled,
        onValueChanged: function (selectedItems) {
            hdn.Set(numbericBoxID, selectedItems.value);
        }
    });
}

function CreateTextArea(textAreaID, value, placeholder, autoResizeEnabled, height, weight, rtlEnabled) {
    $("#" + textAreaID).dxTextArea({
        value: !value ? null : value,
        placeholder: !placeholder ? null : placeholder,
        autoResizeEnabled: autoResizeEnabled,
        height: !height ? null : height,
        weight: !weight ? null : weight,
        rtlEnabled: rtlEnabled,
        onValueChanged: function (selectedItems) {
            hdn.Set(textAreaID, selectedItems.value);
        }
    });
}

function CreateCheckBox(CheckBoxID, value, width, height) {
    $("#" + CheckBoxID).dxCheckBox({
        value: value,
        width: width,
        height: height,
        onValueChanged: function (data) {
            hdn.Set(CheckBoxID, data.value);
        }
    });
}

function CreateButton(buttonID, stylingMode, text, type, width, disabled, icon) {
    $("#" + buttonID).dxButton({
        stylingMode: stylingMode,
        text: text,
        type: type,
        width: width,
        icon : icon,
        disabled: disabled//, 
        //onClick: function () {
        //    onClickFunction();
        //}
    });
}

function CreateContextMenu(contextMenuID, data, target, width,onItemClickFunction) {
    $("#" + contextMenuID).dxContextMenu({
        dataSource: data,
        width: width,
        target: "#" + target,
        onItemClick: function (e) {
            if (!e.itemData.items) {
                onItemClickFunction(e);
                //DevExpress.ui.notify("The \"" + e.itemData.text + "\" item was clicked", "success", 1500);
            }
        }
    });
}

function CreateToast(message, type, time, height, width) {
    DevExpress.ui.notify({
        message: message,
        type: type,
        displayTime: time,
        height: height,
        width: width
    });
}


