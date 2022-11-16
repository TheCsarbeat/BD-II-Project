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
    public partial class adminFormImpuesto : System.Web.UI.Page
    {
        private string stringConnection = usefull.strCon;
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataSourceImpuesto.ConnectionString = usefull.strCon;
            loadCountry();
        }

        public void clearForm()
        {
            IDTaxTxt.Text = "";
            nameTaxtxt.Text = "";
            taxPorcentagetxt.Text = "";
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

        protected void ButtonAgregarImpuesto_Click(object sender, EventArgs e)
        {
            string idTax = IDTaxTxt.Text;
            string nameTax = nameTaxtxt.Text;
            string porcentage = taxPorcentagetxt.Text;
            string idCountry = paisDropList.SelectedValue;
            string status = DropDownListEstado.SelectedValue;
            int valueResult = 0;
            string msgResult = "";

            if (nameTax != "" && porcentage != "" && idCountry != "" && float.Parse(porcentage) < 1)
            {
                try
                {
                    SqlConnection connection = new SqlConnection(stringConnection);
                    if (connection.State == ConnectionState.Closed)
                    {
                        connection.Open();


                    }
                    SqlCommand cmd = new SqlCommand("spCrudImpuesto", connection);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@nombre", SqlDbType.Int).Value = nameTax;
                    cmd.Parameters.AddWithValue("@porcentaje", SqlDbType.Float).Value = porcentage;
                    cmd.Parameters.AddWithValue("@idPais", SqlDbType.Int).Value = Convert.ToInt32(idCountry);
                    cmd.Parameters.AddWithValue("@operationFlag", 0);


                    SqlDataReader reader = cmd.ExecuteReader();


                    connection.Close();
                    reader.Close();

                    if (valueResult == 0)
                    {
                        clearForm();
                        GridViewImpuesto.DataBind();
                        UpdatePanelImpuesto.Update();
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

        protected void ButtonActualizarImpuesto_Click(object sender, EventArgs e)
        {
            string idTax = IDTaxTxt.Text;
            string nameTax = nameTaxtxt.Text;
            string porcentage = taxPorcentagetxt.Text;
            string idCountry = paisDropList.SelectedValue;
            string status = DropDownListEstado.SelectedValue;
            int valueResult = 0;
            string msgResult = "";

            if(idTax != "" && float.Parse(porcentage) < 1)
            {
                try
                {
                    SqlConnection connection = new SqlConnection(stringConnection);
                    if (connection.State == ConnectionState.Closed)
                    {
                        connection.Open();
                    }
                    SqlCommand cmd = new SqlCommand("spCrudImpuesto", connection);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@idImpuesto", SqlDbType.Int).Value = Convert.ToInt32(idTax);
                    cmd.Parameters.AddWithValue("@nombre", SqlDbType.Int).Value = nameTax;
                    cmd.Parameters.AddWithValue("@porcentaje", SqlDbType.Float).Value = porcentage;
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
                        clearForm();
                        GridViewImpuesto.DataBind();
                        UpdatePanelImpuesto.Update();
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                            "Swal.fire('Perfect','" + msgResult + "','success')", true);
                        
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
                           "Swal.fire('Error','Datos invalidos','error')", true);
            }
        }

        protected void ButtonBorrarImpuesto_Click(object sender, EventArgs e)
        {
            string idImpuesto = IDTaxTxt.Text;
            int valueResult = 0;
            string msgResult = "";

            if (idImpuesto != "")
            {
                try
                {
                    SqlConnection connection = new SqlConnection(stringConnection);
                    if (connection.State == ConnectionState.Closed)
                    {
                        connection.Open();


                    }
                    SqlCommand cmd = new SqlCommand("spCrudImpuesto", connection);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@operationFlag", 4);
                    cmd.Parameters.AddWithValue("@idImpuesto", SqlDbType.Int).Value = Convert.ToInt32(idImpuesto);

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
                        clearForm();
                        GridViewImpuesto.DataBind();
                        UpdatePanelImpuesto.Update();
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                            "Swal.fire('Perfect','" + msgResult + "','success')", true);
                        
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