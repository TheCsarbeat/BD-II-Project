using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace indioSupermercado
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (Session["role"].Equals(""))
                {
                    userLoginLink.Visible = true;     //Boton Login
                    userSignupLink.Visible = true;      //Boton SignUp
                    LinkButton3.Visible = false;        //Buton Logout

                    LinkButton11.Visible = false;       //Boton Inventario
                    LinkButton12.Visible = false;       //Boton Reportes
                        
                }
                else if (Session["role"].Equals("ActiveAdmin"))
                {
                    userLoginLink.Visible = false;
                    userSignupLink.Visible = false;
                    LinkButton3.Visible = true;

                    LinkButton11.Visible = true;       //Boton Inventario
                    LinkButton12.Visible = true;       //Boton Reportes
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

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            Session["role"] = "";
            Response.Write("<script LANGUAGE='JavaScript' >alert('Logout Sucessful');window.location='homePage.aspx';</script>");
        }
    }
}