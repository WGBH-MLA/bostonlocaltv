<table class="form-table">
	<tbody>
		<tr>
			<th><label for="autoslideY"><?php _e('Auto Slide', $this -> plugin_name); ?></label></th>
			<td>
				<label><input onclick="jQuery('#autoslide_div').show();" <?php echo ($this -> get_option('autoslide') == "Y") ? 'checked="checked"' : ''; ?> type="radio" name="autoslide" value="Y" id="autoslideY" /> <?php _e('Yes', $this -> plugin_name); ?></label>
				<label><input onclick="jQuery('#autoslide_div').hide();" <?php echo ($this -> get_option('autoslide') == "N") ? 'checked="checked"' : ''; ?> type="radio" name="autoslide" value="N" id="autoslideN" /> <?php _e('No', $this -> plugin_name); ?></label>
				<span class="howto"><?php _e('Should image slides automatically slide?', $this -> plugin_name); ?></span>
			</td>
		</tr>
	</tbody>
</table>

<div id="autoslide_div" style="display:<?php echo ($this -> get_option('autoslide') == "Y") ? 'block' : 'none'; ?>;">
	<table class="form-table">
		<tbody>
			<tr>
				<th><label for="autospeed"><?php _e('Auto Speed', $this -> plugin_name); ?></label></th>
				<td>
					<input type="text" style="width:45px;" name="autospeed" value="<?php echo $this -> get_option('autospeed'); ?>" id="autospeed" /> <?php _e('speed', $this -> plugin_name); ?>
					<span class="howto"><?php _e('Speed for auto sliding. Lower number for shorter interval between images.', $this -> plugin_name); ?> <small><?php _e('(Default/Recommended: 10)', $this -> plugin_name); ?></small></span>
				</td>
			</tr>
		</tbody>
	</table>
</div>

<table class="form-table">
	<tbody>
		<tr>
			<th><label for="fadespeed"><?php _e('Image Fading Speed', $this -> plugin_name); ?></label></th>
			<td>
				<input style="width:45px;" type="text" name="fadespeed" value="<?php echo $this -> get_option('fadespeed'); ?>" id="fadespeed" />
				<span class="howto"><?php _e('Speed for fading of images. Lower number for quicker fading of images.', $this -> plugin_name); ?> <small><?php _e('(Default: 10, Recommended: 1-20)', $this -> plugin_name); ?><br/></small></span>
			</td>
		</tr>
		<tr>
			<th><label for="shownav_Y"><?php _e('Show Image Navigation', $this -> plugin_name); ?></label></th>
			<td>
				<label><input <?php echo ($this -> get_option('shownav') == "Y") ? 'checked="checked"' : ''; ?> onclick="jQuery('#shownavdiv').show();" type="radio" name="shownav" value="Y" id="shownav_Y" /> <?php _e('Yes', $this -> plugin_name); ?></label>
				<label><input <?php echo ($this -> get_option('shownav') == "N") ? 'checked="checked"' : ''; ?> onclick="jQuery('#shownavdiv').hide();" type="radio" name="shownav" value="N" id="shownav_N" /> <?php _e('No', $this -> plugin_name); ?></label>
				<span class="howto"><?php _e('Show next/previous buttons on the image for navigation purposes?', $this -> plugin_name); ?></span>
			</td>
		</tr>
	</tbody>
</table>

<div id="shownavdiv" style="display:<?php echo ($this -> get_option('shownav') == "Y") ? 'block' : 'none'; ?>;">
	<table class="form-table">
		<tbody>
			<tr>
				<th><label for="navopacity"><?php _e('Navigation Default Opacity', $this -> plugin_name); ?></label></th>
				<td>
					<input type="text" name="navopacity" value="<?php echo $this -> get_option('navopacity'); ?>" id="navopacity" style="width:45px;" /> <?php _e('&#37; <!-- percentage -->', $this -> plugin_name); ?>
					<span class="howto"><?php _e('Opacity of the next/previous buttons by default.', $this -> plugin_name); ?></span>
				</td>
			</tr>
			<tr>
				<th><label for="navhover"><?php _e('Navigation Hover Opacity', $this -> plugin_name); ?></label></th>
				<td>
					<input type="text" name="navhover" value="<?php echo $this -> get_option('navhover'); ?>" id="navhover" style="width:45px;" /> <?php _e('&#37; <!-- percentage -->', $this -> plugin_name); ?>
					<span class="howto"><?php _e('Opacity of the next/previous buttons when they are hovered.', $this -> plugin_name); ?></span>
				</td>
			</tr>
		</tbody>
	</table>
</div>

<table class="form-table">
	<tbody>
		<tr>
			<th><label for="informationY"><?php _e('Show Information', $this -> plugin_name); ?></label></th>
			<td>
				<label><input onclick="jQuery('#information_div').show();" <?php echo ($this -> get_option('information') == "Y") ? 'checked="checked"' : ''; ?> type="radio" name="information" value="Y" id="informationY" /> <?php _e('Yes', $this -> plugin_name); ?></label>
				<label><input onclick="jQuery('#information_div').hide();" <?php echo ($this -> get_option('information') == "N") ? 'checked="checked"' : ''; ?> type="radio" name="information" value="N" id="informationN" /> <?php _e('No', $this -> plugin_name); ?></label>
				<span class="howto"><?php _e('Should the information bar be shown on slides?', $this -> plugin_name); ?></span>
			</td>
		</tr>
	</tbody>
