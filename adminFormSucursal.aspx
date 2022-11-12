<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="adminFormSucursal.aspx.cs" Inherits="indioSupermercado.adminFormSucursal" %>
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
                           <h4>Detalles de la sucursal</h4>
                        </center>
                     </div>
                  </div>
                  <div class="row">
                     <div class="col">
                        <center>
                           <img width="100px" src="img/supermercado.png" />
                        </center>
                     </div>
                  </div>
                  <div class="row">
                     <div class="col">
                        <hr>
                     </div>
                  </div>
                   <div class="row">
                     <div class="col">
                        <asp:FileUpload class="form-control" ID="FileSucursal runat="server" />
                     </div>
                  </div>
                  <div class="row">
                     <div class="col-md-4">
                        <label>ID Sucursal</label>
                        <div class="form-group">
                           <div class="input-group">
                              <asp:TextBox CssClass="form-control" ID="TextBoxIDSucursal" runat="server" placeholder="ID Sucursal"></asp:TextBox>
                              <asp:LinkButton class="btn btn-primary" ID="LinkButton4" runat="server"><i class="fas fa-check-circle"></i></asp:LinkButton>
                           </div>
                        </div>
                     </div>
                     <div class="col-md-8">
                        <label>Nombre Sucursal</label>
                        <div class="form-group">
                           <asp:TextBox CssClass="form-control" ID="TextBoxNombreSucursal" runat="server" placeholder="Nombre Sucursal" ></asp:TextBox>
                        </div>
                     </div>
                     
                  </div>
                  <div class="row">
                     <div class="col-md-6">
                        <label>ID Lugar</label>
                        <div class="form-group">
                           <asp:TextBox CssClass="form-control" ID="TextBoxIDLugar" runat="server" placeholder="ID Lugar" ></asp:TextBox>
                        </div>
                     </div>
                     <div class="col-md-6">
                        <label>idMonedaXPais</label>
                        <div class="form-group">
                           <asp:TextBox CssClass="form-control" ID="TextBoxIdMonedaXP" runat="server" placeholder="idMonedaXPais" ></asp:TextBox>
                        </div>
                     </div>
                     
                  </div>
                  <div class="row">
                     <div class="col-md-6">
                        <label>ID Empleado Administrador</label>
                        <div class="form-group">
                           <asp:TextBox CssClass="form-control" ID="TextBoxEmpAdmin" runat="server" placeholder="ID Empleado"></asp:TextBox>
                        </div>
                     </div>
                     <div class="col-md-6">
                        <label>Estado</label>
                        <div class="form-group">
                            <asp:DropDownList class="form-control" ID="DropDownListEstado" runat="server">
                              <asp:ListItem Text="Activo" Value=0 />
                              <asp:ListItem Text="Inactivo" Value=1 />
                              <asp:ListItem Text="Suspendido" Value=2 />
                              
                           </asp:DropDownList>
                        </div>
                     </div>
                    
                  </div>
                 
                  <div class="row">
                      <div class="col-md-4">
                        <asp:Button ID="ButtonAgregarSucursal" class="btn btn-lg btn-block btn-success" runat="server" Text="Insertar" />
                     </div>
                      <div class="col-4">
                        <asp:Button ID="ButtonActualizarSucursal" class="btn btn-lg btn-block btn-warning" runat="server" Text="Actualizar" />
                     </div>
                     <div class="col-4">
                        <asp:Button ID="ButtonBorrarSucursal" class="btn btn-lg btn-block btn-danger" runat="server" Text="Eliminar" />
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
                           <h4>Lista de sucursales</h4>
                        </center>
                     </div>
                  </div>
                  <div class="row">
                     <div class="col">
                        <hr>
                     </div>
                  </div>
                  <div class="row">
                     <div class="col">
                        <asp:GridView class="table table-striped table-bordered" ID="GridView1" runat="server"></asp:GridView>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
</asp:Content>
