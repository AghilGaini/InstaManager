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

    }
}