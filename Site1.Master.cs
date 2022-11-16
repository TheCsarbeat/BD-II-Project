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
                    Comprar.Visible = false;


                    adminloginLink.Visible = true; // admin login link button

                    
                    reportesLinkButton.Visible = false; // publisher management link button
                    empleadosLinkButton.Visible = false;  // admin employees
                    clientesAdmin.Visible = false; //admin clients
                    productsLinkButton.Visible = false;
                    orderProducts.Visible = false;
                    taxCategoria.Visible = false;                    
                    discount.Visible = false;
                    expired.Visible = false;
                    SucursalAdmin.Visible = false; // admin sucursales
                    ProveedorAdmin.Visible = false; // admin proveedor
                    TipoCambioAdmin.Visible = false; // admin tipo cambio
                    ImpuestoAdmin.Visible = false; // admin impuesto
                    TipoPagoAdmin.Visible = false; // admin tipoPago
                    PuestoTrabajo.Visible = false; // admin puesto
                    Lugar.Visible = false;
                    loteLinkButton.Visible = false;
                    Manager.Visible = false;
                    adminCategoria.Visible = false;
                    adminFormHorario.Visible = false;


                }
                else if (Session["role"].Equals("user"))
                {
                    //Response.Write("<script>alert('estoy en usuario');</script.");
                    userLoginLink.Visible = false; // user login link button
                    userSignupLink.Visible = false; // sign up link button

                    loginOut.Visible = true; // logout link button
                    helloUser.Visible = true; // hello user link button
                    Comprar.Visible = true;
                    helloUser.Text = "Hello " + Session["username"].ToString();


                    adminloginLink.Visible = true; // admin login link button
                    
                    reportesLinkButton.Visible = false; // publisher management link button
                    empleadosLinkButton.Visible = false;  // admin employees
                    clientesAdmin.Visible = false;//admin clients
                    productsLinkButton.Visible = false;
                    orderProducts.Visible = false;
                    taxCategoria.Visible = false;
                   
                    discount.Visible = false;
                    expired.Visible = false;
                    SucursalAdmin.Visible = false; // admin sucursales
                    ProveedorAdmin.Visible = false; // admin proveedor
                    TipoCambioAdmin.Visible = false; // admin tipo cambio
                    ImpuestoAdmin.Visible = false; // admin impuesto
                    TipoPagoAdmin.Visible = false; // admin tipoPago
                    PuestoTrabajo.Visible = false; // admin puesto
                    Lugar.Visible = false;
                    Manager.Visible = false;
                    adminCategoria.Visible = false;
                    loteLinkButton.Visible = false;
                    adminFormHorario.Visible = false;
                }
                else if (Session["role"].Equals("ActiveAdmin"))
                {
                    //Response.Write("<script>alert('estoy en admin');</script.");
                    userLoginLink.Visible = false; // user login link button
                    userSignupLink.Visible = false; // sign up link button
                    Comprar.Visible= false;

                    loginOut.Visible = true; // logout link button
                    helloUser.Visible = true; // hello user link button
                    helloUser.Text = "Hello Admin";


                    adminloginLink.Visible = false; // admin login link button
                   
                    reportesLinkButton.Visible = true;
                    empleadosLinkButton.Visible = true;  // admin employees
                    clientesAdmin.Visible = true; //admin clients
                    productsLinkButton.Visible = true;
                    orderProducts.Visible = true;
                    taxCategoria.Visible = true;
                    
                    discount.Visible = true;
                    expired.Visible = true;
                    SucursalAdmin.Visible = true; // admin sucursales
                    ProveedorAdmin.Visible = true; // admin proveedor
                    TipoCambioAdmin.Visible = true; // admin tipo cambio
                    ImpuestoAdmin.Visible = true; // admin impuesto
                    TipoPagoAdmin.Visible = true; // admin tipoPago
                    PuestoTrabajo.Visible = true; // admin puesto
                    Lugar.Visible = true;
                    Manager.Visible = true;
                    loteLinkButton.Visible = true;
                    adminCategoria.Visible = true;
                    adminFormHorario.Visible = true;
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

        protected void Lugar_Click(object sender, EventArgs e)
        {
            Response.Redirect("adminFormLugar.aspx");
        }

        protected void Comprar_Click(object sender, EventArgs e)
        {
            Response.Redirect("branchSelector.aspx");
        }

        protected void Manager_Click(object sender, EventArgs e)
        {
            Response.Redirect("adminFormManager.aspx");
        }
        protected void orderProducts_Click1(object sender, EventArgs e)
        {
            Response.Redirect("adminOrderProducts.aspx");
        }

        protected void loteLinkButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("adminLote.aspx");
        }

        protected void taxCategoria_Click(object sender, EventArgs e)
        {
            Response.Redirect("adminFormTaxByCategory.aspx");
        }

        protected void orderProducts_Click2(object sender, EventArgs e)
        {
            Response.Redirect("adminOrderProducts.aspx");
        }

        protected void adminCategoria_Click(object sender, EventArgs e)
        {
            Response.Redirect("adminCategoria.aspx");
        }

        protected void adminFormHorario_Click(object sender, EventArgs e)
        {
            Response.Redirect("adminFormHorario.aspx");
        }
    }
}