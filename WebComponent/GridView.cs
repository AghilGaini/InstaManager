using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DevExpress.Web.ASPxGridView;

namespace WebComponent
{
    public class GridView : ASPxGridView
    {

        public GridView()
        {
            this.Width = System.Web.UI.WebControls.Unit.Percentage(100);
            this.ClientSideEvents.SelectionChanged = "function(s,e) { hdn.Set('MainID',s.GetRowKey(e.visibleIndex)) }";
            this.SettingsText.EmptyDataRow = "داده ای برای نمایش وجود ندارد";
            this.PageSize = 10;
            this.AutoGenerateColumns = false;
        }
    }
}
