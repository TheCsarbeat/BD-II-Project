using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;

namespace indioSupermercado
{
    public partial class userSignup : System.Web.UI.Page
    {
        string stringConnection = ConfigurationManager.ConnectionStrings["connectionCostumer"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        // sign up button click event
        protected void signupBtn_Click(object sender, EventArgs e)
        {
            try
            {
                SqlConnection connection = new SqlConnection(stringConnection);
                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                    
                }
                SqlCommand cmd = new SqlCommand("spGetEvent", connection);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@fechaInicio", SqlDbType.Date).Value = "2022-01-01";
                cmd.Parameters.Add("@fechaFinal", SqlDbType.Date).Value = "2022-08-01";
                cmd.Parameters.Add("@idTipoEvento", SqlDbType.Int).Value = 1;
                cmd.Parameters.Add("@idCategoriaAsiento", SqlDbType.Int).Value = 6;

                SqlDataReader reader = cmd.ExecuteReader();
                String nombre = "";
                while (reader.Read())
                {
                    nombre = reader[0].ToString();

                }
                
                connection.Close();
                reader.Close();
                String alert = "<script> alert('testing "+ nombre + "'); </script>";
                Response.Write(alert);

            }
            catch(Exception ex)
            {
                Response.Write("<script> alert('An error have ocurred with the server'); </script>");
            }
        }

        
    }
}