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
                    FillGrid(data);
                },
                function (data) {
                    ShowError("data: " + data.d, "عدم برقراری ارتباط");
                }
            )
        }

        function FillGrid(data) {
            debugger;
            $("#grid").dxDataGrid({
                dataSource: data.payload,
                keyExpr: "ID",
                selection: {
                   mode: "single"
                },
                paging: {
                    pageSize: 4
                },
                pager: {
                    showPageSizeSelector: true,
                    allowedPageSizes: [2, 4, 6],
                    showInfo: true,
                    infoText: 'صفحه {0} از {1} - تعداد کل {2}'
                },
                //hoverStateEnabled: true,
                showColumnLines: true,
                showRowLines: true,
                showBorders: true,
                rowAlternationEnabled: true,
                focusedRowEnabled: true,
                allowColumnResizing: true,
                columnResizingMode: "nextColumn",
                columnAutoWidth: true,
                columns: [  {dataField : "ID", caption : "شناسه"}, 
                            {dataField : "Name",caption:"نام"}, 
                            {dataField : "Family",caption:"نام خانوادگی"},
                            {
                                dataField: "Picture",
                                caption : "تصویر",
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

                ],
                onSelectionChanged: function (selectedItems) {
                            debugger;
                            var data = selectedItems.selectedRowsData[0];
                            if(data) {
                                var message = 'نام : ' + data.Name + ' نام خانوادگی :  ' + data.Family;
                                ShowSuccess(message , 'اطلاعات فرد انتخاب شده');
                            }
                    }
            });
        }

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">


    <div class="dx-viewport">

        <input type="button" class="btn btn-success" value="search" onclick="FillData()" style="margin:10px 0px;" />
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

            $("#grid").dxDataGrid({
                dataSource: null,
                paging: {
                    pageSize: 4
                },
                pager: {
                    showPageSizeSelector: true,
                    allowedPageSizes: [2, 4, 6],
                    showInfo: true
                },
                columns: [{dataField : "ID", caption : "شناسه"}, 
                            {dataField : "Name",caption:"نام"}, 
                            {dataField : "Family",caption:"نام خانوادگی"},
                            {dataField : "Picture",caption : "تصویر"}],
                showBorders: true
            });
        });
    </script>

</asp:Content>
