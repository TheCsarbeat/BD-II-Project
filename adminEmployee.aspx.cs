using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.IO;
using static System.Net.Mime.MediaTypeNames;
using System.Net.NetworkInformation;
using System.Collections;

namespace indioSupermercado
{
    public partial class adminEmployee : System.Web.UI.Page
    {
        private string stringConnection = usefull.strCon;
        private string sqlQuerryTry = "insert into Bono(idEmpleado,fecha,cantidadBono,idTipoBono,Performance) Values(@idEmp,GETDATE(),60,2,'Realizó 1000 ventas')";
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataSource1.ConnectionString = stringConnection;
            loadBranches();
        }
        public void loadBranches()
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

                SqlCommand cmd = new SqlCommand("EXEC spGetSucursalDropList", con);
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
                        branchesDropList.Items.Insert(0, new ListItem(idCategoria[i].ToString(), nombreCategoria[i].ToString()));
                    branchesDropList.DataBind();
                }

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script.");
            }
        }

        public void loadFileImg()
        {
            string strFileName;
            string strFilePath = "";
            string strFolder;
            strFolder = Server.MapPath("./profilePictures/");
            // Retrieve the name of the file that is posted.
            strFileName = FileEmpleado.PostedFile.FileName;
            strFileName = Path.GetFileName(strFileName);

            if (FileEmpleado.PostedFile.FileName != "")
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
                    FileEmpleado.PostedFile.SaveAs(strFilePath);
                   
                }
            }

            
        }

        protected void ButtonAgregarSucursal_Click(object sender, EventArgs e)
        {

            string name = TextBoxNombreEmpleado.Text;
            string lastName = TextBoxApellidoEmpleado.Text;
            string inputDate = TextBoxFecha.Text;
            string position = TextBoxPuesto.Text;
            string office = branchesDropList.SelectedValue;
            string pic = "profilePictures/" + FileEmpleado.FileName;

            int valueResult = -1;
            string msgResult = "";

            int valuePS = -1;
            string msgPS = "";


            if (!string.IsNullOrEmpty(TextBoxPuesto.Text) || (!string.IsNullOrEmpty(branchesDropList.SelectedValue)) 
                ||!string.IsNullOrEmpty(TextBoxNombreEmpleado.Text) || (!string.IsNullOrEmpty(TextBoxApellidoEmpleado.Text)) || (!string.IsNullOrEmpty(TextBoxFecha.Text))
                                    || (!string.IsNullOrEmpty(FileEmpleado.FileName)))
            {
                try
                {
                    SqlConnection conObj = new SqlConnection(stringConnection);
                    if (conObj.State == ConnectionState.Closed)
                    {
                        conObj.Open();
                    }

                    SqlCommand cmd3 = new SqlCommand("spValidPuestoSucursal", conObj);
                    cmd3.CommandType = CommandType.StoredProcedure;

                    cmd3.Parameters.Add("@idSucursal", SqlDbType.Int).Value = office;
                    cmd3.Parameters.Add("@idPuesto", SqlDbType.Int).Value = position;

                    SqlDataReader reader3 = cmd3.ExecuteReader();

                    while (reader3.Read())
                    {
                        valuePS = Convert.ToInt32(reader3[0].ToString());
                        msgPS = reader3[1].ToString();
                    }


                    reader3.Close();

                    if(valuePS == 0)
                    {
                        SqlCommand cmd = new SqlCommand("spInsertarEmpleado", conObj);
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.Add("@nombreEmpleado", SqlDbType.VarChar).Value = name;
                        cmd.Parameters.Add("@apellido", SqlDbType.VarChar).Value = lastName;
                        cmd.Parameters.Add("@fecha", SqlDbType.Date).Value = inputDate;
                        cmd.Parameters.Add("@foto", SqlDbType.VarChar).Value = pic;
                        cmd.Parameters.Add("@idPuesto", SqlDbType.Int).Value = position;
                        cmd.Parameters.Add("@idSucursal", SqlDbType.Int).Value = office;

                        SqlDataReader reader = cmd.ExecuteReader();

                        while (reader.Read())
                        {
                            valueResult = Convert.ToInt32(reader[0].ToString());
                            msgResult = reader[1].ToString();
                        }

                        reader.Close();

                        if(valueResult == 0)
                        {
                            loadFileImg();
                            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                                        "Swal.fire('Perfect','" + msgResult + "','success')", true);

                            GridViewEmpleado.DataBind();
                            UpdatePanelEmployee.Update();

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
                                    "Swal.fire('Error','" + msgPS + "','error')", true);
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('" + ex.Message + "');</script.");

                }
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                                    "Swal.fire('Error','Missing Credentials','error')", true);
            }

        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            string idInput = TextBoxIDEmpleado.Text;
            string name = TextBoxNombreEmpleado.Text;
            string lastName = TextBoxApellidoEmpleado.Text;
            string inputDate = TextBoxFecha.Text;
            string position = TextBoxPuesto.Text;
            string office = branchesDropList.SelectedValue;
            string pic = "profilePictures/" + FileEmpleado.FileName;

            int valueResult = -1;
            string msgResult = "";

            int valueUpdate = -1;
            string msgUpdate = "";

            int valuePS = -1;
            string msgPS= "";


            if (!string.IsNullOrWhiteSpace(TextBoxIDEmpleado.Text))
            {   

                try
                {   

                    if(!string.IsNullOrEmpty(TextBoxPuesto.Text) || (!string.IsNullOrEmpty(branchesDropList.SelectedValue)))
                    {
                        SqlConnection conObj = new SqlConnection(stringConnection);
                        if (conObj.State == ConnectionState.Closed)
                        {
                            conObj.Open();
                        }

                        SqlCommand cmd3 = new SqlCommand("spValidPuestoSucursal", conObj);
                        cmd3.CommandType = CommandType.StoredProcedure;

                        cmd3.Parameters.Add("@idSucursal", SqlDbType.Int).Value = office;
                        cmd3.Parameters.Add("@idPuesto", SqlDbType.Int).Value = position;

                        SqlDataReader reader3 = cmd3.ExecuteReader();

                        while (reader3.Read())
                        {
                            valuePS = Convert.ToInt32(reader3[0].ToString());
                            msgPS = reader3[1].ToString();
                        }


                        reader3.Close();


                        if (valuePS == 0)
                        {

                            SqlCommand cmd = new SqlCommand("spValidarEmpleado", conObj);
                            cmd.CommandType = CommandType.StoredProcedure;

                            cmd.Parameters.Add("@idEmpleado", SqlDbType.Int).Value = idInput;

                            SqlDataReader reader = cmd.ExecuteReader();

                            while (reader.Read())
                            {
                                valueResult = Convert.ToInt32(reader[0].ToString());
                                msgResult = reader[1].ToString();
                            }


                            reader.Close();

                            if (valueResult == 0)
                            {
                                if (!string.IsNullOrEmpty(TextBoxNombreEmpleado.Text) || (!string.IsNullOrEmpty(TextBoxApellidoEmpleado.Text)) || (!string.IsNullOrEmpty(TextBoxFecha.Text))
                                    || (!string.IsNullOrEmpty(FileEmpleado.FileName)))
                                {


                                    ////Codigo para ejecutar el update empleado
                                    ///IMPORTANTE SE AGREGO UN NUEVO PROCEDURE

                                    SqlCommand cmd2 = new SqlCommand("spActualizarEmpleado", conObj);
                                    cmd2.CommandType = CommandType.StoredProcedure;

                                    cmd2.Parameters.Add("@idEmpleado", SqlDbType.Int).Value = idInput;
                                    cmd2.Parameters.Add("@nombreEmpleado", SqlDbType.VarChar).Value = name;
                                    cmd2.Parameters.Add("@apellido", SqlDbType.VarChar).Value = lastName;
                                    cmd2.Parameters.Add("@fecha", SqlDbType.Date).Value = inputDate;
                                    cmd2.Parameters.Add("@foto", SqlDbType.VarChar).Value = pic;
                                    cmd2.Parameters.Add("@idPuesto", SqlDbType.Int).Value = position;
                                    cmd2.Parameters.Add("@idSucursal", SqlDbType.Int).Value = office;

                                    SqlDataReader reader2 = cmd2.ExecuteReader();

                                    while (reader2.Read())
                                    {
                                        valueUpdate = Convert.ToInt32(reader2[0].ToString());
                                        msgUpdate = reader2[1].ToString();
                                    }

                                    reader2.Close();

                                    if (valueUpdate == 0)
                                    {
                                        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                                        "Swal.fire('Perfect','" + msgUpdate + "','success')", true);

                                        GridViewEmpleado.DataBind();
                                        UpdatePanelEmployee.Update();
                                    }
                                    else
                                    {
                                        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                                        "Swal.fire('Error','" + msgUpdate + "','error')", true);
                                    }


                                }
                                else
                                {
                                    ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                                    "Swal.fire('Error','Missing Credentials','error')", true);
                                }


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
                                    "Swal.fire('Error','" + msgPS + "','error')", true);
                        }
                    }
                    else
                    {
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                                    "Swal.fire('Error','Missing Credentials','error')", true);
                    }

                   
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('" + ex.Message + "');</script.");

                }
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                            "Swal.fire('Error','Missing ID','error')", true);
            }
            
        }

        protected void ButtonBorrarSucursal_Click(object sender, EventArgs e)
        {
            string idInput = TextBoxIDEmpleado.Text;

            int valueResult = -1;
            string msgResult = "";

            int valueDelete = -1;
            string msgDelete = "";

            if (!string.IsNullOrWhiteSpace(TextBoxIDEmpleado.Text))
            {
                try
                {
                    SqlConnection conObj = new SqlConnection(stringConnection);
                    if (conObj.State == ConnectionState.Closed)
                    {
                        conObj.Open();
                    }

                    SqlCommand cmd = new SqlCommand("spValidarEmpleado", conObj);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@idEmpleado", SqlDbType.Int).Value = idInput;

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        valueResult = Convert.ToInt32(reader[0].ToString());
                        msgResult = reader[1].ToString();
                    }

                    reader.Close();

                    if (valueResult == 0)
                    {
                        SqlCommand cmd2 = new SqlCommand("spEliminarEmpleado", conObj);
                        cmd2.CommandType = CommandType.StoredProcedure;

                        cmd2.Parameters.Add("@idEmpleado", SqlDbType.Int).Value = idInput;

                        SqlDataReader reader2 = cmd2.ExecuteReader();

                        while (reader2.Read())
                        {
                            valueDelete = Convert.ToInt32(reader2[0].ToString());
                            msgDelete = reader2[1].ToString();
                        }

                        reader2.Close();

                        if (valueDelete == 0)
                        {
                            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                                        "Swal.fire('Perfect','" + msgDelete + "','success')", true);

                            GridViewEmpleado.DataBind();
                            UpdatePanelEmployee.Update();

                        }
                        else
                        {
                            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                                    "Swal.fire('Error','" + msgDelete + "','error')", true);
                        }

                    }
                    else
                    {
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                                    "Swal.fire('Error','" + msgResult + "','error')", true);
                    }

                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('" + ex.Message + "');</script.");

                }
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                            "Swal.fire('Error','Missing ID','error')", true);
            }
        }

        protected void ButtonBono_Click(object sender, EventArgs e)
        {

            string idInput = TextBoxIDEmpleado.Text;
            string performanceInput = TextBoxPerformance.Text;
            string montoInput = TextBoxMontoBono.Text;
            string fechaInput = TextBoxFecha.Text;

            int valueResult = -1;
            string msgResult = "";

            int valueBono = -1;
            string msgBono = "";

            if (!string.IsNullOrWhiteSpace(TextBoxIDEmpleado.Text))
            {
                try
                {
                    SqlConnection conObj = new SqlConnection(stringConnection);
                    if (conObj.State == ConnectionState.Closed)
                    {
                        conObj.Open();
                    }

                    SqlCommand cmd = new SqlCommand("spValidarEmpleado", conObj);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@idEmpleado", SqlDbType.Int).Value = idInput;

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        valueResult = Convert.ToInt32(reader[0].ToString());
                        msgResult = reader[1].ToString();
                    }

                    reader.Close();

                    if (valueResult == 0)
                    {
                        if (!string.IsNullOrWhiteSpace(TextBoxPerformance.Text) || (!string.IsNullOrWhiteSpace(TextBoxMontoBono.Text)) || (!string.IsNullOrWhiteSpace(TextBoxFecha.Text)))
                        {

                            SqlCommand cmdVerventas = new SqlCommand("viewBono", conObj);
                            cmdVerventas.CommandType = CommandType.StoredProcedure;


                            SqlCommand cmdBonoAutomatico = new SqlCommand("spBonoAutomatico", conObj);

                            cmdBonoAutomatico.CommandType = CommandType.StoredProcedure;

                            SqlDataReader readerventas = cmdVerventas.ExecuteReader();

                            if (readerventas.HasRows)
                            {
                                while (readerventas.Read())
                                {

                                    if (Convert.ToInt32(readerventas[1].ToString()) >= 1)
                                    {

                                        //cmdBonoAutomatico.Parameters.Add("@idEmp", SqlDbType.Int).Value = readerventas.GetValue(0);

                                        //cmdBonoAutomatico.ExecuteNonQuery();

                                    }
                                }   
                            }


                            readerventas.Close();



                            SqlCommand cmdBono = new SqlCommand("spBonoPerformance", conObj);
                            cmdBono.CommandType = CommandType.StoredProcedure;

                            cmdBono.Parameters.Add("@idEmpleado", SqlDbType.Int).Value = idInput;
                            cmdBono.Parameters.Add("@fecha", SqlDbType.Date).Value = fechaInput;
                            cmdBono.Parameters.Add("@cantidad", SqlDbType.Money).Value = montoInput;
                            cmdBono.Parameters.Add("@perform", SqlDbType.VarChar).Value = performanceInput;

                            SqlDataReader readerBono = cmdBono.ExecuteReader();

                            while (readerBono.Read())
                            {
                                valueBono = Convert.ToInt32(readerBono[0].ToString());
                                msgBono = readerBono[1].ToString();
                            }

                            readerBono.Close();

                            if (valueBono == 0)
                            {
                                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                                        "Swal.fire('Perfect','" + msgBono + "','success')", true);
                            }
                            else
                            {
                                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                                    "Swal.fire('Error','" + msgBono + "','error')", true);
                            }
                        }
                        else
                        {
                            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                                    "Swal.fire('Error','Missing Credentials','error')", true);
                        }
                    }
                    else
                    {
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                                    "Swal.fire('Error','" + msgResult + "','error')", true);
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('" + ex.Message + "');</script.");
                }
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                            "Swal.fire('Error','Missing ID','error')", true);
            }
        }
    }
}