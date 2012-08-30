<?php

class GalleryMetaboxHelper extends GalleryPlugin {

	var $name = 'Metabox';
	
	function GalleryMetaboxHelper() {
		$url = explode("&", $_SERVER['REQUEST_URI']);
		$this -> url = $url[0];
	}

	function settings_submit() {
		$this -> render('metaboxes' . DS . 'settings-submit', false, true, 'admin');
	}
	
	function settings_about() {
		$this -> render('metaboxes' . DS . 'settings-about', false, true, 'admin');
	}
	
	function settings_general() {
		$this -> render('metaboxes' . DS . 'settings-general', false, true, 'admin');
	}
	
	function settings_linksimages() {
		$this -> render('metaboxes' . DS . 'settings-linksimages', false, true, 'admin');	
	}
	
	function settings_styles() {
		$this -> render('metaboxes' . DS . 'settings-styles', false, true, 'admin');
	}
}

?>