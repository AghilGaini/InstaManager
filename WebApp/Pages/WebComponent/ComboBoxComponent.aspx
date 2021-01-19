<%@ Page Title="کمبو باکس" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true" CodeBehind="ComboBoxComponent.aspx.cs"
    Inherits="WebApp.Pages.WebComponent.ComboBoxComponent" NeedLogin="false"
    gref="8CBF69B8-983A-4B24-A950-F7440CFDD42D" gid="94FF4C66-86F7-45B4-A690-4DF10BB9D169" %>

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
                    FillComboBox(data.payload,cmbID);
                },
                function (data) {
                    ShowError("data: " + data.d, "عدم برقراری ارتباط");
                }
            )
        }

        function FillComboBox(data,cmbID) {
            CreateComboBox(cmbID, data, 'ID', 'Name', 'ID', true, true, 'انتخاب');
        }

    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <div class="dx-viewport">
        <div class="demo-container">

            <input type="button" class="btn btn-success" value="search" onclick="FillData()" style="margin: 10px 0px;" />
            <br />

            <div class="dx-fieldset">
                <div class="dx-field">
                    <div class="dx-field-value ">
                        <div id="cmb"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">

    <script src="../../Scripts/dx.all.js"></script>
    <script src="../../Scripts/dx.aspnet.data.js"></script>
    <script src="../../Scripts/CreateWebComponent.js"></script>

    <script type="text/javascript">

        FillData('cmb');

    </script>

</asp:Content>
