package SjisTk::LabFrame;
######################################################################
#
# SjisTk::LabFrame - Tk Labeled frame widget for ShiftJIS script
#
# Copyright (c) 2009, 2010 INABA Hitoshi <ina@cpan.org>
#
######################################################################

use strict;
use 5.00503;
use Carp;
use vars qw($VERSION);

$VERSION = sprintf '%d.%02d', q$Revision: 0.01 $ =~ m/(\d+)/xmsg;

#
# Labeled frame. Derives from Tk::Frame, but intercepts the labeling
# part.

# use Tk;
use base qw(Tk::Frame);
Tk::Widget->Construct('LabFrame');

sub autoLabel { 0 }

sub ClassInit {
    my($class, $mainwindow) = @_;

    # bind here ...

    $class->SUPER::ClassInit($mainwindow);
}

sub Populate {
    my ($self, $argv) = @_;

    $self->{m_geoMgr} = '';

    my $border = $self->Component(
        Frame   => 'border',
        -relief => 'groove',
        -bd     => 2,
    );

    my $pad = $border->Frame;
    $self->Advertise(pad => $pad);

    my $frame = $border->Frame;
    $self->Advertise(frame => $frame);

    my $label = $self->Component(Label => 'label');

    $self->SUPER::Populate($argv);

    $self->Delegates(DEFAULT => $frame);
    $self->ConfigSpecs(
        -background    => [[qw/SELF ADVERTISED/], qw/background Background/],
        -borderwidth   => [$border, qw/borderWidth Border 2/],
        -font          => [$label, qw/font Font/],
        -foreground    => [$label, qw/foreground Foreground black/],
        -label         => [{-text => $label}, qw/label Label/],
        -labelside     => [qw/METHOD labelSide LabelSide acrosstop/],
        -labelvariable => [{-textvariable => $label}],
        -relief        => [$border, qw/relief Relief groove/],
        DEFAULT        => [$frame],
    );
    return $self;
}

use Tk::Submethods(
    form  => [qw/check forget grid info slaves/],
    grid  => [qw/bbox columnconfigure configure forget info location
                 propagate rowconfigure remove size slaves/],
    pack  => [qw/forget info propagate slaves/],
    place => [qw/forget info slaves/],
);

sub labelside {
    my ($self, $side) = @_;
    return $self->{Configure}{-labelside} unless $side;

    my $border = $self->Subwidget('border');
    my $pad    = $self->Subwidget('pad');
    my $frame  = $self->Subwidget('frame');
    my $label  = $self->Subwidget('label');

    # packForget/formForget as appropriate
    for ($border, $label, $pad, $frame) {
        $_->formForget if $self->{m_geoMgr} eq 'form';
        $_->packForget if ($self->{m_geoMgr} eq 'pack' && $_->ismapped);
    }

    if ($side eq 'acrosstop') {
        my $y = $label->reqheight / 2;
        my $ph = $y - ($border->cget(-bd));
        $ph = 0 if $ph < 0;

        $label->form(qw/-top 0 -left 4 -padx 6 -pady 2/);
        $border->form(-top    => $y,   qw/-bottom -1 -left 0 -right -1 -padx 2 -pady 2/);
        $pad->form(   -bottom => $ph,  qw/-top 0 -left 0 -right -1/);
        $frame->form( -top    => $pad, qw/-bottom -1 -left 0 -right -1 -fill both/);
        $self->{m_geoMgr} = 'form';
    }
    else {
        $label->pack(-side => $side);
        $frame->pack(-expand => 1, -fill => 'both');
        $border->pack(-side => $side, -expand => 1, -fill => 'both');
        $self->{m_geoMgr} = 'pack';
    }
}

sub form {
    my $self = shift;
    $self = $self->Subwidget('frame') if (@_ && $_[0] =~ /^(?:slaves)$/);
    $self->SUPER::form(@_);
}

sub grid {
    my $self = shift;
    $self = $self->Subwidget('frame') if (@_ && $_[0] =~
        /^(?:bbox
            |columnconfigure
            |location
            |propagate
            |rowconfigure
            |size
            |slaves)
        $/x);
    $self->SUPER::grid(@_);
}

sub pack {
    my $self = shift;
    $self = $self->Subwidget('frame') if (@_ && $_[0] =~ /^(?:propagate|slaves)$/);
    $self->SUPER::pack(@_);
}

sub place {
    my $self = shift;
    $self = $self->Subwidget('frame') if (@_ && $_[0] =~ /^(?:slaves)$/);
    $self->SUPER::place(@_);
}

sub configure {
    my($self, @argv) = @_;

    if (@argv == 0) {
        my @config = $self->SUPER::configure();
        my @config_cp932 = ();
        for my $config (@config) {
            if ($config->[0] eq '-label') {
                my $text = $config->[4];
                push @config_cp932, [
                    $config->[0],
                    $config->[1],
                    $config->[2],
                    $config->[3],
                    cp932($text),
                ];
            }
            else {
                push @config_cp932, $config;
            }
        }
        return @config_cp932;
    }
    elsif (@argv == 1) {
        if ($argv[0] eq '-label') {
            if (wantarray) {
                my @config = $self->SUPER::configure($argv[0]);
                return @config[0..3], cp932($config[4]);
            }
            else {
                my $config = $self->SUPER::configure($argv[0]);
                return cp932($config);
            }
        }
        else {
            return $self->SUPER::configure($argv[0]);
        }
    }
    else {
        my %argv = (@argv % 2) ? (@argv, undef) : @argv;

        if (defined $argv{'-labelvariable'}) {
            my $text = utf8(${$argv{'-labelvariable'}});
            ${$argv{'-labelvariable'}} = $text;
        }
        elsif (defined $argv{'-label'}) {
            $argv{'-label'} = utf8($argv{'-label'});
        }

        $self->SUPER::configure(%argv);
    }
}

sub cget {
    my($self, $argv) = @_;

    if ($argv eq '-label') {
        return cp932($self->SUPER::cget($argv));
    }
    else {
        return       $self->SUPER::cget($argv);
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
