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
    public class SecurityController : System.Web.Http.ApiController
    {

        [HttpGet]
        public IHttpActionResult Roles(string title)
        {
            var Res = new Models.Security.RolesModel().GetData(title);

            return Ok(new
            {
                code = 200,
                message = "success",
                count = Res.Count,
                payload = Res
            });

        }
    }
}