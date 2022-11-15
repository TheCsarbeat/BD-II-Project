<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="payOrder.aspx.cs" Inherits="indioSupermercado.payOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="bootstrap/mdb/css/css.css" rel="stylesheet" />
    <link href="bootstrap/mdb/css/mdb.min.css" rel="stylesheet" />
    <script src="bootstrap/mdb/js/mdb.min.js"></script>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-fluid">
        <section class="" style="background-color: #eee;">
            <div class="container py-5 ">
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col">
                        <div class="card">
                            <div class="card-body p-4">

                                <div class="row">

                                    <div class="col-lg-7">


                                        <h5 class="mb-3"><a href="productList.aspx" class="text-body"><i
                                            class="fas fa-long-arrow-alt-left me-2"></i>Continue shopping</h5>

                                        <hr>
                                        <div class="d-flex justify-content-between align-items-center mb-4">
                                            <div>
                                                <p class="mb-1">Shopping cart</p>
                                                <p class="mb-0">You have 4 items in your cart</p>
                                            </div>
                                            <div>
                                                <p class="mb-0">
                                                    <span class="text-muted">Sort by:</span> <a href="#!"
                                                        class="text-body">price <i class="fas fa-angle-down mt-1"></i></a>
                                                </p>
                                            </div>
                                        </div>

                                        <%--<asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>--%>

                                        <asp:Repeater ID="Repeater1" runat="server">
                                            <HeaderTemplate>
                                            </HeaderTemplate>


                                            <ItemTemplate>
                                                <div class="card mb-3">
                                                    <div class="card-body">
                                                        <div class="d-flex justify-content-between">
                                                            <div class="d-flex flex-row align-items-center">
                                                                <div>
                                                                    <img
                                                                        src="<%# DataBinder.Eval(Container.DataItem, "imgPath") %>"
                                                                        class="img-fluid rounded-3" alt="Shopping item" style="width: 65px;">
                                                                </div>
                                                                <div class="ms-3">
                                                                    <h5><%# DataBinder.Eval(Container.DataItem, "productName") %></h5>
                                                                    <p class="small mb-0"><%# DataBinder.Eval(Container.DataItem, "descriptonProduct") %></p>
                                                                </div>
                                                            </div>
                                                            <div class="d-flex flex-row align-items-center">
                                                                <div style="width: 50px;">
                                                                    <h5 class="fw-normal mb-0"><%# "x"+DataBinder.Eval(Container.DataItem, "cantProduct") %></h5>
                                                                </div>
                                                                <div style="width: 80px;">
                                                                    <h5 class="mb-0"><%# "$ "+DataBinder.Eval(Container.DataItem, "subTotalProduct") %></h5>
                                                                </div>
                                                                <%--TRashButton--%>
                                                                <a href="#!" style="color: #cecece;"><i class="fas fa-trash-alt"></i></a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </ItemTemplate>

                                        </asp:Repeater>
                                        <%--Here the repeater end--%>
                                    </div>

                                    <div class="col-lg-5">
                                        <!-- Tabs navs -->
                                        <ul class="nav nav-tabs mb-3 shop-tab" id="ex1" role="tablist">
                                            <li class="nav-item" role="presentation">
                                                <a
                                                    class="nav-link active"
                                                    id="ex1-tab-1"
                                                    data-mdb-toggle="tab"
                                                    href="#ex1-tabs-1"
                                                    role="tab"
                                                    aria-controls="ex1-tabs-1"
                                                    aria-selected="true">IR A TIENDA</a>
                                            </li>
                                            <li class="nav-item" role="presentation">
                                                <a
                                                    class="nav-link"
                                                    id="ex1-tab-2"
                                                    data-mdb-toggle="tab"
                                                    href="#ex1-tabs-2"
                                                    role="tab"
                                                    aria-controls="ex1-tabs-2"
                                                    aria-selected="false">Pasar a Domicilio</a>
                                            </li>

                                        </ul>
                                        <!-- Tabs navs -->

                                        <!-- Tabs content -->
                                        <div class="tab-content" id="ex1-content">
                                            <div
                                                class="tab-pane fade show active"
                                                id="ex1-tabs-1"
                                                role="tabpanel"
                                                aria-labelledby="ex1-tab-1">
                                                Tab 1 content
                                                
                                               
                                                
                                            </div>
                                            <div class="tab-pane fade" id="ex1-tabs-2" role="tabpanel" aria-labelledby="ex1-tab-2">
                                                <%--inciocuadro azul--%>
                                                <div class="card bg-primary text-white rounded-3 shop-info">
                                                    <div class="card-body">

                                                        <div class="row">
                                                            <div class="d-flex justify-content-between align-items-center mb-4">
                                                                <h5 class="mb-0">Order Details</h5>
                                                                <img src="https://mdbcdn.b-cdn.net/img/Photos/Avatars/avatar-6.webp"
                                                                    class="img-fluid rounded-3" style="width: 45px;" alt="Avatar">
                                                            </div>
                                                        </div>


                                                        <%--Metodopago--%>
                                                        <div class="row ">
                                                            <div class="col">
                                                                <label>Choose a payment Method</label>
                                                                <div class="form-group">
                                                                    <asp:DropDownList class="form-control" ID="paymentMethodDrop" runat="server">
                                                                    </asp:DropDownList>
                                                                </div>

                                                            </div>
                                                        </div>

                                                        <div class="row px-2">
                                                            <div class="form-outline form-white mb-4">
                                                                <input type="text" id="typeText" class="form-control form-control-lg" siez="17"
                                                                    placeholder="1234 5678 9012 3457" minlength="19" maxlength="19" />
                                                                <label class="form-label" for="typeText">Card Number</label>
                                                            </div>
                                                        </div>

                                                        <div class="row mb-4">
                                                            <div class="col-md-6">
                                                                <div class="form-outline form-white">
                                                                    <input type="text" id="typeExp" class="form-control form-control-lg"
                                                                        placeholder="MM/YYYY" size="7" id="exp" minlength="7" maxlength="7" />
                                                                    <label class="form-label" for="typeExp">Expiration</label>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <div class="form-outline form-white">
                                                                    <input type="password" id="typeText" class="form-control form-control-lg"
                                                                        placeholder="&#9679;&#9679;&#9679;" size="1" minlength="3" maxlength="3" />
                                                                    <label class="form-label" for="typeText">Cvv</label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <hr class="my-4">

                                                        <%--footer blue chart--%>
                                                        <div class="d-flex justify-content-between">
                                                            <p class="mb-2">
                                                                Subtotal
                                                            </p>

                                                            <asp:Label class="mb-2" ID="subTotalLb" runat="server" Text="0.00"></asp:Label>
                                                        </div>

                                                        <div class="d-flex justify-content-between">
                                                            <p class="mb-2">Other</p>
                                                            <asp:Label class="mb-2" ID="Label1" runat="server" Text="$0.00"></asp:Label>
                                                        </div>

                                                        <div class="d-flex justify-content-between mb-4">
                                                            <p class="mb-2">Total(Incl. taxes)</p>
                                                            <asp:Label class="mb-2" ID="totalLb" runat="server" Text="$4798.00"></asp:Label>
                                                        </div>

                                                        <asp:LinkButton CssClass="btn btn-info btn-block btn-lg" ID="payButton" runat="server" Text="Button" OnClick="payButton_Click">
                                                            <div class="d-flex justify-content-between">
                                                                <asp:Label ID="checkoutLbcheckoutLb" runat="server" Text="Label"></asp:Label>
                                                                <span>Checkout <i class="fas fa-long-arrow-alt-right ms-2"></i></span>
                                                            </div>

                                                        </asp:LinkButton>

                                                    </div>
                                                </div>
                                                <%--finalcuadro azul--%>
                                            </div>
                                            <div class="tab-pane fade" id="ex1-tabs-3" role="tabpanel" aria-labelledby="ex1-tab-3">
                                                Tab 3 content
                                            </div>
                                        </div>
                                        <!-- Tabs content -->




                                    </div>

                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</asp:Content>
