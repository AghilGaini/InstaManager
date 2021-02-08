using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using WebApi.Models;
using Utilities;
using System.Threading.Tasks;
using System.Net.Http;
using System.Net;
using System.IO;

namespace WebApi.Controllers
{
    public class WebComponentController : System.Web.Http.ApiController
    {

        [HttpGet]
        public IHttpActionResult GridView(string name, string family, int? age)
        {
            var Res = new Models.GridViewModel().GetData(name, family, age);

            return Ok(new
            {
                code = 200,
                message = "success",
                count = Res.Count,
                payload = Res
            });

        }

        [HttpGet]
        public IHttpActionResult TreeList()
        {
            var Res = new Models.TreeListModel().InsideList;

            return Ok(new
            {
                code = 200,
                message = "success",
                count = Res.Count,
                payload = Res
            });

        }

        [HttpGet]
        public IHttpActionResult ComboBox()
        {
            var Res = new Models.GridViewModel().InsideList;

            return Ok(new
            {
                code = 200,
                message = "success",
                count = Res.Count,
                payload = Res
            });
        }

        [HttpPost]
        public IHttpActionResult ComboBox(GridViewModel.InsideClass model)
        {
            bool isNew = false;
            long lastID = 0;

            var Info = new Models.GridViewModel().InsideList.FirstOrDefault(r => r.ID == model.ID);
            if (Info.IsNull())
            {
                isNew = true;
                lastID = new Models.GridViewModel().InsideList.Max(r => r.ID);
                Info = new GridViewModel.InsideClass() { ID = lastID + 1 };
            }

            Info.Name = model.Name;
            Info.Family = model.Family;
            Info.Age = model.Age;
            Info.Picture = model.Picture;

            var Res = new Models.GridViewModel().InsideList;

            if (isNew)
                new Models.GridViewModel().InsideList.Add(Info);


            return Ok(new
            {
                code = 200,
                message = "success",
                count = Res.Count,
                payload = Res
            });
        }

        [HttpGet]
        public IHttpActionResult SamplePageActions()
        {
            var Res = new Models.Actions.SampelPage().InsideList;

            return Ok(new
            {
                code = 200,
                message = "success",
                count = Res.Count,
                payload = Res
            });
        }

        [HttpPost]
        public async Task UploadProfilePic(HttpRequestMessage Request)
        {
            var ID = HttpContext.Current.Request.Params["ID"].ToLong();
            if (ID == 0)
                throw new Exception("ID IsInvalid");

            if (!Request.Content.IsMimeMultipartContent())
            {
                throw new HttpResponseException(HttpStatusCode.UnsupportedMediaType);
            }

            var path = string.Format("{0}//{1}", Constants.UploadProfilePic.BasePath, ID.ToString());

            var provider = new MultipartFormDataStreamProvider(path);

            if (!Directory.Exists(path))
                Directory.CreateDirectory(path);

            await Request.Content.ReadAsMultipartAsync(provider);

            foreach (MultipartFileData fileData in provider.FileData)
            {
                string fileName = "";
                if (string.IsNullOrEmpty(fileData.Headers.ContentDisposition.FileName))
                {
                    fileName = Guid.NewGuid().ToString();
                }
                fileName = fileData.Headers.ContentDisposition.FileName;
                if (fileName.StartsWith("\"") && fileName.EndsWith("\""))
                {
                    fileName = fileName.Trim('"');
                }
                if (fileName.Contains(@"/") || fileName.Contains(@"\"))
                {
                    fileName = Path.GetFileName(fileName);
                }

                var filePath = Path.Combine(path, fileName);
                var fileInfo = new FileInfo(filePath);

                if (!Directory.Exists(fileInfo.Directory.FullName))
                {
                    Directory.CreateDirectory(fileInfo.Directory.FullName);
                }

                File.Move(fileData.LocalFileName, filePath);
            }
        }
    }
}