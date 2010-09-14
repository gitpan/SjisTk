package SjisTk::DialogBox;
######################################################################
#
# SjisTk::DialogBox - Tk DialogBox widget for ShiftJIS script
#
# Copyright (c) 2009, 2010 INABA Hitoshi <ina@cpan.org>
#
######################################################################

use strict;
use 5.00503;
use Carp;
use vars qw($VERSION);

$VERSION = sprintf '%d.%02d', q$Revision: 0.01 $ =~ m/(\d+)/xmsg;

# DialogBox is similar to Dialog except that it allows any widget
# in the top frame. Widgets can be added with the add method. Currently
# there exists no way of deleting a widget once it has been added.

use base qw(Tk::Toplevel);
Tk::Widget->Construct('DialogBox');

sub Populate {
    my ($cw, $args) = @_;

    my $title = delete $args->{'-title'};
    $args->{'-title'} = utf8($title);
    $cw->SUPER::Populate($args);
    my $buttons = delete $args->{'-buttons'};
    $buttons = ['OK'] unless defined $buttons;
    $buttons = [ map { utf8($_) } @{$buttons} ];
    my $default_button = delete $args->{'-default_button'};
    $default_button = $buttons->[0] unless defined $default_button;
    $default_button = utf8($default_button);
    my $cancel_button = delete $args->{'-cancel_button'};
    if (!$cancel_button && @$buttons == 1) {
        $cancel_button = $buttons->[0];
    }
    $cancel_button = utf8($cancel_button);

    $cw->{'selected_button'} = '';
    $cw->transient($cw->Parent->toplevel);
    $cw->withdraw;
    if ($cancel_button) {
        $cw->protocol('WM_DELETE_WINDOW' => sub { $cw->{'cancel_button'}->invoke });
    }
    else {
        $cw->protocol('WM_DELETE_WINDOW' => sub { $cw->{'selected_button'} = undef });
    }

    # Make sure waitVariable exits if a waiting dialog is destroyed
    $cw->OnDestroy(sub { $cw->{'selected_button'} = $cw->{'selected_button'} });

    # create the two frames
    my $top = $cw->Component('Frame', 'top');
    $top->configure(-relief => 'raised', -bd => 1) unless $Tk::platform eq 'MSWin32';
    my $bot = $cw->Component('Frame', 'bottom');
    $bot->configure(-relief => 'raised', -bd => 1) unless $Tk::platform eq 'MSWin32';
    $bot->pack(qw/-side bottom -fill both -ipady 3 -ipadx 3/);
    $top->pack(qw/-side top -fill both -ipady 3 -ipadx 3 -expand 1/);

    # create a row of buttons in the bottom.
    my $bl;  # foreach my $var: perl > 5.003_08
    foreach $bl (@$buttons) {
        my @font = ();
        if ($] < 5.007) {
            # font family is MS Gothic
            @font = (-font => ["\x82\x6C\x82\x72\x81\x40\x83\x53\x83\x56\x83\x62\x83\x4E", 8, 'normal']);
        }
        my $b = $bot->Button(@font, -text => $bl, -command => sub { $cw->{'selected_button'} = "$bl" } );
        $b->bind('<Return>' => [ $b, 'Invoke']);
        $cw->Advertise("B_$bl" => $b);
        if ($Tk::platform eq 'MSWin32') {
            $b->configure(-width => 10, -pady => 0);
        }
        if ($bl eq $default_button) {
            my $db = $bot->Frame(-relief => 'sunken', -bd => 1);
            $b->raise($db);
            $b->pack(-in => $db, -padx => '2', -pady => '2');
            $db->pack(-side => 'left', -expand => 1, -padx => 1, -pady => 1);
            $cw->{'default_button'} = $b;
            $cw->bind('<Return>' => [ $b, 'Invoke']);
        }
        else {
            $b->pack(-side => 'left', -expand => 1,  -padx => 1, -pady => 1);
        }
        if (defined $cancel_button && $bl eq $cancel_button) {
            $cw->{'cancel_button'} = $b;
        }
    }
    if (defined $default_button && !$cw->{'default_button'}) {
#       warn "Default button `$default_button' does not exist.\n";
    }
    if (defined $cancel_button && !$cw->{'cancel_button'}) {
#       warn "Cancel button `$cancel_button' does not exist.\n";
    }
    $cw->ConfigSpecs(-command     => ['CALLBACK', undef, undef, undef ],
                     -foreground  => ['DESCENDANTS', 'foreground','Foreground', 'black'],
                     -background  => ['DESCENDANTS', 'background','Background',  undef],
                     -focus       => ['PASSIVE', undef, undef, undef],
                     -showcommand => ['CALLBACK', undef, undef, undef],
    );
    $cw->Delegates('Construct',$top);
}

sub add {
    my ($cw, $wnam, @args) = @_;

    my $w = $cw->Subwidget('top')->$wnam(@args);
    $cw->Advertise("\L$wnam" => $w);
    return $w;
}

sub Wait
{
    my $cw = shift;

    $cw->Callback(-showcommand => $cw);
    $cw->waitVariable(\$cw->{'selected_button'});
    $cw->grabRelease if Tk::Exists($cw);
    $cw->withdraw if Tk::Exists($cw);
    $cw->Callback(-command => $cw->{'selected_button'});
}

sub Show {

    croak 'DialogBox: "Show" method requires at least 1 argument' if scalar @_ < 1;
    my $cw = shift;
    my ($grab) = @_;
    my $old_focus = $cw->focusSave;
    my $old_grab = $cw->grabSave;

    shift if defined $grab && length $grab && ($grab =~ /global/);
    $cw->Popup(@_);

    Tk::catch {
        if (defined $grab && length $grab && ($grab =~ /global/)) {
            $cw->grabGlobal;
        }
        else {
            $cw->grab;
        }
    };
    if (my $focusw = $cw->cget(-focus)) {
        $focusw->focus;
    }
    elsif (defined $cw->{'default_button'}) {
        $cw->{'default_button'}->focus;
    }
    else {
        $cw->focus;
    }
    $cw->Wait;
    &$old_focus;
    &$old_grab;
    return cp932($cw->{'selected_button'});
}

sub Exit
{
    my $cw = shift;

    #kill the dialogbox, by faking a 'DONE'
    $cw->{'selected_button'} = $cw->{'default_button'}->cget(-text);
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
