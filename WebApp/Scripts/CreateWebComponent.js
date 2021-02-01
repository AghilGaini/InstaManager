//Create Components
function CreateGridView(gridID, data, keyFieldName, showPageSizeSelector, pageSize, allowedPageSizes, showInfo,
    showColumnLines, showRowLines, showBorders, rowAlternationEnabled, allowColumnResizing, columnResizingMode,
    columnAutoWidth, columns, Isexport, onExportingFunction, excelFileName, excelWorksheet,
    isExportPdf, btnPdfID, btnPdfText, fileNamePdf, actionSelectBoxID) {
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
            if (CheckNull(onExportingFunction)) {

                var excelName = CheckNull(excelFileName) ? gridID : excelFileName;
                var worksheetName = CheckNull(excelWorksheet) ? gridID : excelWorksheet;

                GeneralExportGridView(e, excelName, worksheetName);
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
        },
        onRowClick: function (e) {
            if (CheckNull(actionSelectBoxID))
                DevexpressDisable('cmbActions', false);
            else
                DevexpressDisable(actionSelectBoxID, false);
        }

    });

    if (isExportPdf) {
        CreateExportPdfButton(btnPdfID, btnPdfText, gridID, fileNamePdf);
    }

    hdn.Set(gridID + "Type", 'dxDataGrid');
}

function CreateGridViewWithURL(gridID, keyFieldName, showPageSizeSelector, pageSize, allowedPageSizes, showInfo,
    showColumnLines, showRowLines, showBorders, rowAlternationEnabled, allowColumnResizing, columnResizingMode,
    columnAutoWidth, columns, Isexport, onExportingFunction, excelFileName, excelWorksheet,
    isExportPdf, btnPdfID, btnPdfText, fileNamePdf, url, actionSelectBoxID) {

    $.ajax({
        type: 'GET',
        url: url,
        contentType: "application/json; charset=utf-8",
        dataType: "json"
    }).then(
        function (data) {

            CreateGridView(gridID, data.payload, keyFieldName, showPageSizeSelector, pageSize, allowedPageSizes, showInfo,
                showColumnLines, showRowLines, showBorders, rowAlternationEnabled, allowColumnResizing, columnResizingMode,
                columnAutoWidth, columns, Isexport, onExportingFunction, excelFileName, excelWorksheet,
                isExportPdf, btnPdfID, btnPdfText, fileNamePdf, actionSelectBoxID);
        },
        function (data) {
            ShowError("data: " + data.d, "عدم برقراری ارتباط");
        }
    )

}

function GeneralExportGridView(e, FileName, WorkSheet) {
    var workbook = new ExcelJS.Workbook();
    var worksheet = workbook.addWorksheet(WorkSheet);

    //worksheet.columns = [{ width: 5 }, { width: 50 }, { width: 50 }, { width: 80 }];

    DevExpress.excelExporter.exportDataGrid({
        component: e.component,
        worksheet: worksheet,
        keepColumnWidths: false,
        customizeCell: function (options) {
            var gridCell = options.gridCell;
            var excelCell = options.excelCell;

            if (gridCell.rowType === "data") {
            }

        }
    }).then(function () {
        workbook.xlsx.writeBuffer().then(function (buffer) {
            saveAs(new Blob([buffer], { type: "application/octet-stream" }), FileName + ".xlsx");
        });
    });
    e.cancel = true;
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

    hdn.Set(treeListID + "Type", 'dxTreeList');

}

function CreateComboBox(comboBoxID, data, key, displayExpr, valueExpr, showClearButton, rtlEnabled, placeholder, width, height, disabled,onChangeFunction) {
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
        disabled: disabled,
        onValueChanged: function (selectedItem) {
            hdn.Set(comboBoxID, selectedItem.value);
            onChangeFunction(selectedItem.value);
        }
    });

    hdn.Set(comboBoxID + "Type", 'dxSelectBox');

}

