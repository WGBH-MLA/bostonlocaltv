<?php

/*
Plugin Name: Slideshow Gallery
Plugin URI: http://wpgallery.tribulant.net
Author: Tribulant Software
Author URI: http://tribulant.com
Description: Feature content in a JavaScript powered slideshow gallery showcase on your WordPress website. The slideshow is flexible and all aspects can easily be configured. Embedding or hardcoding the slideshow gallery is a breeze. To embed into a post/page, simply insert <code>[slideshow]</code> into its content with an optional <code>post_id</code> parameter. To hardcode into any PHP file of your WordPress theme, simply use <code>&lt;?php if (class_exists('Gallery')) { $Gallery = new Gallery(); $Gallery -> slideshow($output = true, $post_id = null); } ?&gt;</code> and specify the required <code>$post_id</code> parameter accordingly.
Version: 1.2.2
*/

define('DS', DIRECTORY_SEPARATOR);
require_once(dirname(__FILE__) . DS . 'slideshow-gallery-plugin.php');

if (!class_exists('Gallery')) {
	class Gallery extends GalleryPlugin {
		
		function Gallery() {
			$url = explode("&", $_SERVER['REQUEST_URI']);
			$this -> url = $url[0];
			$this -> referer = (empty($_SERVER['HTTP_REFERER'])) ? $this -> url : $_SERVER['HTTP_REFERER'];
			
			$this -> register_plugin('slideshow-gallery', __FILE__);
			
			//WordPress action hooks
			$this -> add_action('wp_head');
			$this -> add_action('admin_menu');
			$this -> add_action('admin_head');
			$this -> add_action('admin_notices');
			$this -> add_action('wp_print_styles', 'print_styles');
			$this -> add_action('admin_print_styles', 'print_styles');
			$this -> add_action('wp_print_scripts', 'print_scripts');
			$this -> add_action('admin_print_scripts', 'print_scripts');
			$this -> add_action('init', 'init_textdomain', 10, 1);
			
			//WordPress filter hooks
			$this -> add_filter('mce_buttons');
			$this -> add_filter('mce_external_plugins');
			
			add_shortcode('slideshow', array($this, 'embed'));
		}
		
		function init_textdomain() {		
			if (function_exists('load_plugin_textdomain')) {
				load_plugin_textdomain($this -> plugin_name, $this -> plugin_name . DS . 'languages', dirname(plugin_basename(__FILE__)) . DS . 'languages');
			}	
		}
		
		function wp_head() {
			if ($this -> get_option('imagesthickbox') == "Y") {
		
				?>
		        
		        <script type="text/javascript">		
				jQuery(document).ready(function() {
					jQuery('.colorbox').colorbox({maxWidth:'100%', maxHeight:'100%'});
				});
				</script>
		        
		        <?php
		    }
		}
		
		function admin_menu() {
			add_menu_page(__('Slideshow', $this -> plugin_name), __('Slideshow', $this -> plugin_name), 10, $this -> sections -> slides, array($this, 'admin_slides'), $this -> url() . '/images/icon.png');
			$this -> menus['slideshow-slides'] = add_submenu_page($this -> sections -> slides, __('Manage Slides', $this -> plugin_name), __('Manage Slides', $this -> plugin_name), 10, $this -> sections -> slides, array($this, 'admin_slides'));
			$this -> menus['slideshow-galleries'] = add_submenu_page($this -> sections -> slides, __('Manage Galleries', $this -> plugin_name), __('Manage Galleries', $this -> plugin_name), 10, $this -> sections -> galleries, array($this, 'admin_galleries'));
			$this -> menus['slideshow-settings'] = add_submenu_page($this -> sections -> slides, __('Configuration', $this -> plugin_name), __('Configuration', $this -> plugin_name), 10, $this -> sections -> settings, array($this, 'admin_settings'));
			
			add_action('admin_head-' . $this -> menus['slideshow-settings'], array($this, 'admin_head_gallery_settings'));
		}
		
		function admin_head() {
			$this -> render('head', false, true, 'admin');
		}
		
		function admin_head_gallery_settings() {		
			add_meta_box('submitdiv', __('Save Settings', $this -> plugin_name), array($this -> Metabox, "settings_submit"), $this -> menus['slideshow-settings'], 'side', 'core');
			add_meta_box('aboutdiv', __('About Us', $this -> plugin_name), array($this -> Metabox, "settings_about"), $this -> menus['slideshow-settings'], 'side', 'core');
			add_meta_box('generaldiv', __('General Settings', $this -> plugin_name), array($this -> Metabox, "settings_general"), $this -> menus['slideshow-settings'], 'normal', 'core');
			add_meta_box('linksimagesdiv', __('Links &amp; Images Overlay', $this -> plugin_name), array($this -> Metabox, "settings_linksimages"), $this -> menus['slideshow-settings'], 'normal', 'core');
			add_meta_box('stylesdiv', __('Appearance &amp; Styles', $this -> plugin_name), array($this -> Metabox, "settings_styles"), $this -> menus['slideshow-settings'], 'normal', 'core');
			
			do_action('do_meta_boxes', $this -> menus['slideshow-settings'], 'normal');
			do_action('do_meta_boxes', $this -> menus['slideshow-settings'], 'side');
		}
		
		function admin_notices() {
			$this -> check_uploaddir();
		
			if (!empty($_GET[$this -> pre . 'message'])) {		
				$msg_type = (!empty($_GET[$this -> pre . 'updated'])) ? 'msg' : 'err';
				call_user_method('render_' . $msg_type, $this, $_GET[$this -> pre . 'message']);
			}
		}
		
		function mce_buttons($buttons) {
			array_push($buttons, "separator", "gallery");
			return $buttons;
		}
		
		function mce_external_plugins($plugins) {
			$plugins['gallery'] = $this -> url() . '/js/tinymce/editor_plugin.js';
			return $plugins;
		}
		
		function slideshow($output = true, $post_id = null, $exclude = null) {		
			global $wpdb;
			
			if (!empty($post_id) && $post = get_post($post_id)) {
				if ($attachments = get_children("post_parent=" . $post -> ID . "&post_type=attachment&post_mime_type=image&orderby=menu_order ASC, ID ASC")) {
					if (!empty($exclude)) {
						$exclude = array_map('trim', explode(',', $exclude));
						
						$a = 0;
						foreach ($attachments as $id => $attachment) {
							
							$a++;
							if (in_array($a, $exclude)) {
								unset($attachments[$id]);
							}
						}
					}
				
					$content = $this -> render('gallery', array('slides' => $attachments, 'frompost' => true), false, 'default');
				}
			} else {
				$slides = $this -> Slide -> find_all(null, null, array('order', "ASC"));
				$content = $this -> render('gallery', array('slides' => $slides, 'frompost' => false), false, 'default');
			}
			
			if ($output) { echo $content; } else { return $content; }
		}
		
		function embed($atts = array(), $content = null) {
			//global variables
			global $wpdb;
			$styles = $this -> get_option('styles');
		
			// default shortcode parameters
			$defaults = array(
				'gallery_id'			=>	false,
				'orderby'				=>	array('order', "ASC"),
				'resizeimages'			=>	(($styles['resizeimages'] == "Y") ? "true" : "false"),
				'width'					=>	($styles['width']),
				'height'				=>	($styles['height']),
				'auto'					=>	(($this -> get_option('autoslide') == "Y") ? "true" : "false"),
				'autospeed'				=>	($this -> get_option('autospeed')),
				'fadespeed'				=>	($this -> get_option('fadespeed')),
				'shownav'				=>	(($this -> get_option('shownav') == "Y") ? "true" : "false"),
				'navopacity'			=>	($this -> get_option('navopacity')),
				'navhoveropacity'		=>	($this -> get_option('navhover')),
				'showinfo'				=>	(($this -> get_option('information') == "Y") ? "true" : "false"),
				'infospeed'				=>	($this -> get_option('infospeed')),
				'showthumbs'			=>	(($this -> get_option('thumbnails') == "Y") ? "true" : "false"),
				'thumbsposition'		=>	($this -> get_option('thumbposition')),
				'thumbsborder'			=>	($this -> get_option('thumbactive')),
				'thumbsspeed'			=>	($this -> get_option('thumbscrollspeed')),
				'thumbsspacing'			=>	($this -> get_option('thumbspacing')),
				'post_id' 				=> 	null, 
				'exclude' 				=> 	null, 
				'custom' 				=> 	null,
			);
					
			$s = shortcode_atts($defaults, $atts);
			extract($s);
			
			// if this is an RSS/Atom feed, it should not continue...
			if (is_feed()) { return false; }
			
			if (!empty($gallery_id)) {
				if (!is_array($orderby) || $orderby == "random") {
					$orderbystring = "ORDER BY RAND()";
				} else {
					list($orderf, $orderd) = $orderby;
					$orderbystring = "ORDER BY " . $this -> Slide -> table . "." . $orderf . " " . $orderd . "";
				}
			
				$slidesquery = "SELECT * FROM " . $this -> Slide -> table . " LEFT JOIN " . $this -> GallerySlides -> table . 
				" ON " . $this -> Slide -> table . ".id = " . $this -> GallerySlides -> table . ".slide_id WHERE " . 
				$this -> GallerySlides -> table . ".gallery_id = '" . $gallery_id . "' " . $orderbystring;
				
				if ($slides = $wpdb -> get_results($slidesquery)) {
					foreach ($slides as $skey => $slide) {
						$slides[$skey] -> image_path = 'wp-content/uploads/slideshow-gallery/' . $slide -> image;
					}
				
					$content = $this -> render('gallery', array('slides' => $slides, 'options' => $s, 'frompost' => false), false, 'default');	
				}
			} elseif (!empty($custom) || empty($post_id)) {
				$slides = $this -> Slide -> find_all(null, null, $orderby);
				
				if (!empty($exclude)) {
					$exclude = array_map('trim', explode(',', $exclude));
					
					foreach ($slides as $slide_key => $slide) {
						if (in_array($slide -> id, $exclude)) {
							unset($slides[$slide_key]);
						}
					}
				}
				
				$content = $this -> render('gallery', array('slides' => $slides, 'options' => $s, 'frompost' => false), false, 'default');
			} else {
				global $post;
				$pid = (empty($post_id)) ? $post -> ID : $post_id;
			
				if (!empty($pid) && $post = get_post($pid)) {
					if ($attachments = get_children("post_parent=" . $post -> ID . "&post_type=attachment&post_mime_type=image&orderby=" . ((!empty($orderby) && $orderby == "random") ? "rand" : "menu_order ASC, ID ASC"))) {
						if (!empty($exclude)) {
							$exclude = array_map('trim', explode(',', $exclude));
							
							$a = 0;
							foreach ($attachments as $id => $attachment) {
								
								$a++;
								if (in_array($a, $exclude)) {
									unset($attachments[$id]);
								}
							}
						}
					
						$content = $this -> render('gallery', array('slides' => $attachments, 'options' => $s, 'frompost' => true), false, 'default');
					}
				}
			}
			
			return $content;
		}
		
		function admin_slides() {	
			switch ($_GET['method']) {
				case 'delete'			:
					if (!empty($_GET['id'])) {
						if ($this -> Slide -> delete($_GET['id'])) {
							$msg_type = 'message';
							$message = __('Slide has been removed', $this -> plugin_name);
						} else {
							$msg_type = 'error';
							$message = __('Slide cannot be removed', $this -> plugin_name);	
						}
					} else {
						$msg_type = 'error';
						$message = __('No slide was specified', $this -> plugin_name);
					}
					
					$this -> redirect($this -> referer, $msg_type, $message);
					break;
				case 'save'				:
					if (!empty($_POST)) {
						if ($this -> Slide -> save($_POST, true)) {
							$message = __('Slide has been saved', $this -> plugin_name);
							$this -> redirect($this -> url, "message", $message);
						} else {
							$this -> render('slides' . DS . 'save', false, true, 'admin');
						}
					} else {
						$this -> Db -> model = $this -> Slide -> model;
						$this -> Slide -> find(array('id' => $_GET['id']));
						$this -> render('slides' . DS . 'save', false, true, 'admin');
					}
					break;
				case 'mass'				:
					if (!empty($_POST['action'])) {
						if (!empty($_POST['Slide']['checklist'])) {						
							switch ($_POST['action']) {
								case 'delete'				:							
									foreach ($_POST['Slide']['checklist'] as $slide_id) {
										$this -> Slide -> delete($slide_id);
									}
									
									$message = __('Selected slides have been removed', $this -> plugin_name);
									$this -> redirect($this -> url, 'message', $message);
									break;
							}
						} else {
							$message = __('No slides were selected', $this -> plugin_name);
							$this -> redirect($this -> url, "error", $message);
						}
					} else {
						$message = __('No action was specified', $this -> plugin_name);
						$this -> redirect($this -> url, "error", $message);
					}
					break;
				case 'order'			:
					$slides = $this -> Slide -> find_all(null, null, array('order', "ASC"));
					$this -> render('slides' . DS . 'order', array('slides' => $slides), true, 'admin');
					break;
				default					:
					$data = $this -> paginate('Slide');				
					$this -> render('slides' . DS . 'index', array('slides' => $data[$this -> Slide -> model], 'paginate' => $data['Paginate']), true, 'admin');
					break;
			}
		}
		
		function admin_galleries() {
			
			switch ($_GET['method']) {
				case 'save'						:
					if (!empty($_POST)) {
						if ($this -> Gallery -> save($_POST, true)) {
							$message = __('Gallery has been saved', $this -> plugin_name);
							$this -> redirect($this -> url, "message", $message);
						} else {
							$this -> render('galleries' . DS . 'save', false, true, 'admin');
						}
					} else {
						$this -> Db -> model = $this -> Gallery -> model;
						$this -> Gallery -> find(array('id' => $_GET['id']));
						$this -> render('galleries' . DS . 'save', false, true, 'admin');
					}
					break;
				case 'view'						:
					$this -> Db -> model = $this -> Gallery -> model;
					$gallery = $this -> Gallery -> find(array('id' => $_GET['id']));
					$data = $this -> paginate('GallerySlides', "*", false, array('gallery_id' => $gallery -> id));
					
					$data['Slide'] = array();
					if (!empty($data[$this -> GallerySlides -> model])) {
						foreach ($data[$this -> GallerySlides -> model] as $galleryslide) {
							$this -> Db -> model = $this -> Slide -> model;
							$data['Slide'][] = $this -> Slide -> find(array('id' => $galleryslide -> slide_id));
						}
					}
					
					$this -> render('galleries' . DS . 'view', array('gallery' => $gallery, 'slides' => $data[$this -> Slide -> model], 'paginate' => $data['Paginate']), true, 'admin');
					break;
				case 'hardcode'			:
					$this -> Db -> model = $this -> Gallery -> model;
					$gallery = $this -> Gallery -> find(array('id' => $_GET['id']));					
					$this -> render('galleries' . DS . 'hardcode', array('gallery' => $gallery), true, 'admin');
					break;
				case 'delete'			:
					if (!empty($_GET['id'])) {
						if ($this -> Gallery -> delete($_GET['id'])) {
							$msg_type = 'message';
							$message = __('Gallery has been removed', $this -> plugin_name);
						} else {
							$msg_type = 'error';
							$message = __('Gallery cannot be removed', $this -> plugin_name);	
						}
					} else {
						$msg_type = 'error';
						$message = __('No gallery was specified', $this -> plugin_name);
					}
					
					$this -> redirect($this -> referer, $msg_type, $message);
					break;
				case 'mass'				:
					if (!empty($_POST['action'])) {
						if (!empty($_POST['Gallery']['checklist'])) {						
							switch ($_POST['action']) {
								case 'delete'				:							
									foreach ($_POST['Gallery']['checklist'] as $gallery_id) {
										$this -> Gallery -> delete($gallery_id);
									}
									
									$message = __('Selected galleries have been removed', $this -> plugin_name);
									$this -> redirect($this -> url, 'message', $message);
									break;
							}
						} else {
							$message = __('No slides were selected', $this -> plugin_name);
							$this -> redirect($this -> url, "error", $message);
						}
					} else {
						$message = __('No action was specified', $this -> plugin_name);
						$this -> redirect($this -> url, "error", $message);
					}
					break;
				default							:
					$data = $this -> paginate('Gallery');
					$this -> render('galleries' . DS . 'index', array('galleries' => $data[$this -> Gallery -> model], 'paginate' => $data['Paginate']), true, 'admin');
					break;
			}
		}
		
		function admin_settings() {
			switch ($_GET['method']) {
				case 'reset'			:
					global $wpdb;
					$query = "DELETE FROM `" . $wpdb -> prefix . "options` WHERE `option_name` LIKE '" . $this -> pre . "%';";
					
					if ($wpdb -> query($query)) {
						$message = __('All configuration settings have been reset to their defaults', $this -> plugin_name);
						$msg_type = 'message';
						$this -> render_msg($message);	
					} else {
						$message = __('Configuration settings could not be reset', $this -> plugin_name);
						$msg_type = 'error';
						$this -> render_err($message);
					}
					
					$this -> redirect($this -> url, $msg_type, $message);
					break;
				default					:
					if (!empty($_POST)) {
						foreach ($_POST as $pkey => $pval) {					
							$this -> update_option($pkey, $pval);
						}
						
						$message = __('Configuration has been saved', $this -> plugin_name);
						$this -> render_msg($message);
					}	
					break;
			}
					
			$this -> render('settings', false, true, 'admin');
		}
	}
}

//initialize a Gallery object
$Gallery = new Gallery();

if (!function_exists('slideshow')) {
	function slideshow($output = true, $gallery_id = null, $post_id = null, $params = array()) {
		$params['gallery_id'] = $gallery_id;
		$params['post_id'] = $post_id;
	
		$Gallery = new Gallery();
		$content = $Gallery -> embed($params, false);
		
		if ($output == true) {
			echo $content;
		} else {
			return $content;
		}
	}
}

?>