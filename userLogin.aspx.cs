﻿using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace indioSupermercado
{
    public partial class userLogin : System.Web.UI.Page
    {
        //string stringConnection = ConfigurationManager.ConnectionStrings["connectionAdmin"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Unnamed1_Click(object sender, EventArgs e)
        {
            string user = user_txt.Text.Trim();
            string pass = pass_txt.Text.Trim();
            int valueResult = 0;
            string msgResult = "";

            try
            {
                //SqlConnection conObj = new SqlConnection(stringConnection);
                //if (conObj.State == ConnectionState.Closed)
                //{
                //  conObj.Open(); 
                //}
                //SqlCommand cmd = new SqlCommand("spLoginCostumer", stringConnection);
                //cmd.CommandType = CommandType.StoredProcedure;

                //cmd.Parameters.Add("@nombrUsuario", SqlDbType.VarChar).Value = user;
                //cmd.Parameters.Add("@contrasena", SqlDbType.VarChar).Value = pass;

                //SqlDataReader reader = cmd.ExecuteReader();

                //while (reader.Read())
                //{
                //    valueResult = Convert.ToInt32(reader[0].ToString());
                //    msgResult = reader[1].ToString();
                //}

                ////stringConnection.Close();
                //reader.Close();

                if (valueResult == 0)
                {
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                        "Swal.fire('Perfect','" + msgResult + "','success')", true);

                    Session["username"] = user;
                    Session["role"] = "user";
                    Session["status"] = "user";

                    Response.Redirect("homepage.aspx");
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