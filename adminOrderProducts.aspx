<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="adminOrderProducts.aspx.cs" Inherits="indioSupermercado.adminOrderProducts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


    
     <script src="bootstrap/js/jquery-3.6.1.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {

            //$(document).ready(function () {
            //$('.table').DataTable();
            // });
            $.noConflict();
            jQuery(document).ready(function ($) {
                $(".table").prepend($("<thead></thead>").append($(this).find("tr:first"))).dataTable();
                //$('.table1').DataTable();
            });
            // Code that uses other library's $ can follow here.

        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="container">
        <h2 class="text-center">Product Administration Inventory</h2>
    </section>


    <section class="container-xxl">
        <div class="row">
            <div class="col-md-5">
                <div class="card">
                    <div class="card-body">

                        <div class="row">
                            <div class="col">
                                <center>
                                    <h4>Order Producs to Providers</h4>
                                </center>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col">
                                <center>
                                    <img id="imgview" height="250px" width="250px" src="img/cargo.png" />

                                </center>
                            </div>
                        </div>

                        <%-- Sucursales productos--%>
                        <div class="row">
                            <div class="col-md-6">
                                <label>
                                    Products</label>
                                <div class="form-group">
                                    <asp:DropDownList class="form-control" ID="productosDropList" runat="server">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label>
                                    Branches</label>
                                <div class="form-group">
                                    <asp:DropDownList class="form-control" ID="branchesDropList" runat="server">
                                    </asp:DropDownList>
                                </div>
                            </div>

                        </div>

                        <%--botton best provitder--%>
                        <div class="row m-4 justify-content-center">
                            <div class="col">
                                <div class="form-group">
                                    <asp:Button ID="loadBestBtn" class="btn btn-lg btn-block btn-info" runat="server" Text="Load Best Provider" OnClick="loadBestBtn_Click" />
                                </div>
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
                        <%--tabla--%>
                        <div class="row">
                            <div class="col">


                                <asp:SqlDataSource ID="sqlDataSourceProductos" runat="server"
                                    ConnectionString="" SelectCommand="exec spSelectInventoryView"></asp:SqlDataSource>

                                <asp:ScriptManager ID="ScriptManager1" runat="server">
                                </asp:ScriptManager>
                                <asp:UpdatePanel ID="updatePanelProducts" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <asp:GridView class="table table-striped table-bordered" ID="productsGridView" runat="server"
                                            AutoGenerateColumns="False" DataKeyNames="nombreProducto" DataSourceID="sqlDataSourceProductos">
                                            <Columns>
                                                <asp:BoundField DataField="nombreProducto" HeaderText="Producto" ReadOnly="True" SortExpression="nombreProducto"></asp:BoundField>
                                                <asp:BoundField DataField="nombreSucursal" HeaderText="Sucursal" ReadOnly="True" SortExpression="nombreSucursal"></asp:BoundField>
                                                <asp:BoundField DataField="cantidadInventario" HeaderText="Amount" ReadOnly="True" SortExpression="cantidadInventario"></asp:BoundField>
                                                <asp:BoundField DataField="precioVenta" HeaderText="Price" ReadOnly="True" SortExpression="precioVenta"></asp:BoundField>
                                                <asp:BoundField DataField="minCant" HeaderText="Minimo" ReadOnly="True" SortExpression="minCant"></asp:BoundField>
                                                <asp:BoundField DataField="maxCant" HeaderText="Maximo" ReadOnly="True" SortExpression="maxCant"></asp:BoundField>



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

</asp:Content>
