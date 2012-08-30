=== Slideshow Gallery ===
Contributors: contrid
Donate link: http://tribulant.com/
Tags: wordpress plugins, wordpress slideshow gallery, slides, slideshow, image gallery, images, gallery, featured content, content gallery, javascript, javascript slideshow, slideshow gallery
Requires at least: 2.9
Tested up to: 3.3.2
Stable tag: 1.2.2

Feature content in a JavaScript powered slideshow gallery showcase on your WordPress website

== Description ==

Feature content in a JavaScript powered slideshow gallery showcase on your WordPress website.

You can easily display multiple galleries throughout your WordPress website displaying your custom added slides, slide galleries or showing slides from WordPress posts.

The slideshow is flexible and all aspects can easily be configured.

Embedding or hardcoding the slideshow gallery is a breeze. To embed into a post/page, simply insert `[slideshow]` into its content with an optional `gallery_id` parameter to show slides from a specific gallery `[slideshow gallery_id="7"]` or an optional `post_id` parameter to display the gallery images uploaded to that post/page `[slideshow post_id="123"]`. You can also use an `exclude` parameter to exclude certain images (attachments/slides) by their IDs in the gallery (comma separated) from the slideshow like this `[slideshow post_id="123" exclude="3,7,9"]`. 

To hardcode into any PHP file of your WordPress theme, simply use `<?php if (function_exists('slideshow')) { slideshow($output = true, $gallery_id = false, $post_id = false, $params = array()); } ?>`.

You can use any of the following parameters with both the hardcoding and shortcode to customize each slideshow gallery:

* `resizeimages` [ true | false ] = Set to 'true' to resize images to fit the slideshow dimensions.
* `orderby` [ random ] = Set to 'random' to randomly order the slides. Leave this shortcode parameter to order by the order set on the slides.
* `width` [ width | auto ] = Width of the slideshow in pixels. Don't specify 'px' part, just the numeric value for the height.
* `height` [ height ] (default: setting) = Height of the slideshow in pixels. Don't specify the 'px' part, just the numeric value for the height.
* `auto` [ true | false ] (default: setting) = Set this to 'true' to automatically slide the slides in the slideshow.
* `autospeed` [ speed ] (default: setting) = Speed of the auto sliding. 10 is normal. Lower number is faster. Between 5 and 15 is recommended.
* `fadespeed` [ speed ] (default: setting) = Speed of the fading of images. 10 is normal. Lower number is faster. Between 1 and 20 is recommended.
* `shownav` [ true | false ] (default: setting) = Set to 'true' to show the next/previous image navigation buttons.
* `navopacity` [ opacity ] (default: setting) = The opacity of the next/previous buttons. Between 0 and 100 with 0 being transparent and 100 being fully opaque.
* `navhoveropacity` [ opacity ] (default: setting) = The opacity of the next/previous buttons on hovering. Between 0 and 100 with 0 being transparent and 100 being fully opaque.
* `showinfo` [ true | false ] (default: setting) = Set to 'true' to show the information bar for each slide.
* `infospeed` [ speed ] (default: setting) = Speed at which the information bar will slide up. Between 5 and 15 is recommended.
* `showthumbs` [ true | false ] (default: setting) = Set to 'true' to show the thumbnails for the slides.
* `thumbsposition` [ top | bottom ] (default: setting) = Set to "top" to show above the slideshow.
* `thumbsborder` [ hexidecimal color ] (default: setting) = Hex color of the active thumb border. For example #333333.
* `thumbsspeed` [ speed> ] (default: setting) = Speed of the thumbnail bar scrolling. Lower is slower. Between 1 and 20 is recommended.
* `thumbsspacing` [ spacing ] (default: setting) = An integer value in pixels to space the thumbnails apart. Don’t include the 'px' part, just the number. Between 0 and 10 is recommended.

== Installation ==

Installing the WordPress slideshow gallery plugin is very easy. Simply follow the steps below.

1. Extract the package to obtain the `slideshow-gallery` folder
1. Upload the `slideshow-gallery` folder to the `/wp-content/plugins/` directory
1. Activate the plugin through the 'Plugins' menu in WordPress
1. Configure the settings according to your needs through the 'Slideshow' > 'Configuration' menu
1. Add and manage your slides in the 'Slideshow' section
1. Put `[slideshow post_id="X" exclude=""]` to embed a slideshow with the images of a post into your posts/pages or use `[slideshow gallery_id="X"]` to display the slides of a specific gallery by ID or use `[slideshow]` to embed a slideshow with your custom added slides or `<?php if (function_exists('slideshow')) { slideshow($output = true, $gallery_id = false, $post_id = false, $params = array()); } ?>` into your WordPress theme using PHP code.

== Frequently Asked Questions ==

= Can I display/embed multiple instances of the slideshow gallery? =

Yes, you can, but only one slideshow per page.

= How can I display specific slides in a slideshow gallery instance? =

