using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection.Emit;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace indioSupermercado
{
    public partial class productList : System.Web.UI.Page
    {
        string strcon = ConfigurationManager.ConnectionStrings["connectionMaynor"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            

            try
            {
                int id = 6;//Convert.ToInt32(Request.QueryString["id"].ToString());
                id = 6; 
                SqlConnection con = new SqlConnection(strcon);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                SqlCommand cmd = con.CreateCommand();
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT Producto.idProducto, Producto.nombreProducto, Producto.imgPath, Lote.idLote, " +
                    "Inventario.precioVenta FROM MYSQLSERVER...Producto as Producto\r\nINNER JOIN MYSQLSERVER...Lote AS Lote ON Lote.idProducto = Producto.idProducto" +
                    " INNER JOIN Inventario ON Inventario.idLote = Lote.idLote\r\nINNER JOIN Sucursal ON Sucursal.idSucursal = Inventario.idSucursal" +
                    " where Sucursal.idSucursal = 6";
                cmd.ExecuteNonQuery();
                DataTable dt = new DataTable();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);


                if (!IsPostBack)
                {        
                    Repeater1.DataSource = dt;
                    Repeater1.DataBind();
                }

            }
            catch (Exception ex)
            {

            }
        }

        protected void btnTest_Click(object sender, EventArgs e)
        {
            Response.Write("<script>alert('Testing');</script>");
        }   


        protected void R1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            Label2.Text = "The " + ((Button)e.CommandSource).CommandArgument + " button has just been clicked; <br />";
        }
       
       
    }
}