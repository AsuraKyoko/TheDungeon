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
				Response.Redirect("~/Login.aspx");
			}
			else
			{
				Session["UserId"] = User.Identity.GetUserId();
			}
		}

		protected void AddCharacterButton_Click(object sender, EventArgs e)
		{
			//TODO: implement adding new character
		}

		protected void CharactersGridView_SelectedIndexChanged(object sender, EventArgs e)
		{
			//TODO: implement selection/character sheet loading
		}
	}
}