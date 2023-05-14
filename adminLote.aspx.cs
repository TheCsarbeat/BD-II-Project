using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace indioSupermercado
{
    public partial class adminLote : System.Web.UI.Page
    {
        string stringConnection = usefull.strCon;
        protected void Page_Load(object sender, EventArgs e)
        {
            sqlDataSourceProductos.ConnectionString = stringConnection;
            loadProvider();
            loadProduct();


        }

        public void loadProduct()
        {
            try
            {
                var nombreCategoria = new ArrayList();
                var idCategoria = new ArrayList();


                SqlConnection con = new SqlConnection(stringConnection);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand("EXEC spCrudProducto null, null, null, null, null, null, null, null,3", con);
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    nombreCategoria.Add(reader[0].ToString());
                    idCategoria.Add(reader[1].ToString());
                }

                con.Close();
                if (!IsPostBack)
                {
                    for (int i = 0; i < nombreCategoria.Count; i++)
                        productosDropList.Items.Insert(0, new ListItem(idCategoria[i].ToString(), nombreCategoria[i].ToString()));
                    productosDropList.DataBind();
                }

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script.");
            }

        }
        public void loadProvider()
        {
            try
            {
                var nombreCategoria = new ArrayList();
                var idCategoria = new ArrayList();


                SqlConnection con = new SqlConnection(stringConnection);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand("EXEC spCrudProveedor null, null, null, null, 3", con);
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    nombreCategoria.Add(reader[0].ToString());
                    idCategoria.Add(reader[1].ToString());
                }

                con.Close();
                if (!IsPostBack)
                {
                    for (int i = 0; i < nombreCategoria.Count; i++)
                        providersDropDownList.Items.Insert(0, new ListItem(idCategoria[i].ToString(), nombreCategoria[i].ToString()));
                    providersDropDownList.DataBind();
                }

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script.");
            }

        }

        protected void insert_Click(object sender, EventArgs e)
        {
            string datePro = dateProText.Text;
            string dateExp = dateExpText.Text;
            string idProduct = productosDropList.SelectedValue.ToString();
            string idProvider = providersDropDownList.SelectedValue.ToString();
            string amount = cantTxt.Text;
            string cost = costText.Text;
            string profitPercent = profitPercentTxt.Text;

            string msgResult = "";
            int valueResult = -1;



            if (datePro != "" && dateExp != "" && idProduct != "" && idProvider != "" && amount != "" && cost != "" && profitPercent != "" )
            {
              
                DateTime Date1 = DateTime.Parse(datePro);
                DateTime Date2 = DateTime.Parse(dateExp);

                if (Date1<= Date2)
                {
                    if(usefull.validateFloat(cost) && usefull.validateFloat(profitPercent))
                    {
                        try
                        {
                            SqlConnection con = new SqlConnection(stringConnection);
                            if (con.State == ConnectionState.Closed)
                            {
                                con.Open();
                            }

                            // --fechaProduccion, fechaExpiracion, idProducto, idProveedor, cantidadExistencias,costoUnidad,porcentajeVenta, operation
                            SqlCommand cmd = new SqlCommand("EXEC spCrudLote null, '" + datePro + "','" + dateExp + "', " + idProduct + "," + idProvider + ", " + amount + "," +
                                cost + ", " + profitPercent + ",0", con);
                            SqlDataReader reader = cmd.ExecuteReader();

                            reader.Read();
                            valueResult = Convert.ToInt32(reader[0].ToString());
                            msgResult = (reader[1].ToString());

                            reader.Close();
                            con.Close();
                            if (valueResult == 0)
                            {
                                productsGridView.DataBind();
                                updatePanelProducts.Update();
                                //clearForm();
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
                            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                                    "Swal.fire('Error','" + ex.Message + "','error')", true);       

                        }

                    }
                    else
                    {
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                               "Swal.fire('Error','The cost and profit are wrong','error')", true);
                    }
                }
                else
                {
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                               "Swal.fire('Error','Dates are wrong','error')", true);
                }
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                               "Swal.fire('Error','The are empty values','error')", true);
            }
        }

        protected void update_Click(object sender, EventArgs e)
        {
            string idLote = idLotetxt.Text;
            string datePro = dateProText.Text;
            string dateExp = dateExpText.Text;
            string idProduct = productosDropList.SelectedValue.ToString();
            string idProvider = providersDropDownList.SelectedValue.ToString();
            string amount = cantTxt.Text;
            string cost = costText.Text;
            string profitPercent = profitPercentTxt.Text;

            string msgResult = "";
            int valueResult = -1;



            if (idLote != ""&& datePro != "" && dateExp != "" && idProduct != "" && idProvider != "" && amount != "" && cost != "" && profitPercent != "")
            {

                DateTime Date1 = DateTime.Parse(datePro);
                DateTime Date2 = DateTime.Parse(dateExp);

                if (Date1 <= Date2)
                {
                    if (usefull.validateFloat(cost) && usefull.validateFloat(profitPercent) && usefull.validateInt(idLote))
                    {
                        try
                        {
                            SqlConnection con = new SqlConnection(stringConnection);
                            if (con.State == ConnectionState.Closed)
                            {
                                con.Open();
                            }

                            // --fechaProduccion, fechaExpiracion, idProducto, idProveedor, cantidadExistencias,costoUnidad,porcentajeVenta, operation
                            SqlCommand cmd = new SqlCommand("EXEC spCrudLote "+idLote+", '" + datePro + "','" + dateExp + "', " + idProduct + "," + idProvider + ", " + amount + "," +
                                cost + ", " + profitPercent + ",1", con);
                            SqlDataReader reader = cmd.ExecuteReader();

                            reader.Read();
                            valueResult = Convert.ToInt32(reader[0].ToString());
                            msgResult = (reader[1].ToString());

                            reader.Close();
                            con.Close();
                            if (valueResult == 0)
                            {
                                productsGridView.DataBind();
                                updatePanelProducts.Update();
                                //clearForm();
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
                            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                                    "Swal.fire('Error','" + ex.Message + "','error')", true);

                        }

                    }
                    else
                    {
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                               "Swal.fire('Error','The cost, profit or id Lote are wrong','error')", true);
                    }
                }
                else
                {
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                               "Swal.fire('Error','Dates are wrong','error')", true);
                }
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                               "Swal.fire('Error','The are empty values','error')", true);
            }
        }

        protected void deleteF_Click(object sender, EventArgs e)
        {
            string idLote = idLotetxt.Text;
            

            string msgResult = "";
            int valueResult = -1;



            if (idLote != "")
            {



                        try
                        {
                            SqlConnection con = new SqlConnection(stringConnection);
                            if (con.State == ConnectionState.Closed)
                            {
                                con.Open();
                            }

                            // --fechaProduccion, fechaExpiracion, idProducto, idProveedor, cantidadExistencias,costoUnidad,porcentajeVenta, operation
                            SqlCommand cmd = new SqlCommand("EXEC spCrudLote " + idLote + ", null,null,null,null, null,null, null,4", con);
                            SqlDataReader reader = cmd.ExecuteReader();

                            reader.Read();
                            valueResult = Convert.ToInt32(reader[0].ToString());
                            msgResult = (reader[1].ToString());

                            reader.Close();
                            con.Close();
                            if (valueResult == 0)
                            {
                                productsGridView.DataBind();
                                updatePanelProducts.Update();
                                //clearForm();
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
                            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                                    "Swal.fire('Error','" + ex.Message + "','error')", true);

                        }

                    
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                               "Swal.fire('Error','The are empty values','error')", true);
            }
        }
    }
}