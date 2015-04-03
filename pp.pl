#!/usr/bin/env perl
use strict;
use utf8;
use Text::CSV::Simple;
use DDP;
my $file = $ARGV[0]; #"a.csv";
my $parser = Text::CSV::Simple->new({binary => 1});
my @data = $parser->read_file($file);
my $header = shift @data;
my $map = [];
map {
	my $vals = $_;
	my %hash;
	@hash{ @$header } = @$vals;
	push @$map, \%hash;
} @data;
print p $map;

