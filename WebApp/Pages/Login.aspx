<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebApp.Pages.Login" NeedLogin="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ورود</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="~/Styles/bootstrap.min.css" />
    <link rel="stylesheet" href="~/Styles/toastr.min.css" />
    <link rel="stylesheet" href="~/Styles/style.css" />
    <link rel="stylesheet" href="~/Styles/LoginPanel.css" />

    <script type="text/javascript">

        function CheckLogin() {
            var entity = {};
            entity.Username = $("#txtUsername").val();
            entity.Password = $("#txtPassword").val();
            entity = JSON.stringify(entity);
            $.ajax({
                type: 'POST',
                url: '<%= ResolveUrl("~") %>Pages/Login.aspx/CheckLogin',
                data: JSON.stringify({ info: entity }),
                contentType: "application/json; charset=utf-8",
                dataType: "json"
            }).then
                (
                    function (data) {
                        if (data.d[0] == "1") {
                            debugger;
                            SetCookie("username", data.d[1], 0, 0, 1);
                            window.location.href = "/" + WebAppName + "/Default.aspx";
                        }
                        else if (data.d[0] == "0") {
                            ShowError("", data.d[1]);
                        }
                    }, function (data) {
                        ShowError("", "عدم برقراری ارتباط");
                    }
                )
        }

    </script>

</head>
<body>
    <form id="form1" runat="server">

        <div class="container">

            <div class="panel panel-primary LoginPanelStyle">
                <div class="panel-heading LoginPanelTitle">اطلاعات</div>
                <div class="panel-body">

                    <div class="row LoginPanelInputRowStyle">
                        <div class="col-lg-12 col-md-12 col-sm-12 LoginPanelInputColumnStyle">
                            <input type="text" class="form-control" id="txtUsername" placeholder="نام کاربری" />
                        </div>
                    </div>

                    <div class="row LoginPanelInputRowStyle">
                        <div class="col-lg-12 col-md-12 col-sm-12 LoginPanelInputColumnStyle">
                            <input type="password" class="form-control" id="txtPassword" placeholder="رمز عبور" />
                        </div>
                    </div>

                    <div class="row LoginPanelSubmitRow">
                        <div class="col-lg-12 col-md-12 col-sm-12 LoginPanelSubmitColumn">
                            <button type="button" class="btn btn-primary LoginPanelSubmitButton" onclick="CheckLogin()">ثبت</button>
                        </div>
                    </div>

                </div>
            </div>

        </div>

    </form>
    <div>
        <script type="text/javascript" src='<%= ResolveUrl("~") %>Scripts/jquery.min.js'></script>
        <script type="text/javascript" src='<%= ResolveUrl("~") %>Scripts/bootstrap.min.js'></script>
        <script type="text/javascript" src='<%= ResolveUrl("~") %>Scripts/toastr.min.js'></script>
        <script type="text/javascript" src='<%= ResolveUrl("~") %>Scripts/script.js'></script>
        <script type="text/javascript" src='<%= ResolveUrl("~") %>Scripts/security.js'></script>
        <script type="text/javascript" src='<%= ResolveUrl("~") %>Scripts/myToastr.js'></script>
        <script type="text/javascript" src='<%= ResolveUrl("~") %>Scripts/basicInfo.js'></script>

    </div>
</body>
</html>
