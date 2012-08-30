<div class="wrap <?php echo $this -> pre; ?>">
	<div class="icon32">
		<img src="<?php echo $this -> url(); ?>/images/icon-32.png" />
	</div>

	<h2><?php _e('Save a Slide', $this -> plugin_name); ?></h2>
	
	<form action="<?php echo $this -> url; ?>&amp;method=save" method="post" enctype="multipart/form-data">
		<input type="hidden" name="Slide[id]" value="<?php echo $this -> Slide -> data -> id; ?>" />
		<input type="hidden" name="Slide[order]" value="<?php echo $this -> Slide -> data -> order; ?>" />
	
		<table class="form-table">
			<tbody>
				<tr>
					<th><label for="Slide.title"><?php _e('Title', $this -> plugin_name); ?></label></th>
					<td>
						<input class="widefat" type="text" name="Slide[title]" value="<?php echo esc_attr($this -> Slide -> data -> title); ?>" id="Slide.title" />
                        <span class="howto"><?php _e('title/name of your slide as it will be displayed to your users.', $this -> plugin_name); ?></span>
						<?php echo (!empty($this -> Slide -> errors['title'])) ? '<div style="color:red;">' . $this -> Slide -> errors['title'] . '</div>' : ''; ?>
					</td>
				</tr>
				<tr>
					<th><label for="Slide.description"><?php _e('Description', $this -> plugin_name); ?></label></th>
					<td>
						<textarea class="widefat" name="Slide[description]"><?php echo esc_attr($this -> Slide -> data -> description); ?></textarea>
                        <span class="howto"><?php _e('description of your slide as it will be displayed to your users below the title.', $this -> plugin_name); ?></span>
						<?php echo (!empty($this -> Slide -> errors['description'])) ? '<div style="color:red;">' . $this -> Slide -> errors['description'] . '</div>' : ''; ?>
					</td>
				</tr>
				<tr>
					<th><label for=""><?php _e('Galleries', $this -> plugin_name); ?></label></th>
					<td>
						<?php if ($galleries = $this -> Gallery -> select()) : ?>
							<label style="font-weight:bold"><input onclick="jqCheckAll(this,'','Slide[galleries]');" type="checkbox" name="checkboxall" value="checkboxall" id="checkboxall" /> <?php _e('Select All', $this -> plugin_name); ?></label><br/>
							<?php foreach ($galleries as $gallery_id => $gallery_title) : ?>
								<label><input <?php echo (!empty($this -> Slide -> data -> galleries) && in_array($gallery_id, $this -> Slide -> data -> galleries)) ? 'checked="checked"' : ''; ?> type="checkbox" name="Slide[galleries][]" value="<?php echo $gallery_id; ?>" id="Slide_galleries_<?php echo $gallery_id; ?>" /> <?php echo $gallery_title; ?></label><br/>
							<?php endforeach; ?>
						<?php else : ?>
							<span class="error"><?php _e('No galleries are available.', $this -> plugin_name); ?></span>
						<?php endif; ?>
						<span class="howto"><?php _e('Assign this slide to one or more galleries.', $this -> plugin_name); ?></span>
					</td>
				</tr>
                <tr>
                	<th><label for="Slide.type.file"><?php _e('Image Type', $this -> plugin_name); ?></label></th>
                    <td>
                    	<label><input onclick="jQuery('#typediv_file').show(); jQuery('#typediv_url').hide();" <?php echo (empty($this -> Slide -> data -> type) || $this -> Slide -> data -> type == "file") ? 'checked="checked"' : ''; ?> type="radio" name="Slide[type]" value="file" id="Slide.type.file" /> <?php _e('Upload File (recommended)', $this -> plugin_name); ?></label>
                        <label><input onclick="jQuery('#typediv_url').show(); jQuery('#typediv_file').hide();" <?php echo ($this -> Slide -> data -> type == "url") ? 'checked="checked"' : ''; ?> type="radio" name="Slide[type]" value="url" id="Slide.type.url" /> <?php _e('Specify URL', $this -> plugin_name); ?></label>
                        <?php echo (!empty($this -> Slide -> errors['type'])) ? '<div style="color:red;">' . $this -> Slide -> errors['type'] . '</div>' : ''; ?>
                        <span class="howto"><?php _e('do you want to upload an image or specify a local/remote image URL?', $this -> plugin_name); ?></span>
                    </td>
                </tr>
            </tbody>
        </table>
        
        <div id="typediv_file" style="display:<?php echo (empty($this -> Slide -> data -> type) || $this -> Slide -> data -> type == "file") ? 'block' : 'none'; ?>;">
        	<table class="form-table">
            	<tbody>
                	<tr>
                    	<th><label for="Slide.image_file"><?php _e('Choose Image', $this -> plugin_name); ?></label></th>
                        <td>
                        	<input type="file" name="image_file" value="" id="Slide.image_file" />
                            <span class="howto"><?php _e('choose your image file from your computer. JPG, PNG, GIF are supported.', $this -> plugin_name); ?></span>
                            <?php echo (!empty($this -> Slide -> errors['image_file'])) ? '<div style="color:red;">' . $this -> Slide -> errors['image_file'] . '</div>' : ''; ?>
                            
                            <?php
							
							if (!empty($this -> Slide -> data -> type) && $this -> Slide -> data -> type == "file") {
								if (!empty($this -> Slide -> data -> image)) {									
									?>
                                    
                                    <input type="hidden" name="Slide[image_oldfile]" value="<?php echo esc_attr(stripslashes($this -> Slide -> data -> image)); ?>" />
                                    <p><small><?php _e('Current image. Leave the field above blank to keep this image.', $this -> plugin_name); ?></small></p>
                                    <a title="<?php echo esc_attr($this -> Slide -> data -> title); ?>" class="colorbox" href="<?php echo $this -> Html -> image_url($this -> Slide -> data -> image); ?>"><img src="<?php echo $this -> Html -> timthumb_image_src($this -> Slide -> data -> image_path, 100, 100, 100); ?>" alt="" class="slideshow" /></a>
                                    
                                    <?php	
								}
							}
							
							?>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        
        <div id="typediv_url" style="display:<?php echo ($this -> Slide -> data -> type == "url") ? 'block' : 'none'; ?>;">
            <table class="form-table">
                <tbody>
                    <tr>
                        <th><label for="Slide.image_url"><?php _e('Image URL', $this -> plugin_name); ?></label></th>
                        <td>
                            <input class="widefat" type="text" name="Slide[image_url]" value="<?php echo esc_attr($this -> Slide -> data -> image_url); ?>" id="Slide.image_url" />
                            <span class="howto"><?php _e('Local or remote image location eg. http://domain.com/path/to/image.jpg', $this -> plugin_name); ?></span>
                            <?php echo (!empty($this -> Slide -> errors['image_url'])) ? '<div style="color:red;">' . $this -> Slide -> errors['image_url'] . '</div>' : ''; ?>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>    
                
        <table class="form-table">
        	<tbody>
				<tr>
					<th><label for="Slide_uselink_N"><?php _e('Use Link', $this -> plugin_name); ?></label></th>
					<td>
						<label><input onclick="jQuery('#Slide_uselink_div').show();" <?php echo ($this -> Slide -> data -> uselink == "Y") ? 'checked="checked"' : ''; ?> type="radio" name="Slide[uselink]" value="Y" id="Slide_uselink_Y" /> <?php _e('Yes', $this -> plugin_name); ?></label>
						<label><input onclick="jQuery('#Slide_uselink_div').hide();" <?php echo (empty($this -> Slide -> data -> uselink) || $this -> Slide -> data -> uselink == "N") ? 'checked="checked"' : ''; ?> type="radio" name="Slide[uselink]" value="N" id="Slide_uselink_N" /> <?php _e('No', $this -> plugin_name); ?></label>
                        <span class="howto"><?php _e('set this to Yes to link this slide to a link/URL of your choice.', $this -> plugin_name); ?></span>
					</td>
				</tr>
			</tbody>
		</table>
		
		<div id="Slide_uselink_div" style="display:<?php echo ($this -> Slide -> data -> uselink == "Y") ? 'block' : 'none'; ?>;">
			<table class="form-table">
				<tbody>
					<tr>
						<th><label for="Slide.link"><?php _e('Link To', $this -> plugin_name); ?></label></th>
						<td>
                        	<input class="widefat" type="text" name="Slide[link]" value="<?php echo esc_attr($this -> Slide -> data -> link); ?>" id="Slide.link" />
                            <span class="howto"><?php _e('link/URL to go to when a user clicks the slide eg. http://www.domain.com/mypage/', $this -> plugin_name); ?></span>
                        </td>
					</tr>
					<tr>
						<th><label for="Slide_linktarget_self"><?php _e('Link Target', $this -> plugin_name); ?></label></th>
						<td>
							<label><input <?php echo (empty($this -> Slide -> data -> linktarget) || (!empty($this -> Slide -> data -> linktarget) && $this -> Slide -> data -> linktarget == "self")) ? 'checked="checked"' : ''; ?> type="radio" name="Slide[linktarget]" value="self" id="Slide_linktarget_self" /> <?php _e('Current Window', $this -> plugin_name); ?></label>
							<label><input <?php echo (!empty($this -> Slide -> data -> linktarget) && $this -> Slide -> data -> linktarget == "blank") ? 'checked="checked"' : ''; ?> type="radio" name="Slide[linktarget]" value="blank" id="Slide_linktarget_blank" /> <?php _e('New/Blank Window', $this -> plugin_name); ?></label>
							<span class="howto"><?php _e('Should this link open in the current window or a new window?', $this -> plugin_name); ?></span>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<p class="submit">
			<input class="button-primary" type="submit" name="submit" value="<?php _e('Save Slide', $this -> plugin_name); ?>" />
		</p>
	</form>
</div>