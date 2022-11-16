<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="adminReportes.aspx.cs" Inherits="indioSupermercado.adminReportes" %>

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
            <div class="col">
                <div align="center">
                    <asp:Button ID="ButtonBono" class="btn btn-lg btn-block btn-secondary" runat="server" Text="Reporte Bonos" OnClick="ButtonReporteBono" />
                    <asp:Button ID="Button1" class="btn btn-lg btn-block btn-secondary" runat="server" Text="Reporte Mas Vendidos" OnClick="Button1_Click" />
                    <asp:Button ID="Button2" class="btn btn-lg btn-block btn-secondary" runat="server" Text="Reporte Clientes" OnClick="Button2_Click" />
                    <asp:Button ID="Button4" class="btn btn-lg btn-block btn-secondary" runat="server" Text="Reporte Expirados" OnClick="Button4_Click" />
                    <asp:Button ID="Button3" class="btn btn-lg btn-block btn-secondary" runat="server" Text="Reporte Ganancias" OnClick="Button3_Click" />
                </div>
            </div>
            <br>
            <br>
            <br>
            <div align="center">

                <div class="col-md-7">
                    <div class="card">
                        <div class="card-body">
                            <div class="row">
                                <div class="col">
                                    <center>
                                        <h4>Reportes</h4>
                                    </center>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <hr>
                                </div>
                            </div>
                            <div class="row">

                                <asp:SqlDataSource ID="SqlDataSourceBono" runat="server"
                                    ConnectionString="" SelectCommand="exec reporteBonos"></asp:SqlDataSource>
                                <asp:SqlDataSource ID="SqlDataSourceVendidos" runat="server"
                                    ConnectionString="" SelectCommand="exec spReporteProductosVendidos"></asp:SqlDataSource>
                                <asp:SqlDataSource ID="SqlDataSourceFrecuentes" runat="server"
                                    ConnectionString="" SelectCommand="exec spReporteClientes"></asp:SqlDataSource>
                                <asp:SqlDataSource ID="SqlDataSourceExpirados" runat="server"
                                    ConnectionString="" SelectCommand="exec spReporteExpirados"></asp:SqlDataSource>
                                <asp:SqlDataSource ID="SqlDataSourceGanancias" runat="server"
                                    ConnectionString="" SelectCommand="exec spReportesGanancias"></asp:SqlDataSource>

                                <div class="col">
                                    <asp:ScriptManager ID="ScriptManagerCliente" runat="server">
                                    </asp:ScriptManager>
                                    <asp:UpdatePanel ID="UpdatePanelCliente" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <asp:GridView class="table table-striped table-bordered" ID="GridViewReporteBono" runat="server"
                                                AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="SqlDataSourceBono">
                                                <Columns>
                                                    <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" SortExpression="id">
                                                        <ControlStyle Font-Bold="True" />
                                                        <ItemStyle Font-Bold="True" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" ReadOnly="True" SortExpression="Nombre"></asp:BoundField>
                                                    <asp:BoundField DataField="NombreBono" HeaderText="NombreBono" ReadOnly="True" SortExpression="NombreBono"></asp:BoundField>
                                                    <asp:BoundField DataField="TipoBono" HeaderText="TipoBono" ReadOnly="True" SortExpression="TipoBono"></asp:BoundField>
                                                    <asp:BoundField DataField="Monto" HeaderText="Monto" ReadOnly="True" SortExpression="Monto"></asp:BoundField>
                                                    <asp:BoundField DataField="Descripcion" HeaderText="Descripcion" ReadOnly="True" SortExpression="Descripcion"></asp:BoundField>

                                                </Columns>
                                            </asp:GridView>
                                            <asp:GridView class="table table-striped table-bordered" ID="GridViewExpirados" runat="server"
                                                AutoGenerateColumns="False" DataKeyNames="Nombre" DataSourceID="SqlDataSourceExpirados">
                                                <Columns>
                                                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" ReadOnly="True" SortExpression="Nombre"></asp:BoundField>
                                                    <asp:BoundField DataField="Vencimiento" HeaderText="Vencimiento" ReadOnly="True" SortExpression="Vencimiento"></asp:BoundField>
                                                    <asp:BoundField DataField="Lote" HeaderText="Lote" ReadOnly="True" SortExpression="Lote"></asp:BoundField>
                                                    <asp:BoundField DataField="Precio" HeaderText="Precio" ReadOnly="True" SortExpression="Precio   "></asp:BoundField>
                                                    <asp:BoundField DataField="Categoria" HeaderText="Categoria" ReadOnly="True" SortExpression="Categoria"></asp:BoundField>

                                                </Columns>
                                            </asp:GridView>
                                            <asp:GridView class="table table-striped table-bordered" ID="GridViewVendidos" runat="server"
                                                AutoGenerateColumns="False" DataKeyNames="idProducto" DataSourceID="SqlDataSourceVendidos">
                                                <Columns>
                                                    <asp:BoundField DataField="idProducto" HeaderText="ID" ReadOnly="True" SortExpression="id">
                                                        <ControlStyle Font-Bold="True" />
                                                        <ItemStyle Font-Bold="True" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" ReadOnly="True" SortExpression="Nombre"></asp:BoundField>
                                                    <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" ReadOnly="True" SortExpression="Cantidad"></asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                            <asp:GridView class="table table-striped table-bordered" ID="GridViewClientes" runat="server"
                                                AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="SqlDataSourceFrecuentes">
                                                <Columns>
                                                    <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" SortExpression="id">
                                                        <ControlStyle Font-Bold="True" />
                                                        <ItemStyle Font-Bold="True" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" ReadOnly="True" SortExpression="Nombre"></asp:BoundField>
                                                    <asp:BoundField DataField="Apellido" HeaderText="Apellido" ReadOnly="True" SortExpression="Apellido"></asp:BoundField>
                                                    <asp:BoundField DataField="Compras" HeaderText="Compras" ReadOnly="True" SortExpression="Compras"></asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                            <asp:GridView class="table table-striped table-bordered" ID="GridViewGanancias" runat="server"
                                                AutoGenerateColumns="False" DataKeyNames="fechaFactura" DataSourceID="SqlDataSourceGanancias">
                                                <Columns>
                                                    <asp:BoundField DataField="fechaFactura" HeaderText="Fecha" ReadOnly="True" SortExpression="fechaFactura">                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="nombreSucursal" HeaderText="Sucursal" ReadOnly="True" SortExpression="Sucursal"></asp:BoundField>
                                                    <asp:BoundField DataField="nombreProducto" HeaderText="Producto" ReadOnly="True" SortExpression="Producto"></asp:BoundField>
                                                    <asp:BoundField DataField="MontoTotal" HeaderText="MontoTotal" ReadOnly="True" SortExpression="MontoTotal"></asp:BoundField>
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
    </div>
    <br>
</asp:Content>
