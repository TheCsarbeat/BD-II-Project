<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="productList.aspx.cs" Inherits="indioSupermercado.productList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="js/scripts.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="col-md-3">

            <div class="card p-3 card-product">

                <div class="product-details row">

                    <div class="col">
                        <div class="cart col"><center><i class="fa-2xl fa fa-shopping-cart"></i></center></div>
                        <asp:Label class="font-weight-bold d-block col" ID="shoppingLb" Font-Names="Verdana"  ForeColor="Green" Font-Size="10pt" runat="server" />
    
                    </div>
                    <div class="col buttons d-flex flex-row">
                        <asp:Button ID="finisPurchasebtn" class="btn btn-success cart-button btn-block"
                            Text="Finish Purchase" runat="server" OnClick="finisPurchasebtn_Click" />
                    </div>
                </div>
            </div>
        </div>
         
       <asp:Repeater id="Repeater1" OnItemCommand="R1_ItemCommand" runat="server">
          <HeaderTemplate>
             <div class="wrapper">
            <div class="container">
            <div class="row g-1">
          </HeaderTemplate>
             
          <ItemTemplate>
              <div class="col-md-3">
                <div class="card p-3 card-product">
                    <div class="text-center">
                        <img src="<%#Eval("imgPath")%>" width="200" height="200">
                    </div>
                    <div class="product-details">
                         <span class="font-weight-bold d-block">₡ <%# DataBinder.Eval(Container.DataItem, "precioVenta") %> </span>
                         <span><%#Eval("nombreProducto")%></span>
                         <div class="buttons d-flex flex-row">
                            <div class="cart"><i class="fa fa-shopping-cart"></i></div>  
                            <asp:Button class="btn btn-success cart-button"
                            CommandName='<%# DataBinder.Eval(Container.DataItem, "nombreProducto") +","+ DataBinder.Eval(Container.DataItem, "precioVenta")+","+
                                    DataBinder.Eval(Container.DataItem, "imgPath")+","+DataBinder.Eval(Container.DataItem, "descripcionProducto") +","+
                                DataBinder.Eval(Container.DataItem, "idSucursal" )+","+DataBinder.Eval(Container.DataItem, "idProducto") %>' 
                            CommandArgument='<%# DataBinder.Eval(Container.DataItem, "idLote") %>  ' 
                            Text="Add to Cart" runat="server" />
                        </div>
                         <div class="weight">
                            <small><%#Eval("descripcionProducto")%></small>                             
                         </div>
                        </div>

                    </div>
                </div>    
          </ItemTemplate>
          <FooterTemplate>
             </div>
            </div>
          </div>
          </FooterTemplate>   
       </asp:Repeater>
</asp:Content>
