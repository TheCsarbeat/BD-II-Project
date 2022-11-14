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
                int id = Convert.ToInt32(Request.QueryString["id"].ToString());
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

                shoppingLb.Text = "Shopping Cart TOTAL: $ " + getTotal().ToString(); ;

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

        public double getTotal()
        {
            double total = 0.0;
            //Calcular el total
            foreach (var i in myList)
            {
                total += i.getSubTotal();

            }
            return total;
        }
        protected void finisPurchasebtn_Click(object sender, EventArgs e)
        {
            shoppingLb.Text = "Shopping Cart TOTAL: $ " + getTotal().ToString(); ;
            Response.Redirect("payOrder.aspx");
        }

        protected void R1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int idLote = Convert.ToInt32(((Button)e.CommandSource).CommandArgument);
            double precioVenta = 0.0;
            string nameProduct = "";
            string picturePath = "";
            string description = "";

            string s = ((Button)e.CommandSource).CommandName.ToString();

            string[] subs = s.Split(',');
           
            nameProduct = subs[0];
            precioVenta = Convert.ToDouble(subs[1]);
            picturePath = subs[2];
            description = subs[3];


            //int id, string name, int cant, double precio, string picture, string description
            ItemCart item = new ItemCart(idLote, nameProduct, 1, precioVenta, picturePath, description);
            addToCart(item);
            precioVenta = getTotal();
            shoppingLb.Text = "A " + nameProduct + " was added " + " TOTAL: $ " + precioVenta.ToString(); ;
        }

        

        
    }
}