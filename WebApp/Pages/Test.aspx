<%@ Page Title="Test" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="WebApp.Pages.Test"
    NeedLogin="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link rel="stylesheet" type="text/css" href="../Styles/dx.common.css" />
    <link rel="stylesheet" type="text/css" href="../Styles/dx.light.css" />
    <link rel="stylesheet" type="text/css" href="../Styles/DevExpressTheme/Blue-Dark-Theme.css" />

    <script type="text/javascript">

        function FillData() {
            $.ajax({
                type: 'GET',
                url: BaseApiURL + '/webcomponent/gridview',
                contentType: "application/json; charset=utf-8",
                dataType: "json"
            }).then(
                function (data) {
                    FillGrid(data.payload);
                },
                function (data) {
                    ShowError("data: " + data.d, "عدم برقراری ارتباط");
                }
            )
        }

        function Exporting(e, FileName,WorkSheet) {
            var workbook = new ExcelJS.Workbook();
            var worksheet = workbook.addWorksheet(WorkSheet);

            worksheet.columns = [{ width: 5 }, { width: 50 }, { width: 50 }, { width: 80 }];

            DevExpress.excelExporter.exportDataGrid({
                component: e.component,
                worksheet: worksheet,
                keepColumnWidths: false,
                //topLeftCell: { row: 2, column: 2 },
                customizeCell: function (options) {
                    var gridCell = options.gridCell;
                    var excelCell = options.excelCell;
                }
            }).then(function () {
                workbook.xlsx.writeBuffer().then(function (buffer) {
                    saveAs(new Blob([buffer], { type: "application/octet-stream" }), FileName + ".xlsx");
                });
            });
            e.cancel = true;
        }

        function FillGrid(data) {
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

            CreateGridView('grid', data, "ID", true, 5, allowedPageSizes, true, true, true, true, true, true, true, true, columns, true, Exporting, 'fileNameTest', 'workSheet');
        }

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <div class="demo-container">
        <div id="exportButton"></div>
        <div id="grid"></div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">

    <script src="../Scripts/dx.all.js"></script>
    <script src="../Scripts/dx.aspnet.data.js"></script>
    <script src="../Scripts/CreateWebComponent.js"></script>
    <script src="../Scripts/exceljs.min.js"></script>
    <script src="../Scripts/FileSaver.min.js"></script>

    <script type="text/javascript">
        FillGrid(null);
    </script>

</asp:Content>
