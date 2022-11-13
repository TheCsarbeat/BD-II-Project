<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="branchSelector.aspx.cs" Inherits="indioSupermercado.branchSelector" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section>
        <div class="container">
            <div class="d-flex justify-content-center">
                <h2>Más cercano</h2>
            </div>
            <div class="row g-1">
                <div class="d-flex justify-content-center">
                <div class="card" style="width: 18rem;">
                  <img class="card-img-top" src="img/supermarkets.png" alt="Card image cap">
                  <div class="card-body">
                    <h5 class="card-title"><%=nombreSucursal%></h5>
                    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                    <a href="productList.aspx?id=<%=idSucursal%>" class="btn btn-primary">Ir</a>
                  </div>
                </div> 
            </div>
            </div>
            <div class="d-flex justify-content-center mt-4 mb-2">
                <h2>Otras sucursales</h2>
            </div>
            <asp:Repeater ID="d2" runat="server">
                <HeaderTemplate>
                    <div class="row g-1">
                </HeaderTemplate>
                    <ItemTemplate>

                        <div class="col-md-4">
                        <div class="card" style="width: 18rem;">
                          <img class="card-img-top" src="img/supermarkets.png" alt="Card image cap">
                          <div class="card-body">
                            <h5 class="card-title"><%#Eval("nombreSucursal")%></h5>
                            <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                            <a href="productList.aspx?id=<%#Eval("idSucursal")%>" class="btn btn-primary">Ir</a>
                          </div>
                        </div> 
                    </div>

                    </ItemTemplate>
                <FooterTemplate>
                    </div>
                </FooterTemplate>
            
            
            </asp:Repeater>

        </div>
    </section>
    
    
</asp:Content>
