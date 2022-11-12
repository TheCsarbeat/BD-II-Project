<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="indioSupermercado.WebForm2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="js/scripts.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <asp:Repeater ID="d1" runat="server">
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


                         <span class="font-weight-bold d-block">$ 7.00</span>
                         <span><%#Eval("nombreProducto")%></span>


                         <div class="buttons d-flex flex-row">
                            <div class="cart"><i class="fa fa-shopping-cart"></i></div> <button class="btn btn-success cart-button btn-block"><span class="dot">1</span>Add to cart </button>
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
