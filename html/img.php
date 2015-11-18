<?php
session_start();
require_once("bandwidth_graph.class.php");
if (isset($_SESSION["rrddb"]))
{
   $rrddb = $_SESSION["rrddb"];
}
else
{
   $rrddb = "bandwidth";
}
$g = new BandwidthGraph("../$rrddb.rrd", $_GET["ds"], $_GET["desc"]);
$ts = time();
header("Content-Type: image/png");
$g->setStart($_GET["from"]);
if (( strpos($_GET["from"], "day")  !== false ) ||
   ( strpos($_GET["from"], "week")  !== false )
   )
{
   $g->showAbsMin();
   $g->showAbsMax();
   $g->showRecent("#000000");
   $g->showArea("#ff000032");
}
else
{
   $g->showMin("#0000ff");
   $g->showMax("#ff0000");
}
$g->setUpperLimit($_GET["ul"]);
$g->setLowerLimit(0);
$g->setUnit("Mbit/s");
$g->setScaleDownValue(1024*1024);
$g->setBackgroundColor("#E6E6DC");
//file_put_contents("tmp_$ts.png", $g->generateImage());
echo $g->generateImage();
//print("<img class=\"output_image\" src=\"tmp_$ts.png\" />");
