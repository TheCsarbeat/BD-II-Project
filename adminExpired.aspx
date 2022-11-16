<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="adminExpired.aspx.cs" Inherits="indioSupermercado.adminExpired" %>

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
                                    <h4>Remove Expired Products</h4>
                                </center>
                            </div>
                        </div>
                        <div class="row m-4">
                            <div class="col">
                                <center>
                                    <img width="200px" src="img/expired.png" />
                                </center>
                            </div>
                        </div>
                        <div class="row justify-content-center">
                            <div class="col-4 text-center">
                                <asp:Button ID="ButtonRemoveExpired" class="btn btn-lg btn-block btn-warning" runat="server" Text="Remove Expired" OnClick="ButtonRemoveExpired_Click" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <hr>
                            </div>
                        </div>
                    </div>
                </div>
                <%--card--%>
                <a href="homepage.aspx"><< Back to Home</a><br>
                <br>
            </div>
            <div class="col-md-7">
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col">
                                <center>
                                    <h4>Expired Products</h4>
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
                            <asp:SqlDataSource ID="sqlDataSourceExpired" runat="server"
                                ConnectionString="" SelectCommand="exec spShowExpiredProducts"></asp:SqlDataSource>
                            <div class="col">
                                <asp:ScriptManager ID="ScriptManager1" runat="server">
                                </asp:ScriptManager>
                                <asp:UpdatePanel ID="UpdatePanelExpired" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <asp:GridView class="table table-striped table-bordered" ID="expiredGridview" runat="server"
                                            AutoGenerateColumns="False" DataKeyNames="idProducto" DataSourceID="sqlDataSourceExpired">
                                            <Columns>
                                                <asp:BoundField DataField="idProducto" HeaderText="IDProducto" ReadOnly="True" SortExpression="idProducto">
                                                    <ControlStyle Font-Bold="True" />
                                                    <ItemStyle Font-Bold="True" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="idInventario" HeaderText="idInventario" ReadOnly="True" SortExpression="idInventario"></asp:BoundField>
                                                <asp:BoundField DataField="nombreProducto" HeaderText="Nombre" ReadOnly="True" SortExpression="Nombre"></asp:BoundField>
                                                <asp:BoundField DataField="fechaExpiracion" HeaderText="fechaExpiracion" ReadOnly="True" SortExpression="fechaExpiracion"></asp:BoundField>
                                                <asp:BoundField DataField="cantidadInventario" HeaderText="cantidadInventario" ReadOnly="True" SortExpression="cantidadInventario"></asp:BoundField>
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
                        <%--aqui termina el div del data source--%>
                    </div>
                </div>
                <%--card--%>
            </div>
            <%--second column--%>
        </div>
        <%--main row--%>
    </div>
    <%--container--%>
</asp:Content>
