

(function () {
    'use strict';
    document.addEventListener('DOMContentLoaded', function () {

        const cartButtons = document.querySelectorAll('.cart-button');

        cartButtons.forEach(button => {

            button.addEventListener('click', cartClick);

        });

        function cartClick() {
            let button = this;
            button.classList.add('clicked');
        }

      //Desplegar navegación de paga'ginas y pabellones
        $(function () {
            $(function () {//Activio nav y desplegar menu
                $('body.buscar .navegacion a:contains("Buscar")').addClass('activo');
                $('body.index .navegacion a:contains("Inicio")').addClass('activo');
                $('body.administrar .navegacion a:contains("Administrar")').addClass('activo');
                $('body.sobreferks .navegacion a:contains("Sobre Férks")').addClass('activo');

                $('.menu_movil').on('click', function () {
                    $('.navegacion').slideToggle();
                });
            });


            //Navegacion de admin y desplegar aulas de pabellones
            $(".padre-toggle").on("click", function (e) {
                e.preventDefault();
                $(this).next(".hijo-toggle").slideToggle();
                $('.collapse').collapse()
                

            });

            $(".listaasdf").on("click", function (e) {
                e.preventDefault();
                $('.collapse').collapse({
                    toggle: false
                })


            });


            


            //desplegar aside admin 
            $('div.header_admin .menu_movil').on('click', function () {

                let picha = $('.contenedor-side-nav').attr('style');

                if (picha == 'left: 0px;') {
                    $('.contenedor-side-nav').animate({ 'left': '-210px' }, 800);
                } else {
                    $('.contenedor-side-nav').animate({ 'left': '0px' }, 800);
                }

            });


        });

    });//DOM conten load

})();//Funcion USER stric



