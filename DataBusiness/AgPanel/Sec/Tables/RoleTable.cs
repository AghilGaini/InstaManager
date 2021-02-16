using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataLayer.Models.Generated.AgPanel;
using Utilities;

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

        public List<Role> GetByIDs(List<long> roleIDs)
        {
            if (roleIDs.IsNull() || roleIDs.Count == 0)
                return new List<Role>();

            var q = this.GetAll();
            q.And(Role.Columns.ID, DataLayer.Filter.In, roleIDs);

            return this.Fetch(q);
        }
    }
}
