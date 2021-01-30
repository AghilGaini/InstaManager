using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Utilities;

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
            public int Age { get; set; }
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
                    ID = i,
                    Age = i
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

        public List<InsideClass> GetData(string name, string family, int? age)
        {
            var All = this.InsideList;
            if (family.IsNotNull())
                All = All.Where(r => r.Family.Contains(family)).ToList();
            if (name.IsNotNull())
                All = All.Where(r => r.Name.Contains(name)).ToList();
            if (age.HasValue)
                All = All.Where(r => r.Age == age.Value).ToList();

            return All;
        }

    }
}