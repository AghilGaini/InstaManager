<%@ Page Title="نمایش مودال" Language="C#" MasterPageFile="~/SiteMaster.Master" AutoEventWireup="true" CodeBehind="ModalComponent.aspx.cs"
    Inherits="WebApp.Pages.WebComponent.ModalComponent" NeedLogin="false"
    gref="8CBF69B8-983A-4B24-A950-F7440CFDD42D" gid="0D05BE60-E6C2-4623-82C5-4E0FAC3A025E" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link rel="stylesheet" type="text/css" href="../../Styles/dx.common.css" />
    <link rel="stylesheet" type="text/css" href="../../Styles/dx.light.css" />
    <link rel="stylesheet" type="text/css" href="../../Styles/DevExpressTheme/Blue-Dark-Theme.css" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
        Open modal
    </button>



    <div class="modal fade" id="myModal">
        <div class="modal-dialog modal-lg ">
            <div class="modal-content">

                <div class="modal-header">
                    <h4 class="modal-title">Modal Heading</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <div class="modal-body">

                    <div class="row SearchPanel">
                        <div class="row SearchPanelRows">
                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 SearchPanelColumns">
                                <div style="padding: 1% 1%">
                                    <div>نام</div>
                                </div>
                                <div style="padding: 1% 1%">
                                    <div id="nameTxt" style="width: 80%"></div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 SearchPanelColumns">
                                <div style="padding: 1% 1%">
                                    <div>نام خانوادگی</div>
                                </div>
                                <div style="padding: 1% 1%">
                                    <div id="familyTxt" style="width: 80%"></div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 SearchPanelColumns">
                                <div style="padding: 1% 1%">
                                    <div>سمت</div>
                                </div>
                                <div style="padding: 1% 1%">
                                    <div id="cmbPosition" style="width: 50%"></div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 SearchPanelColumns"></div>
                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 SearchPanelColumns">
                                <div style="padding: 1% 1%">
                                    <div>ادمین</div>
                                </div>
                                <div style="padding: 1% 1%">
                                    <div id="chb" style="width: 50%"></div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 SearchPanelColumns">
                                <div style="padding: 1% 1%">
                                    <div>سن</div>
                                </div>
                                <div style="padding: 1% 1%">
                                    <div id="nuAge" style="width: 50%"></div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 SearchPanelColumns"></div>
                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 SearchPanelColumns"></div>
                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 SearchPanelColumns"></div>
                            
                        </div>
                        <div class="row SearchPanelButtonColumns">
                            <div class="col-lg-12 col-md-12 col-sm-12">
                                <button type="button" class="btn btn-primary SearchPanelButton" onclick="Search()">ثبت</button>
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

    <script type="text/javascript">

        CreateComboBoxWithURL('cmbPosition', BaseApiURL + '/webcomponent/ComboBox', 'ID', 'Name', 'ID', true, true, 'سمت', '80%', null);
        CreateTextBox('nameTxt', 'نام', true, 'نام', null, null, null, true);
        CreateTextBox('familyTxt', 'نام خانوادگی', true, 'نام خانوادگی', null, null, null, true);
        CreateCheckBox('chb', true, null, '120%');
        CreateNumericBox('nuAge', 20, null, 1, true, 'سن', true, null, '80%', null, 85, 10, true);

    </script>

</asp:Content>
