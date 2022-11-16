using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography;

namespace indioSupermercado
{
    public partial class adminFormManager : System.Web.UI.Page
    {
        private string stringConnection = usefull.strCon;
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataSourceManager.ConnectionString = usefull.strCon;
            loadSucursal();
            loadEmpleado();
        }

        public void loadSucursal()
        {
            try
            {
                var nombreSucursal = new ArrayList();
                var idSucursal = new ArrayList();


                SqlConnection con = new SqlConnection(stringConnection);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand("spGetSucursales", con);
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    nombreSucursal.Add(reader[1].ToString());
                    idSucursal.Add(reader[0].ToString());
                }

                con.Close();
                if (!IsPostBack)
                {
                    for (int i = 0; i < nombreSucursal.Count; i++)
                        sucursalDropList.Items.Insert(0, new ListItem(nombreSucursal[i].ToString(), idSucursal[i].ToString()));
                    sucursalDropList.DataBind();
                }

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script.");
            }
        }

        public void loadEmpleado()
        {
            try
            {
                var nombreEmpleado = new ArrayList();
                var idEmpleado = new ArrayList();


                SqlConnection con = new SqlConnection(stringConnection);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand("spGetEmpleado", con);
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    nombreEmpleado.Add(reader[1].ToString());
                    idEmpleado.Add(reader[0].ToString());
                }

                con.Close();
                if (!IsPostBack)
                {
                    for (int i = 0; i < nombreEmpleado.Count; i++)
                        employeeDropList.Items.Insert(0, new ListItem(nombreEmpleado[i].ToString(), idEmpleado[i].ToString()));
                    employeeDropList.DataBind();
                }

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script.");
            }
        }

        protected void ButtonAgregarManager_Click(object sender, EventArgs e)
        {
            string idManager = TextBoxMB.Text;
            string idSucursal = sucursalDropList.SelectedValue;
            string idEmpleado = employeeDropList.SelectedValue;
            int valueResult = 0;
            string msgResult = "";

            if (idSucursal != "" && idEmpleado != "")
            {
                try
                {
                    SqlConnection connection = new SqlConnection(stringConnection);
                    if (connection.State == ConnectionState.Closed)
                    {
                        connection.Open();


                    }
                    SqlCommand cmd = new SqlCommand("crudSucursalManager", connection);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@opcion", 1);
                    cmd.Parameters.AddWithValue("@idSucursal", SqlDbType.Int).Value = Convert.ToInt32(idSucursal);
                    cmd.Parameters.AddWithValue("@idEmpleado", SqlDbType.Int).Value = Convert.ToInt32(idEmpleado);

                    SqlDataReader reader = cmd.ExecuteReader();


                    connection.Close();
                    reader.Close();

                    if (valueResult == 0)
                    {
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                            "Swal.fire('Perfect','" + msgResult + "','success')", true);
                        GridViewManager.DataBind();
                        UpdatePanelManager.Update();

                    }
                    else
                    {
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                            "Swal.fire('Error','" + msgResult + "','error')", true);
                    }


                    //Response.Write(alert);

                }
                catch (Exception ex)
                {

                    ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                           "Swal.fire('Error','" + ex.Message + "','error')", true);
                }
                /// Titulo, mensaje, tipo
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                           "Swal.fire('Error','Some files are empty','error')", true);
            }
        }

        protected void ButtonActualizarManager_Click(object sender, EventArgs e)
        {
            string idManager = TextBoxMB.Text;
            string idSucursal = sucursalDropList.SelectedValue;
            string idEmpleado = employeeDropList.SelectedValue;
            int valueResult = 0;
            string msgResult = "";

            if (idManager != "")
            {
                try
                {
                    SqlConnection connection = new SqlConnection(stringConnection);
                    if (connection.State == ConnectionState.Closed)
                    {
                        connection.Open();
                    }
                    SqlCommand cmd = new SqlCommand("crudHorario", connection);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@opcion", 1);
                    cmd.Parameters.AddWithValue("@@idSucursalManger", SqlDbType.Int).Value = Convert.ToInt32(idSucursal);
                    cmd.Parameters.AddWithValue("@idSucursal", SqlDbType.Int).Value = Convert.ToInt32(idSucursal);
                    cmd.Parameters.AddWithValue("@idEmpleado", SqlDbType.Int).Value = Convert.ToInt32(idEmpleado);

                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        valueResult = Convert.ToInt32(reader[0].ToString());
                        msgResult = reader[1].ToString();
                    }

                    connection.Close();
                    reader.Close();

                    if (valueResult == 0)
                    {
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                            "Swal.fire('Perfect','" + msgResult + "','success')", true);
                        GridViewManager.DataBind();
                        UpdatePanelManager.Update();
                    }
                    else
                    {
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                            "Swal.fire('Error','" + msgResult + "','error')", true);
                    }
                }


                catch (Exception ex)
                {
                    Response.Write("<script>alert('" + ex.Message + "');</script>");

                }

            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                           "Swal.fire('Error','ID impuesto can not be null','error')", true);
            }
        }

        protected void ButtonBorrarManager_Click(object sender, EventArgs e)
        {

        }
    }
}