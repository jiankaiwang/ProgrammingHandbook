# Object-Oriented Programming in Perl

<script type="text/javascript" src="../js/general.js"></script>

###Class definition
---

```Perl
# the .pm file used in perl as object designning file
#!/usr/bin/perl

package person;

sub new {
	my $class = shift;
	my $self = {
		_firstName => shift,
		_lastName => shift,
		_place => shift,
		_phone => shift,
	};
	bless($self,$class);
	return $self;
}

sub getData {
	my ($self, $getOption) = @_;
	if($getOption == 0) { return $self->{_firstName}; }
	elsif($getOption == 1) { return $self->{_lastName}; }
	elsif($getOption == 2) { return $self->{_place}; }
	elsif($getOption == 3) { return $self->{_phone}; }
}
1;
```

###Create objects
---

```
# the programming body in Perl
#!/usr/bin/perl

use strict;
use person;

my @totalPerson = ();
my @tmp = ();

open(fin,"input.txt") or die("Input file error.\n");
foreach my $line(<fin>) {
	chomp($line);
	@tmp = split("\t",$line);
	my $newPerson = new person(@tmp);
	push(@totalPerson,$newPerson);
}	
close(fin);

print "First\tLast\tPlace\tPhone\n";
foreach my $eachPerson (@totalPerson) {
	bless($eachPerson,"person");
	for (my $i = 0 ; $i < 4 ; $i++) {
		print $eachPerson -> getData($i);
		if($i <= 2) { print "\t"; }
		else { print "\n"; }
	}
}
```