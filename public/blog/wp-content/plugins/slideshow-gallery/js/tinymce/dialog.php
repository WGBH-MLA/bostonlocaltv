<?php

global $wpdb;

error_reporting(0);
@ini_set('display_errors', 0);

if (!defined('DS')) { define('DS', DIRECTORY_SEPARATOR); }

$root = __FILE__;
for ($i = 0; $i < 6; $i++) $root = dirname($root);

if (!defined('DS')) { define('DS', DIRECTORY_SEPARATOR); }
require_once($root . DS . 'wp-config.php');
require_once(ABSPATH . 'wp-admin' . DS . 'admin-functions.php');

if(!current_user_can('edit_posts')) die;
do_action('admin_init');

$galleriesquery = "SELECT * FROM `" . $wpdb -> prefix . "gallery_galleries` ORDER BY `title` ASC";
$galleries = $wpdb -> get_results($galleriesquery);

?>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><?php _e('Insert a Slideshow Gallery', "slideshow-gallery"); ?></title>
	<script language="javascript" type="text/javascript" src="<?php bloginfo('wpurl'); ?>/wp-includes/js/tinymce/tiny_mce_popup.js"></script>
	<script language="javascript" type="text/javascript" src="<?php bloginfo('wpurl'); ?>/wp-includes/js/tinymce/utils/mctabs.js"></script>
	<script language="javascript" type="text/javascript" src="<?php bloginfo('wpurl'); ?>/wp-includes/js/tinymce/utils/form_utils.js"></script>
	<script language="javascript" type="text/javascript" src="<?php bloginfo('wpurl'); ?>/wp-includes/js/tinymce/utils/form_utils.js"></script>
	<script language="javascript" type="text/javascript" src="<?php bloginfo('wpurl'); ?>/wp-includes/js/jquery/jquery.js"></script>
	<script language="javascript" type="text/javascript">
	
	var _self = tinyMCEPopup;
	
	function insertTag () {	
		var slideshow_type = jQuery('input[name="slideshow_type"]:checked').val();
		var exclude = jQuery('#exclude').val();
		
		if (slideshow_type == "post") {
			var post_id = jQuery('#post_id').val();
			if (post_id == "") { alert('<?php _e('Please fill in a post ID.', "slideshow-gallery"); ?>'); return false; }
			var tag = '[slideshow post_id="' + post_id + '"';
		
			if (exclude != "" && exclude != "undefined" && exclude != undefined) {
				tag += ' exclude="' + exclude + '"';
			}
			
			tag += ']';
		} else if (slideshow_type == "custom") {
			var tag = '[slideshow';
			if (exclude != "" && exclude != "undefined" && exclude != undefined) { tag += ' exclude="' + exclude + '"'; }
			tag += ']';
		} else if (slideshow_type == "gallery") {
			var gallery_id = jQuery('#gallery_id').val();
			if (gallery_id == "") { alert('<?php _e('Please select a gallery.', "slideshow-gallery"); ?>'); return false; }
			var tag = '[slideshow gallery_id="' + gallery_id + '"';
			if (exclude != "" && exclude != "undefined" && exclude != undefined) { tag += ' exclude="' + exclude + '"'; }
			tag += ']';
		}
		
		if(window.tinyMCE) {
			window.tinyMCE.execInstanceCommand('content', 'mceInsertContent', false, tag);
			tinyMCEPopup.editor.execCommand('mceRepaint');
			tinyMCEPopup.close();
		}
	}
	
	function closePopup() {
		tinyMCEPopup.close();
	}		
	</script>
	
	<style type="text/css">
		table th { vertical-align: top; }
		.panel_wrapper { border-top: 1px solid #909B9C; }
		.panel_wrapper div.current { height:auto !important; }
		#product-menu { width: 180px; }
	</style>
	
</head>
<body>

<div id="wpwrap">

<form onsubmit="insertTag(); return false;" action="#">
	<div class="panel_wrapper">
		<label style="font-weight:bold; cursor:pointer;"><input onclick="jQuery('#post_div').show(); jQuery('#gallery_div').hide();" type="radio" name="slideshow_type" value="post" id="type_post" /> <?php _e('Images From a Post', "slideshow-gallery"); ?></label><br/>
		<label style="font-weight:bold; cursor:pointer;"><input onclick="jQuery('#post_div').hide(); jQuery('#gallery_div').show();" type="radio" name="slideshow_type" value="gallery" id="type_gallery" /> <?php _e('Slides From a Gallery', "slideshow-gallery"); ?></label><br/>
		<label style="font-weight:bold; cursor:pointer;"><input onclick="jQuery('#post_div').hide(); jQuery('#gallery_div').hide();" type="radio" name="slideshow_type" value="custom" id="type_custom" /> <?php _e('All Available Slides', "slideshow-gallery"); ?></label>
		
		<div id="post_div" style="display:none;">
			<p>
				<label for="post_id" style="font-weight:bold;"><?php _e('Post ID:', "slideshow-gallery"); ?></label><br/>
				<input type="text" class="" name="post_id" value="" id="post_id" /><br/>
				<small><?php _e('ID of the post to take images from.', "slideshow-gallery"); ?></small>
			</p>
		</div>
		
		<div id="gallery_div" style="display:none;">
			<p>
				<label for="gallery_id" style="font-weight:bold;"><?php _e('Gallery:', "slideshow-gallery"); ?></label>
				<select name="gallery_id" id="gallery_id">
					<option value=""><?php _e('- Select Gallery -', "slideshow-gallery"); ?></option>
					<?php if (!empty($galleries)) : ?>
						<?php foreach ($galleries as $gallery) : ?>
							<?php $slidescount = $wpdb -> get_var("SELECT COUNT(`id`) FROM `" . $wpdb -> prefix . "gallery_galleriesslides` WHERE `gallery_id` = '" . $gallery -> id . "'"); ?>
							<option value="<?php echo $gallery -> id; ?>"><?php echo $gallery -> title; ?> (<?php echo $slidescount; ?>)</option>
						<?php endforeach; ?>
					<?php endif; ?>
				</select>
			</p>
		</div>
		
		<p>
			<label style="font-weight:bold;"><?php _e('Exclude', "slideshow-gallery"); ?>:</label><br/>
			<input type="text" name="exclude" value="" id="exclude" /><br/>
			<small><?php _e('Comma separated IDs of attachments/slides to exclude', "slideshow-gallery"); ?></small>
		</p>
	</div>
	
	<div class="mceActionPanel">
		<div style="float: left">
			<input type="button" id="cancel" name="cancel" value="{#cancel}" onclick="closePopup()"/>
		</div>

		<div style="float: right">
			<input type="button" id="insert" name="insert" value="{#insert}" onclick="insertTag()" />
		</div>
	</div>
</form>
</div>

<script type="text/javascript">

</script>

</body>
</html>