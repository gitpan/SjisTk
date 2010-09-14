use Sjis 0.64;
use Tk;
@font = ('-font' => ['ＭＳ　Ｐゴシック', 12, 'normal']);

$mw = MainWindow->new;
$mw->Radiobutton(
    @font,
    '-text' => 'ソ',
    '-variable' => \$variable,
    '-value'    => '表',
    '-command' => sub {
        if ($] >= 5.007) {
            require Encode;
            my $cp932 = Encode::encode('cp932', $variable);
            print "値が $cp932 になりました。\n";
        }
        else{
            print "値が $variable になりました。\n";
        }
    },
)->pack;
$textvariable = '表';
$mw->Radiobutton(
    @font,
    '-textvariable' => \$textvariable,
    '-variable' => \$variable,
    '-value'    => '裏',
    '-command' => sub {
        if ($] >= 5.007) {
            require Encode;
            my $cp932 = Encode::encode('cp932', $variable);
            print "値が $cp932 になりました。\n";
        }
        else{
            print "値が $variable になりました。\n";
        }
    },
)->pack;
MainLoop;
