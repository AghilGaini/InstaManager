<%@ Page Title="باتن" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true" CodeBehind="ButtonComponent.aspx.cs"
    Inherits="WebApp.Pages.WebComponent.ButtonComponent" NeedLogin="false"
    gref="8CBF69B8-983A-4B24-A950-F7440CFDD42D" gid="37D4EB90-C6DE-4539-9638-AC1CF0B5684A" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link rel="stylesheet" type="text/css" href="../../Styles/dx.common.css" />
    <link rel="stylesheet" type="text/css" href="../../Styles/dx.light.css" />
    <link rel="stylesheet" type="text/css" href="../../Styles/DevExpressTheme/Blue-Dark-Theme.css" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <div class="row">
        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
            <div id="normal-contained"></div>
        </div>
        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
            <div id="normal-outlined"></div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
            <div id="success-contained"></div>
        </div>
        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
            <div id="success-outlined"></div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
            <div id="default-contained"></div>
        </div>
        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
            <div id="default-outlined"></div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
            <div id="danger-contained"></div>
        </div>
        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
            <div id="danger-outlined"></div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">

    <script src="../../Scripts/dx.all.js"></script>
    <script src="../../Scripts/dx.aspnet.data.js"></script>
    <script src="../../Scripts/CreateWebComponent.js"></script>

    <script type="text/javascript">

        CreateButton("normal-contained", "contained", "جستجو", "normal", "30%", null, 'search', function () { alert('clicked') });
        CreateButton("normal-outlined", "outlined", "Normal Outlined", "normal", "30%", null);
        CreateButton("success-contained", "contained", "ذخیره", "success", "30%", null, 'save', function () { });
        CreateButton("success-outlined", "outlined", "success outlined", "success", "30%", null);
        CreateButton("default-contained", "contained", "اطلاعات", "default", "30%", null, 'info');
        CreateButton("default-outlined", "outlined", "default outlined", "default", "30%", null);
        CreateButton("danger-contained", "contained", "انصراف", "danger", "30%", null, 'remove');
        CreateButton("danger-outlined", "outlined", "danger outlined", "danger", "30%", null);

    </script>

</asp:Content>
