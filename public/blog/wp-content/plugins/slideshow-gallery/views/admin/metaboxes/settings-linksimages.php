<table class="form-table">
	<tbody>
    	<tr>
        	<th><label for="imagesthickbox_N"><?php _e('Open Images in Thickbox Overlay', $this -> plugin_name); ?></label></th>
            <td>
            	<label><input <?php echo ($this -> get_option('imagesthickbox') == "Y") ? 'checked="checked"' : ''; ?> type="radio" name="imagesthickbox" value="Y" id="imagesthickbox_Y" /> <?php _e('Yes', $this -> plugin_name); ?></label>
                <label><input <?php echo ($this -> get_option('imagesthickbox') == "N") ? 'checked="checked"' : ''; ?> type="radio" name="imagesthickbox" value="N" id="imagesthickbox_N" /> <?php _e('No', $this -> plugin_name); ?></label>
            	<span class="howto"><?php _e('turning this on (Yes) will open image URLs (.jpg, .png, .gif, .bmp) in a Thickbox image overlay', $this -> plugin_name); ?></span>
            </td>
        </tr>
    </tbody>
</table>