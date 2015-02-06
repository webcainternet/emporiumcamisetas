<?php  
class ControllerMyocCopu extends Controller {
	protected function index($args) {
		$ssl = isset($_SERVER['HTTPS']) ? 'SSL' : 'NONSSL';

		$type = isset($args['type']) ? $args['type'] : false;
		$path = isset($args['path']) ? $args['path'] : false;
		$copu_product_id = isset($args['copu_product_id']) ? $args['copu_product_id'] : 0;
		$product_option_id = isset($args['product_option_id']) ? $args['product_option_id'] : false;
		$product_id = isset($this->request->get['product_id']) ? (int)$this->request->get['product_id'] : false;

		$copu_products = $this->config->get('copu_products');
		$copu_product = false;
		if($copu_products) {
			foreach($copu_products as $copu_product_value) {
				if($type == 'product' && $copu_product_id && $copu_product_value['copu_product_id'] == $copu_product_id) {
					$this->data['copu_product_id'] = $copu_product_id;
					$copu_product = $copu_product_value;
					break;
				}
			}
		}

		if($copu_product) {
			$copu_status = $copu_product['status'];
			$copu_stores = isset($copu_product['stores']) ? $copu_product['stores'] : array();
			$copu_drag_drop = $copu_product['drag_drop'];
			$copu_multiple = $copu_product['multiple'];
			$copu_force_qty = $copu_product['force_qty'];
			$copu_max_filename_length = $copu_product['max_filename_length'];
			$copu_preview = $copu_product['preview'];
			$copu_replace = $copu_product['replace'];
			$copu_preview_dimension_w = $copu_product['preview_dimension_w'];
			$copu_preview_dimension_h = $copu_product['preview_dimension_h'];
			$copu_message = $copu_product['message'][$this->config->get('config_language_id')]['message'];
		} else {
			$copu_status = $this->config->get('copu_' . $type . '_status');
			$copu_stores = $this->config->get('copu_' . $type . '_stores');
			$copu_drag_drop = $this->config->get('copu_' . $type . '_drag_drop');
			$copu_multiple = $this->config->get('copu_' . $type . '_multiple');
			$copu_force_qty = false;
			$copu_max_filename_length = $this->config->get('copu_' . $type . '_max_filename_length');
			$copu_preview = $this->config->get('copu_' . $type . '_preview');
			$copu_replace = false;
			$copu_preview_dimension_w = $this->config->get('copu_' . $type . '_preview_dimension_w');
			$copu_preview_dimension_h = $this->config->get('copu_' . $type . '_preview_dimension_h');
			$copu_message = $this->config->get('copu_' . $type . '_message');
			$copu_message = $copu_message[$this->config->get('config_language_id')]['message'];
		}

		if(!$type || !$copu_status || ($type == 'customer' && $path == 'register' && !$this->config->get('copu_customer_register')) || $copu_stores == "" || !in_array($this->config->get('config_store_id'), $copu_stores)) {
			return false;
		}
		$this->language->load('myoc/copu');

		if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/myoc/copu.css')) {
			$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/myoc/copu.css');
		} else {
			$this->document->addStyle('catalog/view/theme/default/stylesheet/myoc/copu.css');
		}
		$this->document->addScript('catalog/view/javascript/jquery/myoc/copu-helper.js');
		$this->document->addScript('catalog/view/javascript/jquery/myoc/jquery.ui.widget.js');
		$this->document->addScript('catalog/view/javascript/jquery/myoc/load-image.min.js');
		$this->document->addScript('catalog/view/javascript/jquery/myoc/canvas-to-blob.min.js');
		$this->document->addScript('catalog/view/javascript/jquery/myoc/jquery.iframe-transport.js');
		$this->document->addScript('catalog/view/javascript/jquery/myoc/jquery.fileupload.js');
		$this->document->addScript('catalog/view/javascript/jquery/myoc/jquery.fileupload-process.js');
		$this->document->addScript('catalog/view/javascript/jquery/myoc/jquery.fileupload-image.js');

		if(VERSION >= '1.5.5') {
			if (file_exists('catalog/view/javascript/jquery/colorbox/colorbox.css')) {
				$this->document->addStyle('catalog/view/javascript/jquery/colorbox/colorbox.css');
			}
			if (file_exists('catalog/view/javascript/jquery/colorbox/jquery.colorbox.js')) {
				$this->document->addScript('catalog/view/javascript/jquery/colorbox/jquery.colorbox.js');
			}
		}

		$this->data['text_upload'] = $this->language->get('text_upload');
		$this->data['text_empty'] = $this->language->get('text_empty');
		$this->data['text_confirm_delete'] = $this->language->get('text_confirm_delete');
		$this->data['text_download'] = $this->language->get('text_download');
		$this->data['text_popup'] = $this->language->get('text_popup');
		$this->data['text_drag_drop'] = $this->language->get('text_drag_drop');
		$this->data['text_loading'] = $this->language->get('text_loading');
		$this->data['text_complete'] = $this->language->get('text_complete');
		$this->data['date_format_short'] = $this->language->get('date_format_short');

