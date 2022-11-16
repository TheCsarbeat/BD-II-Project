<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="adminFormBranch.aspx.cs" Inherits="indioSupermercado.adminFormSucursal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="bootstrap/js/jquery-3.6.1.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {

            //$(document).ready(function () {
            //$('.table').DataTable();
            // });
            $(".table").prepend($("<thead></thead>").append($(this).find("tr:first"))).dataTable();
            // Code that uses other library's $ can follow here.

        });

    </script>
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
                           <h4>Branch Details</h4>
                        </center>
                     </div>
                  </div>
                  <div class="row">
                     <div class="col">
                        <center>
                           <img width="100px" src="img/supermarkets.png" />
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
                        <label>ID Branch</label>
                        <div class="form-group">
                           <div class="input-group">
                              <asp:TextBox CssClass="form-control" ID="TextBoxIDSucursal" runat="server" placeholder="ID Branch"></asp:TextBox>
                               <%--<asp:LinkButton class="btn btn-primary" ID="LinkButton4" runat="server" OnClick="LinkButton4_Click"><i class="fas fa-check-circle"></i></asp:LinkButton>--%>
                           </div>
                        </div>
                     </div>
                     <div class="col-md-8">
                        <label>Branch name</label>
                        <div class="form-group">
                           <asp:TextBox CssClass="form-control" ID="TextBoxNombreSucursal" runat="server" placeholder="Branch name" ></asp:TextBox>
                        </div>
                     </div>
                     
                  </div>
                  <div class="row">
                     <div class="col-md-6">
                        <label>Place</label>
                        <div class="form-group">
                           <asp:DropDownList class="form-control" ID="lugarDropList" runat="server">
                              
                           </asp:DropDownList>
                        </div>
                     </div>
                     <div class="col-md-6">
                        <label>Coin porcentage</label>
                        <div class="form-group">
                           <asp:DropDownList class="form-control" ID="monedaXPaisDropList" runat="server">
                              
                           </asp:DropDownList>
                        </div>
                     </div>
                     
                  </div>
                  <div class="row">
                     <div class="col-md-12">
                        <label>Status</label>
                        <div class="form-group">
                            <asp:DropDownList class="form-control" ID="DropDownListEstado" runat="server">
                              <asp:ListItem Text="Active" Value=1 />
                              <asp:ListItem Text="Inactive" Value=0 />
                              <asp:ListItem Text="Suspended" Value=2 />
                              
                           </asp:DropDownList>
                        </div>
                     </div>
                    
                  </div>
                 
                  <div class="row m-4">
                      <div class="col-md-4">
                        <asp:Button ID="ButtonAgregarSucursal" class="btn btn-lg btn-block btn-success" runat="server" Text="Insert" OnClick="ButtonAgregarSucursal_Click" />
                     </div>
                      <div class="col-4">
                          <asp:Button ID="ButtonActualizarSucursal" class="btn btn-lg btn-block btn-warning" runat="server" Text="Update" OnClick="ButtonActualizarSucursal_Click" />
                     </div>
                     <div class="col-4">
                         <asp:Button ID="ButtonBorrarSucursal" class="btn btn-lg btn-block btn-danger" runat="server" Text="Delete" OnClick="ButtonBorrarSucursal_Click" />
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
                           <h4>List of branches</h4>
                        </center>
                     </div>
                  </div>
                  <div class="row">
                     <div class="col">
                        <hr>
                     </div>
                  </div>
                  <div class="row">
                     <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                          ConnectionString="" SelectCommand="exec spSelectSucursalesToView"></asp:SqlDataSource>
                     <div class="col">
                         <asp:ScriptManager ID="ScriptManager1" runat="server">
                            </asp:ScriptManager>
                         <asp:UpdatePanel ID="UpdatePanelSucursal" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:GridView class="table table-striped table-bordered" ID="GridViewSucursal" runat="server"
                                    AutoGenerateColumns="False" DataKeyNames="idSucursal" DataSourceID="SqlDataSource1" >
                                        <Columns>
                                            <asp:BoundField DataField="idSucursal" HeaderText="ID" ReadOnly="True" SortExpression="empleadoID">
                                                <ControlStyle Font-Bold="True" />
                                                <ItemStyle Font-Bold="True" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Nombre" HeaderText="Name" ReadOnly="True" SortExpression="Nombre"></asp:BoundField>
                                            <asp:BoundField DataField="Lugar" HeaderText="Place" ReadOnly="True" SortExpression="Lugar"></asp:BoundField>
                                            <asp:BoundField DataField="Moneda" HeaderText="Coin" ReadOnly="True" SortExpression="Moneda"></asp:BoundField>
                                 
                                        </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
</asp:Content>
