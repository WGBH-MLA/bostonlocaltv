<?php
/**
 * The template for displaying the footer.
 *
 * Contains the closing of the id=main div and all content
 * after.  Calls sidebar-footer.php for bottom widgets.
 *
 * @package WordPress
 * @subpackage Twenty_Ten
 * @since Twenty Ten 1.0
 */
?>
	</div><!-- #main -->

	<div id="footer" role="contentinfo">
		<div id="colophon">
		    <p id="site-title">Boston TV News Digital Library: 1960&mdash;2000</p>
			<div id="footer-nav" role="navigation">
				<?php wp_nav_menu( array( 'container_class' => 'menu-header', 'theme_location' => 'footer-menu' ) ); ?>
			</div>
			<p id="copyright">&copy; 2011 WGBH</p>
			<div id="partner-logos">
                <!-- <img src="<?php echo get_stylesheet_directory_uri() ?>/images/bostonln_footer_berkman.jpg" width="940" height="110"> -->
                <img src="<?php echo get_stylesheet_directory_uri() ?>/images/logo-wgbh.png" width="94" height="83">
                <img src="<?php echo get_stylesheet_directory_uri() ?>/images/logo-cctv.png" width="90" height="83">
                <img src="<?php echo get_stylesheet_directory_uri() ?>/images/logo-bpl.png" width="57" height="83">
                <img src="<?php echo get_stylesheet_directory_uri() ?>/images/logo-nehf.png" width="61" height="83">
            </div>
<?php
	/* A sidebar in the footer? Yep. You can can customize
	 * your footer with four columns of widgets.
	 */
	get_sidebar( 'footer' );
?>

			<div id="site-info">
				<!-- <a href="<?php echo home_url( '/' ); ?>" title="<?php echo esc_attr( get_bloginfo( 'name', 'display' ) ); ?>" rel="home"> -->
					<!-- <?php bloginfo( 'name' ); ?> -->
                <!-- </a> -->
			</div><!-- #site-info -->

			<div id="site-generator">
				<?php do_action( 'twentyten_credits' ); ?>
				<!-- <a href="<?php echo esc_url( __( 'http://bitnami.org/stack/wordpress/', 'twentyten' ) ); ?>" title="<?php esc_attr_e( 'Semantic Personal Publishing Platform', 'twentyten' ); ?>" rel="generator"><?php printf( __( 'Proudly powered by %s.', 'twentyten' ), 'BitNami WordPress' ); ?></a> -->
			</div><!-- #site-generator -->

		</div><!-- #colophon -->
	</div><!-- #footer -->

</div><!-- #wrapper -->

<?php
	/* Always have wp_footer() just before the closing </body>
	 * tag of your theme, or you will break many plugins, which
	 * generally use this hook to reference JavaScript files.
	 */

	wp_footer();
?>
</body>
</html>
