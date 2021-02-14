<%@ Page Title="تری لیست" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true" CodeBehind="TreeListComponent.aspx.cs"
    Inherits="WebApp.Pages.WebComponent.TreeListComponent" NeedLogin="false"
    gref="8CBF69B8-983A-4B24-A950-F7440CFDD42D" gid="48A7015B-D8F4-4A0C-B046-D063FCBB55CD" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


    <link rel="stylesheet" type="text/css" href="../../Styles/dx.common.css" />
    <link rel="stylesheet" type="text/css" href="../../Styles/dx.light.css" />
    <link rel="stylesheet" type="text/css" href="../../Styles/DevExpressTheme/Blue-Dark-Theme.css" />

    <script type="text/javascript">

        function FillTreeList(firstTime, url) {
            var columns = ["title"];
            if (firstTime == true) {
                CreateTreeList('treeList', null, 'gid', 'gref', true, true, true, true, columns, "multiple",null);
            }
            else {
                CreateTreeListWithURL('treeList', url, 'gid', 'gref', true, true, true, true, columns, "multiple", null);
            }
        }

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <div class="dx-viewport">

        <input type="button" class="btn btn-success" value="search" onclick="Search();" style="margin: 10px 0px;" />
        <br />

        <div class="demo-container">
            <div id="treeList"></div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">

    <script src="../../Scripts/dx.all.js"></script>
    <script src="../../Scripts/dx.aspnet.data.js"></script>
    <script src="../../Scripts/CreateWebComponent.js"></script>
    <script type="text/javascript">

        FillTreeList(true, null);

        function Search() {
            var url = BaseApiURL + '/webcomponent/PrivilegesList';

            FillTreeList(false, url);
        }

    </script>

</asp:Content>
