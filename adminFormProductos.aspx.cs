using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Collections;
using System.IO;


namespace indioSupermercado
{
    public partial class adminFormReporte : System.Web.UI.Page
    {
        string stringConnection = usefull.strCon;
        public void clearForm()
        {
            idProductotxt.Text = "";
            nombreProductotxt.Text = "";
            DropDownListEstado.SelectedIndex = -1;
            categoriaDropDownList.SelectedIndex = -1;
            descripcionProductotxt.Text = "";

        }
        public void loadFileImg()
        {
            string strFileName;
            string strFilePath = "";
            string strFolder;
            strFolder = Server.MapPath("./productImgs/");
            // Retrieve the name of the file that is posted.
            strFileName = FileUpload1.PostedFile.FileName;
            strFileName = Path.GetFileName(strFileName);

            if (FileUpload1.PostedFile.FileName != "")
            {
                // Create the folder if it does not exist.
                if (!Directory.Exists(strFolder))
                {
                    Directory.CreateDirectory(strFolder);
                }
                // Save the uploaded file to the server.
                strFilePath = strFolder + strFileName;
                if (!File.Exists(strFilePath))
                {
                    FileUpload1.PostedFile.SaveAs(strFilePath);

                }
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

                while(reader.Read())
                {
                    nombreCategoria.Add(reader[0].ToString());
                    idCategoria.Add(reader[1].ToString());
                }

                con.Close();
                if (!IsPostBack)
                {
                    for (int i = 0; i < nombreCategoria.Count; i++)
                        categoriaDropDownList.Items.Insert(0, new ListItem(idCategoria[i].ToString(), nombreCategoria[i].ToString()));
                    categoriaDropDownList.DataBind();
                }

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script.");
            }

        }
        protected void Page_Load(object sender, EventArgs e)
        {
 
            loadCateogory();
            sqlDataSourceProductos.ConnectionString = stringConnection;
            //sqlDataSourceTaxxCategory.ConnectionString = stringConnection;
        }

        protected void botonIDP_Click(object sender, EventArgs e)
        {
            
        }


