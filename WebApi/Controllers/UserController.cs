using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using Utilities;

namespace WebApi.Controllers
{
    public class UserController : ApiController
    {
        [HttpGet]
        public IHttpActionResult GetUserName(long UserID)
        {

            try
            {
                var UserInfo = DataBusiness.FacadeInstaManagerBusiness.GetUserTable().GetByID(UserID);
                if (UserInfo.IsNull())
                    throw new Exception("کاربری پیدا نشد");

                return Ok(new
                {
                    code = 200,
                    message = "success",
                    count = 1,
                    payload = UserInfo.UserName
                });

            }
            catch (Exception ex)
            {
                return Ok(new
                {
                    code = 400,
                    message = "خطا : " + ex.Message,
                    count = 1,
                    payload = 0
                });
            }

        }

    }
}