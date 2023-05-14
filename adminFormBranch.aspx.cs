using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Collections;

namespace indioSupermercado
{
    public partial class adminFormSucursal : System.Web.UI.Page
    {
        private string stringConnection = usefull.strCon;
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataSource1.ConnectionString = stringConnection;
            loadPlace();
            loadCoinPorcentage();
        }

        public void loadPlace()
        {
            try
            {
                var nombreLugar = new ArrayList();
                var idLugar = new ArrayList();


                SqlConnection con = new SqlConnection(stringConnection);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand("spGetLugares", con);
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    nombreLugar.Add(reader[1].ToString());
                    idLugar.Add(reader[0].ToString());
                }

                con.Close();
                if (!IsPostBack)
                {
                    for (int i = 0; i < nombreLugar.Count; i++)
                        lugarDropList.Items.Insert(0, new ListItem(nombreLugar[i].ToString(), idLugar[i].ToString()));
                    lugarDropList.DataBind();
                }

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script.");
            }
        }

        public void loadCoinPorcentage()
        {
            try
            {
                var cambioPorcentage = new ArrayList();
                var idMonedaXPais = new ArrayList();


                SqlConnection con = new SqlConnection(stringConnection);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand("spGetMonedaXPais", con);
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    cambioPorcentage.Add(reader[2].ToString());
                    idMonedaXPais.Add(reader[0].ToString());
                }

                con.Close();
                if (!IsPostBack)
                {
                    for (int i = 0; i < cambioPorcentage.Count; i++)
                        monedaXPaisDropList.Items.Insert(0, new ListItem(cambioPorcentage[i].ToString(), idMonedaXPais[i].ToString()));
                    monedaXPaisDropList.DataBind();
                }

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script.");
            }
        }
        // Insertar en la sucursal
        protected void ButtonAgregarSucursal_Click(object sender, EventArgs e)
        {

            string idSucursal = TextBoxIDSucursal.Text;
            string nombreSucursal = TextBoxNombreSucursal.Text;
            string idLugar = lugarDropList.SelectedValue;
            string idMonedaXPais = monedaXPaisDropList.SelectedValue;
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
                            "Swal.fire('Perfect','" + msgResult + "','success')", true);
                        GridViewSucursal.DataBind();
                        UpdatePanelSucursal.Update();

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
            string idLugar = lugarDropList.SelectedValue;
            string idMonedaXPais = monedaXPaisDropList.SelectedValue;
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
            string idLugar = lugarDropList.SelectedValue;
            string idMonedaXPais = monedaXPaisDropList.SelectedValue;
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