using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DevExpress.Web.ASPxUploadControl;

namespace WebComponent
{
    public class UploadControl : ASPxUploadControl
    {
        public UploadControl()
        {
            this.UploadButton.Text = "آپلود فایل";
            this.BrowseButton.Text = "انتخاب فایل";
        }
    }
}
