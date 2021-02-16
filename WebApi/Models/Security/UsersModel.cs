using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApi.Models.Security
{
    public class UsersModel
    {
        public string username { get; set; }
        public string password { get; set; }
        public bool isActive { get; set; }
        public List<long> roleIDs { get; set; }
        public long ID { get; set; }
    }
}