using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
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
        public ArrayList cartItems = new ArrayList();
        public static List<ItemCart> myList = new List<ItemCart>();
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

                shoppingLb.Text = "Shhoping cart $1236";

            }
            catch (Exception ex)
            {

            }
        }

        protected void btnTest_Click(object sender, EventArgs e)
        {
            Response.Write("<script>alert('Testing');</script>");
        }   

        protected void addToCart(ItemCart item)
        {
            string nombre;
            int id = 0;
            bool flag = true;
            foreach (var i in myList)
            {
                if (item.getId() == i.getId())
                {
                    i.addSameItem();    
                    flag = false;
                    break;
                }
                
            }
            if (flag)
            {
                myList.Add(item);
            }
           
        }

        public void seeCart()
        {           
           
            for (int i = 0; i < myList.Count; i++)                
                Response.Write("<h1>" + myList[i].toString() + "</h1>");

        }
        protected void finisPurchasebtn_Click(object sender, EventArgs e)
        {
            seeCart();
        }

        protected void R1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int idLote = Convert.ToInt32(((Button)e.CommandSource).CommandArgument);
            string nameProduct = ((Button)e.CommandSource).CommandName.ToString();
            shoppingLb.Text = "A "+ nameProduct+" was added ";

            //idLote, nombreProducto, cantidad
            ItemCart item = new ItemCart(idLote, nameProduct, 1);
             
            addToCart(item);
            
        }

        public class ItemCart
        {
            public int idLote;
            public string nameProduct;
            public int cant;
            public float precio;
            public float subTotal;

            public ItemCart(int id, string name, int cant)
            {
                this.idLote = id;
                this.nameProduct = name;
                this.cant = cant;
            }

            public string getNombre()
            {
                return this.nameProduct;
            }

            public int getId()
            {
                return this.idLote;
            }

            public void addSameItem()
            {
                this.cant += 1;
                
            }

            public string toString()
            {
                return this.nameProduct +" "+ this.idLote.ToString() +" "+ this.cant.ToString();
            }
        }

        
    }
}