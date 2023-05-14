<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="adminFormManager.aspx.cs" Inherits="indioSupermercado.adminFormManager" %>

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
                                    <h4>Manager Per Branch Details</h4>
                                </center>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <center>
                                    <img width="100px" src="img/manager.png" />
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
                                <label>ID Manager Per Branch</label>
                                <div class="form-group">
                                    <div class="input-group">
                                        <asp:TextBox CssClass="form-control" ID="TextBoxMB" runat="server" placeholder="ID Manager branch"></asp:TextBox>

                                    </div>
                                </div>
                            </div>
                            <div class="col-md-8">
                                <label>Branch</label>
                                <div class="form-group">
                                    <asp:DropDownList class="form-control" ID="sucursalDropList" runat="server">
                                    </asp:DropDownList>
                                </div>
                            </div>

                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <label>Employee</label>
                                <div class="form-group">
                                    <asp:DropDownList class="form-control" ID="employeeDropList" runat="server">
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>

                        <div class="row m-4">
                            <div class="col-md-6">
                                <asp:Button ID="ButtonAgregarManager" class="btn btn-lg btn-block btn-success" runat="server" Text="Insert" OnClick="ButtonAgregarManager_Click" />
                            </div>
                            <div class="col-md-6">
                                <asp:Button ID="ButtonActualizarManager" class="btn btn-lg btn-block btn-warning" runat="server" Text="Update" OnClick="ButtonActualizarManager_Click" />
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
                                    <h4>List of Managers Per Branch</h4>
                                </center>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <hr>
                            </div>
                        </div>
                        <div class="row">
                            <asp:SqlDataSource ID="SqlDataSourceManager" runat="server"
                                ConnectionString="" SelectCommand="exec spSelectManagerToView"></asp:SqlDataSource>
                            <div class="col">
                                <asp:ScriptManager ID="ScriptManager1" runat="server">
                                </asp:ScriptManager>
                                <asp:UpdatePanel ID="UpdatePanelManager" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <asp:GridView class="table table-striped table-bordered" ID="GridViewManager" runat="server"
                                            AutoGenerateColumns="False" DataKeyNames="idSucursalManager" DataSourceID="SqlDataSourceManager">
                                            <Columns>
                                                <asp:BoundField DataField="idSucursalManager" HeaderText="ID" ReadOnly="True" SortExpression="empleadoID">
                                                    <ControlStyle Font-Bold="True" />
                                                    <ItemStyle Font-Bold="True" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Sucursal" HeaderText="Branch" ReadOnly="True" SortExpression="Sucursal"></asp:BoundField>
                                                <asp:BoundField DataField="Empleado" HeaderText="Employee" ReadOnly="True" SortExpression="Empleado"></asp:BoundField>
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
