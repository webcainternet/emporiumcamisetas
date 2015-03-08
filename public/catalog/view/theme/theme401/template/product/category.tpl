<?php echo $header; ?>
<?php echo $column_left; ?>
		<div class="<?php if ($column_left or $column_right) { ?>col-sm-9<?php } ?> <?php if (!$column_left & !$column_left) { ?>col-sm-12  <?php } ?> <?php if ($column_left & $column_right) { ?>col-sm-6<?php } ?>" id="content"><?php echo $content_top; ?>
  <div class="breadcrumb">
	<?php foreach ($breadcrumbs as $breadcrumb) { ?>
	<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
	<?php } ?>
  </div>
  <h1 class="style-1"><?php echo $heading_title; ?></h1>
  <?php if ($thumb || $description) { ?>
  <div class="category-info">
	<!--<?php if ($thumb) { ?>
	<div class="image"><img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" /></div>
	<?php } ?>-->
	<?php if ($description) { ?>
	<?php echo $description; ?>
	<?php } ?>
  </div>
  <?php } ?>
  <?php if ($categories) { ?>
  <div class="box subcat">
	<div class="box-heading"><span><?php echo $text_refine; ?></span></div>
	<div class="box-content">
		
		<div class="box-product box-subcat">
			<ul class="row"><?php $i=0;?>
				<?php foreach ($categories as $category) { $i++; ?>
				<?php 
						if ($i%3==1) {
							$a='first-in-line';
						}
						elseif ($i%3==0) {
							$a='last-in-line';
						}
						else {
							$a='';
						}
					?>
				<li class="cat-height  col-sm-3">
					<?php if ($category['thumb']) { ?>
					<div class="image"><a href="<?php echo $category['href']; ?>"><img src="<?php echo $category['thumb']; ?>" alt="<?php echo $category['name']; ?>" /></a></div>
					<?php } ?>
					<div class="name subcatname"><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></div>
				</li>
				<?php } ?>
			</ul>
		</div>
	</div>
  </div>
  <?php } ?>
  <?php if ($products) { ?>
  <div class="product-filter">
		<div class="sort"><b><?php echo $text_sort; ?></b>
	  <select onchange="location = this.value;">
		<?php foreach ($sorts as $sorts) { ?>
		<?php if ($sorts['value'] == $sort . '-' . $order) { ?>
		<option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
		<?php } else { ?>
		<option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
		<?php } ?>
		<?php } ?>
	  </select>
	</div>
	<div class="limit"><b><?php echo $text_limit; ?></b>
	  <select onchange="location = this.value;">
		<?php foreach ($limits as $limits) { ?>
		<?php if ($limits['value'] == $limit) { ?>
		<option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
		<?php } else { ?>
		<option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
		<?php } ?>
		<?php } ?>
	  </select>
	</div>
  <div class="product-compare"><a href="<?php echo $compare; ?>" id="compare-total"><?php echo $text_compare; ?></a></div>
	<div class="display" style="display: none;"><b><?php echo $text_display; ?></b> <?php echo $text_list; ?>  <a onclick="display('grid');"><?php echo $text_grid; ?></a></div>
  </div>

<style type="text/css">

.inner2 {
	display:block;
	position:absolute;
	top:0;
	left:0;
	text-align:center;
	/* background:rgba(242,121,150,0.8); #7dc8f5 */
	background:rgba(125,200,245,0.7);
	padding:18% 25px 0 ;
	border-radius:50%;
	-webkit-transition: all 0.5s ease;
    -moz-transition: all 0.5s ease;
    -o-transition: all 0.5s ease;
    transition: all 0.5s ease;
}
.image2 {
	border-radius:50%;
}
.tituloproduto {
	text-align: center;
	  margin-top: 10px;
	  font-family: 'Roboto Slab', serif;
	  text-transform: uppercase;
	  color: #333;
}
.precovalor {
  color: #7dc8f5;
  font-size: 31px;
  text-transform: uppercase;
  font-family: 'Roboto Slab', serif;
  text-align: right;
  margin-top: 5px;
}

ul li .padding:hover .inner {
	display:block;
	}
ul li .padding:hover .inner2 {
	display:none;
	}
</style>

  <div class="product-grid">
	<ul class="row">
		<?php $i=0; foreach ($products as $product) { $i++; ?>
		<?php 
			if ($i%3==1) {
				$a='first-in-line';
			}
			elseif ($i%3==0) {
				$a='last-in-line';
			}
			else {
				$a='';
			}
		?>
		<li class="col-sm-4 <?php echo $a?>" style="margin-bottom: 27px;">


		<div class="padding">
			<div class="image2">
				<?php if ($product['thumb']) { ?>
				<a href="<?php echo $product['href']; ?>">
					<img id="img_<?php echo $product['product_id']; ?>" src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" style="border-radius: 50%;" />
				</a>
				<?php } ?>
			</div>


			<div class="inner2 image2" style="padding: 25px;  margin-left: 15px;">

				<?php if ($product['thumb']) { 
					$imgprod = str_replace("_orig", "_hover",$product['thumb']);
					$imgprod = str_replace("-270x270", "", $imgprod);
					$imgprod = str_replace("/cache/", "/", $imgprod);
				?>
				<a href="<?php echo $product['href']; ?>">
					<img id="img_<?php echo $product['product_id']; ?>" src="<?php echo $imgprod; ?>" alt="<?php echo $product['name']; ?>" style="border-radius: 50%;   width: 221px;" />
				</a>
				<?php } ?>
			</div>

			<div class="tituloproduto"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
			<div class="precovalor"><a href="<?php echo $product['href']; ?>" class="precovalor"><?php echo $product['price']; ?></a></div>

			<div class="clear"></div>

		</div>

	</li>
		<?php } ?>

	 </ul>
  </div>
  
  <div class="pagination"><?php echo $pagination; ?></div>
  <?php } ?>
  <?php if (!$categories && !$products) { ?>
  <div class="box-container">
	  <div class="content"><?php echo $text_empty; ?></div>
	  <div class="buttons">
		<div class="right"><a href="<?php echo $continue; ?>" class="button"><span><?php echo $button_continue; ?></span></a></div>
	  </div>
  </div>
  <?php } ?>
  
  <?php echo $content_bottom; ?></div>

<?php echo $column_right; ?>

<?php echo $footer; ?>