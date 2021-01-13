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

    public static class FacadeInstaCRBusiness
    {
        public static DataBusiness.InstaCR.robot.ActionQueueTable GetActionQueueTable()
        {
            return new InstaCR.robot.ActionQueueTable();
        }
    }
}
