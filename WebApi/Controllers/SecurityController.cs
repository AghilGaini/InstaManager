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
        #region Role

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

        #endregion

        #region User

        [HttpGet]
        public IHttpActionResult Users(string username)
        {
            var q = DataBusiness.FacadeAgPanelBusiness.GetUserTable().GetAll();
            if (username.IsNotNull())
                q.And(DataLayer.Models.Generated.AgPanel.User.Columns.UserName, DataLayer.Filter.Like, username);
            q.OrderBy(DataLayer.Models.Generated.AgPanel.User.Columns.ID, "DESC");

            var Res = DataBusiness.FacadeAgPanelBusiness.GetUserTable().Fetch(q);

            return Ok(new
            {
                code = 200,
                message = "success",
                count = Res.Count,
                payload = Res
            });

        }

        [HttpPost]
        public IHttpActionResult Users(Models.Security.UsersModel model)
        {
            if (model.username.IsNull())
                throw new Exception("نام کاربری نمیتواند خالی باشد");

            bool isNewUser = false;
            var user = DataBusiness.FacadeAgPanelBusiness.GetUserTable().GetByID(model.ID);
            if (user.IsNull())
            {
                if (model.password.IsNull())
                    throw new Exception("رمز عبور وارد نشده است");
                if (DataBusiness.FacadeAgPanelBusiness.GetUserTable().IsDuplicateUsername(model.username.ToLower()))
                    throw new Exception("نام کاربری وارد شده تکراری میباشد");
                isNewUser = true;
                user = new DataLayer.Models.Generated.AgPanel.User();
                user.UserName = model.username.ToLower();
                user.Password = model.password;
            }
            user.Password = model.password.IsNotNull() ? model.password : user.Password;
            user.IsActive = model.isActive;
            user.Save();


            if (!isNewUser)
                DataBusiness.FacadeAgPanelBusiness.GetStoreProcedure().SP_DeleteOldUserRoles(user.ID);

            var roles = DataBusiness.FacadeAgPanelBusiness.GetRoleTable().GetByIDs(model.roleIDs);
            var userRoles = new List<DataLayer.Models.Generated.AgPanel.UserRole>();

            foreach (var item in roles)
            {
                var newUserRole = new DataLayer.Models.Generated.AgPanel.UserRole()
                {
                    RoleID = item.ID,
                    UserID = user.ID
                };
                newUserRole.Save();
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
        public IHttpActionResult UserRoles(long userID)
        {
            var Res = DataBusiness.FacadeAgPanelBusiness.GetUserRoleTable().GetByUserID(userID);

            return Ok(new
            {
                code = 200,
                message = "success",
                count = Res.Count,
                payload = Res
            });

        }

        #endregion

    }
}