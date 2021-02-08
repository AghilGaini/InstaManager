<%@ Page Title="آپلود پست" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true" CodeBehind="UploadPost.aspx.cs" Inherits="WebApp.Pages.UploadPost"
    gref="B815D05D-76F2-491C-AC75-3DB80C0371ED" gid="652696C3-CF52-444C-B731-3787D0E0EFC7" NeedLogin="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <div class="well well-lg">

        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 ">
                <textarea class="form-control" rows="5" placeholder="متن پست" id="txtPostCaption"></textarea>
            </div>
        </div>
        <br />

        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 ">
                <input type="text" class="form-control" id="txtPostMentions" placeholder="تگ ها" />
            </div>
        </div>
        <br />
        <input type="file" id="fileUpload" accept=".jpg,.gif,.png,.jpeg" />
        <br />
        <button class="btn btn-primary" id="btnUpload">Upload</button>

    </div>

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
            fileData.append("testKey", "value");
            for (var i = 0; i < files.length; i++) {

                //if (files[i].type != 'image/jpeg')
                //    continue;

                fileData.append(files[i].name, files[i]);
            }

            return;

            $.ajax({
                type: 'POST',
                data: fileData,
                contentType: false,
                processData: false,
                async: false,
                url: '<%= ResolveUrl("~")%>Classes/Handlers/FileUploadHandler.ashx',
                success: function (data) {
                    Res = data;
                    SavePost1(Res);
                },
                error: function (data) {
                    alert('Server Connection');
                }
            })
        }

        function SavePost(res) {
            debugger;
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
