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
    public partial class adminOrderProducts : System.Web.UI.Page
    {
        string stringConnection = usefull.strCon;
        protected void Page_Load(object sender, EventArgs e)
        {
            sqlDataSourceProductos.ConnectionString = stringConnection;
    
                
                loadProduct();
                //loadProvider();
                loadBranches();
            
        }
        public void loadBranches()
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

                SqlCommand cmd = new SqlCommand("EXEC spGetSucursalDropList", con);
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
                        branchesDropList.Items.Insert(0, new ListItem(idCategoria[i].ToString(), nombreCategoria[i].ToString()));
                    branchesDropList.DataBind();
                }

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script.");
            }
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


            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script.");
            }

        }

        protected void branchesDropList_SelectedIndexChanged(object sender, EventArgs e)
        {
            loadProvider();
        }

        protected void branchesDropList_TextChanged(object sender, EventArgs e)
        {
            loadProvider();

        }

        protected void loadBestBtn_Click(object sender, EventArgs e)
        {
            try
            {
                string idProducto = productosDropList.SelectedValue.ToString();
                string idSucursal = branchesDropList.SelectedValue.ToString();

                int cantNeed = 0;
                int idProvider = 0;
                string nombreProvider = "";
                int idLote = 0;

                int value = -1;
                string msgResult = "";
                SqlConnection con = new SqlConnection(stringConnection);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                //Obtener la cantidad del producto necesitado spGetCantNeed
                SqlCommand cmd = new SqlCommand("EXEC spGetCantNeed " + idSucursal + ", " + idProducto, con);
                SqlDataReader reader = cmd.ExecuteReader();

                reader.Read();
                cantNeed = Convert.ToInt32(reader[0].ToString());
                reader.Close();

                SqlCommand cmd2 = new SqlCommand("EXEC spGetBestProvider " + idSucursal + ", "+idProducto+","+cantNeed, con);
                SqlDataReader reader2 = cmd2.ExecuteReader();

                reader2.Read();
                idProvider = Convert.ToInt32(reader2[0].ToString());
                nombreProvider = (reader2[1].ToString());
                if (idProvider != -1)
                {
                    
                    idLote = Convert.ToInt32(reader2[2].ToString());
                    reader2.Close();
                    //-- idInventario, cantidad, @idSucursal, @idLote, @precioVenta, operation    el precio de venta nulo para que se autocalcule
                    //          null,       20,     6,          1,      null,            0

                    SqlCommand cmd3 = new SqlCommand("EXEC spInsertProductToInventory null, "+cantNeed.ToString()+", " + idSucursal.ToString() + ", " + idLote.ToString()+ ",null, 0", con);
                    SqlDataReader reader3 = cmd3.ExecuteReader();
                    reader3.Read();
                    value = Convert.ToInt32(reader3[0].ToString());
                    msgResult = (reader3[1].ToString());
                    if(value == 0)
                    {
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                        "Swal.fire('Perfect','" + msgResult + "','success')", true);
                    }
                    else
                    {
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                        "Swal.fire('Error','" + msgResult + "','error')", true);
                    }
                    
                }
                else
                {
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                        "Swal.fire('Sorry','"+ nombreProvider + "','error')", true);
                    reader2.Close();
                }
                
                con.Close();


            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script.");
            }
        }
    }
}