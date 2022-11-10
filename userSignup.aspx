<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="userSignup.aspx.cs" Inherits="indioSupermercado.userSignup" %>
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
            <div class="col-md-8 mx-auto">
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
                           <h2>Custumer Sing Up</h2>
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

                    <div  class="row " >
                       
                        <div class="col campo form-group">       
                            <asp:TextBox CssClass="form-group" id="name_txt" type="text" placeholder="Name" runat="server"></asp:TextBox>
                        </div>

                        <div class="col campo form-group">                          
                            <asp:TextBox CssClass="form-group" id="last_names" type="text" placeholder="Last Names" runat="server"></asp:TextBox>
                        </div>
                                              
                    </div>
                    <div  class="row " >
                       
                        <div class="col campo form-group">       
                            <asp:TextBox CssClass="form-group" id="xLotcation" type="text" placeholder="X location" runat="server"></asp:TextBox>
                        </div>

                        <div class="col campo form-group">                          
                            <asp:TextBox CssClass="form-group" id="yLocation" type="text" placeholder="Y location" runat="server"></asp:TextBox>
                        </div>
                                              
                    </div>
                    <div  class="row" >
                        <div class="col-md-6 mx-auto campo">
                            <span class="fa-lg fas fa-user side-search-icon"></span>
                    
                            <asp:TextBox id="user_txt" type="text" placeholder="User" runat="server"></asp:TextBox>
                        </div>
                     </div>
                     <div  class="row" >
                        <div class="col-md-6 mx-auto form-group campo">
                            <span class="fa-lg fas fa-lock side-search-icon"></span>
                            <asp:TextBox id="pass_txt" type="password" placeholder="Password" runat="server"></asp:TextBox>
                    
                        </div>
                     </div>
                    <div  class="row">
                        <div class="btn_login col-md-6 mx-auto form-group">
                            <center> 
                                <asp:Button runat="server" Text="Sign Up" ID="signupBtn" OnClick="signupBtn_Click" /> 
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
