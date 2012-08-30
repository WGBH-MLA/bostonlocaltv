<?php

class GalleryDbHelper extends GalleryPlugin {

	var $name = 'Db';
	
	function find($conditions = array(), $fields = false, $order = array('id', "DESC"), $assign = true, $atts = array()) {
		global $wpdb;
		
		$newfields = "*";
		
		if (!empty($fields)) {
			if (is_array($fields)) {
				$newfields = "";
				$f = 1;
				
				foreach ($fields as $field) {
					$newfields .= "`" . $field . "`";
					
					if ($f < count($fields)) {
						$newfields .= ", ";
					}
					
					$f++;
				}
			} else {
				$newfields = $fields;
			}
		}
		
		$query = "SELECT " . $newfields . " FROM `" . $this -> table . "`";
		
		if (!empty($conditions) && is_array($conditions)) {
			$query .= " WHERE";
			$c = 1;
			
			foreach ($conditions as $ckey => $cval) {
				$query .= " `" . $ckey . "` = '" . $cval . "'";
				
				if ($c < count($conditions)) {
					$query .= " AND";
				}
				
				$c++;
			}
		}
		
		$order = (empty($order)) ? array('id', "DESC") : $order;
		list($ofield, $odir) = $order;
		$query .= " ORDER BY `" . $ofield . "` " . $odir . "";
		$query .= " LIMIT 1";
		
		if ($record = $wpdb -> get_row($query)) {		
			if (!empty($record)) {			
				$data = $this -> init_class($this -> model, $record);
				
				if ($assign == true) {
					$this -> data = $data;
				}

				return $data;
			}
		}
		
		return false;
	}
	
	function find_all($conditions = array(), $fields = false, $order = array('id', "DESC"), $limit = false, $assign = false, $distinct = false) {
		global $wpdb;
		
		$newfields = "*";
		if (!empty($fields) && !is_array($fields)) { $newfields = $fields; }
		$distinct = (!empty($distinct)) ? "DISTINCT " : "";
		
		$query = "SELECT " . $distinct . $newfields . " FROM `" . $this -> table . "`";
		
		if (!empty($conditions) && is_array($conditions)) {
			$query .= " WHERE";
			$c = 1;
			
			foreach ($conditions as $ckey => $cval) {
				$query .= " `" . $ckey . "` = '" . $cval . "'";
				
				if ($c < count($conditions)) {
					$query .= " AND";
				}
				
				$c++;
			}
		}
		
		$order = (empty($order)) ? array('id', "DESC") : $order;
		
		if ($order == "random") {
			$query .= " ORDER BY RAND()";
		} else {
			if (!is_array($order)) { $order = array('id', "DESC"); }
			list($ofield, $odir) = $order;
			$query .= " ORDER BY `" . $ofield . "` " . $odir . "";
		}
			
		$query .= (empty($limit)) ? '' : " LIMIT " . $limit . "";
		
		if ($records = $wpdb -> get_results($query)) {
			if (!empty($records)) {
				$data = array();
			
				foreach ($records as $record) {
					$data[] = $this -> init_class($this -> model, $record);
				}
				
				if ($assign == true) {
					$this -> data = $data;
				}
				
				return $data;
			}
		}
		
		return false;
	}
	
	function save($data = null, $validate = true) {
		global $wpdb;
		$this -> errors = false;
		
		$defaults = (method_exists($this, 'defaults')) ? $this -> defaults() : false;
		$data = (empty($data[$this -> model])) ? $data : $data[$this -> model];
		
		$r = wp_parse_args($data, $defaults);
		$this -> data = (object) $r;
		
		if ($validate == true) {
			if (method_exists($this, 'validate')) {
				$this -> validate($r);
			}
		}
		
		if (empty($this -> errors)) {
			switch ($this -> model) {
				case 'Slide'				:
					if ($this -> data -> type == "file") {
						//$this -> data -> image = $_FILES['image_file']['name'];	
					} else {
						$this -> data -> image = basename($this -> data -> image_url);
					}
					
					if (empty($this -> data -> uselink) || $this -> data -> uselink == "N") {
						$this -> data -> link = "";
					}
					break;
			}
			
			$query = (empty($this -> data -> id)) ? $this -> insert_query($this -> model) : $this -> update_query($this -> model);			
			
			if ($wpdb -> query($query)) {
				$this -> insertid = $insertid = (empty($this -> data -> id)) ? $wpdb -> insert_id : $this -> data -> id;
				
				switch ($this -> model) {
					case 'Slide'				:					
					
						$slide_id = $this -> insertid;
						$deletequery = "DELETE FROM `" . $wpdb -> prefix . strtolower($this -> pre) . "_galleriesslides` WHERE `slide_id` = '" . $slide_id . "'";
						$wpdb -> query($deletequery);
						
						if (!empty($this -> data -> galleries)) {						
							foreach ($this -> data -> galleries as $gallery_id) {
								$date = date("Y-m-d H:i:s", time());
								$galleryslidequery = "INSERT INTO `" . $wpdb -> prefix . strtolower($this -> pre) . "_galleriesslides` (`id`, `slide_id`, `gallery_id`, `created`, `modified`) VALUES ('', '" . $slide_id . "', '" . $gallery_id . "', '" . $date . "', '" . $date . "');";
								$wpdb -> query($galleryslidequery);
							}
						}
						break;
				}
								
				return true;
			}
		}
		
		return false;
	}
	
