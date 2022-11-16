<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="adminFormTipoCambio.aspx.cs" Inherits="indioSupermercado.adminFormTipoCambio" %>

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
                                    <h4>Exchange rate Details</h4>
                                </center>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <center>
                                    <img width="100px" src="img/exchange.png" />
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
                                <label>ID Coin X Country</label>
                                <div class="form-group">
                                    <div class="input-group">
                                        <asp:TextBox CssClass="form-control" ID="TextBoxIDMonedaXPais" runat="server" placeholder="ID Coin X Country"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-8">
                                <label>Coin</label>
                                <div class="form-group">
                                    <asp:DropDownList class="form-control" ID="monedaDropDownList" runat="server">
                                    </asp:DropDownList>
                                </div>
                            </div>

                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <label>Country</label>
                                <div class="form-group">
                                    <asp:DropDownList class="form-control" ID="paisDropList" runat="server">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label>Exchange porcentage</label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="cambioPorcentajeTxt" runat="server" placeholder="Exchange porcentage"></asp:TextBox>
                                </div>
                            </div>

                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <label>Status</label>
                                <div class="form-group">
                                    <asp:DropDownList class="form-control" ID="DropDownListEstado" runat="server">
                                        <asp:ListItem Text="Active" Value="1" />
                                        <asp:ListItem Text="Inactive" Value="0" />
                                        <asp:ListItem Text="Suspended" Value="2" />

                                    </asp:DropDownList>
                                </div>
                            </div>

                        </div>

                        <div class="row m-4">
                            <div class="col-md-4">
                                <asp:Button ID="ButtonAgregarExchange" class="btn btn-lg btn-block btn-success" runat="server" Text="Insert" OnClick="ButtonAgregarExchange_Click" />
                            </div>
                            <div class="col-4">
                                <asp:Button ID="ButtonActualizarExchange" class="btn btn-lg btn-block btn-warning" runat="server" Text="Update" OnClick="ButtonActualizarExchange_Click" />
                            </div>
                            <div class="col-4">
                                <asp:Button ID="ButtonBorrarExchange" class="btn btn-lg btn-block btn-danger" runat="server" Text="Delete" OnClick="ButtonBorrarExchange_Click" />
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
                                    <h4>List of Exchange rates</h4>
                                </center>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <hr>
                            </div>
                        </div>
                        <div class="row">
                            <asp:SqlDataSource ID="SqlDataSourceExchange" runat="server"
                                ConnectionString="" SelectCommand="exec spSelectExchangeToView"></asp:SqlDataSource>
                            <div class="col">
                                <asp:ScriptManager ID="ScriptManager1" runat="server">
                                </asp:ScriptManager>
                                <asp:UpdatePanel ID="UpdatePanelExchange" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <asp:GridView class="table table-striped table-bordered" ID="GridViewExchange" runat="server"
                                            AutoGenerateColumns="False" DataKeyNames="idMonedaXPais" DataSourceID="SqlDataSourceExchange">
                                            <Columns>
                                                <asp:BoundField DataField="idMonedaXPais" HeaderText="ID" ReadOnly="True" SortExpression="empleadoID">
                                                    <ControlStyle Font-Bold="True" />
                                                    <ItemStyle Font-Bold="True" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Porcentaje" HeaderText="Exchange rate" ReadOnly="True" SortExpression="Porcentaje"></asp:BoundField>
                                                <asp:BoundField DataField="Moneda" HeaderText="Coin" ReadOnly="True" SortExpression="Moneda"></asp:BoundField>
                                                <asp:BoundField DataField="Pais" HeaderText="Country" ReadOnly="True" SortExpression="Pais"></asp:BoundField>

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
