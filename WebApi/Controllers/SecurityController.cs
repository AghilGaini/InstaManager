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
using WebApi.Models.Security;
using WebApi.Classes;

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

        #region Account

        //Check Login
        [HttpPost]
        public IHttpActionResult Login(LoginModel model)
        {
            if (model.password.IsNull() || model.username.IsNull())
                throw new Exception("EnterRequierdValues");

            var UserInfo = DataBusiness.FacadeAgPanelBusiness.GetUserTable().GetByUsername(model.username);
            if (UserInfo.IsNull())
                throw new Exception("UserNotFound");

            if (UserInfo.Password != model.password)
                throw new Exception("WrongPassword");

            var info = model.info.FromJson<Info>();
            var NewSession = new DataLayer.Models.Generated.AgPanel.Session()
            {
                ActivateOn = DateTime.Now,
                browserEngine = info.browserEngine,
                browserLanguage = info.browserLanguage,
                BrowserName = info.browserName,
                browserVersion1a = info.browserVersion1a,
                browserVersion1b = info.browserVersion1b,
                cookieEnabled = info.cookieEnabled,
                DeActivateOn = null,
                javaEnabled = info.javaEnabled,
                Referrer = info.referrer,
                screenHeight = info.screenHeight,
                screenWidth = info.screenWidth,
                InnerHeight = info.innerHeight,
                InnerWidth = info.innerWidth,
                UserID = UserInfo.ID,
                IsActive = true,
                IP = BaseFunctions.GetIP()
            };

            var claim = new { name = model.username, userid = UserInfo.ID, issuedate = DateTime.Now }.ToJson();

            var token = claim.GenerateToken();

            NewSession.Token = token;
            NewSession.Save();

            var Res = new List<string> { token };

            return Ok(new
            {
                code = 200,
                message = "success",
                count = 1,
                payload = Res
            });

        }

        //Logout and Delete token 
        [HttpPost]
        public IHttpActionResult Logout(string token)
        {
            if (!token.IsValidToken())
                throw new Exception("Invalid Token sent");

            var tokenValues = token.TokenValues();

            var userInfo = DataBusiness.FacadeAgPanelBusiness.GetUserTable().GetByID(tokenValues.userid);
            if (userInfo.IsNull())
                throw new Exception("UserNotFound");

            var session = DataBusiness.FacadeAgPanelBusiness.GetSessoinTable().GetByUserIDAndToken(userInfo.ID, token);
            if (session.IsNull())
                throw new Exception("SessionNotFound");

            session.DeActivateOn = DateTime.Now;
            session.IsActive = false;
            session.Save();

            var Res = new List<string> { };

            return Ok(new
            {
                code = 200,
                message = "success",
                count = 1,
                payload = Res
            });

        }

        #endregion
    }
}