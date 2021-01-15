using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DevExpress.Web.ASPxEditors;

namespace WebComponent
{
    public class ComboBox : ASPxComboBox
    {
        public ComboBox()
        {
            this.NullText = "انتخاب";

        }
        protected override void OnPreRender(EventArgs e)
        {
            this.Items.Add(new ListEditItem() { Text = "انتخاب", Value = 0 });

            base.OnPreRender(e);
        }
    }
}
