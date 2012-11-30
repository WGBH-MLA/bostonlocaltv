<?php
/*
Template Name: PageOfChildPages
*/

get_header(); ?>

<div class="banner feature-container">
    <?php
        global $post;
        $myposts = get_posts(array('post_parent' => 1264, 'post_type' => 'page'));
        foreach ( $myposts as $post ) :
            setup_postdata($post);
    ?>
    <div <?php post_class(array(get_post_custom_values('class'), 'home-page-feature')) ?> id="post-<?php the_ID(); ?>">
        <!--
        <h3><?php the_title(); ?></h3>
        <a href="<?php if(get_post_meta($post->ID, 'url', true)) { echo get_post_meta($post->ID, 'url', true); } else { the_permalink(); } ?>" class="featured_image">
            <span class="border-overlay">&nbsp;</span>
            <span class="caption"><?php $tn = get_the_post_thumbnail(); echo get_the_title(get_post_thumbnail_id()); ?></span>
            <?php echo $tn; ?>
        </a>
        -->
        <?php the_content(); ?>
        <div id="feature-text">
            <p><b>Explore collections &mdash;&gt; Vote!</b><br />Welcome to the Boston TV News Digital Library.  Explore the CCTV, Ten O’Clock News, WHDH and WCVB Collections.  You can add information and vote for the records you would like to be digitized.</p>
           </br> <a href="/collections"><img src="<?php echo get_stylesheet_directory_uri() ?>/images/button-browse-h.png"></a>
        </div>
    </div>
    <?php endforeach; ?>
</div>

<div id="container">
<div id="content">

<?php
  $paged = (get_query_var('paged')) ? get_query_var('paged') : 1;
  $post_per_page = -1; // -1 shows all posts
  $do_not_show_stickies = 0; // 0 to show stickies
  $args=array(
    'post_parent' => $posts[0]->ID, 'post_type' => 'page', 'orderby' => 'menu_order', 'order' => 'ASC'
  );
  $temp = $wp_query;  // assign orginal query to temp variable for later use   
  $wp_query = null;
  $wp_query = new WP_Query($args); 
  $last = end($wp_query->posts);
  $wp_query = $temp;  //reset back to original query
?>

<!--      <hr class="section-break" /> -->
<div class="section">
<?php
  $paged = (get_query_var('paged')) ? get_query_var('paged') : 1;
  $post_per_page = -1; // -1 shows all posts
  $do_not_show_stickies = 0; // 0 to show stickies
  $args=array(
    'category_name' => 'uncategorized', 'posts_per_page' => 3 
  );
  $temp = $wp_query;  // assign orginal query to temp variable for later use   
  $wp_query = null;
  $wp_query = new WP_Query($args); 
  $last = end($wp_query->posts);
  if( have_posts() ) : 
    get_template_part( 'loop', 'archive' );
  endif; 
	
	$wp_query = $temp;  //reset back to original query
?>

</div>
</div>
	</div>

<div id="secondary" class="widget-area" role="complementary">
<div id="search_home">
 <div id="search">
  <form accept-charset="UTF-8" action="/catalog" method="get">
<div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /></div>
  <h2 class="search_title">Search collections:</h2>
    <input class="q" id="q" name="q" placeholder="search" type="text" />
     <input id="search_field" name="search_field" type="hidden" value="all_fields" />

     <input alt="search" class="submit" src="/assets/magnifying_glass.gif" type="image" />
</form>
  <hr/>
<h2>Browse collections</h2>
</div>
<div id="voting_status"> this is going to be fun.</div>
</div>

<div id="features_home">
<ul class="xoxo">
<li>
<h3>Home Page Feature One</h3>
</li>
<li>
<h3>Home Page Feature Two</h3>
</li>
</ul>
</div>
</div>

<?php get_footer(); ?>

