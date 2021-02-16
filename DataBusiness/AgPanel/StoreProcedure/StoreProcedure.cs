using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataBusiness.AgPanel.StoreProcedure
{
    public class StoreProcedure : AgPanelBase<dynamic>
    {
        public void SP_DeleteOldRolePrivileges(long roleID)
        {
            var Res = new PetaPoco.Database(this._ConnectionStringName).Execute(" ;EXEC sec.sp_DeleteOldRolePrivileges @@roleID=@0", roleID);
        }
        public void SP_DeleteOldUserRoles(long userID)
        {
            var Res = new PetaPoco.Database(this._ConnectionStringName).Execute(" ;EXEC sec.SP_DeleteOldUserRoles @@userID=@0", userID);
        }
    }
}
