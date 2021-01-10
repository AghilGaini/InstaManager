using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PetaPoco;

namespace DataLayer
{
    public enum Filter
    {
        Like = 1,
        NotLike = 2,
        IsNull = 3,
        IsNotNull = 4,
        In = 5,
        NotIn = 6,
        Equal = 7,
        NotEqual = 8,
        GreaterThan = 9,
        GreaterThanOrEqual = 10,
        LessThan = 11,
        LessThanOrEqual = 12
    }
    public class Query
    {
        public Sql _sql { get; set; }
        private bool _isNew { get; set; }

        public Query()
        {
            _sql = new Sql();
            _isNew = true;
        }

        public Query(string TableName, int? TopCount)
        {
            if (TopCount.HasValue)
            {
                _sql = new Sql(string.Format(" SELECT TOP {0} * FROM {1} ", TopCount.Value, TableName));
            }
            else
            {
                _sql = new Sql(string.Format(" SELECT * FROM {0} ", TableName));
            }
            _isNew = true;
        }

        public void And(string Column, object Value)
        {
            if (_isNew)
            {
                _sql.Where(string.Format(" {0} = @0 ", Column), Value);
                _isNew = false;
            }
            else
            {
                _sql.Append(string.Format(" And {0} = @0 ", Column), Value);
            }
        }

        public void And(string Column, Filter SqlFilter, object Value)
        {
            string comp = "";
            if (SqlFilter == Filter.Like)
                comp = " LIKE ";
            else if (SqlFilter == Filter.NotLike)
                comp = " NOT LIKE ";
            else if (SqlFilter == Filter.In)
                comp = " IN ";
            else if (SqlFilter == Filter.NotIn)
                comp = "NOT IN";
            else if (SqlFilter == Filter.IsNull)
                comp = " IS NULL ";
            else if (SqlFilter == Filter.IsNotNull)
                comp = " IS NOT NULL ";
            else if (SqlFilter == Filter.Equal)
                comp = " = ";
            else if (SqlFilter == Filter.NotEqual)
                comp = " <> ";

            if (_isNew)
            {
                _isNew = false;

                if (Value != null)
                {
                    if (SqlFilter == Filter.Like || SqlFilter == Filter.NotLike)
                        _sql.Where(Column + " " + comp + " N'%" + Value.ToString() + "%'", null);
                    else if (SqlFilter == Filter.In || SqlFilter == Filter.NotIn)
                        _sql.Where(Column + " " + comp + " (@0)", Value);
                    else
                        _sql.Where(Column + " " + comp + " @0", Value);

                }
                else
                {
                    _sql.Where(Column + " " + comp);
                }
            }
            else
            {
                _sql.Append(" AND ");

                if (Value != null)
                {
                    if (SqlFilter  == Filter.Like || SqlFilter == Filter.NotLike)
                        _sql.Append(Column + " " + comp + " N'%" + Value.ToString() + "%'", null);
                    else if (SqlFilter == Filter.In || SqlFilter == Filter.NotIn)
                        _sql.Append(Column + " " + comp + " (@0)", Value);
                    else
                        _sql.Append(Column + " " + comp + " @0", Value);

                }
                else
                {
                    _sql.Append(Column + " " + comp);
                }
            }


        }

        public void OrderBy(string Column, string OrderType = "DESC")
        {
            _sql.OrderBy(string.Format(" {0} {1} ", Column, OrderType));
        }

    }
}
