<?php echo $header; ?>
<div id="content">
<div class="breadcrumb">
  <?php foreach ($breadcrumbs as $breadcrumb) { ?>
  <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
  <?php } ?>
</div>
<?php if ($success) { ?>
<div class="success"><?php echo $success; ?></div>
<?php } ?>
<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<div class="box">
  <div class="heading">
    <h1><img src="view/image/copu.png" alt="" /> <?php echo $common_title; ?></h1>
    <div class="buttons"><a onclick="$('#form').attr('action', '<?php echo $action; ?>'); $('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a><a onclick="$('#form').attr('action', '<?php echo $action_exit; ?>'); $('#form').submit();" class="button"><span><?php echo $button_save_exit; ?></span></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
  </div>
  <div class="content">
    <div id="tabs" class="htabs">
      <a href="#tab-customer" onclick="return false;"><?php echo $tab_customer; ?></a>
      <a href="#tab-order" onclick="return false;"><?php echo $tab_order; ?></a>
      <a href="#tab-product" onclick="return false;"><?php echo $tab_product; ?></a>
      <a href="#tab-filetype" onclick="return false;"><?php echo $tab_filetype; ?></a>
    </div>
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
      <div id="tab-customer">
          <table class="form">
            <tr>
              <td><?php echo $entry_status; ?></td>
              <td><select name="copu_customer_status">
                  <option value="1"<?php if ($copu_customer_status) { ?> selected="selected"<?php } ?>><?php echo $text_enabled; ?></option>
                  <option value="0"<?php if (!$copu_customer_status) { ?> selected="selected"<?php } ?>><?php echo $text_disabled; ?></option>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_register; ?></td>
              <td>
                <input type="radio" id="customer_register1" name="copu_customer_register" value="1"<?php if ($copu_customer_register) { ?> checked="checked"<?php } ?> />
                <label for="customer_register1"><?php echo $text_yes; ?></label>
                <input type="radio" id="customer_register0" name="copu_customer_register" value="0"<?php if (!$copu_customer_register) { ?> checked="checked"<?php } ?> />
                <label for="customer_register0"><?php echo $text_no; ?></label>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_email_alert; ?></td>
              <td>
                <input type="radio" id="customer_email_alert1" name="copu_customer_email_alert" value="1"<?php if ($copu_customer_email_alert) { ?> checked="checked"<?php } ?> />
                <label for="customer_email_alert1"><?php echo $text_yes; ?></label>
                <input type="radio" id="customer_email_alert0" name="copu_customer_email_alert" value="0"<?php if (!$copu_customer_email_alert) { ?> checked="checked"<?php } ?> />
                <label for="customer_email_alert0"><?php echo $text_no; ?></label>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_drag_drop; ?></td>
              <td>
                <input type="radio" id="customer_drag_drop1" name="copu_customer_drag_drop" value="1"<?php if ($copu_customer_drag_drop) { ?> checked="checked"<?php } ?> />
                <label for="customer_drag_drop1"><?php echo $text_yes; ?></label>
                <input type="radio" id="customer_drag_drop0" name="copu_customer_drag_drop" value="0"<?php if (!$copu_customer_drag_drop) { ?> checked="checked"<?php } ?> />
                <label for="customer_drag_drop0"><?php echo $text_no; ?></label>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_multiple; ?></td>
              <td>
                <input type="radio" id="customer_multiple1" name="copu_customer_multiple" value="1"<?php if ($copu_customer_multiple) { ?> checked="checked"<?php } ?> />
                <label for="customer_multiple1"><?php echo $text_yes; ?></label>
                <input type="radio" id="customer_multiple0" name="copu_customer_multiple" value="0"<?php if (!$copu_customer_multiple) { ?> checked="checked"<?php } ?> />
                <label for="customer_multiple0"><?php echo $text_no; ?></label>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_limit; ?></td>
              <td><input type="text" name="copu_customer_limit" value="<?php echo $copu_customer_limit; ?>" size="3" />
                <?php if ($error_customer_limit) { ?>
                <span class="error"><?php echo $error_customer_limit; ?></div>
                <?php } ?>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_minimum; ?></td>
              <td><input type="text" name="copu_customer_minimum" value="<?php echo $copu_customer_minimum; ?>" size="3" />
                <?php if ($error_customer_minimum) { ?>
                <span class="error"><?php echo $error_customer_minimum; ?></div>
                <?php } ?>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_files_per_page; ?></td>
              <td><input type="text" name="copu_customer_files_per_page" value="<?php echo $copu_customer_files_per_page; ?>" size="3" />
                <?php if ($error_customer_files_per_page) { ?>
                <span class="error"><?php echo $error_customer_files_per_page; ?></div>
                <?php } ?>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_max_filesize; ?></td>
              <td><select name="copu_customer_max_filesize">
                  <?php foreach($filesizes as $kb => $filesize) { ?>
                  <option value="<?php echo $kb; ?>"<?php if(isset($copu_customer_max_filesize) && $copu_customer_max_filesize == $kb) { ?> selected="selected"<?php } ?>><?php echo $filesize; ?></option>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_max_dimension; ?></td>
              <td>
                <input type="text" name="copu_customer_max_dimension_w" value="<?php echo $copu_customer_max_dimension_w; ?>" size="3" />
                x
                <input type="text" name="copu_customer_max_dimension_h" value="<?php echo $copu_customer_max_dimension_h; ?>" size="3" />
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_image_channel; ?></td>
              <td><select name="copu_customer_image_channel">
                  <option value="0"<?php if(isset($copu_customer_image_channel) && $copu_customer_image_channel == 0) { ?> selected="selected"<?php } ?>><?php echo $text_any; ?></option>
                  <option value="3"<?php if(isset($copu_customer_image_channel) && $copu_customer_image_channel == 3) { ?> selected="selected"<?php } ?>><?php echo $text_rgb; ?></option>
                  <option value="4"<?php if(isset($copu_customer_image_channel) && $copu_customer_image_channel == 4) { ?> selected="selected"<?php } ?>><?php echo $text_cmyk; ?></option>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_max_filename_length; ?></td>
              <td><input type="text" name="copu_customer_max_filename_length" value="<?php echo $copu_customer_max_filename_length; ?>" size="3" />
                <?php if ($error_customer_max_filename_length) { ?>
                <span class="error"><?php echo $error_customer_max_filename_length; ?></div>
                <?php } ?>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_customer_file_location; ?></td>
              <td><input name="copu_customer_file_location" value="<?php echo $copu_customer_file_location; ?>" size="70" />
                <?php if ($error_customer_file_location) { ?>
                <span class="error"><?php echo $error_customer_file_location; ?></div>
                <?php } ?>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_customer_email_attachment; ?></td>
              <td>
                <input type="radio" id="customer_email_attachment1" name="copu_customer_email_attachment" value="1"<?php if ($copu_customer_email_attachment) { ?> checked="checked"<?php } ?> />
                <label for="customer_email_attachment1"><?php echo $text_yes; ?></label>
                <input type="radio" id="customer_email_attachment0" name="copu_customer_email_attachment" value="0"<?php if (!$copu_customer_email_attachment) { ?> checked="checked"<?php } ?> />
                <label for="customer_email_attachment0"><?php echo $text_no; ?></label>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_message; ?></td>
              <td>
                <div id="customer-languages" class="htabs">
                  <?php foreach ($languages as $language) { ?>
                    <a href="#customer-languages<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
                  <?php } ?>
                </div>
                <?php foreach ($languages as $language) { ?>
                <div id="customer-languages<?php echo $language['language_id']; ?>">
                <textarea name="copu_customer_message[<?php echo $language['language_id']; ?>][message]" id="customer_message<?php echo $language['language_id']; ?>"><?php echo isset($copu_customer_message[$language['language_id']]) ? $copu_customer_message[$language['language_id']]['message'] : ''; ?></textarea></div>
                <?php } ?>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_preview; ?></td>
              <td>
                <input type="radio" id="customer_preview1" name="copu_customer_preview" value="1"<?php if ($copu_customer_preview) { ?> checked="checked"<?php } ?> />
                <label for="customer_preview1"><?php echo $text_yes; ?></label>
                <input type="radio" id="customer_preview0" name="copu_customer_preview" value="0"<?php if (!$copu_customer_preview) { ?> checked="checked"<?php } ?> />
                <label for="customer_preview0"><?php echo $text_no; ?></label>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_preview_dimension; ?></td>
              <td>
                <input type="text" name="copu_customer_preview_dimension_w" value="<?php echo $copu_customer_preview_dimension_w; ?>" size="3" />
                x
                <input type="text" name="copu_customer_preview_dimension_h" value="<?php echo $copu_customer_preview_dimension_h; ?>" size="3" />
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_filetype; ?></td>
              <td><div id="customer-filetype" class="scrollbox" style="height: 200px;">
                <?php if($filetypes) { ?>
                  <?php $class = 'even'; ?>
                  <?php foreach ($filetypes as $filetype) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $class; ?>" id="customer-filetype<?php echo $filetype['filetype_id']; ?>">
                    <input type="checkbox" name="copu_customer_filetypes[]" value="<?php echo $filetype['filetype_id']; ?>"<?php if (!empty($copu_customer_filetypes) && in_array($filetype['filetype_id'], $copu_customer_filetypes)) { ?> checked="checked"<?php } ?> id="customer-filetype-cbk<?php echo $filetype['filetype_id']; ?>" />
                    <label for="customer-filetype-cbk<?php echo $filetype['filetype_id']; ?>"><?php echo $filetype['ext']; ?></label>
                  </div>
                  <?php } ?>
                <?php } ?>
                </div>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_login; ?></td>
              <td>
                <input type="radio" id="customer_login1" name="copu_customer_login" value="1" checked="checked" />
                <label for="customer_login1"><?php echo $text_yes; ?></label>
                <input type="radio" id="customer_login0" name="copu_customer_login" value="0" disabled="disabled" />
                <label for="customer_login0"><?php echo $text_no; ?></label>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_customer_group; ?></td>
              <td><div class="scrollbox">
                <?php $class = 'even'; ?>
                <?php foreach ($customer_groups as $customer_group) { ?>
                <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                <div class="<?php echo $class; ?>">
                  <input type="checkbox" name="copu_customer_customer_groups[]" value="<?php echo $customer_group['customer_group_id']; ?>"<?php if (!empty($copu_customer_customer_groups) && in_array($customer_group['customer_group_id'], $copu_customer_customer_groups)) { ?> checked="checked"<?php } ?> id="customer_customer_group<?php echo $customer_group['customer_group_id']; ?>" />
                  <label for="customer_customer_group<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></label>
                </div>
                <?php } ?>
              </div></td>
            </tr>
            <tr>
              <td><?php echo $entry_store; ?></td>
              <td><div class="scrollbox">
                <?php $class = 'even'; ?>
                <div class="<?php echo $class; ?>">
                  <input type="checkbox" name="copu_customer_stores[]" value="0"<?php if (!empty($copu_customer_stores) && in_array('0', $copu_customer_stores)) { ?> checked="checked"<?php } ?> id="customer_store0" />
                  <label for="customer_store0"><?php echo $text_default; ?></label>
                </div>
                <?php foreach ($stores as $store) { ?>
                <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                <div class="<?php echo $class; ?>">
                  <input type="checkbox" name="copu_customer_stores[]" value="<?php echo $store['store_id']; ?>"<?php if (!empty($copu_customer_stores) && in_array($store['store_id'], $copu_customer_stores)) { ?> checked="checked"<?php } ?> id="customer_store<?php echo $store['store_id']; ?>" />
                  <label for="customer_store<?php echo $store['store_id']; ?>"><?php echo $store['name']; ?></label>
                </div>
                <?php } ?>
              </div></td>
            </tr>
          </table>
      </div>
      <div id="tab-order">
          <table class="form">
            <tr>
              <td><?php echo $entry_status; ?></td>
              <td><select name="copu_order_status">
                  <option value="1"<?php if ($copu_order_status) { ?> selected="selected"<?php } ?>><?php echo $text_enabled; ?></option>
                  <option value="0"<?php if (!$copu_order_status) { ?> selected="selected"<?php } ?>><?php echo $text_disabled; ?></option>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_history_modify; ?></td>
              <td>
                <input type="radio" id="order-history-modify1" name="copu_order_history_modify" value="1"<?php if ($copu_order_history_modify) { ?> checked="checked"<?php } ?> />
                <label for="order-history-modify1"><?php echo $text_yes; ?></label>
                <input type="radio" id="order-history-modify0" name="copu_order_history_modify" value="0"<?php if (!$copu_order_history_modify) { ?> checked="checked"<?php } ?> />
                <label for="order-history-modify0"><?php echo $text_no; ?></label>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_history_modify_status; ?></td>
              <td>
                <select name="copu_order_history_modify_status">
                  <option value="0"<?php if ($copu_order_history_modify_status == 0) { ?> selected="selected"<?php } ?>><?php echo $text_none; ?></option>
                  <?php foreach ($order_statuses as $order_status) { ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>"<?php if ($order_status['order_status_id'] == $copu_order_history_modify_status) { ?> selected="selected"<?php } ?>><?php echo $order_status['name']; ?></option>
                  <?php } ?>
                </select>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_history_modify_email_alert; ?></td>
              <td>
                <input type="radio" id="order-history-modify-email-alert1" name="copu_order_history_modify_email_alert" value="1"<?php if ($copu_order_history_modify_email_alert) { ?> checked="checked"<?php } ?> />
                <label for="order-history-modify-email-alert1"><?php echo $text_yes; ?></label>
                <input type="radio" id="order-history-modify-email-alert0" name="copu_order_history_modify_email_alert" value="0"<?php if (!$copu_order_history_modify_email_alert) { ?> checked="checked"<?php } ?> />
                <label for="order-history-modify-email-alert0"><?php echo $text_no; ?></label>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_drag_drop; ?></td>
              <td>
                <input type="radio" id="order_drag_drop1" name="copu_order_drag_drop" value="1"<?php if ($copu_order_drag_drop) { ?> checked="checked"<?php } ?> />
                <label for="order_drag_drop1"><?php echo $text_yes; ?></label>
                <input type="radio" id="order_drag_drop0" name="copu_order_drag_drop" value="0"<?php if (!$copu_order_drag_drop) { ?> checked="checked"<?php } ?> />
                <label for="order_drag_drop0"><?php echo $text_no; ?></label>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_multiple; ?></td>
              <td>
                <input type="radio" id="order_multiple1" name="copu_order_multiple" value="1"<?php if ($copu_order_multiple) { ?> checked="checked"<?php } ?> />
                <label for="order_multiple1"><?php echo $text_yes; ?></label>
                <input type="radio" id="order_multiple0" name="copu_order_multiple" value="0"<?php if (!$copu_order_multiple) { ?> checked="checked"<?php } ?> />
                <label for="order_multiple0"><?php echo $text_no; ?></label>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_limit; ?></td>
              <td><input type="text" name="copu_order_limit" value="<?php echo $copu_order_limit; ?>" size="3" />
                <?php if ($error_order_limit) { ?>
                <span class="error"><?php echo $error_order_limit; ?></div>
                <?php } ?>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_minimum; ?></td>
              <td><input type="text" name="copu_order_minimum" value="<?php echo $copu_order_minimum; ?>" size="3" />
                <?php if ($error_order_minimum) { ?>
                <span class="error"><?php echo $error_order_minimum; ?></div>
                <?php } ?>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_max_filesize; ?></td>
              <td><select name="copu_order_max_filesize">
                  <?php foreach($filesizes as $kb => $filesize) { ?>
                  <option value="<?php echo $kb; ?>"<?php if(isset($copu_order_max_filesize) && $copu_order_max_filesize == $kb) { ?> selected="selected"<?php } ?>><?php echo $filesize; ?></option>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_max_dimension; ?></td>
              <td>
                <input type="text" name="copu_order_max_dimension_w" value="<?php echo $copu_order_max_dimension_w; ?>" size="3" />
                x
                <input type="text" name="copu_order_max_dimension_h" value="<?php echo $copu_order_max_dimension_h; ?>" size="3" />
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_image_channel; ?></td>
              <td><select name="copu_order_image_channel">
                  <option value="0"<?php if(isset($copu_order_image_channel) && $copu_order_image_channel == 0) { ?> selected="selected"<?php } ?>><?php echo $text_any; ?></option>
                  <option value="3"<?php if(isset($copu_order_image_channel) && $copu_order_image_channel == 3) { ?> selected="selected"<?php } ?>><?php echo $text_rgb; ?></option>
                  <option value="4"<?php if(isset($copu_order_image_channel) && $copu_order_image_channel == 4) { ?> selected="selected"<?php } ?>><?php echo $text_cmyk; ?></option>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_max_filename_length; ?></td>
              <td><input type="text" name="copu_order_max_filename_length" value="<?php echo $copu_order_max_filename_length; ?>" size="3" />
                <?php if ($error_order_max_filename_length) { ?>
                <span class="error"><?php echo $error_order_max_filename_length; ?></div>
                <?php } ?>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_order_file_location; ?></td>
              <td><input name="copu_order_file_location" value="<?php echo $copu_order_file_location; ?>" size="70" />
                <?php if ($error_order_file_location) { ?>
                <span class="error"><?php echo $error_order_file_location; ?></div>
                <?php } ?>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_order_email_attachment; ?></td>
              <td>
                <input type="radio" id="order_email_attachment1" name="copu_order_email_attachment" value="1"<?php if ($copu_order_email_attachment) { ?> checked="checked"<?php } ?> />
                <label for="order_email_attachment1"><?php echo $text_yes; ?></label>
                <input type="radio" id="order_email_attachment0" name="copu_order_email_attachment" value="0"<?php if (!$copu_order_email_attachment) { ?> checked="checked"<?php } ?> />
                <label for="order_email_attachment0"><?php echo $text_no; ?></label>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_message; ?></td>
              <td>
                <div id="order-languages" class="htabs">
                  <?php foreach ($languages as $language) { ?>
                    <a href="#order-languages<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
                  <?php } ?>
                </div>
                <?php foreach ($languages as $language) { ?>
                <div id="order-languages<?php echo $language['language_id']; ?>">
                <textarea name="copu_order_message[<?php echo $language['language_id']; ?>][message]" id="order_message<?php echo $language['language_id']; ?>"><?php echo isset($copu_order_message[$language['language_id']]) ? $copu_order_message[$language['language_id']]['message'] : ''; ?></textarea></div>
                <?php } ?>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_preview; ?></td>
              <td>
                <input type="radio" id="order_preview1" name="copu_order_preview" value="1"<?php if ($copu_order_preview) { ?> checked="checked"<?php } ?> />
                <label for="order_preview1"><?php echo $text_yes; ?></label>
                <input type="radio" id="order_preview0" name="copu_order_preview" value="0"<?php if (!$copu_order_preview) { ?> checked="checked"<?php } ?> />
                <label for="order_preview0"><?php echo $text_no; ?></label>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_preview_dimension; ?></td>
              <td>
                <input type="text" name="copu_order_preview_dimension_w" value="<?php echo $copu_order_preview_dimension_w; ?>" size="3" />
                x
                <input type="text" name="copu_order_preview_dimension_h" value="<?php echo $copu_order_preview_dimension_h; ?>" size="3" />
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_filetype; ?></td>
              <td><div id="order-filetype" class="scrollbox" style="height: 200px;">
                <?php if($filetypes) { ?>
                  <?php $class = 'even'; ?>
                  <?php foreach ($filetypes as $filetype) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $class; ?>" id="order-filetype<?php echo $filetype['filetype_id']; ?>">
                    <input type="checkbox" name="copu_order_filetypes[]" value="<?php echo $filetype['filetype_id']; ?>"<?php if (!empty($copu_order_filetypes) && in_array($filetype['filetype_id'], $copu_order_filetypes)) { ?> checked="checked"<?php } ?> id="order-filetype-cbk<?php echo $filetype['filetype_id']; ?>" />
                    <label for="order-filetype-cbk<?php echo $filetype['filetype_id']; ?>"><?php echo $filetype['ext']; ?></label>
                  </div>
                  <?php } ?>
                <?php } ?>
                </div>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_login; ?></td>
              <td>
                <input type="radio" id="order_login1" name="copu_order_login" value="1"<?php if ($copu_order_login) { ?> checked="checked"<?php } ?> />
                <label for="order_login1"><?php echo $text_yes; ?></label>
                <input type="radio" id="order_login0" name="copu_order_login" value="0"<?php if (!$copu_order_login) { ?> checked="checked"<?php } ?> />
                <label for="order_login0"><?php echo $text_no; ?></label>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_customer_group; ?></td>
              <td><div class="scrollbox">
                <?php $class = 'even'; ?>
                <?php foreach ($customer_groups as $customer_group) { ?>
                <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                <div class="<?php echo $class; ?>">
                  <input type="checkbox" name="copu_order_customer_groups[]" value="<?php echo $customer_group['customer_group_id']; ?>"<?php if (!empty($copu_order_customer_groups) && in_array($customer_group['customer_group_id'], $copu_order_customer_groups)) { ?> checked="checked"<?php } ?> id="order_customer_group<?php echo $customer_group['customer_group_id']; ?>" />
                  <label for="order_customer_group<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></label>
                </div>
                <?php } ?>
              </div></td>
            </tr>
            <tr>
              <td><?php echo $entry_store; ?></td>
              <td><div class="scrollbox">
                <?php $class = 'even'; ?>
                <div class="<?php echo $class; ?>">
                  <input type="checkbox" name="copu_order_stores[]" value="0"<?php if (!empty($copu_order_stores) && in_array('0', $copu_order_stores)) { ?> checked="checked"<?php } ?> id="order_store0" />
                  <label for="order_store0"><?php echo $text_default; ?></label>
                </div>
                <?php foreach ($stores as $store) { ?>
                <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                <div class="<?php echo $class; ?>">
                  <input type="checkbox" name="copu_order_stores[]" value="<?php echo $store['store_id']; ?>"<?php if (!empty($copu_order_stores) && in_array($store['store_id'], $copu_order_stores)) { ?> checked="checked"<?php } ?> id="order_store<?php echo $store['store_id']; ?>" />
                  <label for="order_store<?php echo $store['store_id']; ?>"><?php echo $store['name']; ?></label>
                </div>
                <?php } ?>
              </div></td>
            </tr>
          </table>
      </div>
      <div id="tab-product">
        <div id="vtabs" class="vtabs">
          <?php $copu_product_row = 1; ?>
          <?php foreach ($copu_products as $copu_product) { ?>
            <a href="#tab-copu-product<?php echo $copu_product_row; ?>" id="copu-product<?php echo $copu_product_row; ?>"><?php echo $tab_copu_product; ?> <?php echo $copu_product_row; ?>&nbsp;<img src="view/image/delete.png" alt="delete" onclick="$('.vtabs a:first').trigger('click'); <?php foreach ($languages as $language) { ?>CKEDITOR.instances.copu_product<?php echo $copu_product_row; ?>_message<?php echo $language['language_id']; ?>.destroy(); <?php } ?> $('#copu-product<?php echo $copu_product_row; ?>').remove(); $('#tab-copu-product<?php echo $copu_product_row; ?>').remove(); return false;" /></a>
            <?php $copu_product_row++; ?>
          <?php } ?>
          <span id="copu-product-add"><?php echo $button_add_copu_product; ?>&nbsp;<img src="view/image/add.png" alt="" onclick="addCopuProduct();" /></span>
        </div>
        <?php $copu_product_row = 1; ?>
        <?php foreach ($copu_products as $copu_product) { ?>
        <div id="tab-copu-product<?php echo $copu_product_row; ?>" class="vtabs-content">
          <input type="hidden" name="copu_products[<?php echo $copu_product_row; ?>][copu_product_id]" value="<?php echo $copu_product['copu_product_id']; ?>" />
          <table class="form">
            <tr>
              <td><?php echo $entry_status; ?></td>
              <td><select name="copu_products[<?php echo $copu_product_row; ?>][status]">
                  <option value="1"<?php if ($copu_product['status']) { ?> selected="selected"<?php } ?>><?php echo $text_enabled; ?></option>
                  <option value="0"<?php if (!$copu_product['status']) { ?> selected="selected"<?php } ?>><?php echo $text_disabled; ?></option>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_drag_drop; ?></td>
              <td>
                <input type="radio" id="copu-product<?php echo $copu_product_row; ?>-drag-drop1" name="copu_products[<?php echo $copu_product_row; ?>][drag_drop]" value="1"<?php if ($copu_product['drag_drop']) { ?> checked="checked"<?php } ?> />
                <label for="copu-product<?php echo $copu_product_row; ?>-drag-drop1"><?php echo $text_yes; ?></label>
                <input type="radio" id="copu-product<?php echo $copu_product_row; ?>-drag-drop0" name="copu_products[<?php echo $copu_product_row; ?>][drag_drop]" value="0"<?php if (!$copu_product['drag_drop']) { ?> checked="checked"<?php } ?> />
                <label for="copu-product<?php echo $copu_product_row; ?>-drag-drop0"><?php echo $text_no; ?></label>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_multiple; ?></td>
              <td>
                <input type="radio" id="copu-product<?php echo $copu_product_row; ?>-multiple1" name="copu_products[<?php echo $copu_product_row; ?>][multiple]" value="1"<?php if ($copu_product['multiple']) { ?> checked="checked"<?php } ?> />
                <label for="copu-product<?php echo $copu_product_row; ?>-multiple1"><?php echo $text_yes; ?></label>
                <input type="radio" id="copu-product<?php echo $copu_product_row; ?>-multiple0" name="copu_products[<?php echo $copu_product_row; ?>][multiple]" value="0"<?php if (!$copu_product['multiple']) { ?> checked="checked"<?php } ?> />
                <label for="copu-product<?php echo $copu_product_row; ?>-multiple0"><?php echo $text_no; ?></label>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_limit; ?></td>
              <td><input type="text" name="copu_products[<?php echo $copu_product_row; ?>][limit]" value="<?php echo $copu_product['limit']; ?>" size="3" />
                <?php if ($error_copu_products && isset($error_copu_products[$copu_product['copu_product_id']]['limit'])) { ?>
                <span class="error"><?php echo $error_copu_products[$copu_product['copu_product_id']]['limit']; ?></span>
                <?php } ?>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_minimum; ?></td>
              <td><input type="text" name="copu_products[<?php echo $copu_product_row; ?>][minimum]" value="<?php echo $copu_product['minimum']; ?>" size="3" />
                <?php if ($error_copu_products && isset($error_copu_products[$copu_product['copu_product_id']]['minimum'])) { ?>
                <span class="error"><?php echo $error_copu_products[$copu_product['copu_product_id']]['minimum']; ?></span>
                <?php } ?>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_force_qty; ?></td>
              <td>
                <input type="radio" id="copu-product<?php echo $copu_product_row; ?>_force_qty1" name="copu_products[<?php echo $copu_product_row; ?>][force_qty]" value="1"<?php if ($copu_product['force_qty']) { ?> checked="checked"<?php } ?> />
                <label for="copu-product<?php echo $copu_product_row; ?>_force_qty1"><?php echo $text_yes; ?></label>
                <input type="radio" id="copu-product<?php echo $copu_product_row; ?>_force_qty0" name="copu_products[<?php echo $copu_product_row; ?>][force_qty]" value="0"<?php if (!$copu_product['force_qty']) { ?> checked="checked"<?php } ?> />
                <label for="copu-product<?php echo $copu_product_row; ?>_force_qty0"><?php echo $text_no; ?></label>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_max_filesize; ?></td>
              <td><select name="copu_products[<?php echo $copu_product_row; ?>][max_filesize]">
                  <?php foreach($filesizes as $kb => $filesize) { ?>
                  <option value="<?php echo $kb; ?>"<?php if(isset($copu_product['max_filesize']) && $copu_product['max_filesize'] == $kb) { ?> selected="selected"<?php } ?>><?php echo $filesize; ?></option>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_max_dimension; ?></td>
              <td>
                <input type="text" name="copu_products[<?php echo $copu_product_row; ?>][max_dimension_w]" value="<?php echo $copu_product['max_dimension_w']; ?>" size="3" />
                x
                <input type="text" name="copu_products[<?php echo $copu_product_row; ?>][max_dimension_h]" value="<?php echo $copu_product['max_dimension_h']; ?>" size="3" />
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_image_channel; ?></td>
              <td><select name="copu_products[<?php echo $copu_product_row; ?>][image_channel]">
                  <option value="0"<?php if(isset($copu_product['image_channel']) && $copu_product['image_channel'] == 0) { ?> selected="selected"<?php } ?>><?php echo $text_any; ?></option>
                  <option value="3"<?php if(isset($copu_product['image_channel']) && $copu_product['image_channel'] == 3) { ?> selected="selected"<?php } ?>><?php echo $text_rgb; ?></option>
                  <option value="4"<?php if(isset($copu_product['image_channel']) && $copu_product['image_channel'] == 4) { ?> selected="selected"<?php } ?>><?php echo $text_cmyk; ?></option>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_max_filename_length; ?></td>
              <td><input name="copu_products[<?php echo $copu_product_row; ?>][max_filename_length]" value="<?php echo $copu_product['max_filename_length']; ?>" size="3" />
                <?php if ($error_copu_products && isset($error_copu_products[$copu_product['copu_product_id']]['max_filename_length'])) { ?>
                <span class="error"><?php echo $error_copu_products[$copu_product['copu_product_id']]['max_filename_length']; ?></span>
                <?php } ?>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_product_file_location; ?></td>
              <td><input name="copu_products[<?php echo $copu_product_row; ?>][file_location]" value="<?php echo $copu_product['file_location']; ?>" size="70" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_product_email_attachment; ?></td>
              <td>
                <input type="radio" id="copu-product<?php echo $copu_product_row; ?>_email_attachment1" name="copu_products[<?php echo $copu_product_row; ?>][email_attachment]" value="1"<?php if ($copu_product['email_attachment']) { ?> checked="checked"<?php } ?> />
                <label for="copu-product<?php echo $copu_product_row; ?>_email_attachment1"><?php echo $text_yes; ?></label>
                <input type="radio" id="copu-product<?php echo $copu_product_row; ?>_email_attachment0" name="copu_products[<?php echo $copu_product_row; ?>][email_attachment]" value="0"<?php if (!$copu_product['email_attachment']) { ?> checked="checked"<?php } ?> />
                <label for="copu-product<?php echo $copu_product_row; ?>_email_attachment0"><?php echo $text_no; ?></label>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_message; ?></td>
              <td>
                <div id="copu-product<?php echo $copu_product_row; ?>-languages" class="htabs">
                  <?php foreach ($languages as $language) { ?>
                    <a href="#copu-product<?php echo $copu_product_row; ?>-languages<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
                  <?php } ?>
                </div>
                <?php foreach ($languages as $language) { ?>
                <div id="copu-product<?php echo $copu_product_row; ?>-languages<?php echo $language['language_id']; ?>">
                <textarea name="copu_products[<?php echo $copu_product_row; ?>][message][<?php echo $language['language_id']; ?>][message]" id="copu_product<?php echo $copu_product_row; ?>_message<?php echo $language['language_id']; ?>"><?php echo isset($copu_product['message'][$language['language_id']]) ? $copu_product['message'][$language['language_id']]['message'] : ''; ?></textarea></div>
                <?php } ?>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_preview; ?></td>
              <td>
                <input type="radio" id="copu-product<?php echo $copu_product_row; ?>_preview1" name="copu_products[<?php echo $copu_product_row; ?>][preview]" value="1"<?php if ($copu_product['preview']) { ?> checked="checked"<?php } ?> />
                <label for="copu-product<?php echo $copu_product_row; ?>_preview1"><?php echo $text_yes; ?></label>
                <input type="radio" id="copu-product<?php echo $copu_product_row; ?>_preview0" name="copu_products[<?php echo $copu_product_row; ?>][preview]" value="0"<?php if (!$copu_product['preview']) { ?> checked="checked"<?php } ?> />
                <label for="copu-product<?php echo $copu_product_row; ?>_preview0"><?php echo $text_no; ?></label>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_preview_dimension; ?></td>
              <td>
                <input type="text" name="copu_products[<?php echo $copu_product_row; ?>][preview_dimension_w]" value="<?php echo $copu_product['preview_dimension_w']; ?>" size="3" />
                x
                <input type="text" name="copu_products[<?php echo $copu_product_row; ?>][preview_dimension_h]" value="<?php echo $copu_product['preview_dimension_h']; ?>" size="3" />
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_replace; ?></td>
              <td>
                <input type="radio" id="copu-product<?php echo $copu_product_row; ?>_replace1" name="copu_products[<?php echo $copu_product_row; ?>][replace]" value="1"<?php if ($copu_product['replace']) { ?> checked="checked"<?php } ?> />
                <label for="copu-product<?php echo $copu_product_row; ?>_replace1"><?php echo $text_yes; ?></label>
                <input type="radio" id="copu-product<?php echo $copu_product_row; ?>_replace0" name="copu_products[<?php echo $copu_product_row; ?>][replace]" value="0"<?php if (!$copu_product['replace']) { ?> checked="checked"<?php } ?> />
                <label for="copu-product<?php echo $copu_product_row; ?>_replace0"><?php echo $text_no; ?></label>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_filetype; ?></td>
              <td><div id="copu-product<?php echo $copu_product_row; ?>-filetype" class="scrollbox" style="height: 200px;">
                <?php if($filetypes) { ?>
                  <?php $class = 'even'; ?>
                  <?php foreach ($filetypes as $filetype) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $class; ?>" id="copu-product<?php echo $copu_product_row; ?>-filetype<?php echo $filetype['filetype_id']; ?>">
                    <input type="checkbox" name="copu_products[<?php echo $copu_product_row; ?>][filetypes][]" value="<?php echo $filetype['filetype_id']; ?>"<?php if (!empty($copu_product['filetypes']) && in_array($filetype['filetype_id'], $copu_product['filetypes'])) { ?> checked="checked"<?php } ?> id="copu-product<?php echo $copu_product_row; ?>-filetype-cbk<?php echo $filetype['filetype_id']; ?>" />
                    <label for="copu-product<?php echo $copu_product_row; ?>-filetype-cbk<?php echo $filetype['filetype_id']; ?>"><?php echo $filetype['ext']; ?></label>
                  </div>
                  <?php } ?>
                <?php } ?>
                </div>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_upload_option; ?></td>
              <td><div class="scrollbox">
                <?php $class = 'even'; ?>
                <?php foreach ($copu_options as $copu_option) { ?>
                <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                <div class="<?php echo $class; ?>">
                  <input type="checkbox" name="copu_products[<?php echo $copu_product_row; ?>][options][]" value="<?php echo $copu_option['option_id']; ?>"<?php if (!empty($copu_product['options']) && in_array($copu_option['option_id'], $copu_product['options'])) { ?> checked="checked"<?php } ?> id="copu-product<?php echo $copu_product_row; ?>_option<?php echo $copu_option['option_id']; ?>" />
                  <label for="copu-product<?php echo $copu_product_row; ?>_option<?php echo $copu_option['option_id']; ?>"><?php echo $copu_option['name']; ?></label>
                </div>
                <?php } ?>
              </div></td>
            </tr>
            <tr>
              <td><?php echo $entry_login; ?></td>
              <td>
                <input type="radio" id="copu-product<?php echo $copu_product_row; ?>_login1" name="copu_products[<?php echo $copu_product_row; ?>][login]" value="1"<?php if ($copu_product['login']) { ?> checked="checked"<?php } ?> />
                <label for="copu-product<?php echo $copu_product_row; ?>_login1"><?php echo $text_yes; ?></label>
                <input type="radio" id="copu-product<?php echo $copu_product_row; ?>_login0" name="copu_products[<?php echo $copu_product_row; ?>][login]" value="0"<?php if (!$copu_product['login']) { ?> checked="checked"<?php } ?> />
                <label for="copu-product<?php echo $copu_product_row; ?>_login0"><?php echo $text_no; ?></label>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_customer_group; ?></td>
              <td><div class="scrollbox">
                <?php $class = 'even'; ?>
                <?php foreach ($customer_groups as $customer_group) { ?>
                <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                <div class="<?php echo $class; ?>">
                  <input type="checkbox" name="copu_products[<?php echo $copu_product_row; ?>][customer_groups][]" value="<?php echo $customer_group['customer_group_id']; ?>"<?php if (!empty($copu_product['customer_groups']) && in_array($customer_group['customer_group_id'], $copu_product['customer_groups'])) { ?> checked="checked"<?php } ?> id="copu-product<?php echo $copu_product_row; ?>_customer_group<?php echo $customer_group['customer_group_id']; ?>" />
                  <label for="copu-product<?php echo $copu_product_row; ?>_customer_group<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></label>
                </div>
                <?php } ?>
              </div></td>
            </tr>
            <tr>
              <td><?php echo $entry_store; ?></td>
              <td><div class="scrollbox">
                <?php $class = 'even'; ?>
                <div class="<?php echo $class; ?>">
                  <input type="checkbox" name="copu_products[<?php echo $copu_product_row; ?>][stores][]" value="0"<?php if (!empty($copu_product['stores']) && in_array('0', $copu_product['stores'])) { ?> checked="checked"<?php } ?> id="copu-product<?php echo $copu_product_row; ?>_store0" />
                  <label for="copu-product<?php echo $copu_product_row; ?>_store0"><?php echo $text_default; ?></label>
                </div>
                <?php foreach ($stores as $store) { ?>
                <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                <div class="<?php echo $class; ?>">
                  <input type="checkbox" name="copu_products[<?php echo $copu_product_row; ?>][stores][]" value="<?php echo $store['store_id']; ?>"<?php if (!empty($copu_product['stores']) && in_array($store['store_id'], $copu_product['stores'])) { ?> checked="checked"<?php } ?> id="copu-product<?php echo $copu_product_row; ?>_store<?php echo $store['store_id']; ?>" />
                  <label for="copu-product<?php echo $copu_product_row; ?>_store<?php echo $store['store_id']; ?>"><?php echo $store['name']; ?></label>
                </div>
                <?php } ?>
              </div></td>
            </tr>
          </table>
        </div>
        <?php $copu_product_row++; ?>
        <?php } ?>
      </div>
      <div id="tab-filetype">
        <table class="list" id="filetype-tbl">
          <thead>
            <tr>
              <td class="left"><?php echo $column_ext; ?></td>
              <td class="left"><?php echo $column_mime; ?></td>
              <td class="right"><?php echo $column_action; ?></td>
            </tr>
          </thead>
          <tbody>
            <?php if ($filetypes) { ?>
            <?php foreach ($filetypes as $filetype) { ?>
            <tr id="filetype<?php echo $filetype['filetype_id']; ?>">
              <td class="left ext"><?php echo $filetype['ext']; ?></td>
              <td class="left"><?php echo $filetype['mime']; ?></td>
              <td class="right">[ <a href="<?php echo $filetype['delete']; ?>" class="delete-filetype-btn" id="<?php echo $filetype['filetype_id']; ?>"><?php echo $text_delete; ?></a> ]</td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="3"><?php echo $text_no_results; ?></td>
            </tr>
            <?php } ?>
            <tr>
              <td class="left"><?php echo $entry_ext; ?><input type="text" size="3" id="new-ext" value="" /></td>
              <td class="left"><?php echo $entry_mime; ?><input type="text" size="130" id="new-mime" value="" /></td>
              <td class="right"><a class="button" id="add-filetype-btn"><span><?php echo $button_add_filetype; ?></span></a></td>
            </tr>
          </tbody>
        </table>
      </div>
    </form>
    <div style="clear:both;font-size:11px;color:#666;"><?php echo $myoc_copyright; ?></div>
  </div>
</div>
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script> 
<script type="text/javascript"><!--
$('#tabs a').tabs();
$('#vtabs a').tabs();
$('#customer-languages a').tabs();
$('#order-languages a').tabs();
<?php $copu_product_row = 1; ?>
<?php foreach ($copu_products as $copu_product) { ?>
$('#copu-product<?php echo $copu_product_row; ?>-languages a').tabs();
<?php $copu_product_row++; ?>
<?php } ?>

<?php foreach ($languages as $language) { ?>
CKEDITOR.replace('customer_message<?php echo $language['language_id']; ?>', {
  filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
  filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
  filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
  filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
  filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
  filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
});
CKEDITOR.replace('order_message<?php echo $language['language_id']; ?>', {
  filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
  filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
  filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
  filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
  filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
  filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
});
<?php $copu_product_row = 1; ?>
<?php foreach ($copu_products as $copu_product) { ?>
CKEDITOR.replace('copu_product<?php echo $copu_product_row; ?>_message<?php echo $language['language_id']; ?>', {
  filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
  filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
  filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
  filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
  filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
  filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
});
<?php $copu_product_row++; ?>
<?php } ?>
<?php } ?>

var filetypes = new Array();
<?php if($filetypes) { ?>
  <?php $i = 0; ?>
  <?php foreach($filetypes as $filetype) { ?>
  filetypes[<?php echo $i; ?>] = {'filetype_id':<?php echo $filetype['filetype_id']; ?>, 'ext':'<?php echo $filetype['ext']; ?>'};
    <?php $i++; ?>
  <?php } ?>
<?php } ?>

<?php $total_copu_product_row = count($copu_products); ?>
var copu_product_row = <?php echo ($total_copu_product_row + 1); ?>;

$('.delete-filetype-btn').live('click', function() {
  var _thisBtn = $(this);
  var _filetype_id = _thisBtn.attr('id');
  var _url = _thisBtn.attr('href');
  if(confirm('<?php echo $text_confirm_delete; ?> \'' + $('#filetype' + _filetype_id + ' td.ext').html() + '\'?'))
  {
    $.ajax({
      url: _url,
      dataType: 'json',
      beforeSend: function() {
        _thisBtn.before('<span class="wait"><img src="view/image/loading.gif" alt="" />&nbsp;&nbsp;</span>');
        $('.warning').remove();
      },
      complete: function() {
        $('.wait').remove();
      },      
      success: function(json) {
        if(json['success']) {
          if(filetypes.length > 0) {
            for(var i = 0; i < filetypes.length; i++) {
              if(filetypes.hasOwnProperty(i) && filetypes[i].filetype_id == _filetype_id) {
                delete filetypes[i];
                break;
              }
            }
          }
          $('#filetype' + _filetype_id).fadeOut(function() { $(this).remove(); });
          $('#customer-filetype' + _filetype_id).remove();
          $('#customer-filetype div:odd').attr('class', 'odd');
          $('#customer-filetype div:even').attr('class', 'even');
          $('#order-filetype' + _filetype_id).remove();
          $('#order-filetype div:odd').attr('class', 'odd');
          $('#order-filetype div:even').attr('class', 'even');
          for(var i = 1; i < copu_product_row; i++) {
            $('#copu-product' + i + '-filetype' + _filetype_id).remove();
            $('#copu-product' + i + '-filetype div:odd').attr('class', 'odd');
            $('#copu-product' + i + '-filetype div:even').attr('class', 'even');
          }
        }
        if(json['error']) {
          $('.box').before('<div class="warning" style="display: none;">' + json['error'] + '</div>');
          $('.warning').fadeIn('slow');
        }
      },
      error: function(xhr, ajaxOptions, thrownError) {
        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
      }
    });
  }
  return false;
});
$('#add-filetype-btn').click(function() {
  _thisBtn = $(this);
  var ext = $("#new-ext").val().replace(/ /g, '');
  var mime = $("#new-mime").val().replace(/ /g, '');
  if(ext == "") {
    return false;
  } else {
    $.ajax({
      url: 'index.php?route=module/myoccopu/insert&token=<?php echo $token; ?>&ext=' + ext + '&mime=' + mime,
      dataType: 'json',
      beforeSend: function() {
        _thisBtn.before('<span class="wait"><img src="view/image/loading.gif" alt="" />&nbsp;&nbsp;</span>');
        $('.warning').remove();
      },
      complete: function() {
        $('.wait').remove();
      },      
      success: function(json) {
        if(json['success']) {
          filetypes.push({'filetype_id':json['filetype']['filetype_id'], 'ext':json['filetype']['ext']});
          var newFiletypeRow = '<tr id="filetype' + json['filetype']['filetype_id'] + '"><td class="left ext">' + json['filetype']['ext'] + '</td><td class="left">' + json['filetype']['mime'] + '</td><td class="right">[ <a href="index.php?route=module/myoccopu/delete&filetype_id=' + json['filetype']['filetype_id'] + '&token=<?php echo $token; ?>" class="delete-filetype-btn" id="' + json['filetype']['filetype_id'] + '"><?php echo $text_delete; ?></a> ]</td></tr>';
          $('#filetype-tbl tbody > tr:last').before(newFiletypeRow);
          $('#customer-filetype').append('<div class="" id="customer-filetype' + json['filetype']['filetype_id'] + '"><input type="checkbox" name="copu_customer_filetypes[]" value="' + json['filetype']['filetype_id'] + '" id="customer-filetype-cbk' + json['filetype']['filetype_id'] + '" /> <label for="customer-filetype-cbk' + json['filetype']['filetype_id'] + '">' + json['filetype']['ext'] + '</lable></div>');
          $('#customer-filetype div:odd').attr('class', 'odd');
          $('#customer-filetype div:even').attr('class', 'even');
          $('#order-filetype').append('<div class="" id="order-filetype' + json['filetype']['filetype_id'] + '"><input type="checkbox" name="copu_order_filetypes[]" value="' + json['filetype']['filetype_id'] + '" id="order-filetype-cbk' + json['filetype']['filetype_id'] + '" /> <label for="order-filetype-cbk' + json['filetype']['filetype_id'] + '">' + json['filetype']['ext'] + '</label></div>');
          $('#order-filetype div:odd').attr('class', 'odd');
          $('#order-filetype div:even').attr('class', 'even');
          for(var i = 1; i < copu_product_row; i++) {
            $('#copu-product' + i + '-filetype').append('<div class="" id="copu-product' + i + '-filetype' + json['filetype']['filetype_id'] + '"><input type="checkbox" name="copu_products[' + i + '][filetypes][]" value="' + json['filetype']['filetype_id'] + '" id="copu-product' + i + '-filetype-cbk' + json['filetype']['filetype_id'] + '" /> <label for="copu-product' + i + '-filetype-cbk' + json['filetype']['filetype_id'] + '">' + json['filetype']['ext'] + '</label></div>');
            $('#copu-product' + i + '-filetype div:odd').attr('class', 'odd');
            $('#copu-product' + i + '-filetype div:even').attr('class', 'even');
          }
        }
        if(json['error']) {
          $('.box').before('<div class="warning" style="display: none;">' + json['error'] + '</div>');
          $('.warning').fadeIn('slow');
        }
      },
      error: function(xhr, ajaxOptions, thrownError) {
        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
      }
    });
  }
});

var new_copu_product_id = <?php echo $next_copu_product_id; ?>;
function addCopuProduct() {
  html  = '<div id="tab-copu-product' + copu_product_row + '" class="vtabs-content">';
  html += '  <input type="hidden" name="copu_products[' + copu_product_row + '][copu_product_id]" value="' + new_copu_product_id + '" />';
  html += '    <table class="form">';
  html += '      <tr>';
  html += '        <td><?php echo $entry_status; ?></td>';
  html += '        <td><select name="copu_products[' + copu_product_row + '][status]">';
  html += '            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
  html += '            <option value="0"><?php echo $text_disabled; ?></option>';
  html += '          </select></td>';
  html += '      </tr>';
  html += '      <tr>';
  html += '        <td><?php echo $entry_drag_drop; ?></td>';
  html += '        <td>';
  html += '          <input type="radio" id="copu-product' + copu_product_row + '-drag-drop1" name="copu_products[' + copu_product_row + '][drag_drop]" value="1" checked="checked" />';
  html += '          <label for="copu-product' + copu_product_row + '-drag-drop1"><?php echo $text_yes; ?></label>';
  html += '          <input type="radio" id="copu-product' + copu_product_row + '-drag-drop0" name="copu_products[' + copu_product_row + '][drag_drop]" value="0" />';
  html += '          <label for="copu-product' + copu_product_row + '-drag-drop0"><?php echo $text_no; ?></label>';
  html += '        </td>';
  html += '      </tr>';
  html += '      <tr>';
  html += '        <td><?php echo $entry_multiple; ?></td>';
  html += '        <td>';
  html += '          <input type="radio" id="copu-product' + copu_product_row + '-multiple1" name="copu_products[' + copu_product_row + '][multiple]" value="1" checked="checked" />';
  html += '          <label for="copu-product' + copu_product_row + '-multiple1"><?php echo $text_yes; ?></label>';
  html += '          <input type="radio" id="copu-product' + copu_product_row + '-multiple0" name="copu_products[' + copu_product_row + '][multiple]" value="0" />';
  html += '          <label for="copu-product' + copu_product_row + '-multiple0"><?php echo $text_no; ?></label>';
  html += '        </td>';
  html += '      </tr>';
  html += '      <tr>';
  html += '        <td><?php echo $entry_limit; ?></td>';
  html += '        <td><input type="text" name="copu_products[' + copu_product_row + '][limit]" value="1" size="3" />';
  html += '        </td>';
  html += '      </tr>';
  html += '      <tr>';
  html += '        <td><?php echo $entry_minimum; ?></td>';
  html += '        <td><input type="text" name="copu_products[' + copu_product_row + '][minimum]" value="1" size="3" />';
  html += '        </td>';
  html += '      </tr>';
  html += '      <tr>';
  html += '        <td><?php echo $entry_force_qty; ?></td>';
  html += '        <td>';
  html += '          <input type="radio" id="copu-product' + copu_product_row + '_force_qty1" name="copu_products[' + copu_product_row + '][force_qty]" value="1" />';
  html += '          <label for="copu-product' + copu_product_row + '_force_qty1"><?php echo $text_yes; ?></label>';
  html += '          <input type="radio" id="copu-product' + copu_product_row + '_force_qty0" name="copu_products[' + copu_product_row + '][force_qty]" value="0" checked="checked" />';
  html += '          <label for="copu-product' + copu_product_row + '_force_qty0"><?php echo $text_no; ?></label>';
  html += '        </td>';
  html += '      </tr>';
  html += '      <tr>';
  html += '        <td><?php echo $entry_max_filesize; ?></td>';
  html += '        <td><select name="copu_products[' + copu_product_row + '][max_filesize]">';
  <?php foreach($filesizes as $kb => $filesize) { ?>
  html += '            <option value="<?php echo $kb; ?>"<?php if($kb == 5242) { ?> selected="selected"<?php } ?>><?php echo $filesize; ?></option>';
  <?php } ?>
  html += '          </select></td>';
  html += '      </tr>';
  html += '      <tr>';
  html += '        <td><?php echo $entry_max_dimension; ?></td>';
  html += '        <td>';
  html += '          <input type="text" name="copu_products[' + copu_product_row + '][max_dimension_w]" value="0" size="3" />';
  html += '          x';
  html += '          <input type="text" name="copu_products[' + copu_product_row + '][max_dimension_h]" value="0" size="3" />';
  html += '        </td>';
  html += '      </tr>';
  html += '      <tr>';
  html += '        <td><?php echo $entry_image_channel; ?></td>';
  html += '        <td><select name="copu_products[' + copu_product_row + '][image_channel]">';
  html += '            <option value="0" selected="selected"><?php echo $text_any; ?></option>';
  html += '            <option value="3"><?php echo $text_rgb; ?></option>';
  html += '            <option value="4"><?php echo $text_cmyk; ?></option>';
  html += '          </select></td>';
  html += '      </tr>';
  html += '        <tr>';
  html += '          <td><?php echo $entry_max_filename_length; ?></td>';
  html += '          <td><input name="copu_products[' + copu_product_row + '][max_filename_length]" value="20" size="3" />';
  html += '          </td>';
  html += '        </tr>';
  html += '        <tr>';
  html += '          <td><?php echo $entry_product_file_location; ?></td>';
  html += '          <td><input name="copu_products[' + copu_product_row + '][file_location]" value="upload" size="70" /></td>';
  html += '        </tr>';
  html += '        <tr>';
  html += '          <td><?php echo $entry_product_email_attachment; ?></td>';
  html += '          <td>';
  html += '            <input type="radio" id="copu-product' + copu_product_row + '_email_attachment1" name="copu_products[' + copu_product_row + '][email_attachment]" value="1" />';
  html += '            <label for="copu-product' + copu_product_row + '_email_attachment1"><?php echo $text_yes; ?></label>';
  html += '            <input type="radio" id="copu-product' + copu_product_row + '_email_attachment0" name="copu_products[' + copu_product_row + '][email_attachment]" value="0" checked="checked" />';
  html += '            <label for="copu-product' + copu_product_row + '_email_attachment0"><?php echo $text_no; ?></label>';
  html += '          </td>';
  html += '        </tr>';
  html += '        <tr>';
  html += '          <td><?php echo $entry_message; ?></td>';
  html += '          <td>';
  html += '            <div id="copu-product' + copu_product_row + '-languages" class="htabs">';
  <?php foreach ($languages as $language) { ?>
  html += '              <a href="#copu-product' + copu_product_row + '-languages<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo addslashes($language['name']); ?>" /> <?php echo addslashes($language['name']); ?></a>';
  <?php } ?>
  html += '            </div>';
  <?php foreach ($languages as $language) { ?>
  html += '            <div id="copu-product' + copu_product_row + '-languages<?php echo $language['language_id']; ?>">';
  html += '              <textarea name="copu_products[' + copu_product_row + '][message][<?php echo $language['language_id']; ?>][message]" id="copu_product' + copu_product_row + '_message<?php echo $language['language_id']; ?>"></textarea></div>';
  <?php } ?>
  html += '          </td>';
  html += '        </tr>';
  html += '        <tr>';
  html += '          <td><?php echo $entry_preview; ?></td>';
  html += '          <td>';
  html += '            <input type="radio" id="copu-product' + copu_product_row + '_preview1" name="copu_products[' + copu_product_row + '][preview]" value="1" checked="checked" />';
  html += '            <label for="copu-product' + copu_product_row + '_preview1"><?php echo $text_yes; ?></label>';
  html += '            <input type="radio" id="copu-product' + copu_product_row + '_preview0" name="copu_products[' + copu_product_row + '][preview]" value="0" />';
  html += '            <label for="copu-product' + copu_product_row + '_preview0"><?php echo $text_no; ?></label>';
  html += '          </td>';
  html += '        </tr>';
  html += '        <tr>';
  html += '          <td><?php echo $entry_preview_dimension; ?></td>';
  html += '          <td>';
  html += '            <input type="text" name="copu_products[' + copu_product_row + '][preview_dimension_w]" value="80" size="3" />';
  html += '            x';
  html += '            <input type="text" name="copu_products[' + copu_product_row + '][preview_dimension_h]" value="80" size="3" />';
  html += '          </td>';
  html += '        </tr>';
  html += '        <tr>';
  html += '          <td><?php echo $entry_replace; ?></td>';
  html += '          <td>';
  html += '            <input type="radio" id="copu-product' + copu_product_row + '_replace1" name="copu_products[' + copu_product_row + '][replace]" value="1" />';
  html += '            <label for="copu-product' + copu_product_row + '_replace1"><?php echo $text_yes; ?></label>';
  html += '            <input type="radio" id="copu-product' + copu_product_row + '_replace0" name="copu_products[' + copu_product_row + '][replace]" value="0" checked="checked" />';
  html += '            <label for="copu-product' + copu_product_row + '_replace0"><?php echo $text_no; ?></label>';
  html += '          </td>';
  html += '        </tr>';
  html += '        <tr>';
  html += '          <td><?php echo $entry_filetype; ?></td>';
  html += '          <td><div id="copu-product' + copu_product_row + '-filetype" class="scrollbox" style="height: 200px;">';
  if(filetypes.length > 0) {
    var _class = 'even';
    for(var i = 0; i < filetypes.length; i++) {
      if(filetypes.hasOwnProperty(i)) {
        _class = (_class == 'even' ? 'odd' : 'even');
        var filetype_id = filetypes[i].filetype_id;
        var ext = filetypes[i].ext;
        html += '      <div class="' + _class + '" id="copu-product' + copu_product_row + '-filetype' + filetype_id + '">';
        html += '        <input type="checkbox" name="copu_products[' + copu_product_row + '][filetypes][]" value="' + filetype_id + '" id="copu-product' + copu_product_row + '-filetype-cbk' + filetype_id + '" />';
        html += '        <label for="copu-product' + copu_product_row + '-filetype-cbk' + filetype_id + '">' + ext + '</label>';
        html += '      </div>';
      }
    }
  }
  html += '            </div>';
  html += '          </td>';
  html += '        </tr>';
  html += '        <tr>';
  html += '          <td><?php echo $entry_upload_option; ?></td>';
  html += '          <td><div class="scrollbox">';
  <?php $class = 'even'; ?>
  <?php foreach ($copu_options as $copu_option) { ?>
  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
  html += '              <div class="<?php echo $class; ?>">';
  html += '                <input type="checkbox" name="copu_products[' + copu_product_row + '][options][]" value="<?php echo $copu_option['option_id']; ?>" id="copu-product' + copu_product_row + '_option<?php echo $copu_option['option_id']; ?>" />';
  html += '                <label for="copu-product' + copu_product_row + '_option<?php echo $copu_option['option_id']; ?>"><?php echo addslashes($copu_option['name']); ?></label>';
  html += '              </div>';
  <?php } ?>
  html += '            </div></td>';
  html += '        </tr>';
  html += '        <tr>';
  html += '          <td><?php echo $entry_login; ?></td>';
  html += '          <td>';
  html += '            <input type="radio" id="copu-product' + copu_product_row + '_login1" name="copu_products[' + copu_product_row + '][login]" value="1" />';
  html += '            <label for="copu-product' + copu_product_row + '_login1"><?php echo $text_yes; ?></label>';
  html += '            <input type="radio" id="copu-product' + copu_product_row + '_login0" name="copu_products[' + copu_product_row + '][login]" value="0" checked="checked" />';
  html += '           <label for="copu-product' + copu_product_row + '_login0"><?php echo $text_no; ?></label>';
  html += '          </td>';
  html += '        </tr>';
  html += '        <tr>';
  html += '          <td><?php echo $entry_customer_group; ?></td>';
  html += '          <td><div class="scrollbox">';
  <?php $class = 'even'; ?>
  <?php foreach ($customer_groups as $customer_group) { ?>
  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
  html += '              <div class="<?php echo $class; ?>">';
  html += '                <input type="checkbox" name="copu_products[' + copu_product_row + '][customer_groups][]" value="<?php echo $customer_group['customer_group_id']; ?>" id="copu-product' + copu_product_row + '_customer_group<?php echo $customer_group['customer_group_id']; ?>" />';
  html += '                <label for="copu-product' + copu_product_row + '_customer_group<?php echo $customer_group['customer_group_id']; ?>"><?php echo addslashes($customer_group['name']); ?></label>';
  html += '              </div>';
  <?php } ?>
  html += '            </div></td>';
  html += '        </tr>';
  html += '        <tr>';
  html += '          <td><?php echo $entry_store; ?></td>';
  html += '          <td><div class="scrollbox">';
  <?php $class = 'even'; ?>
  html += '              <div class="<?php echo $class; ?>">';
  html += '                <input type="checkbox" name="copu_products[' + copu_product_row + '][stores][]" value="0" checked="checked" id="copu-product' + copu_product_row + '_store0" />';
  html += '                <label for="copu-product' + copu_product_row + '_store0"><?php echo $text_default; ?></label>';
  html += '              </div>';
  <?php foreach ($stores as $store) { ?>
  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
  html += '              <div class="<?php echo $class; ?>">';
  html += '                <input type="checkbox" name="copu_products[' + copu_product_row + '][stores][]" value="<?php echo $store['store_id']; ?>" id="copu-product' + copu_product_row + '_store<?php echo $store['store_id']; ?>" />';
  html += '                <label for="copu-product' + copu_product_row + '_store<?php echo $store['store_id']; ?>"><?php echo addslashes($store['name']); ?></label>';
  html += '              </div>';
  <?php } ?>
  html += '            </div></td>';
  html += '        </tr>';
  html += '      </table>';
  html += '    </div>';

  $('#tab-product').append(html);

  $('#copu-product-add').before('<a href="#tab-copu-product' + copu_product_row + '" id="copu-product' + copu_product_row + '"><?php echo $tab_copu_product; ?> ' + copu_product_row + '&nbsp;<img src="view/image/delete.png" alt="delete" onclick="$(\'.vtabs a:first\').trigger(\'click\'); <?php foreach ($languages as $language) { ?>CKEDITOR.instances.copu_product' + copu_product_row + '_message<?php echo $language['language_id']; ?>.destroy(); <?php } ?>$(\'#copu-product' + copu_product_row + '\').remove(); $(\'#tab-copu-product' + copu_product_row + '\').remove(); return false;" /></a>');
  
  $('#vtabs a').tabs();

  <?php foreach ($languages as $language) { ?>
  CKEDITOR.replace('copu_product' + copu_product_row + '_message<?php echo $language['language_id']; ?>', {
    filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
    filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
    filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
    filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
    filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
    filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
  });
  <?php } ?>

  $('#copu-product' + copu_product_row + '-languages a').tabs();

  $('#copu-product' + copu_product_row).trigger('click');
  
  copu_product_row++;
  new_copu_product_id++;
}
//--></script>
<?php echo $footer; ?>