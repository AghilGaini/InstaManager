using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using WebApi.Models;
using Utilities;
using System.Threading.Tasks;
using System.Net.Http;
using System.Net;
using System.IO;

namespace WebApi.Controllers
{
    public class SecurityController : System.Web.Http.ApiController
    {

        [HttpGet]
        public IHttpActionResult Roles(string title)
        {
            var q = DataBusiness.FacadeAgPanelBusiness.GetRoleTable().GetAll();
            if (title.IsNotNull())
                q.And(DataLayer.Models.Generated.AgPanel.Role.Columns.FaTitle, DataLayer.Filter.Like, title);
            q.OrderBy(DataLayer.Models.Generated.AgPanel.Role.Columns.ID, "DESC");

            var Res = DataBusiness.FacadeAgPanelBusiness.GetRoleTable().Fetch(q);

            return Ok(new
            {
                code = 200,
                message = "success",
                count = Res.Count,
                payload = Res
            });

        }

        [HttpGet]
        public IHttpActionResult RolePrivileges(long RoleID)
        {
            var q = DataBusiness.FacadeAgPanelBusiness.GetRolePrivilegeView().GetAll();
            q.And(DataLayer.Models.Generated.AgPanel.VwRolePrivilege.Columns.RoleID, RoleID);

            var Res = DataBusiness.FacadeAgPanelBusiness.GetRolePrivilegeView().Fetch(q);

            return Ok(new
            {
                code = 200,
                message = "success",
                count = Res.Count,
                payload = Res
            });

        }

        [HttpPost]
        public IHttpActionResult RolePrivileges(Models.Security.RolePrivilegeModel model)
        {
            if (model.roleTitle.IsNull())
                throw new Exception("عنوان نقش نمیتواند خالی باشد");

            var role = DataBusiness.FacadeAgPanelBusiness.GetRoleTable().GetByID(model.roleID);
            if (role.IsNull())
                role = new DataLayer.Models.Generated.AgPanel.Role();
            role.FaTitle = model.roleTitle;
            role.Save();

            var Privileges = DataBusiness.FacadeAgPanelBusiness.GetPrivilegeTable().GetByIds(model.privilegeID);

            var newPriviligeIds = new List<long>();

            foreach (var item in Privileges)
            {
                var current = item;
                while (current.Gref.IsNotNull())
                {
                    var parrent = DataBusiness.FacadeAgPanelBusiness.GetPrivilegeTable().CachePrivilege.Where(r => r.Gid == current.Gref).FirstOrDefault();
                    if (parrent.IsNotNull())
                    {
                        if (!newPriviligeIds.Any(r => r == parrent.ID))
                            newPriviligeIds.Add(parrent.ID);
                    }
                    current = parrent;
                }
                if (!newPriviligeIds.Any(r => r == item.ID))
                    newPriviligeIds.Add(item.ID);
            }

            DataBusiness.FacadeAgPanelBusiness.GetStoreProcedure().SP_DeleteOldRolePrivileges(model.roleID);

            foreach (var item in newPriviligeIds)
            {
                var NewRolePrivilege = new DataLayer.Models.Generated.AgPanel.RolePrivilege()
                {
                    PrivilegeID = item,
                    RoleID = role.ID
                };
                NewRolePrivilege.Save();
            }

            return Ok(new
            {
                code = 200,
                message = "success",
                count = 0,
                payload = new List<int> { }
            });

        }

        [HttpGet]
        public IHttpActionResult Privileges()
        {
            var Res = DataBusiness.FacadeAgPanelBusiness.GetPrivilegeTable().GetAllList();

            return Ok(new
            {
                code = 200,
                message = "success",
                count = Res.Count,
                payload = Res
            });

        }
    }
}