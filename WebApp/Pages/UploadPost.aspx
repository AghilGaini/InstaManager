<%@ Page Title="آپلود پست" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true" CodeBehind="UploadPost.aspx.cs" Inherits="WebApp.Pages.UploadPost"
    gref="B815D05D-76F2-491C-AC75-3DB80C0371ED" gid="652696C3-CF52-444C-B731-3787D0E0EFC7" NeedLogin="false"%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <input type="file" id="fileUpload" />
    <br />
    <button class="btn btn-primary" id="btnUpload">Upload</button>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">

    <script type="text/javascript">

        var UploadPath = "";

        $(document).ready(function () {
            $("#btnUpload").click(function (evt) {

                UploadPath = "";

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
                options.success = function (result) {
                    UploadPath = result;
                    alert(UploadPath);
                };
                options.error = function (err) { alert(err.statusText); };

                $.ajax(options);

                evt.preventDefault();
            });
        });
    </script>

</asp:Content>
