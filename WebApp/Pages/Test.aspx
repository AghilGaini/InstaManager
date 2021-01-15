<%@ Page Title="Test" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="WebApp.Pages.Test"
    NeedLogin="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">


    <div style="margin-bottom : 10px;">
        <Ins:ComboBox ID="cmbTest" ClientInstanceName="cmbTest" runat="server">

        </Ins:ComboBox>
    </div>

    <div class="well">
        <Ins:GridView ID="grdTest" ClientInstanceName="grdTest" runat="server" Width="100%" KeyFieldName="ID"
            OnCustomCallback="grdTest_CustomCallback" OnPageIndexChanged="grdTest_PageIndexChanged" SettingsBehavior-AllowSelectByRowClick="true">
            <Columns>
                <dx:GridViewDataTextColumn Caption="ID" FieldName="ID" />
                <dx:GridViewDataTextColumn Caption="Name" FieldName="Name" />
                <dx:GridViewDataTextColumn Caption="Family" FieldName="Family" />
            </Columns>
        </Ins:GridView>

    </div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
</asp:Content>
