<?php  
class ControllerCheckoutCheckout extends Controller { 
	public function index() {
if($this->config->get('copu_order_status') && $this->config->get('copu_order_stores') && in_array($this->config->get('config_store_id'), $this->config->get('copu_order_stores')) && $this->config->get('copu_order_minimum') && (!isset($this->session->data['copu_order_uploads']) || count($this->session->data['copu_order_uploads']) < $this->config->get('copu_order_minimum'))) {
					$this->redirect($this->url->link('checkout/cart'));
				}
			$this->document->addScript('catalog/view/javascript/jquery/myoc/copu-helper.js');
			$this->document->addScript('catalog/view/javascript/jquery/myoc/jquery.ui.widget.js');
			$this->document->addScript('catalog/view/javascript/jquery/myoc/load-image.min.js');
			$this->document->addScript('catalog/view/javascript/jquery/myoc/canvas-to-blob.min.js');
			$this->document->addScript('catalog/view/javascript/jquery/myoc/jquery.iframe-transport.js');
			$this->document->addScript('catalog/view/javascript/jquery/myoc/jquery.fileupload.js');
			$this->document->addScript('catalog/view/javascript/jquery/myoc/jquery.fileupload-process.js');
			$this->document->addScript('catalog/view/javascript/jquery/myoc/jquery.fileupload-image.js');
			if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/myoc/copu.css')) {
				$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/myoc/copu.css');
			} else {
				$this->document->addStyle('catalog/view/theme/default/stylesheet/myoc/copu.css');
			}
		// Validate cart has products and has stock.
		if ((!$this->cart->hasProducts() && empty($this->session->data['vouchers'])) || (!$this->cart->hasStock() && !$this->config->get('config_stock_checkout'))) {
			$this->redirect($this->url->link('checkout/cart'));
		}

		// Validate minimum quantity requirments.			
		$products = $this->cart->getProducts();

		foreach ($products as $product) {
			$product_total = 0;

			foreach ($products as $product_2) {
				if ($product_2['product_id'] == $product['product_id']) {
					$product_total += $product_2['quantity'];
				}
			}		

			if ($product['minimum'] > $product_total) {
				$this->redirect($this->url->link('checkout/cart'));
			}				
		}

		$this->language->load('checkout/checkout');

		$this->document->setTitle($this->language->get('heading_title')); 
		$this->document->addScript('catalog/view/javascript/jquery/colorbox/jquery.colorbox-min.js');
		$this->document->addStyle('catalog/view/javascript/jquery/colorbox/colorbox.css');

		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),
			'separator' => false
		);

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_cart'),
			'href'      => $this->url->link('checkout/cart'),
			'separator' => $this->language->get('text_separator')
		);

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('checkout/checkout', '', 'SSL'),
			'separator' => $this->language->get('text_separator')
		);

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_checkout_option'] = $this->language->get('text_checkout_option');
		$this->data['text_checkout_account'] = $this->language->get('text_checkout_account');
		$this->data['text_checkout_payment_address'] = $this->language->get('text_checkout_payment_address');
		$this->data['text_checkout_shipping_address'] = $this->language->get('text_checkout_shipping_address');
		$this->data['text_checkout_shipping_method'] = $this->language->get('text_checkout_shipping_method');
		$this->data['text_checkout_payment_method'] = $this->language->get('text_checkout_payment_method');		
		$this->data['text_checkout_confirm'] = $this->language->get('text_checkout_confirm');
		$this->data['text_modify'] = $this->language->get('text_modify');

		$this->data['logged'] = $this->customer->isLogged();
		$this->data['shipping_required'] = $this->cart->hasShipping();	

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/checkout.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/checkout/checkout.tpl';
		} else {
			$this->template = 'default/template/checkout/checkout.tpl';
		}

		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/content_top',
			'common/content_bottom',
			'common/footer',
			'common/header'	
		);

		if (isset($this->request->get['quickconfirm'])) {
			$this->data['quickconfirm'] = $this->request->get['quickconfirm'];
		}

		$this->response->setOutput($this->render());
	}

	public function country() {
		$json = array();

		$this->load->model('localisation/country');

		$country_info = $this->model_localisation_country->getCountry($this->request->get['country_id']);

		if ($country_info) {
			$this->load->model('localisation/zone');

			$json = array(
				'country_id'        => $country_info['country_id'],
				'name'              => $country_info['name'],
				'iso_code_2'        => $country_info['iso_code_2'],
				'iso_code_3'        => $country_info['iso_code_3'],
				'address_format'    => $country_info['address_format'],
				'postcode_required' => $country_info['postcode_required'],
				'zone'              => $this->model_localisation_zone->getZonesByCountryId($this->request->get['country_id']),
				'status'            => $country_info['status']		
			);
		}

		$this->response->setOutput(json_encode($json));
	}
}
?>