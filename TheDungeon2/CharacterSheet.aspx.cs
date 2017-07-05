using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;

namespace TheDungeon2
{
	public partial class CharacterSheet : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (!User.Identity.IsAuthenticated) // if the user is not logged in
			{
				Response.Redirect("~/Login.aspx");
			}
			else if (!(User.Identity.GetUserId() == CharacterDataSource.))    //TODO check user ID versus character owner
			{
				Response.Redirect("~/CharacterList.aspx");	//TODO: display message/access denied page
			}
		}
	}
}