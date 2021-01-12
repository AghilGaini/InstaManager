using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Utilities
{
    public static class Constants
    {
        public static class UploadPost
        {
            public static class NormalPost
            {
                private static string BasePath = "D://UploadPost//NormalPost";

                public static string TempPath = string.Format("{0}//{1}//", BasePath, "Temp"); 

                public static string UploadedPath(long UserID, string FileName)
                {
                    return string.Format("{0}//{1}//{2}", BasePath, UserID.ToString(), FileName);
                }


            }
        }
    }
}
