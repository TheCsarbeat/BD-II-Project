using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace indioSupermercado
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            try
            {
                if (Session["role"] == null || Session["role"].Equals(""))
                {

                    userLoginLink.Visible = true; // user login link button
                    userSignupLink.Visible = true; // sign up link button

                    loginOut.Visible = false; // logout link button
                    helloUser.Visible = false; // hello user link button


                    adminloginLink.Visible = true; // admin login link button

                    inventarioLinkButton.Visible = false; // author management link button
                    reportesLinkButton.Visible = false; // publisher management link button
                    empleadosLinkButton.Visible = false;  // admin employees
                    clientesAdmin.Visible = false; //admin clients


                }
                else if (Session["role"].Equals("user"))
                {
                    //Response.Write("<script>alert('estoy en usuario');</script.");
                    userLoginLink.Visible = false; // user login link button
                    userSignupLink.Visible = false; // sign up link button

                    loginOut.Visible = true; // logout link button
                    helloUser.Visible = true; // hello user link button
                    helloUser.Text = "Hello " + Session["username"].ToString();


                    adminloginLink.Visible = true; // admin login link button
                    inventarioLinkButton.Visible = false; // author management link button
                    reportesLinkButton.Visible = false; // publisher management link button
                    empleadosLinkButton.Visible = false;  // admin employees
                    clientesAdmin.Visible = false;//admin clients

                }
                else if (Session["role"].Equals("ActiveAdmin"))
                {
                    //Response.Write("<script>alert('estoy en admin');</script.");
                    userLoginLink.Visible = false; // user login link button
                    userSignupLink.Visible = false; // sign up link button

                    loginOut.Visible = true; // logout link button
                    helloUser.Visible = true; // hello user link button
                    helloUser.Text = "Hello Admin";


                    adminloginLink.Visible = false; // admin login link button
                    inventarioLinkButton.Visible = true; // author management link button
                    reportesLinkButton.Visible = true;
                    empleadosLinkButton.Visible = true;  // admin employees
                    clientesAdmin.Visible = true; //admin clients

                }
                
            }
            catch (Exception ex)    
            {
                Response.Write("<script>alert('" + ex.Message + "');</script.");
            }   
            
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            
        }

        protected void userLoginLink_Click(object sender, EventArgs e)
        {
            Response.Redirect("userLogin.aspx");
        }

        protected void userSignupLink_Click(object sender, EventArgs e)
        {
            Response.Redirect("userSignup.aspx");
        }

        protected void LinkButton6_Click(object sender, EventArgs e)
        {
            Response.Redirect("adminLogin.aspx");
        }
        //loginout
        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            Session["role"] = "";
            Response.Write("<script>alert('Login out!');</script.");
        }

        protected void empleadosLinkButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("adminEmployee.aspx");
        }

        protected void clientesAdmin_Click(object sender, EventArgs e)
        {
            Response.Redirect("adminClientes.aspx");
        }

        protected void reportesLinkButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("adminReportes.aspx");
        }
    }
}