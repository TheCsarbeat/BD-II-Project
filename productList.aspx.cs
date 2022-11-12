using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace indioSupermercado
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        string strcon = ConfigurationManager.ConnectionStrings["connectionCesar"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            try {
                SqlConnection con = new SqlConnection(strcon);
                if(con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                SqlCommand cmd = con.CreateCommand();
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select * from Producto";
                cmd.ExecuteNonQuery();
                DataTable dt = new DataTable();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                d1.DataSource = dt;
                d1.DataBind();

            }
            catch(Exception ex) {

            }
        }

        protected void btnTest_Click(object sender, EventArgs e)
        {
            Response.Write("<script>alert('Testing');</script>");
        }
    }
}