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

    <script type="text/javascript" src='<%= ResolveUrl("~") %>Scripts/jquery.min.js'></script>
    <script type="text/javascript" src='<%= ResolveUrl("~") %>Scripts/bootstrap.min.js'></script>
    <script type="text/javascript" src='<%= ResolveUrl("~") %>Scripts/toastr.min.js'></script>
    <script type="text/javascript" src='<%= ResolveUrl("~") %>Scripts/script.js'></script>
    <script type="text/javascript" src='<%= ResolveUrl("~") %>Scripts/security.js'></script>
    <script type="text/javascript" src='<%= ResolveUrl("~") %>Scripts/myToastr.js'></script>
    <script type="text/javascript" src='<%= ResolveUrl("~") %>Scripts/basicInfo.js'></script>


    <script type="text/javascript">

        $(document).ready(function () {

            if (GetCookie("userinfo") != "") {
                debugger;
                $.ajax({
                    type: 'POST',
                    url: BaseApiURL + '/Security/Logout?token=' + GetCookie("userinfo"),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json"
                }).then
                    (
                        function (data) {
                            if (data.code == "200") {
                                SetCookie('username', null, 0, 0, 0);
                                SetCookie('userinfo', null, 0, 0, 0);
                            }
                            else {
                                ShowError("", data.message);
                            }
                        }, function (data) {
                            ShowError("", "عدم برقراری ارتباط");
                        }
                    )

            }
        });

        function CheckLogin() {
            var entity = {};
            entity.username = $("#txtUsername").val();
            entity.password = $("#txtPassword").val();
            entity.info = GetConnectionInfo();
            entity = JSON.stringify(entity);

            $.ajax({
                type: 'POST',
                url: BaseApiURL + '/Security/Login',
                data: entity,
                contentType: "application/json; charset=utf-8",
                dataType: "json"
            }).then
                (
                    function (data) {
                        if (data.code == "200") {
                            SetCookie("username", JSON.parse(entity).username, 0, 0, 15);
                            SetCookie("userinfo", data.payload[0], 0, 0, 15);
                            var lastPage = GetCookie("lastPath");
                            if (lastPage != "")
                                window.location.href = lastPage;
                            else
                                window.location.href = "/" + WebAppName + "/Default.aspx";
                        }
                        else {
                            ShowError("", data.message);
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
    </div>
</body>
</html>
