using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApi.Models
{
    public class GridViewModel
    {
        private static List<InsideClass> _InsideList = new List<InsideClass>();

        public class InsideClass
        {
            public string Name { get; set; }
            public string Family { get; set; }
            public long ID { get; set; }
            public string Picture { get; set; }
        }

        public void InitialInsideList(int number)
        {
            for (int i = 0; i < number; i++)
            {
                _InsideList.Add(new InsideClass()
                {
                    Family = "Family_" + i.ToString(),
                    Name = "Name_" + i.ToString(),
                    Picture = "../../Images/DefaultAccountPic.png",
                    ID = i
                });
            }
        }

        public List<InsideClass> InsideList
        {
            get
            {
                if (_InsideList == null || _InsideList.Count == 0)
                    InitialInsideList(38);
                return _InsideList;
            }
        }
    }
}