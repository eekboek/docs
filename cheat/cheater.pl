#!/usr/bin/perl -w

use strict;
use warnings;
use HTML::Entities;
use Encode;

open(my $ix,  ">", "ix.html"     );
open(my $det, ">", "details.html");
#binmode( STDIN, ":encoding(utf-8)");

print {$ix} ("<head>\n",
	     "<link rel=\"stylesheet\" href=\"cheat.css\">\n",
	     "<head>\n",
	     "<body>\n");
print {$det} ("<head>\n",
	      "<link rel=\"stylesheet\" href=\"cheat.css\">\n",
	      "<head>\n",
	      "<body>\n");

my $did = 0;
while ( <> ) {
    chomp;
    $_ = decode( "utf-8", $_ );
    if ( /^eb\> help (\w+)/ ) {
	my $target = $1;
	print {$ix} ("<br>") if $did;
	print {$ix} ("<a target=\"details\" href=\"details.html#$target\"><span class=\"tg\">$target</span></a>\n");
	print {$det} ("</pre>\n<hr/>\n") if $did;
	print {$det} ("<a name=\"$target\"><span class=\"h3\">$target</span></a>\n<pre>");
	$did++;
	next;
    }

    $_ = encode_entities($_);

    if ( /(^...+   +)([^ ].*)/ ) {
	my ($l, $r) = ($1, $2);
	varfix($r);
	$r = (" " x varfix($l)) . $r;
	$_ = $l.$r;
    }
    else {
	varfix($_);
    }

    s;&lt\;(\w+)&gt\;;<var>$1</var>;g;
    s;&quot\;help (\w+)&quot\;;<a href="#$1">$1</a>;g;
    print {$det} encode("utf-8", $_), "\n";
}

print {$det} ("</pre>\n<hr/>\n") if $did;
print {$ix} ("</body>\n");
print {$det} ("</body>\n");

sub varfix {
    my $need = 0;
    my $new = "";
    while ( $_[0] =~ m;<([^>]+)>; ) {
	$new .= $` . "<var>$1</var>";
	$need += 2;
	$_[0] = $';
    }
    $_[0] = $new . $_[0];
    $need;
}
