using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Runtime.Remoting.Messaging;
using System.Xml.Linq;

namespace indioSupermercado
{
    public partial class adminDiscount : System.Web.UI.Page
    {
        string strcon = usefull.strCon;
        public string currentDiscount;
        protected void Page_Load(object sender, EventArgs e)
        {
            sqlDataSourceDiscount.ConnectionString = strcon;
            loadCurrentDiscount();
        }

        public void clearForm()
        {
            TextDiscount.Text = "";

        }

        protected void loadCurrentDiscount() {
            try
            {

                SqlConnection con = new SqlConnection(strcon);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                SqlCommand cmd = new SqlCommand("select descuentoPorcent from Descuento", con);
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    reader.Read();
                    currentDiscount = (reader[0].ToString());
                    currentDiscount = (float.Parse(currentDiscount, CultureInfo.InvariantCulture.NumberFormat) * 100).ToString();
                }
                reader.Close();
                con.Close();
            }
            catch (Exception ex)
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                        "Swal.fire('Error','" + ex.Message + "','error')", true);
            }
        }
        protected void ButtonUpdateDiscount_Click(object sender, EventArgs e)
        {
            string discount = TextDiscount.Text;
            string msgResult = "";
            int valueResult = -1;

            if (discount != "" && float.Parse(discount, CultureInfo.InvariantCulture.NumberFormat) < 1)
            {
                try
                {
                    SqlConnection con = new SqlConnection(strcon);
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    SqlCommand cmd = new SqlCommand("spChangeDiscount " + discount, con);
                    SqlDataReader reader = cmd.ExecuteReader();

                    reader.Read();
                    valueResult = Convert.ToInt32(reader[0].ToString());
                    msgResult = (reader[1].ToString());
                    reader.Close();
                    con.Close();

                    if (valueResult == 0)
                    {
                        discountGridview.DataBind();
                        UpdatePanelDiscount.Update();
                        loadCurrentDiscount();
                        clearForm();
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
                               "Swal.fire('Error','The input is invalid','error')", true);
            }
        }

        protected void ButtonApplyDiscount_Click(object sender, EventArgs e)
        {
            List<string> idInventarios = new List<string>(); ;
            try
            {
                SqlConnection con = new SqlConnection(strcon);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand("spGetProductsForDiscount", con);
                SqlDataReader reader = cmd.ExecuteReader();


                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        idInventarios.Add(reader[0].ToString());
                        
                    }
                }
                reader.Close();
                SqlCommand cmd2 = con.CreateCommand();
                cmd2.CommandType = CommandType.Text;
                foreach (var i in idInventarios) {
                    cmd2.CommandText = "spApplyDiscount " + i;
                    cmd2.ExecuteNonQuery();
                }
                con.Close();

                discountGridview.DataBind();
                UpdatePanelDiscount.Update();
                loadCurrentDiscount();
                clearForm();
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                        "Swal.fire('Perfect','The discount was applied','success')", true);

            }
            catch (Exception ex)
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                        "Swal.fire('Error','" + ex.Message + "','error')", true);
            }

        }
    }
}