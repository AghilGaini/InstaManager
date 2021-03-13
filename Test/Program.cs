using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using DataBusiness;
using Utilities;

namespace Test
{
    class Program
    {
        static void Main(string[] args)
        {
            try
            {
                var a = new
                {
                    referrer = "http://localhost/InstaManager/Pages/Login.aspx",
                    browserName = "Netscape",
                    browserEngine = "Gecko",
                    browserVersion1a = "5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.82 Safari/537.36",
                    browserVersion1b = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.82 Safari/537.36",
                    javaEnabled = false,
                    cookieEnabled = true,
                    screenWidth = 1920,
                    screenHeight = 1080
                };
                var r = a.ToJson();
                var t = r.FromJson<Info>();

                Console.ReadLine();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }

    }

    public class Info
    {
        public long userID { get; set; }
        public string Referrer { get; set; }
        public string browserName { get; set; }
        public string browserEngine { get; set; }
        public string browserVersion1a { get; set; }
        public string browserVersion1b { get; set; }
        public string browserLanguage { get; set; }
        public bool javaEnabled { get; set; }
        public bool cookieEnabled { get; set; }
        public int screenWidth { get; set; }
        public int screenHeight { get; set; }
        public DateTime? activateOn { get; set; }
        public DateTime? deActivateOn { get; set; }
        public string ip { get; set; }

    }
}
