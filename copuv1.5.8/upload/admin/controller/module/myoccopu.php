<?php
class ControllerModuleMyoccopu extends Controller {
	private $error = array();

	public function index()
	{
		$this->language->load('module/myoccopu');

		$this->document->setTitle($this->language->get('common_title'));
	
		$this->load->model('myoc/copu');

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('copu', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			if (isset($this->request->get['exit'])) {
				$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
			} else {
				$this->redirect($this->url->link('module/myoccopu', 'token=' . $this->session->data['token'], 'SSL'));
			}
		}

		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('common_title'),
			'href'      => $this->url->link('module/myoccopu', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);

		$this->data['common_title'] = $this->language->get('common_title');
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_save_exit'] = $this->language->get('button_save_exit');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_copu_product'] = $this->language->get('button_add_copu_product');
		$this->data['button_add_filetype'] = $this->language->get('button_add_filetype');

		$this->data['tab_customer'] = $this->language->get('tab_customer');
		$this->data['tab_order'] = $this->language->get('tab_order');
		$this->data['tab_product'] = $this->language->get('tab_product');
		$this->data['tab_copu_product'] = $this->language->get('tab_copu_product');
		$this->data['tab_filetype'] = $this->language->get('tab_filetype');

		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_register'] = $this->language->get('entry_register');
		$this->data['entry_email_alert'] = $this->language->get('entry_email_alert');
		$this->data['entry_history_modify'] = $this->language->get('entry_history_modify');
		$this->data['entry_history_modify_status'] = $this->language->get('entry_history_modify_status');
		$this->data['entry_history_modify_email_alert'] = $this->language->get('entry_history_modify_email_alert');
		$this->data['entry_drag_drop'] = $this->language->get('entry_drag_drop');
		$this->data['entry_multiple'] = $this->language->get('entry_multiple');
		$this->data['entry_limit'] = $this->language->get('entry_limit');
		$this->data['entry_minimum'] = $this->language->get('entry_minimum');
		$this->data['entry_files_per_page'] = $this->language->get('entry_files_per_page');
		$this->data['entry_max_filesize'] = $this->language->get('entry_max_filesize');
		$this->data['entry_max_dimension'] = $this->language->get('entry_max_dimension');
		$this->data['entry_image_channel'] = $this->language->get('entry_image_channel');
		$this->data['entry_max_filename_length'] = $this->language->get('entry_max_filename_length');
		$this->data['entry_message'] = $this->language->get('entry_message');
		$this->data['entry_comment'] = $this->language->get('entry_comment');
		$this->data['entry_preview'] = $this->language->get('entry_preview');
		$this->data['entry_preview_dimension'] = $this->language->get('entry_preview_dimension');
		$this->data['entry_filetype'] = $this->language->get('entry_filetype');
		$this->data['entry_replace'] = $this->language->get('entry_replace');
		$this->data['entry_login'] = $this->language->get('entry_login');
		$this->data['entry_customer_group'] = $this->language->get('entry_customer_group');
		$this->data['entry_store'] = $this->language->get('entry_store');
		$this->data['entry_ext'] = $this->language->get('entry_ext');
		$this->data['entry_mime'] = $this->language->get('entry_mime');
		$this->data['entry_upload_option'] = $this->language->get('entry_upload_option');
		$this->data['entry_force_qty'] = $this->language->get('entry_force_qty');
		$this->data['entry_customer_file_location'] = $this->language->get('entry_customer_file_location');
		$this->data['entry_order_file_location'] = $this->language->get('entry_order_file_location');
		$this->data['entry_product_file_location'] = $this->language->get('entry_product_file_location');
		$this->data['entry_customer_email_attachment'] = $this->language->get('entry_customer_email_attachment');
		$this->data['entry_order_email_attachment'] = $this->language->get('entry_order_email_attachment');
		$this->data['entry_product_email_attachment'] = $this->language->get('entry_product_email_attachment');

		$this->data['column_ext'] = $this->language->get('column_ext');
		$this->data['column_mime'] = $this->language->get('column_mime');
		$this->data['column_action'] = $this->language->get('column_action');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_yes'] = $this->language->get('text_yes');
		$this->data['text_no'] = $this->language->get('text_no');
		$this->data['text_none'] = $this->language->get('text_none');
		$this->data['text_default'] = $this->language->get('text_default');
		$this->data['text_add_filetype'] = $this->language->get('text_add_filetype');
		$this->data['text_no_results'] = $this->language->get('text_no_results');
		$this->data['text_delete'] = $this->language->get('text_delete');
		$this->data['text_confirm_delete'] = $this->language->get('text_confirm_delete');
		$this->data['text_any'] = $this->language->get('text_any');
		$this->data['text_rgb'] = $this->language->get('text_rgb');
		$this->data['text_cmyk'] = $this->language->get('text_cmyk');
		
