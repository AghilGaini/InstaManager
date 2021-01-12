using System;
using System.Collections.Generic;
using System.IO;
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

                string[] Tags = values.Tags.Split(',');

                if (!Directory.Exists(Constants.UploadPost.NormalPost.ReadyPath(CurrentUser.ID)))
                    Directory.CreateDirectory(Constants.UploadPost.NormalPost.ReadyPath(CurrentUser.ID));

                if (File.Exists(values.Path))
                {
                    var FileName = Path.GetFileName(values.Path);
                    File.Move(values.Path, Constants.UploadPost.NormalPost.ReadyPath(CurrentUser.ID) + "//" + FileName);
                }
                else
                    throw new Exception("File Not Found");

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