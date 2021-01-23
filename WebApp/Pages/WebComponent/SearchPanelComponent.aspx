<%@ Page Title="پنل جستجو" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true"
    CodeBehind="SearchPanelComponent.aspx.cs" Inherits="WebApp.Pages.WebComponent.SearchPanelComponent"
    gref="8CBF69B8-983A-4B24-A950-F7440CFDD42D" gid="4C1494A2-A8DD-4A04-A85A-2A7CF16F7002" NeedLogin="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link rel="stylesheet" type="text/css" href="../../Styles/dx.common.css" />
    <link rel="stylesheet" type="text/css" href="../../Styles/dx.light.css" />
    <link rel="stylesheet" type="text/css" href="../../Styles/DevExpressTheme/Blue-Dark-Theme.css" />

    <script type="text/javascript">

        var cmbPositionsData;

        function cmbPositions() {
            $.ajax({
                type: 'GET',
                url: BaseApiURL + '/webcomponent/ComboBox',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async:false
            }).then(
                function (data) {
                    cmbPositionsData =  data.payload;
                },
                function (data) {
                    ShowError("data: " + data.d, "عدم برقراری ارتباط");
                }
            )
        }

        cmbPositions();

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <div>
        <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12">
            <div style="padding: 2% 2%">
                <div>نام</div>
            </div>
            <div style="padding: 2% 2%">
                <div id="nameTxt" style="width: 80%"></div>
            </div>
        </div>
        <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12">
            <div style="padding: 2% 2%">
                <div>نام خانوادگی</div>
            </div>
            <div style="padding: 2% 2%">
                <div id="familyTxt" style="width: 80%"></div>
            </div>
        </div>
        <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12">
            <div style="padding: 2% 2%">
                <div>سمت</div>
            </div>
            <div style="padding: 2% 2%">
                <div id="cmbPosition" style="width: 50%"></div>
            </div>
        </div>
        <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12">
            <div style="padding: 2% 2%">
                <div>سن</div>
            </div>
            <div style="padding: 2% 2%">
                <div id="nuAge" style="width: 50%"></div>
            </div>
        </div>
        <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12">
            <div style="padding: 2% 2%">
                <div>ادمین</div>
            </div>
            <div style="padding: 2% 2%">
                <div id="chb" style="width: 50%"></div>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">

    <script src="../../Scripts/dx.all.js"></script>
    <script src="../../Scripts/dx.aspnet.data.js"></script>
    <script src="../../Scripts/CreateWebComponent.js"></script>

    <script type="text/javascript">

        CreateTextBox('nameTxt', 'نام', true, null, null, null, null);
        CreateTextBox('familyTxt', 'نام خانوادگی', true, null, null, null, null);
        CreateComboBox('cmbPosition', cmbPositionsData, 'ID', 'Name', 'ID', true, true, 'سمت', '80%', null);
        CreateCheckBox('chb', null, null, '120%');
        CreateNumericBox('nuAge', null, null, 1, true, 'سن', true, null,'80%',null);

    </script>

</asp:Content>
