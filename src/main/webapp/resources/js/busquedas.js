jQuery(function () {

    $(document).on("click", '.dropdown-menu-advanced-search .dropdown-item', function () {
        showLoader();
        let checkbox = $('input', $(this).closest('div'));
        if ($(this).hasClass('active')) {
            $(this).removeClass('active');
            checkbox.prop('checked', false);
        } else {
            $(this).addClass('active');
            checkbox.prop('checked', true);
        }
        updateInfoFilter($(this).closest('.dropdown-advanced-search'));
        submitFilter();
    });

    $(document).on('click', '.seleccion-global', function () {
        showLoader();
        let context = $(this).closest('.dropdown-advanced-search');
        let activos = $('.dropdown-item.active', context).length;
        let inputs = $('input', context);
        if (activos !== undefined && activos > 0) {
            $(this).text('TODO');
            activos.removeClass('active');
            inputs.prop('checked', false);
        } else {
            $(this).text('BORRAR');
            console.log($('.dropdown-item', context));
            $('.dropdown-item', context).each(function () {
                $(this).addClass('active');
            });
            inputs.prop('checked', true);
        }
        submitFilter();
    });
});

function updateInfoFilter(context) {
    let totalElements = $('.active', context).length;
    let names = [];
    $('.active span', context).each(function () {
        names.push($(this).text());
    });

    $('.countSelections', context).text(totalElements);
    $('.nameSelections', context).text(names.join(", "));

    let button = $('.dropdown-toggle-advanced-search', context);
    if (totalElements !== undefined && totalElements > 0) {
        button.addClass('items-selected');
    } else {
        button.removeClass('items-selected');
    }
}

function submitFilter() {
    $.ajax({
        url: CONTEXT_ROOT + 'busqueda-avanzada',
        headers: {
            'X-CSRF-Token': $('[name*=_csrf]').val()
        },
        type: "POST",
        data: $('#advanced-search').serialize(),
        success: function (fragment) {
            $('#resultados').html(fragment);
        }, complete: function () {
            hideLoader();
        }
    });
}