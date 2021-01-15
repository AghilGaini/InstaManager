using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web.ASPxGridView;
using Utilities;

namespace WebApp.Pages
{
    public class person
    {
        public string Name { get; set; }
        public string Family { get; set; }
        public long ID { get; set; }
    }

    public partial class Test : Classes.BasePage
    {

        private List<person> _persons = new List<person>();

        #region PageMethods
        protected void Page_Load(object sender, EventArgs e)
        {
            for(int i =0;i<35;i++)
            {
                _persons.Add(new person()
                {
                    Family = "Family" + (i+1).ToString(),
                    Name = "Name" + (i + 1).ToString(),
                    ID = (i + 1)
                });
            }

            cmbTest.DataSource = _persons;
            cmbTest.TextField = "Name";
            cmbTest.ValueField = "ID";
            cmbTest.ValueType = typeof(long);
            cmbTest.DataBind();
        }
        #endregion


        protected void grdTest_CustomCallback(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs e)
        {
            grdTest.DataSource = _persons;
            grdTest.DataBind();
        }

        protected void grdTest_PageIndexChanged(object sender, EventArgs e)
        {
            grdTest_CustomCallback(null, null);

        }
    }
}