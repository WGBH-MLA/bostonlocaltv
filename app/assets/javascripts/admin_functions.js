$(function() {
  $('body').on("change", 'form.edit_shopping_cart input', function(e) {
    e.preventDefault();
    $(this).closest('form').submit();
  });
  $('body').on("click", '#active_admin_content #mark_complete', function(e) {
    e.preventDefault();
    id = $(this).data('id');
    console.log(id)
    $.ajax({
      url: '/admin/shopping_carts/' + id,
        dataType: 'json',
        type: 'put',
        data: {
          shopping_cart: {
            status: 'closed',
            settled: true
          }
        },
        success: function(data) {
          console.log(data);
          window.location = '/admin/shopping_carts'
        }
    });
  });
});