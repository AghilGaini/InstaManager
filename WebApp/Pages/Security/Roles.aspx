<%@ Page Title="نقش ها" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true"
    CodeBehind="Roles.aspx.cs" Inherits="WebApp.Pages.Security.Roles" NeedLogin="false"
    gref="A4C194D1-B103-43DC-8379-ED5A6F40A000" gid="7BF8CE13-251E-49AA-87E4-2D48F5D8B388" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">

        SetCurrentPage("نقش ها");

        function CreateGrid_Roles(firstTime, url) {
            var columns = [
                { dataField: "ID", caption: "شناسه" },
                { dataField: "FaTitle", caption: "عنوان" }
            ];
            var allowedPageSizes = [5, 10, 15];

            if (firstTime == true) {
                CreateGridView('grdRoles', null, "ID", true, 5, allowedPageSizes, true, true, true, true, true, true, true, true, columns,
                    true, ExportingExcel, 'نقش ها', 'workSheet', true, 'exportButton', 'خروجی PDF', 'نقش ها', 'cmbActions');
            }
            else {
                CreateGridViewWithURL('grdRoles', "ID", true, 5, allowedPageSizes, true, true, true, true, true, true, true, true, columns,
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

        function Fill_moPrivilegeTreeList(firstTime, url) {
            var columns = [{ dataField: "FaTitle", caption: "عنوان" }];
            debugger;
            if (firstTime == true) {
                CreateTreeList('moPrivilegeTreeList', null, 'Gid', 'Gref', true, true, true, true, columns, "multiple", null);
            }
            else {
                CreateTreeListWithURL('moPrivilegeTreeList', url, 'Gid', 'Gref', true, true, true, true, columns, "multiple", null);
            }
        }

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <div class="row SearchPanel">
        <div class="row SearchPanelRows">
            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12 SearchPanelColumns">
                <div style="padding: 1% 1%">
                    <div>عنوان</div>
                </div>
                <div style="padding: 1% 1%">
                    <div id="titleTxt" style="width: 80%"></div>
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
                <button type="button" class="btn btn-primary" onclick="New()">جدید</button>
            </div>
        </div>
    </div>

    <div class="MainGrid">
        <div id="exportButton"></div>
        <div id="grdRoles"></div>
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
                                    <div>عنوان</div>
                                </div>
                                <div style="padding: 1% 1%">
                                    <div id="moTitleTxt" style="width: 80%"></div>
                                </div>
                            </div>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 SearchPanelColumns" style="direction: ltr">
                                <div style="padding: 1% 1%">
                                    <div id="moPrivilegeTreeList"></div>
                                </div>
                            </div>
                        </div>
                        <div class="row SearchPanelButtonColumns">
                            <div class="col-lg-12 col-md-12 col-sm-12">
                                <button type="button" class="btn btn-primary SearchPanelButton" onclick="SaveEdit()">ذخیره</button>
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
        CreateTextBox('titleTxt', 'عنوان', true, null, null, null, null, true);
        CreateComboBoxWithURL('cmbActions', BaseApiURL + '/webcomponent/samplepageactions', 'gid', 'title', 'gid', true, true, 'عملیات', '80%', null, true, actionValueChanged);
        CreateGrid_Roles(true);
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

            var title = CheckNull(DevexpressGetValue('titleTxt')) == true ? "" : DevexpressGetValue('titleTxt');
            var args = 'title=' + title;

            var url = BaseApiURL + '/Security/Roles?' + args;

            CreateGrid_Roles(false, url);
        }

        //#endregion

        //#region edit modal

        //#region initial modal components

        CreateTextBox('moTitleTxt', 'عنوان', true, null, null, null, null, true);
        Fill_moPrivilegeTreeList(false, BaseApiURL + '/security/privileges');

        //#endregion 

        //#region functions

        function ShowEditInfoModal() {

            if (hdn.Get("grdRoles") == undefined)
                ShowError("موردی انتخاب نشده است", "خطا");

            hdn.Set('roleID', hdn.Get("grdRoles").ID);
            debugger;
            DevexpressSetValue('moTitleTxt', hdn.Get('grdRoles').FaTitle);
            DevexpressSetValueWithURL('moPrivilegeTreeList', BaseApiURL + '/security/roleprivileges?roleid=' + hdn.Get('roleID'), 'Gid')

            $("#editInfo").modal();
        }

        function New() {
            hdn.Set('roleID', 0);
            ClearSelection('moPrivilegeTreeList');
            DevexpressSetValue('moTitleTxt', null);

            $("#editInfo").modal();
        }

        function SaveEdit() {
            debugger;
            if (CheckNull(DevexpressGetValue("moTitleTxt")) == true)
                ShowError("عنوان نقش الزامی است",);
            var selectedPrivileges = DevexpressGetValue('moPrivilegeTreeList');
            var entity = {};
            entity.roleID = hdn.Get('roleID');
            entity.roleTitle = DevexpressGetValue("moTitleTxt");
            entity.privilegeID = [];

            for (i = 0; i < selectedPrivileges.length; i++) {
                entity.privilegeID[i] = selectedPrivileges[i].ID;
            }

            entity = JSON.stringify(entity);

            var URL = BaseApiURL + '/security/RolePrivileges';

            $.ajax({
                type: 'POST',
                url: URL,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: entity
            }).then(
                function (data) {
                    debugger;
                    ClearSelection('grdRoles');
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
