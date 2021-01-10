using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataBusiness;

namespace Test
{
    class Program
    {
        static void Main(string[] args)
        {
            var q = DataBusiness.FacadeInstaManagerBusiness.GetUserTable().GetAll(1);

            q.And(DataLayer.Models.Generated.InstaManager.User.Columns.ID, 1);

            var res = DataBusiness.FacadeInstaManagerBusiness.GetUserTable().Fetch(q);

        }
    }
}
