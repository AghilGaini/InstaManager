using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataLayer.Models.Generated.AgPanel;

namespace DataBusiness.AgPanel.Sec.Tables
{
    public class SessoinTable : AgPanelBase<Session>
    {
        public Session GetByUserIDAndToken(long userID, string token)
        {
            var q = this.GetAll(1);
            q.And(Session.Columns.UserID, userID);
            q.And(Session.Columns.Token, token);

            return this.Fetch(q).FirstOrDefault();
        }
    }
}
