<%@ Page Title="آپلود فایل" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true" CodeBehind="UploadFile.aspx.cs"
    Inherits="WebApp.Pages.WebComponent.UploadFile" NeedLogin="false"
    gref="8CBF69B8-983A-4B24-A950-F7440CFDD42D" gid="082D4178-0A06-4A98-B129-5DAF324241F9" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <br />
    <input type="file" id="fileUpload" accept=".jpg,.gif,.png,.jpeg" />
    <br />
    <button class="btn btn-primary" id="btnUpload">Upload</button>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">

    <script type="text/javascript">

        $("#btnUpload").click(function () {
            UploadFile();
        });

        function UploadFile() {
            debugger;
            var fileUpload = $("#fileUpload").get(0);
            if (fileUpload == 'undefined')
                return;

            var files = fileUpload.files;
            if (files.length == 0)
                return;

            var fileData = new FormData();
            for (var i = 0; i < files.length; i++) {

                if (files[i].type != 'image/jpeg')
                    continue;

                fileData.append(files[i].name, files[i]);
            }

            $.ajax({
                type: 'POST',
                data: fileData,
                contentType: false,
                processData: false,
                async: false,
                url: '<%= ResolveUrl("~")%>Classes/Handlers/FileUploadHandler.ashx',
                success: function (data) {
                    Res = data;
                    AfterSave(Res);
                },
                error: function (data) {
                    alert('Server Connection');
                }
            })
        }

        function AfterSave(res) {
            var data = JSON.parse(res);
            var entity = {};
            entity.Path = data.Result;
            entity.Tags = $("#txtPostMentions").val();
            entity.Description = $("#txtPostCaption").val();

            entity = JSON.stringify(entity);

            $.ajax({
                type: 'POST',
                url: '<%= ResolveUrl("~") %>Pages/UploadPost.aspx/SavePost',
                data: JSON.stringify({ info: entity }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    alert('tamam');
                },
                error: function (data) {
                    alert('Server Connection');
                }
            })
        }


    </script>

</asp:Content>
