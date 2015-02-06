<?php
class ControllerMyocCopu extends Controller {
	protected function index($args) {
		$type = isset($args['type']) ? $args['type'] : false;
		$type_id = isset($this->request->get[$type . '_id']) ? $this->request->get[$type . '_id'] : 0;
		if(!$type || !$type_id) {
			return false;
		}
		$this->language->load('module/myoccopu');

		$this->data['column_image'] = $this->language->get('column_image');
		$this->data['column_name'] = $this->language->get('column_name');
		$this->data['column_size'] = $this->language->get('column_size');
		$this->data['column_date'] = $this->language->get('column_date');
		$this->data['column_action'] = $this->language->get('column_action');

		$this->data['text_popup'] = $this->language->get('text_popup');
		$this->data['text_download'] = $this->language->get('text_download');
		$this->data['text_empty'] = $this->language->get('text_empty');
		$this->data['text_delete'] = $this->language->get('text_delete');
		$this->data['text_confirm_delete'] = $this->language->get('text_confirm_delete');
		$this->data['text_drag_drop'] = $this->language->get('text_drag_drop');
		$this->data['text_loading'] = $this->language->get('text_loading');
		$this->data['text_complete'] = $this->language->get('text_complete');
		$this->data['date_format_short'] = $this->language->get('date_format_short');

		$this->data['button_upload'] = $this->language->get('button_upload');

		$this->data['token'] = $this->session->data['token'];

		$this->document->addStyle('view/stylesheet/myoc/copu.css');

		if(file_exists('../catalog/view/javascript/jquery/colorbox/colorbox.css') && file_exists('../catalog/view/javascript/jquery/colorbox/jquery.colorbox.js')) {
			$this->document->addStyle('../catalog/view/javascript/jquery/colorbox/colorbox.css');
			$this->document->addScript('../catalog/view/javascript/jquery/colorbox/jquery.colorbox.js');
		} elseif(file_exists('../catalog/view/javascript/jquery/fancybox/jquery.fancybox-1.3.4.css') && file_exists('../catalog/view/javascript/jquery/fancybox/jquery.fancybox-1.3.4.pack.js')) { //OCv1.5.1.3
			$this->document->addStyle('../catalog/view/javascript/jquery/fancybox/jquery.fancybox-1.3.4.css');
			$this->document->addScript('../catalog/view/javascript/jquery/fancybox/jquery.fancybox-1.3.4.pack.js');
		}
		if($type == 'customer') {
			$this->document->addScript('../catalog/view/javascript/jquery/myoc/copu-helper.js');
			$this->document->addScript('../catalog/view/javascript/jquery/myoc/jquery.ui.widget.js');
			$this->document->addScript('../catalog/view/javascript/jquery/myoc/load-image.min.js');
			$this->document->addScript('../catalog/view/javascript/jquery/myoc/canvas-to-blob.min.js');
			$this->document->addScript('../catalog/view/javascript/jquery/myoc/jquery.iframe-transport.js');
			$this->document->addScript('../catalog/view/javascript/jquery/myoc/jquery.fileupload.js');
			$this->document->addScript('../catalog/view/javascript/jquery/myoc/jquery.fileupload-process.js');
			$this->document->addScript('../catalog/view/javascript/jquery/myoc/jquery.fileupload-image.js');
		}

		$copu_preview_dimension_w = $this->config->get('copu_' . $type . '_preview_dimension_w');
		$copu_preview_dimension_h = $this->config->get('copu_' . $type . '_preview_dimension_h');

		$this->load->model('myoc/copu');

		$this->load->model('tool/image');

		$this->load->helper('copu');

		$this->data['type'] = $type;

		if(isset($this->request->get['customer_id'])) {
			$this->data['customer_id'] = $this->request->get['customer_id'];
		} elseif(isset($args['customer_id'])) {
			$this->data['customer_id'] = $args['customer_id'];
		} else {
			$this->data['customer_id'] = 0;
		}

		if(isset($this->request->get['order_id'])) {
			$this->data['order_id'] = $this->request->get['order_id'];
		} else {
			$this->data['order_id'] = 0;
		}

		$this->data['upload'] = isset($args['edit']) ? $args['edit'] : true;
		$this->data['delete'] = isset($args['edit']) ? $args['edit'] : true;
		$this->data['html'] = isset($args['html']) ? $args['html'] : true;
		$this->data['javascript'] = isset($args['js']) ? $args['js'] : true;

		$this->data['colspan'] = 5;
		if(!$this->data['delete']) {
			$this->data['colspan']--;
		}

		$this->data['copu_preview_dimension_w'] = $copu_preview_dimension_w;
		$this->data['copu_preview_dimension_h'] = $copu_preview_dimension_h;
		$this->data['copu_max_filename_length'] = $this->config->get('copu_' . $type . '_max_filename_length');

		$this->data['uploads'] = array();

		$uploads = $this->model_myoc_copu->getUploads(array($type . '_id' => $type_id));

		if($uploads) {
			foreach ($uploads as $upload) {
				if ($upload['filename']) {
					$file = DIR_DOWNLOAD . $upload['filename'];
					$size = filesize($file);
					if(!$size) { continue; }
					$imageinfo = @getimagesize($file);
                	if($imageinfo[2] > 0 && $imageinfo[2] < 4) {
                		if(!file_exists(DIR_IMAGE . $upload['mask'])) {
	                    	copy($file, DIR_IMAGE . $upload['mask']);
	                    }
	                    $image = $this->model_tool_image->resize($upload['mask'], $copu_preview_dimension_w, $copu_preview_dimension_h);
	                    $popup = $this->model_tool_image->resize($upload['mask'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height'));
	                    //unlink(DIR_IMAGE . $upload['mask']); //comment out to improve performance but decrease security
	                } else {
	        			$image = $this->model_tool_image->resize('no_image.jpg', $copu_preview_dimension_w, $copu_preview_dimension_h);
	                    $popup = false;
	        		}

					$this->data['uploads'][] = array(
						'upload_id'	=> $upload['upload_id'],
						'image' 	=> $image,
						'popup' 	=> $popup,
						'date' 		=> date($this->language->get('date_format_short'), strtotime($upload['date_added'])),
						'name'      => $upload['mask'],
						'size'      => formatFilesize($size),
						'href'      => $this->url->link('myoc/copu/download', 'token=' . $this->session->data['token'] . '&f=' . urlencode($upload['filename']), 'SSL'),
						'delete'	=> $this->url->link('myoc/copu/delete', 'token=' . $this->session->data['token'] . '&upload_id=' . $upload['upload_id'] . '&confirm=0', 'SSL'),
					);
				}
			}
		}

		$this->template = 'myoc/copu_upload.tpl';

		$this->response->setOutput($this->render());
	}

	protected function product($args) {
		if(!isset($this->request->get['order_id'])) {
			return false;
		}
		$this->language->load('module/myoccopu');

		$this->data['column_image'] = $this->language->get('column_image');
		$this->data['column_name'] = $this->language->get('column_name');
		$this->data['column_size'] = $this->language->get('column_size');
		$this->data['column_date'] = $this->language->get('column_date');
		$this->data['column_action'] = $this->language->get('column_action');

		$this->data['text_popup'] = $this->language->get('text_popup');
		$this->data['text_download'] = $this->language->get('text_download');
		$this->data['text_empty'] = $this->language->get('text_empty');
		$this->data['text_delete'] = $this->language->get('text_delete');
		$this->data['text_confirm_delete'] = $this->language->get('text_confirm_delete');
		$this->data['text_drag_drop'] = $this->language->get('text_drag_drop');
		$this->data['text_loading'] = $this->language->get('text_loading');
		$this->data['text_complete'] = $this->language->get('text_complete');

		$this->data['button_upload'] = $this->language->get('button_upload');

		$order_id = $this->request->get['order_id'];

		$this->data['order_id'] = $order_id;
		$this->data['customer_id'] = isset($args['customer_id']) ? $args['customer_id'] : 0;

		$this->data['token'] = $this->session->data['token'];

		if(file_exists('../catalog/view/javascript/jquery/colorbox/colorbox.css') && file_exists('../catalog/view/javascript/jquery/colorbox/jquery.colorbox.js')) {
			$this->document->addStyle('../catalog/view/javascript/jquery/colorbox/colorbox.css');
			$this->document->addScript('../catalog/view/javascript/jquery/colorbox/jquery.colorbox.js');
		} elseif(file_exists('../catalog/view/javascript/jquery/fancybox/jquery.fancybox-1.3.4.css') && file_exists('../catalog/view/javascript/jquery/fancybox/jquery.fancybox-1.3.4.pack.js')) { //OCv1.5.1.3
			$this->document->addStyle('../catalog/view/javascript/jquery/fancybox/jquery.fancybox-1.3.4.css');
			$this->document->addScript('../catalog/view/javascript/jquery/fancybox/jquery.fancybox-1.3.4.pack.js');
		}
		$this->document->addStyle('view/stylesheet/myoc/copu.css');
		
		$this->data['html'] = isset($args['html']) ? $args['html'] : false;
		$this->data['javascript'] = isset($args['js']) ? $args['js'] : false;

		$this->template = 'myoc/copu_product.tpl';

		$this->response->setOutput($this->render());
	}

	protected function invoice($args) {
		if(!$args['order_id']) {
			return false;
		}
		$this->language->load('module/myoccopu');

		$this->data['column_name'] = $this->language->get('column_name');
		$this->data['column_size'] = $this->language->get('column_size');

		$this->data['text_empty'] = $this->language->get('text_empty');
		$this->data['text_upload'] = $this->language->get('text_upload');

		$this->load->model('myoc/copu');

		$this->load->helper('copu');

		$this->data['uploads'] = array();

		$uploads = $this->model_myoc_copu->getUploads(array('order_id' => $args['order_id']));

		if($uploads) {
			foreach ($uploads as $upload) {
				if (file_exists(DIR_DOWNLOAD . $upload['filename'])) {
					$size = filesize(DIR_DOWNLOAD . $upload['filename']);

					$this->data['uploads'][] = array(
						'name'      => $upload['mask'],
						'size'      => formatFilesize($size),
					);
				}
			}
		}

		$this->template = 'myoc/copu_invoice.tpl';

		$this->response->setOutput($this->render());
	}

	public function upload() {
		$this->language->load('module/myoccopu');

		$json = array();

		if (!$this->user->hasPermission('modify', 'module/myoccopu')) {
			$json['error'] = $this->language->get('error_permission');
		}

		$type = isset($this->request->get['type']) ? $this->request->get['type'] : "";
		$copu_products = $this->config->get('copu_products');
		$option_id = isset($this->request->get['option_id']) ? $this->request->get['option_id'] : false;
			
		if($type == 'product' && $copu_products && $option_id) {
			foreach ($copu_products as $copu_product) {
				if(isset($copu_product['options']) && in_array($option_id, $copu_product['options'])) {
					$copu_force_qty = $copu_product['force_qty'];
					$copu_max_filename_length = $copu_product['max_filename_length'];
					$copu_file_location = $copu_product['file_location'] ? "../" . $copu_product['file_location'] . "/" : "";
					$copu_preview_dimension_w = $copu_product['preview_dimension_w'];
					$copu_preview_dimension_h = $copu_product['preview_dimension_h'];
					break;
				}
			}
		} else {
			$copu_force_qty = $this->config->get('copu_' . $type . '_force_qty');
			$copu_max_filename_length = $this->config->get('copu_' . $type . '_max_filename_length');
			$copu_file_location = $this->config->get('copu_' . $type . '_file_location') ? "../" . $this->config->get('copu_' . $type . '_file_location') . "/" : "";
			$copu_preview_dimension_w = $this->config->get('copu_' . $type . '_preview_dimension_w');
			$copu_preview_dimension_h = $this->config->get('copu_' . $type . '_preview_dimension_h');
		}

		if(!empty($copu_file_location)) {
			if(strpos($copu_file_location, '%customer_id%')) {
				$copu_file_location = str_replace('%customer_id%', $this->request->get['customer_id'], $copu_file_location);
			}
			if(strpos($copu_file_location, '%product_id%') && $type == 'product' && $this->request->get['product_id']) {
				$copu_file_location = str_replace('%product_id%', $this->request->get['product_id'], $copu_file_location);
			}
			if(strpos($copu_file_location, '%order_id%')) {
				$copu_file_location = str_replace('%order_id%', $this->request->get['order_id'], $copu_file_location);
			}
		}
		if(!empty($copu_file_location) && !file_exists(DIR_DOWNLOAD . $copu_file_location)) {
			mkdir(DIR_DOWNLOAD . $copu_file_location, 0755, true);
		}

		$this->load->model('myoc/copu');
		$this->load->helper('copu');
		
		if (!empty($this->request->files['file']['name'])) {
			$filename = basename(preg_replace('/[^a-zA-Z0-9\.\-\s+]/', '', html_entity_decode($this->request->files['file']['name'], ENT_QUOTES, 'UTF-8')));
			
			if ((strlen($filename) < 3) || (strlen($filename) > 64)) {
				$json['error'] = $this->language->get('error_filename');
			}
			
			//check other system upload error
			if ($this->request->files['file']['error'] != UPLOAD_ERR_OK) {
				$json['error'] = $this->language->get('error_upload_' . $this->request->files['file']['error']);
			}
		} else {
			$json['error'] = $this->language->get('error_upload');
		}
		
		if (!$json) {
			if (is_uploaded_file($this->request->files['file']['tmp_name']) && file_exists($this->request->files['file']['tmp_name']) && $this->request->files['file']['size']) {
				$upload_id = md5(mt_rand());
				$file = $filename . '.' . $upload_id;
				
				move_uploaded_file($this->request->files['file']['tmp_name'], DIR_DOWNLOAD . $copu_file_location . $file);
				
				$upload_id = $this->model_myoc_copu->addUpload(array('filename' => $copu_file_location . $file));

				$this->load->model('tool/image');

            	$imageinfo = @getimagesize(DIR_DOWNLOAD . $copu_file_location . $file);
            	if($imageinfo[2] > 0 && $imageinfo[2] < 4) {
                	copy(DIR_DOWNLOAD . $copu_file_location . $file, DIR_IMAGE . $filename);
                    $image = $this->model_tool_image->resize($filename, $copu_preview_dimension_w, $copu_preview_dimension_h);
                    $popup = $this->model_tool_image->resize($filename, $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height'));
	                unlink(DIR_IMAGE . $filename);
                } else {
        			$image = $this->model_tool_image->resize('no_image.jpg', $copu_preview_dimension_w, $copu_preview_dimension_h);
        			$popup = false;
        		}

        		$json['file'] = array();
        		$json['file']['upload_id'] = $upload_id;
        		$json['file']['file'] = $copu_file_location . $file;
        		$json['file']['image'] = $image;
        		$json['file']['popup'] = $popup;
        		$json['file']['name'] = truncateFilename($filename, $copu_max_filename_length);
        		$json['file']['href'] = $this->url->link('myoc/copu/download', 'token=' . $this->session->data['token'] . '&f=' . urlencode($copu_file_location . $file), 'SSL');
        		$json['file']['date'] = date($this->language->get('date_format_short'));
        		$json['file']['size'] = formatFilesize($this->request->files['file']['size']);
        		$json['file']['force_qty'] = ($copu_force_qty) ? true : false;
        		$json['file']['delete'] = $this->url->link('myoc/copu/delete', 'token=' . $this->session->data['token'] . '&upload_id=' . $upload_id, 'SSL');
			}

			$json['success'] = true;
		}	
		
		$this->response->setOutput(json_encode($json));		
	}

	public function download()
	{
		$filename = isset($this->request->get['f']) ? $this->request->get['f'] : false;
		$mask = basename(substr($filename, 0, strrpos($filename, '.')));
		if (file_exists(DIR_DOWNLOAD . $filename)) {
			if (!headers_sent()) {
				header('Content-Type: application/octet-stream');
				header('Content-Description: File Transfer');
				header('Content-Disposition: attachment; filename="' . $mask . '"');
				header('Content-Transfer-Encoding: binary');
				header('Expires: 0');
				header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
				header('Pragma: public');
				header('Content-Length: ' . filesize(DIR_DOWNLOAD . $filename));
				
				readfile(DIR_DOWNLOAD . $filename, 'rb');

				exit;
			} else {
				exit('Error: Headers already sent out!');
			}
		} else {
			exit('Error: Could not find file ' . DIR_DOWNLOAD . $filename . '!');
		}
	}

	public function delete() {
        $upload_id = $this->request->get['upload_id'];
        $confirm = isset($this->request->get['confirm']) ? $this->request->get['confirm'] : true;

        $this->language->load('module/myoccopu');

	    $json = array();

	    $json['error'] = $this->language->get('error_delete');

        if (!$this->user->hasPermission('modify', 'module/myoccopu')) {
			$json['error'] = $this->language->get('error_permission');
		} else {
		    if($confirm) {
	    		$this->load->model('myoc/copu');
		    	$upload = $this->model_myoc_copu->getUpload($upload_id);
		        if($upload && unlink(DIR_DOWNLOAD . $upload['filename']))
		        {
		            $this->model_myoc_copu->deleteUpload($upload_id);
		            $json['success'] = true;
		            unset($json['error']);
		        }
		    } else {
		    	$json['success'] = true;
		        unset($json['error']);
		    }
		}
        $this->response->setOutput(json_encode($json));
	}
}
?>