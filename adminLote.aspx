<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="adminLote.aspx.cs" Inherits="indioSupermercado.adminLote" %>

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
                                    <h4>Invenotory Branch</h4>
                                </center>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col">
                                <center>
                                    <img id="imgview" height="250px" width="250px" src="img/inventory.png" />

                                </center>
                            </div>
                        </div>

                        <div class="row">
                             <div class="col">
                                <label>ID Producto</label>
                                <div class="form-group">
                                    <div class="input-group">
                                        <asp:TextBox CssClass="form-control" ID="idLotetxt" runat="server" placeholder="ID Lote"></asp:TextBox>
                                        <asp:LinkButton class="btn btn-primary" ID="botonIDP" runat="server"><i class="fas fa-check-circle"></i></asp:LinkButton>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <%--Campo fecha--%>
                        <div class="row">
                            <div class="col-md-6">
                                <label>Production Date</label>
                                <div class="form-group">
                                    <div class="input-group">
                                        <asp:TextBox CssClass="form-control" ID="dateProText" runat="server" TextMode="Date"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                               <label>Expiration Date</label>
                                <div class="form-group">
                                    <div class="input-group">
                                        <asp:TextBox CssClass="form-control" ID="dateExpText" runat="server" TextMode="Date"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <%--drop list productos proveedore--%>
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
                                <label>Providers</label>
                                <div class="form-group">
                                    <asp:DropDownList class="form-control" ID="providersDropDownList" runat="server">
                                    </asp:DropDownList>
                                </div>
                            </div>

                        </div>
                        <%--cantidad--%>
                        <div class="row">
                            <div class="col-md-12">
                                <label>Amount</label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="cantTxt" runat="server" TextMode="Number" ></asp:TextBox>
                                </div>
                            </div>

                        </div>

                         <div class="row">
                            <div class="col-md-6">
                                <label>
                                    Cost</label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="costText" runat="server" ></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label>Profit Percent</label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="profitPercentTxt" runat="server"></asp:TextBox>
                                </div>
                            </div>

                        </div>

                        <%--botones--%>
                        <div class="row m-4">
                            <div class="col-md-4">
                                <asp:Button ID="insert" class="btn btn-lg btn-block btn-success" runat="server" Text="Insertar" OnClick="insert_Click" />
                            </div>
                            <div class="col-4">
                                <asp:Button ID="update" class="btn btn-lg btn-block btn-warning" runat="server" Text="Actualizar" OnClick="update_Click"  />
                            </div>
                            <div class="col-4">
                                <asp:Button ID="deleteF" class="btn btn-lg btn-block btn-danger" runat="server" Text="Elminar" OnClick="deleteF_Click"  />
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
                                    ConnectionString="" SelectCommand="exec spSelectLotetoView"></asp:SqlDataSource>

                                <asp:ScriptManager ID="ScriptManager1" runat="server">
                                </asp:ScriptManager>
                                <asp:UpdatePanel ID="updatePanelProducts" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <asp:GridView class="table table-striped table-bordered" ID="productsGridView" runat="server"
                                            AutoGenerateColumns="False" DataKeyNames="idLote" DataSourceID="sqlDataSourceProductos">
                                            <Columns>
                                                <asp:BoundField DataField="idLote" HeaderText="ID" ReadOnly="True" SortExpression="idLote">
                                                    <ControlStyle Font-Bold="True" />
                                                    <ItemStyle Font-Bold="True" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="nombreProducto" HeaderText="Product" ReadOnly="True" SortExpression="nombreProducto"></asp:BoundField>
                                                <asp:BoundField DataField="fechaProduccion" HeaderText="Production" ReadOnly="True" SortExpression="fechaProduccion"></asp:BoundField>
                                                <asp:BoundField DataField="fechaExpiracion" HeaderText="Expiration" ReadOnly="True" SortExpression="fechaExpiracion"></asp:BoundField>
                                                <asp:BoundField DataField="cantidadExistencias" HeaderText="Amount" ReadOnly="True" SortExpression="cantidadExistencias"></asp:BoundField>
                                                <asp:BoundField DataField="costoUnidad" HeaderText="Cost" ReadOnly="True" SortExpression="costoUnidad"></asp:BoundField>                                                
                                                <asp:BoundField DataField="porcentajeVenta" HeaderText="Profit" ReadOnly="True" SortExpression="porcentajeVenta"></asp:BoundField>
                                                <asp:BoundField DataField="nombreProveedor" HeaderText="Provider" ReadOnly="True" SortExpression="nombreProveedor"></asp:BoundField>

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
