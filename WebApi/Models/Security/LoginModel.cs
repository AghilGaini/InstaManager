using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApi.Models.Security
{
    public class LoginModel
    {
        public string username { get; set; }
        public string password { get; set; }
    }
}