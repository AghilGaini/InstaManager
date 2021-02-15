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

    public static class FacadeAgPanelBusiness
    {
        #region Tables
        public static DataBusiness.AgPanel.Sec.Tables.PrivilegeTable GetPrivilegeTable()
        {
            return new AgPanel.Sec.Tables.PrivilegeTable();
        }

        public static DataBusiness.AgPanel.Sec.Tables.RoleTable GetRoleTable()
        {
            return new AgPanel.Sec.Tables.RoleTable();
        }

        public static DataBusiness.AgPanel.Sec.Tables.RolePrivilegeTable GetRolePrivilegeTable()
        {
            return new AgPanel.Sec.Tables.RolePrivilegeTable();
        }

        #endregion

        #region Views

        public static DataBusiness.AgPanel.Sec.Views.RolePrivilegeView GetRolePrivilegeView()
        {
            return new AgPanel.Sec.Views.RolePrivilegeView();
        }

        #endregion

        #region StoreProcedure

        public static DataBusiness.AgPanel.StoreProcedure.StoreProcedure GetStoreProcedure()
        {
            return new AgPanel.StoreProcedure.StoreProcedure();
        }

        #endregion
    }
}
