#!/usr/bin/env perl 
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
binmode STDERR, ':utf8';
use utf8;
use open qw(:std :utf8);

my $patron_url = qr/(news|http|https|ftp|ftps):\/\/[^\s\n]*/ ;
my $patron_referencia_o_hashtag = qr/(@|#)[^\s\n]*/ ;

my $Separador = qr/[\.\,\;\:\«\»\"\&\%\+\=\$\#\(\)\<\>\!\¡\?\¿\\\[\]\{\}\|\^\*\-\€\/\_\·\¬\~\º\ª]/ ;
while ($line = <STDIN>) {
    chomp $line;
    $line =~ s/[\'\ʹ\‟\’\‘]//g;
    $line =~ s/[0-9]+//g;
    #$line =~ tr/$accent/$noaccent/;
    $line =~ s/([^\.]) [A-ZÁÉÍÓÚÀÈÌÒÙÄËÏÖÜÂÊÎÔÛÑÇČŠŽ][^ ]+ /$1 /g; ##removing proper names 

    $line = lc $line;
   
   ##vogais com umlaut: ō, ö > œ ä >æ ,

  
   ##africadas / palatais: 
     $line =~ s/(ch|tx)/ĉ/g;
     $line =~ s/sh/š/g;
     $line =~ s/t[zsš]/š/g;
     $line =~ s/d[žz]/ž/g;

   ##aspiradas
    $line =~ s/zh/z/g;
    $line =~ s/kh/k/g;
    $line =~ s/gh/g/g;
       
   #nasais e laterais palatais (necessita muito mais estudo)
    $line =~ s/(ñ|gn|nh|њ)/nj/g;
    $line =~ s/(lh|Ł|ł)/lj/g;


    ##normalizing vowels:
    $line =~ y/ĀāĂăĄąâåæĒēĔĕĖėĘęĚěêẽėĨĩĪīĬĭĮįİıĲĳîŌōõŎŏŐőŒœôøŨũŪūŬŭŮůŰűŲųûůäëïöü/äääääääääëëëëëëëëëëëëëïïïïïïïïïïïïïöööööööööööüüüüüüüüüüüüüüäëïöü/;

    ##normalizing consonnes (frictives, affricates)
    #$line =~ y/ĆćĊċĈĉČčçĎďĐđĜĝĞğĠġĢģĤĥĦħĴĵǰĶķĸќĹĺĻļĽľĿŀŁłŃńŅņŇňŉñŊŋŔŕŖŗŘřŜŝŠšŚśŞşŢţŤťŦŧŴŵŶŷŸýŹźŻżŽžſṃḥṛṇṁřľťßðłńđ/ccccĉĉĉĉsddjjžžgggggghhhhjjjkkkkllllllllllnnnnnnnnnnrrrrrrššššssssttttttwwyyyyzzzzžžrmhrnmrltsdlnd/;   
   $line =~ y/ĆćĊċĈĉČčçĎďĐđĜĝĞğĠġĢģĤĥĦħĴĵǰĶķĸќĹĺĻļĽľĿŀŁłŃńŅņŇňŉñŊŋŔŕŖŗŘřŜŝŠšŚśŞşŢţŤťŦŧŴŵŶŷŸýŹźŻżŽžſṃḥṛṇṁřľťßðłń/ccccĉĉĉĉsddžžžžgggggghhžžžžžkkkkllllllllllnnnnnnnnnnrrrrrrššššssssttttttwwyyyyzzzzžžrmhrnmrltsdln/;

    ##latin to ascii
    # $line =~ y/ĀāĂăĄąâåæĒēĔĕĖėĘęĚěêẽėĨĩĪīĬĭĮįİıĲĳîŌōõŎŏŐőŒœôøŨũŪūŬŭŮůŰűŲųûůäëïöü/aaaaaaaaaeeeeeeeeeeeeeiiiiiiiiiiiiiooooooooooouuuuuuuuuuuuuuaeiou/;
 # $line =~ y/ĆćĈĉĊċČčçĎďĐđĜĝĞğĠġĢģĤĥĦħĴĵǰĶķĸĹĺĻļĽľĿŀŁłŃńŅņŇňŉñŊŋŔŕŖŗŘřŚśŜŝŞşŠšŢţŤťŦŧŴŵŶŷŸýŹźŻżŽžſṃḥṛṇṁřľťßðśłżńčćžđ/cccccccccddddgggggggghhhhjjjkkkllllllllllnnnnnnnnnnrrrrrrssssssssttttttwwyyyyzzzzzzrmhrnmrltsdslzncczd/;
    
    $line =~ y/áéíóúàèìòù/aeiouaeiou/; ##removing stress accents
 
    $line =~ s/$Separador/ /g;
    
    $line =~ s/ [ ]+/ /g;
    $line =~ s/$patron_url/ /g ;
    $line =~ s/$patron_referencia_o_hashtag/ /g ;
    $line =~ s/http(s)?/ /g;
    $line =~ s/n̂/n/g;
     $line =~ s/l̂/l/g;
    $line =~ s/(í|ḯ)/i/g; ##ultracorreçoes grego - cirilico
    $line =~ s/ṓ/o/g; ##grego
    $line =~ "s/[ჲჳჱჴβαբոաĳ№]//g"; #problems with previous transliteration
    #if ($line =~ /[ჴჲβαբոաĳჳ]/) {next}

    print "$line\n";
}

