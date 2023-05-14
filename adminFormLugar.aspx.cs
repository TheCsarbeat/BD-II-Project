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
    public partial class adminFormLugar : System.Web.UI.Page
    {
        private string stringConnection = usefull.strCon;
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataSourceLugar.ConnectionString = usefull.strCon;
            loadCountry();

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

        protected void ButtonAgregarLugar_Click(object sender, EventArgs e)
        {
            string idUbication = TextBoxIDLugar.Text;
            string nameUbication = TextBoxNombreLugar.Text;
            string longitude = TextBoxLongitud.Text;
            string latitude = txtLatitud.Text;
            string idCountry = paisDropList.SelectedValue;
            string status = DropDownListStatusLugar.SelectedValue;
            int valueResult = 0;
            string msgResult = "";

            if (nameUbication != "" && nameUbication != "" && longitude != "" && latitude != "" && idCountry != "")
            {
                try
                {
                    SqlConnection connection = new SqlConnection(stringConnection);
                    if (connection.State == ConnectionState.Closed)
                    {
                        connection.Open();

                    }
                    SqlCommand cmd = new SqlCommand("crudLugar", connection);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@opcion", 1);
                    cmd.Parameters.AddWithValue("@nombre", SqlDbType.Int).Value = nameUbication;
                    cmd.Parameters.AddWithValue("@idPais", SqlDbType.Int).Value = Convert.ToInt32(idCountry);
                    cmd.Parameters.AddWithValue("@longitud", SqlDbType.Float).Value = longitude;
                    cmd.Parameters.AddWithValue("@latitud", SqlDbType.Float).Value = latitude;

                    SqlDataReader reader = cmd.ExecuteReader();


                    connection.Close();
                    reader.Close();

                    if (valueResult == 0)
                    {
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                            "Swal.fire('Perfect','" + msgResult + "','success')", true);
                        GridViewLugar.DataBind();
                        UpdatePanelLugar.Update();

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

        protected void ButtonActualizarLugar_Click(object sender, EventArgs e)
        {
            string idUbication = TextBoxIDLugar.Text;
            string nameUbication = TextBoxNombreLugar.Text;
            string longitude = TextBoxLongitud.Text;
            string latitude = txtLatitud.Text;
            string idCountry = paisDropList.SelectedValue;
            string status = DropDownListStatusLugar.SelectedValue;
            int valueResult = 0;
            string msgResult = "";

            if (idUbication != "")
            {
                try
                {
                    SqlConnection connection = new SqlConnection(stringConnection);
                    if (connection.State == ConnectionState.Closed)
                    {
                        connection.Open();
                    }
                    SqlCommand cmd = new SqlCommand("crudLugar", connection);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@opcion", 2);
                    cmd.Parameters.AddWithValue("@idLugar", SqlDbType.Int).Value = Convert.ToInt32(idUbication);
                    cmd.Parameters.AddWithValue("@nombre", SqlDbType.Int).Value = nameUbication;
                    cmd.Parameters.AddWithValue("@idPais", SqlDbType.Int).Value = Convert.ToInt32(idCountry);
                    cmd.Parameters.AddWithValue("@longitud", SqlDbType.Float).Value = longitude;
                    cmd.Parameters.AddWithValue("@latitud", SqlDbType.Float).Value = latitude;

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
                        GridViewLugar.DataBind();
                        UpdatePanelLugar.Update();
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
                           "Swal.fire('Error','ID lugar can not be null','error')", true);
            }
        }

        protected void ButtonBorrarLugar_Click(object sender, EventArgs e)
        {
            string idUbication = TextBoxIDLugar.Text;
            int valueResult = 0;
            string msgResult = "";

            if (idUbication != "")
            {
                try
                {
                    SqlConnection connection = new SqlConnection(stringConnection);
                    if (connection.State == ConnectionState.Closed)
                    {
                        connection.Open();


                    }
                    SqlCommand cmd = new SqlCommand("crudLugar", connection);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@opcion", 4);
                    cmd.Parameters.AddWithValue("@idLugar", SqlDbType.Int).Value = Convert.ToInt32(idUbication);

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
                        GridViewLugar.DataBind();
                        UpdatePanelLugar.Update();
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