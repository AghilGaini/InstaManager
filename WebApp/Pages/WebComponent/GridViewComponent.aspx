<%@ Page Title="GridViewComponent" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true" CodeBehind="GridViewComponent.aspx.cs"
    Inherits="WebApp.Pages.WebComponent.GridViewComponent" NeedLogin="false"
    gref="8CBF69B8-983A-4B24-A950-F7440CFDD42D" gid="15F25352-1A63-4333-BD9F-D8581CBCA7B0" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link rel="stylesheet" type="text/css" href="../../Styles/dx.common.css" />
    <link rel="stylesheet" type="text/css" href="../../Styles/dx.light.css" />
    <link rel="stylesheet" type="text/css" href="../../Styles/DevExpressTheme/Blue-Dark-Theme.css" />


    <style>
        #exportButton {
            margin-bottom: 10px;
        }
    </style>

    <script type="text/javascript">

        function FillData() {
            $.ajax({
                type: 'GET',
                url: BaseApiURL + '/webcomponent/gridview',
                contentType: "application/json; charset=utf-8",
                dataType: "json"
            }).then(
                function (data) {
                    FillGrid(data);
                },
                function (data) {
                    alert("data: " + data.d, "عدم برقراری ارتباط");
                }
            )
        }

        function FillGrid(data) {
            debugger;
            $("#grid").dxDataGrid({
                dataSource: data.payload,
                keyExpr: "ID",
                paging: {
                    pageSize: 4
                },
                pager: {
                    showPageSizeSelector: true,
                    allowedPageSizes: [2, 4, 6],
                    showInfo: true,
                    infoText: 'صفحه {0} از {1} - تعداد کل {2}'
                },
                showColumnLines: true,
                showRowLines: true,
                showBorders: true,
                rowAlternationEnabled: true,
                focusedRowEnabled: true,
                columns: ["ID", "Name", "Family",
                    {
                        dataField: "Picture",
                        width: 60,
                        height: 50,
                        allowFiltering: false,
                        allowSorting: false,
                        cellTemplate: function (container, options) {
                            $("<div>")
                                .append($("<img>", { "src": options.value, "width": "50", "height": "50" }))
                                .appendTo(container);
                        }
                    }

                ],
            });
        }

        function Export() {

        }

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">


    <div class="dx-viewport">

        <input type="button" class="btn btn-success" value="search" onclick="FillData()" />
        <br />
        <input type="button" class="btn btn-success" value="Export" onclick="Export()" />
        <br />

        <div class="demo-container dx-swatch-Blue-Dark-Theme">
            <div id="exportButton"></div>
            <div id="grid"></div>
        </div>
    </div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">

    <script src="../../Scripts/dx.all.js"></script>
    <script src="../../Scripts/dx.aspnet.data.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {

            $('#exportButton').dxButton({
                icon: 'exportpdf',
                text: 'Export to PDF',
                onClick: function () {
                    debugger;
                    const doc = new jsPDF();
                    DevExpress.pdfExporter.exportDataGrid({
                        jsPDFDocument: doc,
                        component: dataGrid
                    }).then(function () {
                        doc.save('Customers.pdf');
                    });
                }
            });

            $("#grid").dxDataGrid({
                dataSource: null,
                paging: {
                    pageSize: 3
                },
                pager: {
                    showPageSizeSelector: true,
                    allowedPageSizes: [2, 4, 6],
                    showInfo: true
                },
                columns: ["ID", "Name", "Family"],
                showBorders: true
            });
        });
    </script>



</asp:Content>
