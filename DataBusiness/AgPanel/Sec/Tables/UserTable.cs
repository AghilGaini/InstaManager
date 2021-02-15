using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataLayer.Models.Generated.AgPanel;

namespace DataBusiness.AgPanel.Sec.Tables
{
    public class UserTable : AgPanelBase<User>
    {
        public User GetByID(long ID)
        {
            var q = this.GetAll(1);
            q.And(User.Columns.ID, ID);

            return this.Fetch(q).FirstOrDefault();
        }

        public bool IsDuplicateUsername(string username)
        {
            var q = this.GetAll(1);
            q.And(User.Columns.UserName, username.ToLower());

            return this.Fetch(q).Any();
        }
    }
}
