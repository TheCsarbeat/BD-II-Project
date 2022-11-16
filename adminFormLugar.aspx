<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="adminFormLugar.aspx.cs" Inherits="indioSupermercado.adminFormLugar" %>

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
                                    <h4>Ubication Details</h4>
                                </center>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <center>
                                    <img width="100px" src="img/lugar.png" />
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
                                <label>ID Ubication</label>
                                <div class="form-group">
                                    <div class="input-group">
                                        <asp:TextBox CssClass="form-control" ID="TextBoxIDLugar" runat="server" placeholder="ID Lugar"></asp:TextBox>
                                        <%--<asp:LinkButton class="btn btn-primary" ID="LinkButton4" runat="server" OnClick="LinkButton4_Click"><i class="fas fa-check-circle"></i></asp:LinkButton>--%>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-8">
                                <label>Ubication name</label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="TextBoxNombreLugar" runat="server" placeholder="Ubication name"></asp:TextBox>
                                </div>
                            </div>

                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <label>Longitude</label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="TextBoxLongitud" runat="server" placeholder="Longitude"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label>Latitude</label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="txtLatitud" runat="server" placeholder="Latitude"></asp:TextBox>

                                </div>
                            </div>

                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <label>Status</label>
                                <div class="form-group">
                                    <asp:DropDownList class="form-control" ID="DropDownListStatusLugar" runat="server">
                                        <asp:ListItem Text="Active" Value="1" />
                                        <asp:ListItem Text="Inactive" Value="0" />
                                        <asp:ListItem Text="Suspended" Value="2" />

                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label>Country</label>
                                <div class="form-group">
                                    <asp:DropDownList class="form-control" ID="paisDropList" runat="server">
                                    </asp:DropDownList>

                                </div>
                            </div>

                        </div>

                        <div class="row m-4">
                            <div class="col-md-4">
                                <asp:Button ID="ButtonAgregarLugar" class="btn btn-lg btn-block btn-success" runat="server" Text="Insert" OnClick="ButtonAgregarLugar_Click" />
                            </div>
                            <div class="col-4">
                                <asp:Button ID="ButtonActualizarLugar" class="btn btn-lg btn-block btn-warning" runat="server" Text="Update" OnClick="ButtonActualizarLugar_Click" />
                            </div>
                            <div class="col-4">
                                <asp:Button ID="ButtonBorrarLugar" class="btn btn-lg btn-block btn-danger" runat="server" Text="Delete" OnClick="ButtonBorrarLugar_Click" />
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
                                    <h4>List of Ubications</h4>
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
                            <asp:SqlDataSource ID="SqlDataSourceLugar" runat="server"
                                ConnectionString="" SelectCommand="exec spSelectLugarToView"></asp:SqlDataSource>
                            <div class="col">
                                <asp:ScriptManager ID="ScriptManager1" runat="server">
                                </asp:ScriptManager>
                                <asp:UpdatePanel ID="UpdatePanelLugar" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <asp:GridView class="table table-striped table-bordered" ID="GridViewLugar" runat="server"
                                            AutoGenerateColumns="False" DataKeyNames="idLugar" DataSourceID="SqlDataSourceLugar">
                                            <Columns>
                                                <asp:BoundField DataField="idLugar" HeaderText="ID" ReadOnly="True" SortExpression="empleadoID">
                                                    <ControlStyle Font-Bold="True" />
                                                    <ItemStyle Font-Bold="True" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Nombre" HeaderText="Name" ReadOnly="True" SortExpression="Nombre"></asp:BoundField>
                                                <asp:BoundField DataField="Pais" HeaderText="Country" ReadOnly="True" SortExpression="Pais"></asp:BoundField>


                                            </Columns>
                                        </asp:GridView>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                        <%--aqui termina el div del data source--%>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
