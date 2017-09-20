using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using System.IO;

namespace TheDungeon
{
	public partial class About : Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (!User.Identity.IsAuthenticated) // if the user is not logged in
			{
				Response.Redirect("~/Account/Login.aspx");
			}
			else
			{
				Session["UserId"] = User.Identity.GetUserId();
			}
		}

		protected void ConfirmAddButton_Click(object sender, EventArgs e)
		{
			CharacterListDataSource.InsertCommand = "INSERT into Characters ([User], [Name], [Active], [DateCreated]) VALUES ('" + Session["UserId"] + "', '" + AddCharacterNameTextBox.Text + "', 1, GETDATE()) SET @charIdentity=SCOPE_IDENTITY();";
			CharacterListDataSource.Insert();
			
			//TODO: add character id parameters
		}

		protected void CharacterListDataSource_Inserted(object sender, SqlDataSourceStatusEventArgs e)
		{
			string charID = e.Command.Parameters["@charIdentity"].Value.ToString();

			string filePath = Server.MapPath("~/UserSheets/" + User.Identity.GetUserId() + "/" + charID + ".txt");

			Directory.CreateDirectory(filePath);

			if (AddCharacterFileUpload.HasFile)
			{
				if (AddCharacterFileUpload.PostedFile.ContentType == "text/txt")
				{
					if (File.Exists(filePath))
					{
						File.Delete(filePath);
					}
					AddCharacterFileUpload.SaveAs(filePath);
				}
				else
				{
					DisplayAlert("Error: the file you've selected is not the proper file type.");
				}
			}
		}

		//Displays a popup window with a simple alert message
		private void DisplayAlert(string message)
		{
			string script = "alert('" + message + "');";
			ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
		}
	}
}