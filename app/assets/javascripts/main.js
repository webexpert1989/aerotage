

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


// SET EQUAL HEIGHTS FOR ELEMENTS
function equalHeight(group) {
    tallest = 0;
    group.each(function () {
        thisHeight = $(this).height();
        if (thisHeight > tallest) {
            tallest = thisHeight;
        }
    });
    group.height(tallest);
}



$(document).ready(function () {
    leftAlignIcons();
    toggleMobile();
    equalHeight($(".feature__box"));

    // Input
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
});

$(window).resize(function () {
    leftAlignIcons();
     equalHeight($(".feature__box"));
});