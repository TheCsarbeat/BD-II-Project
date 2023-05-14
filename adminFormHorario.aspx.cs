using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.NetworkInformation;

namespace indioSupermercado
{
    public partial class adminFormHorario : System.Web.UI.Page
    {
        private string stringConnection = usefull.strCon;
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataSourceSchedule.ConnectionString = usefull.strCon;
            loadSucursal();
        }

        public void loadSucursal()
        {
            try
            {
                var nombreSucursal = new ArrayList();
                var idSucursal = new ArrayList();


                SqlConnection con = new SqlConnection(stringConnection);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand("spGetSucursales", con);
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    nombreSucursal.Add(reader[1].ToString());
                    idSucursal.Add(reader[0].ToString());
                }

                con.Close();
                if (!IsPostBack)
                {
                    for (int i = 0; i < nombreSucursal.Count; i++)
                        sucursalDropList.Items.Insert(0, new ListItem(nombreSucursal[i].ToString(), idSucursal[i].ToString()));
                    sucursalDropList.DataBind();
                }

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script.");
            }
        }

        protected void ButtonAgregarBranch_Click(object sender, EventArgs e)
        {
            string idScheduele = TextBoxIDSchedule.Text;
            string horaInicial = TextBoxSTime.Text;
            string horaFinal = TextBoxFTime.Text;
            string dia = TextBoxDia.Text;
            string idSucursal = sucursalDropList.SelectedValue;
            string status = DropDownListEstado.SelectedValue;
            int valueResult = 0;
            string msgResult = "";

            if (horaInicial != "" && horaFinal != "" && dia != "" && idSucursal != "")
            {
                try
                {
                    SqlConnection connection = new SqlConnection(stringConnection);
                    if (connection.State == ConnectionState.Closed)
                    {
                        connection.Open();


                    }
                    SqlCommand cmd = new SqlCommand("crudHorario", connection);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@opcion", 1);
                    cmd.Parameters.AddWithValue("@horaInicial", SqlDbType.Int).Value = horaInicial;
                    cmd.Parameters.AddWithValue("@horaFinal", SqlDbType.Float).Value = horaFinal;
                    cmd.Parameters.AddWithValue("@dia", SqlDbType.Int).Value = dia;
                    cmd.Parameters.AddWithValue("@idSucursal", SqlDbType.Int).Value = Convert.ToInt32(idSucursal);


                    SqlDataReader reader = cmd.ExecuteReader();


                    connection.Close();
                    reader.Close();

                    if (valueResult == 0)
                    {
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                            "Swal.fire('Perfect','" + msgResult + "','success')", true);
                        GridViewSchedule.DataBind();
                        UpdatePanelSchedule.Update();

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

        protected void ButtonActualizarBranch_Click(object sender, EventArgs e)
        {
            string idScheduele = TextBoxIDSchedule.Text;
            string horaInicial = TextBoxSTime.Text;
            string horaFinal = TextBoxFTime.Text;
            string dia = TextBoxDia.Text;
            string idSucursal = sucursalDropList.SelectedValue;
            string status = DropDownListEstado.SelectedValue;
            int valueResult = 0;
            string msgResult = "";

            if (idScheduele != "")
            {
                try
                {
                    SqlConnection connection = new SqlConnection(stringConnection);
                    if (connection.State == ConnectionState.Closed)
                    {
                        connection.Open();
                    }
                    SqlCommand cmd = new SqlCommand("crudHorario", connection);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@opcion", 2);
                    cmd.Parameters.AddWithValue("@idHorario", SqlDbType.Int).Value = Convert.ToInt32(idScheduele);
                    cmd.Parameters.AddWithValue("@horaInicial", SqlDbType.Int).Value = horaInicial;
                    cmd.Parameters.AddWithValue("@horaFinal", SqlDbType.Float).Value = horaFinal;
                    cmd.Parameters.AddWithValue("@dia", SqlDbType.Int).Value = dia;
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
                            "Swal.fire('Perfect','" + msgResult + "','success')", true);
                        GridViewSchedule.DataBind();
                        UpdatePanelSchedule.Update();
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
                           "Swal.fire('Error','ID impuesto can not be null','error')", true);
            }
        }

        protected void ButtonBorrarBranch_Click(object sender, EventArgs e)
        {
            string idScheduele = TextBoxIDSchedule.Text;
            int valueResult = 0;
            string msgResult = "";

            if (idScheduele != "")
            {
                try
                {
                    SqlConnection connection = new SqlConnection(stringConnection);
                    if (connection.State == ConnectionState.Closed)
                    {
                        connection.Open();


                    }
                    SqlCommand cmd = new SqlCommand("crudHorario", connection);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@opcion", 4);
                    cmd.Parameters.AddWithValue("@idHorario", SqlDbType.Int).Value = Convert.ToInt32(idScheduele);

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
                        GridViewSchedule.DataBind();
                        UpdatePanelSchedule.Update();
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
                           "Swal.fire('Error','ID impuesto can not be null','error')", true);
            }
        }
    }
}