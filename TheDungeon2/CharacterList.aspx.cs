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
			//TODO: add character to database
			//TODO: set InsertParameters
			CharacterListDataSource.InsertCommand = "INSERT into Characters ([User], [Name], [Active], [DateCreated]) VALUES ('" + Session["UserId"] + "', '" + AddCharacterNameTextBox.Text + "', 1, GETDATE())";
			CharacterListDataSource.Insert();
			//TODO: get character id
			

			/*
			string filePath = "";                   //TODO: generate file path
			if (AddCharacterFileUpload.PostedFile.ContentType == "text/txt")      //TODO: include other text file formats
			{
				if (File.Exists(filePath))
				{
					File.Delete(filePath);
				}
				AddCharacterFileUpload.SaveAs(filePath);
			}
			else
			{
				//TODO: error message
			}
			*/
		}
	}
}