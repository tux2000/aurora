#!/usr/bin/perl

$lon = 17.63;
$lat = 59.85;
$lat = 68;
$lon = 270;

#   1096 values covering 0 to 360 degrees in the horizontal (longitude) direction  (0.32846715 degrees/value)
#   512 values covering -90 to 90 degrees in the vertical (latitude) direction  (0.3515625 degrees/value)
#   Values range from 0 (little or no probability of visible aurora) to 100 (high probability of visible aurora)

$xf = int($lon / 0.32846715)+1;
$yf = int((90+$lat) / 0.3515625)+1;

#print "$xf $yf\n";

$i=1;
$j=1;


while(<>){
   chomp;
   next if(m/^\s*#/);
   @a = split(/\s+/);
   for($j=1;$j < 1096;$j++){
      if($a[$j] > 0){
         $lo = ($j * 0.32846715)-180;
         $la = ($i * 0.3515625)-90;
         $al = $a[$j] / 100.0;
#         print "<wpt lat=\"$la\" lon=\"$lo\" >\n";
         print "$lo,$la,$al\n";
      }
   }
   $i++;
#   print "$j $i\n";
}


