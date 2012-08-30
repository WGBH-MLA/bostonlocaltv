<?php 

$rand = 's' . rand(1,99) . 'w';
$wrapperid = "slideshow-wrapper-" . $rand;
$slides = stripslashes_deep($slides);

?>

<?php if (!empty($slides)) : ?>
	<ul id="slideshow" class="slideshow" style="display:none;">
		<?php if ($frompost) : ?>
			<?php foreach ($slides as $slide) : ?>
				<li>
					<h3><?php echo $slide -> post_title; ?></h3>
					<?php $full_image_href = wp_get_attachment_image_src($slide -> ID, 'full', false); ?>
					<?php $full_image_path = get_attached_file($slide -> ID); ?>
					<?php $full_image_url = wp_get_attachment_url($slide -> ID); ?>
					<?php if ($options['resizeimages'] == "true" && $options['width'] != "auto") : ?>
						<span><?php echo $this -> Html -> timthumb_image_src($full_image_href[0], $options['width'], $options['height'], 100); ?></span>
					<?php else : ?>
						<span><?php echo $full_image_href[0]; ?></span>
					<?php endif; ?>
					<p><?php echo $slide -> post_content; ?></p>
					<?php $thumbnail_link = wp_get_attachment_image_src($slide -> ID, 'thumbnail', false); ?>
					<?php if ($options['showthumbs'] == "true") : ?>
						<?php if (!empty($slide -> guid)) : ?>
							<a href="<?php echo $slide -> guid; ?>" target="_self" title="<?php echo esc_attr($slide -> post_title); ?>"><img src="<?php echo $this -> Html -> timthumb_image_src($full_image_href[0], $this -> get_option('thumbwidth'), $this -> get_option('thumbheight'), 100); ?>" alt="<?php echo $this -> Html -> sanitize($slide -> post_title); ?>" /></a>
						<?php else : ?>
							<img src="<?php echo $this -> Html -> timthumb_image_src($full_image_href[0], $this -> get_option('thumbwidth'), $this -> get_option('thumbheight'), 100); ?>" alt="<?php echo $this -> Html -> sanitize($slide -> post_title); ?>" />
						<?php endif; ?>
					<?php else : ?>
						<a href="<?php echo $slide -> guid; ?>" title="<?php echo $slide -> post_title; ?>"></a>
					<?php endif; ?>
				</li>
			<?php endforeach; ?>
		<?php else : ?>
			<?php foreach ($slides as $slide) : ?>		
				<li>
					<h3><?php echo $slide -> title; ?></h3>
					<?php if ($options['resizeimages'] == "true" && $options['width'] != "auto") : ?>
						<span><?php echo $this -> Html -> timthumb_image_src($slide -> image_path, $options['width'], $options['height'], 100); ?></span>
					<?php else : ?>
						<span><?php echo $this -> Html -> image_url($slide -> image); ?></span>
					<?php endif; ?>
					<p><?php echo $slide -> description; ?></p>
					<?php if ($options['showthumbs'] == "true") : ?>
						<?php if ($slide -> uselink == "Y" && !empty($slide -> link)) : ?>
							<a href="<?php echo $slide -> link; ?>" title="<?php echo esc_attr($slide -> title); ?>" target="_<?php echo $slide -> linktarget; ?>"><img src="<?php echo $this -> Html -> timthumb_image_src($slide -> image_path, $this -> get_option('thumbwidth'), $this -> get_option('thumbheight'), 100); ?>" alt="<?php echo $this -> Html -> sanitize($slide -> title); ?>" /></a>
						<?php else : ?>
							<img src="<?php echo $this -> Html -> timthumb_image_src($slide -> image_path, $this -> get_option('thumbwidth'), $this -> get_option('thumbheight'), 100); ?>" alt="<?php echo $this -> Html -> sanitize($slide -> title); ?>" />
						<?php endif; ?>
					<?php else : ?>
						<a href="<?php echo $slide -> link; ?>" title="<?php echo $slide -> title; ?>"></a>
					<?php endif; ?>
				</li>
			<?php endforeach; ?>
		<?php endif; ?>
	</ul>
	
	<div id="<?php echo $wrapperid; ?>">
		<?php if ($options['showthumbs'] == "true" && $options['thumbsposition'] == "top") : ?>
			<div id="thumbnails<?php echo $rand; ?>" class="thumbstop">
				<div id="slideleft<?php echo $rand; ?>" title="<?php _e('Slide Left', $this -> plugin_name); ?>"></div>
				<div id="slidearea<?php echo $rand; ?>">
					<div id="slider<?php echo $rand; ?>"></div>
				</div>
				<div id="slideright<?php echo $rand; ?>" title="<?php _e('Slide Right', $this -> plugin_name); ?>"></div>
				<br style="clear:both; visibility:hidden; height:1px;" />
			</div>
		<?php endif; ?>
	
		<div id="fullsize<?php echo $rand; ?>">
			<?php $navb = false; $navf = false; ?>
			<?php if ($options['shownav'] == "true" && count($slides) > 1) : ?>
				<?php $navb = "imgprev" . $rand; ?>
				<div id="imgprev<?php echo $rand; ?>" class="imgnav" title="<?php _e('Previous Image', $this -> plugin_name); ?>"></div>
			<?php endif; ?>
			<div id="imglink<?php echo $rand; ?>" class="imglink"><!-- link --></div>
			<?php if ($options['shownav'] == "true" && count($slides) > 1) : ?>
				<?php $navf = "imgnext" . $rand; ?>
				<div id="imgnext<?php echo $rand; ?>" class="imgnav" title="<?php _e('Next Image', $this -> plugin_name); ?>"></div>
			<?php endif; ?>
			<div id="image<?php echo $rand; ?>"></div>
			<?php if ($options['showinfo'] == "true") : ?>
				<div id="information<?php echo $rand; ?>">
					<h3></h3>
					<p></p>
				</div>
			<?php endif; ?>
		</div>
		
		<?php if ($options['showthumbs'] == "true" && $options['thumbsposition'] == "bottom") : ?>
			<div id="thumbnails<?php echo $rand; ?>" class="thumbsbot">
				<div id="slideleft<?php echo $rand; ?>" title="<?php _e('Slide Left', $this -> plugin_name); ?>"></div>
				<div id="slidearea<?php echo $rand; ?>">
					<div id="slider<?php echo $rand; ?>"></div>
				</div>
				<div id="slideright<?php echo $rand; ?>" title="<?php _e('Slide Right', $this -> plugin_name); ?>"></div>
				<br style="clear:both; visibility:hidden; height:1px;" />
			</div>
		<?php endif; ?>
	</div>
	
	<script type="text/javascript">
	jQuery.noConflict();
	tid('slideshow').style.display = "none";
	tid('<?php echo $wrapperid; ?>').style.display = 'block';
	tid('<?php echo $wrapperid; ?>').style.visibility = 'hidden';
	// append the spinner
	jQuery("#fullsize<?php echo $rand; ?>").append('<div id="spinner<?php echo $rand; ?>"><img src="<?php echo $this -> url(); ?>/images/spinner.gif"></div>');
	tid('spinner<?php echo $rand; ?>').style.visibility = 'visible';

	var slideshow = new TINY.slideshow("slideshow");
	jQuery(document).ready(function() {
		window.onload = function() {
			<?php if (empty($options['auto']) || (!empty($options['auto']) && $options['auto'] == "true")) : ?>slideshow.auto = true;<?php else : ?>slideshow.auto = false;<?php endif; ?>
			slideshow.speed = <?php echo $options['autospeed']; ?>;
			slideshow.imgSpeed = <?php echo $options['fadespeed']; ?>;
			slideshow.navOpacity = <?php echo $options['navopacity']; ?>;
			slideshow.navHover = <?php echo $options['navhoveropacity']; ?>;
			slideshow.letterbox = "#000000";
			slideshow.linkclass = "linkhover";
			slideshow.info = "<?php echo ($options['showinfo'] == "true") ? 'information' . $rand : ''; ?>";
			slideshow.infoSpeed = <?php echo $options['infospeed']; ?>;
			slideshow.thumbs = "<?php echo ($options['showthumbs'] == "true") ? 'slider' . $rand : ''; ?>";
			slideshow.thumbOpacity = <?php echo $this -> get_option('thumbopacity'); ?>;
			slideshow.left = "slideleft<?php echo $rand; ?>";
			slideshow.right = "slideright<?php echo $rand; ?>";
			slideshow.scrollSpeed = <?php echo $options['thumbsspeed']; ?>;
			slideshow.spacing = <?php echo $options['thumbsspacing']; ?>;
			slideshow.active = "<?php echo $options['thumbsborder']; ?>";
			slideshow.imagesthickbox = "<?php echo ($this -> get_option('imagesthickbox') == "Y") ? 'true' : 'false'; ?>";
			jQuery("#spinner<?php echo $rand; ?>").remove();
			slideshow.init("slideshow","image<?php echo $rand; ?>","<?php echo $navb; ?>","<?php echo $navf; ?>","imglink<?php echo $rand; ?>");
			tid('<?php echo $wrapperid; ?>').style.visibility = 'visible';
		}
	});
	</script>
	
	<?php
	
	$cssattr['wrapperrand'] = $rand;
	$cssattr['wrapperid'] = $wrapperid;
	$cssattr['resizeimages'] = (($options['resizeimages'] == "true") ? "Y" : "N");
	$cssattr['width'] = $options['width'];
	$cssattr['height'] = $options['height'];
	$cssattr['thumbwidth'] = $this -> get_option('thumbwidth');
	$cssattr['thumbheight'] = $this -> get_option('thumbheight');
	
	?>
	
	<style type="text/css">
	@import url('<?php echo $this -> get_css_url($cssattr); ?>');
	</style>
	
	<!--[if IE 6]>
	<style type="text/css">
	.imglink, #imglink<?php echo $rand; ?> { display: none !important; }
	.linkhover { display: none !important; }
	</style>
	<![endif]-->
<?php endif; ?>