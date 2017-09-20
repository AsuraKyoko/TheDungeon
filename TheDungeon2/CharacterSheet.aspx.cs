using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using System.IO;
using System.Data;

namespace TheDungeon
{
	public partial class CharacterSheet : System.Web.UI.Page
	{
		private string filePath;
		private DataView SheetDataView;

		private DataRow characterData;

		protected void Page_Load(object sender, EventArgs e)
		{
			if (!User.Identity.IsAuthenticated) // if the user is not logged in
			{
				Response.Redirect("~/Account/Login.aspx");
				return;
			}

			try
			{
				SheetDataView = (DataView)CharacterDataSource.Select(DataSourceSelectArguments.Empty);

				if (SheetDataView.Table.Rows.Count == 0)
				{
					DisplayAlert("No Character with that ID exists, or that character belongs to another user");
					Response.Redirect("~/CharacterList.aspx");
				}
				else
				{
					characterData = SheetDataView.Table.Rows[0];	//set the field characterData

					if ((User.Identity.GetUserId() != characterData.Field<string>("User")))       // This should never happen, but in case something wierd happens, it's here as a safety net
					{
						DisplayAlert("That character belongs to a different user");
						Response.Redirect("~/CharacterList.aspx");
					}
					else
					{
						//Set the text boxes on the page to have the correct data
						NameTextBox.Text = characterData.Field<string>("Name");
						ActiveCheckBox.Checked = (characterData.Field<bool>("Active")); //FIXME: this probably won't work, maybe?
						DateCreatedTextBox.Text = characterData.Field<DateTime>("DateCreated").ToLongDateString();  //FIXME: this might not work, hopefully will

						//read the text from the saved character sheet file
						filePath = Server.MapPath("~/UserSheets/" + characterData.Field<string>("User") + "/" + characterData.Field<Int32>("Id").ToString() + ".txt");
						if(File.Exists(filePath))
							SheetTextBox.Text = File.ReadAllText(filePath);
					}
				}
			}
			catch (Exception x)
			{
				DisplayAlert(x.Message);	//This should be handled better
			}
		}

		// Uploads character sheet to the server, then loads sheet text into character sheet display
		protected void UploadButton_Click(object sender, EventArgs e)
		{
			if (CharacterSheetFileUpload.PostedFile.ContentType == "text/txt")      //TODO: include other text file formats
			{
				if (File.Exists(filePath))
				{
					File.Delete(filePath);
				}
				CharacterSheetFileUpload.SaveAs(filePath);
				//SheetTextBox.Text = File.ReadAllText(filePath);
			}
			else
			{
				DisplayAlert("The uploaded file is not in the correct format.");
			}
		}

		// Downloads the character sheet to client machine.
		// TODO: should probably use AJAX
		protected void DownloadButton_Click(object sender, EventArgs e)
		{
			if (File.Exists(filePath))
			{
				Response.ContentType = "application/octet-stream";
				Response.AppendHeader("Content-Disposition", "attachment; filename=" + characterData.Field<string>("CharName") + "_" + DateTime.Now.ToShortDateString() + ".txt");
				Response.TransmitFile(filePath);
				Response.End();
			}
		}

		// Deletes this character from the database and the filesystem
		protected void DeleteCharacterButton_Click(object sender, EventArgs e)
		{
			//TODO: add confirm delete dialog box (should use javascript)

			//delete character file in filesystem
			File.Delete(filePath);

			CharacterDataSource.DeleteCommand = "DELETE FROM Characters WHERE Id = " + characterData.Field<Int32>("Id").ToString();
			CharacterDataSource.Delete();

			Response.Redirect("~/CharacterList.aspx");
		}

		protected void OnPageUnload(object sender, EventArgs e)
		{
			//SaveCharacterInformation();
		}

		//Displays a popup window with a simple alert message
		private void DisplayAlert(string message)
		{
			string script = "alert('" + message + "');";
			ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
		}
	}
}