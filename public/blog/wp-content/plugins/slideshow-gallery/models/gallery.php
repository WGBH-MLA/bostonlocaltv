<?php

class GalleryGallery extends GalleryDbHelper {

	var $table;
	var $model = 'Gallery';
	var $controller = "galleries";
	var $plugin_name = 'slideshow-gallery';
	
	var $data = array();
	var $errors = array();
	
	var $fields = array(
		'id'				=>	"INT(11) NOT NULL AUTO_INCREMENT",
		'title'				=>	"VARCHAR(150) NOT NULL DEFAULT ''",
		'created'			=>	"DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00'",
		'modified'			=>	"DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00'",
		'key'				=>	"PRIMARY KEY (`id`)",
	);

	function GalleryGallery($data = array()) {
		global $wpdb;
		$this -> table = $wpdb -> prefix . strtolower($this -> pre) . "_" . $this -> controller;
		if (is_admin()) { $this -> check_table($this -> model); }
	
		if (!empty($data)) {
			foreach ($data as $dkey => $dval) {
				$this -> {$dkey} = stripslashes_deep($dval);
				
				switch ($dkey) {
					case 'id'			:
						$slidescountquery = "SELECT COUNT(`id`) FROM `" . $wpdb -> prefix . strtolower($this -> pre) . "_galleriesslides` WHERE `gallery_id` = '" . $dval . "'";
						$this -> slidescount = $wpdb -> get_var($slidescountquery);
						break;
				}
			}
		}
		
		return true;
	}
	
	function select() {
		$select = array();
		
		if ($galleries = $this -> find_all()) {
			foreach ($galleries as $gallery) {
				$select[$gallery -> id] = $gallery -> title;
			}
		}
		
		return $select;
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
			
			if (empty($title)) { $this -> errors['title'] = __('Please fill in a title', $this -> plugin_name); }
		} else {
			$this -> errors[] = __('No data was posted', $this -> plugin_name);
		}
		
		return $this -> errors;
	}
}

?>