	function save_field($field = null, $value = null, $conditions = array()) {
		if (!empty($this -> model)) {
			global $wpdb;
			
			if (!empty($field)) {
				$query = "UPDATE `" . $this -> table . "` SET `" . $field . "` = '" . $value . "'";
				
				if (!empty($conditions) && is_array($conditions)) {
					$query .= " WHERE";
					$c = 1;
					
					foreach ($conditions as $ckey => $cval) {
						$query .= " `" . $ckey . "` = '" . $cval . "'";
						
						if ($c < count($conditions)) {
							$query .= " AND";
						}
						
						$c++;
					}
				}
				
				if ($wpdb -> query($query)) {
					return true;
				}
			}
		}
		
		return false;
	}
	
	function delete($record_id = null) {
		global $wpdb;
		
		if (!empty($record_id) && $record = $this -> find(array('id' => $record_id))) {
			$query = "DELETE FROM `" . $this -> table . "` WHERE `id` = '" . $record_id . "' LIMIT 1";
			
			if ($wpdb -> query($query)) {
				switch ($this -> model) {
					case 'Gallery'			:
						$query = "DELETE FROM `" . $wpdb -> prefix . strtolower($this -> pre) . "_galleriesslides` WHERE `gallery_id` = '" . $record_id . "'";
						$wpdb -> query($query);
						break;
				}
							
				return true;
			}
		}
		
		return false;
	}
	
	function insert_query($model = null) {	
		if (!empty($model)) {
			global $wpdb;
			
			if (!empty($this -> data)) {
				if (empty($this -> data -> id)) {
					$query1 = "INSERT INTO `" . $this -> table . "` (";
					$query2 = "";
					$c = 1;
					unset($this -> fields['key']);
					
					foreach (array_keys($this -> fields) as $field) {
						if (!empty($this -> data -> {$field}) || $this -> data -> {$field} == "0") {						
							if (is_array($this -> data -> {$field}) || is_object($this -> data -> {$field})) {
								$value = serialize($this -> data -> {$field});
							} else {
								$value = mysql_escape_string($this -> data -> {$field});
							}
				
							$query1 .= "`" . $field . "`";
							$query2 .= "'" . $value . "'";
							
							if ($c < count($this -> fields)) {
								$query1 .= ", ";
								$query2 .= ", ";
							}
						}
						
						$c++;
					}
					
					$query1 .= ") VALUES (";
					$query = $query1 . "" . $query2 . ");";
					
					return $query;
				} else {
					$query = $this -> update_query($model);
					
					return $query;
				}
			}
		}
	
		return false;
	}
	
	function update_query($model = null) {	
		if (!empty($model)) {
			global $wpdb;
			
			if (!empty($this -> data)) {			
				$query = "UPDATE `" . $this -> table . "` SET ";
				$c = 1;
				
				unset($this -> fields['id']);
				unset($this -> fields['key']);
				unset($this -> fields['created']);
				
				foreach (array_keys($this -> fields) as $field) {
					//if (!empty($this -> data -> {$field}) || $this -> data -> {$field} == "0") {
						if (is_array($this -> data -> {$field}) || is_object($this -> data -> {$field})) {
							$value = serialize($this -> data -> {$field});
						} else {
							$value = mysql_escape_string($this -> data -> {$field});
						}
					
						$query .= "`" . $field . "` = '" . $value . "'";
						
						if ($c < count($this -> fields)) {
							$query .= ", ";
						}
					//}
					
					$c++;
				}
				
				$query .= " WHERE `id` = '" . $this -> data -> id . "' LIMIT 1";
				
				return $query;
			}
		}
	
		return false;
	}
}

?>