		$this->data['column_image'] = $this->language->get('column_image');
		$this->data['column_name'] = $this->language->get('column_name');
		$this->data['column_date'] = $this->language->get('column_date');
		$this->data['column_size'] = $this->language->get('column_size');
		$this->data['column_action'] = $this->language->get('column_action');

		$this->data['button_upload'] = $this->language->get('button_upload');
		$this->data['button_remove'] = $this->language->get('button_remove');

		if ($type == 'order' && $path && $this->config->get('copu_order_minimum') && (!isset($this->session->data['copu_order_uploads']) || count($this->session->data['copu_order_uploads']) < $this->config->get('copu_order_minimum'))) {
			$this->data['error_upload_minimum'] = sprintf($this->language->get('error_upload_minimum'), $this->config->get('copu_order_minimum'));
			if($path == 'checkout') {
				$this->redirect($this->url->link('checkout/cart'));
			}
		} else {
			$this->data['error_upload_minimum'] = '';
		}

		$this->data['product_id'] = $product_id;
		$this->data['product_option_id'] = $product_option_id;
		$this->data['drag_drop'] = $copu_drag_drop;
		$this->data['multiple'] = $copu_multiple;
		$this->data['force_qty'] = $copu_force_qty;
		$this->data['copu_replace'] = $copu_replace;
		$this->data['image_thumb_width'] = $this->config->get('config_image_thumb_width');
		$this->data['image_thumb_height'] = $this->config->get('config_image_thumb_height');
		$this->data['copu_preview_dimension_w'] = $copu_preview_dimension_w;
		$this->data['copu_preview_dimension_h'] = $copu_preview_dimension_h;
		$this->data['copu_max_filename_length'] = $copu_max_filename_length;
		$this->data['date'] = false;
		$this->data['nosession'] = '';
		$this->data['type'] = $type;
		$this->data['type_id'] = (isset($this->request->get['order_id']) && $type == 'order') ? $this->request->get['order_id'] : 0;

		$colspan = 4;
		$this->data['copu_preview'] = $copu_preview;
		if(!$this->data['copu_preview']) {
			$colspan--;
		}
		if($path == 'checkout' || $type == 'product' || ($type == 'order' && !$path)) {
			$colspan--;
		}
		if($type == 'customer' && !$path) {
			$this->data['date'] = true;
			$this->data['nosession'] = '&session=0';
			$colspan++;
		}
		$this->data['colspan'] = $colspan;

		$this->data['action'] = ($path == 'checkout' || ($type == 'order' && !$path)) ? false : true;
		$this->data['copu_order_history_modify'] = ($this->config->get('copu_order_history_modify') && $path != 'cart' && $path != 'checkout') ? true : false;

		if($type == 'order' && $this->data['copu_order_history_modify']) {
			$this->data['nosession'] = '&session=0';
		}

		$this->data['copu_message'] = ($this->data['action'] || $this->data['copu_order_history_modify']) ? html_entity_decode($copu_message, ENT_QUOTES, 'UTF-8') : false;

		$this->load->helper('copu');
		$this->load->model('tool/image');
		$this->load->model('myoc/copu');

		$page = isset($this->request->get['page']) ? $this->request->get['page'] : 1;			

		if($type == 'product') {
			$uploads = isset($this->session->data['copu_product_uploads'][$product_id][$product_option_id]) ? $this->session->data['copu_product_uploads'][$product_id][$product_option_id] : false;
		} elseif($type == 'customer' && !$path) {
			$uploads = $this->model_myoc_copu->getUploads(array('customer_id' => $this->customer->isLogged(), 'start' => ($page - 1) * $this->config->get('copu_customer_files_per_page'), 'limit' => $this->config->get('copu_customer_files_per_page')));
		} elseif($type == 'order' && !$path) {
			$uploads = $this->model_myoc_copu->getUploads(array('order_id' => $this->request->get['order_id']));
		} else {
			$uploads = isset($this->session->data['copu_' . $type . '_uploads']) ? $this->session->data['copu_' . $type . '_uploads'] : false;
		}
		$this->data['uploads'] = array();

