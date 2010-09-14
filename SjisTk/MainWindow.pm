package SjisTk::MainWindow;
######################################################################
#
# SjisTk::MainWindow - Tk::MainWindow for ShiftJIS script
#
# Copyright (c) 2009, 2010 INABA Hitoshi <ina@cpan.org>
#
######################################################################

use strict;
use 5.00503;
use vars qw($VERSION @ISA);

$VERSION = sprintf '%d.%02d', q$Revision: 0.01 $ =~ m/(\d+)/xmsg;

use Tk;
@ISA = qw(MainWindow);

sub new {
    my($class, @argv) = @_;
    return bless MainWindow->new(@argv), $class;
}

sub title {
    my($self, $argv) = @_;
    return $self->SUPER::title(utf8($argv));
}

sub getOpenFile {
    my($self, @argv) = @_;
    return cp932($self->SUPER::getOpenFile(@argv));
}

sub getSaveFile {
    my($self, @argv) = @_;
    return cp932($self->SUPER::getSaveFile(@argv));
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
