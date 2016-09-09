$(document).ready(function () {
    $(function () {
        $('select').selectric({
            maxHeight: 160,
            optionsItemBuilder: '{text}',
            labelBuilder: '{text}',
            disableOnMobile: false,
            arrowButtonMarkup: '<span class="input__icon"><svg class="icon icon-angle"><use xlink:href="assets/images/sprite-job-search.svg#icon-angle"></use></svg></span>'
        });
    });
    $(function () {
        $(".selectric-items").mCustomScrollbar({
            autoDraggerLength: false,
            theme: 'dark-2'
        });
    });


    $('.twitter-typeahead').addClass('form-control');


    $('.tt-input').keydown(function (event) {
        if (event.keyCode == 13) {
            event.preventDefault();
            return false;
        }
    });


});

(function () {
    var communities = new Bloodhound({
        datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        prefetch: {
            url: '/communities.json',
            filter: function (list) {
                return $.map(list, function (cityname) {
                    return {name: cityname};
                });
            },
            remote: {
                url: '/communities.json',
                wildcard: '%QUERY%'
            }
        }
    });
    communities.initialize();

    $('#communities').tagsinput({
        typeaheadjs: {
            name: 'communities',
            displayKey: 'name',
            valueKey: 'name',
            source: communities.ttAdapter()
        },
        cancelConfirmKeysOnEmpty: true,
        freeInput: false,
    });

})();