using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace indioSupermercado
{
    public partial class adminFormTipoCambio : System.Web.UI.Page
    {
        private string stringConnection = usefull.strCon;
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataSourceExchange.ConnectionString = stringConnection;
            loadCountry();
            loadCoin();
        }

        public void loadCountry()
        {
            try
            {
                var nombrePais = new ArrayList();
                var idPais = new ArrayList();


                SqlConnection con = new SqlConnection(stringConnection);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand("spGetCountries", con);
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    nombrePais.Add(reader[1].ToString());
                    idPais.Add(reader[0].ToString());
                }

                con.Close();
                if (!IsPostBack)
                {
                    for (int i = 0; i < nombrePais.Count; i++)
                        paisDropList.Items.Insert(0, new ListItem(nombrePais[i].ToString(), idPais[i].ToString()));
                    paisDropList.DataBind();
                }

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script.");
            }
        }

        public void loadCoin()
        {
            try
            {
                var nombreMoneda = new ArrayList();
                var idMoneda = new ArrayList();


                SqlConnection con = new SqlConnection(stringConnection);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand("spGetCoin", con);
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    nombreMoneda.Add(reader[1].ToString());
                    idMoneda.Add(reader[0].ToString());
                }

                con.Close();
                if (!IsPostBack)
                {
                    for (int i = 0; i < nombreMoneda.Count; i++)
                        monedaDropDownList.Items.Insert(0, new ListItem(nombreMoneda[i].ToString(), idMoneda[i].ToString()));
                    monedaDropDownList.DataBind();
                }

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script.");
            }
        }

        protected void ButtonAgregarExchange_Click(object sender, EventArgs e)
        {
            string idMonedaXPais = TextBoxIDMonedaXPais.Text;
            string idPais =paisDropList.SelectedValue;
            string cambio = cambioPorcentajeTxt.Text;
            string idMoneda = monedaDropDownList.SelectedValue;
            string estado = DropDownListEstado.SelectedValue;
            int valueResult = 0;
            string msgResult = "";

            if (idPais != "" && cambio != "" && idMoneda != "")
            {
                try
                {
                    SqlConnection connection = new SqlConnection(stringConnection);
                    if (connection.State == ConnectionState.Closed)
                    {
                        connection.Open();


                    }
                    SqlCommand cmd = new SqlCommand("crudMonedaXPais", connection);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@opcion", 1);
                    cmd.Parameters.AddWithValue("@idPais", SqlDbType.Int).Value = Convert.ToInt32(idPais);
                    cmd.Parameters.AddWithValue("@cambioPorcentaje", SqlDbType.Int).Value = cambio;
                    cmd.Parameters.AddWithValue("@idMoneda", SqlDbType.Int).Value = Convert.ToInt32(idMoneda);

                    SqlDataReader reader = cmd.ExecuteReader();


                    connection.Close();
                    reader.Close();

                    if (valueResult == 0)
                    {
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                            "Swal.fire('Perfect','" + msgResult + "','success')", true);
                        GridViewExchange.DataBind();
                        UpdatePanelExchange.Update();

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

        protected void ButtonActualizarExchange_Click(object sender, EventArgs e)
        {
            string idMonedaXPais = TextBoxIDMonedaXPais.Text;
            string idPais = paisDropList.SelectedValue;
            string cambio = cambioPorcentajeTxt.Text;
            string idMoneda = monedaDropDownList.SelectedValue;
            string estado = DropDownListEstado.SelectedValue;
            int valueResult = 0;
            string msgResult = "";


            if (idMonedaXPais != "")
            {
                try
                {
                    SqlConnection connection = new SqlConnection(stringConnection);
                    if (connection.State == ConnectionState.Closed)
                    {
                        connection.Open();
                    }
                    SqlCommand cmd = new SqlCommand("crudMonedaXPais", connection);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@opcion", 2);
                    cmd.Parameters.AddWithValue("@idMonedaxPais", SqlDbType.Int).Value = idMonedaXPais;
                    cmd.Parameters.AddWithValue("@idPais", SqlDbType.Int).Value = Convert.ToInt32(idPais);
                    cmd.Parameters.AddWithValue("@cambioPorcentaje", SqlDbType.Int).Value = cambio;
                    cmd.Parameters.AddWithValue("@idMoneda", SqlDbType.Int).Value = Convert.ToInt32(idMoneda);

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
                        GridViewExchange.DataBind();
                        UpdatePanelExchange.Update();
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
                           "Swal.fire('Error','ID idMonedaXPais can not be null','error')", true);
            }
        }

        protected void ButtonBorrarExchange_Click(object sender, EventArgs e)
        {
            string idMonedaXPais = TextBoxIDMonedaXPais.Text;
            int valueResult = 0;
            string msgResult = "";

            if (idMonedaXPais != "")
            {
                try
                {
                    SqlConnection connection = new SqlConnection(stringConnection);
                    if (connection.State == ConnectionState.Closed)
                    {
                        connection.Open();


                    }
                    SqlCommand cmd = new SqlCommand("crudMonedaXPais", connection);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@opcion", 4);
                    cmd.Parameters.AddWithValue("@idMonedaXPais", SqlDbType.Int).Value = Convert.ToInt32(idMonedaXPais);

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
                        GridViewExchange.DataBind();
                        UpdatePanelExchange.Update();
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
                           "Swal.fire('Error','ID monedaXPais can not be null','error')", true);
            }
        }
    }
}