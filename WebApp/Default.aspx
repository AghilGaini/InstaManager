<%@ Page Title="مدیریت اینستاگرام" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApp.Default" IsDefault="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <div class="panel panel-primary">
        <div class="panel-heading">اطلاعات</div>

        <div class="panel-body">

            <div class="row FieldMargin">
                <div class="col-lg-4 col-md-4 col-sm-1"></div>
                <div class="col-lg-4 col-md-4 col-sm-1">
                    <img id="imgProfile" src="Images/DefaultAccountPic.png" class="img-circle" alt="عکس پروفایل" width="100" height="100" />
                </div>
                <div class="col-lg-4 col-md-4 col-sm-1"></div>
            </div>

            <div class="row FieldMargin">
                <div class="col-lg-8 col-md-8 col-sm-8 col-xs-6">
                    <label id="lblUsername"></label>
                </div>
                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-6">
                    <label for="txtUsername">نام کاربری</label>
                </div>
            </div>

            <div class="row FieldMargin">
                <div class="col-lg-8 col-md-8 col-sm-8 col-xs-6">
                    <label id="lblName"></label>
                </div>
                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-6">
                    <label for="txtName">نام</label>
                </div>
            </div>

            <div class="row FieldMargin">
                <div class="col-lg-8 col-md-8 col-sm-8 col-xs-6">
                    <label id="lblFamily"></label>
                </div>
                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-6">
                    <label for="txtFamily">نام خانوادگی</label>
                </div>
            </div>

            <div class="row FieldMargin">
                <div class="col-lg-8 col-md-8 col-sm-8 col-xs-6">
                    <label id="lblEmail"></label>
                </div>
                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-6">
                    <label for="txtEmail">ایمیل</label>
                </div>
            </div>

            <%--<div class="row FieldMargin">
                <div class="col-lg-8 col-md-8 col-sm-8 col-xs-6">
                    <label id="lblAddress"></label>
                </div>
                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-6">
                    <label for="txtAddress">آدرس</label>
                </div>
            </div>--%>

            <div class="row FieldMargin">
                <div class="col-lg-8 col-md-8 col-sm-8 col-xs-6">
                    <label id="lblMobile"></label>
                </div>
                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-6">
                    <label for="txtMobile">موبایل</label>
                </div>
            </div>

        </div>

    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
    <script type="text/javascript">

        $(document).ready(function () {
            GetInfo();
        });

        function GetInfo() {
            $.ajax({
                type: 'POST',
                url: '<%= ResolveUrl("~") %>Default.aspx/GetInfo',
                data: JSON.stringify({}),
                contentType: "application/json; charset=utf-8",
                dataType: "json"
            }).then
                (
                    function (data) {
                        if (data.d[0] == "1") {
                            var Userinfo = JSON.parse(data.d[1])
                            $("#lblUsername").text(Userinfo.UserName);
                            //$("#lblName").text(Userinfo.Name);
                            //$("#lblFamily").text(Userinfo.Family);
                            $("#lblEmail").text(Userinfo.Email);
                            //$("#lblAddress").text(Userinfo.Address);
                            $("#lblMobile").text(Userinfo.CellNo);
                            $("#imgProfile").attr('src', 'Images/DefaultAccountPic.png');
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
</asp:Content>
