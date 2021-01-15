using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApp.Classes.Models
{
    public class Persons
    {
        private static List<Persons> _PersonList = new List<Persons>();

        public long ID { get; set; }
        public string Name { get; set; }
        public string Family { get; set; }

        public List<Persons> PersonList
        {

            get
            {
                try
                {
                    if (_PersonList == null || _PersonList.Count == 0)
                        return new List<Persons>();
                    return _PersonList;
                }
                catch (Exception ex)
                {

                    throw;
                }
            }
        }

        public List<Persons> GetAll()
        {
            return this.PersonList;
        }
    }
}