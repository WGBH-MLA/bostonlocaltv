<?php

class GalleryPlugin {

	var $version = '1.2.2';
	var $plugin_name;
	var $plugin_base;
	var $pre = 'Gallery';
	
	var $menus = array();
	var $sections = array(
		'slides'			=>	'slideshow-slides',
		'galleries'			=>	'slideshow-galleries',
		'settings'			=>	'slideshow-settings',
	);
	
	var $helpers = array('Db', 'Html', 'Form', 'Metabox');
	var $models = array('Slide', 'Gallery', 'GallerySlides');
	
	var $debugging = false;		//set to "true" to turn on debugging
	var $debug_level = 2;		//set to 2 for PHP and DB errors or 1 for just DB errors

	function register_plugin($name, $base) {
		$this -> plugin_name = $name;
		$this -> plugin_base = rtrim(dirname($base), DS);
		$this -> sections = (object) $this -> sections;
		
		$this -> initialize_classes();
		$this -> initialize_options();
		
		global $wpdb;
		if ($this -> debugging == true) {
			$wpdb -> show_errors();
			
			if ($this -> debug_level == 2) {
				error_reporting(E_ALL ^ E_NOTICE);
				@ini_set('display_errors', 1);
			}
		} else {
			$wpdb -> hide_errors();
			error_reporting(0);
			@ini_set('display_errors', 0);
		}
		
		return true;
	}
	
	function init_class($name = null, $params = array()) {
		if (!empty($name)) {
			$name = $this -> pre . $name;
				
			if (class_exists($name)) {
				if ($class = new $name($params)) {							
					return $class;
				}
			}
		}
		
		$this -> init_class('Country');
		
		return false;
	}
	
	function initialize_classes() {	
		if (!empty($this -> helpers)) {
			foreach ($this -> helpers as $helper) {
				$hfile = dirname(__FILE__) . DS . 'helpers' . DS . strtolower($helper) . '.php';
				
				if (file_exists($hfile)) {
					require_once($hfile);
					
					if (empty($this -> {$helper}) || !is_object($this -> {$helper})) {
						$classname = $this -> pre . $helper . 'Helper';
						
						if (class_exists($classname)) {
							$this -> {$helper} = new $classname;
						}
					}
				} 
			}
		}
	
		if (!empty($this -> models)) {
			foreach ($this -> models as $model) {
				$mfile = dirname(__FILE__) . DS . 'models' . DS . strtolower($model) . '.php';
				
				if (file_exists($mfile)) {
					require_once($mfile);
					
					if (empty($this -> {$model}) || !is_object($this -> {$model})) {
						$classname = $this -> pre . $model;
						
						if (class_exists($classname)) {
							$this -> {$model} = new $classname;
						}
					}
				} 
			}
		}
	}
	
	function initialize_options() {
		if (!is_admin()) { return; }
	
		$styles = array(
			'width'				=>	"450",
			'height'			=>	"250",
			'border'			=>	"1px solid #CCCCCC",
			'background'		=>	"#000000",
			'infobackground'	=>	"#000000",
			'infocolor'			=>	"#FFFFFF",
			'resizeimages'		=>	"Y",
		);
		
		$this -> add_option('styles', $styles);
		
		//General Settings
		$this -> add_option('fadespeed', 10);
		$this -> add_option('shownav', "Y");
		$this -> add_option('navopacity', 25);
		$this -> add_option('navhover', 70);
		$this -> add_option('information', "Y");
		$this -> add_option('infospeed', 10);
		$this -> add_option('thumbnails', "N");
		$this -> add_option('thumbwidth', "100");
		$this -> add_option('thumbheight', "75");
		$this -> add_option('thumbposition', "bottom");
		$this -> add_option('thumbopacity', 70);
		$this -> add_option('thumbscrollspeed', 5);
		$this -> add_option('thumbspacing', 5);
		$this -> add_option('thumbactive', "#FFFFFF");
		$this -> add_option('autoslide', "Y");
		$this -> add_option('autospeed', 10);
		$this -> add_option('imagesthickbox', "N");
	}
	
