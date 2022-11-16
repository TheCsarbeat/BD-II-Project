using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;

namespace indioSupermercado
{
    public partial class adminFormProvider : System.Web.UI.Page
    {
        private string stringConnection = usefull.strCon;
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataSourceProvider.ConnectionString = usefull.strCon;
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

        protected void ButtonAgregarProvider_Click(object sender, EventArgs e)
        {
            string idProvider = TextBoxIDProvider.Text;
            string nameProvider = TextBoxNombreProvider.Text;
            string contactProvider = TextBoxContactProvider.Text;
            string idCountry = paisDropList.SelectedValue;
            string status = DropDownListStatusProvider.SelectedValue;
            int valueResult = 0;
            string msgResult = "";

            if (nameProvider != "" && contactProvider != "" && idCountry != "")
            {
                try
                {
                    SqlConnection connection = new SqlConnection(stringConnection);
                    if (connection.State == ConnectionState.Closed)
                    {
                        connection.Open();


                    }
                    SqlCommand cmd = new SqlCommand("spCrudProveedor", connection);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@nombreProveedor", SqlDbType.Int).Value = nameProvider;
                    cmd.Parameters.AddWithValue("@contacto", SqlDbType.Int).Value = contactProvider;
                    cmd.Parameters.AddWithValue("@idPais", SqlDbType.Int).Value = Convert.ToInt32(idCountry);
                    cmd.Parameters.AddWithValue("@operationFlag", 0);


                    SqlDataReader reader = cmd.ExecuteReader();


                    connection.Close();
                    reader.Close();

                    if (valueResult == 0)
                    {
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                            "Swal.fire('Perfect','" + msgResult + "','success')", true);
                        GridViewProvider.DataBind();
                        UpdatePanelProvider.Update();

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

        protected void ButtonActualizarProvider_Click(object sender, EventArgs e)
        {
            string idProvider = TextBoxIDProvider.Text;
            string nameProvider = TextBoxNombreProvider.Text;
            string contactProvider = TextBoxContactProvider.Text;
            string idCountry = paisDropList.SelectedValue;
            string status = DropDownListStatusProvider.SelectedValue;
            int valueResult = 0;
            string msgResult = "";



            if (idProvider != "")
            {
                try
                {
                    SqlConnection connection = new SqlConnection(stringConnection);
                    if (connection.State == ConnectionState.Closed)
                    {
                        connection.Open();
                    }
                    SqlCommand cmd = new SqlCommand("spCrudProveedor", connection);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@idProveedor", SqlDbType.Int).Value = Convert.ToInt32(idProvider);
                    cmd.Parameters.AddWithValue("@nombreProveedor", SqlDbType.Int).Value = nameProvider;
                    cmd.Parameters.AddWithValue("@contacto", SqlDbType.Int).Value = contactProvider;
                    cmd.Parameters.AddWithValue("@idPais", SqlDbType.Int).Value = Convert.ToInt32(idCountry);
                    cmd.Parameters.AddWithValue("@operationFlag", 1);

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
                        GridViewProvider.DataBind();
                        UpdatePanelProvider.Update();
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

        protected void ButtonBorrarProvider_Click(object sender, EventArgs e)
        {
            string idProvider = TextBoxIDProvider.Text;
            int valueResult = 0;
            string msgResult = "";

            if (idProvider != "")
            {
                try
                {
                    SqlConnection connection = new SqlConnection(stringConnection);
                    if (connection.State == ConnectionState.Closed)
                    {
                        connection.Open();


                    }
                    SqlCommand cmd = new SqlCommand("spCrudProveedor", connection);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@operationFlag", 4);
                    cmd.Parameters.AddWithValue("@idProveedor", SqlDbType.Int).Value = Convert.ToInt32(idProvider);

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
                        GridViewProvider.DataBind();
                        UpdatePanelProvider.Update();
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