<%@ Page Title="آپلود پست" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true" CodeBehind="UploadPost.aspx.cs" Inherits="WebApp.Pages.UploadPost"
    gref="B815D05D-76F2-491C-AC75-3DB80C0371ED" gid="652696C3-CF52-444C-B731-3787D0E0EFC7" NeedLogin="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <div class="row LoginPanelInputRowStyle">
        <div class="col-lg-12 col-md-12 col-sm-12 LoginPanelInputColumnStyle">
            <input type="text" class="form-control" id="txtPostDescription" placeholder="متن پست" />
        </div>
    </div>
    <br />

    <div class="row LoginPanelInputRowStyle">
        <div class="col-lg-12 col-md-12 col-sm-12 LoginPanelInputColumnStyle">
            <input type="text" class="form-control" id="txtPostMentions" placeholder="تگ ها" />
        </div>
    </div>
    <br />
    <input type="file" id="fileUpload" />
    <br />
    <button class="btn btn-primary" id="btnUpload">Upload</button>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">

    <script type="text/javascript">

        var UploadPath = "";

        Res = {};


        $("#btnUpload").click(function () {

            alert('ok');

            UploadFile1();
        });


        function UploadFile1() {
            var fileUpload = $("#fileUpload").get(0);
            if (fileUpload == 'undefined')
                return;

            var files = fileUpload.files;
            if (files.length == 0)
                return;

            var fileData = new FormData();
            for (var i = 0; i < files.length; i++) {
                fileData.append(files[i].name, files[i]);
            }

            $.ajax({
                type: 'POST',
                data: fileData,
                contentType: false,
                processData: false,
                async : false,
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

        function test(res) {
            alert(res);
        }

        function SavePost(res) {

            var etity = {};
            entity.Path = res.Result;
            entity.Tags = $("#txtPostDescription").val();
            entity.Description = $("#txtPostMentions").val();

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

        function SavePost(path) {
            debugger;

            var etity = {};
            entity.Path = path;
            entity.Tags = $("#txtPostDescription").val();
            entity.Description = $("#txtPostMentions").val();

            var options = {};
            options.url = '<%= ResolveUrl("~")%>Pages/UploadPost.aspx/SavePost';
            options.type = "POST";
            options.data = JSON.stringify({ info: entity });
            options.contentType = false;
            options.processData = false;
            options.success = function (result) {
                if (result.d[0] == 1) {
                    alert('Success');
                }
                else {
                    alert("Has Error : " + result.d[1]);
                }
            };
            options.error = function (err) { alert(err.statusText); };

            $.ajax(options);
        }

        //$(document).ready(function () {
        //});
    </script>

</asp:Content>