</table>

<div id="information_div" style="display:<?php echo ($this -> get_option('information') == "Y") ? 'block' : 'none'; ?>;">
	<table class="form-table">
		<tbody>
			<tr>
				<th><label for="infospeed"><?php _e('Information Speed', $this -> plugin_name); ?></label></th>
				<td>
					<input type="text" style="width:45px;" name="infospeed" value="<?php echo $this -> get_option('infospeed'); ?>" id="infospeed" />
					<span class="howto"><?php _e('Speed at which the information bar will slide in and out.', $this -> plugin_name); ?></span>
				</td>
			</tr>
		</tbody>
	</table>
</div>

<table class="form-table">
	<tbody>
		<tr>
			<th><label for="thumbnailsN"><?php _e('Show Thumbnails', $this -> plugin_name); ?></label></th>
			<td>
				<label><input onclick="jQuery('#thumbnails_div').show();" <?php echo ($this -> get_option('thumbnails') == "Y") ? 'checked="checked"' : ''; ?> type="radio" name="thumbnails" value="Y" id="thumbnailsY" /> <?php _e('Yes', $this -> plugin_name); ?></label>
				<label><input onclick="jQuery('#thumbnails_div').hide();" <?php echo ($this -> get_option('thumbnails') == "N") ? 'checked="checked"' : ''; ?> type="radio" name="thumbnails" value="N" id="thumbnailsN" /> <?php _e('No', $this -> plugin_name); ?></label>
				<span class="howto"><?php _e('Should the thumbnails bar be shown for slides?', $this -> plugin_name); ?></span>
			</td>
		</tr>
	</tbody>
</table>

<div id="thumbnails_div" style="display:<?php echo ($this -> get_option('thumbnails') == "Y") ? 'block' : 'none'; ?>;">
	<table class="form-table">
		<tbody>
			<tr>
				<th><label for="thubmpositionbottom"><?php _e('Thumbnails Position', $this -> plugin_name); ?></label></th>
				<td>
					<label><input <?php echo ($this -> get_option('thumbposition') == "top") ? 'checked="checked"' : ''; ?> type="radio" name="thumbposition" value="top" id="thumbpositiontop" /> <?php _e('Top', $this -> plugin_name); ?></label>
					<label><input <?php echo ($this -> get_option('thumbposition') == "bottom") ? 'checked="checked"' : ''; ?> type="radio" name="thumbposition" value="bottom" id="thumbpositionbottom" /> <?php _e('Bottom', $this -> plugin_name); ?></label>
					<span class="howto"><?php _e('Choose your preferred position of the thumbnails bar relative to the slideshow images.', $this -> plugin_name); ?></span>
				</td>
			</tr>
			<tr>
				<th><label for="thumbheight"><?php _e('Thumbnail Dimensions', $this -> plugin_name); ?></label></th>
				<td>
					<input class="widefat" style="width:45px;" type="text" name="thumbwidth" value="<?php echo esc_attr(stripslashes($this -> get_option('thumbwidth'))); ?>" id="thumbwidth" /> 
					<?php _e('x <!-- by -->', $this -> plugin_name); ?>
					<input class="widefat" style="width:45px;" type="text" name="thumbheight" value="<?php echo esc_attr(stripslashes($this -> get_option('thumbheight'))); ?>" id="thumbheight" />
					<?php _e('px <!-- pixels -->', $this -> plugin_name); ?>
					<span class="howto"><?php _e('Width and height of the thumbnails for the slides.', $this -> plugin_name); ?><br/>
					<?php _e('You may leave the width empty (not the height) to crop proportionally.', $this -> plugin_name); ?></span>
				</td>
			</tr>
			<tr>
				<th><label for="thumbopacity"><?php _e('Thumbnail Opacity', $this -> plugin_name); ?></label></th>
				<td>
					<input style="width:45px;" type="text" name="thumbopacity" value="<?php echo $this -> get_option('thumbopacity'); ?>" id="thumbopacity" /> <?php _e('&#37; <!-- percentage -->', $this -> plugin_name); ?>
					<span class="howto"><?php _e('Default opacity of thumbnails when they are not hovered.', $this -> plugin_name); ?></span>
				</td>
			</tr>
			<tr>
				<th><label for="thumbscrollspeed"><?php _e('Thumbnails Scroll Speed', $this -> plugin_name); ?></label></th>
				<td>
					<input class="widefat" style="width:45px;" name="thumbscrollspeed" value="<?php echo $this -> get_option('thumbscrollspeed'); ?>" id="thumbscrollspeed" /> <?php _e('speed', $this -> plugin_name); ?>
					<span class="howto"><?php _e('Speed at which the thumbnails will scroll.', $this -> plugin_name); ?> <small><?php _e('(Default:5, Recommended: 1-20)', $this -> plugin_name); ?></small></span>
				</td>
			</tr>
			<tr>
				<th><label for=""><?php _e('Thumbnail Spacing', $this -> plugin_name); ?></label></th>
				<td>
					<input type="text" style="width:45px;" name="thumbspacing" value="<?php echo $this -> get_option('thumbspacing'); ?>" id="thumbspacing" /> <?php _e('px', $this -> plugin_name); ?>
					<span class="howto"><?php _e('Horizontal margin/spacing in pixels between thumbnail images.', $this -> plugin_name); ?></span>
				</td>
			</tr>
		</tbody>
	</table>
</div>