
function topAlign(topElement, element) {
    var topHeight = topElement.outerHeight();

    return  element.css('top', topHeight);
}

function leftAlignIcons() {
    var feature = $('.feature--left .feature__caption');
    var iconWidth = $('.feature--left .feature__icon').outerWidth();
    var winWidth = $(window).width();

    if (winWidth < 992) {
        feature.css('padding-left', '0');
    } else {
        feature.css('padding-left', iconWidth + 20);
    }
}

// MOBILE MENU TOGGLE
function toggleMobile() {
    var btn = $('.navbar-toggle');

    btn.on('click', function () {
        btn.toggleClass('nav-open');
    });

    $('.header__menu-toggle').on('click', function () {
        $('.header').toggleClass('menu-open');
    });
}

// FILTER SIDE BAR TOGGLE
function toggleFilter() {
    var btn = $('.btn__filter');
    var page = $('.page');

    btn.on('click', function () {
        page.toggleClass('side-open');
    });
}

// SET EQUAL HEIGHTS FOR ELEMENTS
$.fn.equalHeight = function () {
    var maxHeight = 0;
    return this.each(function (index, box) {
        var boxHeight = $(box).height();
        maxHeight = Math.max(maxHeight, boxHeight);
    }).height(maxHeight);
};

// INPUT
(function () {
    // trim polyfill : https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/Trim
    if (!String.prototype.trim) {
        (function () {
            // Make sure we trim BOM and NBSP
            var rtrim = /^[\s\uFEFF\xA0]+|[\s\uFEFF\xA0]+$/g;
            String.prototype.trim = function () {
                return this.replace(rtrim, '');
            };
        })();
    }

    [].slice.call(document.querySelectorAll('.input__field')).forEach(function (inputEl) {
        // in case the input is already filled..
        if (inputEl.value.trim() !== '') {
            classie.add(inputEl.parentNode, 'input__typing');
        }

        // events:
        inputEl.addEventListener('focus', onInputFocus);
        inputEl.addEventListener('blur', onInputBlur);
    });

    function onInputFocus(ev) {
        classie.add(ev.target.parentNode, 'input__typing');
    }

    function onInputBlur(ev) {
        if (ev.target.value.trim() === '') {
            classie.remove(ev.target.parentNode, 'input__typing');
        }
    }
})();

// MENU LIST-ITEM ARROW ROTATE
(function () {
    $('.menu__list a').on('click', function (event) {
        var $tgt = $(event.target);

        if ($tgt.hasClass('collapsed') !== true) {
            $tgt.children().removeClass('rotate');
        } else {
            $('.menu__list a').next().removeClass('rotate');
            $tgt.children().addClass('rotate');
        }
    });
})();

// FAQ PANEL-ARROW ROTATE
(function () {
    $('.section__panel-title a').on('click', function (event) {
        var $tgt = $(event.target);

        if ($tgt.hasClass('collapsed') !== true) {
            $tgt.next().removeClass('rotate');
        } else {
            $('.section__panel-title a').next().removeClass('rotate');
            $tgt.next().addClass('rotate');
        }
    });
})();

$(function () {
    if ($('.menu').length > 0) {
        $(".menu__inner").mCustomScrollbar({
            autoDraggerLength: true,
            theme: 'dark-2'
        });
    }
});


function isScrolledIntoView(elem) {
    return elem.getBoundingClientRect().top <= window.innerHeight - 100;
}

function animTrigger() {

    $('.animate').each(function () {
        if (isScrolledIntoView(this) === true) {
            $(this).addClass('visible');
        }
    });
}

$(window).on('scroll', function () {



});

$(window).on('resize', function () {
    var winWidth = $(window).outerWidth();

    if (winWidth >= 1200) {
        $('.page').addClass('side-open');
    } else {
        $('.page').removeClass('side-open');
    }

    topAlign($('.page__top'), $('.page__side'));
    leftAlignIcons();
    $(".card__block").css('height', 'auto');
    $(".card__block").equalHeight();
    $(".feature__box").css('height', 'auto');
    $(".feature__box").equalHeight();
    $(".section--positions .feature").css('height', 'auto');
    $(".section--positions .feature").equalHeight();
});

$(document).ready(function () {
    var winWidth = $(window).outerWidth();


    if (winWidth <= 1200) {
        $('.page').removeClass('side-open');
    }

    topAlign($('.page__top'), $('.page__side'));
    leftAlignIcons();
    toggleMobile();
    toggleFilter();
    $(".card__block").equalHeight();
    $(".feature__box").equalHeight();
    $(".section--positions .feature").equalHeight();



});

(function ($) {
    // Init Skrollr


    if ($('.hero__bg').length) {

        var s = skrollr.init({
            smoothScrolling: false,
            render: function (data) {
                //Debugging - Log the current scroll position.
                //console.log(data.curTop);
                animTrigger();
            },
        });

    }
})(jQuery);
 