

$(document).ready(function () {
    var winWidth = $(window).outerWidth();
    if (winWidth <= 1200) {
        $('.page').removeClass('side-open');
    }

    topAlign($('.page__top'), $('.page__side'));
    leftAlignIcons();
    toggleMobile();
    toggleFilter();
    if ($(".card__block").length)
        $(".card__block").equalHeight();
    if ($(".feature__box").length)
        $(".feature__box").equalHeight();
    if ($(".section--positions .feature").length)
        $(".section--positions .feature").equalHeight();
    if ($(".section--engineering-solutions .feature").length)
        $(".section--engineering-solutions .feature").equalHeight();

    if ($('#skrollr-body').length) {
        enquire.register("screen and (min-width : 768px)", initAdjustWindow(), false);
    }
//    $('body').on('touchstart touchmove touchcancel touchend', function (e) {
//        if ($('body').hasClass('menu-open')) {
//            e.stopPropagation();
//            e.preventDefault();
//            return false;
//        }
//    });
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
    if ($(".card__block").length)
        $(".card__block").css('height', 'auto');
    if ($(".card__block").length)
        $(".card__block").equalHeight();
    if ($(".feature__box").length)
        $(".feature__box").css('height', 'auto');
    if ($(".feature__box").length)
        $(".feature__box").equalHeight();
    if ($(".section--positions .feature").length)
        $(".section--positions .feature").css('height', 'auto');
    if ($(".section--positions .feature").length)
        $(".section--positions .feature").equalHeight();
    if ($(".section--engineering-solutions .feature").length)
        $(".section--engineering-solutions .feature").css('height', 'auto');
    if ($(".section--engineering-solutions .feature").length)
        $(".section--engineering-solutions .feature").equalHeight();
});

$(window).on("orientationchange", function () {
    if ($('#skrollr-body').length) {
        enquire.register("screen and (min-width : 768px)", initAdjustWindow(), false);
    }
});


function adjustWindow() {
    var winW = $(window).width();

    if (winW >= 768) {

        // Init Skrollr
        var s = skrollr.init({
            forceHeight: false,
            beforerender: function (data) {
                if (winW <= 1024 && $('body').hasClass('menu-open')) {
                    return false;
                }
            },
            render: function (data) {
                //Debugging - Log the current scroll position.
                //console.log(data.curTop);
                var sections = $('body').children('.section');
                var element;
                (function () {
                    sections.length > 1 ? element = sections.eq(1) : element = sections.eq(0);
                })();

                var header = $('header');
                if (element.length) {
                    if (data.curTop > element.offset().top) {
                        header.addClass('off-screen');
                    } else {
                        header.removeClass('off-screen');
                    }
                }

                $('body').on('touchstart touchmove touchcancel touchend', function () {
                    if ($('body').hasClass('menu-open')) {
                        s.setScrollTop(0);
                    }
                });

                animTrigger();
            }
        });

        s.refresh($('.hero'));

    } else {

        var s = skrollr.init();
        s.destroy();
    }
}

function initAdjustWindow() {
    return {
        match: function () {
            adjustWindow();
        },
        unmatch: function () {
            adjustWindow();
        }
    };
}

function hideHeader() {
    if ($('.section').length) {
        var sections = $('body').children('.section');
        var element;
        sections.length > 1 ? element = sections.eq(1) : element = sections.eq(0);

        var header = $('header');

        if ($(window).scrollTop() > element.offset().top) {
            header.addClass('off-screen');
            $('body').removeClass('menu-open');
        } else {
            header.removeClass('off-screen');
        }
    }
}

$(window).scroll(function () {

    if ($(window).outerWidth() < 768) {
        hideHeader();
    }
});

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
        $('body').toggleClass('menu-open');
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

$(function () {
    var btn = $('.btn__header');
    var win = $(window);
    var search = $('.header__form-groups');

    function toggleSearch() {
        if (win.outerWidth() < 1200) {
            btn.attr('type', 'button');
            search.toggleClass('search-visible');
        } else {
            btn.attr('type', 'submit');
        }
    }

    btn.on('click', function () {
        toggleSearch();
    });
});

(function () {
    // This changes everything
    "use strict";

// retrieve the element
    var label = document.querySelector(".checkbox label");
    var element = document.querySelector(".checkbox span");

    if (document.getElementsByClassName('checkbox').length) {
// reset the transition by...
        label.addEventListener("click", function (e) {
            e.preventDefault;

            // -> removing the class
            element.classList.remove("checked");

            // -> triggering reflow /* The actual magic */
            // without this it wouldn't work. Try uncommenting the line and the transition won't be retriggered.
            // This was, from the original tutorial, will no work in strict mode. Thanks Felis Phasma! The next uncommented line is the fix.
            // element.offsetWidth = element.offsetWidth;

            void element.offsetWidth;

            // -> and re-adding the class
            element.classList.add("checked");
        }, false);
    }
})();

$(function () {
    $('.intro__arrow').click(function () {
        if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && location.hostname == this.hostname) {
            var target = $(this.hash);
            target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
            if (target.length) {
                $('html, body').animate({
                    scrollTop: target.offset().top
                }, 1200);
                return false;
            }
        }
    });
});








