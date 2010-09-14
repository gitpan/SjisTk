package SjisTk::Listbox;
######################################################################
#
# SjisTk::Listbox - Tk Listbox widget for ShiftJIS script
#
# Copyright (c) 2009, 2010 INABA Hitoshi <ina@cpan.org>
#
######################################################################

use strict;
use 5.00503;
use vars qw($VERSION);

$VERSION = sprintf '%d.%02d', q$Revision: 0.01 $ =~ m/(\d+)/xmsg;

use base qw(Tk::Derived Tk::Listbox);
Tk::Widget->Construct('Listbox');

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

sub insert {
    my($self, $index, @argv) = @_;

    $self->SUPER::insert($index, map { utf8($_) } @argv);
}

sub get {
    my($self, @argv) = @_;

    my @item = $self->SUPER::get(@argv);

    if (wantarray) {
        return map { cp932($_) } @item;
    }
    else {
        return       cp932($item[-1]);
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
