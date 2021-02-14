using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApi.Models
{
    public class RolesModel
    {
        private static List<InsideClass> _InsideList = new List<InsideClass>();

        public class InsideClass
        {
            public long ID { get; set; }
            public string title { get; set; }
        }

        public void InitialInsideList()
        {
            _InsideList.Add(new InsideClass() { ID = 1, title = "Admin" });
            _InsideList.Add(new InsideClass() { ID = 2, title = "Testrole" });
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