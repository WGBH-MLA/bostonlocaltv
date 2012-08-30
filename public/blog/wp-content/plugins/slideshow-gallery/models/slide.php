<?php

class GallerySlide extends GalleryDbHelper {

	var $table;
	var $model = 'Slide';
	var $controller = "slides";
	var $plugin_name = 'slideshow-gallery';
	
	var $data = array();
	var $errors = array();
	
	var $fields = array(
		'id'				=>	"INT(11) NOT NULL AUTO_INCREMENT",
		'title'				=>	"VARCHAR(150) NOT NULL DEFAULT ''",
		'description'		=>	"TEXT NOT NULL",
		'image'				=>	"VARCHAR(50) NOT NULL DEFAULT ''",
		'type'				=>	"ENUM('file','url') NOT NULL DEFAULT 'file'",
		'image_url'			=>	"VARCHAR(200) NOT NULL DEFAULT ''",
		'uselink'			=>	"ENUM('Y','N') NOT NULL DEFAULT 'N'",
		'linktarget'		=>	"ENUM('self','blank') NOT NULL DEFAULT 'self'",
		'link'				=>	"VARCHAR(200) NOT NULL DEFAULT ''",
		'order'				=>	"INT(11) NOT NULL DEFAULT '0'",
		'created'			=>	"DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00'",
		'modified'			=>	"DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00'",
		'key'				=>	"PRIMARY KEY (`id`)",
	);

	function GallerySlide($data = array()) {
		global $wpdb;
		$this -> table = $wpdb -> prefix . strtolower($this -> pre) . "_" . $this -> controller;
		if (is_admin()) { $this -> check_table($this -> model); }
	
		if (!empty($data)) {
			foreach ($data as $dkey => $dval) {
				$this -> {$dkey} = stripslashes_deep($dval);
				
				switch ($dkey) {
					case 'id'					:
						$this -> galleries = array();
						$this -> gallery = array();
						
						$galleryslidesquery = "SELECT * FROM `" . $wpdb -> prefix . strtolower($this -> pre) . "_galleriesslides` WHERE `slide_id` = '" . $dval . "'";
						if ($galleryslides = $wpdb -> get_results($galleryslidesquery)) {
							foreach ($galleryslides as $galleryslide) {
								$this -> galleries[] = $galleryslide -> gallery_id;
								$this -> gallery[$galleryslide -> gallery_id] = $wpdb -> get_row("SELECT * FROM `" . $wpdb -> prefix . strtolower($this -> pre) . "_galleries` WHERE `id` = '" . $galleryslide -> gallery_id . "'");
							}
						}
						break;
					case 'image'				:
						$this -> image_path = 'wp-content/uploads/slideshow-gallery/' . $dval;
						break;
				}
			}
		}
		
		return true;
	}
	
	function defaults() {
		$defaults = array(
			'galleries'			=>	false,
			'order'				=>	0,
			'created'			=>	GalleryHtmlHelper::gen_date(),
			'modified'			=>	GalleryHtmlHelper::gen_date(),
		);
		
		return $defaults;
	}
	
	function validate($data = null) {
		$this -> errors = array();
	
		if (!empty($data)) {
			$data = (empty($data[$this -> model])) ? $data : $data[$this -> model];
			$data = stripslashes_deep($data);			
			extract($data, EXTR_SKIP);
			
			if (empty($title)) { $this -> errors['title'] = __('Please fill in a title', $this -> plugin_name); }
			//if (empty($description)) { $this -> errors['description'] = __('Please fill in a description', $this -> plugin_name); }
			if (empty($type)) { $this -> errors['type'] = __('Please select an image type', $this -> plugin_name); }
			elseif ($type == "file") {
				if (!empty($image_oldfile) && empty($_FILES['image_file']['name'])) {
					$imagename = $image_oldfile;
					$imagepath = ABSPATH . "wp-content" . DS . "uploads" . DS . $this -> plugin_name . DS;
					$imagefull = $imagepath . $imagename;
					
					$this -> data -> image = $imagename;
					$this -> data -> image_path = 'wp-content/uploads/slideshow-gallery/' . $imagename;
				} else {					
					if ($_FILES['image_file']['error'] <= 0) {
						$imagename = $_FILES['image_file']['name'];
						$imagepath = ABSPATH . 'wp-content' . DS . 'uploads' . DS . $this -> plugin_name . DS;
						$imagefull = $imagepath . $imagename;
						
						if (!is_uploaded_file($_FILES['image_file']['tmp_name'])) { $this -> errors['image_file'] = __('The image did not upload, please try again', $this -> plugin_name); }
						elseif (!move_uploaded_file($_FILES['image_file']['tmp_name'], $imagefull)) { $this -> errors['image_file'] = __('Image could not be moved from TMP to "wp-content/uploads/", please check permissions', $this -> plugin_name); }
						else {
							$this -> data -> image = $imagename;
							$this -> data -> image_path = 'wp-content/uploads/slideshow-gallery/' . $imagename;
						}
					} else {					
						switch ($_FILES['image_file']['error']) {
							case UPLOAD_ERR_INI_SIZE		:
							case UPLOAD_ERR_FORM_SIZE 		:
								$this -> errors['image_file'] = __('The image file is too large', $this -> plugin_name);
								break;
							case UPLOAD_ERR_PARTIAL 		:
								$this -> errors['image_file'] = __('The image was partially uploaded, please try again', $this -> plugin_name);
								break;
							case UPLOAD_ERR_NO_FILE 		:
								$this -> errors['image_file'] = __('No image was chosen for uploading, please choose an image', $this -> plugin_name);
								break;
							case UPLOAD_ERR_NO_TMP_DIR 		:
								$this -> errors['image_file'] = __('No TMP directory has been specified for PHP to use, please ask your hosting provider', $this -> plugin_name);
								break;
							case UPLOAD_ERR_CANT_WRITE 		:
								$this -> errors['image_file'] = __('Image cannot be written to disc, please ask your hosting provider', $this -> plugin_name);
								break;
						}
					}
				}
			} elseif ($type == "url") {
				if (empty($image_url)) { $this -> errors['image_url'] = __('Please specify an image', $this -> plugin_name); }
				else {
					if ($image = wp_remote_fopen($image_url)) {
						$filename = basename($image_url);
						$filepath = ABSPATH . 'wp-content' . DS . 'uploads' . DS . $this -> plugin_name . DS;
						$filefull = $filepath . $filename;
						
						if (!file_exists($filefull)) {
							$fh = @fopen($filefull, "w");
							@fwrite($fh, $image);
							@fclose($fh);
						}
					}
				}
			}
		} else {
			$this -> errors[] = __('No data was posted', $this -> plugin_name);
		}
		
		return $this -> errors;
	}
}

?>