<%@ Page Title="پنل جستجو" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true"
    CodeBehind="SearchPanelComponent.aspx.cs" Inherits="WebApp.Pages.WebComponent.SearchPanelComponent"
    gref="8CBF69B8-983A-4B24-A950-F7440CFDD42D" gid="4C1494A2-A8DD-4A04-A85A-2A7CF16F7002" NeedLogin="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link rel="stylesheet" type="text/css" href="../../Styles/dx.common.css" />
    <link rel="stylesheet" type="text/css" href="../../Styles/dx.light.css" />
    <link rel="stylesheet" type="text/css" href="../../Styles/DevExpressTheme/Blue-Dark-Theme.css" />

    <script type="text/javascript">

        function FillData(cmbID) {
            $.ajax({
                type: 'GET',
                url: BaseApiURL + '/webcomponent/ComboBox',
                contentType: "application/json; charset=utf-8",
                dataType: "json"
            }).then(
                function (data) {
                    FillComboBox(data.payload, cmbID);
                },
                function (data) {
                    ShowError("data: " + data.d, "عدم برقراری ارتباط");
                }
            )
        }

        function FillComboBox(data, cmbID) {
            CreateComboBox(cmbID, data, 'ID', 'Name', 'ID', true, true, 'انتخاب', 150, 35);
        }

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">

    <script src="../../Scripts/dx.all.js"></script>
    <script src="../../Scripts/dx.aspnet.data.js"></script>
    <script src="../../Scripts/CreateWebComponent.js"></script>

    <script type="text/javascript">

        FillData('cmb');
        FillData('cmb1');

    </script>

</asp:Content>
