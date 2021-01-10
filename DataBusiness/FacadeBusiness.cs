using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataBusiness
{
    public static class FacadeInstaManagerBusiness
    {
        public static DataBusiness.InstaManager.dbo.UserTable GetUserTable()
        {
            return new DataBusiness.InstaManager.dbo.UserTable();
        }
    }
}
