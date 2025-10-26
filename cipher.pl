use strict;
use warnings;

#my ($mode, $text) = @ARGV;
my ($mode, $text, $cipher) = @ARGV;
#die "Usage: $0 encode|decode 'text'\n" unless $mode && $text;
die "Usage: $0 encode|decode 'text' 'cipher_alphabet'\n" unless $mode && $text && $cipher;


my $plain  = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
#my $cipher = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';

if (length($cipher) < length($plain)) {
    warn "Character count must match plain; padding with 'a'\n";
    $cipher .= 'a' x (length($plain) - length($cipher));
} elsif (length($cipher) > length($plain)) {
    warn "Alphabet shorter than plain; truncating\n";
    $cipher = substr($cipher, 0, length($plain));
}

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
