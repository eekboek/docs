#!/usr/bin/perl -w

# Read EekBoek help output, and create individual tt2 documents for
# each topic.
# Also creates indexes.

use strict;
use warnings;
use HTML::Entities;
use Encode;

open(my $ix,  ">", "ix.html"     );
open(my $det, ">", "details.html");
open(my $tt2, ">", "commands.tt2"      );
my $top;

#binmode( STDIN, ":encoding(utf-8)");

print {$ix} ("<head>\n",
	     "<link rel=\"stylesheet\" href=\"cheat.css\">\n",
	     "<head>\n",
	     "<body>\n");
print {$det} ("<head>\n",
	      "<link rel=\"stylesheet\" href=\"cheat.css\">\n",
	      "<head>\n",
	      "<body>\n");
print {$tt2} ("<li>\n",
	      "<object type=\"text/sitemap\">\n",
	      "<param name=\"Name\" value=\"Commando&rsquo;s\">\n",
	      "<param name=\"Local\" value=\"commands.html\">\n",
	      "</object>\n",
	      "<ul>\n");

mkdir("topics") unless -d "topics";
my $did = 0;
my $collect;
my $tpat;
while ( <> ) {
    chomp;
    $_ = decode( "utf-8", $_ );
    if ( /^eb\> help (\w+)/ ) {
	my $target = $1;
	print {$ix} ("<br>") if $did;
	print {$ix} ("<a target=\"details\" href=\"details.html#$target\"><span class=\"tg\">$target</span></a>\n");
	print {$tt2} ("[% PROCESS item title=\"$target\" link=\"topics/$target.html\" %]\n");
	if ( $collect ) {
	    $collect =~ s/\s+$//;
	    my $tag = $tpat ? "table" : "p";
	    print {$top} ("<$tag>", $collect, "</$tag>\n");
	    print {$det} ("<$tag>", $collect, "</$tag>\n");
	}
	print {$det} ("\n<hr/>\n") if $did;
	print {$det} ("<a name=\"$target\"><span class=\"h3\">$target</span></a>\n");
	undef $top;
	open( $top, ">", "topics/$target.html"      );
	print {$top} ("[% META type = \"text\" -%]\n",
		      "<strong>$target</strong>\n");
	$did++;
	$collect = "";
	$tpat = "";
	next;
    }

    if ( ! /\S/ ) {
	if ( $tpat ) {
	    print {$top} ("<table>\n", $collect, "</table>\n") if $collect;
	    print {$det} ("<table>\n", $collect, "</table>\n") if $collect;
	}
	else {
	    print {$top} ("<p>", $collect, "</p>\n") if $collect;
	    print {$det} ("<p>", $collect, "</p>\n") if $collect;
	}
	$collect = "";
	$tpat = "";
	next;
    }

    # Non-empty line.
    $_ = detab($_);
    unless ( $collect ) {	# first
	if ( /^( +)(\S.*?)(  +)/ ) {
	    $tpat = ( "." x length($1) ) . "(.{" . (length($2)+length($3)) . "})(.*)";
	    $tpat = qr($tpat);
	}
	elsif ( /^( +)/ ) {
	    $collect = "&nbsp;&nbsp;";
	}
    }
    if ( $tpat ) {
	$_ =~ $tpat;
	my ( $l, $t ) = ( $1, $2 );
	for ( $l, $t ) {
	    $_ = enhance($_||"");
	}
	if ( $l =~ /\S/ ) {
	    $collect .= "<tr><td valign=\"top\">&nbsp;&nbsp;" . $l . "&nbsp;</td><td valign=\"top\">";
	}
	else {
	    substr( $collect, length($collect) - 11, 11, " " );
	}
	$collect .= $t . "</td></tr>\n"
    }
    else {
	$collect .= "<br>&nbsp;&nbsp;" if index( $collect, "&nbsp;" ) == 0 && length($collect) > 12;
	$collect .= enhance($_) . " ";
    }
}

if ( $collect ) {
    if ( $tpat ) {
	print {$top} ("<table>\n", $collect, "</table>\n");
	print {$det} ("<table>\n", $collect, "</table>\n");
    }
    else {
	print {$top} ("<p>", $collect, "</p>\n");
	print {$det} ("<p>", $collect, "</p>\n");
    }
}

print {$det} ("\n<hr/>\n") if $did;
print {$ix} ("</body>\n");
print {$det} ("</body>\n");
print {$tt2} ("</ul>\n");

sub enhance {
    my ( $t ) = @_;
    $t =~ s/^\s+//;
    $t =~ s/\s+$//;
    $t = encode_entities($t);

    if ( $t =~ /(^...+   +)([^ ].*)/ ) {
	my ($l, $r) = ($1, $2);
	varfix($r);
	$r = (" " x varfix($l)) . $r;
	$t = $l.$r;
    }
    else {
	varfix($t);
    }

    $t =~ s;&lt\;(\w+)&gt\;;<i>$1</i>;g;
    $t =~ s;&quot\;help (\w+)&quot\;;<a href="$1.html">$1</a>;g;

    $t;
}

sub varfix {
    my $need = 0;
    my $new = "";
    while ( $_[0] =~ m;<([^>]+)>; ) {
	$new .= $` . "<i>$1</i>";
	$need += 2;
	$_[0] = $';
    }
    $_[0] = $new . $_[0];
    $need;
}

sub detab {
    my ( $line ) = @_;
    my (@l) = split (/\t/, $line);

    # Replace tabs with blanks, retaining layout

    $line = shift (@l);
    $line .= " " x (8-length($line)%8) . shift(@l) while $#l >= 0;

    $line;
}
