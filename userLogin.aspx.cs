using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;


namespace indioSupermercado
{
    public partial class userLogin : System.Web.UI.Page
    {
        private string stringConnection = usefull.strCon;

        private string getCostumerId (string userName)
        {
            string costumerId = "";
            try
            {
                SqlConnection conObj = new SqlConnection(stringConnection);
                if (conObj.State == ConnectionState.Closed)
                {
                    conObj.Open();
                }
                SqlCommand cmd = new SqlCommand("spGetCortumerIdByUserName", conObj);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@nombreUsuario", SqlDbType.VarChar).Value = userName;

                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    costumerId = reader[0].ToString();
                }

                //stringConnection.Close();
                reader.Close();
                conObj.Close();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script.");

            }
            return costumerId;
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Unnamed1_Click(object sender, EventArgs e)
        {
            string user = user_txt.Text.Trim();
            string pass = pass_txt.Text.Trim();
            int valueResult = -1;
            string msgResult = "";

            try
            {
                SqlConnection conObj = new SqlConnection(stringConnection);
                if (conObj.State == ConnectionState.Closed)
                {
                    conObj.Open();
                }
                SqlCommand cmd = new SqlCommand("EXEC spLoginCostumer '"+ user+"', '"+pass+"'", conObj);
                cmd.CommandType = CommandType.Text;

                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    valueResult = Convert.ToInt32(reader[0].ToString());
                    msgResult = reader[1].ToString();
                }

                //stringConnection.Close();
                reader.Close();
                conObj.Close();
                if (valueResult == 0)
                {
                    string id = getCostumerId(user);
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                        "Swal.fire('Perfect','" + msgResult + "','success').then(function() {window.location = 'branchSelector.aspx';})", true);
                    Session["username"] = user;
                    Session["role"] = "user";
                    Session["idCliente"] = id;

                }
                else
                {
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                        "Swal.fire('Error','" + msgResult + "','error')", true);
                }

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script.");

            }

        }
    }
}