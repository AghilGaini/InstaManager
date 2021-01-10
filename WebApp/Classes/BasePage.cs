using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DataLayer.Models.Generated.InstaManager;
using Utilities;

namespace WebApp.Classes
{
    public class BasePage : System.Web.UI.Page
    {
        private bool? _NeedLogin;
        private bool? _IsDefault;

        public bool IsDefault
        {
            get
            {
                if (!_IsDefault.HasValue)
                {
                    _IsDefault = false;
                }
                return _IsDefault.Value;
            }
            set
            {
                _IsDefault = value;
            }
        }
        public bool NeedLogin
        {
            get
            {
                if (!_NeedLogin.HasValue)
                {
                    _NeedLogin = true;
                }
                return _NeedLogin.Value;
            }
            set
            {
                _NeedLogin = value;
            }
        }
        public Guid? Gref { get; set; }
        public Guid Gid { get; set; }

        public static User CurrentUser
        {
            get
            {
                if (HttpContext.Current.Session["USER_ID"].IsNull() || HttpContext.Current.Session.IsNull())
                    return null;
                var ID = HttpContext.Current.Session["USER_ID"].ToLong();
                return DataBusiness.FacadeInstaManagerBusiness.GetUserTable().GetByID(ID);
            }
            set
            {
                if (value.IsNotNull())
                    HttpContext.Current.Session["USER_ID"] = value.ID;
                else
                    HttpContext.Current.Session["USER_ID"] = null;
            }
        }

        protected override void OnPreLoad(EventArgs e)
        {
            if(NeedLogin && CurrentUser.IsNull())
            {
                HttpContext.Current.Response.Redirect("~/Pages/Login.aspx");
                return;
            }

            //ToDO : Complete To Check privilege
            //if (NeedLogin && !IsDefault /*&& !Business.FacadeAutomation.GetVwUserPrivilegeRoleBusiness().HasPrivilege(CurrentUser, this.gid)*/)
            //{
            //    HttpContext.Current.Response.Redirect("~/Default.aspx?AccessDenied=true");
            //    return;
            //}

            base.OnPreLoad(e);
        }

        public void ShowException(Exception ex)
        {
            //ToDO : Complete This Message
            if (ex.Message == "-1000")
                Response.Redirect("~/Pages/Login.aspx");

            this.ShowUnSucceed(ex.Message);
        }

        private void ShowUnSucceed(string ErrorMessage)
        {
            var j = string.Format("$(document).ready(function() {{ShowError('','{0}'); $('.WaitMask').hide(); }});", ErrorMessage);
            System.Web.UI.ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowException", j, true);
        }

    }
}