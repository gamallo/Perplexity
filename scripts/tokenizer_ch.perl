#!/usr/bin/env perl
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
binmode STDERR, ':utf8';
use utf8;
use open qw(:std :utf8);


while ($line = <STDIN>) {
    chomp $line;
    @line = split ("", $line);
    
    foreach $ch (@line) {
	if ($ch =~ /\s/) {
	    $ch = "\#"
	}
	print "$ch\n" if ($ch =~ /[\w\#]/);
    }
}
            

             
