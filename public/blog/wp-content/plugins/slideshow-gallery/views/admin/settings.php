<?php

global $post, $post_ID;
$post_ID = 1;

wp_nonce_field('closedpostboxes', 'closedpostboxesnonce', false);
wp_nonce_field('meta-box-order', 'meta-box-order-nonce', false);

?>

<div class="wrap">
	<div class="icon32">
		<img src="<?php echo $this -> url(); ?>/images/icon-settings-32.png" />
	</div>

	<h2><?php _e('Configuration Settings', $this -> plugin_name); ?></h2>
	
	<form action="<?php echo $this -> url; ?>" name="post" id="post" method="post">
		<div id="poststuff" class="metabox-holder has-right-sidebar">			
			<div id="side-info-column" class="inner-sidebar">		
				<?php do_action('submitpage_box'); ?>	
				<?php do_meta_boxes($this -> menus['slideshow-settings'], 'side', $post); ?>
			</div>
			<div id="post-body">
				<div id="post-body-content">
					<?php do_meta_boxes($this -> menus['slideshow-settings'], 'normal', $post); ?>
				</div>
			</div>
			<br class="clear" />
		</div>
	</form>
</div>