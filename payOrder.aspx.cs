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
                totalLb.Text = "$ "+productList.getTotal().ToString();
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


    }
}