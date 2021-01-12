<%@ Page Title="Test" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="WebApp.Pages.Test" NeedLogin="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <input type="file" id="fileUpload" />
    <br />
    <button class="btn btn-primary" id="btnUpload">Upload</button>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">

    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnUpload").click(function (evt) {

                debugger;
                var fileUpload = $("#fileUpload").get(0);

                if (fileUpload == 'undefined')
                    return;

                var files = fileUpload.files;
                if (files.length == 0)
                    return;

                var data = new FormData();
                for (var i = 0; i < files.length; i++) {
                    data.append(files[i].name, files[i]);
                }

                var options = {};
                options.url = '<%= ResolveUrl("~")%>Classes/Handlers/FileUploadHandler.ashx';
                options.type = "POST";
                options.data = data;
                options.contentType = false;
                options.processData = false;
                options.success = function (result) { alert(result); };
                options.error = function (err) { alert(err.statusText); };

                $.ajax(options);

                evt.preventDefault();
            });
        });
    </script>

</asp:Content>
