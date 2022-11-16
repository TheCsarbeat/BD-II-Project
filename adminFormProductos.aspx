<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="adminFormProductos.aspx.cs" Inherits="indioSupermercado.adminFormReporte" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

 
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
    <section class="container">
        <h2 class="text-center">Product Administration</h2>

    </section>
    <section class="container-xxl">
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
                                    <img id="imgview" height="250px" width="250px" src="img/producto.png" />

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
                                    <asp:TextBox Class="form-control" ID="nombreProductotxt" placeholder="Nombre Producto" runat="server"></asp:TextBox>
                                </div>
                            </div>

                        </div>
                        <%--estado categoria--%>
                        <div class="row">
                            <div class="col-md-6">
                                <label>
                                    Estado</label>
                                <div class="form-group">
                                    <asp:DropDownList class="form-control" ID="DropDownListEstado" runat="server">
                                        <asp:ListItem Text="Activo" Value="0" />
                                        <asp:ListItem Text="Inactivo" Value="1" />
                                        <asp:ListItem Text="Suspendido" Value="2" />

                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label>ID Categoria</label>
                                <div class="form-group">
                                    <asp:DropDownList class="form-control" ID="categoriaDropDownList" runat="server">
                                    </asp:DropDownList>
                                </div>
                            </div>

                        </div>
                        <%--limite--%>
                        <div class="row">
                            <div class="col-md-6">
                                <label>Min</label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="minTxt" runat="server" TextMode="Number"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label>Max</label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="maxTxt" runat="server" TextMode="Number"></asp:TextBox>
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
                                <asp:Button ID="insertProductBtn" class="btn btn-lg btn-block btn-success" runat="server" Text="Insertar" OnClick="ButtonAgregarSucursal_Click" />
                            </div>
                            <div class="col-4">
                                <asp:Button ID="update" class="btn btn-lg btn-block btn-warning" runat="server" Text="Actualizar" OnClick="update_Click" />
                            </div>
                            <div class="col-4">
                                <asp:Button ID="delete" class="btn btn-lg btn-block btn-danger" runat="server" Text="Desactivar" OnClick="delete_Click" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <asp:Button ID="deleteF" class="btn btn-lg btn-block btn-danger" runat="server" Text="Elminar Permanente" OnClick="deleteF_Click" />
                            </div>
                            <div class="col">
                                <asp:Button ID="Button1" class="btn btn-lg btn-block btn-warning" runat="server" Text="Reactivar" OnClick="Button1_Click" />
                            </div>
                        </div>
                    </div>
                </div>
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


                                <asp:SqlDataSource ID="sqlDataSourceProductos" runat="server"
                                    ConnectionString="" SelectCommand="exec spSelectProductsToView"></asp:SqlDataSource>

                                <asp:ScriptManager ID="ScriptManager1" runat="server">
                                </asp:ScriptManager>
                                <asp:UpdatePanel ID="updatePanelProducts" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <asp:GridView class="table table-striped table-bordered" ID="productsGridView" runat="server"
                                            AutoGenerateColumns="False" DataKeyNames="idProducto" DataSourceID="sqlDataSourceProductos">
                                            <Columns>
                                                <asp:BoundField DataField="idProducto" HeaderText="ID" ReadOnly="True" SortExpression="productosID">
                                                    <ControlStyle Font-Bold="True" />
                                                    <ItemStyle Font-Bold="True" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Nombre" HeaderText="Nombre" ReadOnly="True" SortExpression="Nombre"></asp:BoundField>
                                                <asp:BoundField DataField="minCant" HeaderText="Minimo" ReadOnly="True" SortExpression="minCant"></asp:BoundField>
                                                <asp:BoundField DataField="maxCant" HeaderText="Máximo" ReadOnly="True" SortExpression="maxCant"></asp:BoundField>
                                                <asp:BoundField DataField="Descripcion" HeaderText="Descripcion" ReadOnly="True" SortExpression="Descripcion"></asp:BoundField>
                                                <asp:BoundField DataField="Categoria" HeaderText="Categoria" ReadOnly="True" SortExpression="Categoria"></asp:BoundField>
                                                <asp:BoundField DataField="estado" HeaderText="Estado" ReadOnly="True" SortExpression="estado"></asp:BoundField>

                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <div class="col-lg-2">
                                                            <asp:Image class="img-fluid" ID="Image1" runat="server" ImageUrl='<%# Eval("imgPath") %>' />
                                                        </div>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

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

    </section>

    <%-- Seccion de asignar impuesto --%>
</asp:Content>
