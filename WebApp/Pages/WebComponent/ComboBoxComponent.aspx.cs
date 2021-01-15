using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApp.Pages.WebComponent
{
    public partial class ComboBoxComponent : Classes.BasePage
    {
        #region PageMethods
        protected void Page_Load(object sender, EventArgs e)
        {
            cmb.DataSource = new Classes.Models.Persons().PersonList;
            cmb.TextField = "Name";
            cmb.ValueField = "ID";
            cmb.ValueType = typeof(long);
            cmb.DataBind();

        }
        #endregion
    }
}