		$this->data['action'] = $this->url->link('module/myoccopu', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['action_exit'] = $this->url->link('module/myoccopu', 'token=' . $this->session->data['token'] . '&exit=1', 'SSL');
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['add_filetype'] = $this->url->link('module/myoccopu/filetype', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['token'] = $this->session->data['token'];
		
		$this->data['myoc_copyright'] = $this->language->get('myoc_copyright');
 
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}

		$error_vars = array(
			'customer_limit',
			'order_limit',
			'customer_minimum',
			'order_minimum',
			'customer_files_per_page',
			'customer_max_filename_length',
			'order_max_filename_length',
			'customer_file_location',
			'order_file_location',
			'copu_products'
		);
		foreach ($error_vars as $error_var) {
			if (isset($this->error[$error_var])) {
				$this->data['error_' . $error_var] = $this->error[$error_var];
			} else {
				$this->data['error_' . $error_var] = array();
			}
		}

		$config_vars = array(
			'copu_customer_status' => false,
			'copu_order_status' => false,
			'copu_customer_limit' => 1,
			'copu_order_limit' => 1,
			'copu_customer_minimum' => 1,
			'copu_order_minimum' => 1,
			'copu_customer_register' => false,
			'copu_customer_email_alert' => 0,
			'copu_order_history_modify' => false,
			'copu_order_history_modify_status' => 0,
			'copu_order_history_modify_email_alert' => 0,
			'copu_customer_drag_drop' => true,
			'copu_order_drag_drop' => true,
			'copu_customer_multiple' => true,
			'copu_order_multiple' => true,
			'copu_customer_files_per_page' => 10,
			'copu_customer_max_filesize' => 5242,
			'copu_order_max_filesize' => 5242,
			'copu_customer_max_dimension_w' => 0,
			'copu_customer_max_dimension_h' => 0,
			'copu_order_max_dimension_w' => 0,
			'copu_order_max_dimension_h' => 0,
			'copu_customer_image_channel' => 0,
			'copu_order_image_channel' => 0,
			'copu_customer_max_filename_length' => 20,
			'copu_order_max_filename_length' => 20,
			'copu_customer_file_location' => 'upload',
			'copu_order_file_location' => 'upload',
			'copu_customer_email_attachment' => 0,
			'copu_order_email_attachment' => 0,
			'copu_customer_message' => array(),
			'copu_order_message' => array(),
			'copu_customer_preview' => 1,
			'copu_order_preview' => 1,
			'copu_customer_preview_dimension_w' => 80,
			'copu_order_preview_dimension_w' => 80,
			'copu_customer_preview_dimension_h' => 80,
			'copu_order_preview_dimension_h' => 80,
			'copu_customer_filetypes' => array(),
			'copu_order_filetypes' => array(),
			'copu_customer_login' => true,
			'copu_order_login' => false,
			'copu_customer_customer_groups' => array(1),
			'copu_order_customer_groups' => array(),
			'copu_customer_stores' => array(0),
			'copu_order_stores' => array(0),
			'copu_products' => array(),
		);

		foreach ($config_vars as $config_var => $default_value) {
			if (isset($this->request->post[$config_var])) {
				$this->data[$config_var] = $this->request->post[$config_var];
			} elseif(is_null($this->config->get($config_var))) {
				$this->data[$config_var] = $default_value;
			} else {
				$this->data[$config_var] = $this->config->get($config_var);
			}
		}

		$this->data['next_copu_product_id'] = 1;
		if($this->data['copu_products']) {
			$copu_product_ids = array();
			foreach ($this->data['copu_products'] as $copu_product) {
				$copu_product_ids[] = $copu_product['copu_product_id'];
			}
			sort($copu_product_ids);
			$this->data['next_copu_product_id'] += array_pop($copu_product_ids);
		}

        //Message
        $this->load->model('localisation/language');
		$this->data['languages'] = $this->model_localisation_language->getLanguages();

		$this->data['copu_options'] = array();
		$this->load->model('catalog/option');
		$options = $this->model_catalog_option->getOptions();
		if(!empty($options)) {
			foreach ($options as $option) {
				if($option['type'] == 'file') {
					$this->data['copu_options'][] = array(
						'option_id' => $option['option_id'],
            			'name' => $option['name'],
					);
				}
			}
		}

		$this->data['filetypes'] = array();
        $filetypes = $this->model_myoc_copu->getFiletypes();
        foreach ($filetypes as $filetype) {
        	$this->data['filetypes'][$filetype['filetype_id']] = array(
        		'filetype_id' => $filetype['filetype_id'],
        		'ext' => $filetype['ext'],
        		'mime' => $filetype['mime'],
        		'delete' => $this->url->link('module/myoccopu/delete', 'filetype_id=' . $filetype['filetype_id'] . '&token=' . $this->session->data['token'], 'SSL'),
        	);
        }

        $this->data['filesizes'] = array(
        	'512' => '512 Kb',
        	'1024' => '1 MB',
        	'2048' => '2 MB',
        	'3072' => '3 MB',
        	'4096' => '4 MB',
        	'5120' => '5 MB',
        	'10240' => '10 MB',
        	'20480' => '20 MB',
        	'30720' => '30 MB',
        	'51200' => '50 MB',
        	'102400' => '100 MB',
        	'204800' => '200 MB',
        	'307200' => '300 MB',
        	'512000' => '500 MB',
        	'1024000' => '1 GB',
        	'2048000' => '2 GB',
        	'3072000' => '3 GB',
        	'5120000' => '5 GB',
        	'10240000' => '10 GB',
        );

		$this->load->model('sale/customer_group');
        $this->data['customer_groups'] = $this->model_sale_customer_group->getCustomerGroups();

		$this->load->model('setting/store');
        $this->data['stores'] = $this->model_setting_store->getStores();

        $this->load->model('localisation/order_status');
    	$this->data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();

		$this->template = 'myoc/copu.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
	}

