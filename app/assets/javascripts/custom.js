 $(document).ready(function(){
  $('#access > li a').click(function () { 
    $(this).fadeTo('fast', .5).removeAttr('href'); 
  });
	$("#featured").tabs({fx:{opacity: "toggle"}});
  $('.msg-bar').delay(3000).fadeOut('fast');
  $('body').on("click", '.show_password', function(e) {
    e.preventDefault();
    $('.password_hide').show();
    $(this).hide();
  });
  
  $('form input#non_video').change(function() {
    var values = $(this).closest('form').serialize()
    console.log(values)
    $(this).closest('form').submit()
  })
});


