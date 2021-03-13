using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApi.Classes
{
    public static class BaseFunctions
    {
        public static string GetIP()
        {
            try
            {
                return HttpContext.Current.Request.UserHostAddress;
            }
            catch
            {
                return string.Empty;
            }
        }
    }
}