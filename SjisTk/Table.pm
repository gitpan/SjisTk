package SjisTk::Table;
######################################################################
#
# SjisTk::Table - Tk Table widget for ShiftJIS script
#
# Copyright (c) 2009, 2010 INABA Hitoshi <ina@cpan.org>
#
######################################################################

use strict;
use 5.00503;
use vars qw($VERSION);

$VERSION = sprintf '%d.%02d', q$Revision: 0.01 $ =~ m/(\d+)/xmsg;

use base qw(Tk::Derived Tk::Table);
Tk::Widget->Construct('Table');

use Tk;

sub ClassInit {
    my($class, $mainwindow) = @_;

    # bind here ...

    $class->SUPER::ClassInit($mainwindow);
}

sub Populate {
    my($self, $args) = @_;

    $self->SUPER::Populate($args);

    return $self;
}

sub put {
    my($self, $row, $col, $argv) = @_;

    if (Tk::Exists($argv)) {
        return $self->SUPER::put($row, $col, $argv);
    }
    else {
        return $self->SUPER::put($row, $col, utf8($argv));
    }
}

sub get {
    my($self, $row, $col) = @_;

    my $get = $self->SUPER::get($row, $col);
    if (Tk::Exists($get)) {
        return $get;
    }
    else {
        return cp932($get);
    }
}

sub utf8 {
    if ($] >= 5.007) {
        require Encode;
        return Encode::decode('cp932', $_[0]);
    }
    return $_[0];
}

sub cp932 {
    if ($] >= 5.007) {
        require Encode;
        return Encode::encode('cp932', $_[0]);
    }
    return $_[0];
}

1;

__END__
