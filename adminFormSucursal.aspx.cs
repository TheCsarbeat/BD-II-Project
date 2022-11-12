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
    public partial class adminFormSucursal : System.Web.UI.Page
    {
        private string stringConnection = ConfigurationManager.ConnectionStrings["connectionAdmin"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ButtonAgregarSucursal_Click(object sender, EventArgs e)
        {
           
            //string idCostumer = idCostumer_txt.Text;
            string nombreSursal = TextBoxNombreSucursal.Text;
            //string apellidos = last_names.Text;
            //string xlocation = xLotcation.Text;
            //string ylocation = yLocation.Text;
            //string user = user_txt.Text;
            //string password = pass_txt.Text;

            int valueResult = 0;
            string msgResult = "";

            if (true)            {

                if (true)
                {
                    try
                    {
                        SqlConnection connection = new SqlConnection(stringConnection);
                        if (connection.State == ConnectionState.Closed)
                        {
                            connection.Open();
                            

                        }
                        SqlCommand cmd = new SqlCommand("crudSucursal", connection);
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.Add("@idSucursal", SqlDbType.Int).Value = Convert.ToInt64(TextBoxIDSucursal.Text);
                        cmd.Parameters.Add("@nombre", SqlDbType.VarChar).Value = nombreSursal;
                        cmd.Parameters.Add("@idLugar", SqlDbType.Int).Value = Convert.ToInt64(TextBoxIDLugar.Text);
                        cmd.Parameters.Add("@idMonedaxPais", SqlDbType.Int).Value = Convert.ToInt64(TextBoxIdMonedaXP.Text); 
                        cmd.Parameters.Add("@idEmpleadoAdministrador", SqlDbType.Int).Value = Convert.ToInt64(TextBoxEmpAdmin.Text);



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
                                "Swal.fire('Perfect','" + msgResult + "','s')", true);
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
                    /// Titulo, mensaje, tipo
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