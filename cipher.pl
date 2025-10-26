use strict;
use warnings;

my ($mode, $text) = @ARGV;
die "Usage: $0 encode|decode 'text'\n" unless $mode && $text;

my $plain  = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
my $cipher = 'ZYXWVUTSRQPONMLKJIHGFEDCBAzyxwvutsrqponmlkjihgfedcba';

my %encode_map;
my %decode_map;

for my $i (0 .. length($plain)-1) {
    my $p = substr($plain, $i, 1);
    my $c = substr($cipher, $i, 1);
    $encode_map{$p} = $c;
    $decode_map{$c} = $p;
}

my $result = join '', map {
    $mode eq 'encode' ? ($encode_map{$_} // $_) : ($decode_map{$_} // $_)
} split //, $text;

print "$result\n";
