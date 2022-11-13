<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="adminEmpleados.aspx.cs" Inherits="indioSupermercado.adminEmpleados" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
      <div class="row">
         <div class="col-md-4">
            <div class="card">
               <div class="card-body">
                  <div class="row">
                     <div class="col">
                        <center>
                           <h4>Modificar Empleados</h4>
                        </center>
                     </div>
                  </div>
                  <div class="row">
                     <div class="col">
                        <center>
                           <img width="100px"<img src="img/writer.png"/>
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
                        <asp:FileUpload class="form-control" ID="FileEmpleado" runat="server" />
                     </div>
                  </div>
                  <div class="row">
                     <div class="col-md-6">
                        <label>Nombre</label>
                        <div class="form-group">
                           <div class="input-group">
                              <asp:TextBox CssClass="form-control" ID="TextBoxNombreEmpleado" runat="server" placeholder="Nombre"></asp:TextBox>
                           </div>
                        </div>
                     </div>
                     <div class="col-md-6">
                        <label>Apellido</label>
                        <div class="form-group">
                            <asp:TextBox CssClass="form-control" ID="TextBoxApellidoEmpleado" runat="server" placeholder="Apellido" ></asp:TextBox>
                        </div>
                     </div>
                     
                  </div>
                  <div class="row">

                     <div class="col-md-6">
                        <label>Fecha Contratacion</label>
                        <div class="form-group">
                           <asp:TextBox CssClass="form-control" ID="TextBoxFecha" runat="server" placeholder="YYYY-MM-DD" ></asp:TextBox>
                        </div>
                     </div>
                     
                  </div>
                  <div class="row">
                     <div class="col-md-6">
                        <label>Puesto</label>
                        <div class="form-group">

                           <%--<asp:DropDownList class="form-control" ID="DropDownListPuesto" runat="server">
                              <asp:ListItem Text="Activo" Value=1 />
                              <asp:ListItem Text="Inactivo" Value=2 />
                              <asp:ListItem Text="Suspendido" Value=3 />

                               </asp:DropDownList>--%>

                            <div class="form-group">
                           <asp:TextBox CssClass="form-control" ID="TextBoxPuesto" runat="server" placeholder="ID Puesto" ></asp:TextBox>
                            </div>

                        </div>
                     </div>
                     <div class="col-md-6">
                        <label>Sucursal</label>
                        <div class="form-group">

                            <%--<asp:DropDownList class="form-control" ID="DropDownListSucursal" runat="server">
                              <asp:ListItem Text="Activo" Value=1 />
                              <asp:ListItem Text="Inactivo" Value=2 />
                              <asp:ListItem Text="Suspendido" Value=3 />
                              
                           </asp:DropDownList>--%>
                            <div class="form-group">
                           <asp:TextBox CssClass="form-control" ID="TextBoxSucursal" runat="server" placeholder="ID Puesto" ></asp:TextBox>
                            </div>

                        </div>
                     </div>
                    
                  </div>
                 
                  <div class="row m-4">
                        <div class="col">
                            <div align="center">
                              <asp:Button ID="ButtonEmpleado" class="btn btn-lg btn-block btn-success" runat="server" Text="Insertar" OnClick="ButtonAgregarSucursal_Click" />
                            </div>
                        </div>
                    </div>

                   <div class="row">
                        <div class="col">
                            <div align="center">
                               <label>ID Empleado</label>
                                <div class="form-group">
                                   <div class="input-group">

                                      <asp:TextBox CssClass="form-control" ID="TextBoxIDEmpleado" runat="server" placeholder="ID Empleado" ></asp:TextBox>
                                       
                                   </div>
                                </div>
                            </div>
                        </div>
                    </div>
                   <div class="row m-4">
                        <div class="col-md-4">
                               <asp:Button ID="Button1" class="btn btn-lg btn-block btn-warning" runat="server" Text="Actualizar" OnClick="Button2_Click" />
                        </div>
                       <div class="col">
                           <div style="float: right">
                               <asp:Button ID="ButtonBorrarSucursal" class="btn btn-lg btn-block btn-danger" runat="server" Text="Eliminar" OnClick="ButtonBorrarSucursal_Click" />
                            </div>
                     </div>
                    </div>

                   <br>
               </div>
            </div>
            <br>
            <br />
         </div>
         <div class="col-md-7">
            <div class="card">
               <div class="card-body">
                  <div class="row">
                     <div class="col">
                        <center>
                           <h4>Lista Empleados</h4>
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
