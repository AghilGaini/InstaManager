<%@ Page Title="کاربران" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true"
    CodeBehind="Users.aspx.cs" Inherits="WebApp.Pages.Security.Users" NeedLogin="false"
    gref="A4C194D1-B103-43DC-8379-ED5A6F40A000" gid="5C200EA9-8266-4084-9180-8CFA40FE5A83" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">

        function CreateGrid_mainGrd(firstTime, url) {
            var columns = [
                { dataField: "UserName", caption: "نام کاربری" }
            ];
            var allowedPageSizes = [5, 10, 15];

            if (firstTime == true) {
                CreateGridView('mainGrd', null, "ID", true, 5, allowedPageSizes, true, true, true, true, true, true, true, true, columns,
                    true, ExportingExcel, 'نقش ها', 'workSheet', true, 'exportButton', 'خروجی PDF', 'نقش ها', 'cmbActions');
            }
            else {
                CreateGridViewWithURL('mainGrd', "ID", true, 5, allowedPageSizes, true, true, true, true, true, true, true, true, columns,
                    true, ExportingExcel, 'نقش ها', 'workSheet', true, 'exportButton', 'خروجی PDF', 'نقش ها', url, 'cmbActions');
            }
        }

        function ExportingExcel(e, FileName, WorkSheet) {
            var workbook = new ExcelJS.Workbook();
            var worksheet = workbook.addWorksheet(WorkSheet);

            //worksheet.columns = [{ width: 5 }, { width: 50 }, { width: 50 }, { width: 80 }];

            DevExpress.excelExporter.exportDataGrid({
                component: e.component,
                worksheet: worksheet,
                keepColumnWidths: false,
                customizeCell: function (options) {
                    var gridCell = options.gridCell;
                    var excelCell = options.excelCell;

                    if (gridCell.rowType === "data") {
                    }

                }
            }).then(function () {
                workbook.xlsx.writeBuffer().then(function (buffer) {
                    saveAs(new Blob([buffer], { type: "application/octet-stream" }), FileName + ".xlsx");
                });
            });
            e.cancel = true;
        }

        function CreateGrid_moRoleGridView(firstTime, url) {
            debugger;
            var columns = [
                { dataField: "FaTitle", caption: "عنوان" }
            ];
            var allowedPageSizes = [5, 10, 15];

            if (firstTime == true) {
                CreateGridView('moRoleGridView', null, "ID", true, 5, allowedPageSizes, true, true, true, true, true, true, true, true, columns,
                    true, ExportingExcel, 'نقش ها', 'workSheet', true, 'moRoleGridViewExportButton', 'خروجی PDF', 'نقش ها', null, 'multiple');
            }
            else {
                CreateGridViewWithURL('moRoleGridView', "ID", true, 5, allowedPageSizes, true, true, true, true, true, true, true, true, columns,
                    true, ExportingExcel, 'نقش ها', 'workSheet', true, 'moRoleGridViewExportButton', 'خروجی PDF', 'نقش ها', url, null, 'multiple');
            }
        }

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <div class="row SearchPanel">
        <div class="row SearchPanelRows">
            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12 SearchPanelColumns">
                <div style="padding: 1% 1%">
                    <div>نام کاربری</div>
                </div>
                <div style="padding: 1% 1%">
                    <div id="usernameTxt" style="width: 80%"></div>
                </div>
            </div>
        </div>
        <div class="row SearchPanelButtonColumns">
            <div class="col-lg-12 col-md-12 col-sm-12">
                <button type="button" class="btn btn-primary SearchPanelButton" onclick="Search()">جستجو</button>
            </div>
        </div>
    </div>

    <div class="ActionPanel">
        <div>
            <div style="width: 65%">
                <div id="cmbActions" style="width: 50%;"></div>
            </div>
        </div>
    </div>

    <div class="ActionPanel">
        <div class="row SearchPanelButtonColumns">
            <div>
                <button type="button" class="btn btn-primary" onclick="ShowNew()">جدید</button>
            </div>
        </div>
    </div>

    <div class="MainGrid">
        <div id="exportButton"></div>
        <div id="mainGrd"></div>
    </div>

    <div class="modal fade" id="editInfo">
        <div class="modal-dialog modal-lg ">
            <div class="modal-content">

                <div class="modal-header">
                    <h4 class="modal-title">ویرایش اطلاعات</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <div class="modal-body">

                    <div class="row SearchPanel">
                        <div class="row SearchPanelRows">
                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 SearchPanelColumns">
                                <div style="padding: 1% 1%">
                                    <div>نام کاربری</div>
                                </div>
                                <div style="padding: 1% 1%">
                                    <div id="moUsernameTxt" style="width: 80%"></div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 SearchPanelColumns">
                                <div style="padding: 1% 1%">
                                    <div>کلمه عبور</div>
                                </div>
                                <div style="padding: 1% 1%">
                                    <div id="moPasswordTxt" style="width: 80%"></div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 SearchPanelColumns">
                                <div style="padding: 1% 1%">
                                    <div>فعال</div>
                                </div>
                                <div style="padding: 1% 1%">
                                    <div id="moIsActiveChb" style="width: 80%"></div>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 SearchPanelColumns" style="direction: ltr">
                                <div style="padding: 1% 1%">
                                    <div id="moRoleGridViewExportButton"></div>
                                    <div id="moRoleGridView"></div>
                                </div>
                            </div>
                        </div>
                        <div class="row SearchPanelButtonColumns">
                            <div class="col-lg-12 col-md-12 col-sm-12">
                                <button type="button" class="btn btn-primary SearchPanelButton" onclick="NewEditSave()">ذخیره</button>
                            </div>
                        </div>
                    </div>

                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                </div>

            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">

    <script type="text/javascript">

        //#region inital Devexpress components 
        CreateTextBox('usernameTxt', 'نام کاربری', true, null, null, null, null, true);
        CreateComboBoxWithURL('cmbActions', BaseApiURL + '/webcomponent/samplepageactions', 'gid', 'title', 'gid', true, true, 'عملیات', '80%', null, true, actionValueChanged);
        CreateGrid_mainGrd(true);
        //#endregion

        //#region Other functions

        function actionValueChanged(data) {

            DevexpressSetValue('cmbActions', null);
            DevexpressDisable('cmbActions', true);
            if (data == '89EAF5F0-B97A-4B7F-9C1A-7CE072E310A4') {
                ShowEditInfoModal();
            }
            else {

            }
        }

        function Search() {

            DevexpressSetValue('cmbActions', null);
            DevexpressDisable('cmbActions', true);

            var username = CheckNull(DevexpressGetValue('usernameTxt')) == true ? "" : DevexpressGetValue('usernameTxt');
            var args = 'username=' + username;

            var url = BaseApiURL + '/Security/Users?' + args;

            CreateGrid_mainGrd(false, url);
        }

        //#endregion

        //#region edit modal

        //#region initial modal components

        CreateTextBox('moUsernameTxt', 'نام کاربری', true, null, null, null, null, true);
        CreateTextBox('moPasswordTxt', 'رمز عبور', true, null, null, null, null, true, 'password');
        CreateCheckBox('moIsActiveChb', null, null, null);
        CreateGrid_moRoleGridView(false, BaseApiURL + '/security/roles?title=');

        //#endregion

        //#region functions

        function NewEditCheck(NewEdit) {
            if (NewEdit == "New") {
                if (CheckNull(DevexpressGetValue("moUsernameTxt")) == true ||
                    CheckNull(DevexpressGetValue("moPasswordTxt")) == true) {
                    ShowError("همه موارد الزامی وارد نشده است",);
                    return false;
                }
            }
            else {
                if (hdn.Get("mainGrd") == undefined) {
                    ShowError("موردی انتخاب نشده است", "خطا");
                    return false;
                }
            }

            return true;
        }

        function ShowEditInfoModal() {
            if (hdn.Get("mainGrd") == undefined) {
                ShowError("موردی انتخاب نشده است", "خطا");
                return false;
            }

            hdn.Set('userID', hdn.Get("mainGrd").ID);
            debugger;
            DevexpressSetValue('moUsernameTxt', hdn.Get('mainGrd').UserName);
            DevexpressSetValue('moPasswordTxt', null);
            DevexpressSetValue('moIsActiveChb', hdn.Get('mainGrd').IsActive);
            DevexpressDisable('moUsernameTxt', true);
            DevexpressSetValueWithURL('moRoleGridView', BaseApiURL + '/security/UserRoles?userid=' + hdn.Get('userID'), 'RoleID')

            hdn.Set('NewEdit', 'Edit');

            $("#editInfo").modal();
        }

        function ShowNew() {

            hdn.Set('userID', 0);
            DevexpressSetValue('moUsernameTxt', null);
            DevexpressSetValue('moPasswordTxt', null);
            DevexpressSetValue('moIsActiveChb', null);
            DevexpressDisable('moUsernameTxt', false);
            //ClearSelection('moRoleGridView');

            hdn.Set('NewEdit', 'New');

            $("#editInfo").modal();
        }

        function NewEditSave() {

            if (NewEditCheck(hdn.Get('NewEdit')) == false)
                return;

            var entity = {};
            entity.ID = hdn.Get('userID');
            entity.username = DevexpressGetValue("moUsernameTxt").toLowerCase();
            entity.password = DevexpressGetValue("moPasswordTxt");
            entity.isActive = DevexpressGetValue("moIsActiveChb");
            entity.roleIDs = DevexpressGetValue('moRoleGridView').map(function (item) { return item['ID'] });
            entity = JSON.stringify(entity);

            var URL = BaseApiURL + '/security/Users';

            $.ajax({
                type: 'POST',
                url: URL,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: entity
            }).then(
                function (data) {
                    ClearSelection('mainGrd');
                    ShowSuccess('عملیات با موفقیت انحام شد', 'عملیات موفق');
                    $("#editInfo").modal('hide');
                    Search();
                },
                function (data) {
                    ShowError("data: " + data.d, "عدم برقراری ارتباط");
                }
            )

        }

        //#endregion

        //#endregion

    </script>

</asp:Content>
