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
    public partial class UploadPost : Classes.BasePage
    {

        #region PageEvents
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        #endregion

        #region WebMethod
        [WebMethod]
        public static string[] SavePost(string info)
        {
            try
            {
                var values = new System.Web.Script.Serialization.JavaScriptSerializer().Deserialize<Classes.Pages.UploadPost>(info);

                if (values.Description.IsNull() || values.Path.IsNull())
                    throw new Exception("EnterRquierdValues");

                return new string[2] { "1", "Success" };
            }
            catch (Exception ex)
            {
                return new string[2] { "0", ex.Message };
            }
        }
        #endregion

    }
}