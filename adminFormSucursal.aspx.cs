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
                        string idSucursal = TextBoxIDSucursal.Text;
                        string nombreSurcursal = TextBoxNombreSucursal.Text;
                        string idLugar = TextBoxIDLugar.Text;
                        string idMonedaXPais = TextBoxIdMonedaXP.Text;
                        string estado = DropDownListEstado.SelectedValue;

                        SqlConnection connection = new SqlConnection(stringConnection);
                        if (connection.State == ConnectionState.Closed)
                        {
                            connection.Open();                            

                        }

                        SqlCommand cmd = new SqlCommand("crudSucursal", connection);
                        cmd.CommandType = CommandType.StoredProcedure;


                        cmd.Parameters.AddWithValue("@opcion", 1);
                        cmd.Parameters.AddWithValue("@nombre", nombreSurcursal);
                        cmd.Parameters.AddWithValue("@idLugar", Convert.ToInt32(idLugar));
                        cmd.Parameters.AddWithValue("@idMonedaxPais", Convert.ToInt32(idMonedaXPais));


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