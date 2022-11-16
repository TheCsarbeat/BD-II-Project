<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="aboutUs.aspx.cs" Inherits="indioSupermercado.aboutUs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    
<%--        <nav class="navbar navbar-expand-lg navbar-light bg-light py-3">
      <div class="container"><a href="#" class="navbar-brand d-flex align-items-center"> <i class="fa fa-snowflake-o fa-lg text-primary mr-2"></i><strong>Snowflake</strong></a>
        <button type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation" class="navbar-toggler"><span class="navbar-toggler-icon"></span></button>
        <div id="navbarSupportedContent" class="collapse navbar-collapse">
          <ul class="navbar-nav ml-auto">
            <li class="nav-item active"><a href="#" class="nav-link font-italic"> Home </a></li>
            <li class="nav-item active"><a href="#" class="nav-link font-italic"> About </a></li>
            <li class="nav-item active"><a href="#" class="nav-link font-italic"> Services </a></li>
            <li class="nav-item active"><a href="#" class="nav-link font-italic"> Contact</a></li>
          </ul>
        </div>
      </div>
    </nav>--%>

    <div class="bg-white">
      <div class="container py-5">
        <div class="row h-100 align-items-center py-5">
          <div class="col-lg-6">
            <h1 class="display-4">Proyecto Final Bases De Datos II</h1>
            <p class="lead text-muted mb-0">Instituto Tecnológico de Costa Rica</p>
              <p class="lead text-muted mb-0">Ingeniería en Computación</p>
          </div>
          <div class="col-lg-6 d-none d-lg-block"><img src="aboutUsTemplate/aboutUsImg/fondoMain.jpg" alt="" class="img-fluid"></div>
        </div>
      </div>
    </div>

    <div class="bg-white py-5">
      <div class="container py-5">
        <div class="row align-items-center mb-5">
          <div class="col-lg-6 order-2 order-lg-1"><i class="fa fa-bar-chart fa-2x mb-3 text-primary"></i>
            <h2 class="font-weight-light">Sistema de administración de Supermercado</h2>
            <p class="font-italic text-muted mb-4">Permite administrar empleados, clientes, productos, sucursales y todo lo necesario para la correcta administración del supermercado</p>
          </div>
          <div class="col-lg-5 px-5 mx-auto order-1 order-lg-2"><img src="aboutUsTemplate/aboutUsImg/marketMain.jpg"  alt="" class="img-fluid mb-4 mb-lg-0"></div>
        </div>
        <div class="row align-items-center">
          <div class="col-lg-5 px-5 mx-auto"> <img src="aboutUsTemplate/aboutUsImg/database.jpg" alt="" class="img-fluid mb-4 mb-lg-0"></div>
          <div class="col-lg-6"><i class="fa fa-leaf fa-2x mb-3 text-primary"></i>
            <h2 class="font-weight-light">Almacenamiento de información en bases de datos SQL</h2>
            <p class="font-italic text-muted mb-4">Se trabaja en un servidor local fragmentado para cada país</p>
          </div>
        </div>
      </div>
    </div>
    
    <div class="bg-light py-5">
      <div class="container py-5">
        <div class="row mb-4">
          <div class="col-lg-5">
            <h2 class="display-4 font-weight-light">Equipo Desarrollador</h2>
            <p class="font-italic text-muted"> Estudiantes Carné 2021 </p>
          </div>
        </div>

        <div class="row text-center">
          <!-- Team item-->
          <div class="col-xl-3 col-sm-6 mb-5">
            <div class="bg-white rounded shadow-sm py-5 px-4"> <img src="aboutUsTemplate/aboutUsImg/Maynor.jpeg" alt="" width="100" class="img-fluid rounded-circle mb-3 img-thumbnail shadow-sm">
              <h5 class="mb-0">Maynor Martinez</h5>
                <span class="small text-uppercase text-muted">2021052792</span>
              <ul class="social mb-0 list-inline mt-3">
                <li class="list-inline-item"><a href="#" class="social-link"><i class="fa fa-facebook-f"></i></a></li>
                <li class="list-inline-item"><a href="#" class="social-link"><i class="fa fa-twitter"></i></a></li>
                <li class="list-inline-item"><a href="#" class="social-link"><i class="fa fa-instagram"></i></a></li>
                <li class="list-inline-item"><a href="#" class="social-link"><i class="fa fa-linkedin"></i></a></li>
              </ul>
            </div>
          </div>
          <!-- End-->

          <!-- Team item-->
          <div class="col-xl-3 col-sm-6 mb-5">
            <div class="bg-white rounded shadow-sm py-5 px-4"> <img src="aboutUsTemplate/aboutUsImg/Fernanda.jpg" alt="" width="100" class="img-fluid rounded-circle mb-3 img-thumbnail shadow-sm">
              <h5 class="mb-0">Fernanda Murillo</h5><span class="small text-uppercase text-muted">2021077803</span>
              <ul class="social mb-0 list-inline mt-3">
                <li class="list-inline-item"><a href="#" class="social-link"><i class="fa fa-facebook-f"></i></a></li>
                <li class="list-inline-item"><a href="#" class="social-link"><i class="fa fa-twitter"></i></a></li>
                <li class="list-inline-item"><a href="#" class="social-link"><i class="fa fa-instagram"></i></a></li>
                <li class="list-inline-item"><a href="#" class="social-link"><i class="fa fa-linkedin"></i></a></li>
              </ul>
            </div>
          </div>
          <!-- End-->

          <!-- Team item-->
          <div class="col-xl-3 col-sm-6 mb-5">
            <div class="bg-white rounded shadow-sm py-5 px-4"> <img src="aboutUsTemplate/aboutUsImg/sebas.jpg" alt="" width="100" class="img-fluid rounded-circle mb-3 img-thumbnail shadow-sm">
              <h5 class="mb-0">Sebastian Chaves</h5><span class="small text-uppercase text-muted">2021</span>
              <ul class="social mb-0 list-inline mt-3">
                <li class="list-inline-item"><a href="#" class="social-link"><i class="fa fa-facebook-f"></i></a></li>
                <li class="list-inline-item"><a href="#" class="social-link"><i class="fa fa-twitter"></i></a></li>
                <li class="list-inline-item"><a href="#" class="social-link"><i class="fa fa-instagram"></i></a></li>
                <li class="list-inline-item"><a href="#" class="social-link"><i class="fa fa-linkedin"></i></a></li>
              </ul>
            </div>
          </div>
          <!-- End-->

          <!-- Team item-->
          <div class="col-xl-3 col-sm-6 mb-5">
            <div class="bg-white rounded shadow-sm py-5 px-4"> <img src="aboutUsTemplate/aboutUsImg/cesar.jpg" alt="" width="100" class="img-fluid rounded-circle mb-3 img-thumbnail shadow-sm">
              <h5 class="mb-0">Cesar Jimenez</h5><span class="small text-uppercase text-muted">2021</span>
              <ul class="social mb-0 list-inline mt-3">
                <li class="list-inline-item"><a href="#" class="social-link"><i class="fa fa-facebook-f"></i></a></li>
                <li class="list-inline-item"><a href="#" class="social-link"><i class="fa fa-twitter"></i></a></li>
                <li class="list-inline-item"><a href="#" class="social-link"><i class="fa fa-instagram"></i></a></li>
                <li class="list-inline-item"><a href="#" class="social-link"><i class="fa fa-linkedin"></i></a></li>
              </ul>
            </div>
          </div>
          <!-- End-->

        </div>
      </div>
    </div>

</asp:Content>

