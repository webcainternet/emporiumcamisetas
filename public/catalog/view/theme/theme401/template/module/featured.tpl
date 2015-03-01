<div class="box featured">
  <div class="box-heading"><span><?php echo $heading_title; ?></span></div>
  <div class="box-content">
	<div class="box-product">
		<ul class="row">
		  <?php $i=0; foreach ($products as $product) { $i++ ?>
		  <?php 
			   $perLine = 4;
			   $spanLine = 3;
			   $last_line = "";
							$total = count($products);
							$totModule = $total%$perLine;
							if ($totModule == 0)  { $totModule = $perLine;}
							if ( $i > $total - $totModule) { $last_line = " last_line";}
							if ($i%$perLine==1) {
								$a='first-in-line';
							}
							elseif ($i%$perLine==0) {
								$a='last-in-line';
							}
							else {
								$a='';
							}
						?>
			<li class="<?php echo $a. $last_line ;?> col-sm-<?php echo $spanLine ;?>">
				<script type="text/javascript">
				$(document).ready(function(){
					$("a.colorbox<?php echo $i?>").colorbox({
					rel: 'colorbox',
					inline:true,
					html: true,
					width:'58%',
					maxWidth:'780px',
					height:'70%',
					open:false,
					returnFocus:false,
					fixed: true,
					title: false,
					href:'.quick-view<?php echo $i;?>',
					current:'<?php echo $text_product; ?>'
					});
					});
				</script> 
				<div class="padding">
					<div class="image2">
						<?php if ($product['thumb']) { ?>
						<a href="<?php echo $product['href']; ?>">
							<img id="img_<?php echo $product['product_id']; ?>" src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" />
						</a>
						<?php } ?>
					</div>
				




					<div class="inner2 image2" style="padding: 25px 25px 0;">
						<?php if ($product['thumb']) { 
							$imgprod = str_replace("_orig", "_hover",$product['thumb']);
							$imgprod = str_replace("-270x270", "", $imgprod);
							$imgprod = str_replace("/cache/", "/", $imgprod);
						?>
						<a href="<?php echo $product['href']; ?>">
							<img id="img_<?php echo $product['product_id']; ?>" src="<?php echo $imgprod; ?>" alt="<?php echo $product['name']; ?>" />
						</a>
						<?php } ?>
					</div>

					<div class="clear"></div>
				</div>
			</li>
		  <?php } ?>
		</ul>
	</div>
	<div class="clear"></div>
  </div>
</div>
