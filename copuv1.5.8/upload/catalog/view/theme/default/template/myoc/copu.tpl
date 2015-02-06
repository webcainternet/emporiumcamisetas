<h2><?php echo $text_upload; ?></h2>
	<?php if($copu_message) { ?><div><?php echo $copu_message; ?></div><?php } ?>	
  <?php if($error_upload_minimum) { ?><div class="warning"><?php echo $error_upload_minimum; ?><img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div><?php } ?>
  <table class="form copu-tbl">
		<thead>
		  <tr>
		    <?php if($copu_preview) { ?><td class="preview"><?php echo $column_image; ?></td><?php } ?>
		    <td class="name"><?php echo $column_name; ?></td>
		    <td class="size"><?php echo $column_size; ?></td>
        <?php if($date) { ?><td class="date"><?php echo $column_date; ?></td><?php } ?>
		    <?php if($action) { ?><td class="action"><?php echo $column_action; ?></td><?php } ?>
		  </tr>
		</thead>
		<tbody><?php if ($uploads) { ?>
      <?php foreach ($uploads as $upload) { ?>
      <tr id="upload<?php echo $upload['upload_id']; ?>">
        <?php if ($upload['image']) { ?><td class="preview">
          <?php if ($upload['popup']) { ?><a href="<?php echo $upload['popup']; ?>" class="colorbox" rel="copubox"><?php } ?><img src="<?php echo $upload['image']; ?>" alt="<?php echo $upload['name']; ?>" title="<?php echo $text_popup; ?>" /><?php if ($upload['popup']) { ?></a><?php } ?>
          </td><?php } ?>
        <td class="name"><a href="<?php echo $upload['href']; ?>" title="<?php echo $text_download; ?>"><?php echo $upload['name']; ?></a></td>
        <td class="size"><?php echo $upload['size']; ?></td>   
        <?php if($date) { ?><td class="date"><?php echo $upload['date']; ?></td><?php } ?>
        <?php if($action) { ?><td class="action"><a href="<?php echo $upload['delete']; ?>" class="delete-btn" id="<?php echo $upload['upload_id']; ?>"><img src="catalog/view/theme/default/image/remove.png" alt="<?php echo $button_remove; ?>" title="<?php echo $button_remove; ?>" /></a></td><?php } ?>
      </tr>
      <?php } ?>
    <?php } else { ?>
      <tr class="empty"><td colspan="<?php echo $colspan; ?>"><?php echo $text_empty; ?></td></tr>
    <?php } ?>
    <?php if($action || $copu_order_history_modify) { ?>
      <tr class="error-msg"></tr>
		  <tr>
		    <td colspan="<?php echo $colspan; ?>" class="upload-ctrl">
          <?php if($drag_drop) { ?>
          <div class="drop-zone">
            <p class="bg-text"><?php echo $text_drag_drop; ?></p>
          <?php } ?>
            <a id="button-upload" class="button">
              <span><?php echo $button_upload; ?></span>
              <input id="fileupload" type="file" name="file"<?php if($multiple) { ?> multiple<?php } ?>>
            </a>
          <?php if($drag_drop) { ?></div><?php } ?>
        </td>
		  </tr>
    <?php } ?>
		</tbody>
  </table>
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
<?php if($action) { ?>
$('.delete-btn').die('click.deleteBtn');
$('.delete-btn').live("click.deleteBtn", function() {
  var _thisBtn = $(this);
  var _upload_id = _thisBtn.attr('id');
  var _url = _thisBtn.attr('href');
  if(confirm('<?php echo $text_confirm_delete; ?>'))
  {
    $.ajax({
      url: _url,
      dataType: 'json',
      beforeSend: function() {
        _thisBtn.before('<span class="wait"><img src="catalog/view/theme/default/image/loading.gif" alt="" />&nbsp;&nbsp;</span>');
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
<?php } ?>
<?php if($action || $copu_order_history_modify) { ?>  
//////////////jQuery File Upload//////////////
var _url = 'index.php?route=myoc/copu/upload&type=<?php echo $type; ?>&type_id=<?php echo $type_id; ?><?php echo $nosession; ?>';
$('#fileupload').fileupload({
  url: _url,
  dataType: 'json',
  dropZone: <?php if($drag_drop) { ?>$('.copu-tbl tbody td.upload-ctrl')<?php } else { ?>null<?php } ?>,
  disableImageResize: /Android(?!.*Chrome)|Opera/.test(window.navigator && navigator.userAgent),
  previewMaxWidth: <?php echo $copu_preview_dimension_w; ?>,
  previewMaxHeight: <?php echo $copu_preview_dimension_h; ?>,
  previewCrop: true,
  disableImageResize: true,
}).on('fileuploadadd', function (e, data) {
  $('.warning').remove();
  $.each(data.files, function (index, file) {
    console.log(file);
    $.getJSON("index.php?route=myoc/copu/validateUpload&type=<?php echo $type; ?>&type_id=<?php echo $type_id; ?><?php echo $nosession; ?>", {"filename":file.name, "filesize":file.size, "filetype":file.type}, function (result) {
      if(result.error) {
        data.abort();
        data.context.fadeOut(function() { $(this).remove(); });
        $('.warning').remove();
        var _error_msg = $('<td class="warning" colspan="<?php echo $colspan; ?>"/>').text(result.error).append($('<img src="catalog/view/theme/default/image/close.png" alt="" class="close"/>'));
        $('.copu-tbl tbody .error-msg').html(_error_msg);
      } else {
        data.submit();
      }
    });

    $('.copu-tbl tbody tr.empty').remove();

    data.context = $('<tr/>');

    <?php if($copu_preview) { ?>
    $('<td class="preview"/>').appendTo(data.context);
    <?php } ?>
    $('<td class="name"/>')
      .append($('<img src="catalog/view/theme/default/image/loading.gif" class="loading" style="margin-right: 5px;" />'))
      .append($('<span/>').text(truncateFilename(file.name, <?php echo $copu_max_filename_length; ?>)))
      .append($('<br/>'))
      .append($('<div class="progressbar"/>').append($('<div class="progress-label"/>').text('<?php echo $text_loading; ?>')))
      .appendTo(data.context);
    $('<td class="size"/>').append($('<span/>').text(formatFilesize(file.size))).appendTo(data.context);
    <?php if($date) { ?>
    $('<td class="date"/>').append($('<span/>').text('<?php echo date($date_format_short); ?>')).appendTo(data.context);
    <?php } ?>
    <?php if($action) { ?>
    $('<td class="action"/>').append($('<a class="cancel-btn" href=""/>').append($('<img src="catalog/view/theme/default/image/remove.png" alt="<?php echo $button_remove; ?>" title="<?php echo $button_remove; ?>"/>'))).appendTo(data.context);
    data.context.find('td.action a').click(function(e) {
      e.preventDefault();
      if(confirm('<?php echo $text_confirm_delete; ?>')) {
        data.abort();
        data.context.fadeOut(function() { $(this).remove(); });
      }
      return false;
    });
    <?php } ?>
    $('.copu-tbl tbody tr.error-msg').before(data.context);
  });
}).on('fileuploaddone', function (e, data) {
  data.context.find('.loading').remove();
  if(data.result.error) {
    data.abort();
    data.context.fadeOut(function() { $(this).remove(); });
    var _error_msg = $('<td class="warning" colspan="<?php echo $colspan; ?>"/>').text(data.result.error).append($('<img src="catalog/view/theme/default/image/close.png" alt="" class="close"/>'));
    $('.copu-tbl tbody .error-msg').html(_error_msg);
  } else {
    data.context.attr("id", "upload" + data.result.file.upload_id);
    <?php if($copu_preview) { ?>
    data.context.find("td.preview a").attr("href", data.result.file.popup);
    <?php } ?>
    data.context.find("td.name span").html($('<a href="' + data.result.file.href + '" title="<?php echo $text_download; ?>"/>').text(data.result.file.name));
    <?php if($action) { ?>
    data.context.find("td.action").html($('<a id="' + data.result.file.upload_id + '" class="delete-btn" href="' + data.result.file.delete + '"/>').append($('<img src="catalog/view/theme/default/image/remove.png" alt="<?php echo $button_remove; ?>" title="<?php echo $button_remove; ?>"/>')));
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
})<?php if($copu_preview) { ?>.on('fileuploadprocessalways', function (e, data) {
  var index = data.index,
    file = data.files[index],
    node = $(data.context.children('td.preview')),
    img = new Image();
  if (file.preview) {
    img.src = file.preview.toDataURL();
    var link = $('<a class="colorbox" rel="copubox"/>');
  } else {
    img.src = "image/no_image.jpg";
    img.width = <?php echo $copu_preview_dimension_w; ?>;
    img.height = <?php echo $copu_preview_dimension_h; ?>;
    var link = $('<span/>');
  }
  link.append(img);
  node.append(link);
  if (file.error) {
    node.append(file.error);
  }
  if (index + 1 === data.files.length) {
    $('a#button-upload').prop('disabled', !!data.files.error);
  }    
})<?php } ?>;
$(document).on('drop dragover', function (e) {
  e.preventDefault();
});
<?php } ?>
//--></script>