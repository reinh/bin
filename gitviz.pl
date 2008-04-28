#!/usr/bin/perl

use Git;
use strict;
my $repo = Git->repository($ENV{"GIT_DIR"} || ".");

print "digraph {\n";
print "\trankdir=BT;\n";
my($fh, $fhc) = $repo->command_output_pipe("log", "--pretty=format:<%h><%p>");
while (defined(my $line = <$fh>)) {
        my($this, $parents) = ($line =~ /^<(.*?)><(.*?)>/);
        foreach my $parent (split(/\s+/, $parents)) {
                print "\t\"$parent\" -> \"$this\";\n";
        }
}
print "};\n";
