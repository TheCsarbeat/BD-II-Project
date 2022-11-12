using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace indioSupermercado
{
    public partial class userLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Unnamed1_Click(object sender, EventArgs e)
        {
            string user = user_txt.Text.Trim();
            string pass = pass_txt.Text.Trim();
            Session["username"] = user;
            Session["role"] = "user";
            Session["status"] = "user";

            Response.Redirect("homepage.aspx");
        }
    }
}