	function render_msg($message = null) {
		$this -> render('msg-top', array('message' => $message), true, 'admin');
	}
	
	function render_err($message = null) {
		$this -> render('err-top', array('message' => $message), true, 'admin');
	}
	
	function redirect($location = null, $msgtype = null, $message = null) {
		$url = $location;
		
		if ($msgtype == "message") {
			$url .= '&' . $this -> pre . 'updated=true';
		} elseif ($msgtype == "error") {
			$url .= '&' . $this -> pre . 'error=true';
		}
		
		if (!empty($message)) {
			$url .= '&' . $this -> pre . 'message=' . urlencode($message);
		}
		
		?>
		
		<script type="text/javascript">
		window.location = '<?php echo (empty($url)) ? get_option('home') : $url; ?>';
		</script>
		
		<?php
		
		flush();
	}
	
	function paginate($model = null, $fields = '*', $sub = null, $conditions = null, $searchterm = null, $per_page = 10, $order = array('modified', "DESC")) {
		global $wpdb;
	
		if (!empty($model)) {
			global $paginate;
			$paginate = $this -> vendor('Paginate');
			$paginate -> table = $this -> {$model} -> table;
			$paginate -> sub = (empty($sub)) ? $this -> {$model} -> controller : $sub;
			$paginate -> fields = (empty($fields)) ? '*' : $fields;
			$paginate -> where = (empty($conditions)) ? false : $conditions;
			$paginate -> searchterm = (empty($searchterm)) ? false : $searchterm;
			$paginate -> per_page = $per_page;
			$paginate -> order = $order;
			
			$data = $paginate -> start_paging($_GET[$this -> pre . 'page']);
			
			if (!empty($data)) {
				$newdata = array();
			
				foreach ($data as $record) {
					$newdata[] = $this -> init_class($model, $record);
				}
				
				$data = array();
				$data[$model] = $newdata;
				$data['Paginate'] = $paginate;
			}
			
			return $data;
		}
		
		return false;
	}
	
	function vendor($name = null, $folder = null) {
		if (!empty($name)) {
			$filename = 'class.' . strtolower($name) . '.php';
			$filepath = rtrim(dirname(__FILE__), DS) . DS . 'vendors' . DS . $folder . '';
			$filefull = $filepath . $filename;
		
			if (file_exists($filefull)) {
				require_once($filefull);
				$class = 'Gallery' . $name;
				
				if (${$name} = new $class) {
					return ${$name};
				}
			}
		}
	
		return false;
	}
	
	function check_uploaddir() {
		$uploaddir = ABSPATH . 'wp-content' . DS . 'uploads' . DS . $this -> plugin_name . DS;
		$cachedir = $uploaddir . 'cache' . DS;
		
		if (!file_exists($uploaddir)) {
			if (@mkdir($uploaddir, 0777)) {
				@chmod($uploaddir, 0777);
				return true;
			} else {
				$message = sprintf(__('Uploads folder named "%s" cannot be created inside "%s"', $this -> plugin_name), $this -> plugin_name, "wp-content/uploads/");
				$this -> render_msg($message);
			}
		}
		
		if (!file_exists($cachedir)) {
			if (@mkdir($cachedir, 0777)) {
				@chmod($cachedir, 0777);
			} else {
				$message = sprintf(__('Slideshow cache folder "%s" for resizing images cannot be created inside "%s"', $this -> plugin_name), 'cache', 'wp-content/uploads/' . $this -> plugin_name . '/');
				$this -> render_msg($message);
			}
		}
		
		return false;
	}
	
	function add_action($action, $function = null, $priority = 10, $params = 1) {
		if (add_action($action, array($this, (empty($function)) ? $action : $function), $priority, $params)) {
			return true;
		}
		
		return false;
	}
	
	function add_filter($filter, $function = null, $priority = 10, $params = 1) {
		if (add_filter($filter, array($this, (empty($function)) ? $filter : $function), $priority, $params)) {
			return true;
		}
		
		return false;
	}
	
	function print_scripts() {
		$this -> enqueue_scripts();
	}
	
