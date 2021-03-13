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

        public string info { get; set; }
    }

    public class Info
    {
        public long userID { get; set; }
        public string referrer { get; set; }
        public string browserName { get; set; }
        public string browserEngine { get; set; }
        public string browserVersion1a { get; set; }
        public string browserVersion1b { get; set; }
        public string browserLanguage { get; set; }
        public bool javaEnabled { get; set; }
        public bool cookieEnabled { get; set; }
        public int screenWidth { get; set; }
        public int screenHeight { get; set; }
        public int innerHeight { get; set; }
        public int innerWidth { get; set; }
        public DateTime? activateOn { get; set; }
        public DateTime? deActivateOn { get; set; }
        public string ip { get; set; }

    }

}