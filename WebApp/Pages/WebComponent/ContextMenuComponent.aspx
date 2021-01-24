<%@ Page Title="کانتکست منو" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true" CodeBehind="ContextMenuComponent.aspx.cs"
    Inherits="WebApp.Pages.WebComponent.ContextMenuComponent" NeedLogin="false"
    gref="8CBF69B8-983A-4B24-A950-F7440CFDD42D" gid="F5675DC8-4C05-4932-B3A1-E72A69D56272" %>

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

            CreateGridView('grid', data, "ID", true, 5, allowedPageSizes, true, true, true, true, true, true, true, true, columns);
        }

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">


    <div class="row">
        <input type="button" class="btn btn-success" value="search" onclick="FillData()" style="margin: 10px 0px;" />
        <br />
        <div id="grid"></div>
        <div id="context-menu"></div>
    </div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">

    <script src="../../Scripts/dx.all.js"></script>
    <script src="../../Scripts/dx.aspnet.data.js"></script>
    <script src="../../Scripts/CreateWebComponent.js"></script>

    <script type="text/javascript">

        var contextMenuItems = [
            {
                text: 'Share',
                items: [
                    { text: 'Facebook' },
                    { text: 'Twitter' }]
            },
            { text: 'Download' },
            { text: 'Comment' },
            { text: 'Favorite' }
        ];


        FillGrid(null);

        CreateContextMenu('context-menu', contextMenuItems, 'grid', 200, test);

        function test(e) {
            DevExpress.ui.notify("an tush The \"" + e.itemData.text + "\" item was clicked", "success", 1500);
        }

    </script>


</asp:Content>
