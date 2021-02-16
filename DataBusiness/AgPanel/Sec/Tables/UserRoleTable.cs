using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataLayer.Models.Generated.AgPanel;

namespace DataBusiness.AgPanel.Sec.Tables
{
    public class UserRoleTable : AgPanelBase<UserRole>
    {
        public List<UserRole> GetByUserID(long userID)
        {
            var q = this.GetAll();
            q.And(UserRole.Columns.UserID, userID);

            return this.Fetch(q);
        }
    }
}
