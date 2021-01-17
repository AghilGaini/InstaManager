using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApi.Models
{
    public class TreeListModel
    {

        private static List<InsideClass> _InsideList = new List<InsideClass>();

        public class InsideClass
        {
            public string Name { get; set; }
            public string Family { get; set; }
            public long gid { get; set; }
            public long? gref { get; set; }
        }

        public void InitialInsideList(int number)
        {
            for (int i = 0; i < number -20; i++)
            {
                _InsideList.Add(new InsideClass()
                {
                    Family = "Family_" + i.ToString(),
                    Name = "Name_" + i.ToString(),
                    gid = i,
                    gref = null
                });
            }

            for(int i = number-20;i<number-10;i++)
            {
                _InsideList.Add(new InsideClass()
                {
                    Family = "Family_" + i.ToString(),
                    Name = "Name_" + i.ToString(),
                    gid = i,
                    gref = i-10
                });
            }

            for (int i = number - 10; i < number ; i++)
            {
                _InsideList.Add(new InsideClass()
                {
                    Family = "Family_" + i.ToString(),
                    Name = "Name_" + i.ToString(),
                    gid = i,
                    gref = i - 10
                });
            }


        }

        public List<InsideClass> InsideList
        {
            get
            {
                if (_InsideList == null || _InsideList.Count == 0)
                    InitialInsideList(30);
                return _InsideList;
            }
        }
    }
}