	private function validate() {
		$validate_vars = array(
			'customer_limit',
			'customer_minimum',
			'order_limit',
			'order_minimum',
			'customer_files_per_page',
			'customer_max_filename_length',
			'order_max_filename_length'
		);

		foreach ($validate_vars as $validate_var) {
			if (isset($this->request->post['copu_' . $validate_var])) {
				if(!is_numeric($this->request->post['copu_' . $validate_var])) {
					$this->error[$validate_var] = $this->language->get('error_numeric');
					$this->error['warning'] = $this->language->get('error_submission');
				}
			}
		}

		$copu_product_validate_vars = array(
			'limit',
			'minimum',
			'max_filename_length',
		);

		if(isset($this->request->post['copu_products'])) {
			foreach ($this->request->post['copu_products'] as $copu_product) {
				foreach ($copu_product_validate_vars as $copu_product_validate_var) {
					if (isset($copu_product[$copu_product_validate_var])) {
						if(!is_numeric($copu_product[$copu_product_validate_var])) {
							if(!isset($this->error['copu_products'])) {
								$this->error['copu_products'] = array();
							}
							$this->error['copu_products'][$copu_product['copu_product_id']][$copu_product_validate_var] = $this->language->get('error_numeric');
							$this->error['warning'] = $this->language->get('error_submission');
						}
					}
				}
			}
		}

		if (isset($this->request->post['copu_customer_file_location'])) {
			if(strstr($this->request->post['copu_customer_file_location'], '%order_id%') || strstr($this->request->post['copu_customer_file_location'], '%product_id%')) {
				$this->error['customer_file_location'] = sprintf($this->language->get('error_file_location'), '"%order_id%" and "%product_id%"', 'customer');
				$this->error['warning'] = $this->language->get('error_submission');
			}
		}

		if (isset($this->request->post['copu_order_file_location'])) {
			if(strstr($this->request->post['copu_order_file_location'], '%product_id%')) {
				$this->error['order_file_location'] = sprintf($this->language->get('error_file_location'), '"%product_id%"', 'order');
				$this->error['warning'] = $this->language->get('error_submission');
			}
		}

		if (!$this->user->hasPermission('modify', 'module/myoccopu')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
            return true;
		} else {
            return false;
		}
	}

	public function insert() {
		$json = array();
		if (!$this->user->hasPermission('modify', 'module/myoccopu')) {
			$this->language->load('module/myoccopu');
			$json['error'] = $this->language->get('error_permission');
		}
		if(!$json) {
			$data = array(
				'ext' => $this->request->get['ext'],
				'mime' => $this->request->get['mime'],
			);
			$this->load->model('myoc/copu');
			$json['success'] = true;
			$json['filetype'] = $this->model_myoc_copu->addFiletype($data);
		}
		$this->response->setOutput(json_encode($json));
	}

	public function delete() {
		$json = array();
		if (!$this->user->hasPermission('modify', 'module/myoccopu')) {
			$this->language->load('module/myoccopu');
			$json['error'] = $this->language->get('error_permission');
		}
		if(!$json) {
	        $filetype_id = $this->request->get['filetype_id'];
	        $this->load->model('myoc/copu');

	        $filetype = $this->model_myoc_copu->getFiletype($filetype_id);
	        if($filetype) {
		        $this->model_myoc_copu->deleteFiletype($filetype_id);
			    $json['success'] = true;
			}
		}
        $this->response->setOutput(json_encode($json));
	}

	public function install()
	{
		$this->load->model('myoc/copu');
		$this->model_myoc_copu->installTable();

		$this->load->model('user/user_group');
		$this->model_user_user_group->addPermission($this->user->getId(), 'access', 'myoc/copu');
		$this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'myoc/copu');
		
		$this->language->load('module/myoccopu');
		$this->session->data['success'] = sprintf($this->language->get('success_install'), $this->url->link('module/myoccopu', 'token=' . $this->session->data['token'], 'SSL'));
	}

	public function uninstall()
	{
		$this->model_setting_setting->deleteSetting('copu');
		$this->load->model('myoc/copu');
		$this->model_myoc_copu->uninstallTable();
	}
}
?>