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
            _InsideList.Add(new InsideClass() { ID=0 ,gref = null, gid = "8CBF69B8-983A-4B24-A950-F7440CFDD42D", title = "WebComponents" });
            _InsideList.Add(new InsideClass() { ID=1 ,gref = "8CBF69B8-983A-4B24-A950-F7440CFDD42D", gid = "15F25352-1A63-4333-BD9F-D8581CBCA7B0", title = "GridView" });
            _InsideList.Add(new InsideClass() { ID=2 ,gref = "8CBF69B8-983A-4B24-A950-F7440CFDD42D", gid = "082D4178-0A06-4A98-B129-5DAF324241F9", title = "UploadFile" });
            _InsideList.Add(new InsideClass() { ID=3 ,gref = "8CBF69B8-983A-4B24-A950-F7440CFDD42D", gid = "94FF4C66-86F7-45B4-A690-4DF10BB9D169", title = "ComboBox" });
            _InsideList.Add(new InsideClass() { ID=4 ,gref = "8CBF69B8-983A-4B24-A950-F7440CFDD42D", gid = "48A7015B-D8F4-4A0C-B046-D063FCBB55CD", title = "TreeList" });
            _InsideList.Add(new InsideClass() { ID=5 ,gref = "8CBF69B8-983A-4B24-A950-F7440CFDD42D", gid = "9383F62E-14B4-4282-BECB-FE15FC697F15", title = "TextBox" });
            _InsideList.Add(new InsideClass() { ID=6 ,gref = "8CBF69B8-983A-4B24-A950-F7440CFDD42D", gid = "7A750C2A-BE4C-4376-9850-0201AEAEDE2B", title = "CheckBox" });
            _InsideList.Add(new InsideClass() { ID=7 ,gref = "8CBF69B8-983A-4B24-A950-F7440CFDD42D", gid = "37D4EB90-C6DE-4539-9638-AC1CF0B5684A", title = "Button" });
            _InsideList.Add(new InsideClass() { ID=8 ,gref = "8CBF69B8-983A-4B24-A950-F7440CFDD42D", gid = "F5675DC8-4C05-4932-B3A1-E72A69D56272", title = "ContextMenu" });
            _InsideList.Add(new InsideClass() { ID=9 ,gref = "8CBF69B8-983A-4B24-A950-F7440CFDD42D", gid = "0D05BE60-E6C2-4623-82C5-4E0FAC3A025E", title = "Modal" });
            _InsideList.Add(new InsideClass() { ID=10 ,gref = "8CBF69B8-983A-4B24-A950-F7440CFDD42D", gid = "4C1494A2-A8DD-4A04-A85A-2A7CF16F7002", title = "SearchPanel" });
            _InsideList.Add(new InsideClass() { ID=11 ,gref = "8CBF69B8-983A-4B24-A950-F7440CFDD42D", gid = "740B9F04-E590-4C1A-B5C0-1115B5832C6A", title = "SamplePage" });
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