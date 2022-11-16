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
                    productsLinkButton.Visible = false;
                    orderProducts.Visible = false;
                    taxCategoria.Visible = false;
                    providers.Visible = false;
                    discount.Visible = false;
                    expired.Visible = false;
                    SucursalAdmin.Visible = false; // admin sucursales
                    ProveedorAdmin.Visible = false; // admin proveedor
                    TipoCambioAdmin.Visible = false; // admin tipo cambio
                    ImpuestoAdmin.Visible = false; // admin impuesto
                    TipoPagoAdmin.Visible = false; // admin tipoPago
                    PuestoTrabajo.Visible = false; // admin puesto

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
                    productsLinkButton.Visible = false;
                    orderProducts.Visible = false;
                    taxCategoria.Visible = false;
                    providers.Visible = false;
                    discount.Visible = false;
                    expired.Visible = false;
                    SucursalAdmin.Visible = false; // admin sucursales
                    ProveedorAdmin.Visible = false; // admin proveedor
                    TipoCambioAdmin.Visible = false; // admin tipo cambio
                    ImpuestoAdmin.Visible = false; // admin impuesto
                    TipoPagoAdmin.Visible = false; // admin tipoPago
                    PuestoTrabajo.Visible = false; // admin puesto

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
                    productsLinkButton.Visible = true;
                    orderProducts.Visible = true;
                    taxCategoria.Visible = true;
                    providers.Visible = true;
                    discount.Visible = true;
                    expired.Visible = true;
                    SucursalAdmin.Visible = true; // admin sucursales
                    ProveedorAdmin.Visible = true; // admin proveedor
                    TipoCambioAdmin.Visible = true; // admin tipo cambio
                    ImpuestoAdmin.Visible = true; // admin impuesto
                    TipoPagoAdmin.Visible = true; // admin tipoPago
                    PuestoTrabajo.Visible = true; // admin puesto

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
            Response.Redirect("homePage.aspx");
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

        protected void productsLinkButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("adminFormProductos.aspx");
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void taxCategori_Click(object sender, EventArgs e)
        {
            Response.Redirect("adminFormTaxByCategory.aspx");
        }
        protected void sucursalLinkButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("adminFormBranch.aspx");
        }

        protected void proveedorLinkButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("adminFormProvider.aspx");
        }

        protected void orderProducts_Click(object sender, EventArgs e)
        {
            Response.Redirect("adminOrderProducts.aspx");
        }

        protected void providers_Click1(object sender, EventArgs e)
        {
            Response.Redirect("adminFormProvider.aspx");
        }

        protected void discount_Click(object sender, EventArgs e)
        {
            Response.Redirect("adminDiscount.aspx");
        }

        protected void expired_Click(object sender, EventArgs e)
        {
            Response.Redirect("adminExpired.aspx");
        }
        protected void tipoCambioLinkButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("adminFormTipoCambio.aspx");
        }

        protected void impuestoLinkButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("adminFormImpuesto.aspx");
        }

        protected void tipoPagoLinkButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("adminFormTipoPago.aspx");
        }

        protected void puestoLinkButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("adminFormPuesto.aspx");
        }
    }
}