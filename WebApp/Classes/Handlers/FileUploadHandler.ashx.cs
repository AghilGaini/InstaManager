using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
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
                        Res.Success = true;
                        Res.Result = FileOut[1];
                        context.Response.Write(Res.ToJson());
                    }
                    else
                    {
                        Res.Success = false;
                        Res.Result = FileOut[1];
                        context.Response.Write(Res.ToJson());
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
                    HttpPostedFile CurrentFile = Files[i];
                    string[] FileNameSegments = CurrentFile.FileName.Split('.');

                    if (!Directory.Exists(Constants.UploadPost.NormalPost.TempPath))
                        Directory.CreateDirectory(Constants.UploadPost.NormalPost.TempPath);

                    Path = string.Format("{0}{1}.{2}", Constants.UploadPost.NormalPost.TempPath, Guid.NewGuid().ToString(), FileNameSegments[FileNameSegments.Length-1]);
                    CurrentFile.SaveAs(Path);
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