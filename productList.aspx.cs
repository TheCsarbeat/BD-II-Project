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
        string strcon = usefull.strCon;

        public static List<ItemCart> myList = new List<ItemCart>();
        protected void Page_Load(object sender, EventArgs e)
        {
            

            try
            {
                int id = 6;//Convert.ToInt32(Request.QueryString["id"].ToString());
                SqlConnection con = new SqlConnection(strcon);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                SqlCommand cmd = con.CreateCommand();
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "spGetProductsByBranch " + id;
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
                Response.Write("<script>alert('" + ex.Message + "');</script.");
            }
        }

        protected void btnTest_Click(object sender, EventArgs e)
        {
            Response.Write("<script>alert('Testing');</script>");
        }   

        protected double addToCart(ItemCart item)
        {
            double total = 0.0;
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
            //Calcular el total
            foreach (var i in myList)
            {
                total +=i.getSubTotal();  

            }
            return total;

        }

        protected void finisPurchasebtn_Click(object sender, EventArgs e)
        {
            
        }

        protected void R1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int idLote = Convert.ToInt32(((Button)e.CommandSource).CommandArgument);
            double precioVenta = 0.0;
            string nameProduct = ((Button)e.CommandSource).CommandName.ToString();
            string[] subs = nameProduct.Split(',');
            precioVenta = Convert.ToDouble(subs[1]);
            nameProduct = subs[0];
            

            //idLote, nombreProducto, cantidad
            ItemCart item = new ItemCart(idLote, nameProduct, 1, precioVenta);
            precioVenta = addToCart(item);
            shoppingLb.Text = "A " + nameProduct + " was added " + " TOTAL: $ " + precioVenta.ToString(); ;
        }

        public class ItemCart
        {
            public int idLote;
            public string nameProduct;
            public int cant;
            public double precio;
            public double subTotal;

            public ItemCart(int id, string name, int cant, double precio)
            {
                this.idLote = id;
                this.nameProduct = name;
                this.cant = cant;
                this.precio = precio;
                this.subTotal = precio * this.cant;
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
                this.subTotal = this.precio * this.cant;
                
            }

            public string toString()
            {
                return this.nameProduct +" "+ this.idLote.ToString() +" "+ this.cant.ToString()+ " "+this.subTotal;
            }

            public double getSubTotal()
            {
                return this.subTotal;
            }
        }

        
    }
}