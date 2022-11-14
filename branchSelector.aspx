<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="branchSelector.aspx.cs" Inherits="indioSupermercado.branchSelector" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="container-fluid" style="background-image: var(--fondo-branch-selector);
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  background-attachment: fixed;
  height: 100%;
  width: 100%;
  " >
        <div class="container">
            <div class="d-flex justify-content-center">
                <h2 class="titulo-sucursal">Más cercano</h2>
            </div>
            <div class="row g-1">
                <div class="d-flex justify-content-center">
                <div class="card text-center" style="width: 18rem;">
                  <img class="card-img-top" src="img/supermarkets.png" alt="Card image cap">
                  <div class="card-body">
                    <h5 class="card-title"><%=nombreSucursal%></h5>
                    <a href="productList.aspx?id=<%=idSucursal%>" class="btn btn-primary px-5">Ir</a>
                  </div>
                </div> 
            </div>
            </div>
            <div class="d-flex justify-content-center mt-4 mb-2">
                <h2 class="titulo-sucursal">Otras sucursales</h2>
            </div>
            <asp:Repeater ID="d2" runat="server">
                <HeaderTemplate>
                    <div class="d-flex justify-content-center">
                    <div class="row g-1">
                </HeaderTemplate>
                    <ItemTemplate>

                        <div class="col-md-4 my-3">
                        <div class="card text-center" style="width: 18rem;">
                          <img class="card-img-top" src="img/supermarkets.png" alt="Card image cap">
                          <div class="card-body">
                            <h5 class="card-title "><%#Eval("nombreSucursal")%></h5>
                            <a href="productList.aspx?id=<%#Eval("idSucursal")%>" class="btn btn-primary px-5">Ir</a>
                          </div>
                        </div> 
                    </div>

                    </ItemTemplate>
                <FooterTemplate>
                    </div>
                    </div>
                </FooterTemplate>
            
            </asp:Repeater>

        </div>
    </section>
    
    
</asp:Content>
