<div class="submitbox" id="submitpost">
	<div id="minor-publishing">
		<div id="misc-publishing-actions">
			<div class="misc-pub-section misc-pub-section-last">
				<a href="<?php echo $this -> url; ?>&amp;method=reset" title="<?php _e('Reset all configuration settings to their default values', $this -> plugin_name); ?>" onclick="if (!confirm('<?php _e('Are you sure you wish to reset all configuration settings?', $this -> plugin_name); ?>')) { return false; }"><?php _e('Reset to Defaults', $this -> plugin_name); ?></a>
			</div>
		</div>
	</div>
	<div id="major-publishing-actions">
		<div id="publishing-action">
			<input class="button-primary" type="submit" name="save" value="<?php _e('Save Configuration', $this -> plugin_name); ?>" />
		</div>
		<br class="clear" />
	</div>
</div>