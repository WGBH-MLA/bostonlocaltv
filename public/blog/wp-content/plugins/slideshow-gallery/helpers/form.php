<?php

class GalleryFormHelper extends GalleryPlugin {
	
	function hidden($name = '', $args = array()) {
		global $wpcoHtml;
		
		$defaults = array(
			'value' 		=> 	(empty($args['value'])) ? $this -> Html -> field_value($name) : $args['value'],
		);
		
		$r = wp_parse_args($args, $defaults);
		extract($r, EXTR_SKIP);
		
		ob_start();
		
		?><input type="hidden" name="<?php echo $this -> Html -> field_name($name); ?>" value="<?php echo $value; ?>" id="<?php echo $name; ?>" /><?php
		
		$hidden = ob_get_clean();
		return $hidden;
	}

	function text($name = '', $args = array()) {	
		$defaults = array(
			'id'			=>	(empty($args['id'])) ? $name : $args['id'],
			'width'			=>	'100%',
			'class'			=>	"widefat",
			'error'			=>	true,
			'value'			=>	(empty($args['value'])) ? GalleryHtmlHelper::field_value($name) : $args['value'],
			'autocomplete'	=>	"on",
		);
		
		$r = wp_parse_args($args, $defaults);
		extract($r, EXTR_SKIP);
		
		$this -> debug($this);
		echo $this -> Html -> field_value($name);
		
		ob_start();
		
		?><input class="<?php echo $class; ?>" type="text" autocomplete="<?php echo $autocomplete; ?>" style="width:<?php echo $width; ?>" name="<?php echo $this -> Html -> field_name($name); ?>" value="<?php echo $value; ?>" id="<?php echo $id; ?>" /><?php
		
		if ($error == true) {
			echo $this -> Html -> field_error($name);
		}
		
		$text = ob_get_clean();
		return $text;
	}
	
	function textarea($name = '', $args = array()) {		
		$defaults = array(
			'error'			=>	true,
			'width'			=>	'100%',
			'class'			=>	"widefat",
			'rows'			=>	4,
			'cols'			=>	"100%",
		);
		
		$r = wp_parse_args($args, $defaults);
		extract($r, EXTR_SKIP);
		
		ob_start();
		
		?><textarea class="<?php echo $class; ?>" name="<?php echo $this -> Html -> field_name($name); ?>" rows="<?php echo $rows; ?>" style="width:<?php echo $width; ?>;" cols="<?php echo $cols; ?>" id="<?php echo $name; ?>"><?php echo $this -> Html -> field_value($name); ?></textarea><?php
		
		if ($error == true) {
			echo $this -> Html -> field_error($name);
		}
		
		$textarea = ob_get_clean();
		return $textarea;
	}

	function submit($name = '', $args = array()) {		
		$defaults = array('class' => "button-primary");
		$r = wp_parse_args($args, $defaults);
		extract($r, EXTR_SKIP);
		
		ob_start();
		
		?><input class="<?php echo $class; ?>" type="submit" name="<?php echo $this -> Html -> sanitize($name); ?>" value="<?php echo $name; ?>" /><?php
		
		$submit = ob_get_clean();
		return $submit;
	}
}

?>