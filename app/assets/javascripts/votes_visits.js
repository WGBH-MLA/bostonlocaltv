var tabcontainers=$('#voting_status > div');
		//hide every content div
		tabcontainers.hide();
		
		$('#tabs > li a').click(function(){
			//On click on the tab navigation link
			tabcontainers.hide();
			//show content block corresponding to link clicked
			tabcontainers.filter(this.hash).fadeIn();
			$('#tabs > li a').removeClass('selected');
			$(this).addClass('selected');
			return false;			
		}).filter(':first').click();//click event for first link on pageload