<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="productList.aspx.cs" Inherits="indioSupermercado.productList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="js/scripts.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    
    
    
    
    
    
    <asp:Button ID="Button1" runat="server" Text="Button" />
    
    
    
    
    
    
    
    <asp:Repeater ID="Repeater1" runat="server">

    </asp:Repeater>
    
    
    
    
    
    
    
    <asp:Repeater ID="d1" runat="server" OnItemCommand="d1_ItemCommand">
        <HeaderTemplate>
        <div class="wrapper">
        <div class="container">
        <div class="row g-1">

        </HeaderTemplate>
        <ItemTemplate>

                <div class="col-md-3">

                <div class="card p-3">

                    <div class="text-center">

                        <img src="<%#Eval("imgPath")%>" width="200" height="200">
                        
                    </div>

                    <div class="product-details">


                         <span class="font-weight-bold d-block"></span>
                         <span><%#Eval("nombreProducto")%></span>


                         <div class="buttons d-flex flex-row">
                            <div class="cart"><i class="fa fa-shopping-cart"></i></div> <asp:button id="<%#Eval("nombreProducto")%>" class="btn btn-success cart-button btn-block"><span class="dot">1</span>Add to cart >
                             
                        </div>

                         <div class="weight">

                            <small>1 piece 2.5kg</small>
                                                         
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
