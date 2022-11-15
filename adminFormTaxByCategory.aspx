<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="adminFormTaxByCategory.aspx.cs" Inherits="indioSupermercado.adminFormTaxByCategory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <script type="text/javascript">
        $(document).ready(function () {

            //$(document).ready(function () {
            //$('.table').DataTable();
            // });

            $(".table").prepend($("<thead></thead>").append($(this).find("tr:first"))).dataTable();
            //$('.table1').DataTable();
        });

        </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <section class="container">
        <h2 class="text-center">Set tax to a Product Category</h2>
    </section>

    
    <section class="container-xxl">
        <div class="row">
            <div class="col-md-5">
                <div class="card">
                    <div class="card-body">

                        <div class="row">
                            <div class="col">
                                <center>
                                    <h4>Taxes by Category</h4>
                                </center>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <center>
                                    <img id="imgview" height="250px" width="250px" src="img/producto.png" />

                                </center>
                            </div>
                        </div>

                        <hr>
                           
                        <%--ID--%>
                        <div class="row">
                            <div class="col">
                                <label>ID</label>
                                <div class="form-group">
                                    <div class="input-group">
                                        <asp:TextBox CssClass="form-control" ID="idtxt" runat="server" placeholder="ID"></asp:TextBox>
                                        <asp:LinkButton class="btn btn-primary" ID="LinkButton1" runat="server"><i class="fas fa-check-circle"></i></asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%--impuesto--%>
                        <div class="row">
                            <div class="col-6">

                                <label>Choose a tax</label>
                                <div class="form-group">
                                    <asp:DropDownList class="form-control" ID="taxDropList" runat="server" OnSelectedIndexChanged="taxDropList_SelectedIndexChanged">
                                    </asp:DropDownList>                                    
                                </div>
                            </div>
                     <%--       <div class="col-6">
                                <asp:Label ID="countryLb" runat="server" Text="Country"></asp:Label>
                                <asp:TextBox CssClass="form-control" ID="countrytxt" runat="server" placeholder="Set tax to see the country" Enabled="False"></asp:TextBox>
                            </div>--%>
                        </div>

                        <%--Category--%>
                        <div class="row">
                            <div class="col">
                                <label>Choose a pproduct category</label>
                                <div class="form-group">
                                    <asp:DropDownList class="form-control" ID="producCategoryDropList" runat="server">
                                    </asp:DropDownList>
                                </div>

                            </div>
                        </div>

                        <%--buttton--%>
                        <div class="row m-4">
                            <div class="col-md-4">
                                <asp:Button ID="insert" class="btn btn-lg btn-block btn-success" runat="server" Text="Insertar" OnClick="insert_Click" />
                            </div>
                            <div class="col-4">
                                <asp:Button ID="update" class="btn btn-lg btn-block btn-warning" runat="server" Text="Actualizar" OnClick="update_Click" />
                            </div>
                            <div class="col-4">
                                <asp:Button ID="delete" class="btn btn-lg btn-block btn-danger" runat="server" Text="Eliminar" OnClick="delete_Click" />
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
                                    <h4>Taxes in a category</h4>
                                </center>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <hr>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">

                                <asp:SqlDataSource ID="sqlDataSourceTaxxCategory" runat="server"
                                    ConnectionString="" SelectCommand="EXEC spGetImpuestoxCategory"></asp:SqlDataSource>
                                <asp:ScriptManager ID="ScriptManager1" runat="server">
                                </asp:ScriptManager>
                                <asp:UpdatePanel ID="updatePanel1" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <asp:GridView class="table table-striped table-bordered" ID="taxGridView" runat="server"
                                            AutoGenerateColumns="False" DataKeyNames="idCategoriaxImpuesto" DataSourceID="sqlDataSourceTaxxCategory">
                                            <Columns>
                                                <asp:BoundField DataField="idCategoriaxImpuesto" HeaderText="ID" ReadOnly="True" SortExpression="idCategoriaxImpuesto">
                                                    <ControlStyle Font-Bold="True" />
                                                    <ItemStyle Font-Bold="True" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="taxName" HeaderText="Impuesto" ReadOnly="True" SortExpression="taxName"></asp:BoundField>
                                                <asp:BoundField DataField="porcentajeImpuesto" HeaderText="PorcentajeImpuesto" ReadOnly="True" SortExpression="porcentajeImpuesto"></asp:BoundField>
                                                <asp:BoundField DataField="nombreCategoria" HeaderText="Categoria" ReadOnly="True" SortExpression="nombreCategoria"></asp:BoundField>
                                                <asp:BoundField DataField="descripcionCategoria" HeaderText="Descripcion" ReadOnly="True" SortExpression="descripcionCategoria"></asp:BoundField>
                                                <asp:BoundField DataField="nombrePais" HeaderText="Pais" ReadOnly="True" SortExpression="nombrePais"></asp:BoundField>

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
