using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;

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

		}
	}
}