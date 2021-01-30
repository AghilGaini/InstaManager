<%@ Page Title="صفحه نمونه" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true" CodeBehind="SamplePage.aspx.cs"
    Inherits="WebApp.Pages.WebComponent.SamplePage" NeedLogin="false"
    gref="8CBF69B8-983A-4B24-A950-F7440CFDD42D" gid="740B9F04-E590-4C1A-B5C0-1115B5832C6A" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link rel="stylesheet" type="text/css" href="../../Styles/dx.common.css" />
    <link rel="stylesheet" type="text/css" href="../../Styles/dx.light.css" />
    <link rel="stylesheet" type="text/css" href="../../Styles/DevExpressTheme/Blue-Dark-Theme.css" />

    <script type="text/javascript">

        function CreateGrid(firstTime,url) {
            var columns = [
                { dataField: "ID", caption: "شناسه" },
                { dataField: "Name", caption: "نام" },
                { dataField: "Family", caption: "نام خانوادگی" },
                {
                    dataField: "Picture",
                    caption: "تصویر",
                    width: 80,
                    height: 50,
                    allowFiltering: false,
                    allowSorting: false,
                    cellTemplate: function (container, options) {
                        $("<div>")
                            .append($("<img>", { "src": options.value, "width": "50", "height": "50" }))
                            .appendTo(container);
                    }
                }
            ];
            var allowedPageSizes = [5, 10, 15];

            if (firstTime == true) {
                CreateGridView('grid', null, "ID", true, 5, allowedPageSizes, true, true, true, true, true, true, true, true, columns,
                    true, ExportingExcel, 'fileNameTest', 'workSheet', true, 'exportButton', 'خروجی PDF', 'اطلاعات');
            }
            else {
                CreateGridViewWithURL('grid', "ID", true, 5, allowedPageSizes, true, true, true, true, true, true, true, true, columns,
                    true, null, 'fileNameTest', 'workSheet', true, 'exportButton', 'خروجی PDF', 'اطلاعات', url);
            }
        }

        function ExportingExcel(e, FileName, WorkSheet) {
            var workbook = new ExcelJS.Workbook();
            var worksheet = workbook.addWorksheet(WorkSheet);

            worksheet.columns = [{ width: 5 }, { width: 50 }, { width: 50 }, { width: 80 }];

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

        function Search() {
            debugger;
            var name = DevexpressGetValue('nameTxt');
            var family = DevexpressGetValue('familyTxt');
            var age = DevexpressGetValue('nuAge');

            var args = 'name=' + name + '&family=' + family + '&age=' + age;

            var url = BaseApiURL + '/webcomponent/gridview?' + args; 

            CreateGrid(false,url);
        }

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">


    <div class="row SearchPanel">
        <div class="row SearchPanelRows">
            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12 SearchPanelColumns">
                <div style="padding: 1% 1%">
                    <div>نام</div>
                </div>
                <div style="padding: 1% 1%">
                    <div id="nameTxt" style="width: 80%"></div>
                </div>
            </div>
            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12 SearchPanelColumns">
                <div style="padding: 1% 1%">
                    <div>نام خانوادگی</div>
                </div>
                <div style="padding: 1% 1%">
                    <div id="familyTxt" style="width: 80%"></div>
                </div>
            </div>
            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12 SearchPanelColumns">
                <div style="padding: 1% 1%">
                    <div>سمت</div>
                </div>
                <div style="padding: 1% 1%">
                    <div id="cmbPosition" style="width: 50%"></div>
                </div>
            </div>
            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12 SearchPanelColumns">
                <div style="padding: 1% 1%">
                    <div>سن</div>
                </div>
                <div style="padding: 1% 1%">
                    <div id="nuAge" style="width: 50%"></div>
                </div>
            </div>
            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12 SearchPanelColumns"></div>
            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12 SearchPanelColumns"></div>
            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12 SearchPanelColumns"></div>
            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12 SearchPanelColumns">
                <div style="padding: 1% 1%">
                    <div>ادمین</div>
                </div>
                <div style="padding: 1% 1%">
                    <div id="chb" style="width: 50%"></div>
                </div>
            </div>
        </div>
        <div class="row SearchPanelButtonColumns">
            <div class="col-lg-12 col-md-12 col-sm-12">
                <button type="button" class="btn btn-primary SearchPanelButton" onclick="Search()">جستجو</button>
            </div>
        </div>
    </div>

    <div class="MainGrid">
        <div id="exportButton"></div>
        <div id="grid"></div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">

    <script src="../../Scripts/dx.all.js"></script>
    <script src="../../Scripts/dx.aspnet.data.js"></script>
    <script src="../../Scripts/CreateWebComponent.js"></script>
    <script src="../../Scripts/exceljs.min.js"></script>
    <script src="../../Scripts/FileSaver.min.js"></script>
    <script src="../../Scripts/jspdf.plugin.autotable.min.js"></script>
    <script src="../../Scripts/jspdf.umd.min.js"></script>

    <script type="text/javascript">

        CreateComboBoxWithURL('cmbPosition', BaseApiURL + '/webcomponent/ComboBox', 'ID', 'Name', 'ID', true, true, 'سمت', '80%', null);
        CreateTextBox('nameTxt', 'نام', true, null, null, null, null, true);
        CreateTextBox('familyTxt', 'نام خانوادگی', true, null, null, null, null, true);
        CreateCheckBox('chb', null, null, '120%');
        CreateNumericBox('nuAge', null, null, 1, true, 'سن', true, null, '80%', null, 85, 10, true);

        CreateGrid(true);

    </script>

</asp:Content>
