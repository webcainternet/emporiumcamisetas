<?php if($copu_message) { ?><div><?php echo $copu_message; ?></div><?php } ?>
<table id="copu-tbl-<?php echo $product_option_id; ?>" class="form copu-tbl" style="margin-bottom:1px;">
  <thead>
    <tr>
      <?php if($copu_preview) { ?><td class="preview" style="width:<?php echo $copu_preview_dimension_w; ?>px;"><?php echo $column_image; ?></td><?php } ?>
      <td class="name"><?php echo $column_name; ?></td>
      <td class="action"></td>
    </tr>
  </thead>
  <tbody><?php if ($uploads) { ?>
    <?php foreach ($uploads as $upload) { ?>
    <tr id="upload<?php echo $upload['upload_id']; ?>">
      <?php if ($upload['image']) { ?><td class="preview" style="width:<?php echo $copu_preview_dimension_w; ?>px;">
        <?php if ($upload['popup']) { ?><a href="<?php echo $upload['popup']; ?>" class="colorbox" rel="copubox"><?php } ?><img src="<?php echo $upload['image']; ?>" alt="<?php echo $upload['name']; ?>" title="<?php echo $text_popup; ?>" /><?php if ($upload['popup']) { ?></a><?php } ?>
        </td><?php } ?>
      <td class="name"><a href="<?php echo $upload['href']; ?>" title="<?php echo $text_download; ?>"><?php echo $upload['name']; ?></a><br /><b><?php echo $column_size; ?>:</b> <?php echo $upload['size']; ?></td>     
      <td class="action"><a href="<?php echo $upload['delete']; ?>" class="delete-btn" id="<?php echo $upload['upload_id']; ?>"><img src="catalog/view/theme/default/image/remove.png" alt="<?php echo $button_remove; ?>" title="<?php echo $button_remove; ?>" /></a></td>
    </tr>
    <?php } ?>
  <?php } else { ?>
    <tr class="empty"><td colspan="<?php echo $colspan; ?>"><?php echo $text_empty; ?></td></tr>
  <?php } ?>
    <tr class="error-msg"></tr>
    <tr>
      <td colspan="<?php echo $colspan; ?>" class="upload-ctrl">
        <?php if($drag_drop) { ?>
        <div class="drop-zone">
          <p class="bg-text"><?php echo $text_drag_drop; ?></p>
        <?php } ?>
          <a class="button button-upload">
            <span><?php echo $button_upload; ?></span>
            <input class="fileupload" type="file" name="file"<?php if($multiple) { ?> multiple<?php } ?>>
          </a>
        <?php if($drag_drop) { ?></div><?php } ?>
      </td>
    </tr>
  </tbody>
