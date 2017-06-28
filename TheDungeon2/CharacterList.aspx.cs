using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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
				Session.Add("UserId", User.Identity.Name);
			}
		}
	}
}