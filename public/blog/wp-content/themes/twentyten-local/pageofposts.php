<?php
/*
Template Name: PageOfChildPages
*/

get_header(); ?>
<div id="container">
<div id="content" class="narrowcolumn">

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
  if( have_posts() ) : 
		while ($wp_query->have_posts()) : $wp_query->the_post(); ?>
	    <div <?php post_class(get_post_custom_values('class')) ?> id="post-<?php the_ID(); ?>">
        <h3><?php the_title(); ?></h3>
        <div class="entry">
          <?php the_content('Read the rest of this entry »'); ?>
        </div>
      </div>
<?php if($last->ID != get_the_ID()): ?>
      <hr class="section-break" />
<?php endif; ?>
    <?php endwhile; ?>
  <?php else : ?>

		<h2 class="center">Not Found</h2>
		<p class="center">Sorry, but you are looking for something that isn't here.</p>
		<?php get_search_form(); ?>

	<?php endif; 
	
	$wp_query = $temp;  //reset back to original query
?>

	</div>
</div>
<?php get_sidebar(); ?>

<?php get_footer(); ?>

