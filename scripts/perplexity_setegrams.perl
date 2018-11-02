#!/usr/bin/env perl 

binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
binmode STDERR, ':utf8';
use utf8;
use open qw(:std :utf8);
#use Math::BigInt;
use Storable qw(store retrieve freeze thaw dclone);

no warnings 'utf8';

# Absolute path 
use Cwd 'abs_path';
use File::Basename;
my $abs_path = dirname(abs_path($0));
$abs_path =~ s/\/scripts$//;
my $ling1 = shift(@ARGV);
my $ling2 = shift(@ARGV);
utf8::decode($ling2);

#my $feat = shift(@ARGV);
my $model = $abs_path."/models/setegrams_"  . ${ling1} . "\.st";
print STDERR "--: $ling2\n";


my $arrayref = retrieve($model); 
my $setegram = $arrayref->[0];
my $hexagram = $arrayref->[1];
my $pentagram = $arrayref->[2];
my $tetragram = $arrayref->[3];
my $trigram =  $arrayref->[4];
my $bigram =  $arrayref->[5];
my $unigram =  $arrayref->[6];


$infi= 1/1000000;
$n=0;
$summa= 0;
while ($line = <STDIN>) {
   chomp $line;
  # if ($n<=$th){
    $n +=1 ;
    ($w1, $w2, $w3, $w4, $w5, $w6, $w7) = split(" ", $line);
    $bi = $w1 . " " . $w2;
    $tri =  $w1 . " " . $w2 .  " " . $w3;
    $te =  $w1 . " " . $w2 .  " " . $w3 .  " " . $w4  ;
    $pen =  $w1 . " " . $w2 .  " " . $w3 .  " " . $w4 .  " " . $w5  ;
    $hex =  $w1 . " " . $w2 .  " " . $w3 .  " " . $w4   .  " " . $w5 . " " . $w6  ;
    $set =  $w1 . " " . $w2 .  " " . $w3 .  " " . $w4   .  " " . $w5 . " " . $w6  . " " . $w7 ;
    
    $set_dec =   $setegram->{$set} if ($setegram->{$set});
    $hex_dec =   $hexagram->{$hex} if ($hexagram->{$hex});
    $pen_dec =   $pentagram->{$pen} if ($pentagram->{$pen});
    #print STDERR "$pen_dec: #$pentagram->{$pen}# : #$w1# - #$w2#\n";
    $te_dec =   ($tetragram->{$te}) if ($tetragram->{$te});
    $tri_dec =  ($trigram->{$tri}) if ($trigram->{$tri});
    $bi_dec =    ($bigram->{$bi}) if ($bigram->{$bi});
    $uni_dec =  ($unigram->{$w1}) if ($unigram->{$w1}) ;

   $lambda7=0.3;
   $lambda6=0.2;
   $lambda5=0.1;
   $lambda4=0.1;
   $lambda3=0.1;
   $lambda2=0.1;
   $lambda1=0.1;#

   $set_dec = 0 if (!$setegram->{$set});
   $hex_dec = 0 if (!$hexagram->{$hex});
   $pen_dec = 0 if (!$pentagram->{$pen});
   $te_dec = 0 if (!$tetragram->{$te});
   $tri_dec = 0 if (!$trigram->{$tri});
   $bi_dec = 0 if (!$bigram->{$bi});
   $uni_dec = 0 if (!$unigram->{$w1});

    $prob =  log2 ( ($set_dec * $lambda7) + ($hex_dec * $lambda6) + ($pen_dec * $lambda5) + ($te_dec * $lambda4) + ($tri_dec *  $lambda3) + ($bi_dec * $lambda2)  +  ($uni_dec * $lambda1) + $infi);
    $summa = ($prob + $summa);
}

$perplexity= 2**(-($summa/$n));
#$perplexity = 1 / (-$summa**(1/$n)) ;

print "$ling1 $ling2 $perplexity\n";


sub log2 {
        my $n = shift;
        return log($n)/log(2);
    }
