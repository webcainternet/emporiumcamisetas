<?php if($html) { ?>
<div id="tab-copu"<?php if($type == 'order') { ?> class="vtabs-content"<?php } ?>>
  <table id="copu-tbl" class="list copu-tbl">
    <thead>
      <tr>
        <td class="center"><?php echo $column_image; ?></td>
        <td class="left"><?php echo $column_name; ?></td>
        <td class="right" style="width:10%;"><?php echo $column_size; ?></td>
        <td class="right" style="width:15%;"><?php echo $column_date; ?></td>
        <?php if($delete) { ?><td class="right" style="width:10%;"><?php echo $column_action; ?></td><?php } ?>
      </tr>
    </thead>
    <tbody>
      <?php if ($uploads) { ?>
      <?php foreach ($uploads as $file) { ?>
      <tr id="upload<?php echo $file['upload_id']; ?>">
        <?php if($upload) { ?><input type="hidden" name="<?php echo $type; ?>_upload[]" value="<?php echo $file['upload_id']; ?>" /><?php } ?>
        <td class="center"><?php if($file['popup']) { ?><a href="<?php echo $file['popup']; ?>" class="colorbox" rel="copubox"><?php } ?><img src="<?php echo $file['image']; ?>" alt="<?php echo $file['name']; ?>" title="<?php echo $text_popup; ?>" /><?php if($file['popup']) { ?></a><?php } ?></td>
        <td class="left"><a href="<?php echo $file['href']; ?>" title="<?php echo $text_download; ?>"><?php echo $file['name']; ?></a></td>
        <td class="right"><?php echo $file['size']; ?></td>
        <td class="right"><?php echo $file['date']; ?></td>
        <?php if($delete) { ?><td class="right">[ <a href="<?php echo $file['delete']; ?>" class="delete-btn-info" id="<?php echo $file['upload_id']; ?>"><?php echo $text_delete; ?></a> ]</td><?php } ?>
      </tr>
      <?php } ?>
      <?php } else { ?>
      <tr class="empty">
        <td class="center" colspan="<?php echo $colspan; ?>"><?php echo $text_empty; ?></td>
      </tr>
      <?php } ?>
      <?php if($upload) { ?>
      <tr class="error-msg"></tr>
      <tr>
        <td colspan="<?php echo $colspan; ?>" class="upload-ctrl">
          <div class="drop-zone">
            <p class="bg-text"><?php echo $text_drag_drop; ?></p>
            <a id="button-upload" class="button">
              <span><?php echo $button_upload; ?></span>
              <input id="fileupload" type="file" name="file" multiple>
            </a>
          </div>
        </td>
      </tr>
      <?php } ?>
    </tbody>
  </table>
</div>
<?php } ?>
<?php if($javascript) { ?>
<script type="text/javascript"><!--
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
<?php if($delete) { ?>
$('.delete-btn-info').die('click.deleteBtnInfo');
$('.delete-btn-info').live('click.deleteBtnInfo', function() {
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
          $('#upload' + _upload_id).fadeOut(function() { $(this).remove(); });
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
<?php } ?>
<?php if($upload) { ?>
//////////////jQuery File Upload//////////////
var _url = 'index.php?route=myoc/copu/upload&token=<?php echo $token; ?>&type=<?php echo $type; ?>&customer_id=<?php echo $customer_id; ?>&order_id=<?php echo $order_id; ?>';
$('#fileupload').fileupload({
  url: _url,
  dataType: 'json',
  dropZone: $('#copu-tbl tbody td.upload-ctrl'),
  disableImageResize: /Android(?!.*Chrome)|Opera/.test(window.navigator && navigator.userAgent),
  previewMaxWidth: <?php echo $copu_preview_dimension_w; ?>,
  previewMaxHeight: <?php echo $copu_preview_dimension_h; ?>,
  previewCrop: true,
  disableImageResize: true,
}).on('fileuploadadd', function (e, data) {
  $('.warning').parent('td').remove();
  $('.warning').remove();
  $.each(data.files, function (index, file) {
    $('#copu-tbl tbody tr.empty').remove();

    data.context = $('<tr/>');

    <?php if($upload) { ?>
    $('<input type="hidden" name="<?php echo $type; ?>_upload[]" value=""/>').appendTo(data.context);
    <?php } ?>
    $('<td class="preview center"/>').appendTo(data.context);
    $('<td class="name left"/>')
      .append($('<img src="view/image/loading.gif" class="loading" style="margin-right: 5px;" />'))
      .append($('<span/>').text(truncateFilename(file.name, <?php echo $copu_max_filename_length; ?>)))
      .append($('<br/>'))
      .append($('<div class="progressbar"/>').append($('<div class="progress-label"/>').text('<?php echo $text_loading; ?>')))
      .appendTo(data.context);
    $('<td class="right"/>').append($('<span/>').text(formatFilesize(file.size))).appendTo(data.context);
    $('<td class="right"/>').append($('<span/>').text('<?php echo date($date_format_short); ?>')).appendTo(data.context);
    <?php if($delete) { ?>
    $('<td class="action right"/>').html('[ <a class="delete-btn-info" href=""><?php echo $text_delete; ?></a> ]').appendTo(data.context);
    data.context.find('td.action a').click(function(e) {
      e.preventDefault();
      if(confirm('<?php echo $text_confirm_delete; ?>?')) {
        data.abort();
        data.context.fadeOut(function() { $(this).remove(); });
      }
      return false;
    });
    <?php } ?>
    $('#copu-tbl tbody tr.error-msg').before(data.context);
    data.submit();
  });
}).on('fileuploaddone', function (e, data) {
  data.context.find('.loading').remove();
  if(data.result.error) {
    data.abort();
    data.context.fadeOut(function() { $(this).remove(); });
    var _error_msg = $('<td colspan="<?php echo $colspan; ?>"/>').append($('<div class="warning"/>').text(data.result.error));
    $('#copu-tbl tbody .error-msg').html(_error_msg);
  } else {
    <?php if($upload) { ?>
    data.context.find('input[name="<?php echo $type; ?>_upload[]"]').val(data.result.file.upload_id);
    <?php } ?>
    data.context.attr("id", "upload" + data.result.file.upload_id);
    if(data.result.file.popup) {
      data.context.find("td.preview a").attr("href", data.result.file.popup);
    }
    data.context.find("td.name span").html($('<a href="' + data.result.file.href + '" title="<?php echo $text_download; ?>"/>').text(data.result.file.name));
    <?php if($upload) { ?>
    data.context.find("td.action").html('[ <a id="' + data.result.file.upload_id + '" class="delete-btn-info" href="' + data.result.file.delete + '"><?php echo $text_delete; ?></a> ]');
    <?php } ?>
    data.context.find('.progressbar .progress-label').text("<?php echo $text_complete; ?>");
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
    $(data.context.find('a#button-upload')).prop('disabled', !!data.files.error);
  }
});
$(document).on('drop dragover', function (e) {
  e.preventDefault();
});
<?php } ?>
//--></script>
<?php } ?>