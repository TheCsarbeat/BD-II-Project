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
        protected bool validateFloat(string num)
        {
            try
            {
                float asd = (float)Convert.ToDouble(num);
            }
            catch
            {
                return false;
            }
            return true;
        }

        protected bool validateInt(string num)
        {
            try
            {
                int asd = (int)Convert.ToInt64(num);
            }
            catch
            {
                return false;
            }
            return true;
        }
        // sign up button click event
        protected void signupBtn_Click(object sender, EventArgs e)
        {
            string idCostumer = idCostumer_txt.Text;
            string nombre = name_txt.Text;
            string apellidos = last_names.Text;
            string xlocation = xLotcation.Text;
            string ylocation = yLocation.Text;
            string user = user_txt.Text;
            string password = pass_txt.Text;

            int valueResult = 0;
            string msgResult = "";

            if (validateFloat(xlocation) == true || validateFloat(ylocation) == true ){

                if (idCostumer != "" && nombre != "" && apellidos != "" && xlocation != "" && ylocation != "" && user != "" &&  password != "" )
                {
                    try
                    {
                        SqlConnection connection = new SqlConnection(stringConnection);
                        if (connection.State == ConnectionState.Closed)
                        {
                            connection.Open();

                        }
                        SqlCommand cmd = new SqlCommand("spSignUpCostumer", connection);
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.Add("@nombrUsuario", SqlDbType.VarChar).Value =user;
                        cmd.Parameters.Add("@contrasena", SqlDbType.VarChar).Value = password;
                        cmd.Parameters.Add("@idCliente", SqlDbType.VarChar).Value = idCostumer;
                        cmd.Parameters.Add("@nombre", SqlDbType.VarChar).Value = nombre;
                        cmd.Parameters.Add("@apellidos", SqlDbType.VarChar).Value = apellidos;
                        cmd.Parameters.Add("@xPosition", SqlDbType.Float).Value = (float)Convert.ToDouble(xlocation);
                        cmd.Parameters.Add("@yPosition", SqlDbType.Float).Value = (float)Convert.ToDouble(ylocation); 
                        

                        SqlDataReader reader = cmd.ExecuteReader();

                        while (reader.Read())
                        {
                            valueResult = Convert.ToInt32(reader[0].ToString());
                            msgResult = reader[1].ToString();
                        }

                        connection.Close();
                        reader.Close();

                        if (valueResult == 0)
                        {                            
                            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                                "Swal.fire('Perfect','"+ msgResult + "','success')", true);
                        }
                        else
                        {
                            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                                "Swal.fire('Error','" + msgResult + "','error')", true);
                        }

                        
                        //Response.Write(alert);

                    }
                    catch (Exception ex)
                    {
                        
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                               "Swal.fire('Error','" + ex.Message + "','error')", true);
                    }
                }
                else
                {
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                               "Swal.fire('Error','Some files are empty','error')", true);
                }
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                               "Swal.fire('Error','The x and y location need to be a number!','error')", true);
            }

            
        }

        
    }
}