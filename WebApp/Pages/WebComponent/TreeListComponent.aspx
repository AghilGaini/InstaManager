<%@ Page Title="تری لیست" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true" CodeBehind="TreeListComponent.aspx.cs"
    Inherits="WebApp.Pages.WebComponent.TreeListComponent" NeedLogin="false"
    gref="8CBF69B8-983A-4B24-A950-F7440CFDD42D" gid="48A7015B-D8F4-4A0C-B046-D063FCBB55CD" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


    <link rel="stylesheet" type="text/css" href="../../Styles/dx.common.css" />
    <link rel="stylesheet" type="text/css" href="../../Styles/dx.light.css" />
    <link rel="stylesheet" type="text/css" href="../../Styles/DevExpressTheme/Blue-Dark-Theme.css" />

    <script type="text/javascript">

        function FillData() {
            $.ajax({
                type: 'GET',
                url: BaseApiURL + '/webcomponent/TreeList',
                contentType: "application/json; charset=utf-8",
                dataType: "json"
            }).then(
                function (data) {
                    FillTreeList(data);
                },
                function (data) {
                    ShowError("data: " + data.d, "عدم برقراری ارتباط");
                }
            )
        }

        function FillTreeList(data) {
            debugger;
            $("#treeList").dxTreeList({
                dataSource: data.payload,
                rootValue: -1,
                keyExpr: "gid",
                parentIdExpr: "gref",
                columns: ["Name", "Family", "gid", "gref"],
                expandedRowKeys: [1],
                showRowLines: true,
                showBorders: true,
                columnAutoWidth: true
            });
        }

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <div class="dx-viewport">

        <input type="button" class="btn btn-success" value="search" onclick="FillData()" style="margin: 10px 0px;" />
        <br />

        <div class="demo-container dx-swatch-Blue-Dark-Theme">
            <div id="treeList"></div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">

    <script src="../../Scripts/dx.all.js"></script>
    <script src="../../Scripts/dx.aspnet.data.js"></script>

</asp:Content>
