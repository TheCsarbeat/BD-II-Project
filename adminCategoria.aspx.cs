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
    public partial class adminCategoria : System.Web.UI.Page
    {
        private string stringConnection = usefull.strCon;
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataSourceCategoria.ConnectionString = stringConnection;
        }

        protected void ButtonAgregarCategoria_Click(object sender, EventArgs e)
        {
            string nombreMetodo = TextBoxPaymentMethodName.Text;
            string descripcion = otroDetailsTXT.Text;
            int valueResult = 0;
            string msgResult = "";

            if (nombreMetodo != "" && descripcion != "")
            {
                try
                {
                    SqlConnection connection = new SqlConnection(stringConnection);
                    if (connection.State == ConnectionState.Closed)
                    {
                        connection.Open();

                    }
                    SqlCommand cmd = new SqlCommand("spCrudCategoriaProducto", connection);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@operationFlag", 0);
                    cmd.Parameters.AddWithValue("@nombre", SqlDbType.Int).Value = nombreMetodo;
                    cmd.Parameters.AddWithValue("@descripcion", SqlDbType.Int).Value = descripcion;

                    SqlDataReader reader = cmd.ExecuteReader();


                    connection.Close();
                    reader.Close();

                    if (valueResult == 0)
                    {
                        GridViewCategoria.DataBind();
                        UpdatePanelCategoria.Update();
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                            "Swal.fire('Perfect','" + msgResult + "','success')", true);
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

        protected void ButtonActualizarCategoria_Click(object sender, EventArgs e)
        {
            string idCategoria = TextBoxIDPaymentMethod.Text;
            string nombreMetodo = TextBoxPaymentMethodName.Text;
            string descripcion = otroDetailsTXT.Text;
            int valueResult = 0;
            string msgResult = "";

            if (idCategoria != "")
            {
                try
                {
                    SqlConnection connection = new SqlConnection(stringConnection);
                    if (connection.State == ConnectionState.Closed)
                    {
                        connection.Open();

                    }
                    SqlCommand cmd = new SqlCommand("spCrudCategoriaProducto", connection);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@idCategoriaProducto", SqlDbType.Int).Value = Convert.ToInt32(idCategoria);
                    cmd.Parameters.AddWithValue("@operationFlag", 1);
                    cmd.Parameters.AddWithValue("@nombre", SqlDbType.Int).Value = nombreMetodo;
                    cmd.Parameters.AddWithValue("@descripcion", SqlDbType.Int).Value = descripcion;

                    SqlDataReader reader = cmd.ExecuteReader();


                    connection.Close();
                    reader.Close();

                    if (valueResult == 0)
                    {
                        GridViewCategoria.DataBind();
                        UpdatePanelCategoria.Update();
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                            "Swal.fire('Perfect','" + msgResult + "','success')", true);
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

        protected void ButtonBorrarCategoria_Click(object sender, EventArgs e)
        {
            string idCategoria = TextBoxIDPaymentMethod.Text;
            int valueResult = 0;
            string msgResult = "";

            if (idCategoria != "")
            {
                try
                {
                    SqlConnection connection = new SqlConnection(stringConnection);
                    if (connection.State == ConnectionState.Closed)
                    {
                        connection.Open();

                    }
                    SqlCommand cmd = new SqlCommand("spCrudCategoriaProducto", connection);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@idCategoriaProducto", SqlDbType.Int).Value = Convert.ToInt32(idCategoria);
                    cmd.Parameters.AddWithValue("@operationFlag", 4);

                    SqlDataReader reader = cmd.ExecuteReader();


                    connection.Close();
                    reader.Close();

                    if (valueResult == 0)
                    {
                        GridViewCategoria.DataBind();
                        UpdatePanelCategoria.Update();
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                            "Swal.fire('Perfect','" + msgResult + "','success')", true);
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
    }
    
}