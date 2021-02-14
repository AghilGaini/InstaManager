<%@ Page Title="نقش ها" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true"
    CodeBehind="Roles.aspx.cs" Inherits="WebApp.Pages.Security.Roles" NeedLogin="false"
    gref="A4C194D1-B103-43DC-8379-ED5A6F40A000" gid="7BF8CE13-251E-49AA-87E4-2D48F5D8B388" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link rel="stylesheet" type="text/css" href="../../Styles/dx.common.css" />
    <link rel="stylesheet" type="text/css" href="../../Styles/dx.light.css" />
    <link rel="stylesheet" type="text/css" href="../../Styles/DevExpressTheme/Blue-Dark-Theme.css" />

    <script type="text/javascript">

        function CreateGrid_Roles(firstTime, url) {
            var columns = [
                { dataField: "ID", caption: "شناسه" },
                { dataField: "title", caption: "عنوان" }
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
            var columns = ["title"];
            if (firstTime == true) {
                CreateTreeList('moPrivilegeTreeList', null, 'gid', 'gref', true, true, true, true, columns, "multiple", null);
            }
            else {
                CreateTreeListWithURL('moPrivilegeTreeList', url, 'gid', 'gref', true, true, true, true, columns, "multiple", null);
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
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 SearchPanelColumns">
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

    <script src="../../Scripts/dx.all.js"></script>
    <script src="../../Scripts/dx.aspnet.data.js"></script>
    <script src="../../Scripts/CreateWebComponent.js"></script>
    <script src="../../Scripts/exceljs.min.js"></script>
    <script src="../../Scripts/FileSaver.min.js"></script>
    <script src="../../Scripts/jspdf.plugin.autotable.min.js"></script>
    <script src="../../Scripts/jspdf.umd.min.js"></script>

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
        Fill_moPrivilegeTreeList(true);

        //#endregion 

        //#region functions

        function ShowEditInfoModal() {

            var privilegesUrl = BaseApiURL + '/webcomponent/PrivilegesList';
            debugger;
            DevexpressSetValue('moTitleTxt', hdn.Get('grdRoles').title);
            Fill_moPrivilegeTreeList(false, privilegesUrl);

            $("#editInfo").modal();
        }

        function SaveEdit() {
            var entity = {};
            entity.Name = DevexpressGetValue('moNameTxt');
            entity.Family = DevexpressGetValue('moFamilyTxt');
            entity.Age = DevexpressGetValue('moAgenu');
            entity.ID = hdn.Get('grid').ID;

            entity = JSON.stringify(entity);

            var URL = BaseApiURL + '/WebComponent/ComboBox';

            $.ajax({
                type: 'POST',
                url: URL,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: entity
            }).then(
                function (data) {
                    ClearSelection('grid');
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
