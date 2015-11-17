<?php

class BandwidthGraph {
   

   var $rrdFile;
   var $g;
   var $width = 600;
   var $height = 150;
   var $lower;
   var $upper;
   var $start = "1 day";
   var $end = "now";
   var $unit;
   var $ds;
   var $title;
   var $areaColor;
   var $showAbsMin = false;
   var $showAbsMax = false;
   var $showTotal = false;
   var $recentColor;
   var $scaleDownValue = 1;
   var $minColor;
   var $maxColor;
   var $bgColor;
   var $specOptions;
   function BandwidthGraph($rrdFile, $ds, $title) {
      $this->rrdFile = $rrdFile;
      $this->g = new RRDGraph("-");
      $this->ds = $ds;
      $this->title = $title;
   }
   function setBackgroundColor($col) {
      $this->bgColor = $col;
   }
   function setStart($start) {
      $this->start = $start;
   }

   function setUnit($unit) {
      $this->unit = $unit;
   }
   
   function setUpperLimit($limit) {
      $this->upper = $limit;
   }
   
   function setLowerLimit($limit) {
      $this->lower = $limit;
   }
   
   function setScaleDownValue($unit) {
      $this->scaleDownValue = $unit;
   }

   function showAbsMin() {
      $this->showAbsMin = true;
   }
   
   function showAbsMax() {
      $this->showAbsMax = true;
   }
   
   function showTotal() {
      $this->showTotal = true;
   }
   
   function showRecent($col) {
      $this->recentColor = $col;
   }
  
   function showMin($col) {
      $this->minColor = $col;
   }

   function showMax($col) {
      $this->maxColor = $col;
   }

   function showArea($col) {
      $this->areaColor = $col;
   }

   function generateImage() {
      
      $options = 
      array(
      "-t $this->title",
      "-w $this->width",
      "-h $this->height",
      "-s $this->end - $this->start",
      "-e $this->end",
      "-X 0"
      );
      
      $dsoptions = 
      array(
      "VDEF:absmin=recent,MINIMUM",
      "VDEF:absmax=recent,MAXIMUM",
      "DEF:min=$this->rrdFile:$this->ds:MIN",
      "DEF:max=$this->rrdFile:$this->ds:MAX"
      );
      
      $this->specOptions =
      array(
      "DEF:recent_raw=$this->rrdFile:$this->ds:AVERAGE",
      "CDEF:recent=recent_raw,$this->scaleDownValue,/",
      ); 
      $options = array_merge($options, $this->specOptions, $dsoptions);
      
      array_push($options, "-v $this->unit");
      if (isset($this->upper)) {
         array_push($options, "-u $this->upper");
      }
      if (isset($this->lower)) {
         array_push($options, "-l $this->lower");
      }
      if (isset($this->bgColor)) {
         array_push($options, "--color=CANVAS$this->bgColor");
         array_push($options, "--color=BACK$this->bgColor");
         array_push($options, "--color=SHADEA$this->bgColor");
         array_push($options, "--color=SHADEB$this->bgColor");
      }
      if (isset($this->areaColor)) {
         array_push($options, "AREA:recent{$this->areaColor}");
      }
      if ($this->recentColor) {
         array_push($options, "LINE1:recent{$this->recentColor}:Latest");
         array_push($options, "GPRINT:recent:LAST:\\t%5.2lf $this->unit\\n");
      }
      if ($this->minColor) {
         array_push($options, "LINE1:min{$this->minColor}:Minimum");
         array_push($options, "GPRINT:min:MIN:\\t%5.2lf $this->unit\\n");
      }
      if ($this->maxColor) {
         array_push($options, "LINE1:max{$this->maxColor}:Maximum");
         array_push($options, "GPRINT:max:MAX:\\t%5.2lf $this->unit\\n");
      }
      if ($this->showAbsMin) {
         array_push($options, "HRULE:absmin#0000ff:Minimum");
         array_push($options, "GPRINT:recent:MIN:\\t%5.2lf $this->unit\\n");
      }
      if ($this->showAbsMax) {
         array_push($options, "HRULE:absmax#ff0000:Maximum");
         array_push($options, "GPRINT:recent:MAX:\\t%5.2lf $this->unit\\n");
      }
      if ($this->showTotal) {
         array_push($options, "GPRINT:total:Summe\\t\\t%5.2lf $this->unit\\n");
      }
      $this->g->setOptions($options);
      $res = $this->g->saveVerbose();
      return $res["image"];
   }

}


