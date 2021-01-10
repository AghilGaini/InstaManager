using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataLayer.Models.Generated.InstaManager;

namespace DataBusiness.InstaManager.dbo
{
    public class UserTable : InstaManager<User>
    {
        public User GetByID(long ID)
        {
            var q = this.GetAll(1);
            q.And(User.Columns.ID, ID);

            return this.Fetch(q).FirstOrDefault();
        }

        public User GetByUserName(string userName)
        {
            var q = this.GetAll(1);
            q.And(User.Columns.UserName.ToLower(), userName.ToLower());

            return this.Fetch(q).FirstOrDefault();
        }
    }
}
