<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="adminFormHorario.aspx.cs" Inherits="indioSupermercado.adminFormHorario" %>

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
                                    <h4>Schedule Details</h4>
                                </center>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <center>
                                    <img width="100px" src="img/calendario.png" />
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
                                <label>ID Schedule</label>
                                <div class="form-group">
                                    <div class="input-group">
                                        <asp:TextBox CssClass="form-control" ID="TextBoxIDSchedule" runat="server" placeholder="ID Schedule"></asp:TextBox>
                                        <%--<asp:LinkButton class="btn btn-primary" ID="LinkButton4" runat="server" OnClick="LinkButton4_Click"><i class="fas fa-check-circle"></i></asp:LinkButton>--%>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-8">
                                <label>Starting hour</label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="TextBoxSTime" runat="server" placeholder="Starting time" TextMode="Time"></asp:TextBox>
                                </div>
                            </div>

                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <label>Finishing hour</label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="TextBoxFTime" runat="server" placeholder="Finishing time" TextMode="Time"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label>Day</label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="TextBoxDia" runat="server" placeholder="Dia"></asp:TextBox>
                                </div>
                            </div>

                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <label>Status</label>
                                <div class="form-group">
                                    <asp:DropDownList class="form-control" ID="DropDownListEstado" runat="server">
                                        <asp:ListItem Text="Active" Value="1" />
                                        <asp:ListItem Text="Inactive" Value="0" />
                                        <asp:ListItem Text="Suspended" Value="2" />

                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label>Branch</label>
                                <div class="form-group">
                                    <asp:DropDownList class="form-control" ID="sucursalDropList" runat="server">
                                    </asp:DropDownList>
                                </div>
                            </div>

                        </div>

                        <div class="row m-4">
                            <div class="col-md-4">
                                <asp:Button ID="ButtonAgregarBranch" class="btn btn-lg btn-block btn-success" runat="server" Text="Insert" OnClick="ButtonAgregarBranch_Click" />
                            </div>
                            <div class="col-4">
                                <asp:Button ID="ButtonActualizarBranch" class="btn btn-lg btn-block btn-warning" runat="server" Text="Update" OnClick="ButtonActualizarBranch_Click" />
                            </div>
                            <div class="col-4">
                                <asp:Button ID="ButtonBorrarBranch" class="btn btn-lg btn-block btn-danger" runat="server" Text="Delete" OnClick="ButtonBorrarBranch_Click" />
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
                                    <h4>List of Schedules</h4>
                                </center>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <hr>
                            </div>
                        </div>
                        <div class="row">
                            <asp:SqlDataSource ID="SqlDataSourceSchedule" runat="server"
                                ConnectionString="" SelectCommand="exec spSelectHorarioToView"></asp:SqlDataSource>
                            <div class="col">
                                <asp:ScriptManager ID="ScriptManager1" runat="server">
                                </asp:ScriptManager>
                                <asp:UpdatePanel ID="UpdatePanelSchedule" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <asp:GridView class="table table-striped table-bordered" ID="GridViewSchedule" runat="server"
                                            AutoGenerateColumns="False" DataKeyNames="idHorario" DataSourceID="SqlDataSourceSchedule">
                                            <Columns>
                                                <asp:BoundField DataField="idHorario" HeaderText="ID" ReadOnly="True" SortExpression="empleadoID">
                                                    <ControlStyle Font-Bold="True" />
                                                    <ItemStyle Font-Bold="True" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="horaInicial" HeaderText="Start time" ReadOnly="True" SortExpression="horaInicial"></asp:BoundField>
                                                <asp:BoundField DataField="horaFinal" HeaderText="Finish time" ReadOnly="True" SortExpression="horaFinal"></asp:BoundField>
                                                <asp:BoundField DataField="dia" HeaderText="Day" ReadOnly="True" SortExpression="dia"></asp:BoundField>
                                                <asp:BoundField DataField="nombreSucursal" HeaderText="Branch" ReadOnly="True" SortExpression="Sucursal"></asp:BoundField>
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
