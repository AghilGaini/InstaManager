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
                var sk = "biusbdsdiugkigvidshoiu";

                string p = string.Format("[Name:aghil,Family:gaeini]");


                var p64 = p.EncodeToBase64();
                var hmac64 = (string.Format("{0}.{1}", p64, sk)).ToHMACSHA256(sk).EncodeToBase64();
                var packet = string.Format("{0}.{1}", p64, hmac64);

                var newPacket = "eyJuYW1lIjoiYS5nYWVpbmkiLCJpZCI6MX0=.WHhQKzFqcVhWcVBZaUV2ZlZiZGNHVmw1ckcyZEJwT2Yrd3FtenhHYTlUZz0=";
                if (newPacket.IsValidToken())
                    Console.WriteLine("ok");
                else
                    Console.WriteLine("kiri");

                //Console.WriteLine(packet);
                //Console.WriteLine(Token.GenerateToken(p));

                Console.ReadLine();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }

    }
}
