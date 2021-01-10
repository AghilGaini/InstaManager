using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApp
{
    public partial class Default : Classes.BasePage
    {
        #region PageMethod

        protected void Page_Load(object sender, EventArgs e)
        {

        }
        #endregion

        #region WebMethod
        [WebMethod]
        public static string[] GetInfo()
        {
            try
            {
                return new string[2] { "1", Newtonsoft.Json.JsonConvert.SerializeObject(CurrentUser) };
            }
            catch (Exception ex)
            {
                return new string[2] { "0", ex.Message };
            }
        }
        #endregion
    }
}