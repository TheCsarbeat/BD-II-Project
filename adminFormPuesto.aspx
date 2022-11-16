<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="adminFormPuesto.aspx.cs" Inherits="indioSupermercado.adminFormPuesto" %>

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
                                    <h4>Position Details</h4>
                                </center>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <center>
                                    <img width="100px" src="img/position.png" />
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
                                <label>ID Position</label>
                                <div class="form-group">
                                    <div class="input-group">
                                        <asp:TextBox CssClass="form-control" ID="TextBoxPosition" runat="server" placeholder="ID Position"></asp:TextBox>

                                    </div>
                                </div>
                            </div>
                            <div class="col-md-8">
                                <label>Position name</label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="TextBoxPositionName" runat="server" placeholder="Position Name"></asp:TextBox>
                                </div>
                            </div>

                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <label>Salary</label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="TextBoxSalary" runat="server" placeholder="Salary"></asp:TextBox>
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
                                <asp:Button ID="ButtonAgregarPuesto" class="btn btn-lg btn-block btn-success" runat="server" Text="Insert" OnClick="ButtonAgregarPuesto_Click" />
                            </div>
                            <div class="col-4">
                                <asp:Button ID="ButtonActualizarPuesto" class="btn btn-lg btn-block btn-warning" runat="server" Text="Update" OnClick="ButtonActualizarPuesto_Click" />
                            </div>
                            <div class="col-4">
                                <asp:Button ID="ButtonBorrarPuesto" class="btn btn-lg btn-block btn-danger" runat="server" Text="Delete" OnClick="ButtonBorrarPuesto_Click" />
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
                                    <h4>List of Positions</h4>
                                </center>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <hr>
                            </div>
                        </div>
                        <div class="row">
                            <asp:SqlDataSource ID="SqlDataSourcePositions" runat="server"
                                ConnectionString="" SelectCommand="exec spSelectPuestoToView"></asp:SqlDataSource>
                            <div class="col">
                                <asp:ScriptManager ID="ScriptManager1" runat="server">
                                </asp:ScriptManager>
                                <asp:UpdatePanel ID="UpdatePanelPositions" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <asp:GridView class="table table-striped table-bordered" ID="GridViewPosition" runat="server"
                                            AutoGenerateColumns="False" DataKeyNames="idPuesto" DataSourceID="SqlDataSourcePositions">
                                            <Columns>
                                                <asp:BoundField DataField="idPuesto" HeaderText="ID" ReadOnly="True" SortExpression="empleadoID">
                                                    <ControlStyle Font-Bold="True" />
                                                    <ItemStyle Font-Bold="True" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Nombre" HeaderText="Name" ReadOnly="True" SortExpression="Nombre"></asp:BoundField>
                                                <asp:BoundField DataField="Salario" HeaderText="Salary" ReadOnly="True" SortExpression="Salary"></asp:BoundField>
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
