<?php
/*
Plugin Name: JW Player Plugin for WordPress
Plugin URI: http://www.longtailvideo.com/
Description: Embed a JW Player for Flash into your WordPress articles.
Version: 1.4.2
Author: LongTail Video Inc.
Author URI: http://www.longtailvideo.com/

Copyright 2010  LongTail Video Inc.  (email : plugins@longtailvideo.com)

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License, version 2, as
published by the Free Software Foundation.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 */

global $wp_version;

define("JW_PLAYER_GA_VARS", "?utm_source=WordPress&utm_medium=Product&utm_campaign=WordPress");
define("JW_FILE_PERMISSIONS", 'For tips on how to make sure this folder is writable please refer to <a href="http://codex.wordpress.org/Changing_File_Permissions">http://codex.wordpress.org/Changing_File_Permissions</a>.');

// Check for WP2.7 installation
if (!defined ('IS_WP27')) {
  define('IS_WP27', version_compare($wp_version, '2.7', '>=') );
}

// This works only in WP2.7 or higher
if (IS_WP27 == FALSE) {
  add_action('admin_notices', create_function('', 'echo \'<div id="message" class="error fade"><p><strong>' . __('Sorry, the JWPlayer Plugin for WordPress works only under WordPress 2.7 or higher.') . '</strong></p></div>\';'));
  return;
}

// The plugin is only compatible with PHP 5.0 or higher
if (version_compare(phpversion(), "5.0", '<')) {
  add_action('admin_notices', create_function('', 'echo \'<div id="message" class="error fade"><p><strong>' . __('Sorry, the JWPlayer Plugin for WordPress only works with PHP Version 5 or higher.') . '</strong></p></div>\';'));
  return;
}

//Include core plugin files.
include_once (dirname (__FILE__) . "/framework/LongTailFramework.php");
include_once (dirname (__FILE__) . "/admin/AdminContext.php");
include_once (dirname (__FILE__) . "/media/JWMediaFunctions.php");
include_once (dirname (__FILE__) . "/media/JWShortcode.php");

register_activation_hook(__FILE__, "jwplayer_activation");

//Define the plugin directory and url for file access.
$uploads = wp_upload_dir();
if (isset($uploads["error"]) && !empty($uploads["error"])) {
  add_action('admin_notices', create_function('', 'echo \'<div id="message" class="fade updated"><p><strong>There was a problem completing activation of the JW Player Plugin for WordPress.  Please note that the JWPlayer Plugin for WordPress requires that the WordPress uploads directory exists and is writable.  ' . JW_FILE_PERMISSIONS . '</strong></p></div>\';'));
  return;
}
$isHttps = is_ssl();
$pluginURL = $isHttps ? str_replace("http://", "https://", WP_PLUGIN_URL) : WP_PLUGIN_URL;
$uploadsURL = $isHttps ? str_replace("http://", "https://", $uploads["baseurl"]) : $uploads["baseurl"];
define("JWPLAYER_PLUGIN_DIR", WP_PLUGIN_DIR . "/" . plugin_basename(dirname(__FILE__)));
define("JWPLAYER_PLUGIN_URL", $pluginURL . "/" . plugin_basename(dirname(__FILE__)));
define("JWPLAYER_FILES_DIR", $uploads["basedir"] . "/" . plugin_basename(dirname(__FILE__)));
define("JWPLAYER_FILES_URL", $uploadsURL . "/" . plugin_basename(dirname(__FILE__)));

if (!@is_dir(JWPLAYER_FILES_DIR)) {
  add_action('admin_notices', create_function('', 'echo \'<div id="message" class="fade updated"><p><strong>' . __('Activation of the JW Player Plugin for WordPress could not complete successfully.  The following directories could not be created automatically: </p><ul><li>- ' . JWPLAYER_FILES_DIR . '</li><li>- ' . JWPLAYER_FILES_DIR . '/configs</li><li>- ' . JWPLAYER_FILES_DIR . '/player</li></ul><p>Please ensure these directories are writable.  ' . JW_FILE_PERMISSIONS) . '</strong></p></div>\';'));
} else if (!file_exists(LongTailFramework::getPlayerPath())) {
  // Error if the player doesn't exist
  add_action('admin_notices', "jwplayer_install_notices");
}

function jwplayer_activation() {
  clearstatcache();
  if (!@is_dir(JWPLAYER_FILES_DIR)) {
    if (!@mkdir(JWPLAYER_FILES_DIR, 0755, true)) {
      add_action('admin_notices', create_function('', 'echo \'<div id="message" class="fade updated"><p><strong>' . __('There was a problem completing activation of the plugin.  The wp-content/uploads/jw-player-plugin-for-wordpress directory could not be created.  Please ensure the WordPress uploads directory is writable.  ' . JW_FILE_PERMISSIONS) . '</strong></p></div>\';'));
      return;
    }
    chmod(JWPLAYER_FILES_DIR, 0755);
    if (!@mkdir(JWPLAYER_FILES_DIR . "/player", 0755)) {
      add_action('admin_notices', create_function('', 'echo \'<div id="message" class="fade updated"><p><strong>' . __('There was a problem completing activation of the plugin.  The wp-content/uploads/jw-player-plugin-for-wordpress/player directory could not be created.  Please ensure the WordPress uploads directory is writable.  ' . JW_FILE_PERMISSIONS) . '</strong></p></div>\';'));
      return;
    }
    chmod(JWPLAYER_FILES_DIR . "/player", 0755);
    if (!@mkdir(JWPLAYER_FILES_DIR . "/configs", 0755)) {
      add_action('admin_notices', create_function('', 'echo \'<div id="message" class="fade updated"><p><strong>' . __('There was a problem completing activation of the plugin.  The wp-content/uploads/jw-player-plugin-for-wordpress/configs directory could not be created.  Please ensure the WordPress uploads directory is writable.  ' . JW_FILE_PERMISSIONS) . '</strong></p></div>\';'));
      return;
    }
    chmod(JWPLAYER_FILES_DIR . "/configs", 0755);
    if (@is_dir(JWPLAYER_PLUGIN_DIR . "/configs")) {
      foreach (get_old_configs() as $config) {
        @rename(JWPLAYER_PLUGIN_DIR . "/configs/$config.xml", JWPLAYER_FILES_DIR . "/configs/$config.xml");
      }
    }
  }
}

