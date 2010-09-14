package SjisTk::Dialog;
######################################################################
#
# SjisTk::Dialog - Tk Dialog widget for ShiftJIS script
#
# Copyright (c) 2009, 2010 INABA Hitoshi <ina@cpan.org>
#
######################################################################

use strict;
use 5.00503;
use Carp;
use vars qw($VERSION);

$VERSION = sprintf '%d.%02d', q$Revision: 0.01 $ =~ m/(\d+)/xmsg;

# Dialog - a translation of `tk_dialog' from Tcl/Tk to TkPerl (based on
# John Stoffel's idea).
#
# Stephen O. Lidie, Lehigh University Computing Center.  94/12/27
# lusol@Lehigh.EDU

# Documentation after __END__

use base qw(Tk::DialogBox);
Tk::Widget->Construct('Dialog');

sub Populate {

    # Dialog object constructor.  Uses `new' method from base class
    # to create object container then creates the dialog toplevel.

    my($cw, $args) = @_;

    my $text = delete $args->{'-text'};
    $args->{'-text'} = utf8($text);
    $cw->SUPER::Populate($args);

    my($w_bitmap, $w_but, $pad1, $pad2);

    # Create the Toplevel window and divide it into top and bottom parts.

    my(@pl) = (-side => 'top', -fill => 'both');

    ($pad1, $pad2) = ([-padx => '3m', -pady => '3m'], [-padx => '3m', -pady => '2m']);

    $cw->iconname('Dialog');

    my $w_top = $cw->Subwidget('top');

    # Fill the top part with the bitmap and message.

    @pl = (-side => 'left');

    $w_bitmap = $w_top->Label(Name => 'bitmap');
    $w_bitmap->pack(@pl, @$pad1);

    my $w_msg = $w_top->Label( -wraplength => '3i', -justify => 'left' );

    $w_msg->pack(-side => 'right', -expand => 1, -fill => 'both', @$pad1);

    $cw->Advertise(message => $w_msg);
    $cw->Advertise(bitmap  => $w_bitmap );

    $cw->ConfigSpecs(
        -image      => ['bitmap', undef, undef, undef],
        -bitmap     => ['bitmap', undef, undef, undef],
        # font family is MS Gothic
        -font       => ['message', 'font', 'Font', "\x82\x6C\x82\x72\x81\x40\x83\x53\x83\x56\x83\x62\x83\x4E 8 normal"],
        DEFAULT     => ['message', undef, undef, undef]
    );
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