</table>
<input type="hidden" name="copu_product_id[<?php echo $product_option_id; ?>]" value="<?php echo $copu_product_id; ?>" />
</div><br /><!-- close default option <div> -->
<script type="text/javascript"><!--
<?php if(isset($upload['replace']) && $upload['replace']) { ?>
$('#image').parent().attr('href', '<?php echo $upload['popup']; ?>');
$('#image').attr('src', '<?php echo $upload['replace']; ?>');
<?php } ?>
<?php if($force_qty) { ?>
$(document).ready(function() {
  $('input[name=quantity]').val($('#copu-tbl-<?php echo $product_option_id; ?> .delete-btn').length > 0 ? $('#copu-tbl-<?php echo $product_option_id; ?> .delete-btn').length : parseInt($('input[name=quantity]').val())); 
});
<?php } ?>
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
          _thisBtn.remove();
          $('#upload' + _upload_id).fadeOut(function() { $(this).remove(); });
        }
        <?php if($force_qty) { ?>
        $('input[name=quantity]').val(parseInt($('input[name=quantity]').val()) > 1 ? $('#copu-tbl-<?php echo $product_option_id; ?> .delete-btn').length : 1);
        <?php } ?>
        if(json['error']) {
          alert(json['error']);
          $('#upload' + _upload_id).fadeOut(function() { $(this).remove(); });
        }
      },
      error: function(xhr, ajaxOptions, thrownError) {
        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
      }
    });
  }
  return false;
});
var empty_row = '<tr class="empty"><td colspan="<?php echo $colspan; ?>"><?php echo $text_empty; ?></td></tr>';
//////////////jQuery File Upload//////////////
var _url = 'index.php?route=myoc/copu/upload&type=product&type_id=<?php echo $product_id; ?>&product_option_id=<?php echo $product_option_id; ?>&copu_product_id=<?php echo $copu_product_id; ?>';
$('#copu-tbl-<?php echo $product_option_id; ?> tbody .fileupload').fileupload({
  url: _url,
  dataType: 'json',
  dropZone: <?php if($drag_drop) { ?>$("#copu-tbl-<?php echo $product_option_id; ?> tbody td.upload-ctrl")<?php } else { ?>null<?php } ?>,
  disableImageResize: /Android(?!.*Chrome)|Opera/.test(window.navigator && navigator.userAgent),
  previewMaxWidth: <?php echo $image_thumb_width; ?>,
  previewMaxHeight: <?php echo $image_thumb_height; ?>,
  previewCrop: true,
  disableImageResize: true,
}).on('fileuploadadd', function (e, data) {
  $('.warning').remove();
  $.each(data.files, function (index, file) {
    $.getJSON("index.php?route=myoc/copu/validateUpload&type=product&type_id=<?php echo $product_id; ?>&product_option_id=<?php echo $product_option_id; ?>&copu_product_id=<?php echo $copu_product_id; ?>", {"filename":file.name, "filesize":file.size, "filetype":file.type}, function (result) {
      if(result.error) {
        data.abort();
        data.context.fadeOut(function() { $(this).remove(); });
        $('.warning').remove();
        var _error_msg = $('<td class="warning" colspan="<?php echo $colspan; ?>"/>').text(result.error).append($('<img src="catalog/view/theme/default/image/close.png" alt="" class="close"/>'));
        $('#copu-tbl-<?php echo $product_option_id; ?> tbody .error-msg').html(_error_msg);
      } else {
        data.submit();
      }
    });

    $('#copu-tbl-<?php echo $product_option_id; ?> tbody tr.empty').remove();

    data.context = $('<tr/>');

    <?php if($copu_preview) { ?>
    $('<td class="preview"/>').appendTo(data.context);
    <?php } ?>
    $('<td class="name"/>')
      .append($('<img src="catalog/view/theme/default/image/loading.gif" class="loading" style="margin-right: 5px;" />'))
      .append($('<span/>').text(truncateFilename(file.name, <?php echo $copu_max_filename_length; ?>)))
      .append($('<br/>'))
      .append('<b><?php echo $column_size; ?>:</b> ' + formatFilesize(file.size))
      .append($('<br/>'))
      .append($('<div class="progressbar"/>').append($('<div class="progress-label"/>').text('<?php echo $text_loading; ?>')))
      .appendTo(data.context);
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
    $('#copu-tbl-<?php echo $product_option_id; ?> tbody tr.error-msg').before(data.context);
  });
}).on('fileuploaddone', function (e, data) {
  data.context.find('.loading').remove();
  if(data.result.error) {
    data.abort();
    data.context.fadeOut(function() { $(this).remove(); });
    var _error_msg = $('<td class="warning" colspan="<?php echo $colspan; ?>"/>').text(data.result.error).append($('<img src="catalog/view/theme/default/image/close.png" alt="" class="close"/>'));
    $('#copu-tbl-<?php echo $product_option_id; ?> tbody .error-msg').html(_error_msg);
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
    if(data.result.file.replace) {
      $('#image').parent().attr('href', data.result.file.popup);
      $('#image').attr('src', data.result.file.replace);
    }
    <?php if($force_qty) { ?>
    $('input[name=quantity]').val($('#copu-tbl-<?php echo $product_option_id; ?> .delete-btn').length);
    <?php } ?>
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
    <?php if($copu_replace) { ?>
    $("#image").attr('src', img.src);
    <?php } ?>
    var link = $('<a class="colorbox" rel="copubox"/>');
  } else {
    img.src = "image/no_image.jpg";
    var link = $('<span/>');
  }
  img.width = <?php echo $copu_preview_dimension_w; ?>;
  img.height = <?php echo $copu_preview_dimension_h; ?>;
  link.append(img);
  node.append(link);
  if (file.error) {
    node.append(file.error);
  }
  if (index + 1 === data.files.length) {
    $(data.context.find('a.button-upload')).prop('disabled', !!data.files.error);
  }    
})<?php } ?>;
$(document).on('dragover drop', function (e) {
  e.preventDefault();
});
//--></script>