<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="productList.aspx.cs" Inherits="indioSupermercado.productList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="js/scripts.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    
    
    
     <asp:Label id="Label2" font-names="Verdana" ForeColor="Green" font-size="10pt" runat="server"/>

         
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


                         <span class="font-weight-bold d-block">$ <%# DataBinder.Eval(Container.DataItem, "precioVenta") %> </span>
                         <span><%#Eval("nombreProducto")%></span>


                         <div class="buttons d-flex flex-row">
                            <div class="cart"><i class="fa fa-shopping-cart"></i></div>
                            
                             
                             <ASP:Button class="btn btn-success cart-button btn-block" 
                                 CommandArgument=<%# DataBinder.Eval(Container.DataItem, "idLote") %> Text="Add to Cart" runat="server" />
                        </div>

                         <div class="weight">

                            <small>1 piece 2.5kg</small>
                                                         
                         </div>

                        </div>
                    </div>
                </div>

             
          </ItemTemplate>
             
          <FooterTemplate>
             </table>
          </FooterTemplate>
             
       </asp:Repeater>
       <br />
         
      
    

</asp:Content>
