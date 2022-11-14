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
        private string stringConnection = ConfigurationManager.ConnectionStrings["connectionFernanda"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        // Insertar en la sucursal
        protected void ButtonAgregarSucursal_Click(object sender, EventArgs e)
        {

            string idSucursal = TextBoxIDSucursal.Text;
            string nombreSucursal = TextBoxNombreSucursal.Text;
            string idLugar = TextBoxIDLugar.Text;
            string idMonedaXPais = TextBoxIdMonedaXP.Text;
            string estado = DropDownListEstado.SelectedValue;
            int valueResult = 0;
            string msgResult = "";

            if (nombreSucursal != "" && idLugar != "" && idMonedaXPais != "")
            {
                try
                {
                    SqlConnection connection= new SqlConnection(stringConnection);
                    if (connection.State == ConnectionState.Closed)
                    {
                        connection.Open();


                    }
                    SqlCommand cmd = new SqlCommand("crudSucursal", connection);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@opcion", 1);
                    cmd.Parameters.AddWithValue("@nombre", SqlDbType.Int).Value = nombreSucursal;
                    cmd.Parameters.AddWithValue("@idLugar", SqlDbType.Int).Value = Convert.ToInt32(idLugar);
                    cmd.Parameters.AddWithValue("@idMonedaxPais", SqlDbType.Int).Value = Convert.ToInt32(idMonedaXPais);


                    SqlDataReader reader = cmd.ExecuteReader();


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
        // Actualizar en la sucursal
        protected void ButtonActualizarSucursal_Click(object sender, EventArgs e)
        {
            string idSucursal = TextBoxIDSucursal.Text;
            string nombreSucursal = TextBoxNombreSucursal.Text;
            string idLugar = TextBoxIDLugar.Text;
            string idMonedaXPais = TextBoxIdMonedaXP.Text;
            string estado = DropDownListEstado.SelectedValue;
            int valueResult = 0;
            string msgResult = "";



            if (idSucursal != "") 
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
                    
                    cmd.Parameters.AddWithValue("@opcion", 2);
                    cmd.Parameters.AddWithValue("@idSucursal", SqlDbType.Int).Value = Convert.ToInt32(idSucursal);
                    cmd.Parameters.AddWithValue("@nombre", SqlDbType.Int).Value = nombreSucursal;
                    cmd.Parameters.AddWithValue("@idLugar", SqlDbType.Int).Value = idLugar;
                    cmd.Parameters.AddWithValue("@idMonedaxPais", SqlDbType.Int).Value = idMonedaXPais;

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
                        GridViewSucursal.DataBind();
                        UpdatePanelSucursal.Update();
                    }
                    else
                    {
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                            "Swal.fire('Error','" + msgResult + "','error')", true);
                    }
                }

                
                catch (Exception ex)
                {
                    Response.Write("<script>alert('"+ex.Message+"');</script>");
                    
                }

            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                           "Swal.fire('Error','ID sucursal can not be null','error')", true);
            }


        }

        // Borrar en la sucursal
        protected void ButtonBorrarSucursal_Click(object sender, EventArgs e)
        {
            string idSucursal = TextBoxIDSucursal.Text;
            string nombreSucursal = TextBoxNombreSucursal.Text;
            string idLugar = TextBoxIDLugar.Text;
            string idMonedaXPais = TextBoxIdMonedaXP.Text;
            string estado = DropDownListEstado.SelectedValue;
            int valueResult = 0;
            string msgResult = "";



            if (idSucursal != "")
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

                    cmd.Parameters.AddWithValue("@opcion", 4);
                    cmd.Parameters.AddWithValue("@idSucursal", SqlDbType.Int).Value = Convert.ToInt32(idSucursal);

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
                }


                catch (Exception ex)
                {
                    Response.Write("<script>alert('" + ex.Message + "');</script>");

                }

            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                           "Swal.fire('Error','ID sucursal can not be null','error')", true);
            }

        }

        
    }
}