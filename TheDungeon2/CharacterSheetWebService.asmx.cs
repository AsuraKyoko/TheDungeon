using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Microsoft.AspNet.Identity;
using System.IO;
using System.Configuration;
using System.Data.SqlClient;

namespace TheDungeon
{
	/// <summary>
	/// Manages saving changes to CharacterSheet data
	/// </summary>
	[WebService(Namespace = "http://thedungeon.net/")]
	[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
	[System.ComponentModel.ToolboxItem(false)]
	// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
	[System.Web.Script.Services.ScriptService]
	public class CharacterSheetWebService : System.Web.Services.WebService
	{

		[WebMethod]
		public string HelloWorld()
		{
			return "Hello World";
		}

		// Saves the passed in character data
		// Returns true on successful save
		[WebMethod]
		public bool SaveCharacterData(int CharId, string CharName, bool CharActive, string CharSheetText)
		{
			try
			{
				// return true if both the table update and file update succeeded, otherwise return false
				return (UpdateCharacterData(CharId, CharName, CharActive) && SaveCharacterSheetData(CharId, CharSheetText));
			}
			catch (Exception x)
			{
				// TODO: handle exception
				return false;
			}
		}

		//update the character data in the database
		private bool UpdateCharacterData(int id, string name, bool active)
		{
			string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
			string userId = User.Identity.GetUserId();

			bool result;

			using (SqlConnection con = new SqlConnection(constr))
			{
				using (SqlCommand cmd = new SqlCommand("UPDATE Characters SET Name = @CharName, Active = @CharActive WHERE [Id] = @CharId AND [User] = @UserId"))
				{
					cmd.Parameters.AddWithValue("@CharId", id);
					cmd.Parameters.AddWithValue("@UserId", userId);
					cmd.Parameters.AddWithValue("@CharName", name);
					cmd.Parameters.AddWithValue("@CharActive", active?1:0);		//set parameter to 1 if active, 0 if inactive
					cmd.Connection = con;
					con.Open();
					result = (cmd.ExecuteNonQuery() == 1);
					con.Close();
				}
			}
			return result;
		}

		// save the character sheet data to the filesystem
		private bool SaveCharacterSheetData(int CharId, string CharSheetText)
		{
			try
			{
				string filePath = Server.MapPath("~/UserSheets/" + User.Identity.GetUserId() + "/" + CharId + ".txt");

				File.WriteAllText(filePath, CharSheetText);

				return true;
			}
			catch(Exception x)
			{
				// TODO: handle exception
				return false;
			}
		}

		// TODO: check for character sheet changed elsewhere, and prompt for a reload
		// check every 30 minutes?
	}
}