		if($uploads) {
			if(method_exists($this->encryption, 'encrypt')) {
				$encryption = $this->encryption;
			} else {
				$this->load->library('encryption');
			 	$encryption = new Encryption($this->config->get('config_encryption'));
			}
			foreach ($uploads as $upload_id => $upload) {
				$file = is_array($upload) ? $upload['filename'] : $encryption->decrypt($upload);
				$filename = basename(substr($file, 0, strrpos($file, '.')));
				if (file_exists(DIR_DOWNLOAD . $file)) {
					$size = filesize(DIR_DOWNLOAD . $file);
					$image = false;
	        		$popup = false;
                    $replace = false;
					if(($copu_preview || $copu_replace) && $file && $size) {
						$imageinfo = @getimagesize(DIR_DOWNLOAD . $file);
                		if($imageinfo[2] > 0 && $imageinfo[2] < 4) {
		                    if(!file_exists(DIR_IMAGE . $filename)) {
		                    	copy(DIR_DOWNLOAD . $file, DIR_IMAGE . $filename);
		                    }
		                    $image = $copu_preview ? $this->model_tool_image->resize($filename, $copu_preview_dimension_w, $copu_preview_dimension_h) : false;
		                    $popup = ($copu_preview || $copu_replace) ? $this->model_tool_image->resize($filename, $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height')) : false;
		                    $replace = ($type == 'product' && $copu_replace)  ? $this->model_tool_image->resize($filename, $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height')) : false;
		                    unlink(DIR_IMAGE . $filename); //comment out to improve performance but decrease security
		                } else {
		        			$image = $copu_preview ? $this->model_tool_image->resize('no_image.jpg', $copu_preview_dimension_w, $copu_preview_dimension_h) : false;
		        		}
		        	}

					$this->data['uploads'][] = array(
						'upload_id'	=> $upload_id,
						'image' 	=> $image,
						'popup' 	=> $popup,
						'replace'   => $replace,
						'date' 		=> isset($upload['date_added']) ? date($this->language->get('date_format_short'), strtotime($upload['date_added'])) : false,
						'name'      => truncateFilename($filename, $copu_max_filename_length),
						'size'      => formatFilesize($size),
						'href'      => $this->url->link('myoc/copu/download', 'f=' . urlencode(is_array($upload) ? $encryption->encrypt($upload['filename']) : $upload), $ssl),
						'delete'	=> $this->url->link('myoc/copu/delete', 'upload_id=' . $upload_id, $ssl),
					);
				}
			}
		}

		$tpl = 'copu.tpl';
		if($type == 'product') {
			$tpl = 'copu_product.tpl';
		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/myoc/' . $tpl)) {
			$this->template = $this->config->get('config_template') . '/template/myoc/' . $tpl;
		} else {
			$this->template = 'default/template/myoc/' . $tpl;
		}
								
		$this->render();
	}

	protected function cart($args) {
		$ssl = isset($_SERVER['HTTPS']) ? 'SSL' : 'NONSSL';

		$this->language->load('myoc/copu');
		$this->load->model('tool/image');
		$this->load->helper('copu');

		$this->data['text_download'] = $this->language->get('text_download');

		$this->data['uploads'] = array();

		$this->data['path'] = 'cart';
		if(isset($this->request->get['route'])) {
			if(trim($this->request->get['route']) == 'checkout/confirm' || trim($this->request->get['route']) == 'account/order/info') {
				$this->data['path'] = 'confirm';
			}
		}

		if(method_exists($this->encryption, 'encrypt')) {
			$encryption = $this->encryption;
		} else {
			$this->load->library('encryption');
		 	$encryption = new Encryption($this->config->get('config_encryption'));
		}
		
		$copu_products = $this->config->get('copu_products');
		$copu_product = false;

		if(isset($args['key'])) {
			$products = $this->cart->getProducts();

			foreach ($products as $key => $product) {
				if($key == $args['key']) {
					foreach ($product['option'] as $option) {
						if($option['type'] == 'file' && $option['option_value'] && $copu_products && !empty($copu_products)) {
							foreach($copu_products as $copu_product) {
								if($copu_product['status'] && isset($copu_product['options']) && !empty($copu_product['options']) && in_array($option['option_id'], $copu_product['options']) && isset($copu_product['stores']) && !empty($copu_product['stores']) && in_array($this->config->get('config_store_id'), $copu_product['stores'])) {
									$file = $encryption->decrypt($option['option_value']);
									$filename = basename(substr($file, 0, strrpos($file, '.')));
									$size = file_exists(DIR_DOWNLOAD . $file) ? filesize(DIR_DOWNLOAD . $file) : 0;
									$this->data['uploads'][] = array(
										'option_name' => $option['name'],
										'size' => formatFilesize($size),
										'href' => $this->url->link('myoc/copu/download', 'f=' . urlencode($option['option_value']), $ssl),
										'filename' => truncateFilename($filename, $copu_product['max_filename_length']),
									);
								}
							}
						}
					}
				}
			}
		} elseif(isset($args['order_id'])) {
			$this->load->model('account/order');
			$products = $this->model_account_order->getOrderProducts($args['order_id']);

			foreach ($products as $product) {
				if($product['order_product_id'] == $args['order_product_id']) {
					$options = $this->model_account_order->getOrderOptions($args['order_id'], $args['order_product_id']);
					foreach ($options as $option) {
						if($option['type'] == 'file' && $option['value'] && $copu_products && !empty($copu_products)) {
							foreach($copu_products as $copu_product) {
								if($copu_product['status'] && $copu_product['stores'] != "" && in_array($this->config->get('config_store_id'), $copu_product['stores'])) {
									$size = file_exists(DIR_DOWNLOAD . $option['value']) ? filesize(DIR_DOWNLOAD . $option['value']) : 0;
									$filename = basename(substr($option['value'], 0, strrpos($option['value'], '.')));
									$this->data['uploads'][] = array(
										'option_name' => $option['name'],
										'size' => formatFilesize($size),
										'href' => $this->url->link('myoc/copu/download', 'f=' . urlencode($encryption->encrypt($option['value'])), $ssl),
										'filename' => truncateFilename($filename, $copu_product['max_filename_length']),
									);
									break;
								}
							}
						}
					}
				}
			}
		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/myoc/copu_cart.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/myoc/copu_cart.tpl';
		} else {
			$this->template = 'default/template/myoc/copu_cart.tpl';
		}
								
		$this->render();
	}

	public function customer() {
		$ssl = isset($_SERVER['HTTPS']) ? 'SSL' : 'NONSSL';

		if(!$this->config->get('copu_customer_status') || $this->config->get('copu_customer_stores') == "" || !in_array($this->config->get('config_store_id'), $this->config->get('copu_customer_stores'))) {
			$this->redirect($this->url->link('account/account', '', $ssl));
		}
		if(!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/upload', '', $ssl);
			$this->redirect($this->url->link('account/login', '', $ssl));
		}
		$this->language->load('myoc/copu');

		$this->document->setTitle($this->language->get('heading_title'));
      	
		$this->data['breadcrumbs'] = array();

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),
        	'separator' => false
      	); 

