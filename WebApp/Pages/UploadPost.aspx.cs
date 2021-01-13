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

                var Tags = values.Tags.Split(',').ToList();

                for(int i =0; i<Tags.Count;i++)
                {
                    if (Tags[i].Length > Constants.UploadPost.TagLength)
                        Tags.RemoveAt(i);
                }

                if (!Directory.Exists(Constants.UploadPost.NormalPost.ReadyPath(CurrentUser.ID)))
                    Directory.CreateDirectory(Constants.UploadPost.NormalPost.ReadyPath(CurrentUser.ID));

                if (File.Exists(values.Path))
                {
                    var FileName = Path.GetFileName(values.Path);
                    var DestPath = Constants.UploadPost.NormalPost.ReadyPath(CurrentUser.ID) + "//" + FileName;
                    File.Move(values.Path, DestPath);

                    var Params = new { filepath = DestPath, caption = values.Description, user_tags = Tags };

                    var ActionQueueRecord = new DataLayer.Models.Generated.InstaCR.ActionQueue()
                    {
                        ActionTypeID = 3,
                        LoginAccountID = 4,
                        Title = "1",
                        Description = "2",
                        Params = Params.ToJson(),
                        CreationDate = DateTime.Now,
                        Schedule = DateTime.Now.AddMinutes(5),
                        NumberOfExecutions = 1,
                        ErrorCode = 0,
                        //ErrorDescription = null,
                        //DoneAt = null,
                        IsActive = true,
                        ReserveNumber = -1,
                        //JsonValue = null,
                        //Val = null
                    };

                    ActionQueueRecord.Save();


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