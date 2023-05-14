<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="adminCategoria.aspx.cs" Inherits="indioSupermercado.adminCategoria" %>
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
                                    <h4>Product Category</h4>
                                </center>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <center>
                                    <img width="200px" src="img/pCategory.png" />
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
                                <label>ID Category</label>
                                <div class="form-group">
                                    <div class="input-group">
                                        <asp:TextBox CssClass="form-control" ID="TextBoxIDPaymentMethod" runat="server" placeholder="ID Category"></asp:TextBox>

                                    </div>
                                </div>
                            </div>
                            <div class="col-md-8">
                                <label>Category name</label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="TextBoxPaymentMethodName" runat="server" placeholder="Category name"></asp:TextBox>
                                </div>
                            </div>

                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <label>Category description</label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="otroDetailsTXT" runat="server" placeholder="Description"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <div class="row m-4">
                            <div class="col-md-4">
                                <asp:Button ID="ButtonAgregarCategoria" class="btn btn-lg btn-block btn-success" runat="server" Text="Insert" OnClick="ButtonAgregarCategoria_Click"/>
                            </div>
                            <div class="col-4">
                                <asp:Button ID="ButtonActualizarCategoria" class="btn btn-lg btn-block btn-warning" runat="server" Text="Update" OnClick="ButtonActualizarCategoria_Click"/>
                            </div>
                            <div class="col-4">
                                <asp:Button ID="ButtonBorrarCategoria" class="btn btn-lg btn-block btn-danger" runat="server" Text="Delete" OnClick="ButtonBorrarCategoria_Click"/>
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
                                    <h4>List of Categories</h4>
                                </center>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <hr>
                            </div>
                        </div>
                        <div class="row">
                            <asp:SqlDataSource ID="SqlDataSourceCategoria" runat="server"
                                ConnectionString="" SelectCommand="exec spSelectCategoryToView"></asp:SqlDataSource>
                            <div class="col">
                                <asp:ScriptManager ID="ScriptManager1" runat="server">
                                </asp:ScriptManager>
                                <asp:UpdatePanel ID="UpdatePanelCategoria" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <asp:GridView class="table table-striped table-bordered" ID="GridViewCategoria" runat="server"
                                            AutoGenerateColumns="False" DataKeyNames="idCategoria" DataSourceID="SqlDataSourceCategoria">
                                            <Columns>
                                                <asp:BoundField DataField="idCategoria" HeaderText="ID" ReadOnly="True" SortExpression="idCategoria">
                                                    <ControlStyle Font-Bold="True" />
                                                    <ItemStyle Font-Bold="True" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="nombreCategoria" HeaderText="Name" ReadOnly="True" SortExpression="Name"></asp:BoundField>
                                                <asp:BoundField DataField="descripcionCategoria" HeaderText="Description" ReadOnly="True" SortExpression="Description"></asp:BoundField>

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
