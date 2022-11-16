<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="adminDiscount.aspx.cs" Inherits="indioSupermercado.adminDiscount" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
                           <h4>Discounts</h4>
                        </center>
                     </div>
                  </div>
                  <div class="row m-4">
                     <div class="col">
                        <center>
                           <img width="200px" src="img/discount.png" />
                        </center>
                     </div>
                  </div>
                   <div class="row justify-content-between">
                     <div class="col-4">
                         <h4>Current Active Discount: <%=currentDiscount%> %</h4>
                     </div>
                     <div class="col-4">
                          <asp:Button ID="ButtonApplyDiscount" class="btn btn-lg btn-block btn-warning" runat="server" Text="Apply" OnClick="ButtonApplyDiscount_Click" />
                     </div>
                  </div>
                  <div class="row">
                     <div class="col">
                        <hr>
                     </div>
                  </div>
                  
                  <div class="row">
                     <div class="col-md-8">
                        <label>Discount</label>
                        <div class="form-group">
                           <asp:TextBox CssClass="form-control" ID="TextDiscount" runat="server" placeholder="0.0..." ></asp:TextBox>
                        </div>
                     </div>
                  </div>
                 
                  <div class="row m-4">
                      <div class="col">
                          <asp:Button ID="ButtonUpdateDiscount" class="btn btn-lg btn-block btn-success" runat="server" Text="Update" OnClick="ButtonUpdateDiscount_Click" />
                     </div>
                  </div>
               </div>
            </div> <%--card--%>
            <a href="homepage.aspx"><< Back to Home</a><br>
            <br>
         </div>
         <div class="col-md-7">
            <div class="card">
               <div class="card-body">
                  <div class="row">
                     <div class="col">
                        <center>
                           <h4>Products with Discount</h4>
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
                      <asp:SqlDataSource ID="sqlDataSourceDiscount" runat="server" 
                          ConnectionString="" SelectCommand="exec spShowProductsDiscount"></asp:SqlDataSource>
                      <div class="col">
                         <asp:ScriptManager ID="ScriptManager1" runat="server">
                            </asp:ScriptManager>
                         <asp:UpdatePanel ID="UpdatePanelDiscount" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:GridView class="table table-striped table-bordered" ID="discountGridview" runat="server"
                                    AutoGenerateColumns="False" DataKeyNames="idProducto" DataSourceID="sqlDataSourceDiscount" >
                                        <Columns>
                                            <asp:BoundField DataField="idProducto" HeaderText="IDProducto" ReadOnly="True" SortExpression="productosID">
                                                    <ControlStyle Font-Bold="True" />
                                                    <ItemStyle Font-Bold="True" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="idInventario" HeaderText="idInventario" ReadOnly="True" SortExpression="idInventario"></asp:BoundField>
                                                <asp:BoundField DataField="nombreProducto" HeaderText="Nombre" ReadOnly="True" SortExpression="Nombre"></asp:BoundField>
                                                <asp:BoundField DataField="precioVenta" HeaderText="Precio" ReadOnly="True" SortExpression="Precio"></asp:BoundField>
                                                <asp:BoundField DataField="cantidadInventario" HeaderText="Cantidad" ReadOnly="True" SortExpression="Cantidad"></asp:BoundField>
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
            </div><%--card--%>
         </div> <%--second column--%>
      </div><%--main row--%>
   </div> <%--container--%>


</asp:Content>
