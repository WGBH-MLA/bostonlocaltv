<?php

class GalleryGallerySlides extends GalleryDbHelper {

	var $table;
	var $model = 'GallerySlides';
	var $controller = "galleriesslides";
	var $plugin_name = 'slideshow-gallery';
	
	var $data = array();
	var $errors = array();
	
	var $fields = array(
		'id'				=>	"INT(11) NOT NULL AUTO_INCREMENT",
		'gallery_id'		=>	"INT(11) NOT NULL DEFAULT '0'",
		'slide_id'			=>	"INT(11) NOT NULL DEFAULT '0'",
		'created'			=>	"DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00'",
		'modified'			=>	"DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00'",
		'key'				=>	"PRIMARY KEY (`id`)",
	);

	function GalleryGallerySlides($data = array()) {
		global $wpdb;
		$this -> table = $wpdb -> prefix . strtolower($this -> pre) . "_" . $this -> controller;
		if (is_admin()) { $this -> check_table($this -> model); }
	
		if (!empty($data)) {
			foreach ($data as $dkey => $dval) {
				$this -> {$dkey} = $dval;
			}
		}
		
		return true;
	}
	
	function table() {
		$this -> table = $wpdb -> prefix . strtolower($this -> pre) . "_" . $this -> controller;
		return $this -> table;
	}
	
	function defaults() {
		$defaults = array(
			'created'			=>	GalleryHtmlHelper::gen_date(),
			'modified'			=>	GalleryHtmlHelper::gen_date(),
		);
		
		return $defaults;
	}
	
	function validate($data = null) {
		$this -> errors = array();
	
		if (!empty($data)) {
			$data = (empty($data[$this -> model])) ? $data : $data[$this -> model];
			
			foreach ($data as $dkey => $dval) {
				$this -> data -> {$dkey} = stripslashes($dval);
			}
			
			extract($data, EXTR_SKIP);
			
			if (empty($gallery_id)) { $this -> errors['title'] = __('No gallery was specified', $this -> plugin_name); }
			if (empty($slide_id)) { $this -> errors['title'] = __('No slide was specified', $this -> plugin_name); }
			
			if (empty($this -> errors)) {
				if ($galleryslide = $this -> find(array('gallery_id' => $gallery_id, 'slide_id' => $slide_id))) {
					$this -> debug($galleryslide);
					exit();
				}
			}
		} else {
			$this -> errors[] = __('No data was posted', $this -> plugin_name);
		}
		
		return $this -> errors;
	}
}

?>