You can organize slides either into multiple galleries according to your needs or you can upload images to WordPress posts and display the images uploaded to a post.

= How do I display the images uploaded to a post? =

You can embed a slideshow and show the images uploaded to a post with the `post_id` parameter. Like this `[slideshow post_id="123"]`.

= Can I exclude certain images from a post in the slideshow? =

Yes, you can use the `exclude` parameter to exclude post images by their order in the gallery (comma separated) like this `[slideshow post_id="123" exclude="2,4,8"]`.

== Screenshots ==

1. Slideshow gallery with thumbnails at the bottom.
2. Slideshow gallery with thumbnails turned OFF.
3. Slideshow gallery with thumbnails at the top.
4. Different styles/colors.
5. TinyMCE editor button to insert shortcodes.
6. Turn on Thickbox to show enlarged images in an overlay.

== Changelog ==

= 1.2.2 =
* FIX: Slides paging numbers didn't show up
* REMOVE: 'Description' not mandatory/required for each slide.
* FIX: Slashes caused by single/double quotes in titles/descriptions
* ADD: Hardcode for each gallery in 'Manage Galleries' section
* ADD: Shortcode in the 'Manage Galleries' section for each gallery
* ADD: Gallery ID to the 'Manage Galleries' section
* FIX: the 100% width issue on the 'img' tag if resizeimages = false
* IMPROVE: Change cache directory to "wp-content/uploads/slideshow-gallery/cache" for TimThumb

= 1.2.1 = 
* FIX: Thumbnails On/Off setting doesn't work
* IMPROVE: TimThumb absolute URLs to prevent permission problems
* FIX: Colorbox script should only load with this featured turned on

= 1.2 =
* ADD: 'About Us' box in the Configuration section
* IMPROVE: Better, more usable hardcoding procedure
* FIX: Slideshow goes left
* IMPROVE: auto width property
* ADD: Banner image for WordPress.org directory
* IMPROVE: Use load_plugin_textdomain instead for language file
* ADD: Order slides by random?
* FIX: Enqueue scripts/styles at the right time
* ADD: Link target (current/new window) setting on each slide for link
* IMPROVE: Hide next/previous navigation when there is only one slide
* ADD: TimThumb integration for cropping images
* CHANGE: Colorbox for popup images
* ADD: 'Open' link to test slide links
* ADD: Icon in each section of the plugin
* CHANGE: Author name on WordPress.org to link appropriately
* ADD: Dimensions for thumbnail images
* CHANGE: New icon image for the admin menu
* IMPROVE: Change 1=1 for the CSS
* FIX: Code showing in the RSS feed.
* ADD: Shortcode parameters
* ADD: Multiple slideshows per post/page
* ADD: Setting to turn off the next/previous navigation
* IMPROVE: "Previous Image" and "Next Image" in language file
* FIX: Not all thumbnails load the first time
* IMPROVE: Remove black borders left and right of the image
* IMPROVE: Removed link overlay which displayed white in IE6

= 1.1 =
* ADDED: "THIS POST" added to the TinyMCE dialog to insert a shortcode for a slideshow of the current post
* IMPROVED: Some CSS improvements to the slideshow
* ADDED: Thickbox to show images in overlay. Can be turned On/Off
* FIXED: Fixed all thumbnails not preloading on first load
* FIXED: Slide HREF in IE
* ADDED: Spinner loading indicator to show the slideshow is loading up
* ADDED: "Link" column in the "Manage Slides" section
* FIXED: Load Thickbox on the 'Manage Slides' page for the enlargements
* ADDED: Ability to upload an image when saving a slide rather than specifying a URL
* ADDED: Row actions in the 'Manage Slides' section

= 1.0.4 =
* IMPROVED: WordPress 2.9 sortable meta boxes.
* FIXED: `wp_redirect()` fatal error in dashboard.
* ADDED: TinyMCE editor button to quickly insert slideshows into posts/pages.
* ADDED: `exclude` parameter to use in conjunction with the `post_id` parameter to exclude attachments by order.
* CHANGED: Changed `#wrapper` in the HTML markup to `#slideshow-wrapper` due to some theme conflicts.

= 1.0.4 =
* COMPATIBILITY: WordPress 2.9
* FIXED: #fullsize z-index to keep below other elements such as drop down menus.

= 1.0.3 =
* ADDED: Default, English language file in the `languages` folder.
* ADDED: Configuration setting to turn On/Off resizing of images via CSS.
* ADDED: Webkit border radius in CSS for thumbnail images.
* ADDED: `post_id` parameter for the `[slideshow]` shortcode to display images from a post/page.
* IMPROVED: Plugin doesn't utilize PHP short open tags anymore.
* COMPATIBILITY: Removed `autoLoad` (introduced in PHP 5) parameter from `class_exists` function for PHP 4 compatibility.
* IMPROVED: Directory separator constant DS from DIRECTORY_SEPARATOR.

= 1.0 =
* Initial release of the WordPress Slideshow Gallery plugin