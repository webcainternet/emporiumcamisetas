<?php
class ModelMyocCopu extends Model {
	public function getTotalUploads($data) {
		if(isset($data['type']) && isset($data['type_id'])) {
			$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "myoc_" . $data['type'] . "_upload tu LEFT JOIN `" . DB_PREFIX . "myoc_upload` u ON (tu.upload_id = u.upload_id) WHERE tu." . $data['type'] . "_id = '" . (int)$data['type_id'] . "'");
			return $query->row['total'];
		}
		return false;
	}

	public function getUploads($data) {
		if(isset($data['customer_id'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}
			
			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}	
			
			$query = $this->db->query("SELECT u.*,cu.* FROM " . DB_PREFIX . "myoc_customer_upload cu LEFT JOIN `" . DB_PREFIX . "myoc_upload` u ON (cu.upload_id = u.upload_id) WHERE cu.customer_id = '" . (int)$data['customer_id'] . "' ORDER BY u.date_added DESC LIMIT " . (int)$data['start'] . "," . (int)$data['limit']);
		}
		if(isset($data['order_id'])) {			
			$query = $this->db->query("SELECT u.*,ou.* FROM " . DB_PREFIX . "myoc_order_upload ou LEFT JOIN `" . DB_PREFIX . "myoc_upload` u ON (ou.upload_id = u.upload_id) WHERE ou.order_id = '" . (int)$data['order_id'] . "' ORDER BY u.date_added DESC");
		}
		$uploads = array();

		foreach($query->rows as $row) {
			$uploads[$row['upload_id']] = array(
				'upload_id' => $row['upload_id'],
				'filename' => $row['filename'],
				'mask' => $row['mask'],
				'date_added' => $row['date_added'],
				'customer_id' => isset($row['customer_id']) ? $row['customer_id'] : 0,
				'order_id' => isset($row['order_id']) ? $row['order_id'] : 0,
			);
		}
		return $uploads;
	}

	public function getFiletypes($filetype_ids = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "myoc_filetype WHERE ";
		if(!empty($filetype_ids)) {
			foreach ($filetype_ids as $filetype_id) {
				$sql .= "`filetype_id` = '" . (int)$filetype_id . "' OR ";
			}
		}
		$sql .= "'0';";
		$query = $this->db->query($sql);
		
		return $query->rows;
	}

	public function addUpload($data) {
		$this->language->load('myoc/copu');

		$mask = basename(substr($data['filename'], 0, strrpos($data['filename'], '.')));
		$this->db->query("INSERT INTO " . DB_PREFIX . "myoc_upload SET filename = '" . $this->db->escape($data['filename']) . "', mask = '" . $this->db->escape($mask) . "', date_added = NOW();");
		$upload_id = $this->db->getLastId();
		$email_attachment = false;

		if(isset($data['customer_id'])) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "myoc_customer_upload SET customer_id = '" . (int)$data['customer_id'] . "', upload_id = '" . (int)$upload_id . "';");
		
			if ($this->config->get('copu_customer_email_alert')) {
				$this->load->model('account/customer');
				$customer_info = $this->model_account_customer->getCustomer($data['customer_id']);
				$subject = sprintf($this->language->get('text_new_upload_title'), html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'), $this->language->get('text_customer'), $customer_info['firstname'] . ' ' . $customer_info['lastname']);

				$text = sprintf($this->language->get('text_new_upload_body'), $this->language->get('text_customer'), $customer_info['firstname'] . ' ' . $customer_info['lastname'] . ' (' . $customer_info['email'] . ')') . "\n\n";
				if ($this->config->get('copu_customer_email_attachment')) {
					$email_attachment = true;
				}
			}
		}
		if(isset($data['order_id'])) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "myoc_order_upload SET order_id = '" . (int)$data['order_id'] . "', upload_id = '" . (int)$upload_id . "';");
		
			$order_info_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "order` WHERE order_id = '" . (int)$data['order_id'] . "'");
			if ($this->config->get('copu_order_history_modify_email_alert') && $order_info_query->row['order_status_id']) {
				$subject = sprintf($this->language->get('text_new_upload_title'), html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'), $this->language->get('text_order'), $data['order_id']);

				$text = sprintf($this->language->get('text_new_upload_body'), $this->language->get('text_order'), $data['order_id']) . "\n\n";
				if ($this->config->get('copu_order_email_attachment')) {
					$email_attachment = true;
				}
			}
		}
		if(isset($subject)) {
			$text .= sprintf($this->language->get('text_new_upload_file'), $mask) . "\n";
			$text .= sprintf($this->language->get('text_new_upload_date'), date($this->language->get('date_format_long') . ' ' . $this->language->get('time_format'))) . "\n";
			
			// Admin Alert Mail
			$mail = new Mail(); 
			$mail->protocol = $this->config->get('config_mail_protocol');
			$mail->parameter = $this->config->get('config_mail_parameter');
			$mail->hostname = $this->config->get('config_smtp_host');
			$mail->username = $this->config->get('config_smtp_username');
			$mail->password = $this->config->get('config_smtp_password');
			$mail->port = $this->config->get('config_smtp_port');
			$mail->timeout = $this->config->get('config_smtp_timeout');
			if($email_attachment) {
				copy(DIR_DOWNLOAD . $data['filename'], DIR_DOWNLOAD . $mask);
				$mail->addAttachment(DIR_DOWNLOAD . $mask);
			}
			$mail->setTo($this->config->get('config_email'));
			$mail->setFrom($this->config->get('config_email'));
			$mail->setSender($this->config->get('config_name'));
			$mail->setSubject(html_entity_decode($subject, ENT_QUOTES, 'UTF-8'));
			$mail->setText(html_entity_decode($text, ENT_QUOTES, 'UTF-8'));
			$mail->send();

			// Send to additional alert emails
			$emails = explode(',', $this->config->get('config_alert_emails'));

			foreach ($emails as $email) {
				if ($email && preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $email)) {
					$mail->setTo($email);
					$mail->send();
				}
			}
			if(file_exists(DIR_DOWNLOAD . $mask)) {
				unlink(DIR_DOWNLOAD . $mask);
			}
		}

		return $upload_id;
	}

	public function getUpload($upload_id) {
		$query = $this->db->query("SELECT u.*,cu.* FROM " . DB_PREFIX . "myoc_upload u LEFT JOIN `" . DB_PREFIX . "myoc_customer_upload` cu ON (cu.upload_id = u.upload_id) WHERE u.upload_id = '" . (int)$upload_id . "'");

		return $query->row;
	}

	public function deleteUpload($upload_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "myoc_upload WHERE upload_id = '" . (int)$upload_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "myoc_customer_upload WHERE upload_id = '" . (int)$upload_id . "'");
	}

	public function getOrderUploadInvoice($data) {
		if(!$this->config->get('copu_order_status') || !$this->config->get('copu_order_stores') || !in_array($this->config->get('config_store_id'), $this->config->get('copu_order_stores'))) {
			return false;
		}
		$language = new Language($data['language_directory']);
		$this->language->load('myoc/copu');

		$template = new Template();

		$template->data['column_name'] = $this->language->get('column_name');
		$template->data['column_size'] = $this->language->get('column_size');

		$template->data['text_empty'] = $this->language->get('text_empty');
		$template->data['text_upload'] = $this->language->get('text_upload');

		$this->load->helper('copu');

		$template->data['format'] = $data['format'];

		$template->data['uploads'] = array();

		$uploads = $this->getUploads(array('order_id' => $data['order_id']));

		if(method_exists($this->encryption, 'encrypt')) {
			$encryption = $this->encryption;
		} else {
			$this->load->library('encryption');
			$encryption = new Encryption($this->config->get('config_encryption'));
		}

		if($uploads) {
			foreach ($uploads as $upload) {
				if (file_exists(DIR_DOWNLOAD . $upload['filename'])) {
					$size = filesize(DIR_DOWNLOAD . $upload['filename']);

					$template->data['uploads'][] = array(
						'name' => $upload['mask'],
						'size' => formatFilesize($size),
					);
				}
			}
		}
			
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/myoc/copu_mail.tpl')) {
			return $template->fetch($this->config->get('config_template') . '/template/myoc/copu_mail.tpl');
		} else {
			return $template->fetch('default/template/myoc/copu_mail.tpl');
		}
	}

	public function getNewCustomerId() {
		$query = $this->db->query("SELECT customer_id FROM " . DB_PREFIX . "customer ORDER BY customer_id DESC LIMIT 0,1");

		return $query->row['customer_id'];
	}

	public function editOrderOptionValues($data = array()) {
		$this->db->query("UPDATE " . DB_PREFIX . "order_option SET value = '" . $data['new_value'] . "' WHERE order_id = '" . (int)$data['order_id'] . "' AND product_option_id = '" . (int)$data['product_option_id'] . "' AND value = '" . $data['value'] . "' AND type = 'file'");
	}
}
?>