	function enqueue_scripts() {	
		wp_enqueue_script('jquery');
		
		if (is_admin()) {
			if (!empty($_GET['page']) && in_array($_GET['page'], (array) $this -> sections)) {			
				if ($_GET['page'] == 'slideshow-settings') {
					wp_enqueue_script('common');
					wp_enqueue_script('wp-lists');
					wp_enqueue_script('postbox');
					
					wp_enqueue_script('settings-editor', '/' . PLUGINDIR . '/' . $this -> plugin_name . '/js/settings-editor.js', array('jquery'), '1.0');
				}
				
				if ($_GET['page'] == "slideshow-slides" && $_GET['method'] == "order") {
					wp_enqueue_script('jquery-ui-sortable');
				}
			}
			
			wp_enqueue_script('colorbox', WP_PLUGIN_URL . '/' . $this -> plugin_name . '/js/colorbox.js', array('jquery'), '1.3.19');
			wp_enqueue_script($this -> plugin_name . 'admin', '/' . PLUGINDIR . '/' . $this -> plugin_name . '/js/admin.js', null, '1.0');
		} else {
			wp_enqueue_script($this -> plugin_name, '/' . PLUGINDIR . '/' . $this -> plugin_name . '/js/gallery.js', null, '1.0');
			
			if ($this -> get_option('imagesthickbox') == "Y") {
				wp_enqueue_script('colorbox', WP_PLUGIN_URL . '/' . $this -> plugin_name . '/js/colorbox.js', array('jquery'), '1.3.19');
			}
		}
		
		return true;
	}
	
	function get_css_url($attr = null) {
		$css_url = WP_PLUGIN_URL . '/' . $this -> plugin_name . '/css/gallery-css.php?';
		
		$default_attr = $this -> get_option('styles');
		$styles = wp_parse_args($attr, $default_attr);
		
		if (!empty($styles)) {	
			$s = 1;
			
			foreach ($styles as $skey => $sval) {
				$css_url .= $skey . '=' . urlencode($sval);
				if ($s < count($styles)) { $css_url .= '&'; }
				$s++;
			}
		}
		
		return $css_url;
	}
	
	function print_styles() {
		$this -> enqueue_styles();
	}
	
	function enqueue_styles() {
		if (is_admin()) {
			$src = WP_PLUGIN_URL . '/' . $this -> plugin_name . '/css/admin.css';			
			wp_enqueue_style($this -> plugin_name, $src, null, "1.0", "all");
		}
		
		$colorbox_src = WP_PLUGIN_URL . '/' . $this -> plugin_name . '/css/colorbox.css';
		wp_enqueue_style('colorbox', $colorbox_src, null, "1.3.19", "all");
	
		return true;
	}
	
	function plugin_base() {
		return rtrim(dirname(__FILE__), '/');
	}
	
	function url() {
		return rtrim(get_bloginfo('wpurl'), '/') . '/' . substr(preg_replace("/\\" . DS . "/si", "/", $this -> plugin_base()), strlen(ABSPATH));
	}
	
	function add_option($name = '', $value = '') {
		if (add_option($this -> pre . $name, $value)) {
			return true;
		}
		
		return false;
	}
	
	function update_option($name = null, $value = null) {
		if (update_option($this -> pre . $name, $value)) {
			return true;
		}
		
		return false;
	}
	
	function get_option($name = null, $stripslashes = true) {
		if ($option = get_option($this -> pre . $name)) {
			if (@unserialize($option) !== false) {
				return unserialize($option);
			}
			
			if ($stripslashes == true) {
				$option = stripslashes_deep($option);
			}
			
			return $option;
		}
		
		return false;
	}
	
	function debug($var = array()) {
		if ($this -> debugging) {
			echo '<pre>' . print_r($var, true) . '</pre>';
			return true;
		}
		
		return false;
	}
	
