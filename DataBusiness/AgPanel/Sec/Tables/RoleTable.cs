using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataLayer.Models.Generated.AgPanel;

namespace DataBusiness.AgPanel.Sec.Tables
{
    public class RoleTable : AgPanelBase<Role>
    {
        public Role GetByID(long roleID)
        {
            var q = this.GetAll(1);
            q.And(Role.Columns.ID, roleID);

            return this.Fetch(q).FirstOrDefault();
        }
    }
}
