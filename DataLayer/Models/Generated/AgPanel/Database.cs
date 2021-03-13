




















// This file was automatically generated by the PetaPoco T4 Template
// Do not make changes directly to this file - edit the template instead
// 
// The following connection settings were used to generate this file
// 
//     Connection String Name: `AgPanel`
//     Provider:               `System.Data.SqlClient`
//     Connection String:      `Data Source=.;Initial Catalog=AgPanel;Integrated Security=False;User Id=sa;password=**zapped**;MultipleActiveResultSets=True`
//     Schema:                 ``
//     Include Views:          `True`



using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using PetaPoco;

namespace DataLayer.Models.Generated.AgPanel
{

	public partial class AgPanelDB : Database
	{
		public AgPanelDB() 
			: base("AgPanel")
		{
			CommonConstruct();
		}

		public AgPanelDB(string connectionStringName) 
			: base(connectionStringName)
		{
			CommonConstruct();
		}
		
		partial void CommonConstruct();
		
		public interface IFactory
		{
			AgPanelDB GetInstance();
		}
		
		public static IFactory Factory { get; set; }
        public static AgPanelDB GetInstance()
        {
			if (_instance!=null)
				return _instance;
				
			if (Factory!=null)
				return Factory.GetInstance();
			else
				return new AgPanelDB();
        }

		[ThreadStatic] static AgPanelDB _instance;
		
		public override void OnBeginTransaction()
		{
			if (_instance==null)
				_instance=this;
		}
		
		public override void OnEndTransaction()
		{
			if (_instance==this)
				_instance=null;
		}
        

		public class Record<T> where T:new()
		{
			public static AgPanelDB repo { get { return AgPanelDB.GetInstance(); } }
			public bool IsNew() { return repo.IsNew(this); }
			public object Insert() { return repo.Insert(this); }

			public void Save() { repo.Save(this); }
			public int Update() { return repo.Update(this); }

			public int Update(IEnumerable<string> columns) { return repo.Update(this, columns); }
			public static int Update(string sql, params object[] args) { return repo.Update<T>(sql, args); }
			public static int Update(Sql sql) { return repo.Update<T>(sql); }
			public int Delete() { return repo.Delete(this); }
			public static int Delete(string sql, params object[] args) { return repo.Delete<T>(sql, args); }
			public static int Delete(Sql sql) { return repo.Delete<T>(sql); }
			public static int Delete(object primaryKey) { return repo.Delete<T>(primaryKey); }
			public static bool Exists(object primaryKey) { return repo.Exists<T>(primaryKey); }
			public static bool Exists(string sql, params object[] args) { return repo.Exists<T>(sql, args); }
			public static T SingleOrDefault(object primaryKey) { return repo.SingleOrDefault<T>(primaryKey); }
			public static T SingleOrDefault(string sql, params object[] args) { return repo.SingleOrDefault<T>(sql, args); }
			public static T SingleOrDefault(Sql sql) { return repo.SingleOrDefault<T>(sql); }
			public static T FirstOrDefault(string sql, params object[] args) { return repo.FirstOrDefault<T>(sql, args); }
			public static T FirstOrDefault(Sql sql) { return repo.FirstOrDefault<T>(sql); }
			public static T Single(object primaryKey) { return repo.Single<T>(primaryKey); }
			public static T Single(string sql, params object[] args) { return repo.Single<T>(sql, args); }
			public static T Single(Sql sql) { return repo.Single<T>(sql); }
			public static T First(string sql, params object[] args) { return repo.First<T>(sql, args); }
			public static T First(Sql sql) { return repo.First<T>(sql); }
			public static List<T> Fetch(string sql, params object[] args) { return repo.Fetch<T>(sql, args); }
			public static List<T> Fetch(Sql sql) { return repo.Fetch<T>(sql); }
			public static List<T> Fetch(long page, long itemsPerPage, string sql, params object[] args) { return repo.Fetch<T>(page, itemsPerPage, sql, args); }
			public static List<T> Fetch(long page, long itemsPerPage, Sql sql) { return repo.Fetch<T>(page, itemsPerPage, sql); }
			public static List<T> SkipTake(long skip, long take, string sql, params object[] args) { return repo.SkipTake<T>(skip, take, sql, args); }
			public static List<T> SkipTake(long skip, long take, Sql sql) { return repo.SkipTake<T>(skip, take, sql); }
			public static Page<T> Page(long page, long itemsPerPage, string sql, params object[] args) { return repo.Page<T>(page, itemsPerPage, sql, args); }
			public static Page<T> Page(long page, long itemsPerPage, Sql sql) { return repo.Page<T>(page, itemsPerPage, sql); }
			public static IEnumerable<T> Query(string sql, params object[] args) { return repo.Query<T>(sql, args); }
			public static IEnumerable<T> Query(Sql sql) { return repo.Query<T>(sql); }

		}

	}
	



    

