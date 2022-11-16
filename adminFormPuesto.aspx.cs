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
    public partial class adminFormPuesto : System.Web.UI.Page
    {
        private string stringConnection = usefull.strCon;
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataSourcePositions.ConnectionString = stringConnection;
        }

        protected void ButtonAgregarPuesto_Click(object sender, EventArgs e)
        {
            string idPuesto = TextBoxPosition.Text;
            string nombre = TextBoxPositionName.Text;
            string salario = TextBoxSalary.Text;
            string estado = DropDownListEstado.SelectedValue;
            int valueResult = 0;
            string msgResult = "";

            if (nombre != "" && salario != "")
            {
                try
                {
                    SqlConnection connection = new SqlConnection(stringConnection);
                    if (connection.State == ConnectionState.Closed)
                    {
                        connection.Open();

                    }
                    SqlCommand cmd = new SqlCommand("crudPuesto", connection);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@opcion", 1);
                    cmd.Parameters.AddWithValue("@nombre", SqlDbType.Int).Value = nombre;
                    cmd.Parameters.AddWithValue("@salario", SqlDbType.Int).Value = salario;

                    SqlDataReader reader = cmd.ExecuteReader();


                    connection.Close();
                    reader.Close();

                    if (valueResult == 0)
                    {
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                            "Swal.fire('Perfect','" + msgResult + "','success')", true);
                        GridViewPosition.DataBind();
                        UpdatePanelPositions.Update();

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

        protected void ButtonActualizarPuesto_Click(object sender, EventArgs e)
        {
            string idPuesto = TextBoxPosition.Text;
            string nombre = TextBoxPositionName.Text;
            string salario = TextBoxSalary.Text;
            string estado = DropDownListEstado.SelectedValue;
            int valueResult = 0;
            string msgResult = "";

            if (idPuesto != "")
            {
                try
                {
                    SqlConnection connection = new SqlConnection(stringConnection);
                    if (connection.State == ConnectionState.Closed)
                    {
                        connection.Open();
                    }
                    SqlCommand cmd = new SqlCommand("crudPuesto", connection);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@opcion", 2);
                    cmd.Parameters.AddWithValue("@idPuesto", SqlDbType.Int).Value = Convert.ToInt32(idPuesto);
                    cmd.Parameters.AddWithValue("@nombre", SqlDbType.Int).Value = nombre;
                    cmd.Parameters.AddWithValue("@salario", SqlDbType.Int).Value = salario;

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
                            "Swal.fire('Perfect','" + msgResult + "','success')", true);
                        GridViewPosition.DataBind();
                        UpdatePanelPositions.Update();
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
                           "Swal.fire('Error','ID puesto can not be null','error')", true);
            }
        }

        protected void ButtonBorrarPuesto_Click(object sender, EventArgs e)
        {
            string idPuesto = TextBoxPosition.Text;
            int valueResult = 0;
            string msgResult = "";

            if (idPuesto != "")
            {
                try
                {
                    SqlConnection connection = new SqlConnection(stringConnection);
                    if (connection.State == ConnectionState.Closed)
                    {
                        connection.Open();
                    }

                    SqlCommand cmd = new SqlCommand("crudPuesto", connection);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@opcion", 4);
                    cmd.Parameters.AddWithValue("@idPuesto", SqlDbType.Int).Value = Convert.ToInt32(idPuesto);

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
                            "Swal.fire('Perfect','" + msgResult + "','success')", true);
                        GridViewPosition.DataBind();
                        UpdatePanelPositions.Update();
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
                           "Swal.fire('Error','ID puesto can not be null','error')", true);
            }
        }
    }
}