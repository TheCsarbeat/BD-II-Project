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
        public void bindGridProducts()
        {
            try
            {
                SqlConnection con = new SqlConnection(stringConnection);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                
                SqlCommand cmd = new SqlCommand("spSelectProductsToView", con);

                cmd.ExecuteNonQuery();
                con.Close();

                DataTable dt = new DataTable();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                productosGridView.DataSource = dt;
                productosGridView.DataBind();                

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script.");
            }


            productosGridView.DataBind();
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


            productosGridView.DataBind();
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            bindGridProducts();
            loadCateogory();
            //clearForm();
        }

        protected void botonIDP_Click(object sender, EventArgs e)
        {
            
        }

        public void loadPostedImg()
        {
            
        }

        protected void ButtonAgregarSucursal_Click(object sender, EventArgs e)
        {
            string nombreProducto = nombreProductotxt.Text;
            string descripcionProducto = descripcionProductotxt.Text;
            string categoria = categoriaDropDownList.SelectedValue.ToString();

            string msgResult = "";
            int valueResult = -1;
            
            if (nombreProducto != "" && descripcionProducto != "")
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
                    if (File.Exists(strFilePath))
                    {
                        lblUploadResult.Text = strFileName + " already exists on the server!";
                    }
                    else
                    {
                        FileUpload1.PostedFile.SaveAs(strFilePath);
                        lblUploadResult.Text = strFileName + " has been successfully uploaded.";
                    }
                }
                else
                {
                    lblUploadResult.Text = "Click 'Browse' to select the file to upload.";
                }

                SqlConnection con = new SqlConnection(stringConnection);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand("spCrudProducto null, '" + nombreProducto + "', '" + descripcionProducto + "'," +
                    " " + categoria + ", '" + strFileName + "','" + strFilePath + "', 0", con);
                SqlDataReader reader = cmd.ExecuteReader();

                reader.Read();
                valueResult = Convert.ToInt32(reader[0].ToString());
                msgResult = (reader[1].ToString());

                reader.Close();
                con.Close();
                if (valueResult == 0)
                {
                    bindGridProducts();
                    loadCateogory();
                    clearForm();

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