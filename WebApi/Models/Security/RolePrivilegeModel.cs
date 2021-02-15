using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApi.Models.Security
{
    public class RolePrivilegeModel
    {
        public long roleID { get; set; }
        public string roleTitle { get; set; }
        public List<long> privilegeID { get; set; }
    }
}