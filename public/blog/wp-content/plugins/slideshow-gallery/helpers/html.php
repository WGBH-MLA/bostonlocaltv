<?php

class GalleryHtmlHelper extends GalleryPlugin {

	function link($name = '', $href = '/', $args = array()) {
		$defaults = array(
			'title'			=>	(empty($args['title'])) ? $title : $args['title'],
			'target'		=>	"_self",
			'class' 		=>	"wpco",
			'rel'			=>	"",
			'onclick'		=>	"",
		);
		
		$r = wp_parse_args($args, $defaults);
		extract($r, EXTR_SKIP);
		
		ob_start();
		
		?><a class="<?php echo $class; ?>" rel="<?php echo $rel; ?>" <?php echo (!empty($onclick)) ? 'onclick="' . $onclick . '"' : ''; ?> href="<?php echo $href; ?>" target="<?php echo $target; ?>" title="<?php echo $title; ?>"><?php echo $name; ?></a><?php
		
		$link = ob_get_clean();
		return $link;
	}
	
	function filename($url = null) {
		if (!empty($url)) {
			return basename($url);
		}
		
		return false;
	}
	
	function thumbname($filename = null, $append = "thumb") {
		if (!empty($filename)) {
			$name = $this -> strip_ext($filename, "name");
			$ext = $this -> strip_ext($filename, "ext");
			
			return $name . '-' . $append . '.' . $ext;
		}
		
		return false;
	}
	
	function timthumb_image($image = null, $width = null, $height = null, $quality = 100, $class = "slideshow", $rel = "") {	
		$tt_image = '<img src="' . $this -> timthumb_url() . '?src=' . $image;
		if (!empty($width)) { $tt_image .= '&w=' . $width; };
		if (!empty($height)) { $tt_image .= '&h=' . $height; };
		$tt_image .= '&q=' . $quality . '"';
		$tt_image .= '&a=t';
		if (!empty($class)) { $tt_image .= ' class="' . $class . '"'; };
		if (!empty($rel)) { $tt_image .= ' rel="' . $rel . '"'; }
		$tt_image .= ' />';
		return $tt_image;
	}
	
	function timthumb_image_src($image = null, $width = null, $height = null, $quality = 100) {	
		$tt_image = $this -> timthumb_url() . '?src=' . $image;
		if (!empty($width)) { $tt_image .= '&w=' . $width; };
		if (!empty($height)) { $tt_image .= '&h=' . $height; };
		$tt_image .= '&q=' . $quality;
		$tt_image .= '&a=t';
		return $tt_image;
	}
	
	function timthumb_url() {
		return rtrim(get_bloginfo('wpurl'), '/') . '/wp-content/plugins/slideshow-gallery/vendors/timthumb.php';
	}
	
	function image_url($filename = null) {
		if (!empty($filename)) {
			return rtrim(get_option('siteurl'), '/') . '/wp-content/uploads/slideshow-gallery/' . $filename;
		}
		
		return false;
	}
	
	function field_name($name = '') {
		if (!empty($name)) {
			if ($mn = $this -> strip_mn($name)) {
				return $mn[1] . '[' . $mn[2] . ']';
			}
		}
	
		return $name;
	}
	
	function field_error($name = '', $el = "p") {
		if (!empty($name)) {
			if ($mn = $this -> strip_mn($name)) {
				$errors = array();
				
				switch ($mn[1]) {
					case 'Slide'		:
						$errors = GallerySlide::validate($_POST);
						break;
				}			
						
				if (!empty($errors[$mn[2]])) {
					$error = '<' . $el . ' class="' . $this -> pre . 'error">' . $errors[$mn[2]] . '</' . $el . '>';
					
					return $error;
				}
			}
		}
		
		return false;
	}
	
	function field_value($name = null) {
		if ($mn = $this -> strip_mn($name)) {					
			$value = $this -> {$mn[1]} -> data -> {$mn[2]};
			
			return $value;
		}
		
		return false;
	}
	
	function retainquery($add = '') {
		$url = $_SERVER['REQUEST_URI'];
	
		if (($urls = @explode("?", $url)) !== false) {				
			if (!empty($urls[1])) {			
				if (!empty($add)) {				
					if (($adds = explode("&", str_replace("&amp;", "&", $add))) !== false) {					
						foreach ($adds as $qstring) {						
							if (($qparts = @explode("=", $qstring)) !== false) {							
								if (!empty($qparts[0])) {								
									if (preg_match("/\&?" . $qparts[0] . "\=([0-9a-z+]*)/i", $urls[1], $matches)) {
										$urls[1] = preg_replace("/\&?" . $qparts[0] . "\=([0-9a-z+]*)/i", "", $urls[1]);
									}									
								}
							}
						}
					}
				}
			}
		}
		
		$urls[1] = preg_replace("/\&?" . $this -> pre . "message\=([0-9a-z+]*)/i", "", $urls[1]);
		$url = $urls[0];
		$url .= '?';
		$url .= (empty($urls[1])) ? '' : $urls[1] . '&amp;';
		$url .= $add;
				
		return preg_replace("/\?(\&)?/si", "?", $url);
	}
	
	function strip_ext($filename = '', $return = 'ext') {
		if (!empty($filename)) { 
			$extArray = split("[/\\.]", $filename); 
			
			if ($return == 'ext') {
				$p = count($extArray) - 1; 
				$extension = $extArray[$p]; 
				return $extension;
			} else {
				$p = count($extArray) - 2;
				$filename = $extArray[$p];
				return $filename;
			}
		}
		
		return false;
	}
	
	function strip_mn($name = '') {	
		if (!empty($name)) {
			if (preg_match("/^(.*?)\.(.*?)$/si", $name, $matches)) {
				return $matches;
			}
		}
	
		return false;
	}
	
	function gen_date($format = "Y-m-d H:i:s", $time = false) {
		$time = (empty($time)) ? time() : $time;
		$date = date($format, $time);
		
		return $date;
	}
	
	function array_to_object($array = array()) {
		//type casting...
		return (object) $array;
	}
	
	function sanitize($string = '', $sep = '-') {
		if (!empty($string)) {
			$string = ereg_replace("[^0-9a-z" . $sep . "]", "", strtolower(str_replace(" ", $sep, $string)));
			$string = preg_replace("/" . $sep . "[" . $sep . "]*/i", $sep, $string);
			
			return $string;
		}
	
		return false;
	}
}

?>
