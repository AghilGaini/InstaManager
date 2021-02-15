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
            new DataBusiness.AgPanel.StoreProcedure.StoreProcedure().SP_DeleteOldRolePrivileges(3);
        }
    }
}
