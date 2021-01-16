using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;

namespace WebApi.Controllers
{
    public class WebComponentController : System.Web.Http.ApiController
    {

        [HttpGet]
        public IHttpActionResult GridView()
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

    }
}