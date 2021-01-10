<%@ Page Title="آپلود پست" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true" CodeBehind="UploadPost.aspx.cs" Inherits="WebApp.Pages.UploadPost"
    gref="B815D05D-76F2-491C-AC75-3DB80C0371ED" gid="652696C3-CF52-444C-B731-3787D0E0EFC7" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">


    <div class="well">
        <Ins:UploadControl runat="server" ID="test" ClientInstanceName="test"></Ins:UploadControl>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
</asp:Content>