	[TableName("[sec].[Privilege]")]



	[PrimaryKey("ID")]




	[ExplicitColumns]

    public partial class Privilege : AgPanelDB.Record<Privilege>  
    {

	

		public static class Columns
		{	
			
				public static string ID = @"ID";
			
				public static string Gid = @"Gid";
			
				public static string EnTitle = @"EnTitle";
			
				public static string FaTitle = @"FaTitle";
			
				public static string Gref = @"Gref";
			
		}





		[Column] public long ID { get; set; }





		[Column] public string Gid { get; set; }





		[Column] public string EnTitle { get; set; }





		[Column] public string FaTitle { get; set; }





		[Column] public string Gref { get; set; }



	}

    

	[TableName("[sec].[RolePrivilege]")]



	[PrimaryKey("ID")]




	[ExplicitColumns]

    public partial class RolePrivilege : AgPanelDB.Record<RolePrivilege>  
    {

	

		public static class Columns
		{	
			
				public static string ID = @"ID";
			
				public static string RoleID = @"RoleID";
			
				public static string PrivilegeID = @"PrivilegeID";
			
		}





		[Column] public long ID { get; set; }





		[Column] public long RoleID { get; set; }





		[Column] public long PrivilegeID { get; set; }



	}

    

	[TableName("[sec].[Roles]")]



	[PrimaryKey("ID")]




	[ExplicitColumns]

    public partial class Role : AgPanelDB.Record<Role>  
    {

	

		public static class Columns
		{	
			
				public static string ID = @"ID";
			
				public static string EnTitle = @"EnTitle";
			
				public static string FaTitle = @"FaTitle";
			
		}





		[Column] public long ID { get; set; }





		[Column] public string EnTitle { get; set; }





		[Column] public string FaTitle { get; set; }



	}

    

	[TableName("[sec].[Session]")]



	[PrimaryKey("ID")]




	[ExplicitColumns]

    public partial class Session : AgPanelDB.Record<Session>  
    {

	

		public static class Columns
		{	
			
				public static string ID = @"ID";
			
				public static string UserID = @"UserID";
			
				public static string Referrer = @"Referrer";
			
				public static string BrowserName = @"BrowserName";
			
				public static string browserEngine = @"browserEngine";
			
				public static string browserVersion1a = @"browserVersion1a";
			
				public static string browserVersion1b = @"browserVersion1b";
			
				public static string browserLanguage = @"browserLanguage";
			
				public static string javaEnabled = @"javaEnabled";
			
				public static string cookieEnabled = @"cookieEnabled";
			
				public static string screenWidth = @"screenWidth";
			
				public static string screenHeight = @"screenHeight";
			
				public static string ActivateOn = @"ActivateOn";
			
				public static string DeActivateOn = @"DeActivateOn";
			
				public static string IP = @"IP";
			
				public static string Token = @"Token";
			
				public static string IsActive = @"IsActive";
			
				public static string InnerHeight = @"InnerHeight";
			
