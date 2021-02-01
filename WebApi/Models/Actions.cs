using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Utilities;

namespace WebApi.Models
{
    public class Actions
    {
        public class SampelPage
        {
            private static List<InsideClass> _InsideList = new List<InsideClass>();

            public class InsideClass
            {
                public string gid { get; set; }
                public string gref { get; set; }
                public string title { get; set; }
            }

            public void InitialInsideList()
            {
                _InsideList.Add(new InsideClass()
                {
                    gid = "89EAF5F0-B97A-4B7F-9C1A-7CE072E310A4",
                    gref = "B5896454-5032-4B59-8681-908316AAF5C6",
                    title = "ویرایش"
                });

                _InsideList.Add(new InsideClass()
                {
                    gid = "4D2FE3AA-2F3B-46E9-8A2B-F586D6E01760",
                    gref = "B5896454-5032-4B59-8681-908316AAF5C6",
                    title = "نمایش جزئیات"
                });
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
}