function CreateComboBoxWithURL(comboBoxID, URL, key, displayExpr, valueExpr, showClearButton, rtlEnabled, placeholder, width, height, disabled, onChangeFunction) {

    $.ajax({
        type: 'GET',
        url: URL,
        contentType: "application/json; charset=utf-8",
        dataType: "json"
    }).then(
        function (data) {
            CreateComboBox(comboBoxID, data.payload, key, displayExpr, valueExpr, showClearButton, rtlEnabled, placeholder, width, height, disabled, onChangeFunction);
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

    hdn.Set(textBoxID + "Type", 'dxTextBox');

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

    hdn.Set(numbericBoxID + "Type", 'dxNumberBox');

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

    hdn.Set(textAreaID + "Type", 'dxTextArea');

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

    hdn.Set(CheckBoxID + "Type", 'dxCheckBox');

}

function CreateButton(buttonID, stylingMode, text, type, width, disabled, icon) {
    $("#" + buttonID).dxButton({
        stylingMode: stylingMode,
        text: text,
        type: type,
        width: width,
        icon: icon,
        disabled: disabled//, 
        //onClick: function () {
        //    onClickFunction();
        //}
    });

    hdn.Set(buttonID + "Type", 'dxButton');

}

function CreateContextMenu(contextMenuID, data, target, width, onItemClickFunction) {
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

    hdn.Set(contextMenuID + "Type", 'dxContextMenu');

}

function CreateExportPdfButton(btnID, text, gridID, PdfFileName) {
    window.jsPDF = window.jspdf.jsPDF;
    applyPlugin(window.jsPDF);
    $('#' + btnID).dxButton({
        icon: 'exportpdf',
        text: text,
        onClick: function () {
            const doc = new jsPDF();
            DevExpress.pdfExporter.exportDataGrid({
                jsPDFDocument: doc,
                component: $("#" + gridID).dxDataGrid("instance")
            }).then(function () {
                doc.save(PdfFileName + '.pdf');
            });
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

//General Functions
function DevexpressGetValue(ID) {
    var dxType = hdn.Get(ID + "Type");

    var data = null;

    if (dxType == 'dxDataGrid') {

    }
    else if (dxType == 'dxTreeList') {

    }
    else if (dxType == 'dxSelectBox') {
        data = $("#" + ID).dxSelectBox('instance').option('value');
    }
    else if (dxType == 'dxTextBox') {
        data = $("#" + ID).dxTextBox('instance').option('value');
    }
    else if (dxType == 'dxNumberBox') {
        data = $("#" + ID).dxNumberBox('instance').option('value');
    }
    else if (dxType == 'dxTextArea') {
        data = $("#" + ID).dxTextArea('instance').option('value');
    }
    else if (dxType == 'dxCheckBox') {
        data = $("#" + ID).dxCheckBox('instance').option('value');
    }

    return data;
}

function DevexpressSetValue(ID,data) {
    var dxType = hdn.Get(ID + "Type");

    if (dxType == 'dxDataGrid') {

    }
    else if (dxType == 'dxTreeList') {

    }
    else if (dxType == 'dxSelectBox') {
        data = $("#" + ID).dxSelectBox('instance').option('value', data);
    }
    else if (dxType == 'dxTextBox') {
        data = $("#" + ID).dxTextBox('instance').option('value', data);
    }
    else if (dxType == 'dxNumberBox') {
        data = $("#" + ID).dxNumberBox('instance').option('value', data);
    }
    else if (dxType == 'dxTextArea') {
        data = $("#" + ID).dxTextArea('instance').option('value', data);
    }
    else if (dxType == 'dxCheckBox') {
        data = $("#" + ID).dxCheckBox('instance').option('value', data);
    }

    return data;
}

function DevexpressDisable(ID, status) {
    var dxType = hdn.Get(ID + "Type");

    if (dxType == 'dxDataGrid') {
        $("#" + ID).dxDataGrid("option", "disabled", status);
    }
    else if (dxType == 'dxTreeList') {
        $("#" + ID).dxTreeList("option", "disabled", status);
    }
    else if (dxType == 'dxSelectBox') {
        $("#" + ID).dxSelectBox("option", "disabled", status);
    }
    else if (dxType == 'dxTextBox') {
        $("#" + ID).dxTextBox("option", "disabled", status);
    }
    else if (dxType == 'dxNumberBox') {
        $("#" + ID).dxNumberBox("option", "disabled", status);
    }
    else if (dxType == 'dxTextArea') {
        $("#" + ID).dxTextArea("option", "disabled", status);
    }
    else if (dxType == 'dxCheckBox') {
        $("#" + ID).dxCheckBox("option", "disabled", status);
    }
}

//Other Functions
function CheckNull(data) {
    return !data;
}

