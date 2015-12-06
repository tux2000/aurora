#!/usr/bin/perl

use LWP::Simple;


#   1096 values covering 0 to 360 degrees in the horizontal (longitude) direction  (0.32846715 degrees/value)
#   512 values covering -90 to 90 degrees in the vertical (latitude) direction  (0.3515625 degrees/value)
#   Values range from 0 (little or no probability of visible aurora) to 100 (high probability of visible aurora)

sub query {
   my ($lon,$lat,$data) = @_;
   open( DAT, '<', \$data );
   my $xf = int(($lon+180) / 0.32846715);
   my $yf = int(($lat+90) / 0.3515625);

   #print "$xf $yf\n";

   my $i=1;
   my $j=1;
   my $val = '';

   while(<DAT>){
      chomp;
      next if(m/^\s*#/);
      @a = split(/\s+/);
      for($j=1;$j < 1096;$j++){
         if($i == $yf && $j == $xf){
	    $val = $a[$j];
         }
      }
      $i++;
   }
   return $val
}

if ( defined $ARGV[0] and $ARGV[0] eq "config" ) {
    print "graph_title Aurora\n";
    print "graph_vlabel Likelyhood to see\n";
    print "graph_category aurora\n";

    print "uppsala.label Uppsala\n";
    print "abisko.label Abisko\n";
    print "canada.label Somewhere in Canada\n";
}else{

my $data = get 'http://services.swpc.noaa.gov/text/aurora-nowcast-map.txt';

#Uppsala
$lon = 17.63;
$lat = 59.85;

printf("uppsala.value %d\n",query($lon,$lat,$data));

#Canada
$lon = -100;
$lat = 57;

printf("canada.value %d\n",query($lon,$lat,$data));

$lon = 18.816667;
$lat = 68.35;

printf("abisko.value %d\n",query($lon,$lat,$data));
}
