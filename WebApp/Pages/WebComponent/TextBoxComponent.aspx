<%@ Page Title="تکست باکس" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true" CodeBehind="TextBoxComponent.aspx.cs"
    gref="8CBF69B8-983A-4B24-A950-F7440CFDD42D" gid="9383F62E-14B4-4282-BECB-FE15FC697F15" NeedLogin="false"
    Inherits="WebApp.Pages.WebComponent.TextBoxComponent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link rel="stylesheet" type="text/css" href="../../Styles/dx.common.css" />
    <link rel="stylesheet" type="text/css" href="../../Styles/dx.light.css" />
    <link rel="stylesheet" type="text/css" href="../../Styles/DevExpressTheme/Blue-Dark-Theme.css" />

    <script type="text/javascript">

</script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <div class="dx-fieldset">

        <div class="dx-field">
            <div class="dx-field-label">With placeholder and ClearButton and Default Value</div>
            <div class="dx-field-value">
                <div id="txt1"></div>
            </div>

            <div class="dx-field-label">Password textbox </div>
            <div class="dx-field-value">
                <div id="txt2"></div>
            </div>

        </div>

        <div class="dx-field">
        </div>

        <div class="dx-field">
            <div class="dx-field-label">Mask </div>
            <div class="dx-field-value">
                <div id="txt3"></div>
            </div>
        </div>

        <div class="dx-field">
            <div class="dx-field-label">new </div>
            <div class="dx-field-value">
                <div id="txt4"></div>
            </div>
        </div>

        <div class="dx-field">
            <div class="dx-field-label">Numeric box(with min and max)</div>
            <div class="dx-field-value">
                <div id="nuTxt1"></div>
            </div>
        </div>

        <div class="dx-field">
            <div class="dx-field-label">With Formatting</div>
            <div class="dx-field-value">
                <div id="nuTxt2"></div>
            </div>
        </div>

        <div class="dx-field">
            <div class="dx-field-label">new numberic</div>
            <div class="dx-field-value">
                <div id="nuTxt3"></div>
            </div>
        </div>

        <div class="dx-field">
            <div class="dx-field-label">Synchronize text areas </div>
            <div class="dx-field-value">
                <div id="areatxt"></div>
            </div>
        </div>

        <div class="dx-field">
            <div class="dx-field-label">new area text</div>
            <div class="dx-field-value">
                <div id="areatxt1"></div>
            </div>
        </div>

    </div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">


    <script src="../../Scripts/dx.all.js"></script>
    <script src="../../Scripts/dx.aspnet.data.js"></script>
    <script src="../../Scripts/CreateWebComponent.js"></script>


    <script type="text/javascript">

        $("#txt1").dxTextBox({
            placeholder: "Place Holder ... with Clear Button",
            showClearButton: true,
            value: 'Defaqult value . Clear this to see placeholder'
        });

        $("#txt2").dxTextBox({
            mode: 'password',
            placeholder: "Enter Password",
            showClearButton: true
        });

        $("#txt3").dxTextBox({
            //See more at : https://js.devexpress.com/Documentation/ApiReference/UI_Widgets/dxTextBox/Configuration/#mask
            mask: "+\\98 (R\\00) 000-0000",
            maskInvalidMessage: 'عن آقا درست وارد کن',
            maskRules: { "R": /[02-9]/ },
        });

        $("#nuTxt1").dxNumberBox({
            value: 10.5,
            min: 10,
            max: 20,
            placeholder: "min:10 max:20",
            showSpinButtons: true,
            showClearButton: true
        });

        $("#nuTxt2").dxNumberBox({
            format: "$ #,##0.##",
            value: 14500.55,
            step: 0.01, // 1 Step = 100 Unit
            showSpinButtons: true,
        });


        $("#areatxt").dxTextArea({
            value: "Test Address",
            placeholder: "Address",
            autoResizeEnabled: true,
            height: 150
        });

        CreateTextBox('txt4', 'placeholder', true, 'default value', null, null, null);
        CreateNumericBox('nuTxt3', 'This is Default Value', null, null, true, 'placeholder', true, 'عنتو درست وارد کن');
        CreateTextArea('areatxt1', 'Default Address', 'placeholder', true, 180, null);
        DevExpress.ui.notify('test', 'error', 600);


    </script>


</asp:Content>
