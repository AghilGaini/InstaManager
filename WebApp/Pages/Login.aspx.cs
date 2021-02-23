using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utilities;

namespace WebApp.Pages
{
    public partial class Login : Classes.BasePage
    {
        #region PageMethods
        protected void Page_Load(object sender, EventArgs e)
        {
            CurrentUser = null;
        }
        #endregion

        #region WebMethod

        [WebMethod]
        public static string[] CheckLogin(string info)
        {
            try
            {
                var values = new System.Web.Script.Serialization.JavaScriptSerializer().Deserialize<Classes.Pages.Login>(info);

                if (values.Password.IsNull() || values.UserName.IsNull())
                    throw new Exception("EnterRequierdValues");

                var UserInfo = DataBusiness.FacadeAgPanelBusiness.GetUserTable().GetByUsername(values.UserName);
                if (UserInfo.IsNull())
                    throw new Exception("UserNotFound");

                if (UserInfo.Password != values.Password)
                    throw new Exception("WrongPassword");

                CurrentUser = UserInfo;

                return new string[2] { "1", UserInfo.ID.ToString() };
            }
            catch (Exception ex)
            {
                return new string[2] { "0", ex.Message };
            }
        }

        #endregion

    }
}