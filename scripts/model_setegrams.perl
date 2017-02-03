#!/usr/bin/env perl

binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
binmode STDERR, ':utf8';
use utf8;
use open qw(:std :utf8);
use Storable qw(store retrieve freeze thaw dclone);

# Absolute path 
use Cwd 'abs_path';
use File::Basename;
my $abs_path = dirname(abs_path($0));
$abs_path =~ s/\/scripts$//;
my $ling = shift(@ARGV);
#my $feat = shift(@ARGV);
my $output = $abs_path."/models/setegrams_"  . $ling . "\.st";
#print STDERR "PATH: $abs_path";


$n=1;
while ($line = <STDIN>) {
    ($w1, $w2, $w3, $w4, $w5, $w6, $w7) = split(" ", $line);
    $bi = $w1 . " " . $w2;
    $tri =  $w1 . " " . $w2 .  " " . $w3;
    $te =  $w1 . " " . $w2 .  " " . $w3 .  " " . $w4  ;
    $pen =  $w1 . " " . $w2 .  " " . $w3 .  " " . $w4   .  " " . $w5  ;
    $hex =  $w1 . " " . $w2 .  " " . $w3 .  " " . $w4   .  " " . $w5 . " " . $w6  ;
    $set =  $w1 . " " . $w2 .  " " . $w3 .  " " . $w4   .  " " . $w5 . " " . $w6  . " " . $w7 ;
    $set{$set}++;
    $hex{$hex}++;
    $pen{$pen}++;
    $te{$te}++;
    $tr{$tri}++;
    $bi{$bi}++;
    $uni{$w1}++;

    $n++;
}

foreach $setegram (sort keys %set) {
    if ($set{$setegram} > 0) {
	#print >> sys.stderr, freq
       # if 
        ($w1, $w2, $w3, $w4, $w5, $w6, $w7) = split (" ", $setegram);
        $bigram = $w1 . " " . $w2;
        $trigram =  $w1 . " " . $w2 .  " " . $w3;
        $tetragram =  $w1 . " " . $w2 .  " " . $w3 .  " " . $w4  ;
        $pentagram =  $w1 . " " . $w2 .  " " . $w3 .  " " . $w4 .  " " . $w5  ;
        $hexagram =  $w1 . " " . $w2 .  " " . $w3 .  " " . $w4 .  " " . $w5 .  " " . $w6  ;
        $prob_setegram{$setegram} = ($set{$setegram} / $hex{$hexagram}) if ($hex{$hexagram});
        $prob_hexagram{$hexagram} = ($hex{$hexagram} / $pen{$pentagram}) if ($pen{$pentagram});
        $prob_pentagram{$pentagram} = ($pen{$pentagram} / $te{$tetragram}) if ($te{$tetragram});
        $prob_tetragram{$tetragram} = ($te{$tetragram} / $tr{$trigram}) if ($tr{$trigram});
        $prob_trigram{$trigram} = ($tr{$trigram} / $bi{$bigram}) if ($bi{$bigram});
        $prob_bigram{$bigram} = ($bi{$bigram} / $uni{$w1}) if ($uni{$w1}); ##prob (wi|wi-1) prob (b|a)
        $prob_unigram = ($uni{$w7} / $n ) if ($n && $uni{$w7} ); ##prob (c)
	#print '%s %s_%s_%s_%s\t%.6f\t%.6f\t%.6f\t%.6f\t%.6f' % (w5, w1, w2, w3, w4, prob_pentagram, prob_tetragram, prob_trigram, prob_bigram, prob_unigram)
    }
}

store [\%prob_setegram, \%prob_hexagram, \%prob_pentagram, \%prob_tetragram, \%prob_trigram, \%prob_bigram, \%prob_unigram],  $output;
