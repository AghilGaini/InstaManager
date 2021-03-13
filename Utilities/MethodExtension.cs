using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace Utilities
{
    public static class MethodExtension
    {
        public static long ToLong(this object s)
        {
            try
            {
                return Convert.ToInt64(s);
            }
            catch
            {
                return 0;
            }
        }
        public static long? ToNullableLong(this object s)
        {
            try
            {
                return Convert.ToInt64(s);
            }
            catch
            {
                return null;
            }
        }
        public static byte ToByte(this object s)
        {
            try
            {
                return Convert.ToByte(s);
            }
            catch
            {
                return 0;
            }
        }
        public static byte? ToNullableByte(this object s)
        {
            try
            {
                return Convert.ToByte(s);
            }
            catch
            {
                return null;
            }
        }
        public static int ToInt(this object s)
        {
            try
            {
                return Convert.ToInt32(s);
            }
            catch
            {
                return 0;
            }
        }
        public static int? ToNullaleInt(this object s)
        {
            try
            {
                return Convert.ToInt32(s);
            }
            catch
            {
                return null;
            }
        }
        public static short ToShort(this object s)
        {
            try
            {
                return Convert.ToInt16(s);
            }
            catch
            {
                return 0;
            }
        }
        public static short? ToNullableShort(this object s)
        {
            try
            {
                return Convert.ToInt16(s);
            }
            catch
            {
                return null;
            }
        }
        public static bool ToBoolean(this object s)
        {
            try
            {
                return Convert.ToBoolean(s);
            }
            catch
            {
                return false;
            }
        }
        public static bool? ToNullableBoolean(this object s)
        {
            try
            {
                return Convert.ToBoolean(s);
            }
            catch
            {
                return null;
            }
        }
        public static string ToNullableString(this object s)
        {
            try
            {
                var a = s.ToString();
                if (String.IsNullOrEmpty(a))
                    return null;
                if (String.IsNullOrWhiteSpace(a))
                    return null;
                return a;
            }
            catch
            {
                return null;
            }
        }
        public static Guid? ToNullableGuid(this string s)
        {
            try
            {
                return Guid.Parse(s);
            }
            catch
            {
                return null;
            }
        }
        public static Guid ToGuid(this string s)
        {
            try
            {
                return Guid.Parse(s);
            }
            catch
            {
                return Guid.Empty;
            }
        }
        public static bool IsNotNull(this object o)
        {
            try
            {
                if (o == null)
                    return false;
                return true;
            }
            catch
            {
                return false;
            }
        }
        public static bool IsNotNull(this string s)
        {
            try
            {
                return !string.IsNullOrEmpty(s);
            }
            catch
            {
                return false;
            }
        }
        public static bool IsNull(this object o)
        {
            try
            {
                return o == null;
            }
            catch
            {
                return true;
            }
        }
        public static void DeleteDirectoryFiles(string Path)
        {
            try
            {
                System.IO.DirectoryInfo directory = new System.IO.DirectoryInfo(Path);
                foreach (System.IO.FileInfo file in directory.GetFiles()) file.Delete();
                foreach (System.IO.DirectoryInfo subDirectory in directory.GetDirectories()) subDirectory.Delete(true);
            }
            catch
            {

            }
        }
        public static string EncodeToBase64(this string s)
        {
            try
            {
                var plainTextBytes = System.Text.Encoding.UTF8.GetBytes(s);
                return System.Convert.ToBase64String(plainTextBytes);
            }
            catch
            {
                return string.Empty;
            }
        }
        public static string DecodeFromBase64(this string s)
        {
            try
            {
                var base64EncodedBytes = System.Convert.FromBase64String(s);
                return System.Text.Encoding.UTF8.GetString(base64EncodedBytes);
            }
            catch
            {
                return string.Empty;
            }
        }
        public static string ToSHA256(this string s)
        {
            using (SHA256 sha256Hash = SHA256.Create())
            {
                byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(s));

                StringBuilder builder = new StringBuilder();
                for (int i = 0; i < bytes.Length; i++)
                {
                    builder.Append(bytes[i].ToString("x2"));
                }
                return builder.ToString();
            }
        }
        public static string ToHMACSHA256(this string s, string key)
        {
            HMACSHA256 hmac = new HMACSHA256(System.Text.Encoding.UTF8.GetBytes(key));
            var res = hmac.ComputeHash(System.Text.Encoding.UTF8.GetBytes(s));
            return Convert.ToBase64String(res);
        }
        public static string ToJson(this object o)
        {
            try
            {
                return JsonConvert.SerializeObject(o);
            }
            catch
            {
                throw;
            }
        }
        public static T FromJson<T>(this object o)
        {
            try
            {
                return JsonConvert.DeserializeObject<T>(o as string);
            }
            catch
            {
                throw;
            }
        }
    }
    public static class Token
    {
        //TODO : read secretKey from database
        public static string secretKey { get; set; } = "biusbdsdiugkigvidshoiu";

        public static string GenerateToken(this string claim)
        {

            var payload64 = claim.EncodeToBase64();
            var hmac64 = (string.Format("{0}.{1}", payload64, secretKey)).ToHMACSHA256(secretKey).EncodeToBase64();
            var token = string.Format("{0}.{1}", payload64, hmac64);
            return token;
        }
        public static bool IsValidToken(this string token)
        {
            var tokenValues = token.Split('.');
            if (tokenValues.Count() != 2)
                return false;

            var payload64 = tokenValues[0];
            var hmac64 = tokenValues[1];

            var computeHMAC = (string.Format("{0}.{1}", payload64, secretKey)).ToHMACSHA256(secretKey).EncodeToBase64();
            if (computeHMAC == hmac64)
                return true;
            else
                return false;
        }
        public static TokenParameters TokenValues(this string token)
        {
            if (!token.IsValidToken())
                throw new Exception("Invalid Token");

            var tokenValues = token.Split('.');
            var Payload64 = tokenValues[0];
            var payload = (Payload64.DecodeFromBase64()).FromJson<TokenParameters>();

            return payload;
        }

        public class TokenParameters
        {
            public string name { get; set; }
            public long userid { get; set; }
            public DateTime issuedate { get; set; }
        }
    }
}
