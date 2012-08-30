<div class="wrap <?php echo $this -> pre; ?>">
	<div class="icon32">
		<img src="<?php echo $this -> url(); ?>/images/icon-galleries-32.png" />
	</div>

	<h2><?php echo sprintf(__('Hardcode Gallery: %s', $this -> plugin_name), $gallery -> title); ?></h2>
	<div style="float:none;" class="subsubsub"><?php echo $this -> Html -> link(__('&larr; All Galleries', $this -> plugin_name), $this -> url, array('title' => __('All Galleries', $this -> plugin_name))); ?></div>
	<p><?php _e('This PHP code can be used inside your WordPress theme to display slides inside this gallery.', $this -> plugin_name); ?></p>
	<textarea onmouseup="jQuery(this).unbind('onmouseup'); return false;" onfocus="jQuery(this).select();" cols="100%" rows="4"><?php echo htmlentities('<?php if (function_exists(\'slideshow\')) { slideshow(true, "' . $gallery -> id . '", false, array()); } ?>'); ?></textarea>
</div>