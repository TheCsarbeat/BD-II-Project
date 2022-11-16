using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using System.Collections;
using System.Runtime.Remoting.Messaging;

namespace indioSupermercado
{
    public partial class payOrder : System.Web.UI.Page
    {
        string stringConnection = usefull.strCon;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Repeater1.DataSource = productList.myList;
                Repeater1.DataBind();
                loadPaymentMethod();
                subTotalLb.Text = "$" + productList.getTotal().ToString();

                totalLb.Text = "$"+productList.getTotal().ToString();
                //createScripToProducts();
            }
        }

        public void loadPaymentMethod()
        {
            ArrayList idtax = new ArrayList();
            ArrayList taxName = new ArrayList();

            try
            {

                SqlConnection con = new SqlConnection(stringConnection);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand("EXEC spGetPaymentMethod", con);
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    idtax.Add(reader[0].ToString());
                    taxName.Add(reader[1].ToString());
                }

                con.Close();
                if (!IsPostBack)
                {
                    for (int i = 0; i < taxName.Count; i++)
                        paymentMethodDrop.Items.Insert(0, new ListItem(taxName[i].ToString(), idtax[i].ToString()));
                    paymentMethodDrop.DataBind();
                }

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script.");
            }
        }

        public string createScripToProducts()
        {
            string script = "INSER INTO DetalleFactura (idProducto, cantidad, idFactura)VALUES ";
            foreach (var i in productList.myList)
            {
                script = script + "("+ i.getIdProducto().ToString()+","+i.cantProduct.ToString()+","+"@idFactura),";

            }
            script = script.Remove(script.Length - 1, 1);
            return script;
            
        }

        protected void payButton_Click(object sender, EventArgs e)
        {
            string idCostumer = "2021052792";//Session["idCliente"].ToString();
            string idPaymentMethod = paymentMethodDrop.SelectedValue.ToString();

            string msgResult = "";
            int idFactura = -1;
            SqlConnection con = new SqlConnection(stringConnection);
            if (con.State == ConnectionState.Closed)
            {
                con.Open();
            }
            SqlCommand cmd = con.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "EXEC spCostumerPurcharse null, " + productList.myList[0].getIdSucursal().ToString()+","+ productList.getTotal().ToString()+",'"+
                idCostumer+"',"+ idPaymentMethod+", 0";
            
            SqlDataReader reader = cmd.ExecuteReader();
            reader.Read();
            idFactura = Convert.ToInt32(reader[0].ToString());
            reader.Close();
            bool flag = true;
            foreach (var i in productList.myList)
            {
                try
                {
                    SqlCommand cmdPro = con.CreateCommand();
                    cmdPro.CommandType = CommandType.Text;
                    cmdPro.CommandText = "EXEC spProductByPucharse " + i.getIdProducto().ToString() + "," + idFactura.ToString() + "," + i.cantProduct.ToString() + ","+i.idInventario.ToString()+",0";
                    cmdPro.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('" + ex.Message + "');</script.");
                    flag = false;
                }
            }

            if (flag)
            {                
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                    "Swal.fire('Perfect','Your purchase was register successfuly','success')", true);
                productList.myList= new List<ItemCart>();
                Repeater1.DataBind();
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                    "Swal.fire('Erorr','An error have ocurred','error')", true);
            }
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("productList.aspx?id="+productList.idSucursal.ToString());
        }
    }
}