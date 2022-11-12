using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace indioSupermercado
{
    public partial class WebForm2 : System.Web.UI.Page
    {

        //string stringConnection = ConfigurationManager.ConnectionStrings["connectionAdmin"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        //user login
        protected void Unnamed1_Click(object sender, EventArgs e)
        {
            try
            {
                //SqlConnection conObj = new SqlConnection(stringConnection);
                //if (conObj.State == ConnectionState.Closed)
                //{
                  //  conObj.Open(); 
                //}
                if (user_txt.Text.Trim() == "Management" && pass_txt.Text.Trim() == "asdfasdf")
                {

                    Response.Write("<script LANGUAGE='JavaScript' >alert('Login Sucessful!');window.location='homePage.aspx';</script>");
                    Session["adminUser"] = "Administrador";
                    Session["role"] = "ActiveAdmin";

                }
                else
                {
                    Response.Write("<script LANGUAGE='JavaScript' >alert('Invalid Credentials!');</script>");
                    
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('"+ex.Message+"');</script.");
            }
            
            
            
            // Response.Write("<script>alert('Button Click');</script.");
        }   
    }
}