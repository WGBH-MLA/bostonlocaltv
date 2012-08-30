<div class="wrap <?php echo $this -> pre; ?>">
	<div class="icon32">
		<img src="<?php echo $this -> url(); ?>/images/icon-galleries-32.png" />
	</div>

	<h2><?php _e('Save a Gallery', $this -> plugin_name); ?></h2>
	
	<form action="<?php echo $this -> url; ?>&amp;method=save" method="post">
		<input type="hidden" name="Gallery[id]" value="<?php echo $this -> Gallery -> data -> id; ?>" />
	
		<table class="form-table">
			<tbody>
				<tr>
					<th><label for="Gallery_title"><?php _e('Title', $this -> plugin_name); ?></label></th>
					<td>
						<input type="text" class="widefat" name="Gallery[title]" value="<?php echo esc_attr(stripslashes($this -> Gallery -> data -> title)); ?>" id="Gallery_title" />
						<span class="howto"><?php _e('Title of this gallery for identification purposes.', $this -> plugin_name); ?></span>
						<?php echo (!empty($this -> Gallery -> errors['title'])) ? '<span class="error">' . $this -> Gallery -> errors['title'] . '</span>' : ''; ?>
					</td>
				</tr>
			</tbody>
		</table>
	
		<p class="submit">
			<input type="submit" class="button-primary" value="<?php _e('Save Gallery', $this -> plugin_name); ?>" name="submit" />
		</p>
	</form>
</div>