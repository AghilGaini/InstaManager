<%@ Page Title="گرید ویو" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true" CodeBehind="GridViewComponent.aspx.cs"
    Inherits="WebApp.Pages.WebComponent.GridViewComponent" NeedLogin="false"
    gref="8CBF69B8-983A-4B24-A950-F7440CFDD42D" gid="15F25352-1A63-4333-BD9F-D8581CBCA7B0" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link rel="stylesheet" type="text/css" href="../../Styles/dx.common.css" />
    <link rel="stylesheet" type="text/css" href="../../Styles/dx.light.css" />
    <link rel="stylesheet" type="text/css" href="../../Styles/DevExpressTheme/Blue-Dark-Theme.css" />
    
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

            CreateGridView('grid', data, "ID", true, 5, allowedPageSizes, true, true, true, true, true, true, true, true, columns,
                true, ExportingExcel, 'fileNameTest', 'workSheet', true,'exportButton','خروجی PDF','اطلاعات');
        }

        function ExportingExcel(e, FileName, WorkSheet) {
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

                    if (gridCell.rowType === "data") {
                        //if (gridCell.column.dataField === "Picture") {
                        //    excelCell.value = undefined;

                        //    const image = workbook.addImage({
                        //        //filename: gridCell.value,
                        //        filename: "https://icon2.cleanpng.com/20180402/qye/kisspng-computer-icons-user-login-gender-5ac29ccd8f04c2.0984432615227035655858.jpg",
                        //        extension: 'png',
                        //    });

                        //    worksheet.getRow(excelCell.row).height = 90;
                        //    worksheet.addImage(image, {
                        //        tl: { col: excelCell.col - 1, row: excelCell.row - 1 },
                        //        br: { col: excelCell.col, row: excelCell.row }
                        //    });
                        //}
                    }

                }
            }).then(function () {
                workbook.xlsx.writeBuffer().then(function (buffer) {
                    saveAs(new Blob([buffer], { type: "application/octet-stream" }), FileName + ".xlsx");
                });
            });
            e.cancel = true;
        }

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">


    <div class="dx-viewport">

        <input type="button" class="btn btn-success" value="search" onclick="FillData()" style="margin: 10px 0px;" />
        <br />

        <div class="demo-container">
            <div id="exportButton"></div>
            <div id="grid"></div>
        </div>
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
        

        FillGrid(null);

    </script>

</asp:Content>
