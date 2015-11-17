<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="author" content="Christian Eisendle" />
<meta name="description" content="Bandwidth measurement using iperf and rrdtool" />
<meta property="og:site_name" content="Bandwidth Check" />
<meta property="og:type" content="website" />
<meta property="og:locale" content="de_DE" />
<meta property="og:description" content="Bandwidth measurement using iperf and rrdtool" />
<title>Bandwidth Check</title>
<link rel="stylesheet" href="styles.css" />
</head>
<body>
<div class="heading"><h1>Bandwidth Measurement</h1></div>
<div id="output_image_us"><img class="output_image" src="img.php?from=1day&ds=upstream&ul=10&desc=Upstream last 24h" /></div>
<div id="output_image_ds"><img class="output_image" src="img.php?from=1day&ds=downstream&ul=50&desc=Downstream last 24h" /></div>
<div id="output_image_us_1w"><img class="output_image" src="img.php?from=1week&ds=upstream&ul=10&desc=Upstream last 24h" /></div>
<div id="output_image_ds_1w"><img class="output_image" src="img.php?from=1week&ds=downstream&ul=50&desc=Downstream last 24h" /></div>
</body>
</html>
