<div class="wrap <?php echo $this -> pre; ?>">
	<div class="icon32">
		<img src="<?php echo $this -> url(); ?>/images/icon-galleries-32.png" />
	</div>
	
	<h2><?php _e('Manage Galleries', $this -> plugin_name); ?> <?php echo $this -> Html -> link(__('Add New'), $this -> url . '&amp;method=save', array('class' => "button add-new-h2")); ?></h2>
	
	<?php if (!empty($galleries)) : ?>
		<form id="posts-filter" action="<?php echo $this -> url; ?>" method="post">
			<ul class="subsubsub">
				<li><?php echo $paginate -> allcount; ?> <?php _e('galleries', $this -> plugin_name); ?></li>
			</ul>
		</form>
		
		<form onsubmit="if (!confirm('<?php _e('Are you sure you wish to execute this action on the selected galleries?', $this -> plugin_name); ?>')) { return false; }" action="<?php echo $this -> url; ?>&amp;method=mass" method="post">
			<div class="tablenav">
				<div class="alignleft actions">				
					<select name="action" class="action">
						<option value=""><?php _e('- Bulk Actions -', $this -> plugin_name); ?></option>
						<option value="delete"><?php _e('Delete', $this -> plugin_name); ?></option>
					</select>
					<input type="submit" class="button" value="<?php _e('Apply', $this -> plugin_name); ?>" name="execute" />
				</div>
				<?php $this -> render('paginate', array('paginate' => $paginate), true, 'admin'); ?>
			</div>
		
			<table class="widefat">
				<thead>
					<tr>
						<th class="check-column"><input type="checkbox" name="checkboxall" id="checkboxall" value="checkboxall" /></th>
						<th><?php _e('ID', $this -> plugin_name); ?></th>
						<th><?php _e('Title', $this -> plugin_name); ?></th>
						<th><?php _e('Slides', $this -> plugin_name); ?></th>
						<th><?php _e('Shortcode', $this -> plugin_name); ?></th>
						<th><?php _e('Date', $this -> plugin_name); ?></th>
					</tr>
				</thead>
				<tfoot>
					<tr>
						<th class="check-column"><input type="checkbox" name="checkboxall" id="checkboxall" value="checkboxall" /></th>
						<th><?php _e('ID', $this -> plugin_name); ?></th>
						<th><?php _e('Title', $this -> plugin_name); ?></th>
						<th><?php _e('Slides', $this -> plugin_name); ?></th>
						<th><?php _e('Shortcode', $this -> plugin_name); ?></th>
						<th><?php _e('Date', $this -> plugin_name); ?></th>
					</tr>
				</tfoot>
				<tbody>
					<?php foreach ($galleries as $gallery) : ?>
						<tr class="<?php echo $class = (empty($class)) ? 'alternate' : ''; ?>">
							<th class="check-column"><input type="checkbox" name="Gallery[checklist][]" value="<?php echo $gallery -> id; ?>" id="checklist<?php echo $gallery -> id; ?>" /></th>
							<td><?php echo $gallery -> id; ?></td>
							<td>
                            	<a class="row-title" href="<?php echo $this -> url; ?>&amp;method=save&amp;id=<?php echo $gallery -> id; ?>" title=""><?php echo $gallery -> title; ?></a>
                                <div class="row-actions">
                                	<span class="view"><?php echo $this -> Html -> link(__('View', $this -> plugin_name), "?page=" . $this -> sections -> galleries . "&amp;method=view&amp;id=" . $gallery -> id); ?> |</span>
                                	<span class="edit"><?php echo $this -> Html -> link(__('Edit', $this -> plugin_name), "?page=" . $this -> sections -> galleries . "&amp;method=save&amp;id=" . $gallery -> id); ?> |</span>
                                	<span class="edit"><?php echo $this -> Html -> link(__('Hardcode', $this -> plugin_name), '?page=' . $this -> sections -> galleries . "&amp;method=hardcode&amp;id=" . $gallery -> id); ?> |</span>
                                    <span class="delete"><?php echo $this -> Html -> link(__('Delete', $this -> plugin_name), "?page=" . $this -> sections -> galleries . "&amp;method=delete&amp;id=" . $gallery -> id, array('class' => "submitdelete", 'onclick' => "if (!confirm('" . __('Are you sure you want to permanently remove this slide?', $this -> plugin_name) . "')) { return false; }")); ?></span>
                                </div>
                            </td>
                            <td>
                            	<a href="?page=<?php echo $this -> sections -> galleries; ?>&amp;method=view&amp;id=<?php echo $gallery -> id; ?>"><?php echo $gallery -> slidescount; ?></a>
                            </td>
                            <td>
                            	<code>[slideshow gallery_id="<?php echo $gallery -> id; ?>"]</code>
                            </td>
							<td><abbr title="<?php echo $gallery -> modified; ?>"><?php echo date("Y-m-d", strtotime($gallery -> modified)); ?></abbr></td>
						</tr>
					<?php endforeach; ?>
				</tbody>
			</table>
			
			<div class="tablenav">
				
				<?php $this -> render('paginate', array('paginate' => $paginate), true, 'admin'); ?>
			</div>
		</form>
	<?php else : ?>
		<p class="error"><?php _e('No galleries are available.', $this -> plugin_name); ?></p>
	<?php endif; ?>
</div>