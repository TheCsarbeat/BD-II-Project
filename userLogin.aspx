<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="userLogin.aspx.cs" Inherits="indioSupermercado.userLogin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="container-fluid" style="background-image: var(--fondo-login);
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  background-attachment: fixed;
  height: 100vh;
  ">

        <div class="container center " >
             <div class="row">
            <div class="col-md-6 mx-auto">
                <div class="card login-content ">
                    <div class="card-body login_info">

                        <div class="col imagen-login">
                            <center> 
                                <img width="150px" src="img/Icono_logo.png" alt="">
                            </center>  
                           
                        </div>

                        <div class="row">
                     <div class="col">
                        <center>
                           <h2>Custumer Login</h2>
                        </center>
                     </div>
                  </div>

                    </div>
                    <div class="row">
                     <div class="col">
                        <hr>
                     </div>
                  </div>
                    <%--Esta es la parte de los campos--%>

                    <div  class="row" >
                        <div class="col-md-6 mx-auto campo">
                            <span class="fa-lg fas fa-user side-search-icon"></span>
                    
                            <asp:TextBox id="user_txt" name="cedula" type="text" placeholder="User" runat="server"></asp:TextBox>
                        </div>
                        
                    </div>
                     <div  class="row" >
                        <div class="col-md-6 mx-auto form-group campo">
                            <span class="fa-lg fas fa-lock side-search-icon"></span>
                            <asp:TextBox id="pass_txt" name="contraseña" type="password" placeholder="Password" runat="server"></asp:TextBox>
                    
                        </div>
                     </div>
                    <div  class="row">
                        <div class="btn_login col-md-6 mx-auto form-group">
                            <center> 
                                <asp:Button runat="server" Text="Login" /> 
                            </center>  
                            
                        </div>
                     </div>

                     <div  class="row">
                     <div class="col-md-6 mx-auto form-group btn_sing_up">
                          <center> 
                            <a href="userSignup.aspx"><input id="Button2" type="button" value="Sign Up" /></a>  
                         </center>  
                      </div>
                    </div>
                    </div>
                    
                </div>
               
        <!--Login_contenido-->
            </div>
        </div>
        </div>
    </section>
</asp:Content>
