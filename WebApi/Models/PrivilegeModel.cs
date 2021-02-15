using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApi.Models
{
    public class PrivilegeModel
    {
        private static List<InsideClass> _InsideList = new List<InsideClass>();

        public class InsideClass
        {
            public long ID { get; set; }
            public string title { get; set; }
            public string gid { get; set; }
            public string gref { get; set; }
        }

        public void InitialInsideList()
        {

        }

        public List<InsideClass> InsideList
        {
            get
            {
                if (_InsideList == null || _InsideList.Count == 0)
                    InitialInsideList();
                return _InsideList;
            }
        }
    }
}