// Add JW Embedder for 5.3 players or higher.  Otherwise add swfobject.js from Google CDN.
if (version_compare(get_option(LONGTAIL_KEY . "version"), "5.3", ">=")) {
  wp_enqueue_script("jw-embedder", LongTailFramework::getEmbedderURL());
}

wp_deregister_script("swfobject");
wp_register_script("swfobject", 'http' . (is_ssl() ? 's' : '') . '://ajax.googleapis.com/ajax/libs/swfobject/2.2/swfobject.js',NULL,NULL);
wp_enqueue_script("swfobject");

add_filter("the_content", "jwplayer_tag_callback", 11);
add_filter("the_excerpt", "jwplayer_tag_excerpt_callback", 11);
add_filter("widget_text", "jwplayer_tag_widget_callback", 11);

// Player configuration and Media Management, limited to administrators.
if (is_admin()) {
  add_action( 'plugins_loaded', create_function( '', 'global $adminContext; $adminContext = new AdminContext();' ) );
  add_action("admin_menu", "jwplayer_plugin_menu");
  wp_register_script('jquery-ui-jw', $pluginURL . '/' . plugin_basename(dirname(__FILE__)) . "/js/jquery.ui.jw.js");
}

function jwplayer_install_notices() {
  if ($_GET["page"] == "jwplayer-update") {
    return;
  } ?>
  <div id="message" class="fade updated">
    <form name="<?php echo LONGTAIL_KEY . "install"; ?>" method="post" action="admin.php?page=jwplayer-update">
      <p>
        <strong><?php echo "To complete installation of the JW Player Plugin for WordPress, please click install.  "; ?></strong>
        <input class="button-secondary" type="submit" name="Install" value="Install Latest JW Player" />
      </p>
    </form>
  </div>
<?php }

// Build the admin and menu.
function jwplayer_plugin_menu() {
  $admin = add_menu_page("JW Player Title", "JW Player", "administrator", "jwplayer", "jwplayer_plugin_pages");
  add_submenu_page("jwplayer", "JW Player Plugin Licensing", "Licensing", "administrator", "jwplayer-license", "jwplayer_plugin_pages");
  $update = add_submenu_page("jwplayer", "JW Player Plugin Update", "Upgrade", "administrator", "jwplayer-update", "jwplayer_plugin_pages");
  add_action("admin_print_scripts-$admin", "add_admin_js");
}

// Add js for plugin tabs.
function add_admin_js() {
  wp_enqueue_script("jquery-ui-jw");
  echo '<link rel="stylesheet" href="'. WP_PLUGIN_URL . '/' . plugin_basename( dirname(__FILE__) ).'/' . 'css/smoothness/jquery.ui.jw.css" type="text/css" media="print, projection, screen" />'."\n";
}

// Entry point to the Player configuration wizard.
function jwplayer_plugin_pages() {
  switch ($_GET["page"]) {
    case "jwplayer" :
      global $adminContext;
      $adminContext->processState();
      break;
    case "jwplayer-license" :
      require_once (dirname(__FILE__) . "/admin/LicensePage.php");
      break;
    case "jwplayer-update" :
      require_once (dirname(__FILE__) . "/admin/UpdatePage.php");
      break;
  }
}

// Process xspf playlist requests.
function jwplayer_queryvars($query_vars) {
  $query_vars[] = 'xspf';
	return $query_vars;
}

// Parse xspf playlist requests.
function jwplayer_parse_request($wp) {
  if (array_key_exists('xspf', $wp->query_vars) && $wp->query_vars['xspf'] == 'true') {
  require_once (dirname (__FILE__) . '/media/JWPlaylistGenerator.php');
    exit();
  }
}

// Parse the $_GET vars for callbacks
add_filter('query_vars', 'jwplayer_queryvars' );
add_action('parse_request',  'jwplayer_parse_request', 9 );

add_action("wp_ajax_verify_player", "verify_player");

// Handles Ajax call with submitted player version
function verify_player() {
  $response = false;
  if ($_POST["version"] != "null") {
    $response = true;
    update_option(LONGTAIL_KEY . "version", $_POST["version"]);
  }
  echo (int) $response;
  exit;
}

// Grab existing configs for migration to new configs directory
function get_old_configs() {
  $results = array();
  $handler = @opendir(JWPLAYER_PLUGIN_DIR . "/configs");
  $results[] = "New Player";
  while ($file = @readdir($handler)) {
    if ($file != "." && $file != ".." && strstr($file, ".xml")) {
      $results[] = str_replace(".xml", "", $file);
    }
  }
  @closedir($handler);
  return $results;
}

?>