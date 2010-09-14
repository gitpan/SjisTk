package SjisTk::Text;
######################################################################
#
# SjisTk::Text - Tk Text widget for ShiftJIS script
#
# Copyright (c) 2009, 2010 INABA Hitoshi <ina@cpan.org>
#
######################################################################

use strict;
use 5.00503;
use vars qw($VERSION);

$VERSION = sprintf '%d.%02d', q$Revision: 0.01 $ =~ m/(\d+)/xmsg;

use base qw(Tk::Derived Tk::Text);
Tk::Widget->Construct('Text');

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

    my @utf8_argv = ();
    while (@argv > 0) {
        push @utf8_argv, utf8(shift @argv);
        if (@argv > 0) {
            push @utf8_argv, shift @argv;
        }
    }
    $self->SUPER::insert($index, @utf8_argv);
}

sub get {
    my($self, @index) = @_;

    return cp932($self->SUPER::get(@index));
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
