<%@ Page Title="آپلود پست" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true" CodeBehind="UploadPost.aspx.cs" Inherits="WebApp.Pages.UploadPost"
    gref="B815D05D-76F2-491C-AC75-3DB80C0371ED" gid="652696C3-CF52-444C-B731-3787D0E0EFC7" NeedLogin="false"%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">

        function onFileUploadComplete(s, e) {
            debugger;
            var callbackData = e.callbackData.split("|"),
                uploadedFileName = callbackData[0],
                isSubmissionExpired = callbackData[1] === "True";
            uploadedFiles.push(uploadedFileName);
            if (e.errorText.length > 0 || !e.isValid)
                uploadErrorOccurred = true;
            if (isSubmissionExpired && UploadedFilesTokenBox.GetText().length > 0) {
                var removedAfterTimeoutFiles = UploadedFilesTokenBox.GetTokenCollection().join("\n");
                alert("The following files have been removed from the server due to the defined 5 minute timeout: \n\n" + removedAfterTimeoutFiles);
                UploadedFilesTokenBox.ClearTokenCollection();
            }
        }
        function onFileUploadStart(s, e) {
            debugger;
            uploadInProgress = true;
            uploadErrorOccurred = false;
            UploadedFilesTokenBox.SetIsValid(true);
        }

    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">


    <div class="well">

        <%--<Ins:UploadControl runat="server" ID="test" ClientInstanceName="test"
            ShowProgressPanel="true" ShowUploadButton="true"
            ClientSideEvents-FileUploadStart="Start()" ClientSideEvents-FilesUploadComplete="End()" OnFilesUploadComplete="test_FilesUploadComplete">
        </Ins:UploadControl>--%>


        <Ins:UploadControl runat="server" ID="DocumentsUploadControl" ClientInstanceName="DocumentsUploadControl" 
            AutoStartUpload="true" ShowProgressPanel="True" ShowTextBox="false" BrowseButton-Text="Add documents" FileUploadMode="OnPageLoad" 
            ClientSideEvents-FileUploadComplete="onFileUploadComplete" ClientSideEvents-FileUploadStart="onFileUploadStart" >

        </Ins:UploadControl>


    </div>
    <div>
        <button type="button" class="btn btn-primary" onclick="UploadPost()">ثبت</button>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">

    <script type="text/javascript">

        function UploadPost() {
            alert('ok');
        }



    </script>

</asp:Content>
