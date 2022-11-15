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
    public partial class adminFormTaxByCategory : System.Web.UI.Page
    {
        string stringConnection = usefull.strCon;
        ArrayList taxName = new ArrayList();
        ArrayList idtax = new ArrayList();

        protected void Page_Load(object sender, EventArgs e)
        {
            sqlDataSourceTaxxCategory.ConnectionString = stringConnection;
            loadCateogory();
            //loadCountry();
            loadTaxes();
        }


       
        public void loadTaxes()
        {
            try
            {               

                SqlConnection con = new SqlConnection(stringConnection);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand("EXEC spCrudImpuesto null, null, null, null, 3", con);
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    idtax.Add(reader[0].ToString());
                    taxName.Add(reader[1].ToString()+"("+ reader[6].ToString()+")");
                }

                con.Close();
                if (!IsPostBack)
                {
                    for (int i = 0; i < taxName.Count; i++)
                        taxDropList.Items.Insert(0, new ListItem(taxName[i].ToString(), idtax[i].ToString()));
                    taxDropList.DataBind();
                }

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script.");
            }
        }

        public void loadCateogory()
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

                SqlCommand cmd = new SqlCommand("spCrudCategoriaProducto null, null, null,3", con);
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
                        producCategoryDropList.Items.Insert(0, new ListItem(idCategoria[i].ToString(), nombreCategoria[i].ToString()));
                    producCategoryDropList.DataBind();
                }

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script.");
            }

        }

        protected void taxDropList_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void insert_Click(object sender, EventArgs e)
        {
            string idTax = taxDropList.SelectedValue.ToString();
            string categoria = producCategoryDropList.SelectedValue.ToString();

            // Retrieve the name of the file that is posted.
            string msgResult = "";
            int valueResult = -1;

            if (idTax != "" && categoria != "")
            {

                SqlConnection con = new SqlConnection(stringConnection);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand("EXEC spCrudCategoriaImpuesto null, " + categoria + ", " + idTax + ", 0", con);
                SqlDataReader reader = cmd.ExecuteReader();

                reader.Read();
                valueResult = Convert.ToInt32(reader[0].ToString());
                msgResult = (reader[1].ToString());

                reader.Close();
                con.Close();
                if (valueResult == 0)
                {
                    taxGridView.DataBind();
                    updatePanel1.Update();
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
                               "Swal.fire('Error','The are empty values','error')", true);
            }

        }

        protected void update_Click(object sender, EventArgs e)
        {
            string idTax = taxDropList.SelectedValue.ToString();
            string categoria = producCategoryDropList.SelectedValue.ToString();
            string idct = idtxt.Text;

            // Retrieve the name of the file that is posted.
            string msgResult = "";
            int valueResult = -1;

            if (idTax != "" && categoria != "")
            {

                SqlConnection con = new SqlConnection(stringConnection);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand("EXEC spCrudCategoriaImpuesto "+ idct + ", " + categoria + ", " + idTax + ", 1", con);
                SqlDataReader reader = cmd.ExecuteReader();

                reader.Read();
                valueResult = Convert.ToInt32(reader[0].ToString());
                msgResult = (reader[1].ToString());

                reader.Close();
                con.Close();
                if (valueResult == 0)
                {
                    taxGridView.DataBind();
                    updatePanel1.Update();
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                        "Swal.fire('Perfect','" + msgResult + "','success')", true);
                    //clearForm();
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
                               "Swal.fire('Error','The are empty values','error')", true);
            }
        }

        protected void delete_Click(object sender, EventArgs e)
        {
            
            string idct = idtxt.Text;

            // Retrieve the name of the file that is posted.
            string msgResult = "";
            int valueResult = -1;

            if (idct != "")
            {

                SqlConnection con = new SqlConnection(stringConnection);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand("EXEC spCrudCategoriaImpuesto " + idct + ", null, null, 4", con);
                SqlDataReader reader = cmd.ExecuteReader();

                reader.Read();
                valueResult = Convert.ToInt32(reader[0].ToString());
                msgResult = (reader[1].ToString());

                reader.Close();
                con.Close();
                if (valueResult == 4)
                {
                    taxGridView.DataBind();
                    updatePanel1.Update();
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                        "Swal.fire('Perfect','" + msgResult + "','success')", true);
                    //clearForm();
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
                               "Swal.fire('Error','The are empty values','error')", true);
            }
        }
    }
}