        protected void ButtonAgregarSucursal_Click(object sender, EventArgs e)
        {
            string nombreProducto = nombreProductotxt.Text;
            string descripcionProducto = descripcionProductotxt.Text;
            string categoria = categoriaDropDownList.SelectedValue.ToString();
            string strFileName;
            string strFilePath = "";
            string ruta = "productImgs/";
            string min = minTxt.Text;
            string max = maxTxt.Text;

            // Retrieve the name of the file that is posted.
            strFileName = FileUpload1.PostedFile.FileName;
            strFileName = Path.GetFileName(strFileName);
            strFilePath = ruta + strFileName;

            string msgResult = "";
            int valueResult = -1;

            if (nombreProducto != "" && descripcionProducto != "")
            {
                if (usefull.validateInt(min) && usefull.validateInt(max))
                {
                    int min1 = Convert.ToInt32(min);
                    int max2 = Convert.ToInt32(max);

                    if (min1 <= max2)
                    {

                        try
                        {
                            loadFileImg();

                            SqlConnection con = new SqlConnection(stringConnection);
                            if (con.State == ConnectionState.Closed)
                            {
                                con.Open();
                            }

                            SqlCommand cmd = new SqlCommand("EXEC spCrudProducto null, '" + nombreProducto + "', '" + descripcionProducto + "'," + " " + categoria + ", '" + strFileName + "','" + strFilePath + "'," + min + "," + max + ", 0", con);
                            SqlDataReader reader = cmd.ExecuteReader();

                            reader.Read();
                            valueResult = Convert.ToInt32(reader[0].ToString());
                            msgResult = (reader[1].ToString());

                            reader.Close();
                            con.Close();
                            if (valueResult == 0)
                            {
                                productsGridView.DataBind();
                                updatePanelProducts.Update();
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
                                   "Swal.fire('Error','The min and max are wrong','error')", true);
                    }
                }
                else
                {
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                                    "Swal.fire('Error','The are empty values','error')", true);
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
            string nombreProducto = nombreProductotxt.Text;
            string descripcionProducto = descripcionProductotxt.Text;
            string categoria = categoriaDropDownList.SelectedValue.ToString();
            string strFileName;
            string strFilePath = "";
            string ruta = "productImgs/";
            string id = idProductotxt.Text;

            string min = minTxt.Text;
            string max = maxTxt.Text;

            // Retrieve the name of the file that is posted.
            strFileName = FileUpload1.PostedFile.FileName;
            strFileName = Path.GetFileName(strFileName);
            strFilePath = ruta + strFileName;

            string msgResult = "";
            int valueResult = -1;

            if (id != "" && nombreProducto != "" && descripcionProducto != "")
            {
                if (usefull.validateInt(min) && usefull.validateInt(max))
                {

                    int min1 = Convert.ToInt32(min);
                    int max2 = Convert.ToInt32(max);

                    if (min1 <= max2)
                    {
                        
                        try
                        {
                            loadFileImg();

                            SqlConnection con = new SqlConnection(stringConnection);
                            if (con.State == ConnectionState.Closed)
                            {
                                con.Open();
                            }

                            SqlCommand cmd = new SqlCommand("EXEC spCrudProducto " + id + ", '" + nombreProducto + "', '" + descripcionProducto + "'," + " " + categoria + ", '" + strFileName + "','" + strFilePath + "'," + min + "," + max + ", 1", con);
                            SqlDataReader reader = cmd.ExecuteReader();

                            reader.Read();
                            valueResult = Convert.ToInt32(reader[0].ToString());
                            msgResult = (reader[1].ToString());

                            reader.Close();
                            con.Close();
                            if (valueResult == 0)
                            {
                                productsGridView.DataBind();
                                updatePanelProducts.Update();
                                //clearForm();
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
                                   "Swal.fire('Error','Dates are wrong','error')", true);
                    }
                }
                else
                {
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                                   "Swal.fire('Error','The are empty values','error')", true);
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

            string id = idProductotxt.Text;



            string msgResult = "";
            int valueResult = -1;

            if (id != "")
            {


                SqlConnection con = new SqlConnection(stringConnection);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand("EXEC spCrudProducto " + id + ", null, null,null,null,null, 4", con);
                SqlDataReader reader = cmd.ExecuteReader();

                reader.Read();
                valueResult = Convert.ToInt32(reader[0].ToString());
                msgResult = (reader[1].ToString());

                reader.Close();
                con.Close();
                if (valueResult == 0)
                {
                    productsGridView.DataBind();
                    updatePanelProducts.Update();
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
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                               "Swal.fire('Error','The are empty values','error')", true);
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string id = idProductotxt.Text;



            string msgResult = "";
            int valueResult = -1;

            if (id != "")
            {


                SqlConnection con = new SqlConnection(stringConnection);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand("EXEC spCrudProducto " + id + ", null, null,null,null,null, 5", con);
                SqlDataReader reader = cmd.ExecuteReader();

                reader.Read();
                valueResult = Convert.ToInt32(reader[0].ToString());
                msgResult = (reader[1].ToString());

                reader.Close();
                con.Close();
                if (valueResult == 0)
                {
                    productsGridView.DataBind();
                    updatePanelProducts.Update();
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
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                               "Swal.fire('Error','The are empty values','error')", true);
            }
        }

        protected void deleteF_Click(object sender, EventArgs e)
        {
            string id = idProductotxt.Text;



            string msgResult = "";
            int valueResult = -1;

            if (id != "")
            {


                SqlConnection con = new SqlConnection(stringConnection);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand("EXEC spCrudProducto " + id + ", null, null,null,null,null, 6", con);
                SqlDataReader reader = cmd.ExecuteReader();

                reader.Read();
                valueResult = Convert.ToInt32(reader[0].ToString());
                msgResult = (reader[1].ToString());

                reader.Close();
                con.Close();
                if (valueResult == 0)
                {
                    productsGridView.DataBind();
                    updatePanelProducts.Update();
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
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                               "Swal.fire('Error','The are empty values','error')", true);
            }
        }
    }
}