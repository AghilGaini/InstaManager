using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Utilities;

namespace WebApp.Classes.Handlers
{
    public class FileUploadHandler : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";

            var Res = new FileHandlerOuput();
            Res.Success = false;

            if (context.Request.Files.Count < 0)
            {
                context.Response.Write("Send at least on file");
                return;
            }

            string[] Url = context.Request.UrlReferrer.Segments;
            if (Url[Url.Length - 2] == "Pages/")
            {
                if (Url[Url.Length - 1] == "UploadPost.aspx")
                {
                    var FileOut = UploadNormalPost(context);

                    if (FileOut[0] == "1")
                    {

                        context.Response.Write("Path : " + FileOut[1]);
                    }
                    else
                    {
                        context.Response.Write("Error : " + FileOut[1]);
                    }
                    return;
                }
            }

            context.Response.Write("dont anythin done!!");

        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        private string[] UploadNormalPost(HttpContext context)
        {

            try
            {
                HttpFileCollection Files = context.Request.Files;
                string Path = "";

                for (int i = 0; i < Files.Count; i++)
                {
                    HttpPostedFile File = Files[i];
                    string[] FileNameSegments = File.FileName.Split('.');

                    Path = string.Format("{0}{1}{2}", Constants.UploadPost.NormalPost.TempPath, Guid.NewGuid().ToString(), FileNameSegments[1]);
                    File.SaveAs(Path);
                }

                return new string[2] { "1", Path };

            }
            catch (Exception ex)
            {
                return new string[2] { "0", ex.Message };
            }
        }
    }

    public class FileHandlerOuput
    {
        public bool Success { get; set; }
        public dynamic Result { get; set; }
    }
}