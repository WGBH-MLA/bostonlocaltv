 $(document).ready(function(){
  $('#access > li a').click(function () { 
    $(this).fadeTo('fast', .5).removeAttr('href'); 
  });
	$("#featured").tabs({fx:{opacity: "toggle"}})
});


