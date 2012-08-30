<div class="wrap <?php echo $this -> pre; ?>">
	<div class="icon32">
		<img src="<?php echo $this -> url(); ?>/images/icon-galleries-32.png" />
	</div>

	<h2><?php echo sprintf(__('View Gallery: %s', $this -> plugin_name), $gallery -> title); ?></h2>
	
	<div style="float:none;" class="subsubsub"><?php echo $this -> Html -> link(__('&larr; All Galleries', $this -> plugin_name), $this -> url, array('title' => __('All Galleries', $this -> plugin_name))); ?></div>
	
	<div class="tablenav">
		<div class="alignleft actions">
			<a href="?page=<?php echo $this -> sections -> galleries; ?>&amp;method=save&amp;id=<?php echo $gallery -> id; ?>" class="button" title="<?php _e('Edit', $this -> plugin_name); ?>"><?php _e('Edit Gallery', $this -> plugin_name); ?></a>
			<a href="?page=<?php echo $this -> sections -> galleries; ?>&amp;method=hardcode&amp;id=<?php echo $gallery -> id; ?>" class="button" title="<?php _e('Hardcode', $this -> plugin_name); ?>"><?php _e('Hardcode', $this -> plugin_name); ?></a>
			<a onclick="if (!confirm('<?php _e('Are you sure you want to delete this gallery?', $this -> plugin_name); ?>')) { return false; }" href="?page=<?php echo $this -> sections -> galleries; ?>&amp;method=delete&amp;id=<?php echo $gallery -> id; ?>" class="button button-highlighted" title="<?php _e('Delete', $this -> plugin_name); ?>"><?php _e('Delete Gallery', $this -> plugin_name); ?></a>
		</div>
	</div>
	
	<?php $this -> render('slides' . DS . 'loop', array('slides' => $slides, 'paginate' => $paginate), true, 'admin'); ?>
</div>