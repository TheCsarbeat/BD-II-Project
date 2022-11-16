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
    public partial class adminFormTipoPago : System.Web.UI.Page
    {
        private string stringConnection = usefull.strCon;
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataSourcePaymentMethod.ConnectionString = stringConnection;
        }

        protected void ButtonAgregarTipoPago_Click(object sender, EventArgs e)
        {
            string idMetodoPago = TextBoxIDPaymentMethod.Text;
            string nombreMetodo = TextBoxPaymentMethodName.Text;
            string otrosDetalles = otroDetailsTXT.Text;
            string estado = DropDownListEstado.SelectedValue;
            int valueResult = 0;
            string msgResult = "";

            if (nombreMetodo != "" && otrosDetalles != "")
            {
                try
                {
                    SqlConnection connection = new SqlConnection(stringConnection);
                    if (connection.State == ConnectionState.Closed)
                    {
                        connection.Open();

                    }
                    SqlCommand cmd = new SqlCommand("crudMetodoPago", connection);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@opcion", 1);
                    cmd.Parameters.AddWithValue("@nombre", SqlDbType.Int).Value = nombreMetodo;
                    cmd.Parameters.AddWithValue("@otrosDetalles", SqlDbType.Int).Value = otrosDetalles;

                    SqlDataReader reader = cmd.ExecuteReader();


                    connection.Close();
                    reader.Close();

                    if (valueResult == 0)
                    {
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                            "Swal.fire('Perfect','" + msgResult + "','success')", true);
                        GridViewPaymentMethod.DataBind();
                        UpdatePanelPaymentMethod.Update();

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

        protected void ButtonActualizarTipoPago_Click(object sender, EventArgs e)
        {
            string idMetodoPago = TextBoxIDPaymentMethod.Text;
            string nombreMetodo = TextBoxPaymentMethodName.Text;
            string otrosDetalles = otroDetailsTXT.Text;
            string estado = DropDownListEstado.SelectedValue;
            int valueResult = 0;
            string msgResult = "";

            if (idMetodoPago != "")
            {
                try
                {
                    SqlConnection connection = new SqlConnection(stringConnection);
                    if (connection.State == ConnectionState.Closed)
                    {
                        connection.Open();
                    }
                    SqlCommand cmd = new SqlCommand("crudMetodoPago", connection);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@opcion", 2);
                    cmd.Parameters.AddWithValue("@idMetodoPago", SqlDbType.Int).Value =Convert.ToInt32(idMetodoPago);
                    cmd.Parameters.AddWithValue("@nombre", SqlDbType.Int).Value = nombreMetodo;
                    cmd.Parameters.AddWithValue("@otrosDetalles", SqlDbType.Int).Value = otrosDetalles;

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
                        GridViewPaymentMethod.DataBind();
                        UpdatePanelPaymentMethod.Update();
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
                           "Swal.fire('Error','ID tipoPago can not be null','error')", true);
            }
        }

        protected void ButtonBorrarTipoPago_Click(object sender, EventArgs e)
        {
            string idMetodoPago = TextBoxIDPaymentMethod.Text;
            int valueResult = 0;
            string msgResult = "";

            if (idMetodoPago != "")
            {
                try
                {
                    SqlConnection connection = new SqlConnection(stringConnection);
                    if (connection.State == ConnectionState.Closed)
                    {
                        connection.Open();
                    }

                    SqlCommand cmd = new SqlCommand("crudMetodoPago", connection);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@opcion", 4);
                    cmd.Parameters.AddWithValue("@idMetodoPago", SqlDbType.Int).Value = Convert.ToInt32(idMetodoPago);

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
                        GridViewPaymentMethod.DataBind();
                        UpdatePanelPaymentMethod.Update();
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
                           "Swal.fire('Error','ID metodo Pago can not be null','error')", true);
            }
        }
    }
}