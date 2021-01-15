<%@ Page Title="GridViewComponent" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true" CodeBehind="GridViewComponent.aspx.cs" 
    Inherits="WebApp.Pages.WebComponent.GridViewComponent" NeedLogin="false"
    gref="8CBF69B8-983A-4B24-A950-F7440CFDD42D" gid="15F25352-1A63-4333-BD9F-D8581CBCA7B0" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <div class="well">
        <input type="button" class="btn btn-success" onclick="grd.PerformCallback()" value="جستجو" />
    </div>

    <div class="well">
        <Ins:GridView ID="grd" ClientInstanceName="grd" AutoGenerateColumns="false" runat="server" KeyFieldName="ID"
            OnCustomCallback="grd_CustomCallback" OnBeforeColumnSortingGrouping="grd_BeforeColumnSortingGrouping"
            OnPageIndexChanged="grd_PageIndexChanged"
            SettingsBehavior-AllowSelectByRowClick="true">
            <Columns>
                <dx:GridViewDataTextColumn Caption="Name" FieldName="Name" />
                <dx:GridViewDataTextColumn Caption="Family" FieldName="Family" />
                <dx:GridViewDataTextColumn Caption="ID" FieldName="ID" />
            </Columns>

        </Ins:GridView>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
</asp:Content>
