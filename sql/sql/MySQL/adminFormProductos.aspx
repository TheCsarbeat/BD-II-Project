﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="adminFormProductos.aspx.cs" Inherits="indioSupermercado.adminFormReporte" %>
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
                           <h4>Detalles de los Productos</h4>
                        </center>
                     </div>
                  </div>
                  <div class="row">
                     <div class="col">
                        <center>
                           <img width="100px" src="img/producto.png" />
                        </center>
                     </div>
                  </div>
                  <div class="row">
                     <div class="col">
                        <hr>
                         <asp:FileUpload class="form-control" ID="FileUpload1" runat="server" />
                     </div>
                  </div>
                  
                  <div class="row">
                     <div class="col-md-4">
                        <label>ID Producto</label>
                        <div class="form-group">
                           <div class="input-group">
                              <asp:TextBox CssClass="form-control" ID="idProductotxt" runat="server" placeholder="ID Producto"></asp:TextBox>
                              <asp:LinkButton class="btn btn-primary" ID="botonIDP" runat="server"><i class="fas fa-check-circle"></i></asp:LinkButton>
                           </div>
                        </div>
                     </div>
                     <div class="col-md-8">
                        <label>Nombre Producto</label>
                        <div class="form-group">
                           <asp:TextBox CssClass="form-control" ID="nombreProductotxt" runat="server" placeholder="Nombre Producto" ></asp:TextBox>
                        </div>
                     </div>
                     
                  </div>
                  <div class="row">
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
                     <div class="col-md-6">
                        <label>ID Categoria</label>
                        <div class="form-group">
                           <asp:TextBox CssClass="form-control" ID="categoriaProductotxt" runat="server" placeholder="ID categoria" ></asp:TextBox>
                        </div>
                     </div>
                     
                  </div>
                  <div class="row">
                     <div class="col-md-12">
                        <label>Descripcion</label>
                        <div class="form-group">
                            <asp:TextBox CssClass="form-control" ID="descripcionProductotxt" runat="server" placeholder="Descripcion"></asp:TextBox>
                        </div>
                     </div>
                    
                  </div>
                 
                  <div class="row m-4">
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
                           <h4>Lista de Productos</h4>
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