﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApp.Pages.WebComponent
{
    public partial class GridViewComponent : Classes.BasePage
    {
        public class person
        {
            public string Name { get; set; }
            public string Family { get; set; }
            public long ID { get; set; }
        }

        private List<person> _persons = new List<person>();

        #region PageMethods
        protected void Page_Load(object sender, EventArgs e)
        {
            for (int i = 0; i < 35; i++)
            {
                _persons.Add(new person()
                {
                    Family = "Family" + (i + 1).ToString(),
                    Name = "Name" + (i + 1).ToString(),
                    ID = (i + 1)
                });
            }
        }

        #endregion

        #region grd
        protected void grd_CustomCallback(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs e)
        {
            grd.DataSource = _persons;
            grd.DataBind();
        }

        protected void grd_BeforeColumnSortingGrouping(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewBeforeColumnGroupingSortingEventArgs e)
        {
            grd_CustomCallback(null, null);
        }

        protected void grd_PageIndexChanged(object sender, EventArgs e)
        {
            grd_CustomCallback(null, null);
        }

        #endregion
    }
}