      	$this->data['breadcrumbs'][] = array(       	
        	'text'      => $this->language->get('text_account'),
			'href'      => $this->url->link('account/account', '', $ssl),
        	'separator' => $this->language->get('text_separator')
      	);

      	$this->data['breadcrumbs'][] = array(       	
        	'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('account/upload'),
        	'separator' => $this->language->get('text_separator')
      	);
								
		$this->data['heading_title'] = $this->language->get('heading_title');	

		$this->data['button_continue'] = $this->language->get('button_continue');

		$page = isset($this->request->get['page']) ? $this->request->get['page'] : 1;
		$this->load->model('myoc/copu');
		$upload_total = $this->model_myoc_copu->getTotalUploads(array('type' => 'customer', 'type_id' => $this->customer->isLogged()));

		$pagination = new Pagination();
		$pagination->total = $upload_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('copu_customer_files_per_page');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('account/upload', 'page={page}', $ssl);
		
		$this->data['pagination'] = $pagination->render();

		$this->data['continue'] = $this->url->link('account/account', '', $ssl);

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/myoc/copu_customer.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/myoc/copu_customer.tpl';
		} else {
			$this->template = 'default/template/myoc/copu_customer.tpl';
		}
		
		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/content_top',
			'common/content_bottom',
			'common/footer',
			'common/header'	
		);

		$this->data['copu_customer'] = $this->getChild('myoc/copu', array('type' => 'customer'));
							
		$this->response->setOutput($this->render());
	}

	public function validateUpload() {
		$this->language->load('myoc/copu');
		$this->load->model('myoc/copu');
		$this->load->helper('copu');

		$type = $this->request->get['type'];

		$type_id = isset($this->request->get['type_id']) ? $this->request->get['type_id'] : false;
		$product_option_id = isset($this->request->get['product_option_id']) ? $this->request->get['product_option_id'] : false;
		$copu_product_id = isset($this->request->get['copu_product_id']) ? $this->request->get['copu_product_id'] : false;
		$session = isset($this->request->get['session']) ? $this->request->get['session'] : true;

		$copu_products = $this->config->get('copu_products');
		$copu_product = false;
		if($copu_products) {
			foreach ($copu_products as $copu_product_value) {
				if($copu_product_id && $copu_product_value['copu_product_id'] == $copu_product_id) {
					$copu_product = $copu_product_value;
					break;
				}
			}
		}

		if($copu_product) {
			$copu_status = $copu_product['status'];
			$copu_stores = isset($copu_product['stores']) ? $copu_product['stores'] : array();
			$copu_login = $copu_product['login'];
			$copu_customer_groups = isset($copu_product['customer_groups']) ? $copu_product['customer_groups'] : array();
			$copu_limit = $copu_product['limit'];
			$copu_filetypes = isset($copu_product['filetypes']) ? $copu_product['filetypes'] : array();
			$copu_max_filesize = $copu_product['max_filesize'];
		} else {
			$copu_status = $this->config->get('copu_' . $type . '_status');
			$copu_stores = $this->config->get('copu_' . $type . '_stores');
			$copu_login = $this->config->get('copu_' . $type . '_login');
			$copu_customer_groups = $this->config->get('copu_' . $type . '_customer_groups');
			$copu_limit = $this->config->get('copu_' . $type . '_limit');
			$copu_filetypes = $this->config->get('copu_' . $type . '_filetypes');
			$copu_max_filesize = $this->config->get('copu_' . $type . '_max_filesize');
		}

		$json = array();

		//create upload session
		if(!isset($this->session->data['copu_' . $type . '_uploads']) && $session) {
			$this->session->data['copu_' . $type . '_uploads'] = array();
		}
		if($type == 'product' && $type_id && !isset($this->session->data['copu_' . $type . '_uploads'][$type_id])) {
			$this->session->data['copu_' . $type . '_uploads'][$type_id] = array();
		}
		if($type == 'product' && $type_id && $product_option_id && !isset($this->session->data['copu_' . $type . '_uploads'][$type_id][$product_option_id])) {
			$this->session->data['copu_' . $type . '_uploads'][$type_id][$product_option_id] = array();
		}

		//check status and store
		if(!$copu_status || $copu_stores == "" || !in_array($this->config->get('config_store_id'), $copu_stores)) {
			$json['error'] = $this->language->get('error_upload_status');
			$this->response->setOutput(json_encode($json));
			return;
		}

		//check login
		if($copu_login && ($session xor $type == 'customer') && (!$this->customer->isLogged() || !$copu_customer_groups || !in_array($this->customer->getCustomerGroupId(), $copu_customer_groups))) {
			$json['error'] = $this->language->get('error_login');
			$this->response->setOutput(json_encode($json));
			return;
		}

		//check file limit
		$upload_total = 0;
		if($type != 'product' && isset($this->session->data['copu_' . $type . '_uploads'])) {
			$upload_total = count($this->session->data['copu_' . $type . '_uploads']);
		}
		if($type == 'product' && $this->session->data['copu_' . $type . '_uploads'][$type_id][$product_option_id]) {
			$upload_total = count($this->session->data['copu_' . $type . '_uploads'][$type_id][$product_option_id]);
		}
		if(!$session) {
			if($type == 'customer') {
				$type_id = $this->customer->isLogged();
			}
			$upload_total = $this->model_myoc_copu->getTotalUploads(array('type' => $type, 'type_id' => $type_id));
		}
		if($upload_total >= $copu_limit) {
			$json['error'] = $this->language->get('error_limit');
			$this->response->setOutput(json_encode($json));
			return;
		}

		$filetypes = $this->model_myoc_copu->getFiletypes($copu_filetypes);

		if (!empty($this->request->get['filename'])) {
			$filename = basename(preg_replace('/[^a-zA-Z0-9\.\-\s+]/', '', html_entity_decode($this->request->get['filename'], ENT_QUOTES, 'UTF-8')));
			
			if ((strlen($filename) < 3) || (strlen($filename) > 64)) {
				$json['error'] = $this->language->get('error_filename');
			}
			
			$allowed_ext = array();
			$allowed_mime = array();
			
			foreach ($filetypes as $filetype) {
				$allowed_ext[] = trim($filetype['ext']);
				$allowed_mime[trim($filetype['ext'])] = ($filetype['mime'] == '') ? false : explode(",", $filetype['mime']);
			}

			$ext = strtolower(substr(strrchr($filename, '.'), 1));
			$mime = $this->request->get['filetype'];
			
			//check file ext and mime
			if (!in_array($ext, $allowed_ext) || ($mime && $allowed_mime[$ext] && !in_array($mime, $allowed_mime[$ext]))) {
				$json['error'] = sprintf($this->language->get('error_filetype'), implode(", ", $allowed_ext));
			}

			//check file size
			if($this->request->get['filesize'] > $copu_max_filesize * 1024) {
				$json['error'] = sprintf($this->language->get('error_filesize'), formatFilesize($copu_max_filesize * 1024));
			}
		}
		
		$this->response->setOutput(json_encode($json));
	}

	public function upload() {
		$ssl = isset($_SERVER['HTTPS']) ? 'SSL' : 'NONSSL';

		$this->language->load('myoc/copu');
		$this->load->model('myoc/copu');
		$this->load->helper('copu');

		$type = $this->request->get['type'];

		$type_id = isset($this->request->get['type_id']) ? $this->request->get['type_id'] : false;
		$product_option_id = isset($this->request->get['product_option_id']) ? $this->request->get['product_option_id'] : false;
		$copu_product_id = isset($this->request->get['copu_product_id']) ? $this->request->get['copu_product_id'] : false;
		$session = isset($this->request->get['session']) ? $this->request->get['session'] : true;

		$copu_products = $this->config->get('copu_products');
		$copu_product = false;
		if($copu_products) {
			foreach ($copu_products as $copu_product_value) {
				if($copu_product_id && $copu_product_value['copu_product_id'] == $copu_product_id) {
					$copu_product = $copu_product_value;
					break;
				}
			}
		}

		if($copu_product) {
			$copu_status = $copu_product['status'];
			$copu_stores = isset($copu_product['stores']) ? $copu_product['stores'] : array();
			$copu_login = $copu_product['login'];
			$copu_customer_groups = isset($copu_product['customer_groups']) ? $copu_product['customer_groups'] : array();
			$copu_limit = $copu_product['limit'];
			$copu_filetypes = isset($copu_product['filetypes']) ? $copu_product['filetypes'] : array();
			$copu_max_filesize = $copu_product['max_filesize'];
			$copu_max_dimension_w = $copu_product['max_dimension_w'];
			$copu_max_dimension_h = $copu_product['max_dimension_h'];
			$copu_image_channel = $copu_product['image_channel'];
			$copu_max_filename_length = $copu_product['max_filename_length'];
			$copu_file_location = empty($copu_product['file_location']) ? "" : "../" . $copu_product['file_location'] . "/";
			$copu_preview = $copu_product['preview'];
			$copu_replace = $copu_product['replace'];
			$copu_preview_dimension_w = $copu_product['preview_dimension_w'];
			$copu_preview_dimension_h = $copu_product['preview_dimension_h'];
		} else {
			$copu_status = $this->config->get('copu_' . $type . '_status');
			$copu_stores = $this->config->get('copu_' . $type . '_stores');
			$copu_login = $this->config->get('copu_' . $type . '_login');
			$copu_customer_groups = $this->config->get('copu_' . $type . '_customer_groups');
			$copu_limit = $this->config->get('copu_' . $type . '_limit');
			$copu_filetypes = $this->config->get('copu_' . $type . '_filetypes');
			$copu_max_filesize = $this->config->get('copu_' . $type . '_max_filesize');
			$copu_max_dimension_w = $this->config->get('copu_' . $type . '_max_dimension_w');
			$copu_max_dimension_h = $this->config->get('copu_' . $type . '_max_dimension_h');
			$copu_image_channel = $this->config->get('copu_' . $type . '_image_channel');
			$copu_max_filename_length = $this->config->get('copu_' . $type . '_max_filename_length');
			$copu_file_location = $this->config->get('copu_' . $type . '_file_location') ? "../" . $this->config->get('copu_' . $type . '_file_location')  . "/": "";
			$copu_preview = $this->config->get('copu_' . $type . '_preview');
			$copu_preview_dimension_w = $this->config->get('copu_' . $type . '_preview_dimension_w');
			$copu_preview_dimension_h = $this->config->get('copu_' . $type . '_preview_dimension_h');
			$copu_replace = false;
		}

		if(!empty($copu_file_location)) {
			if(strpos($copu_file_location, '%customer_id%')) {
				if($this->customer->isLogged()) {
					$copu_file_location = str_replace('%customer_id%', $this->customer->isLogged(), $copu_file_location);
				} else {
					$copu_file_location = "";
				}
			}
			if(strpos($copu_file_location, '%product_id%') && $type == 'product' && $type_id) {
				$copu_file_location = str_replace('%product_id%', $type_id, $copu_file_location);
			}
			if(strpos($copu_file_location, '%order_id%')) {
				if($type == 'order' && $type_id && !$session) {
					$copu_file_location = str_replace('%order_id%', $type_id, $copu_file_location);
				} else {
					$copu_file_location = "";
				}				
			}
		}
		if(!empty($copu_file_location) && !file_exists(DIR_DOWNLOAD . $copu_file_location)) {
			mkdir(DIR_DOWNLOAD . $copu_file_location, 0755, true);
		}

		$json = array();

		//create upload session
		if(!isset($this->session->data['copu_' . $type . '_uploads']) && $session) {
			$this->session->data['copu_' . $type . '_uploads'] = array();
		}
		if($type == 'product' && $type_id && !isset($this->session->data['copu_' . $type . '_uploads'][$type_id])) {
			$this->session->data['copu_' . $type . '_uploads'][$type_id] = array();
		}
		if($type == 'product' && $type_id && $product_option_id && !isset($this->session->data['copu_' . $type . '_uploads'][$type_id][$product_option_id])) {
			$this->session->data['copu_' . $type . '_uploads'][$type_id][$product_option_id] = array();
		}
		//check status and store
		if(!$copu_status || $copu_stores == "" || !in_array($this->config->get('config_store_id'), $copu_stores)) {
			$json['error'] = $this->language->get('error_upload_status');
			$this->response->setOutput(json_encode($json));
			return;
		}

		//check login
		if($copu_login && ($session xor $type == 'customer') && (!$this->customer->isLogged() || !$copu_customer_groups || !in_array($this->customer->getCustomerGroupId(), $copu_customer_groups))) {
			$json['error'] = $this->language->get('error_login');
			$this->response->setOutput(json_encode($json));
			return;
		}

		//check file limit
		$upload_total = 0;
		if($type != 'product' && isset($this->session->data['copu_' . $type . '_uploads'])) {
			$upload_total = count($this->session->data['copu_' . $type . '_uploads']);
		}
		if($type == 'product' && $this->session->data['copu_' . $type . '_uploads'][$type_id][$product_option_id]) {
			$upload_total = count($this->session->data['copu_' . $type . '_uploads'][$type_id][$product_option_id]);
		}
		if(!$session) {
			if($type == 'customer') {
				$type_id = $this->customer->isLogged();
			}
			$upload_total = $this->model_myoc_copu->getTotalUploads(array('type' => $type, 'type_id' => $type_id));
		}
		if($upload_total >= $copu_limit) {
			$json['error'] = $this->language->get('error_limit');
			$this->response->setOutput(json_encode($json));
			return;
		}

		$filetypes = $this->model_myoc_copu->getFiletypes($copu_filetypes);
		
		if (!empty($this->request->files['file']['name'])) {
			$filename = basename(preg_replace('/[^a-zA-Z0-9\.\-\s+]/', '', html_entity_decode($this->request->files['file']['name'], ENT_QUOTES, 'UTF-8')));
			
			if ((strlen($filename) < 3) || (strlen($filename) > 64)) {
				$json['error'] = $this->language->get('error_filename');
			}
			
			$allowed_ext = array();
			$allowed_mime = array();
			
			foreach ($filetypes as $filetype) {
				$allowed_ext[] = trim($filetype['ext']);
				$allowed_mime[trim($filetype['ext'])] = ($filetype['mime'] == '') ? false : explode(",", $filetype['mime']);
			}

			$ext = strtolower(substr(strrchr($filename, '.'), 1));
			$mime = function_exists('mime_content_type') ? mime_content_type($this->request->files['file']['tmp_name']) : false;
			
			//check file ext and mime
			if (!in_array($ext, $allowed_ext) || ($mime && $allowed_mime[$ext] && !in_array($mime, $allowed_mime[$ext]))) {
				$json['error'] = sprintf($this->language->get('error_filetype'), implode(", ", $allowed_ext));
			}

			//check file size
			if(filesize($this->request->files['file']['tmp_name']) > $copu_max_filesize * 1024) {
				$json['error'] = sprintf($this->language->get('error_filesize'), formatFilesize($copu_max_filesize * 1024));
			}
				
			if(is_uploaded_file($this->request->files['file']['tmp_name']) && file_exists($this->request->files['file']['tmp_name'])) {
				$imageinfo = @getimagesize($this->request->files['file']['tmp_name']);
				if($imageinfo[2] > 0 && $imageinfo[2] < 4 ) {
					//check image file dimension
					if($copu_max_dimension_w && $copu_max_dimension_h && ($imageinfo[0] > $copu_max_dimension_w || $imageinfo[1] > $copu_max_dimension_h)) {
						$json['error'] = sprintf($this->language->get('error_dimension'), $copu_max_dimension_w, $copu_max_dimension_h);
					}
					//check image channel
					if($copu_image_channel && $imageinfo['channels'] != $copu_image_channel) {
						$channel = '';
						if($copu_image_channel == 3) {
							$channel = $this->language->get('text_rgb');
						}
						if($copu_image_channel == 4) {
							$channel = $this->language->get('text_cmyk');
						}
						$json['error'] = sprintf($this->language->get('error_image_channel'), $channel);
					}
				}
			}

			
			
						
			//check other system upload error
			if ($this->request->files['file']['error'] != UPLOAD_ERR_OK) {
				$json['error'] = $this->language->get('error_upload_' . $this->request->files['file']['error']);
			}
		} else {
			$json['error'] = $this->language->get('error_upload');
		}
		
		if (!$json) {
			if (is_uploaded_file($this->request->files['file']['tmp_name']) && file_exists($this->request->files['file']['tmp_name'])) {
				$upload_id = md5(mt_rand());
				$file = $filename . '.' . $upload_id;
				
				move_uploaded_file($this->request->files['file']['tmp_name'], DIR_DOWNLOAD . $copu_file_location . $file);
				
				if(method_exists($this->encryption, 'encrypt')) {
					$encryption = $this->encryption;
				} else {
					$this->load->library('encryption');
				 	$encryption = new Encryption($this->config->get('config_encryption'));
				}
				if(!$session) {
					$upload_id = $this->model_myoc_copu->addUpload(array('filename' => $copu_file_location . $file, $type . '_id' => $type_id));

					if($type == 'order' && $this->config->get('copu_order_history_modify_status')) {
						$this->load->model('checkout/order');
						$order_info = $this->model_checkout_order->getOrder($type_id);
						if($order_info['order_status_id'] > 0) {
							$this->model_checkout_order->update($type_id, $this->config->get('copu_order_history_modify_status'), $this->language->get('text_uploaded') . ' ' . $filename);
						}
					}
				} elseif($type == 'product' && $type_id && $product_option_id) {
					$this->session->data['copu_' . $type . '_uploads'][$type_id][$product_option_id][$upload_id] = $encryption->encrypt($copu_file_location . $file);
				} else {
					$this->session->data['copu_' . $type . '_uploads'][$upload_id] = $encryption->encrypt($copu_file_location . $file);
				}
				$this->load->model('tool/image');

				$image = false;
				$popup = false;
				$replace = false;
				if(($copu_preview || $copu_replace) && $file && filesize(DIR_DOWNLOAD . $copu_file_location . $file)) {
					$imageinfo = @getimagesize(DIR_DOWNLOAD . $copu_file_location . $file);
					if($imageinfo[2] > 0 && $imageinfo[2] < 4) {
						copy(DIR_DOWNLOAD . $copu_file_location . $file, DIR_IMAGE . $filename);
						$image = $copu_preview ? $this->model_tool_image->resize($filename, $copu_preview_dimension_w, $copu_preview_dimension_h) : false;
						$popup = ($copu_preview || $copu_replace) ? $this->model_tool_image->resize($filename, $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height')) : false;
						$replace = ($type == 'product' && $copu_replace) ? $this->model_tool_image->resize($filename, $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height')) : false;
						unlink(DIR_IMAGE . $filename);
					} else {
						$image = $copu_preview ? $this->model_tool_image->resize('no_image.jpg', $copu_preview_dimension_w, $copu_preview_dimension_h) : false;
					}
				}

				$json['file'] = array();
				$json['file']['upload_id'] = $upload_id;
				$json['file']['image'] = $image;
				$json['file']['popup'] = $popup;
				$json['file']['replace'] = $replace;
				$json['file']['name'] = truncateFilename($filename, $copu_max_filename_length);
				$json['file']['href'] = $this->url->link('myoc/copu/download', 'f=' . urlencode($encryption->encrypt($copu_file_location . $file)), $ssl);
				$json['file']['date'] = date($this->language->get('date_format_short'));
				$json['file']['size'] = formatFilesize($this->request->files['file']['size']);

				$json['file']['delete'] = $this->url->link('myoc/copu/delete', 'upload_id=' . $upload_id, $ssl);
			}

			$json['success'] = true;
		}	
		
		$this->response->setOutput(json_encode($json));		
	}

	public function download() {
		if(method_exists($this->encryption, 'encrypt')) {
			$encryption = $this->encryption;
		} else {
			$this->load->library('encryption');
		 	$encryption = new Encryption($this->config->get('config_encryption'));
		}
		$filename = $encryption->decrypt($this->request->get['f']);
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
        
        $this->language->load('myoc/copu');

	    $json = array();
	    $json['error'] = $this->language->get('error_delete');

		if(method_exists($this->encryption, 'encrypt')) {
			$encryption = $this->encryption;
		} else {
			$this->load->library('encryption');
		 	$encryption = new Encryption($this->config->get('config_encryption'));
		}
		if(isset($this->session->data['copu_customer_uploads'][$upload_id]) && unlink(DIR_DOWNLOAD . $encryption->decrypt($this->session->data['copu_customer_uploads'][$upload_id]))) {
			unset($this->session->data['copu_customer_uploads'][$upload_id]);
            $json['success'] = true;
            unset($json['error']);
		} elseif(isset($this->session->data['copu_order_uploads'][$upload_id]) && unlink(DIR_DOWNLOAD . $encryption->decrypt($this->session->data['copu_order_uploads'][$upload_id]))) {
			unset($this->session->data['copu_order_uploads'][$upload_id]);
            $json['success'] = true;
            unset($json['error']);
		} elseif(isset($this->session->data['copu_product_uploads']) && !empty($this->session->data['copu_product_uploads'])) {
			foreach ($this->session->data['copu_product_uploads'] as $product_id => $product_uploads) {
				foreach ($product_uploads as $product_option_id => $product_upload) {
					if(isset($this->session->data['copu_product_uploads'][$product_id][$product_option_id][$upload_id]) && unlink(DIR_DOWNLOAD . $encryption->decrypt($this->session->data['copu_product_uploads'][$product_id][$product_option_id][$upload_id]))) {
						unset($this->session->data['copu_product_uploads'][$product_id][$product_option_id][$upload_id]);
			            $json['success'] = true;
			            unset($json['error']);
			            break 2;
					}
				}
			}
		}
		if(isset($json['error'])) {
			$this->load->model('myoc/copu');
	    	$upload = $this->model_myoc_copu->getUpload($upload_id);
	        if($upload && $upload['customer_id'] == $this->customer->isLogged())
	        {
		        if(unlink(DIR_DOWNLOAD . $upload['filename']))
		        {
		            $this->model_myoc_copu->deleteUpload($upload_id);
		            $json['success'] = true;
		            unset($json['error']);
		        }
		    }
		}

        $this->response->setOutput(json_encode($json));
	}
}
?>