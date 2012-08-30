<?php
/**
 * The base configurations of the WordPress.
 *
 * This file has the following configurations: MySQL settings, Table Prefix,
 * Secret Keys, WordPress Language, and ABSPATH. You can find more information
 * by visiting {@link http://codex.wordpress.org/Editing_wp-config.php Editing
 * wp-config.php} Codex page. You can get the MySQL settings from your web host.
 *
 * This file is used by the wp-config.php creation script during the
 * installation. You don't have to use the web site, you can just copy this file
 * to "wp-config.php" and fill in the values.
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', 'bitnami_wordpress');

/** MySQL database username */
define('DB_USER', 'bn_wordpress');

/** MySQL database password */
define('DB_PASSWORD', '901ff4a1c5');

/** MySQL hostname */
define('DB_HOST', 'localhost:3306');

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
/* Substitute in built apliances */
define('AUTH_KEY',         '8430dd3f9f5b4803316456594af16f6a9bd245f1df09c08852e02052db7f1650');
define('SECURE_AUTH_KEY',  'd670b9332f78ede75651f75390e9727ca5a0e01c9ac5982022043bf2489b3e40');
define('LOGGED_IN_KEY',    '9736493555cb3bf7436609b108654fccecbae7fbdb0b1c87007e480c2775bf1c');
define('NONCE_KEY',        'ae6f6253218247456db744ed838fde200d90cb9724f9bc76f2b929016dcb36e9');
define('AUTH_SALT',        '0a6080fbcdf75b8ddc7048e53b2116ec17e7d2f75a0bdb60eb8cdf99b05cf1eb');
define('SECURE_AUTH_SALT', '005164d435ceef03a56758a8ab2eafb4ce1e479badfc2abea7a1003a28358a32');
define('LOGGED_IN_SALT',   '136c18d90b638c20d7aff4e286cffaa36933e9307b4c8c57a12c2887f0b1810a');
define('NONCE_SALT',       '48d10af7054a441ce68f1473ef1b4dda839d91e9998151b9a9bde4d7c0d3c6a4');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each a unique
 * prefix. Only numbers, letters, and underscores please!
 */
$table_prefix  = 'wp_';

/**
 * WordPress Localized Language, defaults to English.
 *
 * Change this to localize WordPress. A corresponding MO file for the chosen
 * language must be installed to wp-content/languages. For example, install
 * de_DE.mo to wp-content/languages and set WPLANG to 'de_DE' to enable German
 * language support.
 */
define('WPLANG', '');

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 */
define('WP_DEBUG', false);

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');
