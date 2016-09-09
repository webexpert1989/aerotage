
$(document).ready(function () {
    $(function () {
        $('select').selectric({
            maxHeight: 160,
            optionsItemBuilder: '{text}',
            labelBuilder: function (currItem) {
                return '<span class="text__secondary">&#9913</span> ' + currItem.text;
            },
            disableOnMobile: false,
            arrowButtonMarkup: '<span class="input__icon"><svg class="icon icon-arrow-down"><use xlink:href="img/sprite-contact.svg#icon-arrow-down"></use></svg></span>'
        });
    });

    $(function () {
        $(".selectric-items").mCustomScrollbar({
            autoDraggerLength: false,
            theme: 'dark-2'
        });
    });
});