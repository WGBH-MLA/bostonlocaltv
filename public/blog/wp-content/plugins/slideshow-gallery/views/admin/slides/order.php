<div class="wrap">
	<div class="icon32">
		<img src="<?php echo $this -> url(); ?>/images/icon-32.png" />
	</div>

	<h2><?php _e('Order Slides', $this -> plugin_name); ?></h2>
	
	<div style="float:none;" class="subsubsub">
		<a href="<?php echo $this -> url; ?>"><?php _e('&larr; Manage All Slides', $this -> plugin_name); ?></a>
	</div>
	
	<?php if (!empty($slides)) : ?>
		<ul id="slidelist">
			<?php foreach ($slides as $slide) : ?>
				<li class="lineitem" id="item_<?php echo $slide -> id; ?>">
					<span style="float:left; margin:5px 10px 0 5px;"><img src="<?php echo $this -> Html -> timthumb_image_src($slide -> image_path, 60, 60, 100); ?>" alt="<?php echo $this -> Html -> sanitize($slide -> title); ?>" /></span>
					<h4><?php echo $slide -> title; ?></h4>
					<hr class="clear" style="clear:both; visibility:hidden; height:1px; display:block;" />
				</li>
			<?php endforeach; ?>
		</ul>
		
		<div id="slidemessage"><!-- message will go here --></div>
		
		<script type="text/javascript">
		jQuery(document).ready(function() {		
			jQuery("ul#slidelist").sortable({
				start: function(request) {
					jQuery("#slidemessage").slideUp();
				},
				stop: function(request) {					
					jQuery("#slidemessage").load(GalleryAjax + "?cmd=slides_order", jQuery("ul#slidelist").sortable('serialize')).slideDown("slow");
				},
				axis: "y"
			});
		});
		</script>
		
		<style type="text/css">
		#slidelist li.lineitem {
			list-style: none;
			margin: 3px 0px !important;
			padding: 2px 5px 2px 5px;
			background-color: #F1F1F1 !important;
			border:1px solid #B2B2B2;
			cursor: move;
			vertical-align: middle !important;
			display: block;
			clear: both;
			-moz-border-radius: 4px;
			-webkit-border-radius: 4px;
		}
		</style>
	<?php else : ?>
		<p style="color:red;"><?php _e('No slides found', $this -> plugin_name); ?></p>
	<?php endif; ?>
</div>