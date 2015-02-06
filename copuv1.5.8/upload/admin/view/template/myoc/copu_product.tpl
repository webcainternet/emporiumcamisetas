<?php if($html) { ?>
html += '<div>';
if (option['required']) {
  html += '<span class="required">*</span> ';
}          
html += option['name'] + '<br />';
html += '  <table id="copu-tbl-' + option['product_option_id'] + '" class="list copu-tbl">';
html += '    <thead>';
html += '      <tr>';
html += '        <td class="center" style="background-color: #EFEFEF;width:110px;"><?php echo $column_image; ?></td>';
html += '        <td class="left" style="background-color: #EFEFEF;"><?php echo $column_name; ?></td>';
html += '        <td class="right" style="background-color: #EFEFEF;width:10%;"><?php echo $column_action; ?></td>';
html += '      </tr>';
html += '    </thead>';
html += '    <tbody>';
html += '      <tr class="empty">';
html += '        <td class="center" colspan="3"><?php echo $text_empty; ?></td>';
html += '      </tr>';
html += '      <tr class="error-msg"></tr>';
html += '      <tr>';
html += '        <td colspan="3" class="upload-ctrl">';
html += '          <div class="drop-zone">';
html += '            <p class="bg-text"><?php echo $text_drag_drop; ?></p>';
html += '            <a class="button button-upload">';
html += '              <span><?php echo $button_upload; ?></span>';
html += '              <input class="fileupload" type="file" name="file" multiple>';
html += '              <input type="hidden" name="product_option_id" value="' + option['product_option_id'] + '" />';
html += '            </a>';
html += '          </div>';
html += '      </tr>';
html += '    </tbody>';
html += '  </table>';
html += '</div>';
<?php } ?>
<?php if($javascript) { ?>
if($.isFunction($.fn.fancybox)) {
  (function($) {
      $.fn.colorbox = function() {
          return $.fn.fancybox.apply(this, arguments);
      };
  })(jQuery);
}
$('.colorbox').colorbox({
  overlayClose: true,
  opacity: 0.5
});
$('.delete-btn-update').die('click.deleteBtnUpdate');
$('.delete-btn-update').live('click.deleteBtnUpdate', function() {
  var _thisBtn = $(this);
  var _url = _thisBtn.attr('href');
  var _upload_id = _thisBtn.attr('id');
  if(confirm('<?php echo $text_confirm_delete; ?>?'))
  {
    $.ajax({
      url: _url,
      dataType: 'json',
      beforeSend: function() {
        _thisBtn.before('<span class="wait"><img src="view/image/loading.gif" alt="" />&nbsp;&nbsp;</span>');
        $('.warning').parent('td').remove();
        $('.warning').remove();
      },
      complete: function() {
        $('.wait').remove();
      },      
      success: function(json) {
        if(json['success']) {
          _thisBtn.remove();
          $('#upload' + _upload_id).fadeOut(function() { $(this).remove(); });
        }
        $('input[name=quantity]').val(parseInt($('input[name=quantity]').val()) > 1 ? $('.force-qty').length : 1);
        if(json['error']) {
          alert(json['error']);
        }
      },
      error: function(xhr, ajaxOptions, thrownError) {
        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
      }
    });
  }
  return false;
});
//////////////jQuery File Upload//////////////
var _url = 'index.php?route=myoc/copu/upload&token=<?php echo $token; ?>&type=product&option_id=' + option['option_id'] + '&product_option_id=' + option['product_option_id'] + '&customer_id=<?php echo $customer_id; ?>&order_id=<?php echo $order_id; ?>&product_id=' + $("input[name='product_id']").attr('value');
$('#copu-tbl-' + option['product_option_id'] + ' tbody .fileupload').fileupload({
  url: _url,
  dataType: 'json',
  dropZone: $('#copu-tbl-' + option['product_option_id'] + ' tbody td.upload-ctrl'),
  disableImageResize: /Android(?!.*Chrome)|Opera/.test(window.navigator && navigator.userAgent),
  previewMaxWidth: 100,
  previewMaxHeight: 100,
  previewCrop: true,
  disableImageResize: true,
}).on('fileuploadadd', function (e, data) {
  var product_option_id = $(this).next('input[name=product_option_id]').val();
  $('.warning').remove();
  $.each(data.files, function (index, file) {
    $('#copu-tbl-' + product_option_id + ' tbody tr.empty').remove();

    data.context = $('<tr/>');

    $('<input type="hidden" name="option[' + product_option_id + '][]" value=""/>').appendTo(data.context);
    $('<td class="preview center"/>').appendTo(data.context);
    $('<td class="name left"/>')
      .append($('<img src="view/image/loading.gif" class="loading" style="margin-right: 5px;" />'))
      .append($('<span/>').text(truncateFilename(file.name, 30)))
      .append($('<br/>'))
      .append('<b><?php echo $column_size; ?>:</b> ' + formatFilesize(file.size))
      .append($('<br/>'))
      .append($('<div class="progressbar"/>').append($('<div class="progress-label"/>').text('<?php echo $text_loading; ?>')))
      .appendTo(data.context);
    $('<td class="action right"/>').append('[ <a class="delete-btn-update" href=""><?php echo $text_delete; ?></a> ]').appendTo(data.context);
    data.context.find('td.action a').click(function(e) {
      e.preventDefault();
      if(confirm('<?php echo $text_confirm_delete; ?>?')) {
        data.abort();
        data.context.fadeOut(function() { $(this).remove(); });
      }
      return false;
    });
    $('#copu-tbl-' + product_option_id + ' tbody tr.error-msg').before(data.context);
    data.submit();
  });
}).on('fileuploaddone', function (e, data) {
  var product_option_id = $(this).next('input[name=product_option_id]').val();
  data.context.find('.loading').remove();
  if(data.result.error) {
    data.abort();
    data.context.fadeOut(function() { $(this).remove(); });
    var _error_msg = $('<td class="warning" colspan="3"/>').text(data.result.error).append($('<img src="catalog/view/theme/default/image/close.png" alt="" class="close"/>'));
    $('#copu-tbl-' + product_option_id + ' tbody tr.error-msg').html(_error_msg);
  } else {
    data.context.find('input[name="option[' + product_option_id + '][]"]').val(data.result.file.file);
    data.context.attr("id", "upload" + data.result.file.upload_id);
    if(data.result.file.popup) {
      data.context.find("td.preview a").attr("href", data.result.file.popup);
    }
    data.context.find("td.name span").html($('<a href="' + data.result.file.href + '" title="<?php echo $text_download; ?>"/>').text(data.result.file.name));
    data.context.find("td.action").html('[ <a id="' + data.result.file.upload_id + '" class="delete-btn-update' + (data.result.file.force_qty ? ' force-qty' : '') + '" href="' + data.result.file.delete + '"><?php echo $text_delete; ?></a> ]');
    data.context.find('.progressbar .progress-label').text("<?php echo $text_complete; ?>");

    $('input[name=quantity]').val($('.force-qty').length);
    data.context.find('.colorbox').colorbox({
      overlayClose: true,
      opacity: 0.5
    });
  }
}).on('fileuploadprogress', function (e, data) {
  var progress = parseInt(data.loaded / data.total * 100, 10),
    progressbar = data.context.find('.progressbar'),
    progressLabel = data.context.find('.progressbar .progress-label');
  progressbar.progressbar({
    value: progress,
    change: function() {
      progressLabel.text( progressbar.progressbar( "value" ) + "%" );
    }
  });
}).on('fileuploadprocessalways', function (e, data) {
  var index = data.index,
    file = data.files[index],
    node = $(data.context.children('td.preview')),
    img = new Image();
  if (file.preview) {
    img.src = file.preview.toDataURL();
    var link = $('<a class="colorbox" rel="copubox"/>');
  } else {
    img.src = "../image/no_image.jpg";
    var link = $('<span/>');
  }
  link.append(img);
  node.append(link);
  if (file.error) {
    node.append(file.error);
  }
  if (index + 1 === data.files.length) {
    $(data.context.find('a.button-upload')).prop('disabled', !!data.files.error);
  }    
});
$(document).on('drop dragover', function (e) {
  e.preventDefault();
});
<?php } ?>