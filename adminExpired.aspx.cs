using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace indioSupermercado
{
    public partial class adminExpired : System.Web.UI.Page
    {
        string strcon = usefull.strCon;
        protected void Page_Load(object sender, EventArgs e)
        {
            sqlDataSourceExpired.ConnectionString = strcon;
        }

        protected void ButtonRemoveExpired_Click(object sender, EventArgs e)
        {
            string msgResult = "";
            int valueResult = -1;
            try
            {
                SqlConnection con = new SqlConnection(strcon);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                SqlCommand cmd = new SqlCommand("spRemoveExpiredProducts", con);
                SqlDataReader reader = cmd.ExecuteReader();

                reader.Read();
                valueResult = Convert.ToInt32(reader[0].ToString());
                msgResult = (reader[1].ToString());
                reader.Close();
                con.Close();

                if (valueResult == 0)
                {
                    expiredGridview.DataBind();
                    UpdatePanelExpired.Update();
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                            "Swal.fire('Perfect','" + msgResult + "','success')", true);
                }
                else
                {
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                        "Swal.fire('Error','" + msgResult + "','error')", true);
                }

            }
            catch(Exception ex) {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                    "Swal.fire('Error','" + ex.Message + "','error')", true);
            }
        }
    }
}