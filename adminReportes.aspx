<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="adminReportes.aspx.cs" Inherits="indioSupermercado.adminReportes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
      $(document).ready(function () {
      
          //$(document).ready(function () {
              //$('.table').DataTable();
         // });
      
          $(".table").prepend($("<thead></thead>").append($(this).find("tr:first"))).dataTable();
          //$('.table1').DataTable();
      });

    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#imgview').attr('src', e.target.result);
            };

            reader.readAsDataURL(input.files[1]);
        }
    }
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
      <div class="row">
         <div class="col">
             <div align="center">
                <asp:Button ID="ButtonBono" class="btn btn-lg btn-block btn-secondary" runat="server" Text="Reporte Bonos" OnClick="ButtonReporteBono" />
                 <asp:Button ID="Button1" class="btn btn-lg btn-block btn-secondary" runat="server" Text="Reporte Mas Vendidos" />
                 <asp:Button ID="Button2" class="btn btn-lg btn-block btn-secondary" runat="server" Text="Reporte Clientes" />
                 <asp:Button ID="Button4" class="btn btn-lg btn-block btn-secondary" runat="server" Text="Reporte Expirados" />
                 <asp:Button ID="Button3" class="btn btn-lg btn-block btn-secondary" runat="server" Text="Reporte Ganancias" />
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

                          <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                              ConnectionString="" SelectCommand="exec reporteBonos"></asp:SqlDataSource>
                         <div class="col">
                              <asp:ScriptManager ID="ScriptManagerCliente" runat="server">
                                </asp:ScriptManager>
                             <asp:UpdatePanel ID="UpdatePanelCliente" runat="server" UpdateMode="Conditional">
                                 <ContentTemplate>
                                    <asp:GridView class="table table-striped table-bordered" ID="GridViewReporteBono" runat="server"
                                        AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="SqlDataSource1" >
                                            <Columns>
                                                <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" SortExpression="id">
                                                    <ControlStyle Font-Bold="True" />
                                                    <ItemStyle Font-Bold="True" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Nombre" HeaderText="Nombre" ReadOnly="True" SortExpression="Nombre"></asp:BoundField>
                                                <asp:BoundField DataField="NombreBono" HeaderText="NombreBono" ReadOnly="True" SortExpression="NombreBono"></asp:BoundField>
                                                <asp:BoundField DataField="TipoBono" HeaderText="NombreBono" ReadOnly="True" SortExpression="TipoBono"></asp:BoundField>
                                                <asp:BoundField DataField="Monto" HeaderText="NombreBono" ReadOnly="True" SortExpression="Monto"></asp:BoundField>
                                                <asp:BoundField DataField="Descripcion" HeaderText="NombreBono" ReadOnly="True" SortExpression="Descripcion"></asp:BoundField>
                                               
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
