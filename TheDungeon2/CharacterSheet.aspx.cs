using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using System.IO;
using System.Data;

namespace TheDungeon2
{
	public partial class CharacterSheet : System.Web.UI.Page
	{
		private bool sheetEdited = false;
		private string filePath;
		private DataView SheetDataView;

		protected void Page_Load(object sender, EventArgs e)
		{
			if (!User.Identity.IsAuthenticated) // if the user is not logged in
			{
				Response.Redirect("~/Login.aspx");
				return;
			}

			SheetDataView = (DataView)CharacterDataSource.Select(DataSourceSelectArguments.Empty);

			if (!(User.Identity.GetUserId() == SheetDataView.Table.Rows[0].Field<string>("CharUser")))
			{
				Response.Redirect("~/CharacterList.aspx");	//TODO: display message/access denied page
			}

			filePath = Server.MapPath("~/" + User.Identity.GetUserId() + "/" + SheetDataView.Table.Rows[0].Field<string>("SheetId") + ".txt");
			SheetTextBox.Text = File.ReadAllText(filePath);
		}

		protected void UploadButton_Click(object sender, EventArgs e)
		{
			if (CharacterSheetFileUpload.PostedFile.ContentType == "text/txt")
			{
				if(File.Exists(filePath))
				{
					File.Delete(filePath);
				}
				CharacterSheetFileUpload.SaveAs(filePath);
				SheetTextBox.Text = File.ReadAllText(filePath);
			}
			else
			{
				//TODO: error message
			}
		}

		protected void DownloadButton_Click(object sender, EventArgs e)
		{
			if (File.Exists(filePath))
			{
				Response.ContentType = "application/octet-stream";
				Response.AppendHeader("Content-Disposition", "attachment; filename=" +SheetDataView.Table.Rows[0].Field<string>("CharName") + "_" + DateTime.Now.ToShortDateString() + ".txt");
				Response.TransmitFile(filePath);
				Response.End();
			}
		}

		protected void SheetTextBox_TextChanged(object sender, EventArgs e)
		{
			sheetEdited = true;
		}

		protected void SaveTimer_Tick(object sender, EventArgs e)
		{
			if(sheetEdited)
			{
				File.WriteAllText(filePath, SheetTextBox.Text);
			}
		}
	}
}