				public static string InnerWidth = @"InnerWidth";
			
		}





		[Column] public long ID { get; set; }





		[Column] public long? UserID { get; set; }





		[Column] public string Referrer { get; set; }





		[Column] public string BrowserName { get; set; }





		[Column] public string browserEngine { get; set; }





		[Column] public string browserVersion1a { get; set; }





		[Column] public string browserVersion1b { get; set; }





		[Column] public string browserLanguage { get; set; }





		[Column] public bool? javaEnabled { get; set; }





		[Column] public bool? cookieEnabled { get; set; }





		[Column] public int? screenWidth { get; set; }





		[Column] public int? screenHeight { get; set; }





		[Column] public DateTime? ActivateOn { get; set; }





		[Column] public DateTime? DeActivateOn { get; set; }





		[Column] public string IP { get; set; }





		[Column] public string Token { get; set; }





		[Column] public bool? IsActive { get; set; }





		[Column] public int? InnerHeight { get; set; }





		[Column] public int? InnerWidth { get; set; }



	}

    

	[TableName("[sec].[User]")]



	[PrimaryKey("ID")]




	[ExplicitColumns]

    public partial class User : AgPanelDB.Record<User>  
    {

	

		public static class Columns
		{	
			
				public static string ID = @"ID";
			
				public static string UserName = @"UserName";
			
				public static string Password = @"Password";
			
				public static string IsActive = @"IsActive";
			
		}





		[Column] public long ID { get; set; }





		[Column] public string UserName { get; set; }





		[Column] public string Password { get; set; }





		[Column] public bool IsActive { get; set; }



	}

    

	[TableName("[sec].[UserRole]")]



	[PrimaryKey("ID")]




	[ExplicitColumns]

    public partial class UserRole : AgPanelDB.Record<UserRole>  
    {

	

		public static class Columns
		{	
			
				public static string ID = @"ID";
			
				public static string UserID = @"UserID";
			
				public static string RoleID = @"RoleID";
			
		}





		[Column] public long ID { get; set; }





		[Column] public long UserID { get; set; }





		[Column] public long RoleID { get; set; }



	}

    

	[TableName("[sec].[VwRolePrivilege]")]




	[ExplicitColumns]

    public partial class VwRolePrivilege : AgPanelDB.Record<VwRolePrivilege>  
    {

	

		public static class Columns
		{	
			
				public static string RoleID = @"RoleID";
			
				public static string RoleEnTitle = @"RoleEnTitle";
			
				public static string RoleFaTitle = @"RoleFaTitle";
			
				public static string Gid = @"Gid";
			
				public static string Gref = @"Gref";
			
				public static string PrivilegeEnTitle = @"PrivilegeEnTitle";
			
				public static string PrivilegeFaTitle = @"PrivilegeFaTitle";
			
		}





		[Column] public long RoleID { get; set; }





		[Column] public string RoleEnTitle { get; set; }





		[Column] public string RoleFaTitle { get; set; }





		[Column] public string Gid { get; set; }





		[Column] public string Gref { get; set; }





		[Column] public string PrivilegeEnTitle { get; set; }





		[Column] public string PrivilegeFaTitle { get; set; }



	}

    

	[TableName("[sec].[VwUserRolePrivilege]")]




	[ExplicitColumns]

    public partial class VwUserRolePrivilege : AgPanelDB.Record<VwUserRolePrivilege>  
    {

	

		public static class Columns
		{	
			
				public static string RoleID = @"RoleID";
			
				public static string PrivilegeID = @"PrivilegeID";
			
				public static string Gref = @"Gref";
			
				public static string Gid = @"Gid";
			
				public static string UserID = @"UserID";
			
		}





		[Column] public long RoleID { get; set; }





		[Column] public long PrivilegeID { get; set; }





		[Column] public string Gref { get; set; }





		[Column] public string Gid { get; set; }





		[Column] public long UserID { get; set; }



	}


}
