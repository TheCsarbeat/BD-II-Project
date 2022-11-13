using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Runtime.Remoting.Messaging;

namespace indioSupermercado
{
    public partial class adminFormReporte : System.Web.UI.Page
    {
        private string stringConnection = ConfigurationManager.ConnectionStrings["connectionFernanda"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void botonIDP_Click(object sender, EventArgs e)
        {

        }

        protected void ButtonAgregarProducto_Click(object sender, EventArgs e)
        {
            string idProducto = idProductotxt.Text;
            string nombreProducto = nombreProductotxt.Text;
            string descripcion = descripcionProductotxt.Text;
            string idCategoria = categoriaProductotxt.Text;
            string img = "ruta" + fotoProducto.FileName;
            int valueResult = -1;
            string msgResult = "";
            
            if (nombreProducto != "" && descripcion != "" && idCategoria != "" && img != "")
            {
                try
                {
                    SqlConnection connectionFernanda = new SqlConnection(stringConnection);
                    if (connectionFernanda.State == ConnectionState.Closed)
                    {
                        connectionFernanda.Open();


                    }
                    SqlCommand cmd = new SqlCommand("spCrudProducto", connectionFernanda);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@operationFlag", 0);
                    cmd.Parameters.AddWithValue("@nombreProducto", SqlDbType.Int).Value = nombreProducto;
                    cmd.Parameters.AddWithValue("@descripcionProducto", SqlDbType.Int).Value = descripcion;
                    cmd.Parameters.AddWithValue("@idCategoria", SqlDbType.Int).Value = Convert.ToInt32(idCategoria);
                    cmd.Parameters.AddWithValue("@imgPath", SqlDbType.VarChar).Value = img;

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        valueResult = Convert.ToInt32(reader[0].ToString());
                        msgResult = reader[1].ToString();
                    }

                    connectionFernanda.Close();
                    reader.Close();

                    if (valueResult == 0)
                    {
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                            "Swal.fire('Perfect','" + msgResult + "','s')", true);
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
    }
}