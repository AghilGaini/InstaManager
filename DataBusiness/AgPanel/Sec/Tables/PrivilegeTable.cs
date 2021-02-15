using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataLayer.Models.Generated.AgPanel;
using Utilities;

namespace DataBusiness.AgPanel.Sec.Tables
{
    public class PrivilegeTable : AgPanelBase<Privilege>
    {
        private static List<Privilege> _cachePrivilege = new List<Privilege>();

        public List<Privilege> CachePrivilege
        {
            get
            {
                if (_cachePrivilege.IsNull() || _cachePrivilege.Count == 0)
                    _cachePrivilege = this.GetAllList();
                return _cachePrivilege;
            }
        }

        public List<Privilege> GetByIds(List<long> Ids)
        {
            if (Ids.IsNull() || Ids.Count == 0)
                return new List<Privilege>();

            var Res = this.CachePrivilege;
            Res = Res.Join(Ids, o => o.ID, i => i, (o, i) => o).ToList();

            return Res;
        }
    }
}
