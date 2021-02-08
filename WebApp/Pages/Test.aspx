<%@ Page Title="Test" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="WebApp.Pages.Test"
    NeedLogin="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link rel="stylesheet" type="text/css" href="../Styles/dx.common.css" />
    <link rel="stylesheet" type="text/css" href="../Styles/dx.light.css" />
    <link rel="stylesheet" type="text/css" href="../Styles/DevExpressTheme/Blue-Dark-Theme.css" />

    <script type="text/javascript">

</script>

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

    <script src="../Scripts/dx.all.js"></script>
    <script src="../Scripts/dx.aspnet.data.js"></script>
    <script src="../Scripts/CreateWebComponent.js"></script>
    <script src="../Scripts/exceljs.min.js"></script>
    <script src="../Scripts/FileSaver.min.js"></script>

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
            fileData.append("ID", "1");
            for (var i = 0; i < files.length; i++) {

                //if (files[i].type != 'image/jpeg')
                //    continue;

                fileData.append(files[i].name, files[i]);
            }

            $.ajax({
                type: "POST",
                url: BaseApiURL + "/WebComponent/UploadProfilePic",
                contentType: false,
                processData: false,
                data: fileData,
                success: function (result) {
                    ShowSuccess("this is ok");
                },
                error: function (xhr, status, p3, p4) {
                    ShowError("عدم برقراری ازتباط");
                }
            });
            
        }

    </script>

</asp:Content>
