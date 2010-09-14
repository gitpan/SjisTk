package SjisTk::Button;
######################################################################
#
# SjisTk::Button - Tk Button widget for ShiftJIS script
#
# Copyright (c) 2009, 2010 INABA Hitoshi <ina@cpan.org>
#
######################################################################

use strict;
use 5.00503;
use vars qw($VERSION);

$VERSION = sprintf '%d.%02d', q$Revision: 0.01 $ =~ m/(\d+)/xmsg;

use base qw(Tk::Derived Tk::Button);
Tk::Widget->Construct('Button');

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

sub configure {
    my($self, @argv) = @_;

    if (@argv == 0) {
        my @config = $self->SUPER::configure();
        my @config_cp932 = ();
        for my $config (@config) {
            if ($config->[0] eq '-text') {
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
        if ($argv[0] eq '-text') {
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

        if (defined $argv{'-textvariable'}) {
            my $text = utf8(${$argv{'-textvariable'}});
            ${$argv{'-textvariable'}} = $text;
        }
        elsif (defined $argv{'-text'}) {
            $argv{'-text'} = utf8($argv{'-text'});
        }

        $self->SUPER::configure(%argv);
    }
}

sub cget {
    my($self, $argv) = @_;

    if ($argv eq '-text') {
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