	function check_table($model = null) {
		global $wpdb;
	
		if (!empty($model)) {			
			if (!empty($this -> fields) && is_array($this -> fields)) {			
				if (!$wpdb -> get_var("SHOW TABLES LIKE '" . $this -> table . "'")) {				
					$query = "CREATE TABLE `" . $this -> table . "` (";
					$c = 1;
					
					foreach ($this -> fields as $field => $attributes) {
						if ($field != "key") {
							$query .= "`" . $field . "` " . $attributes . "";
						} else {
							$query .= "" . $attributes . "";
						}
						
						if ($c < count($this -> fields)) {
							$query .= ",";
						}
						
						$c++;
					}
					
					$query .= ") ENGINE=MyISAM AUTO_INCREMENT=1 CHARSET=UTF8;";
					
					if (!empty($query)) {
						$this -> table_query[] = $query;
					}
				} else {
					$field_array = $this -> get_fields($this -> table);
					
					foreach ($this -> fields as $field => $attributes) {					
						if ($field != "key") {
							$this -> add_field($this -> table, $field, $attributes);
						}
					}
				}
				
				if (!empty($this -> table_query)) {				
					require_once(ABSPATH . 'wp-admin' . DS . 'upgrade-functions.php');
					dbDelta($this -> table_query, true);
				}
			}
		}
		
		return false;
	}
	
	function get_fields($table = null) {	
		global $wpdb;
	
		if (!empty($table)) {
			$fullname = $table;
		
			if (($tablefields = mysql_list_fields(DB_NAME, $fullname, $wpdb -> dbh)) !== false) { 
				$columns = mysql_num_fields($tablefields);
				
				$field_array = array();
				for ($i = 0; $i < $columns; $i++) {
					$fieldname = mysql_field_name($tablefields, $i);
					$field_array[] = $fieldname;
				}
				
				return $field_array;
			}
		}
		
		return false;
	}
	
	function delete_field($table = null, $field = null) {
		global $wpdb;
		
		if (!empty($table)) {
			if (!empty($field)) {
				$query = "ALTER TABLE `" . $wpdb -> prefix . "" . $table . "` DROP `" . $field . "`";
				
				if ($wpdb -> query($query)) {
					return false;
				}
			}
		}
		
		return false;
	}
	
	function change_field($table = null, $field = null, $newfield = null, $attributes = "TEXT NOT NULL") {
		global $wpdb;
		
		if (!empty($table)) {		
			if (!empty($field)) {			
				if (!empty($newfield)) {
					$field_array = $this -> get_fields($table);
					
					if (!in_array($field, $field_array)) {
						if ($this -> add_field($table, $newfield)) {
							return true;
						}
					} else {
						$query = "ALTER TABLE `" . $table . "` CHANGE `" . $field . "` `" . $newfield . "` " . $attributes . ";";
						
						if ($wpdb -> query($query)) {
							return true;
						}
					}
				}
			}
		}
		
		return false;
	}
	
	function add_field($table = null, $field = null, $attributes = "TEXT NOT NULL") {
		global $wpdb;
	
		if (!empty($table)) {
			if (!empty($field)) {
				$field_array = $this -> get_fields($table);
				
				if (!empty($field_array)) {				
					if (!in_array($field, $field_array)) {					
						$query = "ALTER TABLE `" . $table . "` ADD `" . $field . "` " . $attributes . ";";
						
						if ($wpdb -> query($query)) {
							return true;
						}
					}
				}
			}
		}
		
		return false;
	}
	
	function render($file = null, $params = array(), $output = true, $folder = 'admin') {	
		if (!empty($file)) {
			$this -> plugin_name = 'slideshow-gallery';
			$this -> plugin_base = rtrim(dirname(__FILE__), DS);
		
			$filename = $file . '.php';
			$filepath = $this -> plugin_base() . DS . 'views' . DS . $folder . DS;
			$filefull = $filepath . $filename;
		
			if (file_exists($filefull)) {
				if (!empty($params)) {
					foreach ($params as $pkey => $pval) {
						${$pkey} = $pval;
					}
				}
			
				if ($output == false) {
					ob_start();
				}
				
				include($filefull);
				
				if ($output == false) {					
					$data = ob_get_clean();					
					return $data;
				} else {
					flush();
					return true;
				}
			}
		}
		
		return false;
	}
}

?>