using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataLayer;

namespace DataBusiness
{
    public abstract class BaseBusiness<T>
    {
        public string _TableName = PetaPoco.TableInfo.FromPoco(typeof(T)).TableName;
        public abstract string _ConnectionStringName { get; }
        
        public Query GetAll(int? TopCount = null)
        {
            return new Query(this._TableName, TopCount);
        }

        public List<T> Fetch(Query q)
        {
            return new PetaPoco.Database(this._ConnectionStringName).Fetch<T>(q._sql);
        }

        public List<T> GetAllList()
        {
            return this.Fetch(this.GetAll());
        }
    }

    public class InstaManagerBase<T> : BaseBusiness<T>
    {
        public override string _ConnectionStringName => "InstaManager";
    }
    public class InstaCRBase<T> : BaseBusiness<T>
    {
        public override string _ConnectionStringName => "InstaCR";
    }
}
