<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="homePage.aspx.cs" Inherits="indioSupermercado.homepage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section>
    <img src="img/home-bg.jpg" class="img-fluid"/>
 </section>
    <section>
    <div class="container">
       <div class="row">
          <div class="col-12">
             <center>
                <h2>Our Features</h2>
                <p><b>Our 3 Primary Features -</b></p>
             </center>
          </div>
       </div>
       <div class="row">
          <div class="col-md-4">
             <center>
                <img width="150px" src="img/digital-inventory.png"/>
                <h4>Digital Book Inventory</h4>
                <p class="text-justify">Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Lorem ipsum dolor. reprehenderit</p>
             </center>
          </div>
          <div class="col-md-4">
             <center>
                <img width="150px" src="img/search-online.png"/>
                <h4>Search Books</h4>
                <p class="text-justify">Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Lorem ipsum dolor. reprehenderit</p>
             </center>
          </div>
          <div class="col-md-4">
             <center>
                <img width="150px" src="img/defaulters-list.png"/>
                <h4>Defaulter List</h4>
                <p class="text-justify">Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Lorem ipsum dolor. reprehenderit</p>
             </center>
          </div>
       </div>
    </div>
 </section>
     <section>
    <img src="img/in-homepage-banner.jpg" class="img-fluid"/>
 </section>

</asp:Content>
