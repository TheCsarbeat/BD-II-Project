<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="adminFormProvider.aspx.cs" Inherits="indioSupermercado.adminFormProvider" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
      <div class="row">
         <div class="col-md-5">
            <div class="card">
               <div class="card-body">
                  <div class="row">
                     <div class="col">
                        <center>
                           <h4>Provider Details</h4>
                        </center>
                     </div>
                  </div>
                  <div class="row">
                     <div class="col">
                        <center>
                           <img width="100px" src="img/proveedor.png" />
                        </center>
                     </div>
                  </div>
                  <div class="row">
                     <div class="col">
                        <hr>
                     </div>
                  </div>
                  
                  <div class="row">
                     <div class="col-md-4">
                        <label>ID Provider</label>
                        <div class="form-group">
                           <div class="input-group">
                              <asp:TextBox CssClass="form-control" ID="TextBoxIDProvider" runat="server" placeholder="ID Provider"></asp:TextBox>
                               <%--<asp:LinkButton class="btn btn-primary" ID="LinkButton4" runat="server" OnClick="LinkButton4_Click"><i class="fas fa-check-circle"></i></asp:LinkButton>--%>
                           </div>
                        </div>
                     </div>
                     <div class="col-md-8">
                        <label>Provider name</label>
                        <div class="form-group">
                           <asp:TextBox CssClass="form-control" ID="TextBoxNombreProvider" runat="server" placeholder="Provider name" ></asp:TextBox>
                        </div>
                     </div>
                     
                  </div>
                  <div class="row">
                     <div class="col-md-6">
                        <label>Contact</label>
                        <div class="form-group">
                           <asp:TextBox CssClass="form-control" ID="TextBoxContactProvider" runat="server" placeholder="contact" ></asp:TextBox>
                        </div>
                     </div>
                     <div class="col-md-6">
                        <label>ID Country</label>
                        <div class="form-group">
                            <asp:DropDownList class="form-control" ID="paisDropList" runat="server">
                              
                           </asp:DropDownList>
                           <asp:TextBox CssClass="form-control" ID="TextBoxIDCountry" runat="server" placeholder="idCountry" ></asp:TextBox>
                        </div>
                     </div>
                     
                  </div>
                  <div class="row">
                     <div class="col-md-12">
                        <label>Status</label>
                        <div class="form-group">
                            <asp:DropDownList class="form-control" ID="DropDownListStatusProvider" runat="server">
                              <asp:ListItem Text="Active" Value=1 />
                              <asp:ListItem Text="Inactive" Value=0 />
                              <asp:ListItem Text="Suspended" Value=2 />
                              
                           </asp:DropDownList>
                        </div>
                     </div>
                    
                  </div>
                 
                  <div class="row m-4">
                      <div class="col-md-4">
                          <asp:Button ID="ButtonAgregarProvider" class="btn btn-lg btn-block btn-success" runat="server" Text="Insert" OnClick="ButtonAgregarProvider_Click" />
                     </div>
                      <div class="col-4">
                          <asp:Button ID="ButtonActualizarProvider" class="btn btn-lg btn-block btn-warning" runat="server" Text="Update" OnClick="ButtonActualizarProvider_Click" />
                     </div>
                     <div class="col-4">
                         <asp:Button ID="ButtonBorrarProvider" class="btn btn-lg btn-block btn-danger" runat="server" Text="Delete" OnClick="ButtonBorrarProvider_Click" />
                     </div>
                  </div>
               </div>
            </div>
            <a href="homepage.aspx"><< Back to Home</a><br>
            <br>
         </div>
         <div class="col-md-7">
            <div class="card">
               <div class="card-body">
                  <div class="row">
                     <div class="col">
                        <center>
                           <h4>List of Providers</h4>
                        </center>
                     </div>
                  </div>
                  <div class="row">
                     <div class="col">
                        <hr>
                     </div>
                  </div>
                  <div class="row">
                     <%--data source--%>
                      <asp:SqlDataSource ID="SqlDataSourceProvider" runat="server" 
                          ConnectionString="" SelectCommand="exec spSelectProviderToView"></asp:SqlDataSource>
                      <div class="col">
                         <asp:ScriptManager ID="ScriptManager1" runat="server">
                            </asp:ScriptManager>
                         <asp:UpdatePanel ID="UpdatePanelProvider" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:GridView class="table table-striped table-bordered" ID="GridViewProvider" runat="server"
                                    AutoGenerateColumns="False" DataKeyNames="idProveedor" DataSourceID="SqlDataSourceProvider" >
                                        <Columns>
                                            <asp:BoundField DataField="idProveedor" HeaderText="ID" ReadOnly="True" SortExpression="empleadoID">
                                                <ControlStyle Font-Bold="True" />
                                                <ItemStyle Font-Bold="True" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Nombre" HeaderText="Name" ReadOnly="True" SortExpression="Nombre"></asp:BoundField>
                                            <asp:BoundField DataField="Contacto" HeaderText="Contact" ReadOnly="True" SortExpression="Contacto"></asp:BoundField>
                                            <asp:BoundField DataField="Pais" HeaderText="Country" ReadOnly="True" SortExpression="Pais"></asp:BoundField>
                                 
                                        </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                     </div>
                  </div>
                   <%--aqui termina el div del data source--%>
               </div>
            </div>
         </div>
      </div>
   </div>
    
</asp:Content>
