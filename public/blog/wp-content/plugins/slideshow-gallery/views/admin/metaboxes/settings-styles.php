<?php $styles = $this -> get_option('styles'); ?>

<table class="form-table">
	<tbody>
		<tr>
			<th><label for="styles.resizeimages"><?php _e('Resize Images', $this -> plugin_name); ?></label></th>
			<td>
				<label><input <?php echo (empty($styles['resizeimages']) || $styles['resizeimages'] == "Y") ? 'checked="checked"' : ''; ?> type="radio" name="styles[resizeimages]" value="Y" id="styles.resizeimages_Y" /> <?php _e('Yes', $this -> plugin_name); ?></label>
				<label><input <?php echo ($styles['resizeimages'] == "N") ? 'checked="checked"' : ''; ?> type="radio" name="styles[resizeimages]" value="N" id="styles.resizeimages_N" /> <?php _e('No', $this -> plugin_name); ?></label>
				<span class="howto"><?php _e('Should images be resized proportionally to fit the width of the slideshow area?', $this -> plugin_name); ?></span>
			</td>
		</tr>
		<tr>
			<th><label for="styles.width"><?php _e('Gallery Width', $this -> plugin_name); ?></label></th>
			<td>
				<input style="width:45px;" id="styles.width" type="text" name="styles[width]" value="<?php echo $styles['width']; ?>" /> <?php _e('px', $this -> plugin_name); ?>
				<span class="howto"><?php _e('Width of the slideshow gallery', $this -> plugin_name); ?></span>
			</td>
		</tr>
		<tr>
			<th><label for="styles.height"><?php _e('Gallery Height', $this -> plugin_name); ?></label></th>
			<td>
				<input style="width:45px;" id="styles.height" type="text" name="styles[height]" value="<?php echo $styles['height']; ?>" /> <?php _e('px', $this -> plugin_name); ?>
				<span class="howto"><?php _e('Height of the slideshow gallery', $this -> plugin_name); ?></span>
			</td>
		</tr>
		<tr>
			<th><label for="styles.border"><?php _e('Slideshow Border', $this -> plugin_name); ?></label></th>
			<td>
				<input type="text" name="styles[border]" value="<?php echo $styles['border']; ?>" id="styles.border" style="width:145px;" />
				<span class="howto"><?php echo sprintf(__('Border style/color for the entire slideshow wrapper eg. %s', $this -> plugin_name), "1px #000000 solid"); ?>
			</td>
		</tr>
		<tr>
			<th><label for="styles.background"><?php _e('Slideshow Background', $this -> plugin_name); ?></label></th>
			<td>
				<input type="text" name="styles[background]" value="<?php echo $styles['background']; ?>" id="styles.background" style="width:65px;" />
				<span class="howto"><?php echo sprintf(__('Background color (hexidecimal) of the entire slideshow wrapper eg. %s', $this -> plugin_name), "#FFFFFF"); ?></span>
			</td>
		</tr>
		<tr>
			<th><label for="styles.infobackground"><?php _e('Information Background', $this -> plugin_name); ?></label></th>
			<td>
				<input type="text" name="styles[infobackground]" value="<?php echo $styles['infobackground']; ?>" id="styles.infobackground" style="width:65px;" />
				<span class="howto"><?php echo sprintf(__('Background color (hexidecimal) of the information bar eg. %s', $this -> plugin_name), "#000000"); ?></span>
			</td>
		</tr>
		<tr>
			<th><label for="styles.infocolor"><?php _e('Information Text Color', $this -> plugin_name); ?></label></th>
			<td>
				<input type="text" name="styles[infocolor]" value="<?php echo $styles['infocolor']; ?>" id="styles.infocolor" style="width:65px;" />
				<span class="howto"><?php echo sprintf(__('Text color (hexidecimal) of the information bar content eg. %s', $this -> plugin_name), "#FFFFFF"); ?></span>
			</td>
		</tr>
		<tr>
			<th><label for="thumbactive"><?php _e('Thumbnail Active Border', $this -> plugin_name); ?></label></th>
			<td>
				<input style="width:65px;" type="text" name="thumbactive" value="<?php echo $this -> get_option('thumbactive'); ?>" id="thumbactive" />
				<span class="howto"><?php echo sprintf(__('Border color (hexidecimal) for the active image thumbnail eg. %s', $this -> plugin_name), "#FFFFFF"); ?></span>
			</td>
		</tr>
	</tbody>
</table>